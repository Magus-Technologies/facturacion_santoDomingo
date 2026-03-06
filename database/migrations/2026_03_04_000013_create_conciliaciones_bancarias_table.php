<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('conciliaciones_bancarias', function (Blueprint $table) {
            $table->bigIncrements('id_conciliacion');
            $table->unsignedBigInteger('id_cuenta');
            $table->integer('id_empresa');
            $table->unsignedBigInteger('id_usuario');
            $table->date('fecha_conciliacion');
            $table->decimal('saldo_empresa', 14, 2);
            $table->decimal('saldo_banco', 14, 2);
            $table->decimal('diferencia', 14, 2);
            $table->enum('estado', ['Pendiente', 'Conciliada', 'Diferencia'])->default('Pendiente');
            $table->text('observaciones')->nullable();
            $table->timestamps();

            $table->foreign('id_cuenta')->references('id_cuenta')->on('cuentas_bancarias');
            $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
            $table->foreign('id_usuario')->references('id')->on('users');
            $table->index('id_cuenta');
            $table->index('id_empresa');
            $table->index('fecha_conciliacion');
            $table->index('estado');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('conciliaciones_bancarias');
    }
};
