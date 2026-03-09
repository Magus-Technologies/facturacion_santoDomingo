<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('almacenes', function (Blueprint $table) {
            $table->id();
            $table->string('nombre', 100);
            $table->string('descripcion', 255)->nullable();
            $table->unsignedBigInteger('id_padre')->nullable();
            $table->boolean('es_principal')->default(false);
            $table->integer('id_empresa');
            $table->char('estado', 1)->default('1');
            $table->timestamps();

            $table->foreign('id_padre')->references('id')->on('almacenes')->nullOnDelete();
            $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
        });

        // Insertar los 2 almacenes existentes que corresponden a los valores hardcodeados
        DB::table('almacenes')->insert([
            [
                'id'           => 1,
                'nombre'       => 'Principal',
                'descripcion'  => 'Almacén principal de facturación',
                'id_padre'     => null,
                'es_principal' => true,
                'id_empresa'   => 1,
                'estado'       => '1',
                'created_at'   => now(),
                'updated_at'   => now(),
            ],
            [
                'id'           => 2,
                'nombre'       => 'Almacén Real',
                'descripcion'  => 'Almacén físico real',
                'id_padre'     => 1,
                'es_principal' => false,
                'id_empresa'   => 1,
                'estado'       => '1',
                'created_at'   => now(),
                'updated_at'   => now(),
            ],
        ]);
    }

    public function down(): void
    {
        Schema::dropIfExists('almacenes');
    }
};
