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

    /**
     * Obtener productos destacados (API pública)
     * GET /api/v1/public/productos-destacados
     */
    public function destacados()
    {
        try {
            $productos = Producto::where('estado', '1')
                ->where('es_destacado', '1')
                ->select('id_producto', 'nombre', 'precio', 'cantidad', 'imagen')
                ->limit(10)
                ->get()
                ->map(function ($producto) {
                    return [
                        'id' => $producto->id_producto,
                        'nombre' => $producto->nombre,
                        'precio' => (float) $producto->precio,
                        'stock' => (int) $producto->cantidad,
                        'imagen' => $producto->imagen ? asset('storage/' . $producto->imagen) : null,
                    ];
                });

            return response()->json([
                'success' => true,
                'data' => $productos,
                'total' => $productos->count(),
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener productos destacados: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Obtener productos mejor valorados (API pública)
     * GET /api/v1/public/productos-mejor-valorados
     */
    public function mejorValorados()
    {
        try {
            $productos = Producto::where('estado', '1')
                ->whereNotNull('valoracion')
                ->where('valoracion', '>', 0)
                ->select('id_producto', 'nombre', 'precio', 'cantidad', 'imagen', 'valoracion')
                ->orderByDesc('valoracion')
                ->limit(10)
                ->get()
                ->map(function ($producto) {
                    return [
                        'id' => $producto->id_producto,
                        'nombre' => $producto->nombre,
                        'precio' => (float) $producto->precio,
                        'stock' => (int) $producto->cantidad,
                        'imagen' => $producto->imagen ? asset('storage/' . $producto->imagen) : null,
                        'valoracion' => (float) $producto->valoracion,
                    ];
                });

            return response()->json([
                'success' => true,
                'data' => $productos,
                'total' => $productos->count(),
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener productos mejor valorados: ' . $e->getMessage()
            ], 500);
        }
    }
}
