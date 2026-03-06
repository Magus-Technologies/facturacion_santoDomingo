<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Venta;
use App\Models\MovimientoCaja;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UtilidadesController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();
        if (!$user) {
            return response()->json(['message' => 'No autorizado'], 401);
        }

        $empresaId = $user->id_empresa;
        $periodo   = $request->get('periodo', 'mes');

        [$desde, $hasta] = $this->rangoPeriodo($periodo, $request);

        // ── KPIs principales ──────────────────────────────────────────────
        $ingresos = Venta::porEmpresa($empresaId)
            ->activas()
            ->whereBetween('fecha_emision', [$desde, $hasta])
            ->sum('subtotal');

        // Costo = SUM(cantidad * costo_producto) desde productos_ventas JOIN productos
        $costo = DB::table('productos_ventas as pv')
            ->join('ventas as v', 'v.id_venta', '=', 'pv.id_venta')
            ->join('productos as p', 'p.id_producto', '=', 'pv.id_producto')
            ->where('v.id_empresa', $empresaId)
            ->where('v.estado', '!=', '2')
            ->whereBetween('v.fecha_emision', [$desde, $hasta])
            ->selectRaw('COALESCE(SUM(pv.cantidad * COALESCE(p.costo, 0)), 0) as total_costo')
            ->value('total_costo') ?? 0;

        $gastos = MovimientoCaja::where('id_empresa', $empresaId)
            ->where('tipo', 'egreso')
            ->whereBetween('created_at', [$desde, $hasta])
            ->sum('monto');

        $utilidad = $ingresos - $costo - $gastos;
        $margen   = $ingresos > 0 ? ($utilidad / $ingresos) * 100 : 0;

        // Período anterior para comparativas
        $diffDias   = $desde->diffInDays($hasta) + 1;
        $desdeAntes = $desde->copy()->subDays($diffDias);
        $hastaAntes = $desde->copy()->subDay();

        $ingresosAntes = Venta::porEmpresa($empresaId)->activas()
            ->whereBetween('fecha_emision', [$desdeAntes, $hastaAntes])
            ->sum('subtotal');

        $utilidadAntes = $ingresosAntes - (DB::table('productos_ventas as pv')
            ->join('ventas as v', 'v.id_venta', '=', 'pv.id_venta')
            ->join('productos as p', 'p.id_producto', '=', 'pv.id_producto')
            ->where('v.id_empresa', $empresaId)
            ->where('v.estado', '!=', '2')
            ->whereBetween('v.fecha_emision', [$desdeAntes, $hastaAntes])
            ->selectRaw('COALESCE(SUM(pv.cantidad * COALESCE(p.costo, 0)), 0) as tc')
            ->value('tc') ?? 0);

        // ── Rentabilidad por Producto ─────────────────────────────────────
        $rentabilidadProductos = DB::table('productos_ventas as pv')
            ->join('ventas as v', 'v.id_venta', '=', 'pv.id_venta')
            ->join('productos as p', 'p.id_producto', '=', 'pv.id_producto')
            ->leftJoin('categorias as c', 'c.id', '=', 'p.categoria_id')
            ->where('v.id_empresa', $empresaId)
            ->where('v.estado', '!=', '2')
            ->whereBetween('v.fecha_emision', [$desde, $hasta])
            ->groupBy('p.id_producto', 'p.nombre', 'p.costo', 'c.id', 'c.nombre')
            ->selectRaw('
                p.id_producto,
                p.nombre as producto,
                COALESCE(c.nombre, "Sin categoría") as categoria,
                COALESCE(p.costo, 0) as costo_unitario,
                AVG(pv.precio_unitario) as precio_promedio,
                SUM(pv.cantidad) as unidades,
                SUM(pv.subtotal) as ingreso_total,
                COALESCE(SUM(pv.cantidad * p.costo), 0) as costo_total
            ')
            ->orderByRaw('SUM(pv.subtotal) - COALESCE(SUM(pv.cantidad * p.costo), 0) DESC')
            ->limit(50)
            ->get()
            ->map(function ($row) use ($ingresos) {
                $utilidadTotal = $row->ingreso_total - $row->costo_total;
                $margenPct     = $row->ingreso_total > 0
                    ? ($utilidadTotal / $row->ingreso_total) * 100
                    : 0;
                return [
                    'producto'       => $row->producto,
                    'categoria'      => $row->categoria,
                    'costo_unitario' => round($row->costo_unitario, 2),
                    'precio_venta'   => round($row->precio_promedio, 2),
                    'unidades'       => (int) $row->unidades,
                    'ingreso_total'  => round($row->ingreso_total, 2),
                    'costo_total'    => round($row->costo_total, 2),
                    'utilidad_total' => round($utilidadTotal, 2),
                    'margen'         => round($margenPct, 1),
                    'porcentaje_ventas' => $ingresos > 0
                        ? round(($row->ingreso_total / $ingresos) * 100, 1)
                        : 0,
                ];
            });

        // ── Margen por Categoría ──────────────────────────────────────────
        $margenCategorias = DB::table('productos_ventas as pv')
            ->join('ventas as v', 'v.id_venta', '=', 'pv.id_venta')
            ->join('productos as p', 'p.id_producto', '=', 'pv.id_producto')
            ->leftJoin('categorias as c', 'c.id', '=', 'p.categoria_id')
            ->where('v.id_empresa', $empresaId)
            ->where('v.estado', '!=', '2')
            ->whereBetween('v.fecha_emision', [$desde, $hasta])
            ->groupBy('c.id', 'c.nombre')
            ->selectRaw('
                COALESCE(c.nombre, "Sin categoría") as categoria,
                SUM(pv.subtotal) as ingreso_total,
                COALESCE(SUM(pv.cantidad * COALESCE(p.costo, 0)), 0) as costo_total,
                COUNT(DISTINCT p.id_producto) as num_productos
            ')
            ->orderByRaw('SUM(pv.subtotal) DESC')
            ->get()
            ->map(function ($row) {
                $utilidadCat = $row->ingreso_total - $row->costo_total;
                $margenCat   = $row->ingreso_total > 0
                    ? ($utilidadCat / $row->ingreso_total) * 100
                    : 0;
                return [
                    'categoria'      => $row->categoria,
                    'ingreso_total'  => round($row->ingreso_total, 2),
                    'costo_total'    => round($row->costo_total, 2),
                    'utilidad_total' => round($utilidadCat, 2),
                    'margen'         => round($margenCat, 1),
                    'num_productos'  => (int) $row->num_productos,
                ];
            });

        // ── Margen por Vendedor ───────────────────────────────────────────
        $margenVendedores = DB::table('ventas as v')
            ->join('users as u', 'u.id', '=', 'v.id_usuario')
            ->leftJoin('productos_ventas as pv', 'pv.id_venta', '=', 'v.id_venta')
            ->leftJoin('productos as p', 'p.id_producto', '=', 'pv.id_producto')
            ->where('v.id_empresa', $empresaId)
            ->where('v.estado', '!=', '2')
            ->whereBetween('v.fecha_emision', [$desde, $hasta])
            ->groupBy('u.id', 'u.name')
            ->selectRaw('
                u.id,
                u.name as vendedor,
                SUM(v.subtotal) as ingresos,
                COALESCE(SUM(pv.cantidad * COALESCE(p.costo, 0)), 0) as costos,
                COUNT(DISTINCT v.id_venta) as num_ventas,
                SUM(v.descuento_global) as descuentos
            ')
            ->orderByRaw('SUM(v.subtotal) - COALESCE(SUM(pv.cantidad * COALESCE(p.costo, 0)), 0) DESC')
            ->get()
            ->map(function ($row) {
                $utilidadV = $row->ingresos - $row->costos;
                $margenV   = $row->ingresos > 0 ? ($utilidadV / $row->ingresos) * 100 : 0;
                $ticketProm = $row->num_ventas > 0 ? $row->ingresos / $row->num_ventas : 0;
                return [
                    'vendedor'    => $row->vendedor,
                    'ingresos'    => round($row->ingresos, 2),
                    'costos'      => round($row->costos, 2),
                    'descuentos'  => round($row->descuentos ?? 0, 2),
                    'utilidad'    => round($utilidadV, 2),
                    'margen'      => round($margenV, 1),
                    'num_ventas'  => (int) $row->num_ventas,
                    'ticket_prom' => round($ticketProm, 2),
                ];
            });

        // ── Utilidad en el Tiempo ─────────────────────────────────────────
        $agrupar = $diffDias <= 31 ? 'DATE(v.fecha_emision)' : 'DATE_FORMAT(v.fecha_emision, "%Y-%m")';
        $utilidadTiempo = DB::table('ventas as v')
            ->leftJoin('productos_ventas as pv', 'pv.id_venta', '=', 'v.id_venta')
            ->leftJoin('productos as p', 'p.id_producto', '=', 'pv.id_producto')
            ->where('v.id_empresa', $empresaId)
            ->where('v.estado', '!=', '2')
            ->whereBetween('v.fecha_emision', [$desde, $hasta])
            ->groupByRaw($agrupar)
            ->selectRaw("
                {$agrupar} as periodo,
                SUM(v.subtotal) as ingresos,
                COALESCE(SUM(pv.cantidad * COALESCE(p.costo, 0)), 0) as costos,
                COUNT(DISTINCT v.id_venta) as num_ventas
            ")
            ->orderByRaw($agrupar)
            ->get()
            ->map(function ($row) {
                $utilidadP = $row->ingresos - $row->costos;
                return [
                    'periodo'    => $row->periodo,
                    'ingresos'   => round($row->ingresos, 2),
                    'costos'     => round($row->costos, 2),
                    'utilidad'   => round($utilidadP, 2),
                    'num_ventas' => (int) $row->num_ventas,
                ];
            });

        // ── Gastos Operativos ─────────────────────────────────────────────
        $gastosDetalle = MovimientoCaja::where('id_empresa', $empresaId)
            ->where('tipo', 'egreso')
            ->whereBetween('created_at', [$desde, $hasta])
            ->groupBy('concepto')
            ->selectRaw('concepto, SUM(monto) as total, COUNT(*) as num_movimientos')
            ->orderByRaw('SUM(monto) DESC')
            ->get()
            ->map(function ($row) use ($gastos) {
                return [
                    'concepto'         => $row->concepto,
                    'total'            => round($row->total, 2),
                    'num_movimientos'  => (int) $row->num_movimientos,
                    'porcentaje'       => $gastos > 0 ? round(($row->total / $gastos) * 100, 1) : 0,
                ];
            });

        return response()->json([
            'success' => true,
            'data' => [
                'periodo'   => $periodo,
                'desde'     => $desde->format('Y-m-d'),
                'hasta'     => $hasta->format('Y-m-d'),
                'kpis'      => [
                    'ingresos'       => round($ingresos, 2),
                    'costo'          => round($costo, 2),
                    'gastos'         => round($gastos, 2),
                    'utilidad'       => round($utilidad, 2),
                    'margen'         => round($margen, 1),
                    'cambio_utilidad' => $utilidadAntes != 0
                        ? round((($utilidad - $utilidadAntes) / abs($utilidadAntes)) * 100, 1)
                        : 0,
                    'cambio_ingresos' => $ingresosAntes != 0
                        ? round((($ingresos - $ingresosAntes) / $ingresosAntes) * 100, 1)
                        : 0,
                ],
                'rentabilidad_productos' => $rentabilidadProductos,
                'margen_categorias'      => $margenCategorias,
                'margen_vendedores'      => $margenVendedores,
                'utilidad_tiempo'        => $utilidadTiempo,
                'gastos_detalle'         => $gastosDetalle,
            ],
        ]);
    }

    private function rangoPeriodo(string $periodo, Request $request): array
    {
        $now = Carbon::now();
        return match ($periodo) {
            'hoy'    => [$now->copy()->startOfDay(), $now->copy()->endOfDay()],
            'semana' => [$now->copy()->startOfWeek(), $now->copy()->endOfWeek()],
            'año'    => [$now->copy()->startOfYear(), $now->copy()->endOfYear()],
            'custom' => [
                Carbon::parse($request->get('desde', $now->copy()->startOfMonth())),
                Carbon::parse($request->get('hasta', $now->copy()->endOfMonth())),
            ],
            default  => [$now->copy()->startOfMonth(), $now->copy()->endOfMonth()],
        };
    }
}
