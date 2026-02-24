<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('motivo_nota', function (Blueprint $table) {
            $table->id();
            $table->enum('tipo', ['NC', 'ND']);
            $table->string('codigo_sunat', 2);
            $table->string('descripcion');
            $table->boolean('estado')->default(true);
            $table->timestamps();
        });

        DB::table('motivo_nota')->insert([
            ['tipo' => 'NC', 'codigo_sunat' => '01', 'descripcion' => 'Anulación de la operación', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'NC', 'codigo_sunat' => '02', 'descripcion' => 'Anulación por error en el RUC', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'NC', 'codigo_sunat' => '03', 'descripcion' => 'Corrección por error en la descripción', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'NC', 'codigo_sunat' => '04', 'descripcion' => 'Descuento global', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'NC', 'codigo_sunat' => '05', 'descripcion' => 'Descuento por ítem', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'NC', 'codigo_sunat' => '06', 'descripcion' => 'Devolución total', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'NC', 'codigo_sunat' => '07', 'descripcion' => 'Devolución por ítem', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'NC', 'codigo_sunat' => '08', 'descripcion' => 'Bonificación', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'NC', 'codigo_sunat' => '09', 'descripcion' => 'Disminución en el valor', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'NC', 'codigo_sunat' => '10', 'descripcion' => 'Otros conceptos', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'ND', 'codigo_sunat' => '01', 'descripcion' => 'Intereses por mora', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'ND', 'codigo_sunat' => '02', 'descripcion' => 'Aumento en el valor', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'ND', 'codigo_sunat' => '03', 'descripcion' => 'Penalidades / otros conceptos', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['tipo' => 'ND', 'codigo_sunat' => '10', 'descripcion' => 'Otros conceptos', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }

    public function down(): void
    {
        Schema::dropIfExists('motivo_nota');
    }
};
