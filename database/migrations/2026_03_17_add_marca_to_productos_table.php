<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('productos', function (Blueprint $table) {
            // Si la columna marca_id ya existe, no hacer nada
            if (!Schema::hasColumn('productos', 'marca_id')) {
                $table->string('marca_id', 50)->nullable()->after('categoria_id');
                $table->foreign('marca_id')
                    ->references('cod_marca')
                    ->on('marcra_productos')
                    ->onDelete('set null');
            }
        });
    }

    public function down(): void
    {
        Schema::table('productos', function (Blueprint $table) {
            if (Schema::hasColumn('productos', 'marca_id')) {
                $table->dropForeign(['marca_id']);
                $table->dropColumn('marca_id');
            }
        });
    }
};
