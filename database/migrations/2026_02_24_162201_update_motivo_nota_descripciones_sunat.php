<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // Corregir descripciones NC según Catálogo N° 09 SUNAT oficial
        $motivos = [
            ['tipo' => 'NC', 'codigo_sunat' => '01', 'descripcion' => 'Anulación de la operación'],
            ['tipo' => 'NC', 'codigo_sunat' => '02', 'descripcion' => 'Anulación por error en el RUC'],
            ['tipo' => 'NC', 'codigo_sunat' => '03', 'descripcion' => 'Corrección por error en la descripción'],
            ['tipo' => 'NC', 'codigo_sunat' => '04', 'descripcion' => 'Descuento global'],
            ['tipo' => 'NC', 'codigo_sunat' => '05', 'descripcion' => 'Descuento por ítem'],
            ['tipo' => 'NC', 'codigo_sunat' => '06', 'descripcion' => 'Devolución total'],
            ['tipo' => 'NC', 'codigo_sunat' => '07', 'descripcion' => 'Devolución por ítem'],
            ['tipo' => 'NC', 'codigo_sunat' => '08', 'descripcion' => 'Bonificación'],
            ['tipo' => 'NC', 'codigo_sunat' => '09', 'descripcion' => 'Disminución en el valor'],
            ['tipo' => 'NC', 'codigo_sunat' => '10', 'descripcion' => 'Otros conceptos'],
            ['tipo' => 'NC', 'codigo_sunat' => '11', 'descripcion' => 'Ajustes de operaciones de exportación'],
            ['tipo' => 'NC', 'codigo_sunat' => '12', 'descripcion' => 'Ajustes afectos al IVAP'],
            ['tipo' => 'NC', 'codigo_sunat' => '13', 'descripcion' => 'Corrección del monto neto pendiente de pago'],
        ];

        foreach ($motivos as $m) {
            $exists = DB::table('motivo_nota')
                ->where('tipo', $m['tipo'])
                ->where('codigo_sunat', $m['codigo_sunat'])
                ->first();

            if ($exists) {
                DB::table('motivo_nota')
                    ->where('id', $exists->id)
                    ->update(['descripcion' => $m['descripcion'], 'updated_at' => now()]);
            } else {
                DB::table('motivo_nota')->insert([
                    'tipo' => $m['tipo'],
                    'codigo_sunat' => $m['codigo_sunat'],
                    'descripcion' => $m['descripcion'],
                    'estado' => true,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }

    public function down(): void
    {
        // Eliminar los motivos agregados (11, 12, 13)
        DB::table('motivo_nota')
            ->where('tipo', 'NC')
            ->whereIn('codigo_sunat', ['11', '12', '13'])
            ->delete();
    }
};
