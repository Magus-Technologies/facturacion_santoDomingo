<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('guia_remision', function (Blueprint $table) {
            $table->string('remitente_direccion', 500)->nullable()->after('remitente_nombre');
            $table->string('remitente_ubigeo', 6)->nullable()->after('remitente_direccion');
        });
    }

    public function down(): void
    {
        Schema::table('guia_remision', function (Blueprint $table) {
            $table->dropColumn(['remitente_direccion', 'remitente_ubigeo']);
        });
    }
};
