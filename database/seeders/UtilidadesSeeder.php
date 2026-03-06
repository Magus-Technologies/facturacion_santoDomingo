<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UtilidadesSeeder extends Seeder
{
    public function run(): void
    {
        $empresaId = 1;
        $idCaja    = 1;
        $usuarios  = [2, 3]; // admin, gojo
        $clientes  = [4, 5, 8, 19];

        // ── 1. PRODUCTOS ──────────────────────────────────────────────────────
        $productos = $this->crearProductos($empresaId);

        // ── 2. VENTAS (últimos 6 meses) ───────────────────────────────────────
        $this->crearVentas($empresaId, $productos, $clientes, $usuarios);

        // ── 3. GASTOS OPERATIVOS ──────────────────────────────────────────────
        $this->crearGastos($empresaId, $idCaja, $usuarios[0]);

        $this->command->info('UtilidadesSeeder: datos generados correctamente.');
    }

    // ─────────────────────────────────────────────────────────────────────────
    private function crearProductos(int $empresaId): array
    {
        $catalogo = [
            // [nombre, categoria_id, costo, precio]
            ['Cuaderno A4 100 Hojas',       1,  3.50,   6.50],
            ['Lapicero Azul Caja x12',      1,  5.00,   9.50],
            ['Borrador Blanco',             1,  0.50,   1.20],
            ['Regla 30cm Plástico',         1,  1.00,   2.50],
            ['Tijera Escolar',              1,  2.00,   4.00],
            ['Llavero Surtido Acero',       9,  1.20,   3.50],
            ['Llavero LED Personalizado',   9,  2.50,   6.00],
            ['Llavero Cuero Premium',       9,  4.00,   9.00],
            ['Adorno Navideño Grande',      10, 8.00,  18.00],
            ['Adorno Mesa Moderno',         10, 5.50,  12.00],
            ['Artículo Bebé Mordedor',      14, 3.00,   7.50],
            ['Artículo Bebé Sonajero',      14, 2.50,   6.00],
            ['Termo Acero 500ml',            7, 12.00,  25.00],
            ['Termo Plástico 1L',            7,  6.00,  14.00],
            ['Juguete Auto Control',         3, 18.00,  38.00],
            ['Juguete Bloques 50 Piezas',    3,  9.00,  20.00],
            ['Clip Mariposa x50',            2,  1.50,   3.50],
            ['Clip Estándar x100',           2,  2.00,   4.50],
            ['Silicona Barra x10',          13,  3.00,   6.50],
            ['Repelente Spray 100ml',        4,  4.50,  10.00],
            ['Artículo Hogar Organizador',   8,  7.00,  15.00],
            ['Artículo Hogar Canasta',       8,  5.00,  11.00],
            ['Cable USB Tipo-C 1m',         15,  4.00,   9.00],
            ['Audífonos Bluetooth',         15, 25.00,  55.00],
            ['Ventilador USB Mini',         12, 10.00,  22.00],
        ];

        $ids = [];
        $now = Carbon::now();

        foreach ($catalogo as $item) {
            // Verificar si ya existe
            $exists = DB::table('productos')
                ->where('id_empresa', $empresaId)
                ->where('nombre', $item[0])
                ->value('id_producto');

            if ($exists) {
                $ids[] = [
                    'id_producto'  => $exists,
                    'costo'        => $item[2],
                    'precio'       => $item[3],
                    'categoria_id' => $item[1],
                ];
                DB::table('productos')->where('id_producto', $exists)
                    ->update(['costo' => $item[2], 'precio' => $item[3]]);
            } else {
                $id = DB::table('productos')->insertGetId([
                    'id_empresa'   => $empresaId,
                    'nombre'       => $item[0],
                    'costo'        => $item[2],
                    'precio'       => $item[3],
                    'categoria_id' => $item[1],
                    'cantidad'     => 200,
                    'stock_minimo' => 5,
                    'stock_maximo' => 500,
                    'estado'       => 1,
                    'moneda'       => 'PEN',
                    'created_at'   => $now,
                    'updated_at'   => $now,
                ]);
                $ids[] = [
                    'id_producto'  => $id,
                    'costo'        => $item[2],
                    'precio'       => $item[3],
                    'categoria_id' => $item[1],
                ];
            }
        }

        return $ids;
    }

    // ─────────────────────────────────────────────────────────────────────────
    private function crearVentas(int $empresaId, array $productos, array $clientes, array $usuarios): void
    {
        $igvRate = 0.18;
        $now     = Carbon::now();

        // Números de comprobante
        $numBoleta   = DB::table('documentos_empresas')
            ->where('id_empresa', $empresaId)->where('id_tido', 1)->value('numero') ?? 1;
        $numFactura  = DB::table('documentos_empresas')
            ->where('id_empresa', $empresaId)->where('id_tido', 2)->value('numero') ?? 1;

        // Generar 180 ventas distribuidas en 6 meses
        for ($mes = 5; $mes >= 0; $mes--) {
            $baseDate = $now->copy()->subMonths($mes)->startOfMonth();
            $diasEnMes = $baseDate->daysInMonth;

            // 20-35 ventas por mes
            $cantidadVentas = rand(20, 35);

            for ($i = 0; $i < $cantidadVentas; $i++) {
                $dia         = rand(1, $diasEnMes);
                $fechaEmision = $baseDate->copy()->addDays($dia - 1)->toDateString();

                // Saltar fechas futuras
                if (Carbon::parse($fechaEmision)->isFuture()) {
                    $fechaEmision = $now->toDateString();
                }

                $idCliente = $clientes[array_rand($clientes)];
                $idUsuario = $usuarios[array_rand($usuarios)];
                $esBoleta  = rand(0, 3) > 0; // 75% boletas, 25% facturas

                $idTido = $esBoleta ? 1 : 2;
                $serie  = $esBoleta ? 'B001' : 'F001';

                if ($esBoleta) {
                    $numero = $numBoleta++;
                } else {
                    $numero = $numFactura++;
                }

                // Seleccionar 2-4 productos al azar
                $numItems = rand(2, 4);
                $itemsIdx = array_rand($productos, min($numItems, count($productos)));
                if (!is_array($itemsIdx)) $itemsIdx = [$itemsIdx];

                // Calcular totales
                $subtotalVenta = 0;
                $items = [];

                foreach ($itemsIdx as $idx) {
                    $prod     = $productos[$idx];
                    $cantidad = rand(1, 5);

                    // Variación de precio ±10%
                    $factor = 1 + (rand(-10, 15) / 100);
                    $precioUnit = round($prod['precio'] * $factor, 2);

                    $valorUnit = round($precioUnit / (1 + $igvRate), 6);
                    $subtotalItem = round($valorUnit * $cantidad, 2);
                    $igvItem      = round($subtotalItem * $igvRate, 2);
                    $totalItem    = $subtotalItem + $igvItem;

                    $subtotalVenta += $subtotalItem;
                    $items[] = [
                        'id_producto'        => $prod['id_producto'],
                        'cantidad'           => $cantidad,
                        'precio_unitario'    => $precioUnit,
                        'valor_unitario'     => $valorUnit,
                        'subtotal'           => $subtotalItem,
                        'igv'                => $igvItem,
                        'total'              => $totalItem,
                        'descuento'          => 0,
                        'unidad_medida'      => 'NIU',
                        'tipo_afectacion_igv'=> '10',
                        'created_at'         => $now,
                        'updated_at'         => $now,
                    ];
                }

                $igvVenta   = round($subtotalVenta * $igvRate, 2);
                $totalVenta = $subtotalVenta + $igvVenta;

                // Descuento ocasional (10% de ventas)
                $descuento = 0;
                if (rand(1, 10) === 1) {
                    $descuento = round($subtotalVenta * rand(3, 8) / 100, 2);
                    $subtotalVenta -= $descuento;
                    $igvVenta  = round($subtotalVenta * $igvRate, 2);
                    $totalVenta = $subtotalVenta + $igvVenta;
                }

                $idVenta = DB::table('ventas')->insertGetId([
                    'id_tido'           => $idTido,
                    'id_tipo_pago'      => 1,
                    'afecta_stock'      => 1,
                    'stock_real_descontado' => 1,
                    'fecha_emision'     => $fechaEmision,
                    'serie'             => $serie,
                    'numero'            => $numero,
                    'id_cliente'        => $idCliente,
                    'subtotal'          => $subtotalVenta,
                    'igv'               => $igvVenta,
                    'total'             => $totalVenta,
                    'descuento_global'  => $descuento ?: null,
                    'estado'            => '1',
                    'estado_sunat'      => '0',
                    'id_empresa'        => $empresaId,
                    'id_usuario'        => $idUsuario,
                    'tipo_moneda'       => 'PEN',
                    'direccion'         => '',
                    'fecha_registro'    => $fechaEmision . ' 08:00:00',
                    'created_at'        => $fechaEmision . ' 08:00:00',
                    'updated_at'        => $fechaEmision . ' 08:00:00',
                ]);

                foreach ($items as $item) {
                    DB::table('productos_ventas')->insert(array_merge($item, [
                        'id_venta' => $idVenta,
                    ]));
                }

                // Pago
                DB::table('ventas_pagos')->insert([
                    'id_venta'      => $idVenta,
                    'id_tipo_pago'  => 1,
                    'monto'         => $totalVenta,
                    'fecha_pago'    => $fechaEmision,
                    'tipo_moneda'   => 'PEN',
                    'tipo_cambio'   => 1,
                    'monto_moneda_origen' => $totalVenta,
                    'created_at'    => $now,
                    'updated_at'    => $now,
                ]);
            }
        }

        // Actualizar numeración en documentos_empresas
        DB::table('documentos_empresas')
            ->where('id_empresa', $empresaId)->where('id_tido', 1)
            ->update(['numero' => $numBoleta]);
        DB::table('documentos_empresas')
            ->where('id_empresa', $empresaId)->where('id_tido', 2)
            ->update(['numero' => $numFactura]);
    }

    // ─────────────────────────────────────────────────────────────────────────
    private function crearGastos(int $empresaId, int $idCaja, int $idUsuario): void
    {
        $now = Carbon::now();

        $conceptos = [
            ['Alquiler local',           800,  1200, 1],
            ['Servicios de luz',          80,   150, 1],
            ['Servicios de agua',         40,    70, 1],
            ['Internet y teléfono',       90,   120, 1],
            ['Sueldos y salarios',      2500,  3500, 1],
            ['Transporte y delivery',     50,   150, 2],
            ['Material de oficina',       30,    80, 2],
            ['Publicidad y marketing',   100,   300, 2],
            ['Mantenimiento equipos',     50,   200, 1],
            ['Gastos bancarios',          20,    60, 2],
            ['Limpieza y seguridad',      80,   150, 1],
            ['Capacitación personal',    100,   250, 1],
        ];

        for ($mes = 5; $mes >= 0; $mes--) {
            $baseDate = $now->copy()->subMonths($mes)->startOfMonth();

            foreach ($conceptos as [$concepto, $min, $max, $frecuencia]) {
                // $frecuencia: 1=mensual, 2=varía (puede no ocurrir cada mes)
                if ($frecuencia === 2 && rand(0, 1) === 0) continue;

                $monto = rand($min * 100, $max * 100) / 100;
                $dia   = rand(1, min(28, $baseDate->daysInMonth));
                $fecha = $baseDate->copy()->addDays($dia - 1);

                if ($fecha->isFuture()) $fecha = $now->copy();

                DB::table('movimientos_caja')->insert([
                    'id_caja'     => $idCaja,
                    'id_empresa'  => $empresaId,
                    'id_usuario'  => $idUsuario,
                    'tipo'        => 'egreso',
                    'concepto'    => $concepto,
                    'monto'       => $monto,
                    'descripcion' => 'Gasto operativo - ' . $fecha->format('M Y'),
                    'created_at'  => $fecha->toDateTimeString(),
                    'updated_at'  => $fecha->toDateTimeString(),
                ]);
            }
        }
    }
}
