<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('guia_remision_detalles', function (Blueprint $table) {
            if (!Schema::hasColumn('guia_remision_detalles', 'bien_normalizado')) {
                $table->boolean('bien_normalizado')->default(false)->after('codigo');
            }
            if (!Schema::hasColumn('guia_remision_detalles', 'codigo_producto_sunat')) {
                $table->string('codigo_producto_sunat', 30)->nullable()->after('bien_normalizado');
            }
            if (!Schema::hasColumn('guia_remision_detalles', 'partida_arancelaria')) {
                $table->string('partida_arancelaria', 15)->nullable()->after('codigo_producto_sunat');
            }
            if (!Schema::hasColumn('guia_remision_detalles', 'codigo_gtin')) {
                $table->string('codigo_gtin', 14)->nullable()->after('partida_arancelaria');
            }
        });
    }

    public function down(): void
    {
        Schema::table('guia_remision_detalles', function (Blueprint $table) {
            $columns = [
                'bien_normalizado',
                'codigo_producto_sunat',
                'partida_arancelaria',
                'codigo_gtin',
            ];
            $existing = array_filter($columns, fn ($col) => Schema::hasColumn('guia_remision_detalles', $col));
            if ($existing) {
                $table->dropColumn(array_values($existing));
            }
        });
    }
};
