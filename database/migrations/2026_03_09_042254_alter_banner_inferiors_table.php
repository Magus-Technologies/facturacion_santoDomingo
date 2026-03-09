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
        Schema::table('banner_inferiors', function (Blueprint $table) {
            // Cambiar imagen de varchar(255) a text nullable
            $table->text('imagen')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('banner_inferiors', function (Blueprint $table) {
            // Revertir a varchar(255) NOT NULL
            $table->string('imagen')->change();
        });
    }
};
