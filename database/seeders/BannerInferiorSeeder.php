<?php

namespace Database\Seeders;

use App\Models\BannerInferior;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class BannerInferiorSeeder extends Seeder
{
    public function run(): void
    {
        BannerInferior::create([
            'url' => '#',
            'imagen' => 'banner1.jpg',
            'estado' => '1',
        ]);

        BannerInferior::create([
            'url' => '#',
            'imagen' => 'banner2.jpg',
            'estado' => '1',
        ]);

        BannerInferior::create([
            'url' => '#',
            'imagen' => 'banner3.jpg',
            'estado' => '1',
        ]);
    }
}
