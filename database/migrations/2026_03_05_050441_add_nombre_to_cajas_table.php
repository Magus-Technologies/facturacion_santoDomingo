<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('cajas', function (Blueprint $table) {
            $table->string('nombre', 100)->nullable()->after('id_empresa');
            $table->text('descripcion')->nullable()->after('nombre');
        });

        // Asignar nombre a registros existentes
        DB::table('cajas')->whereNull('nombre')->update([
            'nombre' => DB::raw("CONCAT('Caja #', id_caja)"),
        ]);
    }

    public function down(): void
    {
        Schema::table('cajas', function (Blueprint $table) {
            $table->dropColumn(['nombre', 'descripcion']);
        });
    }
};
