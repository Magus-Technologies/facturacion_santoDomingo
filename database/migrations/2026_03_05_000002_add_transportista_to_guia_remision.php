<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('guia_remision', function (Blueprint $table) {
            $table->unsignedBigInteger('id_transportista')->nullable()->after('id_venta');
            
            $table->foreign('id_transportista')
                ->references('id')
                ->on('transportistas')
                ->onDelete('set null');
        });
    }

    public function down(): void
    {
        Schema::table('guia_remision', function (Blueprint $table) {
            $table->dropForeign(['id_transportista']);
            $table->dropColumn('id_transportista');
        });
    }
};
