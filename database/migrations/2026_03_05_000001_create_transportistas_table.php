<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('transportistas', function (Blueprint $table) {
            $table->id();
            $table->integer('id_empresa');
            $table->char('tipo_documento', 1)->comment('1=DNI, 6=RUC');
            $table->string('numero_documento', 15)->unique();
            $table->string('razon_social', 255);
            $table->string('nombre_comercial', 255)->nullable();
            $table->string('numero_mtc', 20)->nullable()->comment('Número de autorización MTC');
            $table->string('telefono', 20)->nullable();
            $table->string('email', 100)->nullable();
            $table->string('direccion', 255)->nullable();
            $table->boolean('estado')->default(true);
            $table->timestamps();

            $table->foreign('id_empresa')
                ->references('id_empresa')
                ->on('empresas')
                ->onDelete('cascade');

            $table->index('id_empresa');
            $table->index('numero_documento');
            $table->index('estado');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('transportistas');
    }
};
