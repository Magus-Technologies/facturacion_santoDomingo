
SET FOREIGN_KEY_CHECKS = 0;

-- Ventas y relacionadas
TRUNCATE TABLE ventas_anuladas;
TRUNCATE TABLE ventas_pagos;
TRUNCATE TABLE productos_ventas;
TRUNCATE TABLE ventas_servicios;
TRUNCATE TABLE ventas_equipos;
TRUNCATE TABLE ventas_sunat;
TRUNCATE TABLE venta_empresa;
TRUNCATE TABLE dias_ventas;
TRUNCATE TABLE cliente_venta;
TRUNCATE TABLE ventas;

-- Notas de crédito/débito
TRUNCATE TABLE nota_credito;
TRUNCATE TABLE nota_debito;

-- Guías de remisión
TRUNCATE TABLE guia_remision_detalles;
TRUNCATE TABLE guia_remision;

-- Cotizaciones
TRUNCATE TABLE cotizacion_detalles;
TRUNCATE TABLE cotizacion_cuotas;
TRUNCATE TABLE cotizaciones;

-- Compras
TRUNCATE TABLE productos_compras;
TRUNCATE TABLE compra_empresa;
TRUNCATE TABLE dias_compras;
TRUNCATE TABLE compras;

-- Movimientos de stock
TRUNCATE TABLE movimientos_stock;

-- Productos
TRUNCATE TABLE productos;

-- Categorías y unidades (se recrean en la siguiente importación)
TRUNCATE TABLE categorias;
TRUNCATE TABLE unidades;

SET FOREIGN_KEY_CHECKS = 1;
