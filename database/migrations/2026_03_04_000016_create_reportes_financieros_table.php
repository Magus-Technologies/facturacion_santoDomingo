<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('reportes_financieros', function (Blueprint $table) {
            $table->bigIncrements('id_reporte');
            $table->integer('id_empresa');
            $table->unsignedBigInteger('id_usuario');
            $table->enum('tipo', ['Flujo', 'Rentabilidad', 'Indicadores', 'Deuda']);
            $table->date('fecha_inicio');
            $table->date('fecha_fin');
            $table->json('datos_json')->nullable();
            $table->dateTime('generado_en')->nullable();
            $table->timestamps();

            $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
            $table->foreign('id_usuario')->references('id')->on('users');
            $table->index('id_empresa');
            $table->index('tipo');
            $table->index('fecha_inicio');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reportes_financieros');
    }
};
