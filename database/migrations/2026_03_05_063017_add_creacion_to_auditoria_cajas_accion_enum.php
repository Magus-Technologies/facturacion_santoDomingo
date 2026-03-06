<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::statement("ALTER TABLE auditoria_cajas MODIFY COLUMN accion ENUM('Creación','Apertura','Cierre','Autorización Cierre','Rechazo Cierre','Modificación') NOT NULL");
    }

    public function down(): void
    {
        DB::statement("ALTER TABLE auditoria_cajas MODIFY COLUMN accion ENUM('Apertura','Cierre','Autorización Cierre','Rechazo Cierre','Modificación') NOT NULL");
    }
};
