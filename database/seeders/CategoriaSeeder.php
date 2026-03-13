<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CategoriaSeeder extends Seeder
{
    public function run(): void
    {
        $categorias = [
            ['nombre' => 'Electrónica',       'descripcion' => 'Equipos y dispositivos electrónicos', 'estado' => '1'],
            ['nombre' => 'Computadoras',       'descripcion' => 'Laptops, PCs y accesorios',           'estado' => '1'],
            ['nombre' => 'Celulares',          'descripcion' => 'Teléfonos móviles y smartphones',     'estado' => '1'],
            ['nombre' => 'Audio y Video',      'descripcion' => 'Parlantes, audífonos, televisores',   'estado' => '1'],
            ['nombre' => 'Accesorios',         'descripcion' => 'Cables, cargadores y periféricos',    'estado' => '1'],
            ['nombre' => 'Electrodomésticos',  'descripcion' => 'Aparatos para el hogar',              'estado' => '1'],
            ['nombre' => 'Redes',              'descripcion' => 'Routers, switches y cables de red',   'estado' => '1'],
            ['nombre' => 'Impresión',          'descripcion' => 'Impresoras, tóner e insumos',         'estado' => '1'],
        ];

        foreach ($categorias as $cat) {
            DB::table('categorias')->insertOrIgnore(array_merge($cat, [
                'created_at' => now(),
                'updated_at' => now(),
            ]));
        }
    }
}
