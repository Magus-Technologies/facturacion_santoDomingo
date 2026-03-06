<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('apertura_caja_billetes', function (Blueprint $table) {
            $table->bigIncrements('id_apertura_billete');
            $table->unsignedBigInteger('id_caja');
            $table->unsignedBigInteger('id_denominacion');
            $table->integer('cantidad')->default(0);
            $table->decimal('subtotal', 12, 2);
            $table->timestamps();

            $table->foreign('id_caja')->references('id_caja')->on('cajas')->cascadeOnDelete();
            $table->foreign('id_denominacion')->references('id_denominacion')->on('denominaciones_billetes');
            $table->index('id_caja');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('apertura_caja_billetes');
    }
};
