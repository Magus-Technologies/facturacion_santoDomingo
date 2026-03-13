<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\ProductoEnRemate;

class ProductoEnRemateSeeder extends Seeder
{
    public function run(): void
    {
        // Datos de ejemplo
        ProductoEnRemate::create([
            'producto_id' => 1,
            'orden' => 1,
            'estado' => '1',
            'imagen' => null
        ]);
    }
}
