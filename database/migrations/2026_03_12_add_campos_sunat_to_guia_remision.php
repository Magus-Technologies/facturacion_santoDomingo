<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('guia_remision', function (Blueprint $table) {
            // Pagador del Flete
            if (!Schema::hasColumn('guia_remision', 'pagador_tipo_doc')) {
                $table->string('pagador_tipo_doc', 1)->nullable()->after('remitente_ubigeo');
            }
            if (!Schema::hasColumn('guia_remision', 'pagador_documento')) {
                $table->string('pagador_documento', 11)->nullable()->after('pagador_tipo_doc');
            }
            if (!Schema::hasColumn('guia_remision', 'pagador_razon_social')) {
                $table->string('pagador_razon_social', 255)->nullable()->after('pagador_documento');
            }

            // Mercancía Peligrosa
            if (!Schema::hasColumn('guia_remision', 'mercancia_peligrosa')) {
                $table->boolean('mercancia_peligrosa')->default(false)->after('descripcion_motivo');
            }
            if (!Schema::hasColumn('guia_remision', 'codigo_onu')) {
                $table->string('codigo_onu', 4)->nullable()->after('mercancia_peligrosa');
            }

            // Vehículo - Ampliación
            if (!Schema::hasColumn('guia_remision', 'numero_registro_mtc')) {
                $table->string('numero_registro_mtc', 50)->nullable()->after('vehiculo_placa_secundaria');
            }
            if (!Schema::hasColumn('guia_remision', 'emisor_autorizacion')) {
                $table->string('emisor_autorizacion', 50)->nullable()->after('numero_registro_mtc');
            }
            if (!Schema::hasColumn('guia_remision', 'vehiculo_marca')) {
                $table->string('vehiculo_marca', 50)->nullable()->after('vehiculo_placa_secundaria');
            }
            if (!Schema::hasColumn('guia_remision', 'vehiculo_configuracion')) {
                $table->string('vehiculo_configuracion', 10)->nullable()->after('vehiculo_marca');
            }
            if (!Schema::hasColumn('guia_remision', 'vehiculo_habilitacion')) {
                $table->string('vehiculo_habilitacion', 20)->nullable()->after('vehiculo_configuracion');
            }

            // Transportista
            if (!Schema::hasColumn('guia_remision', 'tipo_documento_identidad_transportista')) {
                $table->string('tipo_documento_identidad_transportista', 1)->nullable()->after('transportista_nro_mtc');
            }
            if (!Schema::hasColumn('guia_remision', 'numero_documento_transportista')) {
                $table->string('numero_documento_transportista', 15)->nullable()->after('tipo_documento_identidad_transportista');
            }

            // Establecimiento Remitente / Destinatario
            if (!Schema::hasColumn('guia_remision', 'remitente_cod_establecimiento')) {
                $table->string('remitente_cod_establecimiento', 4)->nullable()->after('remitente_ubigeo');
            }
            if (!Schema::hasColumn('guia_remision', 'destinatario_cod_establecimiento')) {
                $table->string('destinatario_cod_establecimiento', 4)->nullable()->after('destinatario_nombre');
            }

            // Documento Relacionado
            if (!Schema::hasColumn('guia_remision', 'doc_relacionado_tipo')) {
                $table->string('doc_relacionado_tipo', 2)->nullable()->after('emisor_autorizacion');
            }
            if (!Schema::hasColumn('guia_remision', 'doc_relacionado_serie')) {
                $table->string('doc_relacionado_serie', 4)->nullable()->after('doc_relacionado_tipo');
            }
            if (!Schema::hasColumn('guia_remision', 'doc_relacionado_numero')) {
                $table->string('doc_relacionado_numero', 20)->nullable()->after('doc_relacionado_serie');
            }
            if (!Schema::hasColumn('guia_remision', 'doc_relacionado_emisor_ruc')) {
                $table->string('doc_relacionado_emisor_ruc', 11)->nullable()->after('doc_relacionado_numero');
            }

            // Mercancía Especial
            if (!Schema::hasColumn('guia_remision', 'mercancia_iqbf')) {
                $table->boolean('mercancia_iqbf')->default(false)->after('mercancia_peligrosa');
            }
            if (!Schema::hasColumn('guia_remision', 'mercancia_voluminosa')) {
                $table->boolean('mercancia_voluminosa')->default(false)->after('codigo_onu');
            }

            // Tipo de Guía (09 = Remitente, 31 = Transportista)
            if (!Schema::hasColumn('guia_remision', 'tipo_guia')) {
                $table->string('tipo_guia', 2)->default('09')->after('id_venta');
            }

            // Número de Bultos
            if (!Schema::hasColumn('guia_remision', 'nro_bultos')) {
                $table->integer('nro_bultos')->nullable()->after('peso_total');
            }

            // Indicador de Transbordo
            if (!Schema::hasColumn('guia_remision', 'indicador_transbordo')) {
                $table->boolean('indicador_transbordo')->default(false)->after('nro_bultos');
            }
        });
    }

    public function down(): void
    {
        Schema::table('guia_remision', function (Blueprint $table) {
            $columns = [
                'pagador_tipo_doc', 'pagador_documento', 'pagador_razon_social',
                'mercancia_peligrosa', 'codigo_onu',
                'numero_registro_mtc', 'emisor_autorizacion',
                'vehiculo_marca', 'vehiculo_configuracion', 'vehiculo_habilitacion',
                'tipo_documento_identidad_transportista', 'numero_documento_transportista',
                'remitente_cod_establecimiento', 'destinatario_cod_establecimiento',
                'doc_relacionado_tipo', 'doc_relacionado_serie', 'doc_relacionado_numero', 'doc_relacionado_emisor_ruc',
                'mercancia_iqbf', 'mercancia_voluminosa',
                'tipo_guia', 'nro_bultos', 'indicador_transbordo',
            ];
            $existing = array_filter($columns, fn($col) => Schema::hasColumn('guia_remision', $col));
            if ($existing) {
                $table->dropColumn(array_values($existing));
            }
        });
    }
};
