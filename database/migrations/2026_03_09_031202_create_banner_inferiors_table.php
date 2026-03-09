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
        Schema::create('banner_inferiors', function (Blueprint $table) {
            $table->id();
            $table->string('url');
            $table->text('imagen')->nullable(); // Ruta del archivo subido
            $table->string('estado')->default('1');
            $table->timestamps();
            
            // Índices
            $table->index('estado');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('banner_inferiors');
    }
};
