<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('movimientos_caja', function (Blueprint $table) {
            $table->bigIncrements('id_movimiento');
            $table->unsignedBigInteger('id_caja');
            $table->integer('id_empresa');
            $table->unsignedBigInteger('id_usuario');
            $table->enum('tipo', ['Ingreso', 'Egreso'])->default('Ingreso');
            $table->string('concepto');
            $table->decimal('monto', 12, 2);
            $table->string('numero_operacion')->nullable();
            $table->string('referencia_tipo')->nullable();
            $table->unsignedBigInteger('referencia_id')->nullable();
            $table->text('descripcion')->nullable();
            $table->timestamps();

            $table->foreign('id_caja')->references('id_caja')->on('cajas');
            $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
            $table->foreign('id_usuario')->references('id')->on('users');
            $table->index('id_caja');
            $table->index('id_empresa');
            $table->index('tipo');
            $table->index('numero_operacion');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('movimientos_caja');
    }
};
