<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ofertas', function (Blueprint $table) {
            $table->id();
            $table->integer('id_producto');
            $table->integer('id_empresa');
            $table->enum('tipo', ['porcentaje', 'monto'])->comment('porcentaje o monto fijo');
            $table->decimal('valor', 10, 2)->comment('valor del descuento');
            $table->decimal('precio_final', 10, 2)->nullable()->comment('precio después del descuento');
            $table->dateTime('fecha_inicio');
            $table->dateTime('fecha_fin')->nullable();
            $table->char('estado', 1)->default('1')->comment('1=activo, 0=inactivo');
            $table->text('descripcion')->nullable();
            $table->timestamps();

            $table->foreign('id_producto')
                ->references('id_producto')
                ->on('productos')
                ->onDelete('cascade');

            $table->foreign('id_empresa')
                ->references('id_empresa')
                ->on('empresas')
                ->onDelete('cascade');

            $table->index('id_producto');
            $table->index('id_empresa');
            $table->index('estado');
            $table->index('fecha_inicio');
            $table->index('fecha_fin');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ofertas');
    }
};
