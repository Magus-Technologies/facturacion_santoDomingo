<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('plantilla_impresion', function (Blueprint $table) {
            $table->id();
            $table->integer('empresa_id');
            $table->longText('mensaje_cabecera')->nullable();
            $table->boolean('cabecera_activo')->default(true);
            $table->longText('mensaje_inferior')->nullable();
            $table->boolean('inferior_activo')->default(true);
            $table->longText('mensaje_despedida')->nullable();
            $table->boolean('despedida_activo')->default(true);
            $table->timestamps();

            $table->unique('empresa_id');
            $table->foreign('empresa_id')
                  ->references('id_empresa')
                  ->on('empresas')
                  ->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('plantilla_impresion');
    }
};
