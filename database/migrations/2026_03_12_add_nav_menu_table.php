<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('nav_menu', function (Blueprint $table) {
            $table->id();
            $table->string('label', 100);
            $table->string('url', 255)->default('#');
            $table->unsignedBigInteger('parent_id')->nullable();
            $table->integer('orden')->default(0);
            $table->char('estado', 1)->default('1');
            $table->string('target', 10)->default('_self');
            $table->timestamps();

            $table->foreign('parent_id')->references('id')->on('nav_menu')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('nav_menu');
    }
};
