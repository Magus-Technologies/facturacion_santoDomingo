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
        Schema::table('cajas', function (Blueprint $table) {
            // Responsable asignado al crear la caja (quien debe cerrar y cuadrar)
            $table->unsignedBigInteger('id_responsable')->nullable()->after('nombre');
            $table->foreign('id_responsable')->references('id')->on('users')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('cajas', function (Blueprint $table) {
            $table->dropForeign(['id_responsable']);
            $table->dropColumn('id_responsable');
        });
    }
};
