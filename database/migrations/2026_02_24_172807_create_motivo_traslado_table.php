<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('motivo_traslado', function (Blueprint $table) {
            $table->id();
            $table->string('codigo', 2)->unique();
            $table->string('descripcion');
            $table->boolean('estado')->default(true);
            $table->timestamps();
        });

        // Catálogo N° 20 SUNAT - Motivos de traslado
        DB::table('motivo_traslado')->insert([
            ['codigo' => '01', 'descripcion' => 'Venta', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['codigo' => '02', 'descripcion' => 'Compra', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['codigo' => '03', 'descripcion' => 'Venta con entrega a terceros', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['codigo' => '04', 'descripcion' => 'Traslado entre establecimientos de la misma empresa', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['codigo' => '08', 'descripcion' => 'Emisor itinerante de comprobantes de pago', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['codigo' => '09', 'descripcion' => 'Traslado de bienes para transformación', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['codigo' => '13', 'descripcion' => 'Otros', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['codigo' => '14', 'descripcion' => 'Venta sujeta a confirmación del comprador', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['codigo' => '17', 'descripcion' => 'Traslado de bienes para transformación', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['codigo' => '18', 'descripcion' => 'Recojo de bienes transformados', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
            ['codigo' => '19', 'descripcion' => 'Traslado emisor itinerante de comprobantes de pago', 'estado' => true, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('motivo_traslado');
    }
};
