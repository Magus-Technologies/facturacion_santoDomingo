<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Producto;
use Illuminate\Http\Request;

class ShopProductosController extends Controller
{
    /**
     * GET /api/v1/public/shop-productos
     * Endpoint para shop-list-prod.php
     */
    public function index(Request $request)
    {
        try {
            $query = Producto::where('estado', '1');

            // Búsqueda por nombre o código
            if ($request->has('search') && !empty($request->search)) {
                $search = $request->search;
                $query->where(function ($q) use ($search) {
                    $q->where('nombre', 'like', "%{$search}%")
                        ->orWhere('prod_cod', 'like', "%{$search}%");
                });
            }

            // Filtro por categoría
            if ($request->filled('categoria')) {
                $query->where('categoria_id', $request->categoria);
            }

            // Filtro por marca
            if ($request->filled('marca')) {
                $query->where('marca_id', $request->marca);
            }

            // Filtro por rango de precio
            if ($request->has('min_precio')) {
                $query->where('precio', '>=', $request->min_precio);
            }
            if ($request->has('max_precio')) {
                $query->where('precio', '<=', $request->max_precio);
            }

            // Ordenamiento
            if ($request->has('sort')) {
                if ($request->sort === 'asc') {
                    $query->orderBy('precio', 'asc');
                } elseif ($request->sort === 'desc') {
                    $query->orderBy('precio', 'desc');
                }
            }

            // Paginación
            $perPage = $request->input('per_page', 12);
            $productos = $query->paginate($perPage);

            // Mapear datos al formato esperado por shop-list-prod.php
            $data = $productos->map(function ($prod) {
                return [
                    'prod_id' => $prod->id_producto,
                    'nombre' => $prod->nombre,
                    'precio' => (float) $prod->precio,
                    'stock' => (int) $prod->cantidad,
                    'imagen1' => $prod->imagen ?? null,
                    'content1' => $prod->descripcion ?? '',
                    'content2' => '',
                    'content3' => '',
                    'is_ofert' => false,
                ];
            });

            return response()->json([
                'success' => true,
                'data' => $data,
                'pagination' => [
                    'total' => $productos->total(),
                    'per_page' => $productos->perPage(),
                    'current_page' => $productos->currentPage(),
                    'last_page' => $productos->lastPage(),
                ]
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error: ' . $e->getMessage()
            ], 500);
        }
    }
}
