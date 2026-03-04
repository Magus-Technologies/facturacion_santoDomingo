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
        Schema::table('empresas', function (Blueprint $table) {
            $table->string('gre_client_id', 255)->nullable()->after('clave_sol');
            $table->string('gre_client_secret', 255)->nullable()->after('gre_client_id');
        });
    }

    public function down(): void
    {
        Schema::table('empresas', function (Blueprint $table) {
            $table->dropColumn(['gre_client_id', 'gre_client_secret']);
        });
    }
};
