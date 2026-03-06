<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('billeteras_digitales', function (Blueprint $table) {
            $table->bigIncrements('id_billetera');
            $table->integer('id_empresa');
            $table->unsignedBigInteger('id_metodo_pago');
            $table->unsignedBigInteger('id_banco');
            $table->string('numero_cuenta')->unique();
            $table->string('titular');
            $table->string('documento_tipo', 3)->default('DNI');
            $table->string('documento_numero');
            $table->decimal('saldo', 14, 2)->default(0);
            $table->boolean('activa')->default(true);
            $table->timestamps();

            $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
            $table->foreign('id_metodo_pago')->references('id_metodo_pago')->on('metodos_pago');
            $table->foreign('id_banco')->references('id_banco')->on('bancos');
            $table->index('id_empresa');
            $table->index('id_metodo_pago');
            $table->index('id_banco');
            $table->index('activa');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('billeteras_digitales');
    }
};
