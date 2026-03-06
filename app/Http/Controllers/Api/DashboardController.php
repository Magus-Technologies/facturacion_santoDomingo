<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Venta;
use App\Models\Caja;
use App\Models\MetodoPago;
use App\Models\ProductoVenta;
use App\Models\Categoria;
use App\Models\Producto;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function stats(Request $request)
    {
        $fechaInicio = $request->query('fecha_inicio', now()->subDays(7)->format('Y-m-d'));
        $fechaFin    = $request->query('fecha_fin', now()->format('Y-m-d'));
        $empresaId   = $request->query('empresa_id');

        // Período actual
        $query = Venta::whereBetween('fecha_emision', [$fechaInicio, $fechaFin])->activas();
        if ($empresaId) $query->where('id_empresa', $empresaId);
        $ventasTotales      = (float) ($query->sum('total') ?? 0);
        $totalTransacciones = (int)   $query->count();
        $ticketPromedio     = $totalTransacciones > 0 ? $ventasTotales / $totalTransacciones : 0;

        // Período anterior (misma duración)
        $inicio        = Carbon::parse($fechaInicio);
        $fin           = Carbon::parse($fechaFin);
        $dias          = $inicio->diffInDays($fin) + 1;
        $antInicio     = $inicio->copy()->subDays($dias)->format('Y-m-d');
        $antFin        = $inicio->copy()->subDays(1)->format('Y-m-d');

        $queryAnt = Venta::whereBetween('fecha_emision', [$antInicio, $antFin])->activas();
        if ($empresaId) $queryAnt->where('id_empresa', $empresaId);
        $antVentas      = (float) ($queryAnt->sum('total') ?? 0);
        $antTrans       = (int)   $queryAnt->count();
        $antTicket      = $antTrans > 0 ? $antVentas / $antTrans : 0;

        $pct = fn($actual, $anterior) => $anterior > 0
            ? round((($actual - $anterior) / $anterior) * 100, 1)
            : ($actual > 0 ? 100 : 0);

        $cajasAbiertas = (int) Caja::where('estado', 'abierta')->count();
        $diferenciasP  = (int) Caja::where('estado', 'pendiente_validacion')->count();

        return response()->json([
            'success' => true,
            'data' => [
                'ventas_totales'         => round($ventasTotales, 2),
                'ingresos_netos'         => round($ventasTotales * 0.95, 2),
                'ticket_promedio'        => round($ticketPromedio, 2),
                'total_transacciones'    => $totalTransacciones,
                'cajas_abiertas'         => $cajasAbiertas,
                'diferencias_pendientes' => $diferenciasP,
                'cuentas_cobrar'         => 0,
                'total_metodos'          => (int) MetodoPago::count(),
                'ventas_cambio'          => $pct($ventasTotales, $antVentas),
                'ingresos_cambio'        => $pct($ventasTotales * 0.95, $antVentas * 0.95),
                'ticket_cambio'          => $pct($ticketPromedio, $antTicket),
                'transacciones_cambio'   => $pct($totalTransacciones, $antTrans),
            ]
        ]);
    }

    public function ventasPorDia(Request $request)
    {
        $fechaInicio = $request->query('fecha_inicio', now()->subDays(7)->format('Y-m-d'));
        $fechaFin = $request->query('fecha_fin', now()->format('Y-m-d'));
        $empresaId = $request->query('empresa_id');

        // Período actual
        $query = Venta::selectRaw('DATE(fecha_emision) as fecha, SUM(total) as total')
            ->whereBetween('fecha_emision', [$fechaInicio, $fechaFin])
            ->activas();
        if ($empresaId) $query->where('id_empresa', $empresaId);
        $ventas = $query->groupBy('fecha')->orderBy('fecha')->get()
            ->keyBy('fecha');

        // Período anterior (misma duración, desplazado hacia atrás)
        $inicio = \Carbon\Carbon::parse($fechaInicio);
        $fin = \Carbon\Carbon::parse($fechaFin);
        $dias = $inicio->diffInDays($fin) + 1;
        $anteriorInicio = $inicio->copy()->subDays($dias)->format('Y-m-d');
        $anteriorFin = $inicio->copy()->subDays(1)->format('Y-m-d');

        $queryAnt = Venta::selectRaw('DATE(fecha_emision) as fecha, SUM(total) as total')
            ->whereBetween('fecha_emision', [$anteriorInicio, $anteriorFin])
            ->activas();
        if ($empresaId) $queryAnt->where('id_empresa', $empresaId);
        $ventasAnt = $queryAnt->groupBy('fecha')->orderBy('fecha')->get()
            ->values();

        // Generar serie de días del período actual con total_anterior alineado por offset
        $resultado = [];
        $diasActuales = collect();
        for ($i = 0; $i < $dias; $i++) {
            $diasActuales->push($inicio->copy()->addDays($i)->format('Y-m-d'));
        }

        foreach ($diasActuales as $i => $fecha) {
            $resultado[] = [
                'fecha' => $fecha,
                'total' => (float) ($ventas[$fecha]->total ?? 0),
                'total_anterior' => (float) ($ventasAnt[$i]->total ?? 0),
            ];
        }

        return response()->json([
            'success' => true,
            'data' => $resultado
        ]);
    }

    public function metodosPago(Request $request)
    {
        $fechaInicio = $request->query('fecha_inicio', now()->subDays(7)->format('Y-m-d'));
        $fechaFin = $request->query('fecha_fin', now()->format('Y-m-d'));
        $empresaId = $request->query('empresa_id');

        $query = Venta::selectRaw('metodos_pago.nombre, SUM(ventas.total) as total, COUNT(*) as cantidad_ventas')
            ->join('metodos_pago', 'ventas.id_tipo_pago', '=', 'metodos_pago.id_metodo_pago')
            ->whereBetween('ventas.fecha_emision', [$fechaInicio, $fechaFin])
            ->activas();
        
        if ($empresaId) $query->where('ventas.id_empresa', $empresaId);

        $metodos = $query->groupBy('metodos_pago.id_metodo_pago', 'metodos_pago.nombre')
            ->get()
            ->map(function ($item) {
                $item->total = (float) ($item->total ?? 0);
                $item->cantidad_ventas = (int) ($item->cantidad_ventas ?? 0);
                return $item;
            });

        return response()->json([
            'success' => true,
            'data' => $metodos
        ]);
    }

    public function ingresosEgresos(Request $request)
    {
        $fechaInicio = $request->query('fecha_inicio', now()->subDays(7)->format('Y-m-d'));
        $fechaFin = $request->query('fecha_fin', now()->format('Y-m-d'));
        $empresaId = $request->query('empresa_id');

        $query = Venta::selectRaw('DATE(fecha_emision) as fecha, SUM(total) as ingresos')
            ->whereBetween('fecha_emision', [$fechaInicio, $fechaFin])
            ->activas();
        
        if ($empresaId) $query->where('id_empresa', $empresaId);

        $datos = $query->groupBy('fecha')
            ->orderBy('fecha')
            ->get()
            ->map(function ($item) {
                $item->ingresos = (float) ($item->ingresos ?? 0);
                $item->egresos = $item->ingresos * 0.1;
                return $item;
            });

        return response()->json([
            'success' => true,
            'data' => $datos
        ]);
    }

    public function topProductos(Request $request)
    {
        $fechaInicio = $request->query('fecha_inicio', now()->subDays(7)->format('Y-m-d'));
        $fechaFin = $request->query('fecha_fin', now()->format('Y-m-d'));
        $limit = $request->query('limit', 5);
        $empresaId = $request->query('empresa_id');

        $query = Venta::selectRaw('productos.nombre, SUM(productos_ventas.cantidad) as cantidad')
            ->join('productos_ventas', 'ventas.id_venta', '=', 'productos_ventas.id_venta')
            ->join('productos', 'productos_ventas.id_producto', '=', 'productos.id_producto')
            ->whereBetween('ventas.fecha_emision', [$fechaInicio, $fechaFin])
            ->activas();
        
        if ($empresaId) $query->where('ventas.id_empresa', $empresaId);

        $productos = $query->groupBy('productos.id_producto', 'productos.nombre')
            ->orderByDesc('cantidad')
            ->limit($limit)
            ->get()
            ->map(function ($item) {
                $item->cantidad = (int) ($item->cantidad ?? 0);
                return $item;
            });

        return response()->json([
            'success' => true,
            'data' => $productos
        ]);
    }

    public function ultimasTransacciones(Request $request)
    {
        $limit = $request->query('limit', 10);
        $empresaId = $request->query('empresa_id');

        $query = Venta::selectRaw('ventas.*, clientes.datos as cliente, metodos_pago.nombre as metodo')
            ->leftJoin('clientes', 'ventas.id_cliente', '=', 'clientes.id_cliente')
            ->leftJoin('metodos_pago', 'ventas.id_tipo_pago', '=', 'metodos_pago.id_metodo_pago')
            ->activas();
        
        if ($empresaId) $query->where('ventas.id_empresa', $empresaId);

        $transacciones = $query->orderByDesc('ventas.fecha_emision')
            ->limit($limit)
            ->get()
            ->map(function ($item) {
                $item->fecha = $item->fecha_emision;
                $item->monto = $item->total;
                $item->estado = 'completada';
                return $item;
            });

        return response()->json([
            'success' => true,
            'data' => $transacciones
        ]);
    }

    public function cajasPendientes()
    {
        $cajas = Caja::where('estado', 'pendiente_validacion')
            ->with('usuarioApertura')
            ->get()
            ->map(function ($caja) {
                return [
                    'id_caja' => $caja->id_caja,
                    'vendedor' => $caja->usuarioApertura->name ?? 'N/A',
                    'apertura' => $caja->saldo_inicial,
                    'cierre' => $caja->saldo_final_real,
                    'diferencia' => $caja->diferencia
                ];
            });

        return response()->json([
            'success' => true,
            'data' => $cajas
        ]);
    }

    public function topCategorias(Request $request)
    {
        $fechaInicio = $request->query('fecha_inicio', now()->subDays(7)->format('Y-m-d'));
        $fechaFin = $request->query('fecha_fin', now()->format('Y-m-d'));
        $limit = $request->query('limit', 10);
        $empresaId = $request->query('empresa_id');

        $query = Venta::selectRaw('categorias.nombre as categoria, COUNT(DISTINCT ventas.id_venta) as total_ventas, SUM(productos_ventas.total) as monto_total, SUM(productos_ventas.cantidad) as cantidad_total')
            ->join('productos_ventas', 'ventas.id_venta', '=', 'productos_ventas.id_venta')
            ->join('productos', 'productos_ventas.id_producto', '=', 'productos.id_producto')
            ->join('categorias', 'productos.categoria_id', '=', 'categorias.id')
            ->whereBetween('ventas.fecha_emision', [$fechaInicio, $fechaFin])
            ->activas();
        
        if ($empresaId) $query->where('ventas.id_empresa', $empresaId);

        $categorias = $query->groupBy('categorias.id', 'categorias.nombre')
            ->orderByDesc('monto_total')
            ->limit($limit)
            ->get()
            ->map(function ($item) {
                $item->monto_total = (float) ($item->monto_total ?? 0);
                $item->total_ventas = (int) ($item->total_ventas ?? 0);
                $item->cantidad_total = (int) ($item->cantidad_total ?? 0);
                return $item;
            });

        return response()->json([
            'success' => true,
            'data' => $categorias
        ]);
    }

    public function topMarcas(Request $request)
    {
        // In this system, brands are managed through the categorias table
        return $this->topCategorias($request);
    }

    public function topFechas(Request $request)
    {
        $fechaInicio = $request->query('fecha_inicio', now()->subDays(30)->format('Y-m-d'));
        $fechaFin = $request->query('fecha_fin', now()->format('Y-m-d'));
        $limit = $request->query('limit', 10);
        $empresaId = $request->query('empresa_id');

        $query = Venta::selectRaw('DATE(fecha_emision) as fecha, COUNT(*) as total_ventas, SUM(total) as monto_total')
            ->whereBetween('fecha_emision', [$fechaInicio, $fechaFin])
            ->activas();
        
        if ($empresaId) $query->where('id_empresa', $empresaId);

        $fechas = $query->groupBy('fecha')
            ->orderByDesc('monto_total')
            ->limit($limit)
            ->get()
            ->map(function ($item) {
                $item->monto_total = (float) ($item->monto_total ?? 0);
                $item->total_ventas = (int) ($item->total_ventas ?? 0);
                return $item;
            });

        return response()->json([
            'success' => true,
            'data' => $fechas
        ]);
    }

    public function rentabilidad(Request $request)
    {
        $fechaInicio = $request->query('fecha_inicio', now()->subDays(7)->format('Y-m-d'));
        $fechaFin    = $request->query('fecha_fin', now()->format('Y-m-d'));
        $limit       = $request->query('limit', 15);
        $empresaId   = $request->query('empresa_id');

        $query = Venta::selectRaw('
                productos.id_producto,
                productos.nombre,
                SUM(productos_ventas.cantidad) as cantidad,
                SUM(productos_ventas.total) as ingresos,
                SUM(productos_ventas.cantidad * productos.costo) as costo_total,
                (SUM(productos_ventas.total) - SUM(productos_ventas.cantidad * productos.costo)) as ganancia,
                CASE
                    WHEN SUM(productos_ventas.total) > 0
                    THEN ROUND(((SUM(productos_ventas.total) - SUM(productos_ventas.cantidad * productos.costo)) / SUM(productos_ventas.total)) * 100, 2)
                    ELSE 0
                END as margen_porcentaje
            ')
            ->join('productos_ventas', 'ventas.id_venta', '=', 'productos_ventas.id_venta')
            ->join('productos', 'productos_ventas.id_producto', '=', 'productos.id_producto')
            ->whereBetween('ventas.fecha_emision', [$fechaInicio, $fechaFin])
            ->activas();

        if ($empresaId) $query->where('ventas.id_empresa', $empresaId);

        $data = $query
            ->groupBy('productos.id_producto', 'productos.nombre')
            ->orderByDesc('ganancia')
            ->limit($limit)
            ->get()
            ->map(function ($item) {
                return [
                    'nombre'            => $item->nombre,
                    'cantidad'          => (int) ($item->cantidad ?? 0),
                    'ingresos'          => round((float) ($item->ingresos ?? 0), 2),
                    'costo_total'       => round((float) ($item->costo_total ?? 0), 2),
                    'ganancia'          => round((float) ($item->ganancia ?? 0), 2),
                    'margen_porcentaje' => round((float) ($item->margen_porcentaje ?? 0), 2),
                ];
            });

        $totalIngresos = $data->sum('ingresos');
        $totalGanancia = $data->sum('ganancia');
        $margenGeneral = $totalIngresos > 0 ? round(($totalGanancia / $totalIngresos) * 100, 2) : 0;

        return response()->json([
            'success' => true,
            'data'    => $data,
            'resumen' => [
                'total_ingresos' => round($totalIngresos, 2),
                'total_ganancia' => round($totalGanancia, 2),
                'margen_general' => $margenGeneral,
            ],
        ]);
    }

    public function topClientes(Request $request)
    {
        $fechaInicio = $request->query('fecha_inicio', now()->subDays(7)->format('Y-m-d'));
        $fechaFin    = $request->query('fecha_fin', now()->format('Y-m-d'));
        $limit       = $request->query('limit', 10);
        $empresaId   = $request->query('empresa_id');

        $query = Venta::selectRaw('
                clientes.id_cliente,
                clientes.datos as nombre,
                clientes.documento as documento,
                COUNT(DISTINCT ventas.id_venta) as total_compras,
                SUM(ventas.total) as monto_total,
                AVG(ventas.total) as ticket_promedio
            ')
            ->join('clientes', 'ventas.id_cliente', '=', 'clientes.id_cliente')
            ->whereBetween('ventas.fecha_emision', [$fechaInicio, $fechaFin])
            ->activas();

        if ($empresaId) $query->where('ventas.id_empresa', $empresaId);

        $clientes = $query
            ->groupBy('clientes.id_cliente', 'clientes.datos', 'clientes.documento')
            ->orderByDesc('monto_total')
            ->limit($limit)
            ->get()
            ->map(function ($item) {
                return [
                    'nombre'          => $item->nombre ?? 'Sin nombre',
                    'documento'       => $item->documento ?? '-',
                    'total_compras'   => (int) ($item->total_compras ?? 0),
                    'monto_total'     => round((float) ($item->monto_total ?? 0), 2),
                    'ticket_promedio' => round((float) ($item->ticket_promedio ?? 0), 2),
                ];
            });

        return response()->json([
            'success' => true,
            'data'    => $clientes,
        ]);
    }

    public function ventasPorHora(Request $request)
    {
        $fechaInicio = $request->query('fecha_inicio', now()->subDays(7)->format('Y-m-d'));
        $fechaFin    = $request->query('fecha_fin', now()->format('Y-m-d'));
        $empresaId   = $request->query('empresa_id');

        $query = Venta::selectRaw('HOUR(fecha_emision) as hora, COUNT(*) as total_ventas, SUM(total) as monto_total')
            ->whereBetween('fecha_emision', [$fechaInicio, $fechaFin])
            ->activas();

        if ($empresaId) $query->where('id_empresa', $empresaId);

        $porHora = $query->groupBy('hora')->orderBy('hora')->get()
            ->keyBy('hora');

        $horasCompletas = collect(range(0, 23))->map(function ($h) use ($porHora) {
            $item = $porHora->get($h);
            return [
                'hora'         => $h,
                'hora_label'   => sprintf('%02d:00', $h),
                'total_ventas' => $item ? (int) $item->total_ventas : 0,
                'monto_total'  => $item ? round((float) $item->monto_total, 2) : 0,
            ];
        });

        return response()->json([
            'success' => true,
            'data'    => $horasCompletas->values(),
        ]);
    }

    public function vendedores(Request $request)
    {
        $fechaInicio = $request->query('fecha_inicio', now()->subDays(7)->format('Y-m-d'));
        $fechaFin    = $request->query('fecha_fin', now()->format('Y-m-d'));
        $empresaId   = $request->query('empresa_id');

        $query = Venta::selectRaw('
                users.id as id_usuario,
                users.name as vendedor,
                COUNT(DISTINCT ventas.id_venta) as total_ventas,
                SUM(ventas.total) as monto_total,
                AVG(ventas.total) as ticket_promedio
            ')
            ->join('users', 'ventas.id_usuario', '=', 'users.id')
            ->whereBetween('ventas.fecha_emision', [$fechaInicio, $fechaFin])
            ->activas();

        if ($empresaId) $query->where('ventas.id_empresa', $empresaId);

        $data = $query
            ->groupBy('users.id', 'users.name')
            ->orderByDesc('monto_total')
            ->get()
            ->map(function ($item) {
                return [
                    'vendedor'        => $item->vendedor ?? 'N/A',
                    'total_ventas'    => (int) ($item->total_ventas ?? 0),
                    'monto_total'     => round((float) ($item->monto_total ?? 0), 2),
                    'ticket_promedio' => round((float) ($item->ticket_promedio ?? 0), 2),
                ];
            });

        return response()->json([
            'success' => true,
            'data'    => $data,
        ]);
    }

    public function stockBajo(Request $request)
    {
        $empresaId = $request->query('empresa_id');

        $query = Producto::selectRaw('id_producto, nombre, codigo, cantidad, stock_minimo, (cantidad - stock_minimo) as diferencia')
            ->activo()
            ->whereColumn('cantidad', '<=', 'stock_minimo');

        if ($empresaId) $query->empresa($empresaId);

        $productos = $query->orderBy('cantidad')->limit(20)->get()
            ->map(function ($item) {
                return [
                    'nombre'       => $item->nombre,
                    'codigo'       => $item->codigo ?? '-',
                    'cantidad'     => (int) ($item->cantidad ?? 0),
                    'stock_minimo' => (int) ($item->stock_minimo ?? 0),
                    'diferencia'   => (int) ($item->diferencia ?? 0),
                    'urgente'      => ($item->cantidad ?? 0) <= 0,
                ];
            });

        return response()->json([
            'success' => true,
            'data'    => $productos,
            'total'   => $productos->count(),
        ]);
    }
}
