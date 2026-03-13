<?php

namespace Database\Seeders;

use App\Models\Marca;
use Illuminate\Database\Seeder;

class MarcaSeeder extends Seeder
{
    public function run(): void
    {
        $marcas = [
            ['cod_marca' => 'APPLE', 'nombre_marca' => 'Apple', 'descripcion' => 'Productos Apple', 'estado' => '0'],
            ['cod_marca' => 'SAMSUNG', 'nombre_marca' => 'Samsung', 'descripcion' => 'Productos Samsung', 'estado' => '0'],
            ['cod_marca' => 'LG', 'nombre_marca' => 'LG', 'descripcion' => 'Productos LG', 'estado' => '0'],
            ['cod_marca' => 'SONY', 'nombre_marca' => 'Sony', 'descripcion' => 'Productos Sony', 'estado' => '0'],
            ['cod_marca' => 'LENOVO', 'nombre_marca' => 'Lenovo', 'descripcion' => 'Productos Lenovo', 'estado' => '0'],
            ['cod_marca' => 'HP', 'nombre_marca' => 'HP', 'descripcion' => 'Productos HP', 'estado' => '0'],
            ['cod_marca' => 'DELL', 'nombre_marca' => 'Dell', 'descripcion' => 'Productos Dell', 'estado' => '0'],
            ['cod_marca' => 'ASUS', 'nombre_marca' => 'ASUS', 'descripcion' => 'Productos ASUS', 'estado' => '0'],
            ['cod_marca' => 'ACER', 'nombre_marca' => 'Acer', 'descripcion' => 'Productos Acer', 'estado' => '0'],
            ['cod_marca' => 'INTEL', 'nombre_marca' => 'Intel', 'descripcion' => 'Productos Intel', 'estado' => '0'],
            ['cod_marca' => 'AMD', 'nombre_marca' => 'AMD', 'descripcion' => 'Productos AMD', 'estado' => '0'],
            ['cod_marca' => 'NVIDIA', 'nombre_marca' => 'NVIDIA', 'descripcion' => 'Productos NVIDIA', 'estado' => '0'],
            ['cod_marca' => 'CORSAIR', 'nombre_marca' => 'Corsair', 'descripcion' => 'Productos Corsair', 'estado' => '0'],
            ['cod_marca' => 'RAZER', 'nombre_marca' => 'Razer', 'descripcion' => 'Productos Razer', 'estado' => '0'],
            ['cod_marca' => 'LOGITECH', 'nombre_marca' => 'Logitech', 'descripcion' => 'Productos Logitech', 'estado' => '0'],
        ];

        foreach ($marcas as $marca) {
            Marca::updateOrCreate(
                ['cod_marca' => $marca['cod_marca']],
                $marca
            );
        }
    }
}
