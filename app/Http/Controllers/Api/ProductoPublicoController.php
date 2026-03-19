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
     * Lógica: Top 10 productos con más ventas en últimos 30 días
     * GET /api/v1/public/productos-destacados
     */
    public function destacados()
    {
        try {
            // Lógica: Productos más vendidos en últimos 30 días
            $productos = Producto::where('estado', '1')
                ->select('id_producto', 'nombre', 'precio', 'cantidad', 'imagen')
                ->withCount(['ventasDetalles' => function ($query) {
                    $query->whereDate('created_at', '>=', now()->subDays(30));
                }])
                ->orderByDesc('ventas_detalles_count')
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
     * Obtener productos destacados por utilidad/ganancia (API pública)
     * Lógica: Top 10 productos con mayor utilidad total acumulada
     * Utilidad = SUM((precio_unitario_venta - costo_producto) * cantidad_vendida)
     * GET /api/public/productos-mas-rentables
     */
    public function masRentables()
    {
        try {
            $productos = Producto::where('productos.estado', '1')
                ->join('productos_ventas as pv', 'productos.id_producto', '=', 'pv.id_producto')
                ->join('ventas as v', 'pv.id_venta', '=', 'v.id_venta')
                ->where('v.estado', '!=', 'anulado')
                ->select(
                    'productos.id_producto',
                    'productos.nombre',
                    'productos.precio',
                    'productos.cantidad',
                    'productos.imagen'
                )
                ->selectRaw('SUM((pv.precio_unitario - productos.costo) * pv.cantidad) as utilidad_total')
                ->groupBy(
                    'productos.id_producto',
                    'productos.nombre',
                    'productos.precio',
                    'productos.cantidad',
                    'productos.imagen'
                )
                ->orderByDesc('utilidad_total')
                ->limit(10)
                ->get()
                ->map(function ($producto) {
                    return [
                        'id'             => $producto->id_producto,
                        'nombre'         => $producto->nombre,
                        'precio'         => (float) $producto->precio,
                        'stock'          => (int) $producto->cantidad,
                        'imagen'         => $producto->imagen ? asset('storage/' . $producto->imagen) : null,
                        'utilidad_total' => round((float) $producto->utilidad_total, 2),
                    ];
                });

            return response()->json([
                'success' => true,
                'data'    => $productos,
                'total'   => $productos->count(),
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener productos más rentables: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Obtener productos mejor valorados del mes actual (API pública)
     * Lógica: Top 10 más vendidos del mes. Si no hay datos, retrocede mes a mes.
     * GET /api/public/productos-mejor-valorados-mes
     */
    public function mejorValoradosMes()
    {
        try {
            $resultado  = collect();
            $fecha      = now();
            $periodoUsado = null;

            // Intenta hasta 12 meses hacia atrás
            for ($i = 0; $i < 12; $i++) {
                $mes  = $fecha->month;
                $anio = $fecha->year;

                $resultado = Producto::where('productos.estado', '1')
                    ->join('productos_ventas as pv', 'productos.id_producto', '=', 'pv.id_producto')
                    ->join('ventas as v', 'pv.id_venta', '=', 'v.id_venta')
                    ->where('v.estado', '!=', 'anulado')
                    ->whereMonth('v.created_at', $mes)
                    ->whereYear('v.created_at', $anio)
                    ->select(
                        'productos.id_producto',
                        'productos.nombre',
                        'productos.precio',
                        'productos.cantidad',
                        'productos.imagen'
                    )
                    ->selectRaw('SUM(pv.cantidad) as total_vendido')
                    ->groupBy(
                        'productos.id_producto',
                        'productos.nombre',
                        'productos.precio',
                        'productos.cantidad',
                        'productos.imagen'
                    )
                    ->orderByDesc('total_vendido')
                    ->limit(10)
                    ->get();

                if ($resultado->isNotEmpty()) {
                    $periodoUsado = $fecha->format('m/Y');
                    break;
                }

                $fecha = $fecha->subMonth();
            }

            $data = $resultado->map(function ($producto) {
                return [
                    'id'            => $producto->id_producto,
                    'nombre'        => $producto->nombre,
                    'precio'        => (float) $producto->precio,
                    'stock'         => (int) $producto->cantidad,
                    'imagen'        => $producto->imagen ? asset('storage/' . $producto->imagen) : null,
                    'total_vendido' => (int) $producto->total_vendido,
                ];
            });

            return response()->json([
                'success' => true,
                'data'    => $data,
                'total'   => $data->count(),
                'periodo' => $periodoUsado,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener productos mejor valorados del mes: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Obtener productos mejor valorados (API pública)
     * Lógica: Top 10 productos con mejor rating calculado
     * Rating = (suma de calificaciones / cantidad de calificaciones)
     * GET /api/v1/public/productos-mejor-valorados
     */
    public function mejorValorados()
    {
        try {
            // Lógica: Productos con mejor rating promedio
            $productos = Producto::where('estado', '1')
                ->select('id_producto', 'nombre', 'precio', 'cantidad', 'imagen')
                ->with(['resenas' => function ($query) {
                    $query->where('estado', '1');
                }])
                ->get()
                ->map(function ($producto) {
                    // Calcular rating promedio
                    $resenas = $producto->resenas;
                    $rating = 0;
                    if ($resenas->count() > 0) {
                        $rating = $resenas->avg('calificacion');
                    }
                    
                    return [
                        'id' => $producto->id_producto,
                        'nombre' => $producto->nombre,
                        'precio' => (float) $producto->precio,
                        'stock' => (int) $producto->cantidad,
                        'imagen' => $producto->imagen ? asset('storage/' . $producto->imagen) : null,
                        'valoracion' => round($rating, 1),
                        'cantidad_resenas' => $resenas->count(),
                    ];
                })
                ->filter(function ($producto) {
                    // Solo productos con al menos 1 reseña
                    return $producto['cantidad_resenas'] > 0;
                })
                ->sortByDesc('valoracion')
                ->take(10)
                ->values();

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
