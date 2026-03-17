<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class OfertaSeeder extends Seeder
{
    public function run(): void
    {
        $ofertas = [
            [
                'id_producto' => 1,
                'id_empresa' => 1,
                'tipo' => 'porcentaje',
                'valor' => 10.00,
                'precio_final' => null,
                'fecha_inicio' => now(),
                'fecha_fin' => now()->addDays(30),
                'estado' => '1',
                'descripcion' => 'Descuento del 10% por promoción',
            ],
            [
                'id_producto' => 2,
                'id_empresa' => 1,
                'tipo' => 'monto',
                'valor' => 5.00,
                'precio_final' => null,
                'fecha_inicio' => now(),
                'fecha_fin' => now()->addDays(15),
                'estado' => '1',
                'descripcion' => 'Descuento de S/5.00',
            ],
            [
                'id_producto' => 3,
                'id_empresa' => 1,
                'tipo' => 'porcentaje',
                'valor' => 15.00,
                'precio_final' => null,
                'fecha_inicio' => now(),
                'fecha_fin' => now()->addDays(7),
                'estado' => '1',
                'descripcion' => 'Oferta especial 15% descuento',
            ],
        ];

        DB::table('ofertas')->insert($ofertas);
    }
}
