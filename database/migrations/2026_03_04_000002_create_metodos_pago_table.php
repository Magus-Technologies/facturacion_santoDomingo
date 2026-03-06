<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('metodos_pago', function (Blueprint $table) {
            $table->bigIncrements('id_metodo_pago');
            $table->string('nombre')->unique();
            $table->string('codigo')->unique();
            $table->text('descripcion')->nullable();
            $table->enum('tipo', ['Efectivo', 'Tarjeta', 'Transferencia', 'Billetera', 'Cheque', 'Otro'])->default('Otro');
            $table->unsignedBigInteger('id_banco')->nullable();
            $table->boolean('requiere_referencia')->default(false);
            $table->boolean('requiere_comprobante')->default(false);
            $table->boolean('activo')->default(true);
            $table->timestamps();

            $table->foreign('id_banco')->references('id_banco')->on('bancos')->nullOnDelete();
            $table->index('tipo');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('metodos_pago');
    }
};
