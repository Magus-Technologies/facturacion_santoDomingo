<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('cajas', function (Blueprint $table) {
            // id_usuario (quien abre la caja) y fecha_apertura son null
            // hasta que la caja sea abierta por primera vez
            $table->unsignedBigInteger('id_usuario_apertura')->nullable()->change();
            $table->dateTime('fecha_apertura')->nullable()->change();
        });
    }

    public function down(): void
    {
        Schema::table('cajas', function (Blueprint $table) {
            $table->unsignedBigInteger('id_usuario_apertura')->nullable(false)->change();
            $table->dateTime('fecha_apertura')->nullable(false)->change();
        });
    }
};
