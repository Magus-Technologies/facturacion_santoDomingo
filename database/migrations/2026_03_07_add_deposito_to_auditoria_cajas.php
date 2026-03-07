<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Modificar el ENUM para agregar 'Depósito'
        DB::statement("ALTER TABLE auditoria_cajas MODIFY COLUMN accion ENUM('Creación','Apertura','Cierre','Autorización Cierre','Rechazo Cierre','Modificación','Depósito','Retiro','Movimiento') COLLATE utf8mb4_unicode_ci NOT NULL");
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Revertir al ENUM original
        DB::statement("ALTER TABLE auditoria_cajas MODIFY COLUMN accion ENUM('Creación','Apertura','Cierre','Autorización Cierre','Rechazo Cierre','Modificación') COLLATE utf8mb4_unicode_ci NOT NULL");
    }
};
