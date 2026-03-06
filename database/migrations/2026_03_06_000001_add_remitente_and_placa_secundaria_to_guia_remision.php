<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('guia_remision', function (Blueprint $table) {
            $table->string('remitente_tipo_doc', 1)->nullable()->after('destinatario_nombre');
            $table->string('remitente_documento', 15)->nullable()->after('remitente_tipo_doc');
            $table->string('remitente_nombre', 255)->nullable()->after('remitente_documento');
            $table->string('vehiculo_placa_secundaria', 20)->nullable()->after('vehiculo_placa');
            $table->string('establecimiento_codigo', 20)->nullable()->after('ubigeo_llegada');
        });
    }

    public function down(): void
    {
        Schema::table('guia_remision', function (Blueprint $table) {
            $table->dropColumn([
                'remitente_tipo_doc',
                'remitente_documento',
                'remitente_nombre',
                'vehiculo_placa_secundaria',
                'establecimiento_codigo',
            ]);
        });
    }
};
