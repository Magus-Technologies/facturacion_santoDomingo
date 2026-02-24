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
        Schema::create('guia_remision', function (Blueprint $table) {
            $table->id();
            $table->integer('id_empresa');
            $table->unsignedBigInteger('id_usuario');
            $table->unsignedBigInteger('id_venta')->nullable();

            // Documento
            $table->string('serie', 4)->default('T001');
            $table->integer('numero');
            $table->date('fecha_emision');

            // Destinatario
            $table->string('destinatario_tipo_doc', 1)->default('6'); // 6=RUC, 1=DNI
            $table->string('destinatario_documento', 15);
            $table->string('destinatario_nombre');

            // Traslado
            $table->string('motivo_traslado', 2); // Catálogo N° 20
            $table->string('descripcion_motivo')->nullable();
            $table->string('mod_transporte', 2)->default('01'); // Catálogo N° 18: 01=Público, 02=Privado
            $table->date('fecha_traslado');
            $table->decimal('peso_total', 12, 3);
            $table->string('und_peso_total', 3)->default('KGM');

            // Punto partida
            $table->string('ubigeo_partida', 6);
            $table->string('dir_partida');

            // Punto llegada
            $table->string('ubigeo_llegada', 6);
            $table->string('dir_llegada');

            // Transportista (mod_transporte = 01)
            $table->string('transportista_tipo_doc', 1)->nullable();
            $table->string('transportista_documento', 15)->nullable();
            $table->string('transportista_nombre')->nullable();
            $table->string('transportista_nro_mtc', 20)->nullable();

            // Conductor (mod_transporte = 02)
            $table->string('conductor_tipo_doc', 1)->nullable();
            $table->string('conductor_documento', 15)->nullable();
            $table->string('conductor_nombres')->nullable();
            $table->string('conductor_apellidos')->nullable();
            $table->string('conductor_licencia', 20)->nullable();

            // Vehículo
            $table->string('vehiculo_placa', 10)->nullable();

            // Observaciones
            $table->text('observaciones')->nullable();

            // SUNAT
            $table->string('estado', 20)->default('pendiente');
            $table->string('nombre_xml')->nullable();
            $table->string('xml_url')->nullable();
            $table->string('cdr_url')->nullable();
            $table->string('hash_cpe')->nullable();
            $table->string('codigo_sunat', 10)->nullable();
            $table->text('mensaje_sunat')->nullable();
            $table->string('ticket_sunat', 50)->nullable();

            $table->timestamps();

            $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
            $table->foreign('id_usuario')->references('id')->on('users');
            $table->foreign('id_venta')->references('id_venta')->on('ventas')->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('guia_remision');
    }
};
