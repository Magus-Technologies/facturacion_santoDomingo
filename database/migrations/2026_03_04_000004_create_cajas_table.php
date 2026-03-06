<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('cajas', function (Blueprint $table) {
            $table->bigIncrements('id_caja');
            $table->integer('id_empresa');
            $table->unsignedBigInteger('id_usuario_apertura');
            $table->unsignedBigInteger('id_usuario_cierre')->nullable();
            $table->unsignedBigInteger('id_usuario_autoriza_cierre')->nullable();
            $table->dateTime('fecha_apertura');
            $table->dateTime('fecha_cierre')->nullable();
            $table->dateTime('fecha_autorizacion_cierre')->nullable();
            $table->decimal('saldo_inicial', 12, 2)->default(0);
            $table->decimal('saldo_final_teorico', 12, 2)->nullable();
            $table->decimal('saldo_final_real', 12, 2)->nullable();
            $table->decimal('diferencia', 12, 2)->nullable();
            $table->enum('estado', ['Abierta', 'Cerrada', 'Pendiente Autorización'])->default('Abierta');
            $table->text('observaciones')->nullable();
            $table->text('observaciones_cierre')->nullable();
            $table->timestamps();

            $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
            $table->foreign('id_usuario_apertura')->references('id')->on('users');
            $table->foreign('id_usuario_cierre')->references('id')->on('users');
            $table->foreign('id_usuario_autoriza_cierre')->references('id')->on('users');
            $table->index('id_empresa');
            $table->index('fecha_apertura');
            $table->index('estado');
            $table->index('id_usuario_apertura');
            $table->index('id_usuario_cierre');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('cajas');
    }
};
