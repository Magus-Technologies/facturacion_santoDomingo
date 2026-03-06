<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('configuracion_metodos_pago', function (Blueprint $table) {
            $table->bigIncrements('id_config');
            $table->integer('id_empresa');
            $table->unsignedBigInteger('id_metodo_pago');
            $table->boolean('habilitado')->default(true);
            $table->decimal('comision', 5, 2)->default(0);
            $table->decimal('limite_minimo', 12, 2)->nullable();
            $table->decimal('limite_maximo', 12, 2)->nullable();
            $table->boolean('requiere_comprobante')->default(false);
            $table->boolean('requiere_referencia')->default(false);
            $table->timestamps();

            $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
            $table->foreign('id_metodo_pago')->references('id_metodo_pago')->on('metodos_pago');
            $table->unique(['id_empresa', 'id_metodo_pago']);
            $table->index('id_empresa');
            $table->index('habilitado');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('configuracion_metodos_pago');
    }
};
