<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('productos_exclusivos', function (Blueprint $table) {
            $table->id('id_exclusivo');
            $table->string('tab_name'); // nuevos_ingresos, mas_vendidos, ofertas_especiales
            $table->unsignedBigInteger('producto_id');
            $table->integer('orden')->default(0);
            $table->string('estado', 1)->default('1');
            $table->timestamps();

            // Foreign key (opcional dependiendo si la tabla productos es manejada por Laravel o legacy)
            // Se asume que productos.id_producto es la PK
            // $table->foreign('producto_id')->references('id_producto')->on('productos')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('productos_exclusivos');
    }
};
