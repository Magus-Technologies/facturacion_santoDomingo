<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('footer_configs', function (Blueprint $table) {
            $table->id();
            $table->string('slogan', 500)->nullable()->comment('Texto después de "Somos [empresa]"');
            $table->string('subtitulo', 255)->nullable()->comment('Texto debajo del título, ej: Recibe las mejores Ofertas');
            $table->string('boton_texto', 100)->nullable()->default('Suscríbete');
            $table->string('imagen', 500)->nullable()->comment('Imagen decorativa del banner newsletter');
            $table->timestamps();
        });

        // Insertar registro por defecto
        DB::table('footer_configs')->insert([
            'slogan'       => 'VIÑASANTODOMINGO | Somos tu mejor opción en Vino y Pisco',
            'subtitulo'    => 'Recibe las mejores Ofertas SUSCRÍBETE',
            'boton_texto'  => 'Suscríbete',
            'imagen'       => null,
            'created_at'   => now(),
            'updated_at'   => now(),
        ]);
    }

    public function down(): void
    {
        Schema::dropIfExists('footer_configs');
    }
};
