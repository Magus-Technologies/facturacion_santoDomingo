<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MovimientosStockController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        try {
            $user = $request->user();

            $query = DB::table('view_movimientos_stock_detalle')
                ->where('id_empresa', $user->id_empresa);

            // Filtros opcionales
            if ($request->filled('tipo_movimiento')) {
                $query->where('tipo_movimiento', $request->tipo_movimiento);
            }

            if ($request->filled('tipo_documento')) {
                $query->where('tipo_documento', $request->tipo_documento);
            }

            if ($request->filled('id_almacen')) {
                $query->where('id_almacen', $request->id_almacen);
            }

            if ($request->filled('fecha_desde')) {
                $query->whereDate('fecha_movimiento', '>=', $request->fecha_desde);
            }

            if ($request->filled('fecha_hasta')) {
                $query->whereDate('fecha_movimiento', '<=', $request->fecha_hasta);
            }

            if ($request->filled('search')) {
                $search = $request->search;
                $query->where(function ($q) use ($search) {
                    $q->where('producto_nombre', 'like', "%{$search}%")
                      ->orWhere('producto_codigo', 'like', "%{$search}%")
                      ->orWhere('documento_referencia', 'like', "%{$search}%");
                });
            }

            $movimientos = $query->orderBy('fecha_movimiento', 'desc')
                ->limit(500)
                ->get();

            return response()->json([
                'success' => true,
                'data' => $movimientos,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al cargar movimientos de stock',
            ], 500);
        }
    }
}
