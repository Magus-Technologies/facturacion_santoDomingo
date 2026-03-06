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
        Schema::create('caja_metodos_pago', function (Blueprint $table) {
            $table->bigIncrements('id_caja_metodo');
            $table->unsignedBigInteger('id_caja');
            $table->unsignedBigInteger('id_metodo_pago');
            $table->boolean('activo')->default(true);
            $table->timestamps();

            $table->foreign('id_caja')->references('id_caja')->on('cajas')->onDelete('cascade');
            $table->foreign('id_metodo_pago')->references('id_metodo_pago')->on('metodos_pago')->onDelete('cascade');
            $table->unique(['id_caja', 'id_metodo_pago']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('caja_metodos_pago');
    }
};
