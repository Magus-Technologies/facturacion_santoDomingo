<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Producto;
use Illuminate\Http\Request;

class ProductoPublicoController extends Controller
{
    /**
     * Obtener lista de productos activos (API pública)
     */
    public function index(Request $request)
    {
        try {
            $query = Producto::where('estado', '1')
                ->select('id_producto', 'codigo', 'nombre', 'descripcion', 'precio', 'precio_mayor', 'precio_menor', 'cantidad', 'imagen', 'categoria_id');

            // Filtro por categoría si se proporciona
            if ($request->has('categoria_id')) {
                $query->where('categoria_id', $request->categoria_id);
            }

            // Búsqueda por nombre o código
            if ($request->has('search')) {
                $search = $request->search;
                $query->where(function ($q) use ($search) {
                    $q->where('nombre', 'like', "%{$search}%")
                        ->orWhere('codigo', 'like', "%{$search}%");
                });
            }

            // Paginación
            $perPage = $request->get('per_page', 50);
            $productos = $query->paginate($perPage);

            return response()->json([
                'success' => true,
                'data' => $productos->items(),
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
                'message' => 'Error al obtener productos: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Obtener un producto específico (API pública)
     */
    public function show($id)
    {
        try {
            $producto = Producto::where('estado', '1')
                ->where('id_producto', $id)
                ->select('id_producto', 'codigo', 'nombre', 'descripcion', 'precio', 'precio_mayor', 'precio_menor', 'cantidad', 'imagen', 'categoria_id', 'costo', 'stock_minimo', 'stock_maximo')
                ->first();

            if (!$producto) {
                return response()->json([
                    'success' => false,
                    'message' => 'Producto no encontrado'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $producto
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener producto: ' . $e->getMessage()
            ], 500);
        }
    }
}
