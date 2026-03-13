<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\ProductoDeTendencia;

class ProductoDeTendenciaSeeder extends Seeder
{
    public function run(): void
    {
        // Datos de ejemplo
        ProductoDeTendencia::create([
            'producto_id' => 2,
            'orden' => 1,
            'estado' => '1',
            'imagen' => null
        ]);
    }
}
