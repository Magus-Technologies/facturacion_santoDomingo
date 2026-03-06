<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('auditoria_cajas', function (Blueprint $table) {
            $table->bigIncrements('id_auditoria');
            $table->unsignedBigInteger('id_caja');
            $table->unsignedBigInteger('id_usuario');
            $table->enum('accion', ['Apertura', 'Cierre', 'Autorización Cierre', 'Rechazo Cierre', 'Modificación'])->default('Apertura');
            $table->text('detalles')->nullable();
            $table->string('ip_address')->nullable();
            $table->string('user_agent')->nullable();
            $table->timestamps();

            $table->foreign('id_caja')->references('id_caja')->on('cajas')->cascadeOnDelete();
            $table->foreign('id_usuario')->references('id')->on('users');
            $table->index('id_caja');
            $table->index('id_usuario');
            $table->index('accion');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('auditoria_cajas');
    }
};
