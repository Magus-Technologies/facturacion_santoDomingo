<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('cuentas_bancarias', function (Blueprint $table) {
            $table->bigIncrements('id_cuenta');
            $table->integer('id_empresa');
            $table->unsignedBigInteger('id_banco');
            $table->string('numero_cuenta')->unique();
            $table->enum('tipo_cuenta', ['Corriente', 'Ahorros'])->default('Corriente');
            $table->string('moneda', 3)->default('PEN');
            $table->decimal('saldo_actual', 14, 2)->default(0);
            $table->decimal('saldo_banco', 14, 2)->default(0);
            $table->string('cci', 17)->nullable();
            $table->boolean('activa')->default(true);
            $table->timestamps();

            $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
            $table->foreign('id_banco')->references('id_banco')->on('bancos');
            $table->index('id_empresa');
            $table->index('id_banco');
            $table->index('activa');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('cuentas_bancarias');
    }
};
