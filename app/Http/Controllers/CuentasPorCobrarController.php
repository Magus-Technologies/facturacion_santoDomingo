<?php

namespace App\Http\Controllers;

use App\Models\DiaVenta;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Exception;

class CuentasPorCobrarController extends Controller
{
    public function index(Request $request)
    {
        try {
            $user = Auth::user();
            $idEmpresa = $user->id_empresa;

            $query = DiaVenta::with(['venta.cliente'])
                ->whereHas('venta', function ($q) use ($idEmpresa) {
                    $q->where('id_empresa', $idEmpresa)
                      ->where('estado', '1');
                });

            // Filtro por estado
            if ($request->filled('estado')) {
                $estado = $request->estado;
                if ($estado === 'P') $query->pendientes();
                elseif ($estado === 'C') $query->canceladas();
                elseif ($estado === 'V') $query->vencidas();
            }

            // Filtro por rango de fechas
            if ($request->filled('fecha_desde')) {
                $query->where('fecha_vencimiento', '>=', $request->fecha_desde);
            }
            if ($request->filled('fecha_hasta')) {
                $query->where('fecha_vencimiento', '<=', $request->fecha_hasta);
            }

            // Filtro por cliente
            if ($request->filled('cliente')) {
                $cliente = $request->cliente;
                $query->whereHas('venta.cliente', function ($q) use ($cliente) {
                    $q->where('datos', 'like', "%{$cliente}%")
                      ->orWhere('documento', 'like', "%{$cliente}%");
                });
            }

            $cuotas = $query->orderBy('fecha_vencimiento', 'asc')->get();

            $data = $cuotas->map(function ($cuota) {
                $venta = $cuota->venta;
                return [
                    'id_dia_venta' => $cuota->id_dia_venta,
                    'id_venta' => $cuota->id_venta,
                    'documento' => $venta->serie . '-' . str_pad($venta->numero, 8, '0', STR_PAD_LEFT),
                    'cliente' => $venta->cliente->datos ?? 'N/A',
                    'cliente_documento' => $venta->cliente->documento ?? '',
                    'fecha_emision' => $venta->fecha_emision->format('Y-m-d'),
                    'numero_cuota' => $cuota->numero_cuota,
                    'fecha_vencimiento' => $cuota->fecha_vencimiento->format('Y-m-d'),
                    'monto_cuota' => number_format($cuota->monto_cuota, 2, '.', ''),
                    'monto_pagado' => number_format($cuota->monto_pagado, 2, '.', ''),
                    'saldo' => number_format($cuota->saldo, 2, '.', ''),
                    'estado' => $cuota->estado,
                    'fecha_pago' => $cuota->fecha_pago?->format('Y-m-d'),
                    'observaciones' => $cuota->observaciones,
                ];
            });

            // Resumen
            $baseQuery = fn() => DiaVenta::whereHas('venta', function ($q) use ($idEmpresa) {
                $q->where('id_empresa', $idEmpresa)->where('estado', '1');
            });

            $totalPendiente = $baseQuery()->pendientes()->sum('saldo');
            $totalVencido = $baseQuery()->vencidas()->sum('saldo');
            $proximasVencer = $baseQuery()->proximasVencer(7)->count();
            $totalCobradoMes = $baseQuery()->canceladas()
                ->whereMonth('fecha_pago', now()->month)
                ->whereYear('fecha_pago', now()->year)
                ->sum('monto_pagado');

            return response()->json([
                'success' => true,
                'data' => $data,
                'resumen' => [
                    'total_pendiente' => number_format($totalPendiente, 2, '.', ''),
                    'total_vencido' => number_format($totalVencido, 2, '.', ''),
                    'proximas_vencer' => $proximasVencer,
                    'total_cobrado_mes' => number_format($totalCobradoMes, 2, '.', ''),
                ],
            ]);
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener cuentas por cobrar: ' . $e->getMessage()
            ], 500);
        }
    }

    public function pagar(Request $request, $id)
    {
        try {
            $request->validate([
                'monto_pagado' => 'required|numeric|min:0.01',
                'fecha_pago' => 'required|date',
                'observaciones' => 'nullable|string|max:500',
            ]);

            $user = Auth::user();
            $cuota = DiaVenta::whereHas('venta', function ($q) use ($user) {
                $q->where('id_empresa', $user->id_empresa);
            })->findOrFail($id);

            if ($cuota->estado === 'C') {
                return response()->json([
                    'success' => false,
                    'message' => 'Esta cuota ya está cancelada'
                ], 400);
            }

            $montoPago = $request->monto_pagado;
            $nuevoMontoPagado = $cuota->monto_pagado + $montoPago;
            $nuevoSaldo = $cuota->monto_cuota - $nuevoMontoPagado;

            $cuota->monto_pagado = $nuevoMontoPagado;
            $cuota->saldo = max(0, $nuevoSaldo);
            $cuota->fecha_pago = $request->fecha_pago;
            $cuota->observaciones = $request->observaciones ?? $cuota->observaciones;

            if ($nuevoSaldo <= 0) {
                $cuota->estado = 'C';
            }

            $cuota->save();

            return response()->json([
                'success' => true,
                'message' => 'Pago registrado exitosamente',
            ]);
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al registrar pago: ' . $e->getMessage()
            ], 500);
        }
    }
}
