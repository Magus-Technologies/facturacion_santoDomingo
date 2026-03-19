<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Oferta;
use App\Models\Producto;
use App\Models\ProductoVenta;
use Illuminate\Support\Facades\DB;

class EcommercePublicoController extends Controller
{
    /**
     * GET /api/public/nuevos-ingresos
     * Retorna los 10 productos más recientes por fecha de creación.
     */
    public function nuevosIngresos()
    {
        try {
            $productos = Producto::activo()
                ->select('id_producto', 'codigo', 'nombre', 'precio', 'cantidad', 'imagen', 'categoria_id', 'created_at')
                ->with(['categoria:id,nombre', 'marca:cod_marca,nombre'])
                ->orderByDesc('created_at')
                ->limit(10)
                ->get()
                ->map(fn($p) => $this->formatProducto($p));

            return response()->json(['success' => true, 'data' => $productos]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }

    /**
     * GET /api/public/mas-vendidos
     * Retorna los 10 productos con mayor cantidad vendida (suma de productos_ventas.cantidad).
     */
    public function masVendidos()
    {
        try {
            $ids = ProductoVenta::select('id_producto', DB::raw('SUM(cantidad) as total_vendido'))
                ->groupBy('id_producto')
                ->orderByDesc('total_vendido')
                ->limit(10)
                ->pluck('id_producto');

            $productos = Producto::activo()
                ->whereIn('id_producto', $ids)
                ->select('id_producto', 'codigo', 'nombre', 'precio', 'cantidad', 'imagen', 'categoria_id', 'created_at')
                ->with(['categoria:id,nombre', 'marca:cod_marca,nombre'])
                ->get()
                ->sortBy(fn($p) => array_search($p->id_producto, $ids->toArray()))
                ->values()
                ->map(fn($p) => $this->formatProducto($p));

            return response()->json(['success' => true, 'data' => $productos]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }

    /**
     * GET /api/public/ofertas-especiales
     * Retorna los productos con oferta vigente, incluyendo fecha_inicio y fecha_fin.
     */
    public function ofertasEspeciales()
    {
        try {
            $ofertas = Oferta::vigente()
                ->with([
                    'producto' => fn($q) => $q->activo()
                        ->select('id_producto', 'codigo', 'nombre', 'precio', 'cantidad', 'imagen', 'categoria_id'),
                    'producto.categoria:id,nombre',
                    'producto.marca:cod_marca,nombre',
                ])
                ->orderByDesc('fecha_inicio')
                ->get()
                ->filter(fn($o) => $o->producto !== null)
                ->map(fn($o) => [
                    'id_producto'   => $o->producto->id_producto,
                    'codigo'        => $o->producto->codigo,
                    'nombre'        => $o->producto->nombre,
                    'precio'        => (float) $o->producto->precio,
                    'precio_oferta' => (float) $o->precio_final,
                    'descuento'     => $o->tipo === 'porcentaje'
                        ? (float) $o->valor . '%'
                        : 'S/ ' . number_format($o->valor, 2),
                    'tipo_descuento' => $o->tipo,
                    'valor_descuento' => (float) $o->valor,
                    'fecha_inicio'  => $o->fecha_inicio?->format('Y-m-d H:i:s'),
                    'fecha_fin'     => $o->fecha_fin?->format('Y-m-d H:i:s'),
                    'stock'         => (int) $o->producto->cantidad,
                    'imagen'        => $o->producto->imagen ? asset('storage/' . $o->producto->imagen) : null,
                    'categoria'     => $o->producto->categoria?->nombre,
                ])
                ->values();

            return response()->json(['success' => true, 'data' => $ofertas]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }

    private function formatProducto(Producto $p): array
    {
        return [
            'id_producto'   => $p->id_producto,
            'codigo'        => $p->codigo,
            'nombre'        => $p->nombre,
            'precio'        => (float) $p->precio,
            'stock'         => (int) ($p->cantidad ?? 0),
            'imagen'        => $p->imagen ? asset('storage/' . $p->imagen) : null,
            'categoria'     => $p->categoria?->nombre,
            'fecha_ingreso' => $p->created_at?->format('Y-m-d'),
        ];
    }
}
