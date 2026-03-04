<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('clientes', function (Blueprint $table) {
            $table->string('tipo_doc', 1)->nullable()->after('documento');
        });

        // Poblar tipo_doc basado en longitud del documento existente
        DB::statement("UPDATE clientes SET tipo_doc = CASE
            WHEN LENGTH(documento) = 11 THEN '6'
            WHEN LENGTH(documento) = 8 THEN '1'
            WHEN LENGTH(documento) > 0 THEN '4'
            ELSE NULL
        END");
    }

    public function down(): void
    {
        Schema::table('clientes', function (Blueprint $table) {
            $table->dropColumn('tipo_doc');
        });
    }
};
