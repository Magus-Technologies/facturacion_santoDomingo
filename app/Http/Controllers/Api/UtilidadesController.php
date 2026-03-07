<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Venta;
use App\Models\MovimientoCaja;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Style\Border;

class UtilidadesController extends Controller
{
    public function index(Request $request)
    {
        $data = $this->getReportData($request);
        if ($data instanceof \Illuminate\Http\JsonResponse) {
            return $data;
        }

        return response()->json([
            'success' => true,
            'data' => $data,
        ]);
    }

    public function exportar(Request $request)
    {
        ini_set('memory_limit', '512M');
        set_time_limit(180);

        try {
            $user = $request->user();
            if (!$user) return response()->json(['message' => 'No autorizado'], 401);

            $data = $this->getReportData($request);
            if ($data instanceof \Illuminate\Http\JsonResponse) return $data;

            $spreadsheet = new Spreadsheet();
            
            // 1. Pestaña: Resumen KPI
            $sheet = $spreadsheet->getActiveSheet();
            $sheet->setTitle('Resumen General');
            $this->fillKpiSheet($sheet, $data['kpis'], $data['desde'], $data['hasta']);

            // 2. Pestaña: Productos
            $sheetProductos = $spreadsheet->createSheet();
            $sheetProductos->setTitle('Por Producto');
            $this->fillProductosSheet($sheetProductos, $data['rentabilidad_productos']);

            // 3. Pestaña: Ventas
            $sheetVentas = $spreadsheet->createSheet();
            $sheetVentas->setTitle('Por Venta');
            $this->fillVentasSheet($sheetVentas, $data['utilidad_ventas']);

            // 4. Pestaña: Categorías
            $sheetCats = $spreadsheet->createSheet();
            $sheetCats->setTitle('Por Categoría');
            $this->fillCategoriasSheet($sheetCats, $data['margen_categorias']);

            // 5. Pestaña: Vendedores
            $sheetVendedores = $spreadsheet->createSheet();
            $sheetVendedores->setTitle('Por Vendedor');
            $this->fillVendedoresSheet($sheetVendedores, $data['margen_vendedores']);

            // 6. Pestaña: Diario
            $sheetDiario = $spreadsheet->createSheet();
            $sheetDiario->setTitle('Resumen Diario');
            $this->fillDiarioSheet($sheetDiario, $data['utilidad_tiempo']);

            // 7. Pestaña: Gastos
            $sheetGastos = $spreadsheet->createSheet();
            $sheetGastos->setTitle('Gastos Detalle');
            $this->fillGastosSheet($sheetGastos, $data['gastos_detalle']);

            $tab = $request->get('tab');
            $sheetIndex = 0; // Default: Resumen General
            
            if ($tab === 'productos') $sheetIndex = 1;
            else if ($tab === 'ventas') $sheetIndex = 2;
            else if ($tab === 'categorias') $sheetIndex = 3;
            else if ($tab === 'vendedores') $sheetIndex = 4;
            else if ($tab === 'tiempo') $sheetIndex = 5;
            else if ($tab === 'gastos') $sheetIndex = 6;

            $spreadsheet->setActiveSheetIndex($sheetIndex);

            $tabName = match($tab) {
                'productos' => 'Productos',
                'ventas' => 'Ventas',
                'categorias' => 'Categorias',
                'vendedores' => 'Vendedores',
                'tiempo' => 'Tiempo',
                'gastos' => 'Gastos',
                default => 'Resumen'
            };
            $filename = 'Reporte_Utilidades_' . $tabName . '_' . date('Ymd_His') . '.xlsx';
            $writer = new Xlsx($spreadsheet);

            // Limpieza absoluta de cualquier buffer de salida previo
            while (ob_get_level() > 0) {
                ob_end_clean();
            }

            return response()->streamDownload(function() use ($writer) {
                $writer->save('php://output');
            }, $filename, [
                'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                'Cache-Control' => 'no-cache, no-store, must-revalidate',
                'Pragma' => 'no-cache',
                'Expires' => '0',
            ]);
        } catch (\Exception $e) {
            \Log::error('Error detallado exportando utilidades: ' . $e->getMessage() . "\n" . $e->getTraceAsString());
            return response()->json([
                'success' => false, 
                'message' => 'Error al generar Excel: ' . $e->getMessage()
            ], 500);
        }
    }

    private function fillKpiSheet($sheet, $kpis, $desde, $hasta)
    {
        $sheet->setCellValue('A1', 'REPORTE DE UTILIDADES Y BI FINANCIERO');
        $sheet->mergeCells('A1:B1');
        $sheet->getStyle('A1')->getFont()->setBold(true)->setSize(14);

        $sheet->setCellValue('A2', 'Periodo:');
        $sheet->setCellValue('B2', $desde . ' al ' . $hasta);

        $sheet->setCellValue('A4', 'INDICADOR');
        $sheet->setCellValue('B4', 'VALOR');
        $sheet->getStyle('A4:B4')->getFont()->setBold(true);

        $row = 5;
        $sheet->setCellValue('A' . $row, 'Ingresos Totales'); $sheet->setCellValue('B' . $row, $kpis['ingresos']); $row++;
        $sheet->setCellValue('A' . $row, 'Costos de Ventas'); $sheet->setCellValue('B' . $row, $kpis['costo']); $row++;
        $sheet->setCellValue('A' . $row, 'Gastos Operativos'); $sheet->setCellValue('B' . $row, $kpis['gastos']); $row++;
        $sheet->setCellValue('A' . $row, 'Utilidad Neta'); $sheet->setCellValue('B' . $row, $kpis['utilidad']); $row++;
        $sheet->setCellValue('A' . $row, 'Margen de Utilidad'); $sheet->setCellValue('B' . $row, ($kpis['margen'] / 100)); $row++;

        $sheet->getStyle('B5:B8')->getNumberFormat()->setFormatCode('#,##0.00');
        $sheet->getStyle('B9')->getNumberFormat()->setFormatCode('0.0%');
        $sheet->getColumnDimension('A')->setAutoSize(true);
        $sheet->getColumnDimension('B')->setAutoSize(true);
    }

    private function fillProductosSheet($sheet, $items)
    {
        $headers = ['Producto', 'Categoría', 'Costo Unit.', 'Precio Prom.', 'Unidades', 'Ingresos', 'Costos', 'Utilidad', 'Margen %', '% Ventas'];
        $sheet->fromArray($headers, null, 'A1');
        $sheet->getStyle('A1:J1')->getFont()->setBold(true);

        $rowNum = 2;
        foreach ($items as $item) {
            $sheet->fromArray([
                $item['producto'],
                $item['categoria'],
                $item['costo_unitario'],
                $item['precio_venta'],
                $item['unidades'],
                $item['ingreso_total'],
                $item['costo_total'],
                $item['utilidad_total'],
                ($item['margen'] / 100),
                ($item['porcentaje_ventas'] / 100)
            ], null, 'A' . $rowNum);
            $rowNum++;
        }
        if ($rowNum > 2) {
            $sheet->getStyle('I2:J' . ($rowNum - 1))->getNumberFormat()->setFormatCode('0.0%');
        }
        foreach (range('A', 'J') as $col) $sheet->getColumnDimension($col)->setAutoSize(true);
    }

    private function fillVentasSheet($sheet, $items)
    {
        $headers = ['Fecha', 'Comprobante', 'Cliente', 'Ingresos', 'Costos', 'Utilidad'];
        $sheet->fromArray($headers, null, 'A1');
        $sheet->getStyle('A1:F1')->getFont()->setBold(true);

        $rowNum = 2;
        foreach ($items as $item) {
            $sheet->fromArray([
                $item['fecha_emision'],
                $item['comprobante'],
                $item['cliente'],
                $item['ingresos'],
                $item['costos'],
                $item['utilidad']
            ], null, 'A' . $rowNum);
            $rowNum++;
        }
        foreach (range('A', 'F') as $col) $sheet->getColumnDimension($col)->setAutoSize(true);
    }

    private function fillCategoriasSheet($sheet, $items)
    {
        $headers = ['Categoría', 'Productos', 'Ingresos', 'Costos', 'Utilidad', 'Margen %'];
        $sheet->fromArray($headers, null, 'A1');
        $sheet->getStyle('A1:F1')->getFont()->setBold(true);

        $rowNum = 2;
        foreach ($items as $item) {
            $sheet->fromArray([
                $item['categoria'],
                $item['num_productos'],
                $item['ingreso_total'],
                $item['costo_total'],
                $item['utilidad_total'],
                ($item['margen'] / 100)
            ], null, 'A' . $rowNum);
            $rowNum++;
        }
        if ($rowNum > 2) {
            $sheet->getStyle('F2:F' . ($rowNum - 1))->getNumberFormat()->setFormatCode('0.0%');
        }
        foreach (range('A', 'F') as $col) $sheet->getColumnDimension($col)->setAutoSize(true);
    }

    private function fillVendedoresSheet($sheet, $items)
    {
        $headers = ['Vendedor', 'Ventas', 'Ingresos', 'Costos', 'Utilidad', 'Margen %', 'Ticket Prom.'];
        $sheet->fromArray($headers, null, 'A1');
        $sheet->getStyle('A1:G1')->getFont()->setBold(true);

        $rowNum = 2;
        foreach ($items as $item) {
            $sheet->fromArray([
                $item['vendedor'],
                $item['num_ventas'],
                $item['ingresos'],
                $item['costos'],
                $item['utilidad'],
                ($item['margen'] / 100),
                $item['ticket_prom']
            ], null, 'A' . $rowNum);
            $rowNum++;
        }
        if ($rowNum > 2) {
            $sheet->getStyle('F2:F' . ($rowNum - 1))->getNumberFormat()->setFormatCode('0.0%');
        }
        foreach (range('A', 'G') as $col) $sheet->getColumnDimension($col)->setAutoSize(true);
    }

    private function fillDiarioSheet($sheet, $items)
    {
        $headers = ['Periodo', 'Ventas', 'Ingresos', 'Costos', 'Utilidad'];
        $sheet->fromArray($headers, null, 'A1');
        $sheet->getStyle('A1:E1')->getFont()->setBold(true);

        $rowNum = 2;
        foreach ($items as $item) {
            $sheet->fromArray([
                $item['periodo'],
                $item['num_ventas'],
                $item['ingresos'],
                $item['costos'],
                $item['utilidad']
            ], null, 'A' . $rowNum);
            $rowNum++;
        }
        foreach (range('A', 'E') as $col) $sheet->getColumnDimension($col)->setAutoSize(true);
    }

    private function fillGastosSheet($sheet, $items)
    {
        $headers = ['Concepto', 'Movimientos', 'Total', '% del Gasto'];
        $sheet->fromArray($headers, null, 'A1');
        $sheet->getStyle('A1:D1')->getFont()->setBold(true);

        $rowNum = 2;
        foreach ($items as $item) {
            $sheet->fromArray([
                $item['concepto'],
                $item['num_movimientos'],
                $item['total'],
                ($item['porcentaje'] / 100)
            ], null, 'A' . $rowNum);
            $rowNum++;
        }
        if ($rowNum > 2) {
            $sheet->getStyle('D2:D' . ($rowNum - 1))->getNumberFormat()->setFormatCode('0.0%');
        }
        foreach (range('A', 'D') as $col) $sheet->getColumnDimension($col)->setAutoSize(true);
    }

    private function getReportData(Request $request)
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
                $margenPct     = $row->ingreso_total > 0 ? ($utilidadTotal / $row->ingreso_total) * 100 : 0;
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
                    'porcentaje_ventas' => $ingresos > 0 ? round(($row->ingreso_total / $ingresos) * 100, 1) : 0,
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
                $margenCat   = $row->ingreso_total > 0 ? ($utilidadCat / $row->ingreso_total) * 100 : 0;
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
                return [
                    'periodo'    => $row->periodo,
                    'ingresos'   => round($row->ingresos, 2),
                    'costos'     => round($row->costos, 2),
                    'utilidad'   => round($row->ingresos - $row->costos, 2),
                    'num_ventas' => (int) $row->num_ventas,
                ];
            });

        // ── Utilidad por Ventas Individuales ──────────────────────────────
        $utilidadVentas = DB::table('ventas as v')
            ->leftJoin('clientes as c', 'c.id_cliente', '=', 'v.id_cliente')
            ->leftJoin('productos_ventas as pv', 'pv.id_venta', '=', 'v.id_venta')
            ->leftJoin('productos as p', 'p.id_producto', '=', 'pv.id_producto')
            ->where('v.id_empresa', $empresaId)
            ->where('v.estado', '!=', '2')
            ->whereBetween('v.fecha_emision', [$desde, $hasta])
            ->groupBy('v.id_venta', 'v.fecha_emision', 'v.serie', 'v.numero', 'c.datos', 'v.subtotal')
            ->selectRaw("
                v.fecha_emision,
                CONCAT(v.serie, '-', LPAD(v.numero, 6, '0')) as comprobante,
                COALESCE(c.datos, 'Cliente o Varios') as cliente,
                v.subtotal as ingresos,
                COALESCE(SUM(pv.cantidad * COALESCE(p.costo, 0)), 0) as costos
            ")
            ->orderByRaw('v.fecha_emision DESC')
            ->get()
            ->map(function ($row) {
                return [
                    'fecha_emision' => $row->fecha_emision,
                    'comprobante'   => $row->comprobante,
                    'cliente'       => $row->cliente,
                    'ingresos'      => round($row->ingresos, 2),
                    'costos'        => round($row->costos, 2),
                    'utilidad'      => round($row->ingresos - $row->costos, 2),
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

        return [
            'periodo'   => $periodo,
            'desde'     => $desde->format('Y-m-d'),
            'hasta'     => $hasta->format('Y-m-d'),
            'kpis'      => [
                'ingresos'       => round($ingresos, 2),
                'costo'          => round($costo, 2),
                'gastos'         => round($gastos, 2),
                'utilidad'       => round($utilidad, 2),
                'margen'         => round($margen, 1),
                'cambio_utilidad' => $utilidadAntes != 0 ? round((($utilidad - $utilidadAntes) / abs($utilidadAntes)) * 100, 1) : 0,
                'cambio_ingresos' => $ingresosAntes != 0 ? round((($ingresos - $ingresosAntes) / $ingresosAntes) * 100, 1) : 0,
            ],
            'rentabilidad_productos' => $rentabilidadProductos,
            'margen_categorias'      => $margenCategorias,
            'margen_vendedores'      => $margenVendedores,
            'utilidad_tiempo'        => $utilidadTiempo,
            'utilidad_ventas'        => $utilidadVentas,
            'gastos_detalle'         => $gastosDetalle,
        ];
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
