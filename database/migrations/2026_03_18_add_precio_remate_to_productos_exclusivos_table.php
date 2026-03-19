<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('productos_exclusivos', function (Blueprint $table) {
            $table->decimal('precio_remate', 10, 2)->nullable()->after('imagen');
        });
    }

    public function down(): void
    {
        Schema::table('productos_exclusivos', function (Blueprint $table) {
            $table->dropColumn('precio_remate');
        });
    }
};
