<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Venta;
use App\Models\Producto;
use App\Models\Cliente;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function getStats(Request $request)
    {
        $user = $request->user();
        if (!$user) {
            return response()->json(['message' => 'No autorizado'], 401);
        }

        $empresaId = $user->id_empresa;
        
        // Si el usuario no tiene empresa asignada, retornar error
        if (!$empresaId) {
            return response()->json([
                'success' => false,
                'message' => 'Usuario sin empresa asignada. Por favor contacte al administrador.',
                'stats' => [],
                'recentInvoices' => [],
                'sunat' => ['pendientes' => 0, 'ultima_conexion' => now()->format('Y-m-d H:i:s')]
            ], 200); // Cambiar a 200 para que el frontend lo maneje correctamente
        }

        $now = Carbon::now();
        $startOfMonth = $now->copy()->startOfMonth();
        $endOfMonth = $now->copy()->endOfMonth();
        
        $prevMonthStart = $now->copy()->subMonth()->startOfMonth();
        $prevMonthEnd = $now->copy()->subMonth()->endOfMonth();

        // 1. VENTAS DEL MES (Soles)
        $ventasMesActual = Venta::porEmpresa($empresaId)
            ->activas()
            ->whereBetween('fecha_emision', [$startOfMonth, $endOfMonth])
            ->where('tipo_moneda', 'PEN')
            ->sum('total');

        $ventasMesAnterior = Venta::porEmpresa($empresaId)
            ->activas()
            ->whereBetween('fecha_emision', [$prevMonthStart, $prevMonthEnd])
            ->where('tipo_moneda', 'PEN')
            ->sum('total');

        $cambioVentas = $this->calcularCambio($ventasMesActual, $ventasMesAnterior);

        // 2. FACTURAS / BOLETAS EMITIDAS (Mes actual)
        $docsMesActual = Venta::porEmpresa($empresaId)
            ->activas()
            ->whereBetween('fecha_emision', [$startOfMonth, $endOfMonth])
            ->count();

        $docsMesAnterior = Venta::porEmpresa($empresaId)
            ->activas()
            ->whereBetween('fecha_emision', [$prevMonthStart, $prevMonthEnd])
            ->count();
        
        $cambioDocs = $this->calcularCambio($docsMesActual, $docsMesAnterior);

        // 3. CLIENTES ACTIVOS
        $clientesTotal = Cliente::where('id_empresa', $empresaId)->count();
        $clientesMesAnterior = Cliente::where('id_empresa', $empresaId)
            ->where('created_at', '<', $startOfMonth)
            ->count();
        
        $cambioClientes = $this->calcularCambio($clientesTotal, $clientesMesAnterior);

        // 4. PRODUCTOS (Stock bajo o total)
        $productosTotal = Producto::where('id_empresa', $empresaId)->count();
        $productosBajoStock = Producto::where('id_empresa', $empresaId)
            ->where('cantidad', '<=', DB::raw('stock_minimo'))
            ->count();

        // 5. FACTURAS RECIENTES
        $recentInvoices = Venta::porEmpresa($empresaId)
            ->with('cliente')
            ->orderBy('fecha_emision', 'desc')
            ->orderBy('id_venta', 'desc')
            ->take(10)
            ->get()
            ->map(function ($venta) {
                return [
                    'id' => $venta->numero_completo,
                    'client' => $venta->cliente->datos ?? 'S/N',
                    'amount' => ($venta->tipo_moneda === 'PEN' ? 'S/ ' : '$ ') . number_format($venta->total, 2),
                    'date' => $venta->fecha_emision->format('Y-m-d'),
                    'status' => $this->formatStatus($venta->estado_sunat, $venta->estado),
                ];
            });

        // 6. ESTADO SUNAT
        $pendientesSunat = Venta::porEmpresa($empresaId)
            ->activas()
            ->whereIn('id_tido', [1, 2]) // Factura, Boleta
            ->where('estado_sunat', '0')
            ->count();

        return response()->json([
            'success' => true,
            'stats' => [
                [
                    'id' => 1,
                    'title' => "Ventas del Mes",
                    'value' => "S/ " . number_format($ventasMesActual, 2),
                    'change' => ($cambioVentas >= 0 ? '+' : '') . number_format($cambioVentas, 1) . "%",
                    'isPositive' => $cambioVentas >= 0,
                    'icon' => "DollarSign",
                    'bgColor' => "bg-green-500",
                ],
                [
                    'id' => 2,
                    'title' => "Documentos Emitidos",
                    'value' => (string)$docsMesActual,
                    'change' => ($cambioDocs >= 0 ? '+' : '') . number_format($cambioDocs, 1) . "%",
                    'isPositive' => $cambioDocs >= 0,
                    'icon' => "FileText",
                    'bgColor' => "bg-blue-600",
                ],
                [
                    'id' => 3,
                    'title' => "Clientes Totales",
                    'value' => (string)$clientesTotal,
                    'change' => ($cambioClientes >= 0 ? '+' : '') . number_format($cambioClientes, 1) . "%",
                    'isPositive' => $cambioClientes >= 0,
                    'icon' => "Users",
                    'bgColor' => "bg-orange-500",
                ],
                [
                    'id' => 4,
                    'title' => "Productos en Stock",
                    'value' => (string)$productosTotal,
                    'change' => $productosBajoStock > 0 ? "$productosBajoStock stock bajo" : "Stock normal",
                    'isPositive' => $productosBajoStock === 0,
                    'icon' => "Package",
                    'bgColor' => "bg-purple-500",
                ],
            ],
            'recentInvoices' => $recentInvoices,
            'sunat' => [
                'pendientes' => $pendientesSunat,
                'ultima_conexion' => now()->format('Y-m-d H:i:s'),
            ]
        ]);
    }

    private function calcularCambio($actual, $anterior)
    {
        if ($anterior == 0) {
            return $actual > 0 ? 100 : 0;
        }
        return (($actual - $anterior) / $anterior) * 100;
    }

    private function formatStatus($estadoSunat, $estadoGeneral)
    {
        if ($estadoGeneral == '2' || $estadoGeneral == 'A') {
            return "Anulado";
        }
        return $estadoSunat == '1' ? "Aceptado" : "Pendiente";
    }
}
