<?php

namespace App\Http\Controllers;

use App\Models\DiaCompra;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Exception;

class CuentasPorPagarController extends Controller
{
    public function index(Request $request)
    {
        try {
            $user = Auth::user();
            $idEmpresa = $user->id_empresa;

            $query = DiaCompra::with(['compra.proveedor'])
                ->whereHas('compra', function ($q) use ($idEmpresa) {
                    $q->where('id_empresa', $idEmpresa)
                      ->where('estado', '1');
                });

            // Filtro por estado
            if ($request->filled('estado')) {
                $estado = $request->estado;
                if ($estado === '1') $query->pendientes();
                elseif ($estado === '0') $query->pagadas();
                elseif ($estado === 'V') $query->vencidas();
            }

            // Filtro por rango de fechas
            if ($request->filled('fecha_desde')) {
                $query->where('fecha', '>=', $request->fecha_desde);
            }
            if ($request->filled('fecha_hasta')) {
                $query->where('fecha', '<=', $request->fecha_hasta);
            }

            // Filtro por proveedor
            if ($request->filled('proveedor')) {
                $proveedor = $request->proveedor;
                $query->whereHas('compra.proveedor', function ($q) use ($proveedor) {
                    $q->where('razon_social', 'like', "%{$proveedor}%")
                      ->orWhere('ruc', 'like', "%{$proveedor}%");
                });
            }

            $cuotas = $query->orderBy('fecha', 'asc')->get();

            $data = $cuotas->map(function ($cuota) {
                $compra = $cuota->compra;
                return [
                    'dias_compra_id' => $cuota->dias_compra_id,
                    'id_compra' => $cuota->id_compra,
                    'documento' => $compra->serie . '-' . str_pad($compra->numero, 8, '0', STR_PAD_LEFT),
                    'proveedor' => $compra->proveedor->razon_social ?? 'N/A',
                    'proveedor_ruc' => $compra->proveedor->ruc ?? '',
                    'fecha_emision' => $compra->fecha_emision->format('Y-m-d'),
                    'fecha_vencimiento' => $cuota->fecha->format('Y-m-d'),
                    'monto' => number_format($cuota->monto, 2, '.', ''),
                    'estado' => $cuota->estado,
                    'fecha_pago' => $cuota->fecha_pago?->format('Y-m-d'),
                ];
            });

            // Resumen
            $baseQuery = fn() => DiaCompra::whereHas('compra', function ($q) use ($idEmpresa) {
                $q->where('id_empresa', $idEmpresa)->where('estado', '1');
            });

            $totalPendiente = $baseQuery()->pendientes()->sum('monto');
            $totalVencido = $baseQuery()->vencidas()->sum('monto');
            $proximasVencer = $baseQuery()->proximasVencer(7)->count();
            $totalPagadoMes = $baseQuery()->pagadas()
                ->whereMonth('fecha_pago', now()->month)
                ->whereYear('fecha_pago', now()->year)
                ->sum('monto');

            return response()->json([
                'success' => true,
                'data' => $data,
                'resumen' => [
                    'total_pendiente' => number_format($totalPendiente, 2, '.', ''),
                    'total_vencido' => number_format($totalVencido, 2, '.', ''),
                    'proximas_vencer' => $proximasVencer,
                    'total_pagado_mes' => number_format($totalPagadoMes, 2, '.', ''),
                ],
            ]);
        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener cuentas por pagar: ' . $e->getMessage()
            ], 500);
        }
    }

    public function pagar(Request $request, $id)
    {
        try {
            $request->validate([
                'fecha_pago' => 'required|date',
            ]);

            $user = Auth::user();
            $cuota = DiaCompra::whereHas('compra', function ($q) use ($user) {
                $q->where('id_empresa', $user->id_empresa);
            })->findOrFail($id);

            if ($cuota->estado === '0') {
                return response()->json([
                    'success' => false,
                    'message' => 'Esta cuota ya está pagada'
                ], 400);
            }

            $cuota->estado = '0';
            $cuota->fecha_pago = $request->fecha_pago;
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
