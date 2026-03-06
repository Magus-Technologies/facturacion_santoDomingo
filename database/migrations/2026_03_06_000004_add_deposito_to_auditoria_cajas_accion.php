<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // Cambiar valores inválidos a 'Apertura' primero
        DB::table('auditoria_cajas')
            ->whereNotIn('accion', ['Apertura', 'Cierre', 'Autorización Cierre', 'Rechazo Cierre', 'Modificación'])
            ->update(['accion' => 'Apertura']);
        
        DB::statement("ALTER TABLE auditoria_cajas MODIFY COLUMN accion ENUM('Apertura', 'Cierre', 'Autorización Cierre', 'Rechazo Cierre', 'Modificación', 'Depósito') NOT NULL DEFAULT 'Apertura'");
    }

    public function down(): void
    {
        DB::statement("ALTER TABLE auditoria_cajas MODIFY COLUMN accion ENUM('Apertura', 'Cierre', 'Autorización Cierre', 'Rechazo Cierre', 'Modificación') NOT NULL DEFAULT 'Apertura'");
    }
};
