<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('permisos_caja', function (Blueprint $table) {
            $table->bigIncrements('id_permiso');
            $table->unsignedBigInteger('id_usuario');
            $table->integer('id_empresa');
            $table->boolean('puede_abrir_caja')->default(false);
            $table->boolean('puede_cerrar_caja')->default(false);
            $table->boolean('puede_autorizar_cierre')->default(false);
            $table->boolean('puede_rechazar_cierre')->default(false);
            $table->boolean('puede_registrar_movimientos')->default(false);
            $table->boolean('puede_ver_reportes')->default(false);
            $table->timestamps();

            $table->foreign('id_usuario')->references('id')->on('users')->cascadeOnDelete();
            $table->foreign('id_empresa')->references('id_empresa')->on('empresas')->cascadeOnDelete();
            $table->unique(['id_usuario', 'id_empresa']);
            $table->index('id_usuario');
            $table->index('id_empresa');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('permisos_caja');
    }
};
