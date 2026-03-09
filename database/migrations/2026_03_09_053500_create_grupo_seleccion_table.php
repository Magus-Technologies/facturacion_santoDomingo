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
        Schema::create('grupo_seleccion', function (Blueprint $table) {
            $table->id('id_seleccion');
            $table->string('nombre_cate', 100);
            $table->string('codi_categoria', 50)->nullable();
            $table->string('imagen')->nullable();
            $table->char('estado', 1)->default('1');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('grupo_seleccion');
    }
};
