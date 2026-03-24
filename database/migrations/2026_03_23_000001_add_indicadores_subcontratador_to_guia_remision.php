<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('guia_remision', function (Blueprint $table) {
            // Indicadores de traslado
            if (!Schema::hasColumn('guia_remision', 'indicador_retorno_vehiculo_vacio')) {
                $table->boolean('indicador_retorno_vehiculo_vacio')->default(false)->after('indicador_transbordo');
            }
            if (!Schema::hasColumn('guia_remision', 'indicador_transporte_subcontratado')) {
                $table->boolean('indicador_transporte_subcontratado')->default(false)->after('indicador_retorno_vehiculo_vacio');
            }
            if (!Schema::hasColumn('guia_remision', 'indicador_retorno_envases_embalajes_vacios')) {
                $table->boolean('indicador_retorno_envases_embalajes_vacios')->default(false)->after('indicador_transporte_subcontratado');
            }

            // Datos del subcontratador (requerido cuando indicador_transporte_subcontratado = true)
            if (!Schema::hasColumn('guia_remision', 'subcontratador_tipo_doc')) {
                $table->string('subcontratador_tipo_doc', 1)->nullable()->after('indicador_retorno_envases_embalajes_vacios');
            }
            if (!Schema::hasColumn('guia_remision', 'subcontratador_documento')) {
                $table->string('subcontratador_documento', 15)->nullable()->after('subcontratador_tipo_doc');
            }
            if (!Schema::hasColumn('guia_remision', 'subcontratador_nombre')) {
                $table->string('subcontratador_nombre', 255)->nullable()->after('subcontratador_documento');
            }
        });
    }

    public function down(): void
    {
        Schema::table('guia_remision', function (Blueprint $table) {
            $columns = [
                'indicador_retorno_vehiculo_vacio',
                'indicador_transporte_subcontratado',
                'indicador_retorno_envases_embalajes_vacios',
                'subcontratador_tipo_doc',
                'subcontratador_documento',
                'subcontratador_nombre',
            ];
            $existing = array_filter($columns, fn ($col) => Schema::hasColumn('guia_remision', $col));
            if ($existing) {
                $table->dropColumn(array_values($existing));
            }
        });
    }
};
