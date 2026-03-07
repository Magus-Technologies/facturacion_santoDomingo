<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Obtener la primera empresa
        $primeraEmpresa = DB::table('empresas')->first();
        
        if ($primeraEmpresa) {
            // Asignar la primera empresa a usuarios que no tengan empresa
            DB::table('users')
                ->whereNull('id_empresa')
                ->update(['id_empresa' => $primeraEmpresa->id_empresa]);
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // No hacer nada en el rollback
    }
};
