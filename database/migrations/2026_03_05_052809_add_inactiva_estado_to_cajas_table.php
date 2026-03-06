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
        // MySQL: modificar ENUM para añadir 'Inactiva' y cambiar default
        DB::statement("ALTER TABLE cajas MODIFY COLUMN estado ENUM('Inactiva','Abierta','Cerrada','Pendiente Autorización') NOT NULL DEFAULT 'Inactiva'");
    }

    public function down(): void
    {
        DB::statement("ALTER TABLE cajas MODIFY COLUMN estado ENUM('Abierta','Cerrada','Pendiente Autorización') NOT NULL DEFAULT 'Abierta'");
    }
};
