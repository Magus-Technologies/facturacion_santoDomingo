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
        Schema::create('guia_remision_detalles', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('id_guia');
            $table->integer('id_producto')->nullable();
            $table->string('codigo', 30)->nullable();
            $table->string('descripcion');
            $table->decimal('cantidad', 12, 3);
            $table->string('unidad', 5)->default('NIU'); // NIU=Unidad, KGM=Kilogramo
            $table->timestamps();

            $table->foreign('id_guia')->references('id')->on('guia_remision')->cascadeOnDelete();
            $table->foreign('id_producto')->references('id_producto')->on('productos')->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('guia_remision_detalles');
    }
};
