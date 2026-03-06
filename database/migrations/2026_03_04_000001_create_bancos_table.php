<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('bancos', function (Blueprint $table) {
            $table->bigIncrements('id_banco');
            $table->string('nombre')->unique();
            $table->string('codigo_sunat')->unique()->nullable();
            $table->string('codigo_swift')->nullable();
            $table->string('telefono')->nullable();
            $table->string('email')->nullable();
            $table->string('website')->nullable();
            $table->boolean('activo')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('bancos');
    }
};
