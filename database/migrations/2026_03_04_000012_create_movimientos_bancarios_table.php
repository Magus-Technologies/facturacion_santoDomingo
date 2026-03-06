<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('movimientos_bancarios', function (Blueprint $table) {
            $table->bigIncrements('id_movimiento');
            $table->unsignedBigInteger('id_cuenta');
            $table->integer('id_empresa');
            $table->enum('tipo', ['Deposito', 'Retiro', 'Transferencia', 'Comision', 'Interes'])->default('Deposito');
            $table->decimal('monto', 14, 2);
            $table->date('fecha_movimiento');
            $table->string('numero_operacion')->nullable();
            $table->string('referencia')->nullable();
            $table->text('descripcion')->nullable();
            $table->boolean('conciliado')->default(false);
            $table->timestamps();

            $table->foreign('id_cuenta')->references('id_cuenta')->on('cuentas_bancarias');
            $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
            $table->index('id_cuenta');
            $table->index('id_empresa');
            $table->index('fecha_movimiento');
            $table->index('conciliado');
            $table->index('numero_operacion');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('movimientos_bancarios');
    }
};
