<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // Actualizar todos los registros a 'Inactiva' primero
        DB::table('cajas')->update(['estado' => 'Inactiva']);
        
        // Luego modificar el enum
        DB::statement("ALTER TABLE cajas MODIFY COLUMN estado ENUM('Inactiva', 'Activa') NOT NULL DEFAULT 'Inactiva'");
    }

    public function down(): void
    {
        DB::statement("ALTER TABLE cajas MODIFY COLUMN estado ENUM('Abierta', 'Cerrada', 'Pendiente Autorización') NOT NULL DEFAULT 'Abierta'");
    }
};
