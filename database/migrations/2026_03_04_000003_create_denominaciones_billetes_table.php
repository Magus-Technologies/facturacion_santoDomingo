<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('denominaciones_billetes', function (Blueprint $table) {
            $table->bigIncrements('id_denominacion');
            $table->string('moneda', 3)->default('PEN');
            $table->decimal('valor', 8, 2);
            $table->string('tipo')->default('Billete');
            $table->boolean('activa')->default(true);
            $table->timestamps();

            $table->unique(['moneda', 'valor']);
            $table->index('moneda');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('denominaciones_billetes');
    }
};
