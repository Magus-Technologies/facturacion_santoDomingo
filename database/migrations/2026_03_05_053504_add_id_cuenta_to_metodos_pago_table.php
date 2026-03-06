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
        Schema::table('metodos_pago', function (Blueprint $table) {
            // Cuenta bancaria destino donde se depositan los pagos de este método
            // null = Efectivo (queda en caja, no va a banco)
            $table->unsignedBigInteger('id_cuenta')->nullable()->after('id_banco');
            $table->foreign('id_cuenta')->references('id_cuenta')->on('cuentas_bancarias')->nullOnDelete();

            // Si el tipo es Efectivo, queda en caja; si no, va al banco
            $table->boolean('es_efectivo')->default(false)->after('id_cuenta')
                ->comment('true = queda en caja física; false = va a cuenta bancaria');
        });
    }

    public function down(): void
    {
        Schema::table('metodos_pago', function (Blueprint $table) {
            $table->dropForeign(['id_cuenta']);
            $table->dropColumn(['id_cuenta', 'es_efectivo']);
        });
    }
};
