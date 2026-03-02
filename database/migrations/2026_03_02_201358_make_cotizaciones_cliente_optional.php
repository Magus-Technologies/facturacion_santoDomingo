<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('cotizaciones', function (Blueprint $table) {
            // Hacer id_cliente nullable para cotizaciones sin cliente formal
            $table->unsignedBigInteger('id_cliente')->nullable()->change();
            // Almacenar nombre libre del cliente cuando no hay id_cliente
            $table->string('cliente_nombre', 255)->nullable()->after('id_cliente');
        });

        // Actualizar vista para usar LEFT JOIN y mostrar cliente_nombre como fallback
        DB::statement("
            CREATE OR REPLACE VIEW `view_cotizaciones` AS
            SELECT
                c.id,
                c.numero,
                c.fecha,
                c.subtotal,
                c.igv,
                c.total,
                c.descuento,
                c.aplicar_igv,
                c.moneda,
                c.estado,
                c.asunto,
                cl.documento as cliente_documento,
                COALESCE(cl.datos, c.cliente_nombre) as cliente_nombre,
                cl.email as cliente_email,
                cl.telefono as cliente_telefono,
                u.name as vendedor_nombre,
                u.email as vendedor_email,
                c.id_empresa,
                c.id_usuario,
                c.created_at,
                c.updated_at,
                (SELECT COUNT(*) FROM cotizacion_detalles WHERE cotizacion_id = c.id) as total_items
            FROM cotizaciones c
            LEFT JOIN clientes cl ON c.id_cliente = cl.id_cliente
            INNER JOIN users u ON c.id_usuario = u.id
            ORDER BY c.id DESC
        ");
    }

    public function down(): void
    {
        // Restaurar vista original con INNER JOIN
        DB::statement("
            CREATE OR REPLACE VIEW `view_cotizaciones` AS
            SELECT
                c.id,
                c.numero,
                c.fecha,
                c.subtotal,
                c.igv,
                c.total,
                c.descuento,
                c.aplicar_igv,
                c.moneda,
                c.estado,
                c.asunto,
                cl.documento as cliente_documento,
                cl.datos as cliente_nombre,
                cl.email as cliente_email,
                cl.telefono as cliente_telefono,
                u.name as vendedor_nombre,
                u.email as vendedor_email,
                c.id_empresa,
                c.id_usuario,
                c.created_at,
                c.updated_at,
                (SELECT COUNT(*) FROM cotizacion_detalles WHERE cotizacion_id = c.id) as total_items
            FROM cotizaciones c
            INNER JOIN clientes cl ON c.id_cliente = cl.id_cliente
            INNER JOIN users u ON c.id_usuario = u.id
            ORDER BY c.id DESC
        ");

        Schema::table('cotizaciones', function (Blueprint $table) {
            $table->dropColumn('cliente_nombre');
            $table->unsignedBigInteger('id_cliente')->nullable(false)->change();
        });
    }
};
