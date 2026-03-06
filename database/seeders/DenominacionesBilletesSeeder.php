<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\DenominacionBillete;

class DenominacionesBilletesSeeder extends Seeder
{
    public function run(): void
    {
        // Billetes Peruanos (PEN)
        $denominacionesPEN = [
            ['nombre' => 'Billete S/. 200', 'valor' => 200.00, 'tipo' => 'billete', 'moneda' => 'PEN', 'orden' => 1],
            ['nombre' => 'Billete S/. 100', 'valor' => 100.00, 'tipo' => 'billete', 'moneda' => 'PEN', 'orden' => 2],
            ['nombre' => 'Billete S/. 50', 'valor' => 50.00, 'tipo' => 'billete', 'moneda' => 'PEN', 'orden' => 3],
            ['nombre' => 'Billete S/. 20', 'valor' => 20.00, 'tipo' => 'billete', 'moneda' => 'PEN', 'orden' => 4],
            ['nombre' => 'Billete S/. 10', 'valor' => 10.00, 'tipo' => 'billete', 'moneda' => 'PEN', 'orden' => 5],
            ['nombre' => 'Billete S/. 5', 'valor' => 5.00, 'tipo' => 'billete', 'moneda' => 'PEN', 'orden' => 6],
            ['nombre' => 'Billete S/. 2', 'valor' => 2.00, 'tipo' => 'billete', 'moneda' => 'PEN', 'orden' => 7],
            ['nombre' => 'Billete S/. 1', 'valor' => 1.00, 'tipo' => 'billete', 'moneda' => 'PEN', 'orden' => 8],
            ['nombre' => 'Moneda S/. 0.50', 'valor' => 0.50, 'tipo' => 'moneda', 'moneda' => 'PEN', 'orden' => 9],
            ['nombre' => 'Moneda S/. 0.20', 'valor' => 0.20, 'tipo' => 'moneda', 'moneda' => 'PEN', 'orden' => 10],
            ['nombre' => 'Moneda S/. 0.10', 'valor' => 0.10, 'tipo' => 'moneda', 'moneda' => 'PEN', 'orden' => 11],
            ['nombre' => 'Moneda S/. 0.05', 'valor' => 0.05, 'tipo' => 'moneda', 'moneda' => 'PEN', 'orden' => 12],
        ];

        // Billetes Estadounidenses (USD)
        $denominacionesUSD = [
            ['nombre' => 'Billete $ 100', 'valor' => 100.00, 'tipo' => 'billete', 'moneda' => 'USD', 'orden' => 1],
            ['nombre' => 'Billete $ 50', 'valor' => 50.00, 'tipo' => 'billete', 'moneda' => 'USD', 'orden' => 2],
            ['nombre' => 'Billete $ 20', 'valor' => 20.00, 'tipo' => 'billete', 'moneda' => 'USD', 'orden' => 3],
            ['nombre' => 'Billete $ 10', 'valor' => 10.00, 'tipo' => 'billete', 'moneda' => 'USD', 'orden' => 4],
            ['nombre' => 'Billete $ 5', 'valor' => 5.00, 'tipo' => 'billete', 'moneda' => 'USD', 'orden' => 5],
            ['nombre' => 'Billete $ 1', 'valor' => 1.00, 'tipo' => 'billete', 'moneda' => 'USD', 'orden' => 6],
        ];

        // Insertar denominaciones
        foreach (array_merge($denominacionesPEN, $denominacionesUSD) as $denominacion) {
            DenominacionBillete::firstOrCreate(
                ['valor' => $denominacion['valor'], 'moneda' => $denominacion['moneda']],
                $denominacion
            );
        }
    }
}
