<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductoSeeder extends Seeder
{
    public function run(): void
    {
        $idEmpresa = 1;
        $almacen   = 1;

        // Obtener IDs de categorías y unidad
        $cats  = DB::table('categorias')->pluck('id', 'nombre');
        $unidad = DB::table('unidades')->where('codigo', 'NIU')->value('id')
               ?? DB::table('unidades')->first()?->id
               ?? 1;

        $electronica  = $cats['Electrónica']    ?? 1;
        $computadoras = $cats['Computadoras']   ?? 2;
        $celulares    = $cats['Celulares']      ?? 3;
        $audioVideo   = $cats['Audio y Video']  ?? 4;
        $accesorios   = $cats['Accesorios']     ?? 5;

        $productos = [
            [
                'codigo'       => 'SAMSUNG-TV-55',
                'nombre'       => 'Televisor Samsung 55" Smart TV 4K',
                'descripcion'  => 'Smart TV QLED 4K con HDR y Alexa integrada',
                'precio'       => 2499.90,
                'costo'        => 1800.00,
                'cantidad'     => 15,
                'categoria_id' => $electronica,
            ],
            [
                'codigo'       => 'LG-OLED-65',
                'nombre'       => 'Televisor LG OLED 65"',
                'descripcion'  => 'OLED evo 4K 120Hz con webOS 22',
                'precio'       => 4999.00,
                'costo'        => 3800.00,
                'cantidad'     => 8,
                'categoria_id' => $electronica,
            ],
            [
                'codigo'       => 'DELL-LAPTOP-15',
                'nombre'       => 'Laptop Dell Inspiron 15 Core i7',
                'descripcion'  => 'Core i7-1255U, 16GB RAM, 512GB SSD, pantalla FHD',
                'precio'       => 3299.00,
                'costo'        => 2600.00,
                'cantidad'     => 20,
                'categoria_id' => $computadoras,
            ],
            [
                'codigo'       => 'HP-LAPTOP-14',
                'nombre'       => 'Laptop HP Pavilion 14 Core i5',
                'descripcion'  => 'Core i5-1235U, 8GB RAM, 256GB SSD',
                'precio'       => 2199.00,
                'costo'        => 1700.00,
                'cantidad'     => 25,
                'categoria_id' => $computadoras,
            ],
            [
                'codigo'       => 'APPLE-IPHONE15',
                'nombre'       => 'Apple iPhone 15 128GB',
                'descripcion'  => 'Chip A16 Bionic, cámara 48MP, Dynamic Island',
                'precio'       => 4599.00,
                'costo'        => 3900.00,
                'cantidad'     => 30,
                'categoria_id' => $celulares,
            ],
            [
                'codigo'       => 'SAMSUNG-A54',
                'nombre'       => 'Samsung Galaxy A54 5G 128GB',
                'descripcion'  => 'Pantalla AMOLED 6.4", cámara 50MP, batería 5000mAh',
                'precio'       => 1299.00,
                'costo'        => 950.00,
                'cantidad'     => 40,
                'categoria_id' => $celulares,
            ],
            [
                'codigo'       => 'SONY-WH1000XM5',
                'nombre'       => 'Sony WH-1000XM5 Auriculares Bluetooth',
                'descripcion'  => 'Noise Cancelling líder, 30h batería, LDAC Hi-Res',
                'precio'       => 1299.00,
                'costo'        => 950.00,
                'cantidad'     => 18,
                'categoria_id' => $audioVideo,
            ],
            [
                'codigo'       => 'LG-BARRA-SND',
                'nombre'       => 'Barra de Sonido LG SP7 Dolby Atmos',
                'descripcion'  => '380W, 5.1ch, Meridian Technology',
                'precio'       => 899.00,
                'costo'        => 650.00,
                'cantidad'     => 12,
                'categoria_id' => $audioVideo,
            ],
            [
                'codigo'       => 'CABLE-HDMI-2M',
                'nombre'       => 'Cable HDMI 4K 2 metros',
                'descripcion'  => 'HDMI 2.0, 4K 60Hz, compatible con HDR',
                'precio'       => 29.90,
                'costo'        => 12.00,
                'cantidad'     => 100,
                'categoria_id' => $accesorios,
            ],
            [
                'codigo'       => 'CARG-USB-C-65W',
                'nombre'       => 'Cargador USB-C 65W GaN',
                'descripcion'  => 'Carga rápida compatible con laptops y smartphones',
                'precio'       => 89.90,
                'costo'        => 45.00,
                'cantidad'     => 60,
                'categoria_id' => $accesorios,
            ],
        ];

        foreach ($productos as $p) {
            DB::table('productos')->insertOrIgnore(array_merge([
                'cod_barra'           => '',
                'descripcion'         => '',
                'costo'               => 0,
                'precio_mayor'        => 0,
                'precio_menor'        => 0,
                'precio_unidad'       => $p['precio'],
                'stock_minimo'        => 0,
                'stock_maximo'        => 0,
                'id_empresa'          => $idEmpresa,
                'unidad_id'           => $unidad,
                'almacen'             => $almacen,
                'codsunat'            => '51121703',
                'usar_barra'          => '0',
                'usar_multiprecio'    => '0',
                'moneda'              => 'PEN',
                'estado'              => '1',
                'fecha_registro'      => now(),
                'created_at'          => now(),
                'updated_at'          => now(),
            ], $p));
        }
    }
}
