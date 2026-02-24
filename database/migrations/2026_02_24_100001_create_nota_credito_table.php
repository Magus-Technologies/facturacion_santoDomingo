<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('nota_credito', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('id_venta');
            $table->unsignedBigInteger('motivo_id');
            $table->string('serie', 4);
            $table->integer('numero');
            $table->string('tipo_doc_afectado', 2);
            $table->string('serie_num_afectado', 20);
            $table->string('descripcion_motivo')->nullable();
            $table->decimal('monto_subtotal', 12, 2)->default(0);
            $table->decimal('monto_igv', 12, 2)->default(0);
            $table->decimal('monto_total', 12, 2)->default(0);
            $table->string('moneda', 3)->default('PEN');
            $table->date('fecha_emision');
            $table->enum('estado', ['pendiente', 'enviado', 'aceptado', 'rechazado'])->default('pendiente');
            $table->string('hash_cpe', 250)->nullable();
            $table->string('xml_url', 250)->nullable();
            $table->string('cdr_url', 250)->nullable();
            $table->string('codigo_sunat', 10)->nullable();
            $table->string('mensaje_sunat', 250)->nullable();
            $table->string('nombre_xml', 250)->nullable();
            $table->unsignedBigInteger('id_empresa');
            $table->unsignedBigInteger('id_usuario');
            $table->timestamps();

            $table->foreign('id_venta')->references('id_venta')->on('ventas');
            $table->foreign('motivo_id')->references('id')->on('motivo_nota');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('nota_credito');
    }
};
