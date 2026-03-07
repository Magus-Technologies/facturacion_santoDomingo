<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // 1. Cambiar columna almacen de char(1) a int referenciando almacenes.id
        //    Los valores existentes '1' y '2' se convierten naturalmente a int 1 y 2
        // Primero quitar el index existente en almacen si lo hay
        try {
            DB::statement("ALTER TABLE productos DROP INDEX productos_almacen_index");
        } catch (\Exception $e) {
            // Index puede no existir
        }

        DB::statement("ALTER TABLE productos MODIFY COLUMN almacen BIGINT UNSIGNED NOT NULL DEFAULT 1");

        // 2. Agregar FK constraint
        DB::statement("ALTER TABLE productos ADD CONSTRAINT fk_productos_almacen FOREIGN KEY (almacen) REFERENCES almacenes(id)");

        // 3. Actualizar movimientos_stock.id_almacen para que también tenga FK
        DB::statement("ALTER TABLE movimientos_stock MODIFY COLUMN id_almacen BIGINT UNSIGNED NOT NULL DEFAULT 1");
        DB::statement("ALTER TABLE movimientos_stock ADD CONSTRAINT fk_movimientos_stock_almacen FOREIGN KEY (id_almacen) REFERENCES almacenes(id)");

        // 4. Recrear las vistas para que funcionen con la nueva estructura
        DB::statement("DROP VIEW IF EXISTS view_productos_1");
        DB::statement("DROP VIEW IF EXISTS view_productos_2");

        DB::statement("
            CREATE VIEW view_productos_1 AS
            SELECT p.id_producto, p.codigo, p.cod_barra, p.nombre, p.descripcion,
                   p.precio, p.costo, p.precio_mayor, p.precio_menor, p.precio_unidad,
                   p.cantidad, p.stock_minimo, p.stock_maximo, p.id_empresa,
                   p.almacen, p.codsunat, p.usar_barra, p.usar_multiprecio,
                   p.moneda, p.estado, p.imagen, p.ultima_salida,
                   p.fecha_registro, p.fecha_ultimo_ingreso,
                   c.nombre AS categoria, u.nombre AS unidad, u.codigo AS unidad_codigo
            FROM productos p
            LEFT JOIN categorias c ON c.id = p.categoria_id
            LEFT JOIN unidades u ON u.id = p.unidad_id
            WHERE p.almacen = 1 AND p.estado = '1'
            ORDER BY p.id_producto DESC
        ");

        DB::statement("
            CREATE VIEW view_productos_2 AS
            SELECT p.id_producto, p.codigo, p.cod_barra, p.nombre, p.descripcion,
                   p.precio, p.costo, p.precio_mayor, p.precio_menor, p.precio_unidad,
                   p.cantidad, p.stock_minimo, p.stock_maximo, p.id_empresa,
                   p.almacen, p.codsunat, p.usar_barra, p.usar_multiprecio,
                   p.moneda, p.estado, p.imagen, p.ultima_salida,
                   p.fecha_registro, p.fecha_ultimo_ingreso,
                   c.nombre AS categoria, u.nombre AS unidad, u.codigo AS unidad_codigo
            FROM productos p
            LEFT JOIN categorias c ON c.id = p.categoria_id
            LEFT JOIN unidades u ON u.id = p.unidad_id
            WHERE p.almacen = 2 AND p.estado = '1'
            ORDER BY p.id_producto DESC
        ");
    }

    public function down(): void
    {
        DB::statement("ALTER TABLE movimientos_stock DROP FOREIGN KEY fk_movimientos_stock_almacen");
        DB::statement("ALTER TABLE productos DROP FOREIGN KEY fk_productos_almacen");
        DB::statement("ALTER TABLE productos MODIFY COLUMN almacen CHAR(1) DEFAULT '1'");
        DB::statement("ALTER TABLE movimientos_stock MODIFY COLUMN id_almacen INT NULL DEFAULT 1");
    }
};
