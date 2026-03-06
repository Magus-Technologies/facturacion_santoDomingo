<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('titulares_cuenta_bancaria', function (Blueprint $table) {
            $table->bigIncrements('id_titular');
            $table->unsignedBigInteger('id_cuenta');
            $table->string('nombre');
            $table->string('documento_tipo', 3)->default('DNI');
            $table->string('documento_numero')->unique();
            $table->boolean('titular_principal')->default(false);
            $table->timestamps();

            $table->foreign('id_cuenta')->references('id_cuenta')->on('cuentas_bancarias')->cascadeOnDelete();
            $table->index('id_cuenta');
            $table->index('documento_numero');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('titulares_cuenta_bancaria');
    }
};
