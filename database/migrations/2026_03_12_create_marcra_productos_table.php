<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('marcra_productos', function (Blueprint $table) {
            $table->string('cod_marca', 50)->primary();
            $table->string('nombre_marca', 255);
            $table->text('descripcion')->nullable();
            $table->string('imagen')->nullable();
            $table->char('estado', 1)->default('1');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('marcra_productos');
    }
};
