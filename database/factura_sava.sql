/*
 Navicat Premium Dump SQL

 Source Server         : facturacionElidesava
 Source Server Type    : MySQL
 Source Server Version : 100529 (10.5.29-MariaDB)
 Source Host           : 213.199.36.204:3306
 Source Schema         : factura_sava

 Target Server Type    : MySQL
 Target Server Version : 100529 (10.5.29-MariaDB)
 File Encoding         : 65001

 Date: 23/02/2026 21:47:14
*/
-- eliminar base de datos y volver a crearla para asegurar que el dump se pueda importar sin errores
DROP DATABASE IF EXISTS `factura_sava`;
CREATE DATABASE `factura_sava` ;
USE  `factura_sava`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cache
-- ----------------------------

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for categorias
-- ----------------------------
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `estado` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categorias
-- ----------------------------
INSERT INTO `categorias` VALUES (1, 'Repuestos', 'Repuestos y piezas', '1', '2026-01-06 13:06:05', '2026-01-06 13:06:05');
INSERT INTO `categorias` VALUES (2, 'Accesorios', 'Accesorios varios', '1', '2026-01-06 13:06:05', '2026-01-06 13:06:05');
INSERT INTO `categorias` VALUES (3, 'Herramientas', 'Herramientas de trabajo', '1', '2026-01-06 13:06:05', '2026-01-06 13:06:05');
INSERT INTO `categorias` VALUES (4, 'Lubricantes', 'Aceites y lubricantes', '1', '2026-01-06 13:06:05', '2026-01-06 13:06:05');
INSERT INTO `categorias` VALUES (5, 'Neuticos', 'Llantas y nticos', '1', '2026-01-06 13:06:05', '2026-01-06 18:57:42');

-- ----------------------------
-- Table structure for cliente_venta
-- ----------------------------
DROP TABLE IF EXISTS `cliente_venta`;
CREATE TABLE `cliente_venta`  (
  `id_cliente_venta` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venta` bigint UNSIGNED NOT NULL,
  `id_cliente` bigint UNSIGNED NOT NULL,
  `tipo_documento` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_documento` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `razon_social` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente_venta`) USING BTREE,
  INDEX `cliente_venta_id_venta_index`(`id_venta` ASC) USING BTREE,
  INDEX `cliente_venta_id_cliente_index`(`id_cliente` ASC) USING BTREE,
  INDEX `cliente_venta_numero_documento_index`(`numero_documento` ASC) USING BTREE,
  CONSTRAINT `cliente_venta_id_venta_foreign` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cliente_venta
-- ----------------------------

-- ----------------------------
-- Table structure for clientes
-- ----------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes`  (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `documento` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'RUC o DNI',
  `datos` varchar(245) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Razón social o nombres',
  `direccion` varchar(245) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `direccion2` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Dirección alternativa',
  `telefono` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `telefono2` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_empresa` int NOT NULL COMMENT 'Empresa a la que pertenece',
  `ultima_venta` datetime NULL DEFAULT NULL,
  `total_venta` decimal(10, 2) NULL DEFAULT 0.00,
  `ubigeo` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `departamento` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `provincia` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `distrito` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`) USING BTREE,
  INDEX `idx_documento`(`documento` ASC) USING BTREE,
  INDEX `idx_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `idx_datos`(`datos` ASC) USING BTREE,
  INDEX `fk_clientes_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `idx_clientes_empresa_documento`(`id_empresa` ASC, `documento` ASC) USING BTREE,
  INDEX `idx_clientes_empresa_datos`(`id_empresa` ASC, `datos` ASC) USING BTREE,
  CONSTRAINT `fk_clientes_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of clientes
-- ----------------------------
INSERT INTO `clientes` VALUES (4, '20608300393', 'COMPAÑIA FOOD RETAIL S.A.C.', 'CAL. CESAR MORELLI NRO. 181 URB. SAN BORJA NORTE LIMA LIMA SAN BORJA', NULL, NULL, NULL, NULL, 1, NULL, 0.00, '15', NULL, NULL, NULL, '2026-01-06 17:25:33', '2026-01-06 17:25:33');
INSERT INTO `clientes` VALUES (5, '77425200', 'EMER RODRIGO YARLEQUE ZAPATA', NULL, NULL, '+51 993 321 920', NULL, 'kiyotakahitori@gmail.com', 1, NULL, 0.00, NULL, NULL, NULL, NULL, '2026-01-06 17:25:53', '2026-01-06 17:25:53');
INSERT INTO `clientes` VALUES (8, '20100128056', 'SAGA FALABELLA S A', 'AV. PASEO DE LA REPUBLICA NRO. 3220 URB. JARDIN LIMA LIMA SAN ISIDRO', NULL, NULL, NULL, NULL, 1, NULL, 0.00, '150131', 'LIMA', 'LIMA', 'SAN ISIDRO', '2026-01-06 17:42:01', '2026-01-06 17:42:01');

-- ----------------------------
-- Table structure for compra_empresa
-- ----------------------------
DROP TABLE IF EXISTS `compra_empresa`;
CREATE TABLE `compra_empresa`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_compra` int UNSIGNED NOT NULL,
  `id_empresa` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of compra_empresa
-- ----------------------------
INSERT INTO `compra_empresa` VALUES (6, 2, 3, '2026-02-06 14:17:07', '2026-02-06 14:17:07');
INSERT INTO `compra_empresa` VALUES (7, 3, 3, '2026-02-06 14:22:58', '2026-02-06 14:22:58');
INSERT INTO `compra_empresa` VALUES (8, 4, 3, '2026-02-06 14:25:11', '2026-02-06 14:25:11');

-- ----------------------------
-- Table structure for compras
-- ----------------------------
DROP TABLE IF EXISTS `compras`;
CREATE TABLE `compras`  (
  `id_compra` int NOT NULL AUTO_INCREMENT,
  `id_tido` int NULL DEFAULT NULL COMMENT 'Tipo de documento (12=Orden de Compra, etc)',
  `serie` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `numero` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_proveedor` int NULL DEFAULT NULL,
  `proveedor_id` int NULL DEFAULT NULL COMMENT 'Alias para compatibilidad',
  `fecha_emision` date NULL DEFAULT NULL,
  `fecha_vencimiento` date NULL DEFAULT NULL,
  `dias_pagos` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_tipo_pago` int NULL DEFAULT NULL COMMENT '1=Contado, 2=Crédito',
  `moneda` enum('PEN','USD') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'PEN',
  `subtotal` decimal(10, 2) NULL DEFAULT 0.00,
  `igv` decimal(10, 2) NULL DEFAULT 0.00,
  `total` decimal(10, 2) NULL DEFAULT 0.00,
  `direccion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `id_empresa` int NOT NULL,
  `id_usuario` int NULL DEFAULT NULL,
  `sucursal` int NULL DEFAULT 1,
  `estado` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1' COMMENT '1=Activo, 0=Anulado',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_compra`) USING BTREE,
  INDEX `idx_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `idx_proveedor`(`id_proveedor` ASC) USING BTREE,
  INDEX `idx_proveedor_id`(`proveedor_id` ASC) USING BTREE,
  INDEX `idx_fecha_emision`(`fecha_emision` ASC) USING BTREE,
  INDEX `idx_estado`(`estado` ASC) USING BTREE,
  INDEX `idx_serie_numero`(`serie` ASC, `numero` ASC) USING BTREE,
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`proveedor_id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `compras_ibfk_3` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`proveedor_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of compras
-- ----------------------------
INSERT INTO `compras` VALUES (1, 12, 'OC', '00000001', 2, 2, '2026-01-08', '2026-01-08', NULL, 1, 'PEN', 908.00, 0.00, 908.00, 'Jr. Comercio 456', '', 1, 2, 1, '1', '2026-01-08 23:30:01', '2026-01-08 23:30:01');
INSERT INTO `compras` VALUES (2, 12, 'OC', '00000002', 4, 4, '2026-02-06', '2026-02-06', NULL, 1, 'PEN', 928.00, 0.00, 928.00, 'CAL. CESAR MORELLI NRO. 181 URB. SAN BORJA NORTE LIMA LIMA SAN BORJA', '', 1, 2, 1, '1', '2026-02-06 14:17:07', '2026-02-06 14:17:07');
INSERT INTO `compras` VALUES (3, 12, 'OC', '00000003', 4, 4, '2026-02-06', '2026-02-06', NULL, 1, 'PEN', 23.00, 0.00, 23.00, 'CAL. CESAR MORELLI NRO. 181 URB. SAN BORJA NORTE LIMA LIMA SAN BORJA', '', 1, 2, 1, '1', '2026-02-06 14:22:58', '2026-02-06 14:22:58');
INSERT INTO `compras` VALUES (4, 12, 'OC', '00000004', 4, 4, '2026-02-06', '2026-02-06', NULL, 1, 'PEN', 23.00, 0.00, 23.00, 'CAL. CESAR MORELLI NRO. 181 URB. SAN BORJA NORTE LIMA LIMA SAN BORJA', '', 1, 2, 1, '1', '2026-02-06 14:25:11', '2026-02-06 14:25:11');

-- ----------------------------
-- Table structure for cotizacion_cuotas
-- ----------------------------
DROP TABLE IF EXISTS `cotizacion_cuotas`;
CREATE TABLE `cotizacion_cuotas`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `cotizacion_id` bigint UNSIGNED NOT NULL,
  `numero_cuota` int NOT NULL,
  `monto` decimal(10, 2) NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `tipo` enum('inicial','cuota') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'cuota',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_cotizacion`(`cotizacion_id` ASC) USING BTREE,
  CONSTRAINT `fk_cotizacion_cuotas_cotizacion` FOREIGN KEY (`cotizacion_id`) REFERENCES `cotizaciones` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cotizacion_cuotas
-- ----------------------------

-- ----------------------------
-- Table structure for cotizacion_detalles
-- ----------------------------
DROP TABLE IF EXISTS `cotizacion_detalles`;
CREATE TABLE `cotizacion_detalles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `cotizacion_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `codigo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cantidad` decimal(10, 2) NOT NULL,
  `precio_unitario` decimal(10, 5) NOT NULL,
  `precio_especial` decimal(10, 2) NULL DEFAULT NULL COMMENT 'Precio con descuento especial',
  `subtotal` decimal(10, 2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_cotizacion`(`cotizacion_id` ASC) USING BTREE,
  INDEX `idx_producto`(`producto_id` ASC) USING BTREE,
  CONSTRAINT `fk_cotizacion_detalles_cotizacion` FOREIGN KEY (`cotizacion_id`) REFERENCES `cotizaciones` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cotizacion_detalles
-- ----------------------------
INSERT INTO `cotizacion_detalles` VALUES (1, 4, 920, 'JVC-073', 'MOTOSIERRA INDUSTRIAL CON ESPADA DE 20\" - MARCA: NEWTOP - MODELO: NT5800', 'MOTOSIERRA INDUSTRIAL CON ESPADA DE 20\" - MARCA: NEWTOP - MODELO: NT5800', 1.00, 1700.00000, NULL, 1700.00, '2026-02-19 15:45:57');

-- ----------------------------
-- Table structure for cotizaciones
-- ----------------------------
DROP TABLE IF EXISTS `cotizaciones`;
CREATE TABLE `cotizaciones`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `numero` int NULL DEFAULT NULL COMMENT 'Número correlativo de cotización',
  `fecha` date NOT NULL,
  `id_cliente` bigint UNSIGNED NOT NULL,
  `direccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Dirección de entrega',
  `subtotal` decimal(10, 2) NULL DEFAULT 0.00,
  `igv` decimal(10, 2) NULL DEFAULT 0.00,
  `total` decimal(10, 2) NULL DEFAULT 0.00,
  `descuento` decimal(10, 2) NULL DEFAULT 0.00,
  `aplicar_igv` tinyint(1) NULL DEFAULT 1 COMMENT '1=Con IGV, 0=Sin IGV',
  `moneda` enum('PEN','USD') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'PEN',
  `tipo_cambio` decimal(10, 4) NULL DEFAULT NULL,
  `dias_pago` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Condiciones de pago',
  `asunto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `estado` enum('pendiente','aprobada','rechazada','vencida') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'pendiente',
  `id_empresa` bigint UNSIGNED NOT NULL,
  `id_usuario` bigint UNSIGNED NOT NULL COMMENT 'Vendedor que creó la cotización',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_cliente`(`id_cliente` ASC) USING BTREE,
  INDEX `idx_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `idx_usuario`(`id_usuario` ASC) USING BTREE,
  INDEX `idx_fecha`(`fecha` ASC) USING BTREE,
  INDEX `idx_estado`(`estado` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cotizaciones
-- ----------------------------
INSERT INTO `cotizaciones` VALUES (1, 1, '2026-01-06', 1, NULL, 1000.00, 180.00, 1180.00, 0.00, 1, 'PEN', NULL, NULL, NULL, NULL, 'pendiente', 1, 1, '2026-01-06 14:31:16', '2026-01-06 14:31:16');
INSERT INTO `cotizaciones` VALUES (2, 2, '2026-01-06', 2, NULL, 500.00, 90.00, 590.00, 0.00, 1, 'PEN', NULL, NULL, NULL, NULL, 'aprobada', 1, 1, '2026-01-06 14:31:16', '2026-01-06 14:31:16');
INSERT INTO `cotizaciones` VALUES (4, 3, '2026-02-19', 5, NULL, 1700.00, 306.00, 2006.00, 0.00, 1, 'PEN', 1.0000, NULL, NULL, NULL, 'pendiente', 1, 2, '2026-02-19 14:45:57', '2026-02-19 14:45:57');

-- ----------------------------
-- Table structure for dias_compras
-- ----------------------------
DROP TABLE IF EXISTS `dias_compras`;
CREATE TABLE `dias_compras`  (
  `dias_compra_id` int NOT NULL AUTO_INCREMENT,
  `id_compra` int NOT NULL,
  `monto` decimal(10, 3) NOT NULL,
  `fecha` date NOT NULL COMMENT 'Fecha de vencimiento del pago',
  `estado` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1' COMMENT '1=Pendiente, 0=Pagado',
  `fecha_pago` date NULL DEFAULT NULL COMMENT 'Fecha en que se realizó el pago',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`dias_compra_id`) USING BTREE,
  INDEX `idx_compra`(`id_compra` ASC) USING BTREE,
  INDEX `idx_fecha`(`fecha` ASC) USING BTREE,
  INDEX `idx_estado`(`estado` ASC) USING BTREE,
  CONSTRAINT `dias_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dias_compras
-- ----------------------------

-- ----------------------------
-- Table structure for dias_ventas
-- ----------------------------
DROP TABLE IF EXISTS `dias_ventas`;
CREATE TABLE `dias_ventas`  (
  `id_dia_venta` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venta` bigint UNSIGNED NOT NULL,
  `numero_cuota` int NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `monto_cuota` decimal(10, 2) NOT NULL,
  `monto_pagado` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `saldo` decimal(10, 2) NOT NULL,
  `estado` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'P',
  `fecha_pago` date NULL DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_dia_venta`) USING BTREE,
  INDEX `dias_ventas_id_venta_index`(`id_venta` ASC) USING BTREE,
  INDEX `dias_ventas_fecha_vencimiento_index`(`fecha_vencimiento` ASC) USING BTREE,
  INDEX `dias_ventas_estado_index`(`estado` ASC) USING BTREE,
  CONSTRAINT `dias_ventas_id_venta_foreign` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dias_ventas
-- ----------------------------

-- ----------------------------
-- Table structure for documentos_empresas
-- ----------------------------
DROP TABLE IF EXISTS `documentos_empresas`;
CREATE TABLE `documentos_empresas`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `id_tido` int NOT NULL COMMENT 'Tipo de documento',
  `sucursal` int NULL DEFAULT 1,
  `serie` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Serie del documento (F001, B001, etc)',
  `numero` int NOT NULL DEFAULT 1 COMMENT 'Último número usado',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_empresa_tido_serie`(`id_empresa` ASC, `id_tido` ASC, `serie` ASC, `sucursal` ASC) USING BTREE,
  INDEX `idx_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `idx_tido`(`id_tido` ASC) USING BTREE,
  INDEX `fk_documentos_empresas_tido`(`id_tido` ASC) USING BTREE,
  CONSTRAINT `fk_documentos_empresas_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_documentos_empresas_tido` FOREIGN KEY (`id_tido`) REFERENCES `documentos_sunat` (`id_tido`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of documentos_empresas
-- ----------------------------
INSERT INTO `documentos_empresas` VALUES (1, 1, 1, 1, 'B001', 1, NULL, NULL);
INSERT INTO `documentos_empresas` VALUES (2, 1, 2, 1, 'F001', 1, NULL, NULL);
INSERT INTO `documentos_empresas` VALUES (3, 1, 3, 1, 'BC01', 1, NULL, NULL);
INSERT INTO `documentos_empresas` VALUES (4, 1, 3, 1, 'FC01', 1, NULL, NULL);
INSERT INTO `documentos_empresas` VALUES (5, 1, 11, 1, 'T001', 1, NULL, NULL);

-- ----------------------------
-- Table structure for documentos_sunat
-- ----------------------------
DROP TABLE IF EXISTS `documentos_sunat`;
CREATE TABLE `documentos_sunat`  (
  `id_tido` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cod_sunat` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Código SUNAT',
  `abreviatura` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_tido`) USING BTREE,
  INDEX `idx_cod_sunat`(`cod_sunat` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of documentos_sunat
-- ----------------------------
INSERT INTO `documentos_sunat` VALUES (1, 'BOLETA DE VENTA', '03', 'BT', NULL, NULL);
INSERT INTO `documentos_sunat` VALUES (2, 'FACTURA', '01', 'FT', NULL, NULL);
INSERT INTO `documentos_sunat` VALUES (3, 'NOTA DE CREDITO', '07', 'NC', NULL, NULL);
INSERT INTO `documentos_sunat` VALUES (4, 'NOTA DE DEBITO', '08', 'ND', NULL, NULL);
INSERT INTO `documentos_sunat` VALUES (5, 'NOTA DE RECEPCION', '09', 'GR', NULL, NULL);
INSERT INTO `documentos_sunat` VALUES (6, 'NOTA DE VENTA', '00', 'NV', NULL, NULL);
INSERT INTO `documentos_sunat` VALUES (7, 'NOTA DE SEPARACION', '00', 'NS', NULL, NULL);
INSERT INTO `documentos_sunat` VALUES (8, 'NOTA DE TRASLADO', '00', 'NT', NULL, NULL);
INSERT INTO `documentos_sunat` VALUES (9, 'NOTA DE INVENTARIO', '00', 'NIV', NULL, NULL);
INSERT INTO `documentos_sunat` VALUES (10, 'NOTA DE INGRESO', '00', 'NIG', NULL, NULL);
INSERT INTO `documentos_sunat` VALUES (11, 'GUIA DE REMISION', '09', 'GR', NULL, NULL);
INSERT INTO `documentos_sunat` VALUES (12, 'NOTA DE COMPRA', '00', 'NC', NULL, NULL);

-- ----------------------------
-- Table structure for empresas
-- ----------------------------
DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas`  (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `ruc` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `razon_social` varchar(245) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comercial` varchar(245) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre comercial',
  `cod_sucursal` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `direccion` varchar(245) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(145) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `telefono` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `telefono2` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `telefono3` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Activo, 0=Inactivo',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Certificado digital',
  `user_sol` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Usuario SOL SUNAT',
  `clave_sol` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Clave SOL SUNAT',
  `logo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ubigeo` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `distrito` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `provincia` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `departamento` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tipo_impresion` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Tipo de impresión de documentos',
  `modo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'production' COMMENT 'production o beta',
  `igv` decimal(10, 2) NOT NULL DEFAULT 0.18 COMMENT 'Porcentaje de IGV',
  `propaganda` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_empresa`) USING BTREE,
  UNIQUE INDEX `uk_ruc`(`ruc` ASC) USING BTREE,
  INDEX `idx_estado`(`estado` ASC) USING BTREE,
  INDEX `idx_razon_social`(`razon_social` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of empresas
-- ----------------------------
INSERT INTO `empresas` VALUES (1, '20612058424', 'ARIES D & M SOCIEDAD ANONIMA CERRADA', 'ARIES D & M SOCIEDAD ANONIMA CERRADA', NULL, 'JR. ANDAHUAYLAS NRO. 1049 INT. 109S URB. BARRIOS ALTOS LIMA LIMA LIMA', 'contacto@ilidesava.com', '054-123456', NULL, NULL, '1', NULL, 'MODDATOS', 'MODDATOS', 'empresasLogos/logo_20123456789_1768837518.png', '150101', 'LIMA', 'LIMA', 'LIMA', NULL, 'production', 0.18, NULL, NULL, '2026-02-23 04:03:06');
INSERT INTO `empresas` VALUES (2, '20511598452', 'ILIDESAVA & DESAVA SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA - ILIDESAVA & DESAVA S.R.L.', 'ILIDESAVA & DESAVA SOCIEDAD COMERCIAL DE RESPONSABILIDAD LIMITADA - ILIDESAVA & DESAVA S.R.L.', NULL, 'JR. CANGALLO NRO. 253 LIMA LIMA LIMA', 'contacto@ilidesava.com', '987654321', NULL, NULL, '1', NULL, NULL, NULL, 'empresasLogos/logo_20608300393_1768837504.png', '150101', 'LIMA', 'LIMA', 'LIMA', NULL, 'production', 0.18, NULL, NULL, '2026-02-23 04:02:53');
INSERT INTO `empresas` VALUES (3, '20987654321', 'DISTRIBUIDORA NORTE E.I.R.L.', 'DISNORTE', NULL, 'JR. UNION NRO. 567', 'info@disnorte.com', '987654323', NULL, NULL, '1', NULL, NULL, NULL, 'empresasLogos/logo_20987654321_1768837492.jpeg', '150101', 'LIMA', 'LIMA', 'LIMA', NULL, 'production', 0.18, NULL, NULL, '2026-02-23 04:02:39');

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cancelled_at` int NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of job_batches
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED NULL DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- ----------------------------
-- Tabla migrations será creada automáticamente por Laravel
-- ----------------------------

-- ----------------------------
-- Table structure for movimientos_stock
-- ----------------------------
DROP TABLE IF EXISTS `movimientos_stock`;
CREATE TABLE `movimientos_stock`  (
  `id_movimiento` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `tipo_movimiento` enum('entrada','salida','ajuste','devolucion') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` decimal(10, 2) NOT NULL,
  `stock_anterior` decimal(10, 2) NOT NULL,
  `stock_nuevo` decimal(10, 2) NOT NULL,
  `tipo_documento` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'compra, venta, ajuste, etc',
  `id_documento` int NULL DEFAULT NULL COMMENT 'ID de la compra, venta, etc',
  `documento_referencia` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Serie-Número del documento',
  `motivo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `id_almacen` int NULL DEFAULT 1,
  `id_empresa` int NOT NULL,
  `id_usuario` int NULL DEFAULT NULL,
  `fecha_movimiento` datetime NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_movimiento`) USING BTREE,
  INDEX `idx_producto`(`id_producto` ASC) USING BTREE,
  INDEX `idx_tipo_movimiento`(`tipo_movimiento` ASC) USING BTREE,
  INDEX `idx_fecha`(`fecha_movimiento` ASC) USING BTREE,
  INDEX `idx_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `idx_documento`(`tipo_documento` ASC, `id_documento` ASC) USING BTREE,
  CONSTRAINT `movimientos_stock_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `movimientos_stock_ibfk_2` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movimientos_stock
-- ----------------------------

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token` ASC) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type` ASC, `tokenable_id` ASC) USING BTREE,
  INDEX `personal_access_tokens_expires_at_index`(`expires_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------
INSERT INTO `personal_access_tokens` VALUES (1, 'App\\Models\\User', 2, 'auth_token', 'a984a3ab9a638cf574dc111de32ec648383b9f5f1c1174464a5b465e1a937a5d', '[\"*\"]', '2026-01-06 17:13:16', '2026-01-06 21:13:26', '2026-01-06 13:13:26', '2026-01-06 17:13:16');
INSERT INTO `personal_access_tokens` VALUES (2, 'App\\Models\\User', 2, 'auth_token', 'efc45731371ea9c9d61b3fdc2186c6ab2d40736897b6b4257abb92c52866313b', '[\"*\"]', '2026-01-06 16:07:41', '2026-01-06 21:43:26', '2026-01-06 13:43:26', '2026-01-06 16:07:41');
INSERT INTO `personal_access_tokens` VALUES (6, 'App\\Models\\User', 2, 'auth_token', 'a2ef192e6ac09942e50fba12eeda16e073f4a105bcb8a2d26363f7a081507938', '[\"*\"]', '2026-01-06 19:56:33', '2026-01-07 02:51:01', '2026-01-06 18:51:01', '2026-01-06 19:56:33');
INSERT INTO `personal_access_tokens` VALUES (7, 'App\\Models\\User', 2, 'auth_token', '7f2712887842b4ca3376c1f2894197d25565099afbea44ae3ff5a9142fb2a77f', '[\"*\"]', '2026-01-07 04:30:09', '2026-01-07 06:15:33', '2026-01-06 22:15:33', '2026-01-07 04:30:09');
INSERT INTO `personal_access_tokens` VALUES (8, 'App\\Models\\User', 2, 'auth_token', '1a1e139367acb611e9e8eee3b2782c97604d15a81d80f5f2b011cc6a478ef64c', '[\"*\"]', '2026-01-07 18:08:32', '2026-01-07 23:59:51', '2026-01-07 15:59:51', '2026-01-07 18:08:32');
INSERT INTO `personal_access_tokens` VALUES (9, 'App\\Models\\User', 2, 'auth_token', 'a3de1c7a764f39f7d51010181494856e3a63d04428205662c25b2e47f4f1c048', '[\"*\"]', '2026-01-07 19:36:41', '2026-01-08 03:36:26', '2026-01-07 19:36:26', '2026-01-07 19:36:41');
INSERT INTO `personal_access_tokens` VALUES (10, 'App\\Models\\User', 2, 'auth_token', 'c966848dfbf1b50a9c00d16f8b3627c6a049aa06853173a767011c51d4b0ed98', '[\"*\"]', '2026-01-07 19:50:29', '2026-01-08 03:37:25', '2026-01-07 19:37:25', '2026-01-07 19:50:29');
INSERT INTO `personal_access_tokens` VALUES (11, 'App\\Models\\User', 2, 'auth_token', '1ba667a99a89ee3bceee9541f536b3eeb9ae2ee74a72a91d8aa9392093a4a652', '[\"*\"]', '2026-01-07 19:43:25', '2026-01-08 03:40:54', '2026-01-07 19:40:54', '2026-01-07 19:43:25');
INSERT INTO `personal_access_tokens` VALUES (12, 'App\\Models\\User', 2, 'auth_token', '8947863a60bf922b5b9f7adbc77dc639db45e391f7b644c9f79b587f966e9a3c', '[\"*\"]', '2026-01-07 19:49:19', '2026-01-08 03:48:35', '2026-01-07 19:48:35', '2026-01-07 19:49:19');
INSERT INTO `personal_access_tokens` VALUES (13, 'App\\Models\\User', 2, 'auth_token', '93afd33f03f30692edf571eca90605a141f427f4f3d9738e44de16a717f147be', '[\"*\"]', '2026-01-08 20:50:23', '2026-01-08 20:51:37', '2026-01-08 12:51:37', '2026-01-08 20:50:23');
INSERT INTO `personal_access_tokens` VALUES (14, 'App\\Models\\User', 2, 'auth_token', '12f760e0cd3eb24bfbac769901297da96b9ea3ec3b9cdf7f63b8749f787b67fd', '[\"*\"]', '2026-01-09 02:37:52', '2026-01-09 07:26:42', '2026-01-08 23:26:42', '2026-01-09 02:37:52');
INSERT INTO `personal_access_tokens` VALUES (15, 'App\\Models\\User', 2, 'auth_token', '55cd2b1d3a71daa9ab123bda84f94d74bef017f003606e5b2926de942718a130', '[\"*\"]', '2026-01-09 14:00:02', '2026-01-09 21:59:00', '2026-01-09 13:59:00', '2026-01-09 14:00:02');
INSERT INTO `personal_access_tokens` VALUES (16, 'App\\Models\\User', 2, 'auth_token', '1c34788682832c8055aea8c66f3f5c794de0d546865fd7270d1f036016e34749', '[\"*\"]', '2026-01-10 17:38:55', '2026-01-11 00:37:43', '2026-01-10 16:37:43', '2026-01-10 17:38:55');
INSERT INTO `personal_access_tokens` VALUES (17, 'App\\Models\\User', 2, 'auth_token', 'b65bce2dc7f5dfd3b8df4b4f37c4d024b6ddc944cc06237b6cd9323aaeadad46', '[\"*\"]', '2026-01-10 16:42:45', '2026-01-11 00:39:21', '2026-01-10 16:39:21', '2026-01-10 16:42:45');
INSERT INTO `personal_access_tokens` VALUES (18, 'App\\Models\\User', 2, 'auth_token', 'fffd9f90ff65e4c269237ce8b00bbaa914eca3f91dff6349647c825dc16596b1', '[\"*\"]', '2026-01-10 16:54:29', '2026-01-11 00:49:53', '2026-01-10 16:49:53', '2026-01-10 16:54:29');
INSERT INTO `personal_access_tokens` VALUES (19, 'App\\Models\\User', 2, 'auth_token', 'f4bd9d04427371ef32262393be89607a6c03f5c477a43e4f420efcd4734ace4f', '[\"*\"]', '2026-01-10 17:39:44', '2026-01-11 00:54:44', '2026-01-10 16:54:44', '2026-01-10 17:39:44');
INSERT INTO `personal_access_tokens` VALUES (20, 'App\\Models\\User', 2, 'auth_token', 'a5f18262a31d3d93619448d3b81b10f5a86ea95b9f86b2424dc8ba19bdb6d8d9', '[\"*\"]', '2026-01-12 14:32:11', '2026-01-12 22:23:19', '2026-01-12 14:23:19', '2026-01-12 14:32:11');
INSERT INTO `personal_access_tokens` VALUES (21, 'App\\Models\\User', 2, 'auth_token', '519b3355a199e4136c90ce2b3255ee122a5ca0f2c2e2ccb34fa74760fb790c9a', '[\"*\"]', '2026-01-13 00:24:20', '2026-01-13 08:22:57', '2026-01-13 00:22:57', '2026-01-13 00:24:20');
INSERT INTO `personal_access_tokens` VALUES (22, 'App\\Models\\User', 2, 'auth_token', '7c6cd01411f4e25b48a87044df747ee3b6cdbf6664e6ebb675be324140e658dc', '[\"*\"]', '2026-01-13 15:27:40', '2026-01-13 23:04:29', '2026-01-13 15:04:29', '2026-01-13 15:27:40');
INSERT INTO `personal_access_tokens` VALUES (24, 'App\\Models\\User', 2, 'auth_token', '9eaf88a79b41f925572dfa303c81494c05d6cf407a6c411efc645063f46588c0', '[\"*\"]', '2026-01-14 15:13:23', '2026-01-14 23:13:22', '2026-01-14 15:13:22', '2026-01-14 15:13:23');
INSERT INTO `personal_access_tokens` VALUES (25, 'App\\Models\\User', 2, 'auth_token', '5942b9b4bcbafa01697af2a51fdfeb31a3700b2b8148bed81be6a826e0664aa1', '[\"*\"]', '2026-01-17 01:03:22', '2026-01-17 09:03:04', '2026-01-17 01:03:04', '2026-01-17 01:03:22');
INSERT INTO `personal_access_tokens` VALUES (26, 'App\\Models\\User', 2, 'auth_token', '086286d64e751dc4abf876a505e127238d7dc2a98b40a9670cf400dbe71c6896', '[\"*\"]', '2026-01-17 23:04:13', '2026-01-18 06:15:51', '2026-01-17 22:15:51', '2026-01-17 23:04:13');
INSERT INTO `personal_access_tokens` VALUES (27, 'App\\Models\\User', 2, 'auth_token', '8d5737152ee4988edd281460cd67bce0898a8837fdb060a21c23046a76a0914f', '[\"*\"]', '2026-01-19 19:14:51', '2026-01-19 20:22:28', '2026-01-19 12:22:28', '2026-01-19 19:14:51');
INSERT INTO `personal_access_tokens` VALUES (28, 'App\\Models\\User', 2, 'auth_token', '9da77d438113ffcd73594c3229055a5eafa896439b553e9ebaedb3b911292083', '[\"*\"]', '2026-01-19 22:20:54', '2026-01-20 06:17:39', '2026-01-19 22:17:39', '2026-01-19 22:20:54');
INSERT INTO `personal_access_tokens` VALUES (29, 'App\\Models\\User', 2, 'auth_token', '23f6a54da02b05c374584b88caba0fdbead3b23cdb868612c2039bf5ac264eae', '[\"*\"]', '2026-01-20 18:52:16', '2026-01-20 20:49:34', '2026-01-20 12:49:34', '2026-01-20 18:52:16');
INSERT INTO `personal_access_tokens` VALUES (30, 'App\\Models\\User', 2, 'auth_token', '45626156ac0c39ef7f666d95fb3e0ebf592f9aac9f0e6b2e39ec225b2636a440', '[\"*\"]', '2026-01-20 22:42:39', '2026-01-21 05:56:06', '2026-01-20 21:56:06', '2026-01-20 22:42:39');
INSERT INTO `personal_access_tokens` VALUES (31, 'App\\Models\\User', 2, 'auth_token', '0e57b50891b4ddc4f6eae57a455a56e3d336f1423471717688e65a4ac1f46aec', '[\"*\"]', '2026-01-22 14:32:31', '2026-01-22 22:30:53', '2026-01-22 14:30:53', '2026-01-22 14:32:31');
INSERT INTO `personal_access_tokens` VALUES (32, 'App\\Models\\User', 2, 'auth_token', '9e3c9de3e628d11e63b533de6e1dff4d50fbfecf873e6c3d5ca6968f57f9b43b', '[\"*\"]', '2026-01-23 16:31:55', '2026-01-24 00:31:29', '2026-01-23 16:31:29', '2026-01-23 16:31:55');
INSERT INTO `personal_access_tokens` VALUES (33, 'App\\Models\\User', 2, 'auth_token', '6335d280a05a525b2ee9d6b1e331b6ae458d922b06dc8b927b974ebf74c1c8cb', '[\"*\"]', '2026-01-25 23:04:46', '2026-01-26 07:04:40', '2026-01-25 23:04:40', '2026-01-25 23:04:46');
INSERT INTO `personal_access_tokens` VALUES (34, 'App\\Models\\User', 2, 'auth_token', 'dbde9ae7707ba1d8b9975c7548eb6b512e20ad757dae407cabb2e990d8c521eb', '[\"*\"]', '2026-01-27 18:54:59', '2026-01-28 02:54:58', '2026-01-27 18:54:58', '2026-01-27 18:54:59');
INSERT INTO `personal_access_tokens` VALUES (35, 'App\\Models\\User', 2, 'auth_token', '6960847f7b5579f5a0fa8148fdef8fbc1be60acdfe9ba70fa3b5cf5189f713c1', '[\"*\"]', '2026-01-27 19:07:33', '2026-01-28 02:56:20', '2026-01-27 18:56:20', '2026-01-27 19:07:33');
INSERT INTO `personal_access_tokens` VALUES (36, 'App\\Models\\User', 2, 'auth_token', '4e83243d3d8523724ee9391195ee51b121238f4d977d303052a79604a46340ad', '[\"*\"]', '2026-01-27 18:56:33', '2026-01-28 02:56:26', '2026-01-27 18:56:26', '2026-01-27 18:56:33');
INSERT INTO `personal_access_tokens` VALUES (37, 'App\\Models\\User', 2, 'auth_token', 'd83b5e46f48d93f116fa56b5d52b75167ba241dda6ee5c0de522fff7bf7660bd', '[\"*\"]', '2026-01-29 15:06:58', '2026-01-29 22:59:49', '2026-01-29 14:59:49', '2026-01-29 15:06:58');
INSERT INTO `personal_access_tokens` VALUES (38, 'App\\Models\\User', 2, 'auth_token', '11b15355127d3ea95bfad5ddc480fddf752396036a04aed42282c5177a025545', '[\"*\"]', '2026-02-05 22:38:25', '2026-02-06 06:34:49', '2026-02-05 22:34:49', '2026-02-05 22:38:25');
INSERT INTO `personal_access_tokens` VALUES (39, 'App\\Models\\User', 2, 'auth_token', '1d18542586be19eb9f31a5825e5eeba579295a564da3ac778cc2181c1dfda8c7', '[\"*\"]', '2026-02-06 14:52:17', '2026-02-06 22:11:40', '2026-02-06 14:11:40', '2026-02-06 14:52:17');
INSERT INTO `personal_access_tokens` VALUES (40, 'App\\Models\\User', 2, 'auth_token', 'cdeb1b4f3f7044c86d50b10d56c8aaa429f2d4d249bc0e1628423f9e1784cfe8', '[\"*\"]', '2026-02-06 14:29:15', '2026-02-06 22:19:19', '2026-02-06 14:19:19', '2026-02-06 14:29:15');
INSERT INTO `personal_access_tokens` VALUES (41, 'App\\Models\\User', 2, 'auth_token', '7b8c478467e124895967cecb963ceea29ffe88a8203b6804002006f07a54c8be', '[\"*\"]', '2026-02-06 16:10:34', '2026-02-07 00:02:58', '2026-02-06 16:02:58', '2026-02-06 16:10:34');
INSERT INTO `personal_access_tokens` VALUES (42, 'App\\Models\\User', 2, 'auth_token', '22a32a65c606a7edb13884363036f2f55a037dd7a73094a94b8574c570b7a94d', '[\"*\"]', '2026-02-06 16:07:31', '2026-02-07 00:07:07', '2026-02-06 16:07:07', '2026-02-06 16:07:31');
INSERT INTO `personal_access_tokens` VALUES (44, 'App\\Models\\User', 2, 'auth_token', '7d6fb2301f6fe7ebced6822fd1b8c98820c1d54db3dfd311c42ab312dd8026ea', '[\"*\"]', '2026-02-11 18:39:50', '2026-02-12 02:39:35', '2026-02-11 18:39:35', '2026-02-11 18:39:50');
INSERT INTO `personal_access_tokens` VALUES (45, 'App\\Models\\User', 2, 'auth_token', 'adef4ea3bf9ea2360e9d54f2054b0f4cd47eb907b6b3f46214a18e818119ff9d', '[\"*\"]', '2026-02-18 21:14:44', '2026-02-19 05:14:05', '2026-02-18 21:14:05', '2026-02-18 21:14:44');
INSERT INTO `personal_access_tokens` VALUES (46, 'App\\Models\\User', 2, 'auth_token', 'f480e62011c7c5af16c73584f10f42aebaff79527b16133cf69e0661a4c29603', '[\"*\"]', '2026-02-19 20:35:00', '2026-02-19 21:59:39', '2026-02-19 13:59:39', '2026-02-19 20:35:00');
INSERT INTO `personal_access_tokens` VALUES (47, 'App\\Models\\User', 2, 'auth_token', '50263f422b12f042efe07dbec5d1a32cf853ffdc878bd2239b18eb01161bdd35', '[\"*\"]', NULL, '2026-02-19 22:18:15', '2026-02-19 14:18:15', '2026-02-19 14:18:15');
INSERT INTO `personal_access_tokens` VALUES (48, 'App\\Models\\User', 2, 'auth_token', '7d01d9fd47897b7c4201b7936636ca86d9eb9bc8600c10b63c0fbc4f52cda5c4', '[\"*\"]', NULL, '2026-02-19 23:45:27', '2026-02-19 15:45:27', '2026-02-19 15:45:27');
INSERT INTO `personal_access_tokens` VALUES (49, 'App\\Models\\User', 2, 'auth_token', '6bb9747faea3c2ade8c743aab82bf9e68a0889b7677673c5fcff80578694e5f3', '[\"*\"]', NULL, '2026-02-23 11:59:58', '2026-02-23 03:59:58', '2026-02-23 03:59:58');
INSERT INTO `personal_access_tokens` VALUES (50, 'App\\Models\\User', 2, 'auth_token', 'ffe3efaebe71b688dc6a8c7afb21ab734bc9e230d99aa787c3212c859fe006c7', '[\"*\"]', NULL, '2026-02-23 12:01:07', '2026-02-23 04:01:07', '2026-02-23 04:01:07');
INSERT INTO `personal_access_tokens` VALUES (51, 'App\\Models\\User', 2, 'auth_token', '1440bb8d04b0b8fff6158333b0318aef794d39575c3310a9e50ec68f30552963', '[\"*\"]', NULL, '2026-02-23 12:01:34', '2026-02-23 04:01:34', '2026-02-23 04:01:34');
INSERT INTO `personal_access_tokens` VALUES (52, 'App\\Models\\User', 2, 'auth_token', '78612ae85e244b15bc7b9a1472e1acfda4c3b68e6ce3b8b06fc66ea24fd24b2f', '[\"*\"]', NULL, '2026-02-23 12:02:15', '2026-02-23 04:02:15', '2026-02-23 04:02:15');
INSERT INTO `personal_access_tokens` VALUES (53, 'App\\Models\\User', 2, 'auth_token', 'd99322ee712f41361d44e376c31b9fcd7dafbbf8f675177cab464d5b483d1e6e', '[\"*\"]', NULL, '2026-02-23 12:03:25', '2026-02-23 04:03:25', '2026-02-23 04:03:25');
INSERT INTO `personal_access_tokens` VALUES (54, 'App\\Models\\User', 2, 'auth_token', '12dac0aae5f67cc5996ff4094bd4b9ee9140d087b6bb6906cbf204faf896c2e4', '[\"*\"]', '2026-02-23 04:32:33', '2026-02-23 12:31:30', '2026-02-23 04:31:30', '2026-02-23 04:32:33');

-- ----------------------------
-- Table structure for productos
-- ----------------------------
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos`  (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cod_barra` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `precio` decimal(10, 2) NULL DEFAULT 0.00,
  `costo` decimal(10, 2) NULL DEFAULT 0.00,
  `precio_mayor` decimal(10, 2) NULL DEFAULT 0.00,
  `precio_menor` decimal(10, 2) NULL DEFAULT 0.00,
  `precio_unidad` decimal(10, 2) NULL DEFAULT 0.00,
  `cantidad` int NULL DEFAULT 0,
  `stock_minimo` int NULL DEFAULT 0,
  `stock_maximo` int NULL DEFAULT 0,
  `id_empresa` int NOT NULL,
  `categoria_id` int NULL DEFAULT NULL,
  `unidad_id` int NULL DEFAULT NULL,
  `almacen` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1',
  `codsunat` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '51121703',
  `usar_barra` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0',
  `usar_multiprecio` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0',
  `moneda` enum('PEN','USD') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'PEN',
  `estado` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1',
  `imagen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ultima_salida` date NULL DEFAULT NULL,
  `fecha_registro` datetime NULL DEFAULT current_timestamp(),
  `fecha_ultimo_ingreso` datetime NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_producto`) USING BTREE,
  UNIQUE INDEX `unique_codigo_almacen`(`codigo` ASC, `almacen` ASC) USING BTREE,
  INDEX `idx_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `idx_almacen`(`almacen` ASC) USING BTREE,
  INDEX `idx_categoria`(`categoria_id` ASC) USING BTREE,
  INDEX `idx_unidad`(`unidad_id` ASC) USING BTREE,
  INDEX `idx_codigo`(`codigo` ASC) USING BTREE,
  INDEX `idx_estado`(`estado` ASC) USING BTREE,
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `productos_ibfk_3` FOREIGN KEY (`unidad_id`) REFERENCES `unidades` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1116 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of productos
-- ----------------------------
INSERT INTO `productos` VALUES (486, 'CEP-001', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 10\" (NACIONAL)', '', 100.24, 25.00, 90.22, 85.20, 100.24, 10, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (487, 'CEP-001', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 10\" (NACIONAL)', '', 100.24, 25.00, 90.22, 85.20, 100.24, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (488, 'CEP-002', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 11\" (NACIONAL)', '', 101.80, 25.00, 91.62, 86.53, 101.80, 1, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (489, 'CEP-002', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 11\" (NACIONAL)', '', 101.80, 25.00, 91.62, 86.53, 101.80, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (490, 'CEP-003', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 12\" (NACIONAL)', '', 104.91, 0.00, 94.42, 89.18, 104.91, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (491, 'CEP-003', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 12\" (NACIONAL)', '', 104.91, 0.00, 94.42, 89.18, 104.91, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (492, 'CEP-004', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 13\" (NACIONAL)', '', 109.46, 0.00, 98.51, 93.04, 109.46, -3, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (493, 'CEP-004', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 13\" (NACIONAL)', '', 109.46, 0.00, 98.51, 93.04, 109.46, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (494, 'CEP-005', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 14\" (NACIONAL)', '', 112.57, 0.00, 101.31, 95.69, 112.57, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (495, 'CEP-005', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 14\" (NACIONAL)', '', 112.57, 0.00, 101.31, 95.69, 112.57, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (496, 'CEP-006', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 15\" (NACIONAL)', '', 117.11, 0.00, 105.40, 99.55, 117.11, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (497, 'CEP-006', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 15\" (NACIONAL)', '', 117.11, 0.00, 105.40, 99.55, 117.11, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (498, 'CEP-007', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 16\" (NACIONAL)', '', 121.79, 0.00, 109.61, 103.52, 121.79, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (499, 'CEP-007', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 16\" (NACIONAL)', '', 121.79, 0.00, 109.61, 103.52, 121.79, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (500, 'CEP-008', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 17\" (NACIONAL)', '', 130.87, 0.00, 117.79, 111.24, 130.87, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (501, 'CEP-008', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 17\" (NACIONAL)', '', 130.87, 0.00, 117.79, 111.24, 130.87, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (502, 'CEP-009', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 18\" (NACIONAL)', '', 135.55, 0.00, 121.99, 115.21, 135.55, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (503, 'CEP-009', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 18\" (NACIONAL)', '', 135.55, 0.00, 121.99, 115.21, 135.55, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (504, 'CEP-010', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 19\" (NACIONAL)', '', 146.19, 0.00, 131.57, 124.26, 146.19, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (505, 'CEP-010', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 19\" (NACIONAL)', '', 146.19, 0.00, 131.57, 124.26, 146.19, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (506, 'CEP-011', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 20\" (NACIONAL)', '', 153.85, 0.00, 138.46, 130.77, 153.85, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (507, 'CEP-011', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 20\" (NACIONAL)', '', 153.85, 0.00, 138.46, 130.77, 153.85, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (508, 'CEP-012', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 21\" (NACIONAL)', '', 158.52, 0.00, 142.67, 134.74, 158.52, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (509, 'CEP-012', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 21\" (NACIONAL)', '', 158.52, 0.00, 142.67, 134.74, 158.52, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (510, 'CEP-013', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 22\" (NACIONAL)', '', 161.51, 0.00, 145.36, 137.28, 161.51, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (511, 'CEP-013', NULL, 'CEPILLO PARA LAVAR PISO C/ BRAQUETA DE 22\" (NACIONAL)', '', 161.51, 0.00, 145.36, 137.28, 161.51, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (512, 'CEP-014', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 11\" (NACIONAL)', '', 100.24, 0.00, 90.22, 85.20, 100.24, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (513, 'CEP-014', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 11\" (NACIONAL)', '', 100.24, 0.00, 90.22, 85.20, 100.24, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (514, 'CEP-015', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 12\" (NACIONAL)', '', 101.80, 0.00, 91.62, 86.53, 101.80, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (515, 'CEP-015', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 12\" (NACIONAL)', '', 101.80, 0.00, 91.62, 86.53, 101.80, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (516, 'CEP-016', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 13\" (NACIONAL)', '', 104.91, 0.00, 94.42, 89.18, 104.91, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (517, 'CEP-016', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 13\" (NACIONAL)', '', 104.91, 0.00, 94.42, 89.18, 104.91, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (518, 'CEP-017', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 14\" (NACIONAL)', '', 109.46, 0.00, 98.51, 93.04, 109.46, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (519, 'CEP-017', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 14\" (NACIONAL)', '', 109.46, 0.00, 98.51, 93.04, 109.46, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (520, 'CEP-018', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 15\" (NACIONAL)', '', 112.57, 0.00, 101.31, 95.69, 112.57, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (521, 'CEP-018', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 15\" (NACIONAL)', '', 112.57, 0.00, 101.31, 95.69, 112.57, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (522, 'CEP-019', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 16\" (NACIONAL)', '', 117.11, 0.00, 105.40, 99.55, 117.11, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (523, 'CEP-019', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 16\" (NACIONAL)', '', 117.11, 0.00, 105.40, 99.55, 117.11, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (524, 'CEP-020', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 17\" (NACIONAL)', '', 121.79, 0.00, 109.61, 103.52, 121.79, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (525, 'CEP-020', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 17\" (NACIONAL)', '', 121.79, 0.00, 109.61, 103.52, 121.79, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (526, 'CEP-021', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 18\" (NACIONAL)', '', 130.87, 0.00, 117.79, 111.24, 130.87, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (527, 'CEP-021', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 18\" (NACIONAL)', '', 130.87, 0.00, 117.79, 111.24, 130.87, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (528, 'CEP-022', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 19\" (NACIONAL)', '', 135.55, 0.00, 121.99, 115.21, 135.55, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (529, 'CEP-022', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 19\" (NACIONAL)', '', 135.55, 0.00, 121.99, 115.21, 135.55, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (530, 'CEP-023', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 20\" (NACIONAL)', '', 146.19, 0.00, 131.57, 124.26, 146.19, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (531, 'CEP-023', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 20\" (NACIONAL)', '', 146.19, 0.00, 131.57, 124.26, 146.19, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (532, 'CEP-024', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 21\" (NACIONAL)', '', 153.85, 0.00, 138.46, 130.77, 153.85, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (533, 'CEP-024', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 21\" (NACIONAL)', '', 153.85, 0.00, 138.46, 130.77, 153.85, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (534, 'CEP-025', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 22\" (NACIONAL)', '', 158.52, 0.00, 142.67, 134.74, 158.52, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (535, 'CEP-025', NULL, 'CEPILLO PARA LUSTRAR PISO C/ BRAQUETA DE 22\" (NACIONAL)', '', 158.52, 0.00, 142.67, 134.74, 158.52, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (536, 'CEPI-001', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 13\" (IMPORTADO)', '', 147.50, 0.00, 132.75, 125.38, 147.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (537, 'CEPI-001', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 13\" (IMPORTADO)', '', 147.50, 0.00, 132.75, 125.38, 147.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (538, 'CEPI-002', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 15\" (IMPORTADO)', '', 160.00, 0.00, 143.37, 135.41, 160.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (539, 'CEPI-002', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 15\" (IMPORTADO)', '', 160.00, 0.00, 143.37, 135.41, 160.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (540, 'CEPI-003', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 16\" (IMPORTADO)', '', 171.10, 0.00, 153.99, 145.44, 171.10, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (541, 'CEPI-003', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 16\" (IMPORTADO)', '', 171.10, 0.00, 153.99, 145.44, 171.10, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (542, 'CEPI-004', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 17\" (IMPORTADO)', '', 182.90, 0.00, 164.61, 155.47, 182.90, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (543, 'CEPI-004', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 17\" (IMPORTADO)', '', 182.90, 0.00, 164.61, 155.47, 182.90, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (544, 'CEPI-005', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 18\" (IMPORTADO)', '', 194.70, 0.00, 175.23, 165.50, 194.70, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (545, 'CEPI-005', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 18\" (IMPORTADO)', '', 194.70, 0.00, 175.23, 165.50, 194.70, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (546, 'CEPI-006', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 19\" (IMPORTADO)', '', 194.70, 0.00, 175.23, 165.50, 194.70, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (547, 'CEPI-006', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 19\" (IMPORTADO)', '', 194.70, 0.00, 175.23, 165.50, 194.70, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (548, 'CEPI-007', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 13\" (FREGADORA ADVANCE)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (549, 'CEPI-007', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 13\" (FREGADORA ADVANCE)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (550, 'CEPI-008', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 13\" (FREGADORA TENNANT)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (551, 'CEPI-008', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 13\" (FREGADORA TENNANT)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (552, 'CEPI-009', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 16\" (FREGADORA TENNANT)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (553, 'CEPI-009', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 16\" (FREGADORA TENNANT)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (554, 'CEPI-010', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 14\" (FREGADORA VIPER)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (555, 'CEPI-010', NULL, 'CEPILLO PARA LAVAR PISOS C/ BRAQUETA DE 14\" (FREGADORA VIPER)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (556, 'CEPIR-001', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 13\" (AZUL)', '', 112.10, 0.00, 100.89, 95.28, 112.10, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (557, 'CEPIR-001', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 13\" (AZUL)', '', 112.10, 0.00, 100.89, 95.28, 112.10, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (558, 'CEPIR-002', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 13\" (ROJO)', '', 112.10, 0.00, 100.89, 95.28, 112.10, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (559, 'CEPIR-002', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 13\" (ROJO)', '', 112.10, 0.00, 100.89, 95.28, 112.10, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (560, 'CEPIR-003', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 13\" (VERDE)', '', 112.10, 0.00, 100.89, 95.28, 112.10, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (561, 'CEPIR-003', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 13\" (VERDE)', '', 112.10, 0.00, 100.89, 95.28, 112.10, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (562, 'CEPIR-004', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 14\" (AZUL)', '', 123.90, 0.00, 111.51, 105.31, 123.90, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (563, 'CEPIR-004', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 14\" (AZUL)', '', 123.90, 0.00, 111.51, 105.31, 123.90, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (564, 'CEPIR-005', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 14\" (ROJO)', '', 123.90, 0.00, 111.51, 105.31, 123.90, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (565, 'CEPIR-005', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 14\" (ROJO)', '', 123.90, 0.00, 111.51, 105.31, 123.90, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (566, 'CEPIR-006', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 14\" (VERDE)', '', 123.90, 0.00, 111.51, 105.31, 123.90, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (567, 'CEPIR-006', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 14\" (VERDE)', '', 123.90, 0.00, 111.51, 105.31, 123.90, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (568, 'CEPIR-007', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 15\" (AZUL)', '', 135.70, 0.00, 122.13, 115.34, 135.70, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (569, 'CEPIR-007', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 15\" (AZUL)', '', 135.70, 0.00, 122.13, 115.34, 135.70, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (570, 'CEPIR-008', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 15\" (ROJO)', '', 135.70, 0.00, 122.13, 115.34, 135.70, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (571, 'CEPIR-008', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 15\" (ROJO)', '', 135.70, 0.00, 122.13, 115.34, 135.70, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (572, 'CEPIR-009', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 15\" (VERDE)', '', 135.70, 0.00, 122.13, 115.34, 135.70, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (573, 'CEPIR-009', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 15\" (VERDE)', '', 135.70, 0.00, 122.13, 115.34, 135.70, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (574, 'CEPIR-010', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 16\" (AZUL)', '', 147.50, 0.00, 132.75, 125.38, 147.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (575, 'CEPIR-010', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 16\" (AZUL)', '', 147.50, 0.00, 132.75, 125.38, 147.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (576, 'CEPIR-011', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 16\" (ROJO)', '', 147.50, 0.00, 132.75, 125.38, 147.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (577, 'CEPIR-011', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 16\" (ROJO)', '', 147.50, 0.00, 132.75, 125.38, 147.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (578, 'CEPIR-012', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 16\" (VERDE)', '', 147.50, 0.00, 132.75, 125.38, 147.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (579, 'CEPIR-012', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 16\" (VERDE)', '', 147.50, 0.00, 132.75, 125.38, 147.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (580, 'CEPIR-013', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 17\" (AZUL)', '', 159.30, 0.00, 143.37, 135.41, 159.30, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (581, 'CEPIR-013', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 17\" (AZUL)', '', 159.30, 0.00, 143.37, 135.41, 159.30, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (582, 'CEPIR-014', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 17\" (ROJO)', '', 159.30, 0.00, 143.37, 135.41, 159.30, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (583, 'CEPIR-014', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 17\" (ROJO)', '', 159.30, 0.00, 143.37, 135.41, 159.30, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (584, 'CEPIR-015', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 17\" (VERDE)', '', 159.30, 0.00, 143.37, 135.41, 159.30, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (585, 'CEPIR-015', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 17\" (VERDE)', '', 159.30, 0.00, 143.37, 135.41, 159.30, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (586, 'CEPIR-016', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 18\" (AZUL)', '', 171.10, 0.00, 153.99, 145.44, 171.10, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (587, 'CEPIR-016', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 18\" (AZUL)', '', 171.10, 0.00, 153.99, 145.44, 171.10, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (588, 'CEPIR-017', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 18\" (ROJO)', '', 171.10, 0.00, 153.99, 145.44, 171.10, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (589, 'CEPIR-017', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 18\" (ROJO)', '', 171.10, 0.00, 153.99, 145.44, 171.10, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (590, 'CEPIR-018', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 18\" (VERDE)', '', 171.10, 0.00, 153.99, 145.44, 171.10, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (591, 'CEPIR-018', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 18\" (VERDE)', '', 171.10, 0.00, 153.99, 145.44, 171.10, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (592, 'CEPIR-019', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 19\" (AZUL)', '', 182.90, 0.00, 164.61, 155.47, 182.90, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (593, 'CEPIR-019', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 19\" (AZUL)', '', 182.90, 0.00, 164.61, 155.47, 182.90, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (594, 'CEPIR-020', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 19\" (ROJO)', '', 182.90, 0.00, 164.61, 155.47, 182.90, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (595, 'CEPIR-020', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 19\" (ROJO)', '', 182.90, 0.00, 164.61, 155.47, 182.90, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (596, 'CEPIR-021', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 19\" (VERDE)', '', 182.90, 0.00, 164.61, 155.47, 182.90, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (597, 'CEPIR-021', NULL, 'CEPILLO PARA LAVAR ALFOMBRA RANURADO NACIONAL DE 19\" (VERDE)', '', 182.90, 0.00, 164.61, 155.47, 182.90, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (598, 'IMPLE-001', NULL, 'BALDE PRENSA MOPA DE 36 LT DOBLE CUBO (18 LT C/U)', '', 387.50, 0.00, 348.75, 329.38, 387.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (599, 'IMPLE-001', NULL, 'BALDE PRENSA MOPA DE 36 LT DOBLE CUBO (18 LT C/U)', '', 387.50, 0.00, 348.75, 329.38, 387.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (600, 'IMPLE-002', NULL, 'BALDE PRENSA MOPA DE 36 LTS', '', 252.50, 0.00, 227.25, 214.62, 252.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (601, 'IMPLE-002', NULL, 'BALDE PRENSA MOPA DE 36 LTS', '', 252.50, 0.00, 227.25, 214.62, 252.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (602, 'IMPLE-003', NULL, 'BALDE PRENSA MOPA DE 36 LTS', '', 260.00, 0.00, 234.00, 221.00, 260.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (603, 'IMPLE-003', NULL, 'BALDE PRENSA MOPA DE 36 LTS', '', 260.00, 0.00, 234.00, 221.00, 260.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (604, 'IMPLE-004', NULL, 'BALDE PRENSA MOPA DE 36 LTS (DOBLE CUBO)', '', 336.50, 0.00, 302.85, 286.02, 336.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (605, 'IMPLE-004', NULL, 'BALDE PRENSA MOPA DE 36 LTS (DOBLE CUBO)', '', 336.50, 0.00, 302.85, 286.02, 336.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (606, 'IMPLE-005', NULL, 'BALDE PRENSA MOPA PREMIUM DE 81 LT + 3 BALDES + BANDEJA', '', 548.00, 0.00, 493.20, 465.80, 548.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (607, 'IMPLE-005', NULL, 'BALDE PRENSA MOPA PREMIUM DE 81 LT + 3 BALDES + BANDEJA', '', 548.00, 0.00, 493.20, 465.80, 548.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (608, 'IMPLE-006', NULL, 'BANDEJA ORGANIZADORA DE IMPLEMENTOS DE LIMPIEZA', '', 41.50, 0.00, 37.35, 35.27, 41.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (609, 'IMPLE-006', NULL, 'BANDEJA ORGANIZADORA DE IMPLEMENTOS DE LIMPIEZA', '', 41.50, 0.00, 37.35, 35.27, 41.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (610, 'IMPLE-007', NULL, 'COCHE PORTA MATERIALES (AZUL)', '', 360.00, 0.00, 324.00, 306.00, 360.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (611, 'IMPLE-007', NULL, 'COCHE PORTA MATERIALES (AZUL)', '', 360.00, 0.00, 324.00, 306.00, 360.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (612, 'IMPLE-008', NULL, 'COCHE PORTA MATERIALES (GRIS Y AZUL)', '', 330.00, 0.00, 297.00, 280.50, 330.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (613, 'IMPLE-008', NULL, 'COCHE PORTA MATERIALES (GRIS Y AZUL)', '', 330.00, 0.00, 297.00, 280.50, 330.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (614, 'IMPLE-009', NULL, 'COCHE PORTA IMPLEMENTOS DE LIMPIEZA (LINEA INSTITUCIONAL)', '', 650.00, 25.00, 585.00, 552.50, 650.00, 10, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (615, 'IMPLE-009', NULL, 'COCHE PORTA IMPLEMENTOS DE LIMPIEZA (LINEA INSTITUCIONAL)', '', 650.00, 25.00, 585.00, 552.50, 650.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (616, 'IMPLE-010', NULL, 'COCHE PORTA IMPLEMENTOS DE LIMPIEZA (LINEA HOSPITALARIA, INSTITUCIONAL, HOTELERA)', '', 1100.00, 0.00, 990.00, 935.00, 1100.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (617, 'IMPLE-010', NULL, 'COCHE PORTA IMPLEMENTOS DE LIMPIEZA (LINEA HOSPITALARIA, INSTITUCIONAL, HOTELERA)', '', 1100.00, 0.00, 990.00, 935.00, 1100.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (618, 'IMPLE-011', NULL, 'COCHE PORTA IMPLEMENTOS (REPUESTO BOLSA 60 LT)', '', 53.50, 0.00, 48.15, 45.47, 53.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (619, 'IMPLE-011', NULL, 'COCHE PORTA IMPLEMENTOS (REPUESTO BOLSA 60 LT)', '', 53.50, 0.00, 48.15, 45.47, 53.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (620, 'IMPLE-012', NULL, 'COCHE PORTA IMPLEMENTOS C/ CIERRE (REPUESTO BOLSA X LT)', '', 78.00, 0.00, 70.20, 66.30, 78.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (621, 'IMPLE-012', NULL, 'COCHE PORTA IMPLEMENTOS C/ CIERRE (REPUESTO BOLSA X LT)', '', 78.00, 0.00, 70.20, 66.30, 78.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (622, 'IMPLE-013', NULL, 'EXTENSIÓN TELESCÓPICA REGULABLE DE ALUMINIO DE 3 MTS (AZUL)', '', 65.00, 0.00, 58.50, 55.25, 65.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (623, 'IMPLE-013', NULL, 'EXTENSIÓN TELESCÓPICA REGULABLE DE ALUMINIO DE 3 MTS (AZUL)', '', 65.00, 0.00, 58.50, 55.25, 65.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (624, 'IMPLE-014', NULL, 'EXTENSIÓN TELESCÓPICA REGULABLE DE ALUMINIO DE 3 MTS (ESPECIAL - NEGRO)', '', 75.00, 0.00, 67.50, 63.75, 75.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (625, 'IMPLE-014', NULL, 'EXTENSIÓN TELESCÓPICA REGULABLE DE ALUMINIO DE 3 MTS (ESPECIAL - NEGRO)', '', 75.00, 0.00, 67.50, 63.75, 75.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (626, 'IMPLE-015', NULL, 'EXTENSIÓN TELESCÓPICA REGULABLE DE ALUMINIO DE 4 MTS (NEGRO Y AZUL)', '', 80.00, 0.00, 72.00, 68.00, 80.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (627, 'IMPLE-015', NULL, 'EXTENSIÓN TELESCÓPICA REGULABLE DE ALUMINIO DE 4 MTS (NEGRO Y AZUL)', '', 80.00, 0.00, 72.00, 68.00, 80.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (628, 'IMPLE-016', NULL, 'EXTENSIÓN TELESCÓPICA REGULABLE DE ALUMINIO DE 4.5 MTS (NEGRO)', '', 95.00, 0.00, 85.50, 80.75, 95.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (629, 'IMPLE-016', NULL, 'EXTENSIÓN TELESCÓPICA REGULABLE DE ALUMINIO DE 4.5 MTS (NEGRO)', '', 95.00, 0.00, 85.50, 80.75, 95.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (630, 'IMPLE-017', NULL, 'EXTENSIÓN TELESCÓPICA REGULABLE DE ALUMINIO DE 6 MTS (3 SECCIONES) (AZUL)', '', 118.00, 0.00, 106.20, 100.30, 118.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (631, 'IMPLE-017', NULL, 'EXTENSIÓN TELESCÓPICA REGULABLE DE ALUMINIO DE 6 MTS (3 SECCIONES) (AZUL)', '', 118.00, 0.00, 106.20, 100.30, 118.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (632, 'IMPLE-018', NULL, 'EXTENSIÓN TELESCÓPICA REGULABLE DE ALUMINIO DE 9 MTS (3 SECCIONES) (AZUL)', '', 146.00, 0.00, 131.40, 124.10, 146.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (633, 'IMPLE-018', NULL, 'EXTENSIÓN TELESCÓPICA REGULABLE DE ALUMINIO DE 9 MTS (3 SECCIONES) (AZUL)', '', 146.00, 0.00, 131.40, 124.10, 146.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (634, 'IMPLE-019', NULL, 'HUMEDECEDOR DE LUNAS P/EXTENSIÓN TELESCOPICA DE 40 CM (AZUL)', '', 41.50, 0.00, 37.35, 35.27, 41.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (635, 'IMPLE-019', NULL, 'HUMEDECEDOR DE LUNAS P/EXTENSIÓN TELESCOPICA DE 40 CM (AZUL)', '', 41.50, 0.00, 37.35, 35.27, 41.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (636, 'IMPLE-020', NULL, 'HUMEDECEDOR DE LUNAS P/EXTENSIÓN TELESCOPICA DE 45 CM (NEGRO)', '', 47.50, 0.00, 42.75, 40.38, 47.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (637, 'IMPLE-020', NULL, 'HUMEDECEDOR DE LUNAS P/EXTENSIÓN TELESCOPICA DE 45 CM (NEGRO)', '', 47.50, 0.00, 42.75, 40.38, 47.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (638, 'IMPLE-021', NULL, 'JALADOR DE AGUA DOBLE GOMA C/MANGO DE ALUMINIO Y BASE ACERO ZINCADO DE 60 CM', '', 78.50, 0.00, 70.65, 66.72, 78.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (639, 'IMPLE-021', NULL, 'JALADOR DE AGUA DOBLE GOMA C/MANGO DE ALUMINIO Y BASE ACERO ZINCADO DE 60 CM', '', 78.50, 0.00, 70.65, 66.72, 78.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (640, 'IMPLE-022', NULL, 'JALADOR DE AGUA DOBLE GOMA C/MANGO DE ALUMINIO Y BASE ACERO ZINCADO DE 100 CM', '', 88.50, 0.00, 79.65, 75.22, 88.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (641, 'IMPLE-022', NULL, 'JALADOR DE AGUA DOBLE GOMA C/MANGO DE ALUMINIO Y BASE ACERO ZINCADO DE 100 CM', '', 88.50, 0.00, 79.65, 75.22, 88.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (642, 'IMPLE-023', NULL, 'JALADOR DE AGUA DOBLE GOMA C/MANGO DE ALUMINIO Y BASE PLÁSTICA DE 55 CM', '', 33.50, 0.00, 30.15, 28.48, 33.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (643, 'IMPLE-023', NULL, 'JALADOR DE AGUA DOBLE GOMA C/MANGO DE ALUMINIO Y BASE PLÁSTICA DE 55 CM', '', 33.50, 0.00, 30.15, 28.48, 33.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (644, 'IMPLE-024', NULL, 'JALADOR DE AGUA DOBLE GOMA C/MANGO DE ALUMINIO Y BASE PLÁSTICA DE 75 CM', '', 38.50, 0.00, 34.65, 32.73, 38.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (645, 'IMPLE-024', NULL, 'JALADOR DE AGUA DOBLE GOMA C/MANGO DE ALUMINIO Y BASE PLÁSTICA DE 75 CM', '', 38.50, 0.00, 34.65, 32.73, 38.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (646, 'IMPLE-025', NULL, 'JALADOR DE AGUA DOBLE GOMA EBA C/MANGO DE ALUMINIO ESTRIADO Y BASE DE ACERO INOX 55CM', '', 47.50, 0.00, 42.75, 40.38, 47.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (647, 'IMPLE-025', NULL, 'JALADOR DE AGUA DOBLE GOMA EBA C/MANGO DE ALUMINIO ESTRIADO Y BASE DE ACERO INOX 55CM', '', 47.50, 0.00, 42.75, 40.38, 47.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (648, 'IMPLE-026', NULL, 'JALADOR DE AGUA DOBLE GOMA EBA C/MANGO DE ALUMINIO ESTRIADO Y BASE DE ACERO INOX 75CM', '', 53.50, 0.00, 48.15, 45.47, 53.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (649, 'IMPLE-026', NULL, 'JALADOR DE AGUA DOBLE GOMA EBA C/MANGO DE ALUMINIO ESTRIADO Y BASE DE ACERO INOX 75CM', '', 53.50, 0.00, 48.15, 45.47, 53.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (650, 'IMPLE-027', NULL, 'JALADOR DE AGUA DOBLE GOMA EBA C/MANGO DE ALUMINIO ESTRIADO Y BASE DE PROPILENO DE 60 CM (INDUSTRIA HOSPITALARIA - ALIMENTARIA)', '', 75.00, 0.00, 67.50, 63.75, 75.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (651, 'IMPLE-027', NULL, 'JALADOR DE AGUA DOBLE GOMA EBA C/MANGO DE ALUMINIO ESTRIADO Y BASE DE PROPILENO DE 60 CM (INDUSTRIA HOSPITALARIA - ALIMENTARIA)', '', 75.00, 0.00, 67.50, 63.75, 75.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (652, 'IMPLE-028', NULL, 'LETRERO PREVENTIVO \"CUIDADO PISO MOJADO\"', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (653, 'IMPLE-028', NULL, 'LETRERO PREVENTIVO \"CUIDADO PISO MOJADO\"', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (654, 'IMPLE-029', NULL, 'LETRERO PREVENTIVO EN FORMA DE CONO \"CUIDADO PISO MOJADO\"', '', 45.00, 0.00, 40.50, 38.25, 45.00, -2, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (655, 'IMPLE-029', NULL, 'LETRERO PREVENTIVO EN FORMA DE CONO \"CUIDADO PISO MOJADO\"', '', 45.00, 0.00, 40.50, 38.25, 45.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (656, 'IMPLE-030', NULL, 'LIMPIADOR DE LUNAS DE 35 CM C/BASE DE METAL P/EXTENSIÓN TELESCÓPICA', '', 41.50, 0.00, 37.35, 35.27, 41.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (657, 'IMPLE-030', NULL, 'LIMPIADOR DE LUNAS DE 35 CM C/BASE DE METAL P/EXTENSIÓN TELESCÓPICA', '', 41.50, 0.00, 37.35, 35.27, 41.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (658, 'IMPLE-031', NULL, 'LIMPIADOR DE LUNAS DE 40 CM C/BASE DE METAL P/EXTENSIÓN TELESCÓPICA', '', 47.50, 0.00, 42.75, 40.38, 47.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (659, 'IMPLE-031', NULL, 'LIMPIADOR DE LUNAS DE 40 CM C/BASE DE METAL P/EXTENSIÓN TELESCÓPICA', '', 47.50, 0.00, 42.75, 40.38, 47.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (660, 'IMPLE-032', NULL, 'LIMPIADOR DE LUNAS DE 45 CM C/BASE DE METAL P/EXTENSIÓN TELESCÓPICA', '', 53.50, 0.00, 48.15, 45.47, 53.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (661, 'IMPLE-032', NULL, 'LIMPIADOR DE LUNAS DE 45 CM C/BASE DE METAL P/EXTENSIÓN TELESCÓPICA', '', 53.50, 0.00, 48.15, 45.47, 53.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (662, 'IMPLE-033', NULL, 'LIMPIADOR DE LUNAS DUAL P/EXTENSIÓN TELESCÓPICA (HUMEDECEDOR Y JALADOR DE GOMA)', '', 53.50, 0.00, 48.15, 45.47, 53.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (663, 'IMPLE-033', NULL, 'LIMPIADOR DE LUNAS DUAL P/EXTENSIÓN TELESCÓPICA (HUMEDECEDOR Y JALADOR DE GOMA)', '', 53.50, 0.00, 48.15, 45.47, 53.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (664, 'IMPLE-034', NULL, 'MOPA DE BARRIDO DE ALGODÓN DE 60 CM C/MANGO DE ALUMINIO (COMPLETO)', '', 36.50, 0.00, 32.85, 31.02, 36.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (665, 'IMPLE-034', NULL, 'MOPA DE BARRIDO DE ALGODÓN DE 60 CM C/MANGO DE ALUMINIO (COMPLETO)', '', 36.50, 0.00, 32.85, 31.02, 36.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (666, 'IMPLE-035', NULL, 'MOPA DE BARRIDO DE ALGODÓN DE 60 CM (REPUESTO)', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (667, 'IMPLE-035', NULL, 'MOPA DE BARRIDO DE ALGODÓN DE 60 CM (REPUESTO)', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (668, 'IMPLE-036', NULL, 'MOPA DE BARRIDO DE ALGODÓN DE 90 CM C/MANGO DE ALUMINIO (COMPLETO)', '', 58.00, 0.00, 52.20, 49.30, 58.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (669, 'IMPLE-036', NULL, 'MOPA DE BARRIDO DE ALGODÓN DE 90 CM C/MANGO DE ALUMINIO (COMPLETO)', '', 58.00, 0.00, 52.20, 49.30, 58.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (670, 'IMPLE-037', NULL, 'MOPA DE BARRIDO DE ALGODÓN DE 90 CM (REPUESTO)', '', 46.00, 0.00, 41.40, 39.10, 46.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (671, 'IMPLE-037', NULL, 'MOPA DE BARRIDO DE ALGODÓN DE 90 CM (REPUESTO)', '', 46.00, 0.00, 41.40, 39.10, 46.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (672, 'IMPLE-038', NULL, 'MOPA DE BARRIDO DE ALGODÓN DE 110 CM C/MANGO DE ALUMINIO (COMPLETO)', '', 79.00, 0.00, 71.10, 67.15, 79.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (673, 'IMPLE-038', NULL, 'MOPA DE BARRIDO DE ALGODÓN DE 110 CM C/MANGO DE ALUMINIO (COMPLETO)', '', 79.00, 0.00, 71.10, 67.15, 79.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (674, 'IMPLE-039', NULL, 'MOPA DE BARRIDO DE ALGODÓN DE 110 CM (REPUESTO)', '', 67.50, 0.00, 60.75, 57.38, 67.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (675, 'IMPLE-039', NULL, 'MOPA DE BARRIDO DE ALGODÓN DE 110 CM (REPUESTO)', '', 67.50, 0.00, 60.75, 57.38, 67.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (676, 'IMPLE-040', NULL, 'MOPA DE BARRIDO ACRÍLICO DE 60 CM C/MANGO DE ACERO INOX (COMPLETO)', '', 51.00, 0.00, 45.90, 43.35, 51.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (677, 'IMPLE-040', NULL, 'MOPA DE BARRIDO ACRÍLICO DE 60 CM C/MANGO DE ACERO INOX (COMPLETO)', '', 51.00, 0.00, 45.90, 43.35, 51.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (678, 'IMPLE-041', NULL, 'MOPA DE BARRIDO ACRÍLICO DE 60 CM (REPUESTO)', '', 28.50, 0.00, 25.65, 24.22, 28.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (679, 'IMPLE-041', NULL, 'MOPA DE BARRIDO ACRÍLICO DE 60 CM (REPUESTO)', '', 28.50, 0.00, 25.65, 24.22, 28.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (680, 'IMPLE-042', NULL, 'MOPA DE BARRIDO ACRÍLICO DE 90 CM C/MANGO DE ACERO INOX (COMPLETO)', '', 72.00, 0.00, 64.80, 61.20, 72.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (681, 'IMPLE-042', NULL, 'MOPA DE BARRIDO ACRÍLICO DE 90 CM C/MANGO DE ACERO INOX (COMPLETO)', '', 72.00, 0.00, 64.80, 61.20, 72.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (682, 'IMPLE-043', NULL, 'MOPA DE BARRIDO ACRÍLICO DE 90 CM (REPUESTO)', '', 39.00, 0.00, 35.10, 33.15, 39.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (683, 'IMPLE-043', NULL, 'MOPA DE BARRIDO ACRÍLICO DE 90 CM (REPUESTO)', '', 39.00, 0.00, 35.10, 33.15, 39.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (684, 'IMPLE-044', NULL, 'MOPA DE BARRIDO ACRÍLICO DE 110 CM C/MANGO DE ACERO INOX (COMPLETO)', '', 95.50, 0.00, 85.95, 81.18, 95.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (685, 'IMPLE-044', NULL, 'MOPA DE BARRIDO ACRÍLICO DE 110 CM C/MANGO DE ACERO INOX (COMPLETO)', '', 95.50, 0.00, 85.95, 81.18, 95.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (686, 'IMPLE-045', NULL, 'MOPA DE BARRIDO ACRÍLICO DE 110 CM (REPUESTO)', '', 51.00, 0.00, 45.90, 43.35, 51.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (687, 'IMPLE-045', NULL, 'MOPA DE BARRIDO ACRÍLICO DE 110 CM (REPUESTO)', '', 51.00, 0.00, 45.90, 43.35, 51.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (688, 'IMPLE-046', NULL, 'MOPA DE BARRIDO DE MICROFIBRA DE 60 CM C/MANGO DE ALUMINIO (COMPLETO)', '', 46.00, 0.00, 41.40, 39.10, 46.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (689, 'IMPLE-046', NULL, 'MOPA DE BARRIDO DE MICROFIBRA DE 60 CM C/MANGO DE ALUMINIO (COMPLETO)', '', 46.00, 0.00, 41.40, 39.10, 46.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (690, 'IMPLE-047', NULL, 'MOPA DE BARRIDO DE MICROFIBRA DE 60 CM (REPUESTO)', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (691, 'IMPLE-047', NULL, 'MOPA DE BARRIDO DE MICROFIBRA DE 60 CM (REPUESTO)', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (692, 'IMPLE-048', NULL, 'MOPA DE BARRIDO DE MICROFIBRA DE 90 CM C/MANGO DE ALUMINIO (COMPLETO)', '', 67.50, 0.00, 60.75, 57.38, 67.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (693, 'IMPLE-048', NULL, 'MOPA DE BARRIDO DE MICROFIBRA DE 90 CM C/MANGO DE ALUMINIO (COMPLETO)', '', 67.50, 0.00, 60.75, 57.38, 67.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (694, 'IMPLE-049', NULL, 'MOPA DE BARRIDO DE MICROFIBRA DE 90 CM (REPUESTO)', '', 46.00, 0.00, 41.40, 39.10, 46.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (695, 'IMPLE-049', NULL, 'MOPA DE BARRIDO DE MICROFIBRA DE 90 CM (REPUESTO)', '', 46.00, 0.00, 41.40, 39.10, 46.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (696, 'IMPLE-050', NULL, 'MOPA DE BARRIDO DE MICROFIBRA DE 110 CM C/MANGO DE ALUMINIO (COMPLETO)', '', 88.50, 0.00, 79.65, 75.22, 88.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (697, 'IMPLE-050', NULL, 'MOPA DE BARRIDO DE MICROFIBRA DE 110 CM C/MANGO DE ALUMINIO (COMPLETO)', '', 88.50, 0.00, 79.65, 75.22, 88.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (698, 'IMPLE-051', NULL, 'MOPA DE BARRIDO DE MICROFIBRA DE 110 CM (REPUESTO)', '', 72.00, 0.00, 64.80, 61.20, 72.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (699, 'IMPLE-051', NULL, 'MOPA DE BARRIDO DE MICROFIBRA DE 110 CM (REPUESTO)', '', 72.00, 0.00, 64.80, 61.20, 72.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (700, 'IMPLE-052', NULL, 'MOPA PLANTA DE MICROFIBRA DE 69 CM (PALO CON SUJETADOR) (MOJADO O SECO)', '', 95.00, 0.00, 85.50, 80.75, 95.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (701, 'IMPLE-052', NULL, 'MOPA PLANTA DE MICROFIBRA DE 69 CM (PALO CON SUJETADOR) (MOJADO O SECO)', '', 95.00, 0.00, 85.50, 80.75, 95.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (702, 'IMPLE-053', NULL, 'MOPA PLANTA DE MICROFIBRA DE 69 CM P/ PISO MOJADO O SECO - (REPUESTO) (COLOR: AZUL)', '', 35.00, 0.00, 31.50, 29.75, 35.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (703, 'IMPLE-053', NULL, 'MOPA PLANTA DE MICROFIBRA DE 69 CM P/ PISO MOJADO O SECO - (REPUESTO) (COLOR: AZUL)', '', 35.00, 0.00, 31.50, 29.75, 35.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (704, 'IMPLE-054', NULL, 'MOPA PLANTA DE MICROFIBRA DE 69 CM P/ PISO MOJADO O SECO - (REPUESTO) (COLOR: ROJO)', '', 35.00, 0.00, 31.50, 29.75, 35.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (705, 'IMPLE-054', NULL, 'MOPA PLANTA DE MICROFIBRA DE 69 CM P/ PISO MOJADO O SECO - (REPUESTO) (COLOR: ROJO)', '', 35.00, 0.00, 31.50, 29.75, 35.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (706, 'IMPLE-055', NULL, 'MOPA PLANTA DE MICROFIBRA DE 69 CM P/ PISO MOJADO O SECO - (REPUESTO) (COLOR: VERDE)', '', 35.00, 0.00, 31.50, 29.75, 35.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (707, 'IMPLE-055', NULL, 'MOPA PLANTA DE MICROFIBRA DE 69 CM P/ PISO MOJADO O SECO - (REPUESTO) (COLOR: VERDE)', '', 35.00, 0.00, 31.50, 29.75, 35.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (708, 'IMPLE-056', NULL, 'BASE DE TRAPEADOR MECHÓN IMPORTADO C/ MANGO DE ALUMINIO 120 CM (COLOR: AMARILLO)', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (709, 'IMPLE-056', NULL, 'BASE DE TRAPEADOR MECHÓN IMPORTADO C/ MANGO DE ALUMINIO 120 CM (COLOR: AMARILLO)', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (710, 'IMPLE-057', NULL, 'BASE DE TRAPEADOR MECHÓN IMPORTADO C/ MANGO DE ALUMINIO 120 CM (COLOR: AZUL)', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (711, 'IMPLE-057', NULL, 'BASE DE TRAPEADOR MECHÓN IMPORTADO C/ MANGO DE ALUMINIO 120 CM (COLOR: AZUL)', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (712, 'IMPLE-058', NULL, 'BASE DE TRAPEADOR MECHÓN IMPORTADO C/ MANGO DE ALUMINIO 120 CM (COLOR: ROJO)', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (713, 'IMPLE-058', NULL, 'BASE DE TRAPEADOR MECHÓN IMPORTADO C/ MANGO DE ALUMINIO 120 CM (COLOR: ROJO)', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (714, 'IMPLE-059', NULL, 'BASE DE TRAPEADOR MECHÓN IMPORTADO C/ MANGO DE ALUMINIO 120 CM (COLOR: VERDE)', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (715, 'IMPLE-059', NULL, 'BASE DE TRAPEADOR MECHÓN IMPORTADO C/ MANGO DE ALUMINIO 120 CM (COLOR: VERDE)', '', 25.00, 0.00, 22.50, 21.25, 25.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (716, 'IMPLE-060', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 120 CM (COLOR: AMARILLO)', '', 28.00, 0.00, 25.20, 23.80, 28.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (717, 'IMPLE-060', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 120 CM (COLOR: AMARILLO)', '', 28.00, 0.00, 25.20, 23.80, 28.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (718, 'IMPLE-061', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 120 CM (COLOR: AZUL)', '', 28.00, 0.00, 25.20, 23.80, 28.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (719, 'IMPLE-061', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 120 CM (COLOR: AZUL)', '', 28.00, 0.00, 25.20, 23.80, 28.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (720, 'IMPLE-062', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 120 CM (COLOR: ROJO)', '', 28.00, 0.00, 25.20, 23.80, 28.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (721, 'IMPLE-062', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 120 CM (COLOR: ROJO)', '', 28.00, 0.00, 25.20, 23.80, 28.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (722, 'IMPLE-063', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 120 CM (COLOR: VERDE)', '', 28.00, 0.00, 25.20, 23.80, 28.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (723, 'IMPLE-063', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 120 CM (COLOR: VERDE)', '', 28.00, 0.00, 25.20, 23.80, 28.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (724, 'IMPLE-064', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 140 CM (COLOR: AMARILLO)', '', 33.00, 0.00, 29.70, 28.05, 33.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (725, 'IMPLE-064', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 140 CM (COLOR: AMARILLO)', '', 33.00, 0.00, 29.70, 28.05, 33.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (726, 'IMPLE-065', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 140 CM (COLOR: AZUL)', '', 33.00, 0.00, 29.70, 28.05, 33.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (727, 'IMPLE-065', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 140 CM (COLOR: AZUL)', '', 33.00, 0.00, 29.70, 28.05, 33.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (728, 'IMPLE-066', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 140 CM (COLOR: ROJO)', '', 33.00, 0.00, 29.70, 28.05, 33.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (729, 'IMPLE-066', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 140 CM (COLOR: ROJO)', '', 33.00, 0.00, 29.70, 28.05, 33.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (730, 'IMPLE-067', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 140 CM (COLOR: VERDE)', '', 33.00, 0.00, 29.70, 28.05, 33.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (731, 'IMPLE-067', NULL, 'BASE DE TRAPEADOR MECHÓN NACIONAL C/ MANGO DE HIERRO REVESTIDO CON PINTURA URETANO 140 CM (COLOR: VERDE)', '', 33.00, 0.00, 29.70, 28.05, 33.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (732, 'IMPLE-068', NULL, 'RECOGEDOR Y ESCOBA LOBBY (COMPLETO)', '', 41.50, 0.00, 37.35, 35.27, 41.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (733, 'IMPLE-068', NULL, 'RECOGEDOR Y ESCOBA LOBBY (COMPLETO)', '', 41.50, 0.00, 37.35, 35.27, 41.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (734, 'IMPLE-069', NULL, 'TRAPEADOR MECHÓN DE 500 GR', '', 8.00, 0.00, 7.20, 6.80, 8.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (735, 'IMPLE-069', NULL, 'TRAPEADOR MECHÓN DE 500 GR', '', 8.00, 0.00, 7.20, 6.80, 8.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (736, 'IMPLE-070', NULL, 'TRAPEADOR MECHÓN BLANCO DE 450 GR (IMPORTADO)', '', 16.00, 0.00, 14.40, 13.60, 16.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (737, 'IMPLE-070', NULL, 'TRAPEADOR MECHÓN BLANCO DE 450 GR (IMPORTADO)', '', 16.00, 0.00, 14.40, 13.60, 16.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (738, 'IMPLE-071', NULL, 'TRAPEADOR MECHÓN HÚMEDO 50% ANTIBACTERIAL DE 350 GR HÚMEDO (IMPORTADO) (COLOR: AZUL)', '', 16.50, 0.00, 14.85, 14.02, 16.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (739, 'IMPLE-071', NULL, 'TRAPEADOR MECHÓN HÚMEDO 50% ANTIBACTERIAL DE 350 GR HÚMEDO (IMPORTADO) (COLOR: AZUL)', '', 16.50, 0.00, 14.85, 14.02, 16.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (740, 'IMPLE-072', NULL, 'TRAPEADOR MECHÓN HÚMEDO 50% ANTIBACTERIAL DE 350 GR HÚMEDO (IMPORTADO) (COLOR: ROJO)', '', 16.50, 0.00, 14.85, 14.02, 16.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (741, 'IMPLE-072', NULL, 'TRAPEADOR MECHÓN HÚMEDO 50% ANTIBACTERIAL DE 350 GR HÚMEDO (IMPORTADO) (COLOR: ROJO)', '', 16.50, 0.00, 14.85, 14.02, 16.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (742, 'IMPLE-073', NULL, 'TRAPEADOR MECHÓN HÚMEDO 50% ANTIBACTERIAL DE 350 GR HÚMEDO (IMPORTADO) (COLOR: VERDE)', '', 16.50, 0.00, 14.85, 14.02, 16.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (743, 'IMPLE-073', NULL, 'TRAPEADOR MECHÓN HÚMEDO 50% ANTIBACTERIAL DE 350 GR HÚMEDO (IMPORTADO) (COLOR: VERDE)', '', 16.50, 0.00, 14.85, 14.02, 16.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (744, 'IMPLE-074', NULL, 'TRAPEADOR MECHÓN HÚMEDO DE ALGODÓN DE 350 GR (IMPORTADO) - AZUL', '', 27.50, 0.00, 24.75, 23.37, 27.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (745, 'IMPLE-074', NULL, 'TRAPEADOR MECHÓN HÚMEDO DE ALGODÓN DE 350 GR (IMPORTADO) - AZUL', '', 27.50, 0.00, 24.75, 23.37, 27.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (746, 'IMPLE-075', NULL, 'TRAPEADOR MECHÓN HÚMEDO DE ALGODÓN DE 350 GR (IMPORTADO) - ROJO', '', 27.50, 0.00, 24.75, 23.37, 27.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (747, 'IMPLE-075', NULL, 'TRAPEADOR MECHÓN HÚMEDO DE ALGODÓN DE 350 GR (IMPORTADO) - ROJO', '', 27.50, 0.00, 24.75, 23.37, 27.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (748, 'IMPLE-076', NULL, 'TRAPEADOR MECHÓN HÚMEDO DE ALGODÓN DE 350 GR (IMPORTADO) - VERDE', '', 27.50, 0.00, 24.75, 23.37, 27.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (749, 'IMPLE-076', NULL, 'TRAPEADOR MECHÓN HÚMEDO DE ALGODÓN DE 350 GR (IMPORTADO) - VERDE', '', 27.50, 0.00, 24.75, 23.37, 27.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (750, 'JVC-001', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 12\" - MARCA: CRIS-TAURO', 'Modelo: TD-12N \nPotencia de motor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial. \nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 12\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 11\" y Cepillo de Lustrar de 11\".', 3658.00, 0.00, 3292.20, 3109.30, 3658.00, -3, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (751, 'JVC-001', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 12\" - MARCA: CRIS-TAURO', 'Modelo: TD-12N \nPotencia de motor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial. \nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 12\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 11\" y Cepillo de Lustrar de 11\".', 3658.00, 0.00, 3292.20, 3109.30, 3658.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (752, 'JVC-001-1', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 12\" - MARCA: CRIS-TAURO', 'Modelo: TD-12N \nPotencia de motor: 2.0 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 12\" \nCable Vulcanizado Homologado de 3x14: 15 metros \nIncluye: Cepillo de Lavar de 11\" y Cepillo de Lustrar de 11\"', 3958.00, 0.00, 3610.80, 3410.20, 3958.00, 2, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (753, 'JVC-001-1', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 12\" - MARCA: CRIS-TAURO', 'Modelo: TD-12N \nPotencia de motor: 2.0 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 12\" \nCable Vulcanizado Homologado de 3x14: 15 metros \nIncluye: Cepillo de Lavar de 11\" y Cepillo de Lustrar de 11\"', 3958.00, 0.00, 3610.80, 3410.20, 3958.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (754, 'JVC-002', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 14\" - MARCA: CRIS-TAURO', 'Modelo: TD-14N \nPotencia de motor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial \nEstructura en Acero Inoxidable Anticorrosivo. \nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 14\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 13\" y Cepillo de Lustrar de 13\".', 3894.00, 0.00, 3504.60, 3309.90, 3894.00, 1, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (755, 'JVC-002', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 14\" - MARCA: CRIS-TAURO', 'Modelo: TD-14N \nPotencia de motor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial \nEstructura en Acero Inoxidable Anticorrosivo. \nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 14\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 13\" y Cepillo de Lustrar de 13\".', 3894.00, 0.00, 3504.60, 3309.90, 3894.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (756, 'JVC-002-1', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 14\" - MARCA: CRIS-TAURO', 'Modelo: TD-14N \nPotencia de motor: 2.0 HP\nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial \nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 14\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 13\" y Cepillo de Lustrar de 13\".', 4194.00, 0.00, 3823.20, 3610.80, 4194.00, 4, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (757, 'JVC-002-1', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 14\" - MARCA: CRIS-TAURO', 'Modelo: TD-14N \nPotencia de motor: 2.0 HP\nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial \nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 14\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 13\" y Cepillo de Lustrar de 13\".', 4194.00, 0.00, 3823.20, 3610.80, 4194.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (758, 'JVC-003', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 16\" - MARCA: CRIS-TAURO', 'Modelo: TD-16N \nPotencia de motor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 16\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 15\" y Cepillo de Lustrar de 15\".', 4130.00, 321.00, 3717.00, 3510.50, 4130.00, 15, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (759, 'JVC-003', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 16\" - MARCA: CRIS-TAURO', 'Modelo: TD-16N \nPotencia de motor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 16\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 15\" y Cepillo de Lustrar de 15\".', 4130.00, 321.00, 3717.00, 3510.50, 4130.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (760, 'JVC-003-1', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 16\" - MARCA: CRIS-TAURO', 'Modelo: TD-16N \nPotencia de motor: 2.0 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 16\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 15\" y Cepillo de Lustrar de 15\"', 4430.00, 0.00, 4035.60, 3811.40, 4430.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (761, 'JVC-003-1', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 16\" - MARCA: CRIS-TAURO', 'Modelo: TD-16N \nPotencia de motor: 2.0 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 16\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 15\" y Cepillo de Lustrar de 15\"', 4430.00, 0.00, 4035.60, 3811.40, 4430.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (762, 'JVC-004', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 18\" - MARCA: CRIS-TAURO', 'Modelo: TD-18N \nPotencia de motor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 18\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 17\" y Cepillo de Lustrar de 17\"', 4366.00, 0.00, 3929.40, 3711.10, 4366.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (763, 'JVC-004', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 18\" - MARCA: CRIS-TAURO', 'Modelo: TD-18N \nPotencia de motor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 18\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 17\" y Cepillo de Lustrar de 17\"', 4366.00, 0.00, 3929.40, 3711.10, 4366.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (764, 'JVC-004-1', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 18\" - MARCA: CRIS-TAURO', 'Modelo: TD-18N \nPotencia de motor: 2.0 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 18\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 17\" y Cepillo de Lustrar de 17\"', 4666.00, 0.00, 4248.00, 4012.00, 4666.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (765, 'JVC-004-1', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 18\" - MARCA: CRIS-TAURO', 'Modelo: TD-18N \nPotencia de motor: 2.0 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 18\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 17\" y Cepillo de Lustrar de 17\"', 4666.00, 0.00, 4248.00, 4012.00, 4666.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (766, 'JVC-005', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 20\" - MARCA: CRIS-TAURO', 'Modelo: TD-20N \nPotencia de motor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 20\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 19\" y Cepillo de Lustrar de 19\"', 4602.00, 0.00, 4141.80, 3911.70, 4602.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (767, 'JVC-005', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 20\" - MARCA: CRIS-TAURO', 'Modelo: TD-20N \nPotencia de motor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 20\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 19\" y Cepillo de Lustrar de 19\"', 4602.00, 0.00, 4141.80, 3911.70, 4602.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (768, 'JVC-005-1', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 20\" - MARCA: CRIS-TAURO', 'Modelo: TD-20N \nPotencia de motor: 2.0 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 20\".\nCable Vulcanizado Homologado de 3x14: 15 metros. \nIncluye: Cepillo de Lavar de 19\" y Cepillo de Lustrar de 19\"', 4902.00, 0.00, 4460.40, 4212.60, 4902.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (769, 'JVC-005-1', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 20\" - MARCA: CRIS-TAURO', 'Modelo: TD-20N \nPotencia de motor: 2.0 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 20\".\nCable Vulcanizado Homologado de 3x14: 15 metros. \nIncluye: Cepillo de Lavar de 19\" y Cepillo de Lustrar de 19\"', 4902.00, 0.00, 4460.40, 4212.60, 4902.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (770, 'JVC-006', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 23\" - MARCA: CRIS-TAURO', 'Modelo: TD-23N \nPotencia de motor: 2.0 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 23\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 22\" y Cepillo de Lustrar de 22\".', 5310.00, 0.00, 4779.00, 4513.50, 5310.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (771, 'JVC-006', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 23\" - MARCA: CRIS-TAURO', 'Modelo: TD-23N \nPotencia de motor: 2.0 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nMotor: KDS del Grupo Imperial.\nEstructura en Acero Inoxidable Anticorrosivo.\nBase de Motor en Aluminio Fundido anticorrosivo.\nPlato en Acero Inoxidable (calidad 304) de 23\".\nCable Vulcanizado Homologado de 3x14: 15 metros.\nIncluye: Cepillo de Lavar de 22\" y Cepillo de Lustrar de 22\".', 5310.00, 0.00, 4779.00, 4513.50, 5310.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (772, 'JVC-007', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 6 GALONES - MARCA: CRIS-TAURO', 'Modelo: AD-06G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 06 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 2183.00, 0.00, 1964.70, 1855.55, 2183.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (773, 'JVC-007', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 6 GALONES - MARCA: CRIS-TAURO', 'Modelo: AD-06G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 06 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 2183.00, 0.00, 1964.70, 1855.55, 2183.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (774, 'JVC-008', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 8 GALONES - MARCA: CRIS-TAURO', 'Modelo: AD-08G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 08 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 2596.00, 0.00, 2336.40, 2206.60, 2596.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (775, 'JVC-008', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 8 GALONES - MARCA: CRIS-TAURO', 'Modelo: AD-08G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 08 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 2596.00, 0.00, 2336.40, 2206.60, 2596.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (776, 'JVC-009', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 10 GALONES - MARCA: CRIS-TAURO', 'Modelo: AD-10G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 10 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 3009.00, 0.00, 2708.10, 2557.65, 3009.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (777, 'JVC-009', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 10 GALONES - MARCA: CRIS-TAURO', 'Modelo: AD-10G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 10 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 3009.00, 0.00, 2708.10, 2557.65, 3009.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (778, 'JVC-010', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 12 GALONES - MARCA: CRIS-TAURO', 'Modelo: AD-12G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 12 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 3422.00, 0.00, 3079.80, 2908.70, 3422.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (779, 'JVC-010', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 12 GALONES - MARCA: CRIS-TAURO', 'Modelo: AD-12G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 12 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 3422.00, 0.00, 3079.80, 2908.70, 3422.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (780, 'JVC-011', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 15 GALONES - MARCA: CRIS-TAURO', 'Modelo: AD-15G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 15 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 3835.00, 0.00, 3451.50, 3259.75, 3835.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (781, 'JVC-011', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 15 GALONES - MARCA: CRIS-TAURO', 'Modelo: AD-15G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 15 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 3835.00, 0.00, 3451.50, 3259.75, 3835.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (782, 'JVC-012', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 20 GALONES - MARCA: CRIS-TAURO', 'Modelo: AD-20G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 20 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 4248.00, 0.00, 3823.20, 3610.80, 4248.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (783, 'JVC-012', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 20 GALONES - MARCA: CRIS-TAURO', 'Modelo: AD-20G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 20 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 4248.00, 0.00, 3823.20, 3610.80, 4248.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (784, 'JVC-013', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 25 GALONES (DOBLE MOTOR) - MARCA: CRIS-TAURO', 'Modelo: AD-25G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 25 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 4661.00, 0.00, 4194.90, 3961.85, 4661.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (785, 'JVC-013', NULL, 'ASPIRADORA INDUSTRIAL DE POLVO Y AGUA DE 25 GALONES (DOBLE MOTOR) - MARCA: CRIS-TAURO', 'Modelo: AD-25G \nMotor: 1200W - 60Hz / 18000 RPM\nAspirado: Polvo y Agua\nTanque: Fibra de vidrio de 25 Galones.\nCable Vulcanizado Homologado de 3x14: 10 metros.\nIncluye: Kit completo de accesorios', 4661.00, 0.00, 4194.90, 3961.85, 4661.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (786, 'JVC-014', NULL, 'LAVADORA DE ALFOMBRAS INDUSTRIAL 16\" (SISTEMA CONVENSIONAL) - MARCA: CRIS- TAURO', 'Modelo: LTC-16C \nMotor: 1.5HP - 60Hz / 1750 RPM\nSistema de lavado: Sistema de inyección por gravedad.\nCapacidad del Tanque: 12 Litros polietileno.\nIncluye: Cepillo ranurado de lavar alfombras de 15\".', 4543.00, 0.00, 4088.70, 3861.55, 4543.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (787, 'JVC-014', NULL, 'LAVADORA DE ALFOMBRAS INDUSTRIAL 16\" (SISTEMA CONVENSIONAL) - MARCA: CRIS- TAURO', 'Modelo: LTC-16C \nMotor: 1.5HP - 60Hz / 1750 RPM\nSistema de lavado: Sistema de inyección por gravedad.\nCapacidad del Tanque: 12 Litros polietileno.\nIncluye: Cepillo ranurado de lavar alfombras de 15\".', 4543.00, 0.00, 4088.70, 3861.55, 4543.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (788, 'JVC-015', NULL, 'LAVADORA DE ALFOMBRAS INDUSTRIAL 16\" (SISTEMA INYECCIÓN A ESPUMA) - MARCA: CRIS-TAURO', 'Modelo: LTC-16A \nMotor: 1.5HP - 60Hz / 1750 RPM \nMotor de Mezcla: 1200W - 60 Hz \nSistema de lavado: Sistema generador de espuma.\nTanque: 12 Litros de fibra de vidrio.\nIncluye: Cepillo ranurado de lavar alfombras de 15\".', 6490.00, 0.00, 5841.00, 5516.50, 6490.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (789, 'JVC-015', NULL, 'LAVADORA DE ALFOMBRAS INDUSTRIAL 16\" (SISTEMA INYECCIÓN A ESPUMA) - MARCA: CRIS-TAURO', 'Modelo: LTC-16A \nMotor: 1.5HP - 60Hz / 1750 RPM \nMotor de Mezcla: 1200W - 60 Hz \nSistema de lavado: Sistema generador de espuma.\nTanque: 12 Litros de fibra de vidrio.\nIncluye: Cepillo ranurado de lavar alfombras de 15\".', 6490.00, 0.00, 5841.00, 5516.50, 6490.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (790, 'JVC-016', NULL, 'ABRILLANTADOR INDUSTRIAL PARA PISOS DE 20\" - MARCA: MASTER GOLDS', 'Modelo: AMG-1500A \nMotor: 2.0 HP \nInducido Estructura: Polipropileno de alta densidad.\nPlato: Polipropileno de 20\" \nCable: Vulcanizado x 10 metros.\nIncluye: Porta Pad 20\" y Disco Pad 20\".', 4484.00, 0.00, 4035.60, 3811.40, 4484.00, 1, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (791, 'JVC-016', NULL, 'ABRILLANTADOR INDUSTRIAL PARA PISOS DE 20\" - MARCA: MASTER GOLDS', 'Modelo: AMG-1500A \nMotor: 2.0 HP \nInducido Estructura: Polipropileno de alta densidad.\nPlato: Polipropileno de 20\" \nCable: Vulcanizado x 10 metros.\nIncluye: Porta Pad 20\" y Disco Pad 20\".', 4484.00, 0.00, 4035.60, 3811.40, 4484.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (792, 'JVC-016-1', NULL, 'ABRILLANTADORA INDUSTRIAL DE PISOS Y VINILES DE 20\" - MARCA MASTER GOLDS', 'Modelo: AMG-1500C \nMotor: 2.0 HP Inducido \nEstructura: Acero Plato en Acero de 20\".\nCable: Vulcanizado x 10 metros. \nIncluye: Porta Pad 20\" y Disco Pad 20\".', 6490.00, 0.00, 0.00, 0.00, 6490.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (793, 'JVC-016-1', NULL, 'ABRILLANTADORA INDUSTRIAL DE PISOS Y VINILES DE 20\" - MARCA MASTER GOLDS', 'Modelo: AMG-1500C \nMotor: 2.0 HP Inducido \nEstructura: Acero Plato en Acero de 20\".\nCable: Vulcanizado x 10 metros. \nIncluye: Porta Pad 20\" y Disco Pad 20\".', 6490.00, 0.00, 0.00, 0.00, 6490.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (794, 'JVC-017', NULL, 'ASPIRADORA PROFESIONAL DE POLVO DE 6 LITROS (TIPO MOCHILA) - MARCA: MASTER GOLDS', 'Modelo: AMG-6L \nMotor: 1000W LAMB AMETEK \nCapacidad: 6 LT \nAspirado: Polvo \nCable: Vulcanizado x 10 metros \nIncluye: Kit de accesorios', 979.40, 0.00, 881.46, 832.49, 979.40, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (795, 'JVC-017', NULL, 'ASPIRADORA PROFESIONAL DE POLVO DE 6 LITROS (TIPO MOCHILA) - MARCA: MASTER GOLDS', 'Modelo: AMG-6L \nMotor: 1000W LAMB AMETEK \nCapacidad: 6 LT \nAspirado: Polvo \nCable: Vulcanizado x 10 metros \nIncluye: Kit de accesorios', 979.40, 0.00, 881.46, 832.49, 979.40, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (796, 'JVC-018', NULL, 'ASPIRADORA PROFESIONAL DE POLVO DE 10 LITROS (LINEA HOTELERA) - MARCA: MASTER GOLDS', 'Modelo: AMG-10L \nMotor: 1000W LAMB AMETEK \nCapacidad: 10 LT \nAspirado: Polvo \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 767.00, 0.00, 690.30, 651.95, 767.00, -7, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (797, 'JVC-018', NULL, 'ASPIRADORA PROFESIONAL DE POLVO DE 10 LITROS (LINEA HOTELERA) - MARCA: MASTER GOLDS', 'Modelo: AMG-10L \nMotor: 1000W LAMB AMETEK \nCapacidad: 10 LT \nAspirado: Polvo \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 767.00, 0.00, 690.30, 651.95, 767.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (798, 'JVC-019', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 15 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-15L \nMotor: 1000W LAMB AMETEK \nCapacidad: 15 LT \nEstructura: Tanque de acero \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 944.00, 0.00, 849.60, 802.40, 944.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (799, 'JVC-019', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 15 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-15L \nMotor: 1000W LAMB AMETEK \nCapacidad: 15 LT \nEstructura: Tanque de acero \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 944.00, 0.00, 849.60, 802.40, 944.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (800, 'JVC-020', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 25 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-25L \nMotor: 1000W LAMB AMETEK \nCapacidad: 25 LT \nEstructura: Tanque de acero \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios.', 1062.00, 0.00, 955.80, 902.70, 1062.00, 1, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (801, 'JVC-020', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 25 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-25L \nMotor: 1000W LAMB AMETEK \nCapacidad: 25 LT \nEstructura: Tanque de acero \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios.', 1062.00, 0.00, 955.80, 902.70, 1062.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (802, 'JVC-021', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 30 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-30L \nMotor: 1000W LAMB AMETEK \nCapacidad: 30 LT \nEstructura: Tanque de acero \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros.\nIncluye: Kit de accesorios.', 1180.00, 0.00, 1062.00, 1003.00, 1180.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (803, 'JVC-021', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 30 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-30L \nMotor: 1000W LAMB AMETEK \nCapacidad: 30 LT \nEstructura: Tanque de acero \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros.\nIncluye: Kit de accesorios.', 1180.00, 0.00, 1062.00, 1003.00, 1180.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (804, 'JVC-022', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 38 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-38L \nMotor: 1000W LAMB AMETEK \nCapacidad: 38 LT \nEstructura: Tanque de acero\nAspirado: Polvo y agua\nCable: Vulcanizado x 7 metros.\nIncluye: Kit de accesorios.', 1298.00, 0.00, 1168.20, 1103.30, 1298.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (805, 'JVC-022', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 38 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-38L \nMotor: 1000W LAMB AMETEK \nCapacidad: 38 LT \nEstructura: Tanque de acero\nAspirado: Polvo y agua\nCable: Vulcanizado x 7 metros.\nIncluye: Kit de accesorios.', 1298.00, 0.00, 1168.20, 1103.30, 1298.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (806, 'JVC-023', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 10 GALONES - MARCA: MASTER GOLDS', 'Modelo: AMG-10G \nMotor: 1200W ITALY \nCapacidad: 10 GALONES \nEstructura: Tanque de acero con manija de transporte \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 1593.00, 0.00, 1433.70, 1354.05, 1593.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (807, 'JVC-023', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 10 GALONES - MARCA: MASTER GOLDS', 'Modelo: AMG-10G \nMotor: 1200W ITALY \nCapacidad: 10 GALONES \nEstructura: Tanque de acero con manija de transporte \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 1593.00, 0.00, 1433.70, 1354.05, 1593.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (808, 'JVC-024', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 12 GALONES - MARCA: MASTER GOLDS', 'Modelo: AMG-12G \nMotor: 3000W (2 de 1500W) LAMB AMETEK \nCapacidad: 12 GALONES \nEstructura: Tanque de acero con manija de transporte\nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 2065.00, 0.00, 1858.50, 1755.25, 2065.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (809, 'JVC-024', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 12 GALONES - MARCA: MASTER GOLDS', 'Modelo: AMG-12G \nMotor: 3000W (2 de 1500W) LAMB AMETEK \nCapacidad: 12 GALONES \nEstructura: Tanque de acero con manija de transporte\nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 2065.00, 0.00, 1858.50, 1755.25, 2065.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (810, 'JVC-025', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 60 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-60L \nMotor: 2000W (2 de 1000W) LAMB AMETEK \nCapacidad: 60 LT \nEstructura: Tanque de acero con manija de transporte \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 2714.00, 0.00, 2442.60, 2306.90, 2714.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (811, 'JVC-025', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 60 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-60L \nMotor: 2000W (2 de 1000W) LAMB AMETEK \nCapacidad: 60 LT \nEstructura: Tanque de acero con manija de transporte \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 2714.00, 0.00, 2442.60, 2306.90, 2714.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (812, 'JVC-026', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 70 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-70L \nMotor: 2000W (2 de 1000W) LAMB AMETEK \nCapacidad: 70 LT \nEstructura: Tanque de acero con manija de transporte \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 2891.00, 0.00, 2601.90, 2457.35, 2891.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (813, 'JVC-026', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 70 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-70L \nMotor: 2000W (2 de 1000W) LAMB AMETEK \nCapacidad: 70 LT \nEstructura: Tanque de acero con manija de transporte \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 2891.00, 0.00, 2601.90, 2457.35, 2891.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (814, 'JVC-027', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 80 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-80L \nMotor: 3000W (3 de 1000W) LAMB AMETEK \nCapacidad: 80 LT \nEstructura: Tanque de acero con manija de transporte \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 3363.00, 0.00, 3026.70, 2858.55, 3363.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (815, 'JVC-027', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 80 LT - MARCA: MASTER GOLDS', 'Modelo: AMG-80L \nMotor: 3000W (3 de 1000W) LAMB AMETEK \nCapacidad: 80 LT \nEstructura: Tanque de acero con manija de transporte \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 3363.00, 0.00, 3026.70, 2858.55, 3363.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (816, 'JVC-028', NULL, 'LIMPIADOR MULTIFUNCIONAL DE ALFOMBRAS Y SOFAS DE 20 LT- MARCA: MASTER GOLDS', 'Modelo: LMS-20SF \nMotor de Aspirado: 1079W \nMotor de Lavado: 34W \nCapacidad: 20 LT \nEstructura: Tanque de acero \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 3540.00, 0.00, 3186.00, 3009.00, 3540.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (817, 'JVC-028', NULL, 'LIMPIADOR MULTIFUNCIONAL DE ALFOMBRAS Y SOFAS DE 20 LT- MARCA: MASTER GOLDS', 'Modelo: LMS-20SF \nMotor de Aspirado: 1079W \nMotor de Lavado: 34W \nCapacidad: 20 LT \nEstructura: Tanque de acero \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 3540.00, 0.00, 3186.00, 3009.00, 3540.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (818, 'JVC-029', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 25 LT - MARCA: SPEED POWER', 'Modelo: ASP-25L \nMotor: 1200W \nCapacidad: 25 LT \nEstructura: Tanque de acero \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 684.40, 0.00, 615.96, 581.74, 684.40, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (819, 'JVC-029', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 25 LT - MARCA: SPEED POWER', 'Modelo: ASP-25L \nMotor: 1200W \nCapacidad: 25 LT \nEstructura: Tanque de acero \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 684.40, 0.00, 615.96, 581.74, 684.40, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (820, 'JVC-030', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 38 LT - MARCA: SPEED POWER', 'Modelo: ASP-38L \nMotor: 1500W \nCapacidad: 38 LT \nEstructura: Tanque de acero \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 802.40, 0.00, 722.16, 682.04, 802.40, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (821, 'JVC-030', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 38 LT - MARCA: SPEED POWER', 'Modelo: ASP-38L \nMotor: 1500W \nCapacidad: 38 LT \nEstructura: Tanque de acero \nAspirado: Polvo y Agua \nCable: Vulcanizado x 7 metros \nIncluye: Kit de accesorios', 802.40, 0.00, 722.16, 682.04, 802.40, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (822, 'JVC-031', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 38 LT - MARCA: SPEED POWER', 'Modelo: ASP-30LA \nMotor: 1000W \nCapacidad: 38 LT \nEstructura: Tanque de acero \nAspirado: Polvo y Agua \nCable: Vulcanizado x 10 metros \nIncluye: Kit de accesorios', 1003.00, 0.00, 902.70, 852.55, 1003.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (823, 'JVC-031', NULL, 'ASPIRADORA PROFESIONAL DE POLVO Y AGUA DE 38 LT - MARCA: SPEED POWER', 'Modelo: ASP-30LA \nMotor: 1000W \nCapacidad: 38 LT \nEstructura: Tanque de acero \nAspirado: Polvo y Agua \nCable: Vulcanizado x 10 metros \nIncluye: Kit de accesorios', 1003.00, 0.00, 902.70, 852.55, 1003.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (824, 'JVC-032', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 14\" - MARCA: SPEED POWER', 'Modelo: LPS-14 \nMotor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nEstrucura: Acero inoxidable \nPlato: Acero inox de 14\" \nCable: Vulcanizado x 12 metros \nIncluye: Cepillo de lavar 13\" y lustrar de 13\"', 2950.00, 0.00, 2655.00, 2507.50, 2950.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (825, 'JVC-032', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 14\" - MARCA: SPEED POWER', 'Modelo: LPS-14 \nMotor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nEstrucura: Acero inoxidable \nPlato: Acero inox de 14\" \nCable: Vulcanizado x 12 metros \nIncluye: Cepillo de lavar 13\" y lustrar de 13\"', 2950.00, 0.00, 2655.00, 2507.50, 2950.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (826, 'JVC-033', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 18\" - MARCA: SPEED POWER', 'Modelo: LPS-18 \nMotor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nEstrucura: Acero inoxidable \nPlato: Acero revestido de 18\" \nCable: Vulcanizado x 12 metros \nIncluye: Cepillo de lavar 16\" y lustrar de 16\"', 3304.00, 0.00, 2973.60, 2808.40, 3304.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (827, 'JVC-033', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 18\" - MARCA: SPEED POWER', 'Modelo: LPS-18 \nMotor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nEstrucura: Acero inoxidable \nPlato: Acero revestido de 18\" \nCable: Vulcanizado x 12 metros \nIncluye: Cepillo de lavar 16\" y lustrar de 16\"', 3304.00, 0.00, 2973.60, 2808.40, 3304.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (828, 'JVC-034', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 20\" - MARCA: SPEED POWER', 'Modelo: LPS-20 \nMotor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nEstrucura: Acero inoxidable \nPlato: Acero revestido de 20\" \nCable: Vulcanizado x 12 metros \nIncluye: Cepillo de lavar y lustrar de 19\"', 3540.00, 0.00, 3186.00, 3009.00, 3540.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (829, 'JVC-034', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 20\" - MARCA: SPEED POWER', 'Modelo: LPS-20 \nMotor: 1.5 HP \nVoltaje / Frecuencia: 220 V/60 Hz. \nVelocidad de Rotación: 175 RPM. \nEstrucura: Acero inoxidable \nPlato: Acero revestido de 20\" \nCable: Vulcanizado x 12 metros \nIncluye: Cepillo de lavar y lustrar de 19\"', 3540.00, 0.00, 3186.00, 3009.00, 3540.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (830, 'JVC-035', NULL, 'LAVADORA DE ALFOMBRAS DE 18\" (SISTEMA CONVESIONAL) - MARCA: SPEED POWER', 'Modelo: LSP-16C \nMotor: 1.5HP / 1710 RPM \nSistema de lavado: Sistema de inyección por gravedad \nCapacidad del Tanque: 12 Litros polietileno \nEstructura: Acero Plato: 18\" \nCable: Vulcanizado de 12 metros \nIncluye: Cepillo ranurado de lavar alfombras 16\"', 3894.00, 0.00, 3504.60, 3309.90, 3894.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (831, 'JVC-035', NULL, 'LAVADORA DE ALFOMBRAS DE 18\" (SISTEMA CONVESIONAL) - MARCA: SPEED POWER', 'Modelo: LSP-16C \nMotor: 1.5HP / 1710 RPM \nSistema de lavado: Sistema de inyección por gravedad \nCapacidad del Tanque: 12 Litros polietileno \nEstructura: Acero Plato: 18\" \nCable: Vulcanizado de 12 metros \nIncluye: Cepillo ranurado de lavar alfombras 16\"', 3894.00, 0.00, 3504.60, 3309.90, 3894.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (832, 'JVC-036', NULL, 'LAVADORA DE ALFOMBRAS DE 18\" (SISTEMA GENERADOR ESPUMA) - MARCA: SPEED POWER', 'Modelo: LSP-15A \nMotor: 1.5HP / 1710 RPM \nSistema de lavado: Sistema generador de espuma \nCapacidad del Tanque: 12 Litros \nEstructura: Acero Plato: 18\" \nCable: Vulcanizado de 12 metros \nIncluye: Cepillo ranurado de lavar alfombras 16\"', 4484.00, 0.00, 4035.60, 3811.40, 4484.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (833, 'JVC-036', NULL, 'LAVADORA DE ALFOMBRAS DE 18\" (SISTEMA GENERADOR ESPUMA) - MARCA: SPEED POWER', 'Modelo: LSP-15A \nMotor: 1.5HP / 1710 RPM \nSistema de lavado: Sistema generador de espuma \nCapacidad del Tanque: 12 Litros \nEstructura: Acero Plato: 18\" \nCable: Vulcanizado de 12 metros \nIncluye: Cepillo ranurado de lavar alfombras 16\"', 4484.00, 0.00, 4035.60, 3811.40, 4484.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (834, 'JVC-037-1', NULL, 'LIMPIADOR Y SECADOR DE ALFOMBRAS (AZUL) - MARCA: MASTER GOLDS', 'Modelo: LIE-J4-A \nMotor: 3290W \nMotor de succión: 1000W \nTanque de agua limpia: 20 LT\nTanque de agua residual: 18 LT\nIncluye: Kit de accesorios', 6490.00, 0.00, 5841.00, 5516.50, 6490.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (835, 'JVC-037-1', NULL, 'LIMPIADOR Y SECADOR DE ALFOMBRAS (AZUL) - MARCA: MASTER GOLDS', 'Modelo: LIE-J4-A \nMotor: 3290W \nMotor de succión: 1000W \nTanque de agua limpia: 20 LT\nTanque de agua residual: 18 LT\nIncluye: Kit de accesorios', 6490.00, 0.00, 5841.00, 5516.50, 6490.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (836, 'JVC-037-2', NULL, 'LIMPIADOR Y SECADOR DE ALFOMBRAS (PLOMO) - MARCA: MASTER GOLDS', 'Modelo: LAMG \nMotor: 3290W \nMotor de succión: 1000W \nTanque de agua limpia: 20 LT\nTanque de agua residual: 18 LT\nIncluye: Kit de accesorios', 7552.00, 0.00, 6796.80, 6419.20, 7552.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (837, 'JVC-037-2', NULL, 'LIMPIADOR Y SECADOR DE ALFOMBRAS (PLOMO) - MARCA: MASTER GOLDS', 'Modelo: LAMG \nMotor: 3290W \nMotor de succión: 1000W \nTanque de agua limpia: 20 LT\nTanque de agua residual: 18 LT\nIncluye: Kit de accesorios', 7552.00, 0.00, 6796.80, 6419.20, 7552.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (838, 'JVC-038-1', NULL, 'LIMPIADOR INDUSTRIAL DE ESCALERAS ELÉCTRICAS (CON CABLE) - MARCA: MASTER GOLDS', 'Modelo: MLE-SC450 \nMotor: 1000W \nVoltaje: 220-240V/60Hz \nAncho de trabajo: 450mm \nCapacidad: 20 LT\nCable vulcanizado', 6962.00, 0.00, 6265.80, 5917.70, 6962.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (839, 'JVC-038-1', NULL, 'LIMPIADOR INDUSTRIAL DE ESCALERAS ELÉCTRICAS (CON CABLE) - MARCA: MASTER GOLDS', 'Modelo: MLE-SC450 \nMotor: 1000W \nVoltaje: 220-240V/60Hz \nAncho de trabajo: 450mm \nCapacidad: 20 LT\nCable vulcanizado', 6962.00, 0.00, 6265.80, 5917.70, 6962.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (840, 'JVC-038-2', NULL, 'LIMPIADOR INDUSTRIAL DE ESCALERAS ELÉCTRICAS (A BATERÍA) - MARCA: MASTER GOLDS', 'Modelo: MLE-SC450D \nEnergía: 500W \nVoltaje: 24V \nAncho de trabajo: 450mm \nCapacidad: 20L \nBatería: 2 x 12V \nHoras de trabajo: 2 horas aprox.', 8142.00, 0.00, 7327.80, 6920.70, 8142.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (841, 'JVC-038-2', NULL, 'LIMPIADOR INDUSTRIAL DE ESCALERAS ELÉCTRICAS (A BATERÍA) - MARCA: MASTER GOLDS', 'Modelo: MLE-SC450D \nEnergía: 500W \nVoltaje: 24V \nAncho de trabajo: 450mm \nCapacidad: 20L \nBatería: 2 x 12V \nHoras de trabajo: 2 horas aprox.', 8142.00, 0.00, 7327.80, 6920.70, 8142.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (842, 'JVC-039', NULL, 'LAVADORA Y SECADORA DE MUEBLES Y COLCHONES (LAVA BUTACAS) - MARCA: MASTER GOLDS', 'Modelo: MLC-730 \nMotor: 1000W \nMotor Cepillo: 32 V \nCapacidad tanque solución: 16L \nCapacidad tanque recuperación: 12L \nManguera: 1.5 metros \nCable: vulcanizado de 8 metros \nIncluye: Kit de accesorios', 5664.00, 0.00, 5097.60, 4814.40, 5664.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (843, 'JVC-039', NULL, 'LAVADORA Y SECADORA DE MUEBLES Y COLCHONES (LAVA BUTACAS) - MARCA: MASTER GOLDS', 'Modelo: MLC-730 \nMotor: 1000W \nMotor Cepillo: 32 V \nCapacidad tanque solución: 16L \nCapacidad tanque recuperación: 12L \nManguera: 1.5 metros \nCable: vulcanizado de 8 metros \nIncluye: Kit de accesorios', 5664.00, 0.00, 5097.60, 4814.40, 5664.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (844, 'JVC-040', NULL, 'SECADORA INDUSTRIAL DE PISOS Y ALFOMBRAS DE 350W (BLOWER) - MARCA: SPEED POWER', 'Modelo: SSL-350 \nPotencia: 350W \nCaudales regulables: Baja - Media - Alta \nVelocidad: 3 Temporizador: 30 - 60 - 90 minutos \nCable: Vulcanizado de 8 metros', 885.00, 0.00, 796.50, 752.25, 885.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (845, 'JVC-040', NULL, 'SECADORA INDUSTRIAL DE PISOS Y ALFOMBRAS DE 350W (BLOWER) - MARCA: SPEED POWER', 'Modelo: SSL-350 \nPotencia: 350W \nCaudales regulables: Baja - Media - Alta \nVelocidad: 3 Temporizador: 30 - 60 - 90 minutos \nCable: Vulcanizado de 8 metros', 885.00, 0.00, 796.50, 752.25, 885.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (846, 'JVC-040-1', NULL, 'SECADORA INDUSTRIAL DE PISOS Y ALFOMBRAS DE 850W (RUEDA DE TRANSPORTE) - MARCA: GAOMEI', 'Modelo: B-3 \nPotencia: 850W \nCaudales regulables: 2500 - 3400 - 4200 m3/h \nCable: Vulcanizado de 7 metros', 1180.00, 0.00, 1062.00, 1003.00, 1180.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (847, 'JVC-040-1', NULL, 'SECADORA INDUSTRIAL DE PISOS Y ALFOMBRAS DE 850W (RUEDA DE TRANSPORTE) - MARCA: GAOMEI', 'Modelo: B-3 \nPotencia: 850W \nCaudales regulables: 2500 - 3400 - 4200 m3/h \nCable: Vulcanizado de 7 metros', 1180.00, 0.00, 1062.00, 1003.00, 1180.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (848, 'JVC-041', NULL, 'SECADORA INDUSTRIAL DE ALFOMBRAS Y PASADIZOS DE 900W - MARCA: MASTER GOLDS', 'Modelo: SMG-900 \nPotencia: 900W \nVelocidades: 3\nCaudales regulables: 2500 - 3400 - 4200 m3/h \nCable: Vulcanizado de 7 metros', 1298.00, 0.00, 1168.20, 1103.30, 1298.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (849, 'JVC-041', NULL, 'SECADORA INDUSTRIAL DE ALFOMBRAS Y PASADIZOS DE 900W - MARCA: MASTER GOLDS', 'Modelo: SMG-900 \nPotencia: 900W \nVelocidades: 3\nCaudales regulables: 2500 - 3400 - 4200 m3/h \nCable: Vulcanizado de 7 metros', 1298.00, 0.00, 1168.20, 1103.30, 1298.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (850, 'JVC-042', NULL, 'SECADORA INDUSTRIAL DE ALFOMBRAS Y PASADIZOS DE 900W (RUEDA DE TRANSPORTE) - MARCA: MASTER GOLDS', 'Modelo: SMG-900B \nPotencia: 900W \nVelocidades: 3\nCaudales regulables: 2500 - 3400 - 4200 m3/h \nCon manija de transporte\nCable: vulcanizado de 7 metros', 1475.00, 0.00, 1327.50, 1253.75, 1475.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (851, 'JVC-042', NULL, 'SECADORA INDUSTRIAL DE ALFOMBRAS Y PASADIZOS DE 900W (RUEDA DE TRANSPORTE) - MARCA: MASTER GOLDS', 'Modelo: SMG-900B \nPotencia: 900W \nVelocidades: 3\nCaudales regulables: 2500 - 3400 - 4200 m3/h \nCon manija de transporte\nCable: vulcanizado de 7 metros', 1475.00, 0.00, 1327.50, 1253.75, 1475.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (852, 'JVC-043', NULL, 'VAPORIZADORA DE ALTA PRESIÓN DE 2200W - MARCA: MASTER GOLDS', 'Modelo: VMG-1800 \nPotencia: 2200W \nNivel de vapor: 02 \nDepósito de agua: 2L \nMaterial: ABS, Acero inox \nCable: Vulcanizado de 5 metros \nIncluye: Kit de accesorios', 3304.00, 0.00, 2973.60, 2808.40, 3304.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (853, 'JVC-043', NULL, 'VAPORIZADORA DE ALTA PRESIÓN DE 2200W - MARCA: MASTER GOLDS', 'Modelo: VMG-1800 \nPotencia: 2200W \nNivel de vapor: 02 \nDepósito de agua: 2L \nMaterial: ABS, Acero inox \nCable: Vulcanizado de 5 metros \nIncluye: Kit de accesorios', 3304.00, 0.00, 2973.60, 2808.40, 3304.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (854, 'JVC-044', NULL, 'VAPORIZADOR DE ALTA PRESIÓN DE 2200W - MARCA: MASTER GOLDS', 'Modelo: VMG-1800 \nPotencia: 2200W \nNivel de vapor: 04 \nDepósito de agua: 5L Material: ABS, Acero inox \nCable: Vulcanizado de 5 metros \nIncluye: Kit de accesorios', 2950.00, 0.00, 2655.00, 2507.50, 2950.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (855, 'JVC-044', NULL, 'VAPORIZADOR DE ALTA PRESIÓN DE 2200W - MARCA: MASTER GOLDS', 'Modelo: VMG-1800 \nPotencia: 2200W \nNivel de vapor: 04 \nDepósito de agua: 5L Material: ABS, Acero inox \nCable: Vulcanizado de 5 metros \nIncluye: Kit de accesorios', 2950.00, 0.00, 2655.00, 2507.50, 2950.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (856, 'JVC-045', NULL, 'BARREDORA INDUSTRIAL MECÁNICA (HOMBRE ANDANTE) - MARCA: MASTER GOLDS', 'Modelo: BMG-B40L \nEficiencia de trabajo: 3680 m2/h \nAncho de limpieza: 920 mm \nVolumen de basura: 40L', 2714.00, 0.00, 2442.60, 2306.90, 2714.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (857, 'JVC-045', NULL, 'BARREDORA INDUSTRIAL MECÁNICA (HOMBRE ANDANTE) - MARCA: MASTER GOLDS', 'Modelo: BMG-B40L \nEficiencia de trabajo: 3680 m2/h \nAncho de limpieza: 920 mm \nVolumen de basura: 40L', 2714.00, 0.00, 2442.60, 2306.90, 2714.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (858, 'JVC-045-1', NULL, 'BARREDORA INDUSTRIAL (HOMBRE ANDANTE) CAPACIDAD 45 LT - MASTER GOLDS', '', 11210.00, 0.00, 10089.00, 9528.50, 11210.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (859, 'JVC-045-1', NULL, 'BARREDORA INDUSTRIAL (HOMBRE ANDANTE) CAPACIDAD 45 LT - MASTER GOLDS', '', 11210.00, 0.00, 10089.00, 9528.50, 11210.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (860, 'JVC-046', NULL, 'BARREDORA INDUSTRIAL (HOMBRE ANDANTE) CAPACIDAD 35 LT - MASTER GOLDS', 'Modelo: MG-60', 10620.00, 0.00, 9558.00, 9027.00, 10620.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (861, 'JVC-046', NULL, 'BARREDORA INDUSTRIAL (HOMBRE ANDANTE) CAPACIDAD 35 LT - MASTER GOLDS', 'Modelo: MG-60', 10620.00, 0.00, 9558.00, 9027.00, 10620.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (862, 'JVC-047', NULL, 'BARREDORA INDUSTRIAL 180 LT (HOMBRE ABORDO) - MARCA: MASTER GOLDS', 'Modelo: BEM-1800 \nPotencia de motor: 1200W \nBatería: 8 x 48V \nProductividad de trabajo: 12500 m2/h \nTanque de recolección: 180L \nCantidad Cepillos: 5 unidades \nHoras de trabajo: 5 - 6 horas', 25960.00, 0.00, 23364.00, 22066.00, 25960.00, 1, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (863, 'JVC-047', NULL, 'BARREDORA INDUSTRIAL 180 LT (HOMBRE ABORDO) - MARCA: MASTER GOLDS', 'Modelo: BEM-1800 \nPotencia de motor: 1200W \nBatería: 8 x 48V \nProductividad de trabajo: 12500 m2/h \nTanque de recolección: 180L \nCantidad Cepillos: 5 unidades \nHoras de trabajo: 5 - 6 horas', 25960.00, 0.00, 23364.00, 22066.00, 25960.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (864, 'JVC-048', NULL, 'HIDROLAVADORA INDUSTRIAL (MONOFÁSICA) - MARCA: MASTER GOLDS', 'Modelo: HMG6-15CL \nPotencia KW: 3.1KW \nVoltaje/Hz: 220V/60Hz \nFlujo de agua: 560 L/H \nBarra de presión: 150 bar', 4956.00, 0.00, 4460.40, 4212.60, 4956.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (865, 'JVC-048', NULL, 'HIDROLAVADORA INDUSTRIAL (MONOFÁSICA) - MARCA: MASTER GOLDS', 'Modelo: HMG6-15CL \nPotencia KW: 3.1KW \nVoltaje/Hz: 220V/60Hz \nFlujo de agua: 560 L/H \nBarra de presión: 150 bar', 4956.00, 0.00, 4460.40, 4212.60, 4956.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (866, 'JVC-049', NULL, 'HIDROLAVADORA INDUSTRIAL (TRIFÁSICA) - MARCA: MASTER GOLDS', 'Modelo: HMG7-18CL \nPotencia KW: 4.7KW \nVoltaje/Hz: 380V/60Hz \nFlujo de agua: 700 L/H \nBarra de presión: 180 bar', 6844.00, 0.00, 6159.60, 5817.40, 6844.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (867, 'JVC-049', NULL, 'HIDROLAVADORA INDUSTRIAL (TRIFÁSICA) - MARCA: MASTER GOLDS', 'Modelo: HMG7-18CL \nPotencia KW: 4.7KW \nVoltaje/Hz: 380V/60Hz \nFlujo de agua: 700 L/H \nBarra de presión: 180 bar', 6844.00, 0.00, 6159.60, 5817.40, 6844.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (868, 'JVC-050', NULL, 'FREGADORA SEMI INDUSTRIAL ELÉCTRICA (CEPILLO 14\') - MARCA: MASTER GOLDS', 'Modelo: FMG-K201 \nPotencia: 550W \nVoltaje/Hz: 220V/60Hz \nCapacidad de trabajo: 1100 m2/h \nCapacidad de tanque de solución: 11.8L \nCapacidad de tanque de recuperación: 13.4L \nCable: Vulcanizado 25 metros', 5900.00, 0.00, 5310.00, 5015.00, 5900.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (869, 'JVC-050', NULL, 'FREGADORA SEMI INDUSTRIAL ELÉCTRICA (CEPILLO 14\') - MARCA: MASTER GOLDS', 'Modelo: FMG-K201 \nPotencia: 550W \nVoltaje/Hz: 220V/60Hz \nCapacidad de trabajo: 1100 m2/h \nCapacidad de tanque de solución: 11.8L \nCapacidad de tanque de recuperación: 13.4L \nCable: Vulcanizado 25 metros', 5900.00, 0.00, 5310.00, 5015.00, 5900.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (870, 'JVC-051', NULL, 'FREGADORA INDUSTRIAL DE PISOS DE 19\" A BATERIA - MARCA: SPEED POWER', '', 15930.00, 0.00, 14337.00, 13540.50, 15930.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (871, 'JVC-051', NULL, 'FREGADORA INDUSTRIAL DE PISOS DE 19\" A BATERIA - MARCA: SPEED POWER', '', 15930.00, 0.00, 14337.00, 13540.50, 15930.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (872, 'JVC-052', NULL, 'FREGADORA INDUSTRIAL DE PISOS DE 18\" A BATERIA - MARCA: MASTER GOLDS', '', 17110.00, 0.00, 15399.00, 14543.50, 17110.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (873, 'JVC-052', NULL, 'FREGADORA INDUSTRIAL DE PISOS DE 18\" A BATERIA - MARCA: MASTER GOLDS', '', 17110.00, 0.00, 15399.00, 14543.50, 17110.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (874, 'JVC-053', NULL, 'FREGADORA INDUSTRIAL DE PISOS DE 19\" A BATERIA - MARCA: MASTER GOLDS', '', 20650.00, 0.00, 18585.00, 17552.50, 20650.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (875, 'JVC-053', NULL, 'FREGADORA INDUSTRIAL DE PISOS DE 19\" A BATERIA - MARCA: MASTER GOLDS', '', 20650.00, 0.00, 18585.00, 17552.50, 20650.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (876, 'JVC-054-1', NULL, 'LAVADORA SECADORA PROFESIONAL DE PISOS CON MOTOR DE TRACCIÓN DE 19\" (HOMBRE ANDANTE) - MARCA: TVX', 'Modelo: T55BT \nBatería : 2 x 12V \nCapacidad de trabajo: 2250 m2/h \nAncho de área de trabajo: 510 mm \nCapacidad de tanque de solución: 55L \nCapacidad de tanque de recuperación: 65L \nIncluye: Cepillo y Porta Pad de 19\"', 7734.90, 0.00, 6961.41, 6574.66, 7734.90, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (877, 'JVC-054-1', NULL, 'LAVADORA SECADORA PROFESIONAL DE PISOS CON MOTOR DE TRACCIÓN DE 19\" (HOMBRE ANDANTE) - MARCA: TVX', 'Modelo: T55BT \nBatería : 2 x 12V \nCapacidad de trabajo: 2250 m2/h \nAncho de área de trabajo: 510 mm \nCapacidad de tanque de solución: 55L \nCapacidad de tanque de recuperación: 65L \nIncluye: Cepillo y Porta Pad de 19\"', 7734.90, 0.00, 6961.41, 6574.66, 7734.90, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (878, 'JVC-054-2', NULL, 'LAVADORA SECADORA PROFESIONAL DE PISOS CON MOTOR DE TRACCIÓN DE 21\" (HOMBRE A BORDO) - MARCA: TVX', 'Modelo: T90 \nBatería : 2 x 12V \nCapacidad de trabajo: 2800 m2/h \nAncho de área de trabajo: 560 mm \nCapacidad de tanque de solución: 90L \nCapacidad de tanque de recuperación: 100L \nIncluye: Cepillo y Porta Pad de 21\"', 10413.50, 0.00, 9372.15, 8851.48, 10413.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (879, 'JVC-054-2', NULL, 'LAVADORA SECADORA PROFESIONAL DE PISOS CON MOTOR DE TRACCIÓN DE 21\" (HOMBRE A BORDO) - MARCA: TVX', 'Modelo: T90 \nBatería : 2 x 12V \nCapacidad de trabajo: 2800 m2/h \nAncho de área de trabajo: 560 mm \nCapacidad de tanque de solución: 90L \nCapacidad de tanque de recuperación: 100L \nIncluye: Cepillo y Porta Pad de 21\"', 10413.50, 0.00, 9372.15, 8851.48, 10413.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (880, 'JVC-054-3', NULL, 'LAVADORA SECADORA PROFESIONAL DE PISOS DE 16\" DOBLE (HOMBRE A BORDO) - MARCA: TVX', 'Modelo: T130 (DOBLE CEPILLO) \nBatería : 24V / 200AH \nCapacidad de trabajo: 5590 m2/h \nAncho de área de trabajo: 860 mm \nCapacidad de tanque de solución: 120L \nCapacidad de tanque de recuperación: 130L \nIncluye: 2 cepillos y Porta Pad de 16\"', 15133.50, 0.00, 13620.15, 12863.47, 15133.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (881, 'JVC-054-3', NULL, 'LAVADORA SECADORA PROFESIONAL DE PISOS DE 16\" DOBLE (HOMBRE A BORDO) - MARCA: TVX', 'Modelo: T130 (DOBLE CEPILLO) \nBatería : 24V / 200AH \nCapacidad de trabajo: 5590 m2/h \nAncho de área de trabajo: 860 mm \nCapacidad de tanque de solución: 120L \nCapacidad de tanque de recuperación: 130L \nIncluye: 2 cepillos y Porta Pad de 16\"', 15133.50, 0.00, 13620.15, 12863.47, 15133.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (882, 'JVC-054-4', NULL, 'LAVADORA SECADORA PROFESIONAL DE PISOS DE 16\" DOBLE (HOMBRE A BORDO) - MARCA: TVX', 'Modelo: T150 (DOBLE CEPILLO) \nBatería : 3 x 12V\nCapacidad de trabajo: 5590 m2/h \nAncho de área de trabajo: 860 mm \nCapacidad de tanque de solución: 150L \nCapacidad de tanque de recuperación: 170L \nIncluye: Cepillo y Porta Pad de 16\"', 18673.50, 0.00, 16806.15, 15872.47, 18673.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (883, 'JVC-054-4', NULL, 'LAVADORA SECADORA PROFESIONAL DE PISOS DE 16\" DOBLE (HOMBRE A BORDO) - MARCA: TVX', 'Modelo: T150 (DOBLE CEPILLO) \nBatería : 3 x 12V\nCapacidad de trabajo: 5590 m2/h \nAncho de área de trabajo: 860 mm \nCapacidad de tanque de solución: 150L \nCapacidad de tanque de recuperación: 170L \nIncluye: Cepillo y Porta Pad de 16\"', 18673.50, 0.00, 16806.15, 15872.47, 18673.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (884, 'JVC-055', NULL, 'TERMONEBULIZADORA (CAÑON CORTO) - MARCA: MASTER FOG', 'Modelo: TMG-T34 \nFuente de alimentación: 4 x 1.5V \nCaudal Max: 25L/H \nCapacidad de tanque de solución: 6 LT \nCapacidad de tanque de combustión: 2 LT', 6490.00, 0.00, 5841.00, 5516.50, 6490.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (885, 'JVC-055', NULL, 'TERMONEBULIZADORA (CAÑON CORTO) - MARCA: MASTER FOG', 'Modelo: TMG-T34 \nFuente de alimentación: 4 x 1.5V \nCaudal Max: 25L/H \nCapacidad de tanque de solución: 6 LT \nCapacidad de tanque de combustión: 2 LT', 6490.00, 0.00, 5841.00, 5516.50, 6490.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (886, 'JVC-056', NULL, 'TERMONEBULIZADORA (CAÑON LARGO) - MARCA: MASTER FOG', 'Modelo: TMG-BW-20 \nFuente de alimentación: 4 x 1.5V \nCaudal Max: 45L/H \nCapacidad de tanque de solución: 6 LT \nCapacidad de tanque de combustión: 2 LT', 5900.00, 0.00, 5310.00, 5015.00, 5900.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (887, 'JVC-056', NULL, 'TERMONEBULIZADORA (CAÑON LARGO) - MARCA: MASTER FOG', 'Modelo: TMG-BW-20 \nFuente de alimentación: 4 x 1.5V \nCaudal Max: 45L/H \nCapacidad de tanque de solución: 6 LT \nCapacidad de tanque de combustión: 2 LT', 5900.00, 0.00, 5310.00, 5015.00, 5900.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (888, 'JVC-057', NULL, 'MÁQUINA ULV 2.5 LITROS (A BATERÍA) - MARCA: MASTER FOG', 'Modelo: UMG-3600B \nMotor eléctrico: 450W \nBoquilla de nebulización: Contrarotativas\nCapacidad del tanque: 2.5L', 5310.00, 0.00, 4779.00, 4513.50, 5310.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (889, 'JVC-057', NULL, 'MÁQUINA ULV 2.5 LITROS (A BATERÍA) - MARCA: MASTER FOG', 'Modelo: UMG-3600B \nMotor eléctrico: 450W \nBoquilla de nebulización: Contrarotativas\nCapacidad del tanque: 2.5L', 5310.00, 0.00, 4779.00, 4513.50, 5310.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (890, 'JVC-058', NULL, 'MÁQUINA ULV 2.5 LITROS (ELÉCTRICO) - MARCA: MASTER FOG', 'Modelo: UMG-3600E \nMotor eléctrico: 800W - 220V \nBoquilla de nebulización: Contrarotativas \nCapacidad del tanque: 2.5 LT', 2714.00, 0.00, 2442.60, 2306.90, 2714.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (891, 'JVC-058', NULL, 'MÁQUINA ULV 2.5 LITROS (ELÉCTRICO) - MARCA: MASTER FOG', 'Modelo: UMG-3600E \nMotor eléctrico: 800W - 220V \nBoquilla de nebulización: Contrarotativas \nCapacidad del tanque: 2.5 LT', 2714.00, 0.00, 2442.60, 2306.90, 2714.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (892, 'JVC-059', NULL, 'MÁQUINA ULV DE 5 LITROS (A BATERÍA) - MARCA: MASTER FOG', 'Modelo: PIONEER \nMotor eléctrico: 450W \nBoquilla de nebulización: Giratoria \nCapacidad del tanque: 5 LT', 7670.00, 0.00, 6903.00, 6519.50, 7670.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (893, 'JVC-059', NULL, 'MÁQUINA ULV DE 5 LITROS (A BATERÍA) - MARCA: MASTER FOG', 'Modelo: PIONEER \nMotor eléctrico: 450W \nBoquilla de nebulización: Giratoria \nCapacidad del tanque: 5 LT', 7670.00, 0.00, 6903.00, 6519.50, 7670.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (894, 'JVC-060', NULL, 'MÁQUINA ULV 6 LITROS (ÉLECTRICO) - MARCA: MASTER FOG', 'Modelo: UMG-2680A \nMotor eléctrico: 800W - 220V/60Hz \nBoquilla de nebulización: Contrarotativas \nCapacidad del tanque: 6 LT', 2478.00, 0.00, 2230.20, 2106.30, 2478.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (895, 'JVC-060', NULL, 'MÁQUINA ULV 6 LITROS (ÉLECTRICO) - MARCA: MASTER FOG', 'Modelo: UMG-2680A \nMotor eléctrico: 800W - 220V/60Hz \nBoquilla de nebulización: Contrarotativas \nCapacidad del tanque: 6 LT', 2478.00, 0.00, 2230.20, 2106.30, 2478.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (896, 'JVC-061', NULL, 'MÁQUINA ULV DE 10 LITROS (ÉLECTRICO) - MARCA: MASTER FOG', 'Modelo: UMG-1500 \nMotor eléctrico: 1400W - 220V/60Hz \nBoquilla de nebulización: Tipo remolino \nCapacidad del tanque: 10 LT', 2507.50, 0.00, 2256.75, 2131.38, 2507.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (897, 'JVC-061', NULL, 'MÁQUINA ULV DE 10 LITROS (ÉLECTRICO) - MARCA: MASTER FOG', 'Modelo: UMG-1500 \nMotor eléctrico: 1400W - 220V/60Hz \nBoquilla de nebulización: Tipo remolino \nCapacidad del tanque: 10 LT', 2507.50, 0.00, 2256.75, 2131.38, 2507.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (898, 'JVC-062', NULL, 'MÁQUINA ULV DE 12 LITROS (ÉLECTRICO) - MARCA: MASTER FOG', 'Modelo: UMG-1500E \nMotor eléctrico: 1400W - 220V/60Hz \nBoquilla de nebulización: Tipo remolino \nCapacidad del tanque: 12L', 2625.50, 0.00, 2362.95, 2231.68, 2625.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (899, 'JVC-062', NULL, 'MÁQUINA ULV DE 12 LITROS (ÉLECTRICO) - MARCA: MASTER FOG', 'Modelo: UMG-1500E \nMotor eléctrico: 1400W - 220V/60Hz \nBoquilla de nebulización: Tipo remolino \nCapacidad del tanque: 12L', 2625.50, 0.00, 2362.95, 2231.68, 2625.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (900, 'JVC-063', NULL, 'MÁQUINA ULV DE 16 LITROS (ÉLECTRICO) - MARCA: MASTER FOG', 'Modelo: UMG-1500MP \nMotor eléctrico: 1400W - 220V/60Hz \nBoquilla de nebulización: Tipo remolino \nCapacidad del tanque: 16 LT', 2743.50, 0.00, 2469.15, 2331.98, 2743.50, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (901, 'JVC-063', NULL, 'MÁQUINA ULV DE 16 LITROS (ÉLECTRICO) - MARCA: MASTER FOG', 'Modelo: UMG-1500MP \nMotor eléctrico: 1400W - 220V/60Hz \nBoquilla de nebulización: Tipo remolino \nCapacidad del tanque: 16 LT', 2743.50, 0.00, 2469.15, 2331.98, 2743.50, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (902, 'JVC-064', NULL, 'MOCHILA PULVERIZADORA DE 20 LITROS (MANUAL) - MARCA: MASTER FOG', 'Modelo: PMG-20L \nManguera: 13500 mm \nLanza: 600 mm \nCapacidad del tanque: 20 LT \nMaterial del tanque: Polipropileno', 295.00, 0.00, 265.50, 250.75, 295.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (903, 'JVC-064', NULL, 'MOCHILA PULVERIZADORA DE 20 LITROS (MANUAL) - MARCA: MASTER FOG', 'Modelo: PMG-20L \nManguera: 13500 mm \nLanza: 600 mm \nCapacidad del tanque: 20 LT \nMaterial del tanque: Polipropileno', 295.00, 0.00, 265.50, 250.75, 295.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (904, 'JVC-065', NULL, 'MOTO ATOMIZADORA DE 14 LITROS (MOTOR 2 TIEMPOS) - MARCA: MASTER FOG', 'Modelo: NTS420 \nTipo de motor: 2 tiempos \nCilindro de desplazamiento: 56.5cc \nPotencia de salida: 3.0kW/4.0hp \nVelocidad máxima del motor: 6000rpm \nCapacidad del tanque de combustible: 1.5 LT \nCacidad del tanque Quimico: 14 LT', 2301.00, 0.00, 2070.90, 1955.85, 2301.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (905, 'JVC-065', NULL, 'MOTO ATOMIZADORA DE 14 LITROS (MOTOR 2 TIEMPOS) - MARCA: MASTER FOG', 'Modelo: NTS420 \nTipo de motor: 2 tiempos \nCilindro de desplazamiento: 56.5cc \nPotencia de salida: 3.0kW/4.0hp \nVelocidad máxima del motor: 6000rpm \nCapacidad del tanque de combustible: 1.5 LT \nCacidad del tanque Quimico: 14 LT', 2301.00, 0.00, 2070.90, 1955.85, 2301.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (906, 'JVC-066', NULL, 'MOTO PULVERIZADORA DE 25 LITROS (MOTOR 2 TIEMPOS) - MARCA: MASTER FOG', 'Modelo: NTS-768 \nTipo de motor: 2 tiempos \nCilindro de desplazamiento: 26cc \nPotencia de salida: 3.0kW/4.0hp \nVelocidad máxima del motor: 7500rpm \nCapacidad del tanque de combustible: 0.9 LT \nCacidad del tanque Quimico: 25 LT', 1947.00, 0.00, 1752.30, 1654.95, 1947.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (907, 'JVC-066', NULL, 'MOTO PULVERIZADORA DE 25 LITROS (MOTOR 2 TIEMPOS) - MARCA: MASTER FOG', 'Modelo: NTS-768 \nTipo de motor: 2 tiempos \nCilindro de desplazamiento: 26cc \nPotencia de salida: 3.0kW/4.0hp \nVelocidad máxima del motor: 7500rpm \nCapacidad del tanque de combustible: 0.9 LT \nCacidad del tanque Quimico: 25 LT', 1947.00, 0.00, 1752.30, 1654.95, 1947.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (908, 'JVC-067', NULL, 'MÁQUINA DESBROZADORA 2 TIEMPOS (MOTOGUADAÑA) - MARCA: MASTER GREEN', 'Modelo: 541RS \nMotor: 2.2 HP \nTipo de motor: 2 tiempos \nCilindro de desplazamiento: 43cc \nPotencia de salida: 1.47kW \nVelocidad máxima del motor: 7000rpm \nCapacidad de combustible: 950 ml \nIncluye: Cuchilla 2T', 2832.00, 0.00, 2548.80, 2407.20, 2832.00, -1, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (909, 'JVC-067', NULL, 'MÁQUINA DESBROZADORA 2 TIEMPOS (MOTOGUADAÑA) - MARCA: MASTER GREEN', 'Modelo: 541RS \nMotor: 2.2 HP \nTipo de motor: 2 tiempos \nCilindro de desplazamiento: 43cc \nPotencia de salida: 1.47kW \nVelocidad máxima del motor: 7000rpm \nCapacidad de combustible: 950 ml \nIncluye: Cuchilla 2T', 2832.00, 0.00, 2548.80, 2407.20, 2832.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (910, 'JVC-068', NULL, 'MÁQUINA DESBROZADORA 2 TIEMPOS (MOTOGUADAÑA) - MARCA: MASTER GREEN', 'Modelo: 143R-II \nMotor: 1.4 HP \nTipo de motor: 2 tiempos \nCilindro de desplazamiento: 41.5cc \nPotencia de salida: 1.47kW \nVelocidad máxima del motor: 7000rpm \nCapacidad de combustible: 950 ml \nIncluye: Cuchilla 2T', 2655.00, 40.00, 2389.50, 2256.75, 2655.00, 20, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (911, 'JVC-068', NULL, 'MÁQUINA DESBROZADORA 2 TIEMPOS (MOTOGUADAÑA) - MARCA: MASTER GREEN', 'Modelo: 143R-II \nMotor: 1.4 HP \nTipo de motor: 2 tiempos \nCilindro de desplazamiento: 41.5cc \nPotencia de salida: 1.47kW \nVelocidad máxima del motor: 7000rpm \nCapacidad de combustible: 950 ml \nIncluye: Cuchilla 2T', 2655.00, 40.00, 2389.50, 2256.75, 2655.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (912, 'JVC-069', NULL, 'MÁQUINA DESBROZADORA 4 TIEMPOS (MOTOGUADAÑA) - MARCA: MASTER GREEN', 'Modelo: GX50 \nMotor: 2.2 HP \nTipo de motor: 4 tiempos \nCilindro de desplazamiento: 47.9cc \nPotencia de salida: 1.47kW \nVelocidad máxima del motor: 9500rpm \nCapacidad de combustible: 950 ml \nIncluye: Cuchilla 2T', 2183.00, 0.00, 1964.70, 1855.55, 2183.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (913, 'JVC-069', NULL, 'MÁQUINA DESBROZADORA 4 TIEMPOS (MOTOGUADAÑA) - MARCA: MASTER GREEN', 'Modelo: GX50 \nMotor: 2.2 HP \nTipo de motor: 4 tiempos \nCilindro de desplazamiento: 47.9cc \nPotencia de salida: 1.47kW \nVelocidad máxima del motor: 9500rpm \nCapacidad de combustible: 950 ml \nIncluye: Cuchilla 2T', 2183.00, 0.00, 1964.70, 1855.55, 2183.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (914, 'JVC-070', NULL, 'MÁQUINA CORTADORA DE CÉSPED DE 16\" (4 TIEMPOS) - MARCA: NEWTOP', 'Modelo: NTLM16 \nMotor: 3.5 HP / 3600rpm \nAncho de corte: 16\" / 410mm \nPasos de altura de corte: 6 posiciones \nCapacidad del tanque de combusteble: 0.75 LT\nCapacidad del colector: 40 LT', 3068.00, 0.00, 2761.20, 2607.80, 3068.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (915, 'JVC-070', NULL, 'MÁQUINA CORTADORA DE CÉSPED DE 16\" (4 TIEMPOS) - MARCA: NEWTOP', 'Modelo: NTLM16 \nMotor: 3.5 HP / 3600rpm \nAncho de corte: 16\" / 410mm \nPasos de altura de corte: 6 posiciones \nCapacidad del tanque de combusteble: 0.75 LT\nCapacidad del colector: 40 LT', 3068.00, 0.00, 2761.20, 2607.80, 3068.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (916, 'JVC-071', NULL, 'MÁQUINA CORTADORA DE CÉSPED DE 18\"(4 TIEMPOS) - MARCA: NEWTOP', 'Modelo: NTLM18 \nMotor: 4.0 HP / 3600rpm \nAncho de corte: 18\" / 460mm \nPasos de altura de corte: 10 posiciones \nCapacidad del tanque de combusteble: 0.8 LT \nCapacidad del colector: 60 LT', 3304.00, 0.00, 2973.60, 2808.40, 3304.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (917, 'JVC-071', NULL, 'MÁQUINA CORTADORA DE CÉSPED DE 18\"(4 TIEMPOS) - MARCA: NEWTOP', 'Modelo: NTLM18 \nMotor: 4.0 HP / 3600rpm \nAncho de corte: 18\" / 460mm \nPasos de altura de corte: 10 posiciones \nCapacidad del tanque de combusteble: 0.8 LT \nCapacidad del colector: 60 LT', 3304.00, 0.00, 2973.60, 2808.40, 3304.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (918, 'JVC-072', NULL, 'MÁQUINA CORTADORA DE CÉSPED DE 21\"(4 TIEMPOS) - MARCA: NEWTOP', 'Modelo: NTLM21 \nMotor: 6.0 HP / 3600rpm \nAncho de corte: 21\" / 460mm \nPasos de altura de corte: 8 posiciones \nCapacidad del tanque de combusteble: 1.0 LT \nCapacidad del colector: 65 LT', 3658.00, 0.00, 3292.20, 3109.30, 3658.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (919, 'JVC-072', NULL, 'MÁQUINA CORTADORA DE CÉSPED DE 21\"(4 TIEMPOS) - MARCA: NEWTOP', 'Modelo: NTLM21 \nMotor: 6.0 HP / 3600rpm \nAncho de corte: 21\" / 460mm \nPasos de altura de corte: 8 posiciones \nCapacidad del tanque de combusteble: 1.0 LT \nCapacidad del colector: 65 LT', 3658.00, 0.00, 3292.20, 3109.30, 3658.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (920, 'JVC-073', NULL, 'MOTOSIERRA INDUSTRIAL CON ESPADA DE 20\" - MARCA: NEWTOP - MODELO: NT5800', '', 1700.00, 0.00, 0.00, 0.00, 1700.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (921, 'JVC-073', NULL, 'MOTOSIERRA INDUSTRIAL CON ESPADA DE 20\" - MARCA: NEWTOP - MODELO: NT5800', '', 1700.00, 0.00, 0.00, 0.00, 1700.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (922, 'P3M-001', NULL, 'DISCO PAD 3M DE 17\" COLOR: BLANCO', '', 58.48, 0.00, 52.63, 49.71, 58.48, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (923, 'P3M-001', NULL, 'DISCO PAD 3M DE 17\" COLOR: BLANCO', '', 58.48, 0.00, 52.63, 49.71, 58.48, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (924, 'P3M-002', NULL, 'DISCO PAD 3M DE 17\" COLOR: ROJO', '', 58.48, 0.00, 52.63, 49.71, 58.48, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (925, 'P3M-002', NULL, 'DISCO PAD 3M DE 17\" COLOR: ROJO', '', 58.48, 0.00, 52.63, 49.71, 58.48, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (926, 'P3M-003', NULL, 'DISCO PAD 3M DE 20\" COLOR: BLANCO', '', 62.66, 0.00, 56.39, 53.26, 62.66, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (927, 'P3M-003', NULL, 'DISCO PAD 3M DE 20\" COLOR: BLANCO', '', 62.66, 0.00, 56.39, 53.26, 62.66, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (928, 'P3M-004', NULL, 'DISCO PAD 3M DE 20\" COLOR: ROJO', '', 62.66, 0.00, 56.39, 53.26, 62.66, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (929, 'P3M-004', NULL, 'DISCO PAD 3M DE 20\" COLOR: ROJO', '', 62.66, 0.00, 56.39, 53.26, 62.66, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (930, 'P5M-001', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 16\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (931, 'P5M-001', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 16\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (932, 'P5M-002', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR NEGRO DE 16\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (933, 'P5M-002', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR NEGRO DE 16\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (934, 'P5M-003', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR ROJO DE 16\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (935, 'P5M-003', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR ROJO DE 16\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (936, 'P5M-004', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 18\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (937, 'P5M-004', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 18\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (938, 'P5M-005', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR NEGRO DE 18\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (939, 'P5M-005', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR NEGRO DE 18\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (940, 'P5M-006', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR ROJO DE 18\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (941, 'P5M-006', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR ROJO DE 18\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (942, 'P5M-007', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 20\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (943, 'P5M-007', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 20\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (944, 'P5M-008', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR NEGRO DE 20\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (945, 'P5M-008', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR NEGRO DE 20\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (946, 'P5M-009', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR ROJO DE 20\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (947, 'P5M-009', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR ROJO DE 20\" LIMKIT CLEANER 5M', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (948, 'PAD-001', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 14\" LIMKIT CLEANER', '', 28.32, 0.00, 25.49, 24.07, 28.32, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (949, 'PAD-001', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 14\" LIMKIT CLEANER', '', 28.32, 0.00, 25.49, 24.07, 28.32, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (950, 'PAD-002', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 14\" LIMKIT CLEANER', '', 28.32, 0.00, 25.49, 24.07, 28.32, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (951, 'PAD-002', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 14\" LIMKIT CLEANER', '', 28.32, 0.00, 25.49, 24.07, 28.32, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (952, 'PAD-003', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 14\" LIMKIT CLEANER', '', 28.32, 0.00, 25.49, 24.07, 28.32, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (953, 'PAD-003', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 14\" LIMKIT CLEANER', '', 28.32, 0.00, 25.49, 24.07, 28.32, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (954, 'PAD-004', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 14\" LIMKIT CLEANER', '', 28.32, 0.00, 25.49, 24.07, 28.32, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (955, 'PAD-004', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 14\" LIMKIT CLEANER', '', 28.32, 0.00, 25.49, 24.07, 28.32, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (956, 'PAD-005', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 14\" LIMKIT CLEANER', '', 28.32, 0.00, 25.49, 24.07, 28.32, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (957, 'PAD-005', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 14\" LIMKIT CLEANER', '', 28.32, 0.00, 25.49, 24.07, 28.32, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (958, 'PAD-006', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 15\" LIMKIT CLEANER', '', 31.86, 0.00, 28.67, 27.08, 31.86, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (959, 'PAD-006', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 15\" LIMKIT CLEANER', '', 31.86, 0.00, 28.67, 27.08, 31.86, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (960, 'PAD-007', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 15\" LIMKIT CLEANER', '', 31.86, 0.00, 28.67, 27.08, 31.86, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (961, 'PAD-007', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 15\" LIMKIT CLEANER', '', 31.86, 0.00, 28.67, 27.08, 31.86, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (962, 'PAD-008', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 15\" LIMKIT CLEANER', '', 31.86, 0.00, 28.67, 27.08, 31.86, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (963, 'PAD-008', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 15\" LIMKIT CLEANER', '', 31.86, 0.00, 28.67, 27.08, 31.86, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (964, 'PAD-009', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 15\" LIMKIT CLEANER', '', 31.86, 0.00, 28.67, 27.08, 31.86, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (965, 'PAD-009', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 15\" LIMKIT CLEANER', '', 31.86, 0.00, 28.67, 27.08, 31.86, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (966, 'PAD-010', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 15\" LIMKIT CLEANER', '', 31.86, 0.00, 28.67, 27.08, 31.86, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (967, 'PAD-010', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 15\" LIMKIT CLEANER', '', 31.86, 0.00, 28.67, 27.08, 31.86, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (968, 'PAD-011', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 16\" LIMKIT CLEANER', '', 35.40, 0.00, 31.86, 30.09, 35.40, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (969, 'PAD-011', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 16\" LIMKIT CLEANER', '', 35.40, 0.00, 31.86, 30.09, 35.40, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (970, 'PAD-012', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 16\" LIMKIT CLEANER', '', 35.40, 0.00, 31.86, 30.09, 35.40, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (971, 'PAD-012', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 16\" LIMKIT CLEANER', '', 35.40, 0.00, 31.86, 30.09, 35.40, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (972, 'PAD-013', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 16\" LIMKIT CLEANER', '', 35.40, 0.00, 31.86, 30.09, 35.40, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (973, 'PAD-013', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 16\" LIMKIT CLEANER', '', 35.40, 0.00, 31.86, 30.09, 35.40, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (974, 'PAD-014', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 16\" LIMKIT CLEANER', '', 35.40, 0.00, 31.86, 30.09, 35.40, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (975, 'PAD-014', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 16\" LIMKIT CLEANER', '', 35.40, 0.00, 31.86, 30.09, 35.40, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (976, 'PAD-015', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 16\" LIMKIT CLEANER', '', 35.40, 0.00, 31.86, 30.09, 35.40, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (977, 'PAD-015', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 16\" LIMKIT CLEANER', '', 35.40, 0.00, 31.86, 30.09, 35.40, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (978, 'PAD-016', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 17\" LIMKIT CLEANER', '', 38.94, 0.00, 35.05, 33.10, 38.94, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (979, 'PAD-016', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 17\" LIMKIT CLEANER', '', 38.94, 0.00, 35.05, 33.10, 38.94, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (980, 'PAD-017', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 17\" LIMKIT CLEANER', '', 38.94, 0.00, 35.05, 33.10, 38.94, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (981, 'PAD-017', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 17\" LIMKIT CLEANER', '', 38.94, 0.00, 35.05, 33.10, 38.94, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (982, 'PAD-018', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 17\" LIMKIT CLEANER', '', 38.94, 0.00, 35.05, 33.10, 38.94, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (983, 'PAD-018', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 17\" LIMKIT CLEANER', '', 38.94, 0.00, 35.05, 33.10, 38.94, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (984, 'PAD-019', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 17\" LIMKIT CLEANER', '', 38.94, 0.00, 35.05, 33.10, 38.94, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (985, 'PAD-019', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 17\" LIMKIT CLEANER', '', 38.94, 0.00, 35.05, 33.10, 38.94, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (986, 'PAD-020', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 17\" LIMKIT CLEANER', '', 38.94, 0.00, 35.05, 33.10, 38.94, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (987, 'PAD-020', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 17\" LIMKIT CLEANER', '', 38.94, 0.00, 35.05, 33.10, 38.94, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (988, 'PAD-021', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 18\" LIMKIT CLEANER', '', 42.48, 0.00, 38.23, 36.11, 42.48, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (989, 'PAD-021', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 18\" LIMKIT CLEANER', '', 42.48, 0.00, 38.23, 36.11, 42.48, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (990, 'PAD-022', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 18\" LIMKIT CLEANER', '', 42.48, 0.00, 38.23, 36.11, 42.48, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (991, 'PAD-022', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 18\" LIMKIT CLEANER', '', 42.48, 0.00, 38.23, 36.11, 42.48, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (992, 'PAD-023', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 18\" LIMKIT CLEANER', '', 42.48, 0.00, 38.23, 36.11, 42.48, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (993, 'PAD-023', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 18\" LIMKIT CLEANER', '', 42.48, 0.00, 38.23, 36.11, 42.48, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (994, 'PAD-024', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 18\" LIMKIT CLEANER', '', 42.48, 0.00, 38.23, 36.11, 42.48, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (995, 'PAD-024', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 18\" LIMKIT CLEANER', '', 42.48, 0.00, 38.23, 36.11, 42.48, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (996, 'PAD-025', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 18\" LIMKIT CLEANER', '', 36.00, 0.00, 38.23, 36.11, 36.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (997, 'PAD-025', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 18\" LIMKIT CLEANER', '', 36.00, 0.00, 38.23, 36.11, 36.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (998, 'PAD-026', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (999, 'PAD-026', NULL, 'DISCO PAD PARA ABRILLANTAR COLOR BLANCO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1000, 'PAD-027', NULL, 'DISCO PAD PARA LAVADO DECAPADO DE PISOS COLOR DORADO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1001, 'PAD-027', NULL, 'DISCO PAD PARA LAVADO DECAPADO DE PISOS COLOR DORADO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1002, 'PAD-028', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1003, 'PAD-028', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1004, 'PAD-029', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1005, 'PAD-029', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1006, 'PAD-030', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1007, 'PAD-030', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1008, 'PAD-031', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1009, 'PAD-031', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1010, 'PAD-032', NULL, 'DISCO PAD PARA LIMPIEZA Y ABRILLANTADO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1011, 'PAD-032', NULL, 'DISCO PAD PARA LIMPIEZA Y ABRILLANTADO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 41.42, 39.12, 46.02, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1012, 'PAD-033', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 0.00, 0.00, 46.02, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1013, 'PAD-033', NULL, 'DISCO PAD PARA LAVADO PROFUNDO DECAPADO COLOR MARRON DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 0.00, 0.00, 46.02, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1014, 'PAD-034', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 0.00, 0.00, 46.02, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1015, 'PAD-034', NULL, 'DISCO PAD PARA LAVADO PROFUNDO COLOR NEGRO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 0.00, 0.00, 46.02, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1016, 'PAD-035', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 0.00, 0.00, 46.02, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1017, 'PAD-035', NULL, 'DISCO PAD PARA LAVAR Y/O ABRILLANTAR COLOR ROJO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 0.00, 0.00, 46.02, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1018, 'PAD-036', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 0.00, 0.00, 46.02, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1019, 'PAD-036', NULL, 'DISCO PAD PARA LAVAR COLOR VERDE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 0.00, 0.00, 46.02, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1020, 'PAD-037', NULL, 'DISCO PAD PARA LIMPIEZA Y ABRILLANTADO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 0.00, 0.00, 46.02, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1021, 'PAD-037', NULL, 'DISCO PAD PARA LIMPIEZA Y ABRILLANTADO DE 20\" LIMKIT CLEANER', '', 46.02, 0.00, 0.00, 0.00, 46.02, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1022, 'PAD-038', NULL, 'DISCO PAD 3M DE 17\" COLOR: BLANCO', '', 58.48, 0.00, 0.00, 0.00, 58.48, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1023, 'PAD-038', NULL, 'DISCO PAD 3M DE 17\" COLOR: BLANCO', '', 58.48, 0.00, 0.00, 0.00, 58.48, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1024, 'PAD-040', NULL, 'DISCO PAD 3M DE 17\" COLOR: ROJO', '', 58.48, 0.00, 0.00, 0.00, 58.48, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1025, 'PAD-040', NULL, 'DISCO PAD 3M DE 17\" COLOR: ROJO', '', 58.48, 0.00, 0.00, 0.00, 58.48, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1026, 'PAD-041', NULL, 'DISCO PAD 3M DE 20\" COLOR: BLANCO', '', 62.66, 0.00, 0.00, 0.00, 62.66, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1027, 'PAD-041', NULL, 'DISCO PAD 3M DE 20\" COLOR: BLANCO', '', 62.66, 0.00, 0.00, 0.00, 62.66, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1028, 'PAD-043', NULL, 'DISCO PAD 3M DE 20\" COLOR: ROJO', '', 62.66, 0.00, 0.00, 0.00, 62.66, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1029, 'PAD-043', NULL, 'DISCO PAD 3M DE 20\" COLOR: ROJO', '', 62.66, 0.00, 0.00, 0.00, 62.66, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1030, 'PH-001', NULL, 'PAPEL HIGIENICO JUMBO DE 550 METROS X 6 ROLLOS (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1031, 'PH-001', NULL, 'PAPEL HIGIENICO JUMBO DE 550 METROS X 6 ROLLOS (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1032, 'PH-002', NULL, 'PAPEL HIGIENICO JUMBO DE 550 METROS X ROLLO (LINEA INSTITUCIONAL)', NULL, 23.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:34:49');
INSERT INTO `productos` VALUES (1033, 'PH-002', NULL, 'PAPEL HIGIENICO JUMBO DE 550 METROS X ROLLO (LINEA INSTITUCIONAL)', NULL, 23.00, 0.00, 0.00, 0.00, NULL, 0, NULL, NULL, 1, NULL, NULL, '2', '51121703', NULL, '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:34:49');
INSERT INTO `productos` VALUES (1034, 'PH-003', NULL, 'PAPEL HIGIENICO JUMBO DE 400 METROS X 6 ROLLOS (LINEA INSTITUCIONAL)', NULL, 23.00, 23.00, 32.00, 23.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:35:33');
INSERT INTO `productos` VALUES (1035, 'PH-003', NULL, 'PAPEL HIGIENICO JUMBO DE 400 METROS X 6 ROLLOS (LINEA INSTITUCIONAL)', NULL, 23.00, 23.00, 32.00, 23.00, NULL, 0, NULL, NULL, 1, NULL, NULL, '2', '51121703', NULL, '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:35:33');
INSERT INTO `productos` VALUES (1036, 'PH-004', NULL, 'PAPEL HIGIENICO JUMBO DE 400 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1037, 'PH-004', NULL, 'PAPEL HIGIENICO JUMBO DE 400 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1038, 'PH-01', NULL, 'PAPEL HIGIENICO JUMBO DE 550 METROS X 6 ROLLOS (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1039, 'PH-01', NULL, 'PAPEL HIGIENICO JUMBO DE 550 METROS X 6 ROLLOS (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1040, 'PH-02', NULL, 'PAPEL HIGIENICO JUMBO DE 550 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1041, 'PH-02', NULL, 'PAPEL HIGIENICO JUMBO DE 550 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1042, 'PH-03', NULL, 'PAPEL HIGIENICO JUMBO DE 400 METROS X 6 ROLLOS (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1043, 'PH-03', NULL, 'PAPEL HIGIENICO JUMBO DE 400 METROS X 6 ROLLOS (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1044, 'PH-04', NULL, 'PAPEL HIGIENICO JUMBO DE 400 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1045, 'PH-04', NULL, 'PAPEL HIGIENICO JUMBO DE 400 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1046, 'PL-001', NULL, 'PAÑO DE LIMPIEZA LIMPALL X 90', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1047, 'PL-001', NULL, 'PAÑO DE LIMPIEZA LIMPALL X 90', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1048, 'PL-01', NULL, 'PAÑO DE LIMPIEZA LIMPALL X 90', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1049, 'PL-01', NULL, 'PAÑO DE LIMPIEZA LIMPALL X 90', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1050, 'PORT-001', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 10 \"', '', 111.40, 0.00, 100.26, 94.69, 111.40, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1051, 'PORT-001', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 10 \"', '', 111.40, 0.00, 100.26, 94.69, 111.40, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1052, 'PORT-002', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 11 \"', '', 112.96, 0.00, 101.67, 96.02, 112.96, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1053, 'PORT-002', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 11 \"', '', 112.96, 0.00, 101.67, 96.02, 112.96, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1054, 'PORT-003', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 12 \"', '', 115.95, 0.00, 104.35, 98.55, 115.95, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1055, 'PORT-003', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 12 \"', '', 115.95, 0.00, 104.35, 98.55, 115.95, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1056, 'PORT-004', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 13 \"', '', 120.62, 0.00, 108.56, 102.53, 120.62, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1057, 'PORT-004', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 13 \"', '', 120.62, 0.00, 108.56, 102.53, 120.62, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1058, 'PORT-005', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 14 \"', '', 123.60, 0.00, 111.24, 105.06, 123.60, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1059, 'PORT-005', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 14 \"', '', 123.60, 0.00, 111.24, 105.06, 123.60, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1060, 'PORT-006', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 15 \"', '', 126.72, 0.00, 114.05, 107.71, 126.72, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1061, 'PORT-006', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 15 \"', '', 126.72, 0.00, 114.05, 107.71, 126.72, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1062, 'PORT-007', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 16 \"', '', 132.82, 0.00, 119.54, 112.90, 132.82, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1063, 'PORT-007', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 16 \"', '', 132.82, 0.00, 119.54, 112.90, 132.82, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1064, 'PORT-008', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 17 \"', '', 142.04, 0.00, 127.83, 120.73, 142.04, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1065, 'PORT-008', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 17 \"', '', 142.04, 0.00, 127.83, 120.73, 142.04, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1066, 'PORT-009', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 18 \"', '', 146.58, 0.00, 131.92, 124.59, 146.58, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1067, 'PORT-009', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 18 \"', '', 146.58, 0.00, 131.92, 124.59, 146.58, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1068, 'PORT-010', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 19 \"', '', 157.35, 0.00, 141.62, 133.75, 157.35, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1069, 'PORT-010', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 19 \"', '', 157.35, 0.00, 141.62, 133.75, 157.35, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1070, 'PORT-011', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 20 \"', '', 165.01, 0.00, 148.51, 140.26, 165.01, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1071, 'PORT-011', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 20 \"', '', 165.01, 0.00, 148.51, 140.26, 165.01, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1072, 'PORT-012', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 21 \"', '', 169.55, 0.00, 152.60, 144.12, 169.55, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1073, 'PORT-012', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 21 \"', '', 169.55, 0.00, 152.60, 144.12, 169.55, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1074, 'PORT-013', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 22 \"', '', 172.67, 0.00, 155.40, 146.77, 172.67, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1075, 'PORT-013', NULL, 'PORTA PAD NACIONAL C/ BRAQUETA DE 22 \"', '', 172.67, 0.00, 155.40, 146.77, 172.67, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1076, 'PORTI-001', NULL, 'PORTA PAD IMPORTADO C/ BRAQUETA DE 15 \"', '', 165.20, 0.00, 148.68, 140.42, 165.20, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1077, 'PORTI-001', NULL, 'PORTA PAD IMPORTADO C/ BRAQUETA DE 15 \"', '', 165.20, 0.00, 148.68, 140.42, 165.20, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1078, 'PORTI-002', NULL, 'PORTA PAD IMPORTADO C/ BRAQUETA DE 16 \"', '', 182.90, 0.00, 164.61, 155.47, 182.90, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1079, 'PORTI-002', NULL, 'PORTA PAD IMPORTADO C/ BRAQUETA DE 16 \"', '', 182.90, 0.00, 164.61, 155.47, 182.90, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1080, 'PORTI-003', NULL, 'PORTA PAD IMPORTADO C/ BRAQUETA DE 17 \"', '', 200.60, 0.00, 180.54, 170.51, 200.60, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1081, 'PORTI-003', NULL, 'PORTA PAD IMPORTADO C/ BRAQUETA DE 17 \"', '', 200.60, 0.00, 180.54, 170.51, 200.60, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1082, 'PORTI-004', NULL, 'PORTA PAD IMPORTADO C/ BRAQUETA DE 19 \"', '', 218.30, 0.00, 196.47, 185.55, 218.30, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1083, 'PORTI-004', NULL, 'PORTA PAD IMPORTADO C/ BRAQUETA DE 19 \"', '', 218.30, 0.00, 196.47, 185.55, 218.30, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1084, 'PORTI-005', NULL, 'PORTA PAD IMPORTA C/ BRAQUETA P/ LUSTRADORA KARCHER MOD:BDS-43/180C DE 15\"', '', 188.80, 0.00, 169.92, 160.48, 188.80, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1085, 'PORTI-005', NULL, 'PORTA PAD IMPORTA C/ BRAQUETA P/ LUSTRADORA KARCHER MOD:BDS-43/180C DE 15\"', '', 188.80, 0.00, 169.92, 160.48, 188.80, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1086, 'PRUE 001', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 15', 'MARCA: CRIS-TAURO\nModelo: TD-12N Potencia de motor: 1.5 HP Voltaje / Frecuencia: 220 V/60 Hz\nVelocidad de Rotación: 175 RPM. Motor: KDS del Grupo Imperial Estructura en Acero Inoxidable Anticorrosivo Base de Motor en Aluminio Fundido anticorrosivo Plato en Acero Inoxidable (calidad 304) de 12\" Cable Vulcanizado Homologado de 3x14: 15 metros Incluye: Cepillo de\nLavar de 11\" y Cepillo de Lustrar de 11\"', 100.00, 90.00, 150.00, 90.00, 100.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1087, 'PRUE 001', NULL, 'LUSTRADORA LAVADORA INDUSTRIAL DE PISOS DE 15', 'MARCA: CRIS-TAURO\nModelo: TD-12N Potencia de motor: 1.5 HP Voltaje / Frecuencia: 220 V/60 Hz\nVelocidad de Rotación: 175 RPM. Motor: KDS del Grupo Imperial Estructura en Acero Inoxidable Anticorrosivo Base de Motor en Aluminio Fundido anticorrosivo Plato en Acero Inoxidable (calidad 304) de 12\" Cable Vulcanizado Homologado de 3x14: 15 metros Incluye: Cepillo de\nLavar de 11\" y Cepillo de Lustrar de 11\"', 100.00, 90.00, 150.00, 90.00, 100.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1088, 'PT-001', NULL, 'PAPEL TOALLA JUMBO DE 300 METROS X 4 ROLLOS (LINEA INSTITUCIONAL)', '', 85.00, 0.00, 0.00, 0.00, 85.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1089, 'PT-001', NULL, 'PAPEL TOALLA JUMBO DE 300 METROS X 4 ROLLOS (LINEA INSTITUCIONAL)', '', 85.00, 0.00, 0.00, 0.00, 85.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1090, 'PT-002', NULL, 'PAPEL TOALLA JUMBO DE 300 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 21.25, 0.00, 0.00, 0.00, 21.25, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1091, 'PT-002', NULL, 'PAPEL TOALLA JUMBO DE 300 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 21.25, 0.00, 0.00, 0.00, 21.25, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1092, 'PT-003', NULL, 'PAPEL TOALLA JUMBO DE 200 METROS X 4 ROLLOS (LINEA INSTITUCIONAL)', '', 77.00, 0.00, 0.00, 0.00, 77.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1093, 'PT-003', NULL, 'PAPEL TOALLA JUMBO DE 200 METROS X 4 ROLLOS (LINEA INSTITUCIONAL)', '', 77.00, 0.00, 0.00, 0.00, 77.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1094, 'PT-004', NULL, 'PAPEL TOALLA JUMBO DE 200 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 19.25, 0.00, 0.00, 0.00, 19.25, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1095, 'PT-004', NULL, 'PAPEL TOALLA JUMBO DE 200 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 19.25, 0.00, 0.00, 0.00, 19.25, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1096, 'PT-005', NULL, 'PAPEL TOALLA INTERFOLIADO PAQUETE DE 200 HOJAS X 20 PAQUETES (LINEA INSTITUCIONAL)', '', 120.00, 0.00, 0.00, 0.00, 120.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1097, 'PT-005', NULL, 'PAPEL TOALLA INTERFOLIADO PAQUETE DE 200 HOJAS X 20 PAQUETES (LINEA INSTITUCIONAL)', '', 120.00, 0.00, 0.00, 0.00, 120.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1098, 'PT-006', NULL, 'PAPEL TOALLA INTERFOLIADO PAQUETE X 200 HOJAS (LINEA INSTITUCIONAL)', '', 6.00, 0.00, 0.00, 0.00, 6.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1099, 'PT-006', NULL, 'PAPEL TOALLA INTERFOLIADO PAQUETE X 200 HOJAS (LINEA INSTITUCIONAL)', '', 6.00, 0.00, 0.00, 0.00, 6.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1100, 'PT-01', NULL, 'PAPEL TOALLA JUMBO DE 300 METROS X 2 ROLLOS (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1101, 'PT-01', NULL, 'PAPEL TOALLA JUMBO DE 300 METROS X 2 ROLLOS (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1102, 'PT-02', NULL, 'PAPEL TOALLA JUMBO DE 300 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1103, 'PT-02', NULL, 'PAPEL TOALLA JUMBO DE 300 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1104, 'PT-03', NULL, 'PAPEL TOALLA JUMBO DE 200 METROS X 2 ROLLOS (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1105, 'PT-03', NULL, 'PAPEL TOALLA JUMBO DE 200 METROS X 2 ROLLOS (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1106, 'PT-04', NULL, 'PAPEL TOALLA JUMBO DE 200 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1107, 'PT-04', NULL, 'PAPEL TOALLA JUMBO DE 200 METROS X ROLLO (LINEA INSTITUCIONAL)', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1108, 'PT-05', NULL, 'PAPEL TOALLA INTERFOLIADO X CAJA DE 20 PQT', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1109, 'PT-05', NULL, 'PAPEL TOALLA INTERFOLIADO X CAJA DE 20 PQT', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1110, 'PT-06', NULL, 'PAPEL TOALLA INTERFOLIADO PQT X 200 HOJAS', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1111, 'PT-06', NULL, 'PAPEL TOALLA INTERFOLIADO PQT X 200 HOJAS', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1112, 'PTI-01', NULL, 'PAPEL TOALLA INTERFOLIADO PAQUETE DE 200 HOJAS X 20 PAQUETES (LINEA INSTITUCIONAL)', '', 120.00, 0.00, 0.00, 0.00, 120.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1113, 'PTI-01', NULL, 'PAPEL TOALLA INTERFOLIADO PAQUETE DE 200 HOJAS X 20 PAQUETES (LINEA INSTITUCIONAL)', '', 120.00, 0.00, 0.00, 0.00, 120.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1114, 'PTI-02', NULL, 'PAPEL TOALLA INTERFOLIADO PAQUETE X 200 HOJAS (LINEA INSTITUCIONAL)', '', 6.00, 0.00, 0.00, 0.00, 6.00, 0, 0, 0, 1, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');
INSERT INTO `productos` VALUES (1115, 'PTI-02', NULL, 'PAPEL TOALLA INTERFOLIADO PAQUETE X 200 HOJAS (LINEA INSTITUCIONAL)', '', 6.00, 0.00, 0.00, 0.00, 6.00, 0, 0, 0, 1, NULL, NULL, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-02-19 14:41:11', NULL, '2026-02-19 15:41:11', '2026-02-19 15:41:11');

-- ----------------------------
-- Table structure for productos_compras
-- ----------------------------
DROP TABLE IF EXISTS `productos_compras`;
CREATE TABLE `productos_compras`  (
  `id_producto_compra` int NOT NULL AUTO_INCREMENT,
  `id_compra` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` decimal(10, 2) NOT NULL,
  `precio` decimal(10, 3) NOT NULL COMMENT 'Precio unitario',
  `costo` decimal(10, 3) NOT NULL COMMENT 'Costo unitario',
  `subtotal` decimal(10, 2) GENERATED ALWAYS AS (`cantidad` * `precio`) STORED NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_producto_compra`) USING BTREE,
  INDEX `idx_compra`(`id_compra` ASC) USING BTREE,
  INDEX `idx_producto`(`id_producto` ASC) USING BTREE,
  CONSTRAINT `productos_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `productos_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of productos_compras
-- ----------------------------

-- ----------------------------
-- Table structure for productos_ventas
-- ----------------------------
DROP TABLE IF EXISTS `productos_ventas`;
CREATE TABLE `productos_ventas`  (
  `id_producto_venta` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venta` bigint UNSIGNED NOT NULL,
  `id_producto` bigint UNSIGNED NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10, 2) NOT NULL,
  `subtotal` decimal(10, 2) NOT NULL,
  `igv` decimal(10, 2) NULL DEFAULT NULL,
  `total` decimal(10, 2) NOT NULL,
  `descuento` decimal(10, 2) NULL DEFAULT NULL,
  `unidad_medida` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NIU',
  `tipo_afectacion_igv` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '10',
  `valor_unitario` decimal(10, 2) NULL DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `codigo_producto` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto_venta`) USING BTREE,
  INDEX `productos_ventas_id_venta_index`(`id_venta` ASC) USING BTREE,
  INDEX `productos_ventas_id_producto_index`(`id_producto` ASC) USING BTREE,
  CONSTRAINT `productos_ventas_id_venta_foreign` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of productos_ventas
-- ----------------------------
INSERT INTO `productos_ventas` VALUES (1, 1, 484, 1, 120.00, 120.00, 21.60, 141.60, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-01-19 15:44:32', '2026-01-19 15:44:32');
INSERT INTO `productos_ventas` VALUES (2, 2, 477, 1, 6.00, 6.00, 1.08, 7.08, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-01-19 15:46:16', '2026-01-19 15:46:16');
INSERT INTO `productos_ventas` VALUES (3, 2, 476, 1, 120.00, 120.00, 21.60, 141.60, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-01-19 15:46:16', '2026-01-19 15:46:16');
INSERT INTO `productos_ventas` VALUES (4, 2, 475, 1, 19.25, 19.25, 3.47, 22.72, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-01-19 15:46:16', '2026-01-19 15:46:16');
INSERT INTO `productos_ventas` VALUES (5, 2, 474, 1, 77.00, 77.00, 13.86, 90.86, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-01-19 15:46:16', '2026-01-19 15:46:16');
INSERT INTO `productos_ventas` VALUES (6, 2, 473, 1, 21.25, 21.25, 3.83, 25.08, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-01-19 15:46:16', '2026-01-19 15:46:16');
INSERT INTO `productos_ventas` VALUES (7, 3, 484, 1, 120.00, 120.00, 21.60, 141.60, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-01-19 17:09:22', '2026-01-19 17:09:22');
INSERT INTO `productos_ventas` VALUES (8, 3, 485, 1, 6.00, 6.00, 1.08, 7.08, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-01-19 17:09:22', '2026-01-19 17:09:22');
INSERT INTO `productos_ventas` VALUES (9, 4, 485, 1, 6.00, 6.00, 1.08, 7.08, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-01-19 22:19:17', '2026-01-19 22:19:17');
INSERT INTO `productos_ventas` VALUES (10, 4, 484, 1, 120.00, 120.00, 21.60, 141.60, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-01-19 22:19:17', '2026-01-19 22:19:17');
INSERT INTO `productos_ventas` VALUES (11, 4, 475, 1, 19.25, 19.25, 3.47, 22.72, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-01-19 22:19:17', '2026-01-19 22:19:17');
INSERT INTO `productos_ventas` VALUES (12, 5, 485, 1, 6.00, 6.00, 1.08, 7.08, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-02-06 14:19:38', '2026-02-06 14:19:38');
INSERT INTO `productos_ventas` VALUES (13, 6, 485, 1, 6.00, 6.00, 1.08, 7.08, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-02-06 14:20:58', '2026-02-06 14:20:58');
INSERT INTO `productos_ventas` VALUES (14, 7, 485, 1, 6.00, 6.00, 1.08, 7.08, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-02-06 14:50:27', '2026-02-06 14:50:27');
INSERT INTO `productos_ventas` VALUES (15, 8, 485, 1, 6.00, 6.00, 1.08, 7.08, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-02-06 14:51:32', '2026-02-06 14:51:32');

-- ----------------------------
-- Table structure for proveedores
-- ----------------------------
DROP TABLE IF EXISTS `proveedores`;
CREATE TABLE `proveedores`  (
  `proveedor_id` int NOT NULL AUTO_INCREMENT,
  `ruc` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `razon_social` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `direccion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `telefono` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `id_empresa` int NOT NULL,
  `departamento` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `provincia` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `distrito` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ubigeo` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `estado` int NULL DEFAULT 1 COMMENT '1=Activo, 0=Inactivo',
  `fecha_create` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`proveedor_id`) USING BTREE,
  UNIQUE INDEX `ruc`(`ruc` ASC) USING BTREE,
  INDEX `idx_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `idx_ruc`(`ruc` ASC) USING BTREE,
  INDEX `idx_estado`(`estado` ASC) USING BTREE,
  INDEX `idx_razon_social`(`razon_social` ASC) USING BTREE,
  CONSTRAINT `proveedores_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of proveedores
-- ----------------------------
INSERT INTO `proveedores` VALUES (1, '20100131359', 'DATACONT S.A.C.', 'Av. Los Incas 123', '987654321', 'ventas@datacont.com', 1, 'Lima', 'Lima', 'San Isidro', '150131', 1, '2026-01-08 13:50:35', '2026-01-08 13:50:35', '2026-01-08 13:50:35');
INSERT INTO `proveedores` VALUES (2, '20601907063', 'CYBERGAMES (C.G.S.) E.I.R.L.', 'Jr. Comercio 456', '912345678', 'contacto@cybergames.com', 1, 'Lima', 'Lima', 'Miraflores', '150140', 1, '2026-01-08 13:50:35', '2026-01-08 13:50:35', '2026-01-08 13:50:35');
INSERT INTO `proveedores` VALUES (3, '20123456789', 'DISTRIBUIDORA PERU S.A.', 'Av. Industrial 789', '998877665', 'info@distriperu.com', 1, 'Lima', 'Lima', 'Los Olivos', '150117', 1, '2026-01-08 13:50:35', '2026-01-08 13:50:35', '2026-01-08 13:50:35');
INSERT INTO `proveedores` VALUES (4, '20608300393', 'COMPAÑIA FOOD RETAIL S.A.C.', 'CAL. CESAR MORELLI NRO. 181 URB. SAN BORJA NORTE LIMA LIMA SAN BORJA', '993321920', 'kiyotakahitori@gmail.com', 1, 'LIMA', 'LIMA', 'SAN BORJA', '150130', 1, '2026-01-09 00:36:05', '2026-01-08 23:36:05', '2026-01-08 23:36:05');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `rol_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ver_precios` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Permiso para ver precios',
  `puede_eliminar` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Permiso para eliminar registros',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`rol_id`) USING BTREE,
  INDEX `idx_nombre`(`nombre` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'ADMIN', 1, 1, NULL, NULL);
INSERT INTO `roles` VALUES (2, 'USUARIO', 1, 1, NULL, NULL);
INSERT INTO `roles` VALUES (3, 'VENDEDOR', 1, 1, NULL, NULL);
INSERT INTO `roles` VALUES (4, 'CAJERO', 1, 1, NULL, NULL);
INSERT INTO `roles` VALUES (5, 'CONTADOR', 1, 1, NULL, NULL);
INSERT INTO `roles` VALUES (6, 'ALMACEN', 1, 1, NULL, NULL);

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id` ASC) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('1aXlESBqqy0cqHqlMOoKlF4VGtujGuvDuKGgwbFH', NULL, '64.62.156.204', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidVA0Mm9hN1NxeERQZm1HaUFoRDhtMDd1UTdYTXQ2Q2xRZGFsbzB2cyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771900530);
INSERT INTO `sessions` VALUES ('1WIqtVc8mxRdyhvnlByvO8KCTVl5mCMuGBolBQRq', NULL, '43.130.102.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ2hnSmszUVV2aDl3REkzZXNZTTFhM1dhQndzaE81aEdnNW9pQlFjOSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771890563);
INSERT INTO `sessions` VALUES ('1XLE2vUIst7hkuhArEZ9MwwOkeCdo50lxx77l8sL', NULL, '162.216.150.20', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMGtJTUtyU2F1cG95YnhnY2xUbnl2Mkp4aXFnZ0lsUmFYTUZaaXp5ZSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771896077);
INSERT INTO `sessions` VALUES ('59kmFtpnsu7hxnnLPUnYUu99SnNrHwqDCBbEUB2q', NULL, '13.55.69.224', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTUtKZjIzTUV3Qkx5TTlqWHB5VDNuQVBNaE90U0NjM2FRdFFzQmc0TSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771899604);
INSERT INTO `sessions` VALUES ('7eslWn3GtqF5pdSZ17wRMlqsM3scrns6AAM8zN5M', NULL, '176.65.139.8', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMWRNQjJUaWVsQW5DMlZKREh0RmZDNTg5SFNxaUdIalRwbWVvY1haMCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771896104);
INSERT INTO `sessions` VALUES ('8kYxFjkjyZO69vgLpkfO3byMJiPYHkA5YGbS7vsB', NULL, '43.130.102.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMHF4QnFLc1paRWw5YlprVkpkUkhPNDl5MlBHbFFJQ09Rdkp2SUJhUSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771890563);
INSERT INTO `sessions` VALUES ('8S947tH9yvwWXF4td7L0zK21F6Bw0fOP4KLLqD2w', NULL, '43.133.66.51', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWHRrWkxqbHViZlRjWld4cHpKclg1N25DNlRwWWI1c3ZMNFNUYzlRSyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHA6Ly9tLmlsaWRlc2F2YS5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771891530);
INSERT INTO `sessions` VALUES ('95Z8ImpyCcMc5Q6RtI6YvEGDuahVyes7E37YupFo', NULL, '64.62.156.202', 'Mozilla/5.0 (Kubuntu; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieWhOcFY5cTRDTm1rNUllYTdQQXQwRVdhampIeFlWQm00TkFINGRHNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771900571);
INSERT INTO `sessions` VALUES ('9jwYkrFrPS9TW35DRf79FsMHpoJJ6FqHpTTMFMbB', NULL, '87.236.176.221', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibGRuckFoeEtTMmE3OTdhcWlqN2RyWVdtbEduY3FNalBra3gxbTJYTyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771894534);
INSERT INTO `sessions` VALUES ('asE7OEAi8wZAeURXEl34ASf43djIGwFKU3BHqJfv', NULL, '43.130.40.120', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUTh4R0h4Snp2TmxJdEZvWDV6OHRJeGhTVG9sUGxnU0J6RDFjbWJuRSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly93d3cuaWxpZGVzYXZhLmNvbSI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771898679);
INSERT INTO `sessions` VALUES ('bBdKV9eCE47a78TFI1VMfVPqh4BSUqIo2WyMzIiU', NULL, '3.29.134.16', 'Mozilla/5.0 (Linux; Android 14; SM-S918B) AppleWebKit/537.36 Chrome/120.0.0.0 Mobile Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiQzhCN2JGZ3kwczAxSFFqNXZCbW55U2R4NmRhVGU2bzNSMGRPb0E0QiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771892601);
INSERT INTO `sessions` VALUES ('C7hCVmDOkilRrihT5Y4ElQLBcX52t9A7QUnXgk8Y', NULL, '34.27.84.233', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWjk4ZE9tS1dLc0JsZDNISXRaNTdoNWZNdFdtWDFuQmt5ZzJMYkZUcSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly93d3cuaWxpZGVzYXZhLmNvbS9pbmRleC5waHAiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771889367);
INSERT INTO `sessions` VALUES ('c9J81yzA4Ytv0qwCXVjf3iksoK4n4rsFIumJOiEU', NULL, '64.62.156.211', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/115.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMWM4QnpHUGxwbm9IYnVqc1MxNkg5dGRiM2ttd3habnhjMW1NblNibiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771900473);
INSERT INTO `sessions` VALUES ('CbPM5KZd4auQPd9De2BMzyFzMTytvFr0bSfTHJjf', NULL, '100.27.169.19', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibGZmdVFUQ3FsT0ZvbmZMSEdra3VWMmRGcFNLREFJRW1VTkdPcXJmSiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771894752);
INSERT INTO `sessions` VALUES ('CIidsdLr5R9e9RX7Y2pb0WUY2KO6OpFE57Ux4EXt', NULL, '93.158.90.141', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Viewer/99.9.8853.8', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRmtRVEdpWGZleEJVRmRraDJKdTVDWDZpZUIyZDFQRFJMWFdiSEhTNCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vaWxpZGVzYXZhLmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771888454);
INSERT INTO `sessions` VALUES ('Civzji4lWaWHG1wtPqaoNsxIcAWSyHzHADf2lWFB', NULL, '43.130.40.120', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM1ZCbHJCTDd6UG5JeDlKQkZQT2xKM3FZSnNZZDl5d0JxVnIwM0drTiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly93d3cuaWxpZGVzYXZhLmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771898681);
INSERT INTO `sessions` VALUES ('CvKBKxUOfBk5diHdWai8CUMry1IROOpgEL2MfWRh', NULL, '34.27.84.233', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTE5UMkhZanl3Q0k5S2kybHo2WWE1cXFuM3lIUFlEMVdidEFkQWRsdiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzU6Imh0dHBzOi8vd3d3LmlsaWRlc2F2YS5jb20vaW5kZXgucGhwIjtzOjU6InJvdXRlIjtOO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771892454);
INSERT INTO `sessions` VALUES ('dHQ5Cf52vTSnwNTpSmBgLpRN4fjo0gmKePMtwRb7', NULL, '64.62.156.202', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/115.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib1FWaXJsU0ZRWGtpcmNvRnhUV2xldUJENkdKMjRhZUVCUXl4ZHhhSCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771899867);
INSERT INTO `sessions` VALUES ('dijoEq9h9A76viU5vcyDdFAqZSIdYu24usEHVbu3', NULL, '216.180.246.133', 'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUTMwZmgzTWRXTUI0YzY5aUc1WkNwS0dQNnRzT01sdExjWlZuRU5GZSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771890888);
INSERT INTO `sessions` VALUES ('eHjyDcJMpNJt2qFVs4Llcueyx1X079TVsP9oXvzt', NULL, '159.223.146.250', 'Mozilla/5.0 zgrab/0.x', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQlFZUHI3cWtpaWhZM3JGTFlmNmZCcURqSGVzblRJemRzNk1RbWdleCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771891601);
INSERT INTO `sessions` VALUES ('eKXerfmEeSM8Sbc8AjUtf0lYnxFpWV94FTj6r7mK', NULL, '100.27.169.19', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNmswNXhBWE96SXpsTWk5ZlNnM3IyelkyQjBHMUpjYk5WSW9OY0tWaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771894752);
INSERT INTO `sessions` VALUES ('eRDJSwCEOdwX58R6V5OGIUhJHdPbUKsXOsDkkEPM', NULL, '95.214.52.209', 'Mozilla/5.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidHpQYmoxT2s0bWkwOFFDalUyMHltYjk1dlV0cGlYa1lUdDduV3pEZiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771897192);
INSERT INTO `sessions` VALUES ('EwqMdnGj3vxJS2zYnP8uXhbgFz4SyzPaHC0tMZNP', NULL, '64.62.156.204', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRzRBMElWWWNLZGVnZXhtTjJCNHc2ZHQ0SVZndmFzbXJlVUxDSG8yOSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771900530);
INSERT INTO `sessions` VALUES ('F6wUMzydDbELmiNexCS1JOGJnK3heqTl3slgTBBk', NULL, '13.55.69.224', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkZrOFBWWVNOdk5pNmFnWWE3TXNFUU1sRHlFVlpybEJvbUw0QnVacyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771899604);
INSERT INTO `sessions` VALUES ('fEAjNK7bryb7x41cQFwqJTD7x3KvxfjR5JzlnTwx', NULL, '147.185.132.100', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicVV6NEltd0xRZ2JPOEhQdllPTWFLc1BDb2NONzJoM0dVYndYVzlEdiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771887105);
INSERT INTO `sessions` VALUES ('fwxYQ7dZnLKjNMk9ZcXoiOVz9DqlhLVj2v6DR4Nf', NULL, '3.29.134.16', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_2 like Mac OS X) AppleWebKit/605.1.15 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT1laWFlpMFFWM0NQREw3VDZvN3M3N3N2SzZ6d2Y3NU1nb0lod21JayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vd3d3LmRldi5ncHNza2llcy5jb20vbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771892602);
INSERT INTO `sessions` VALUES ('H5YNkJIqD4xJCnCFiMMmxSPIgDgCpqpkRthq5ks3', NULL, '3.29.134.16', 'Mozilla/5.0 (Linux; Android 14; SM-S918B) AppleWebKit/537.36 Chrome/120.0.0.0 Mobile Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiYklpZldoRlRDbm1JTTYzWVJFZ1hIODFybVVXQVlsS21HYUl0aGxlcCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771899257);
INSERT INTO `sessions` VALUES ('hAbiCLFGN53TSyX0qbvXzKxf3dTuO57DBlfVjJM5', NULL, '35.195.246.41', 'python-requests/2.32.5', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSndpVDJrcWprOFhrMkhIQTlUeDNpRnlsbWFxQlRlbDYzQVJoOURvZSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771890516);
INSERT INTO `sessions` VALUES ('I1bfmmDV2fmD983XDoSTGBcoc9HrugHhR0lEWAW8', NULL, '34.27.84.233', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSGhtVWdoemUyUTdDT3g5MGoyUnlxM3hCU1BTeGdpdUQ5TEFFTXp2dCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vaWxpZGVzYXZhLmNvbS9pbmRleC5waHAiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771892481);
INSERT INTO `sessions` VALUES ('jJ2XleS5h6kfUTjWQdXWgtXQ51cL0UMKJ2xnqbf0', NULL, '87.236.176.221', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaWc3VkRFVW81dWFuSGEzZWs3alJhN2V4czl0NUh0clM2T0tDdzVHaiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771894534);
INSERT INTO `sessions` VALUES ('klJFnOC96MFxBfmoDxSgMYbVEitZoOltGBeIxNaL', NULL, '81.29.142.6', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.86 YaBrowser/21.3.0.663 Yowser/2.5 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieTI4SXo5eXg3RW01b2xReVc4SnY0RXhUaHNRRVE0Z0tITm9DdWZ0diI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vaWxpZGVzYXZhLmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771885058);
INSERT INTO `sessions` VALUES ('n7NWIDaqjKz0vGolkYwwVGbSVdz4GnEOv4mcsBbO', NULL, '3.29.134.16', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:121.0) Gecko/20100101 Firefox/121.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVUUxSnpxMXZjTjA4dzkzVUhuNHpacmNnUDZRdG9uR2xpcVFzRzZiayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjY6Imh0dHBzOi8vdy5kZXYuZ3Bzc2tpZXMuY29tIjtzOjU6InJvdXRlIjtOO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771899258);
INSERT INTO `sessions` VALUES ('O0vhNDIvjzp2M3pjAOGsyvoWjGUUIxRUpSqdN01F', NULL, '3.29.134.16', 'Mozilla/5.0 (Linux; Android 14; SM-S918B) AppleWebKit/537.36 Chrome/120.0.0.0 Mobile Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoibnhWNWxtYXpVNXVISVdqR045aUtKTTFXWFdCQnMwTFBqSHVmZlVYUyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771892601);
INSERT INTO `sessions` VALUES ('OCgyKIIzUMq0R4XZN6eKC8W5QYwmx8zzR6IyNkSK', NULL, '100.27.169.19', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZWt3ckxmeUl6TzVtOEQxaHZqMjJ2bk5PbktBWG43VWZxT25pMmFDTyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771894752);
INSERT INTO `sessions` VALUES ('PEoHUFUTYAiTmMZ1lOxTnDIicD9vqUCLLRyvT2pZ', NULL, '104.168.98.195', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 15_7_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRUJpZEhwNnIyM05BU21HOUVsVHM5NnYwS2FnNlpHbkpJWTVycGdQNyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly93d3cuZGV2Lmdwc3NraWVzLmNvbSI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771890503);
INSERT INTO `sessions` VALUES ('QnAFUtzqVo4Fj4RxTODNkUtpbrEav8pDWn4K6CEf', NULL, '104.168.98.195', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 15_7_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Safari/605.1.15', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia25ud1czVUdZZ0dtemxhWHJvQXNmY2hhQzZiNWQ2RXA2cDdJcnB3eSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly93d3cuZGV2Lmdwc3NraWVzLmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771890503);
INSERT INTO `sessions` VALUES ('rfJRYQpkK9apTFr8RM4jD2NRQu9GTZdH2bh6vLzb', NULL, '162.142.125.205', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZGh1Y3VkN01OZkVZbmdDMW1UeDFyMXFzV2UzcTJUR3pRTkw5WTR0YSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771885483);
INSERT INTO `sessions` VALUES ('Rp2NDJKbQQ0mW65fzLv1rUNLOEKiSXwO2r7dvjJf', NULL, '79.124.40.174', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSWZXajFwZmVoc3VUc2NIVjRzQU1oM0J6ZDE4RTA5cDdBMDRCcUE5aCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771889888);
INSERT INTO `sessions` VALUES ('RS6ZySSdYaTuitdzpHfTdcyMLeWNUEomMgcJSnH1', NULL, '81.29.142.6', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 YaBrowser/21.2.4.165 Yowser/2.5 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSGMzRTRhREhTN0pYWjZDVFJ4U2oyRzZ2dER5VldDems5cVJBbVdWZiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vaWxpZGVzYXZhLmNvbSI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771885056);
INSERT INTO `sessions` VALUES ('rtWomR5TwZd0ythZwoc8IrqiXbsueIHrEn39OJqg', NULL, '81.29.142.6', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.86 YaBrowser/21.3.0.663 Yowser/2.5 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaEo0ekNuVEVwV2tMOUc2NUR0ZU8xdm9ENFY3TktXZFFOdDZhSnNiWiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vaWxpZGVzYXZhLmNvbSI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771885056);
INSERT INTO `sessions` VALUES ('s7mvvGPMIwbANFBsOL62nwu8VG4LP9HADfC9swjR', NULL, '34.147.91.161', 'Scrapy/2.13.4 (+https://scrapy.org)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ3dJcjlSY0cxTFE1OGhlRlYzTUp0aERPQzk5QVp5MkVRcWx2bEZTUiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vaWxpZGVzYXZhLmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771890395);
INSERT INTO `sessions` VALUES ('sdM6s8bmb9KqOVHFpRkXu7Ttnk0MpqQ664xpofog', NULL, '223.199.167.93', '', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUlluZzdJZWxROFYyN1luR3pHUjhwY29KS25sR3FyblJlMjdNcjIyNSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771886344);
INSERT INTO `sessions` VALUES ('SdzZqOE4OkgyHta1dhYDCiy8C2F4lb8SBKdZXS5D', NULL, '43.153.204.189', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR3VIZERkZ2pJMnEzM1J4T1pLN2xNTDkzNjdad1I3VmxSWGpaVlRuaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vaWxpZGVzYXZhLmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771895305);
INSERT INTO `sessions` VALUES ('sTZh7MNDvEIctVvPCLWPQF2I2j8vauvnuZzinZ8N', NULL, '216.180.246.133', 'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQThGMm9rUDM2NWtzRHpsdVpWR21UUkh4MTkxOHNxRWNKa3RXejJVZyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771890889);
INSERT INTO `sessions` VALUES ('T5FvNWhTfTQVWgdhHJO99QiWwrd6rGfBiSM73z7L', NULL, '51.158.164.10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.5359.124 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY29JeDAxUW16MnFqSUd3NWxjR3ljamlkcEE2Z01IeVM0ZFc0Y29JaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vaWxpZGVzYXZhLmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771891223);
INSERT INTO `sessions` VALUES ('TFIbbL7V9CfU14bMKJ1UZiIGDznlKhOcSLkTtNq0', NULL, '3.29.134.16', 'Mozilla/5.0 (Linux; Android 14; SM-S918B) AppleWebKit/537.36 Chrome/120.0.0.0 Mobile Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiTUZjMnRNZDhWZW9PWGFWMGQza3o3YnB0a0pIOURBTkVTeHRBaEl4TyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771899258);
INSERT INTO `sessions` VALUES ('ttiH2zfkGojo1tzKYCLjclmnits0MF50vOpEweSi', NULL, '162.216.150.20', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRUltR0ZUblVJT2xQSW9QSWY4NjRtVnM1RjJVWVRITUF4TFdHVEx1YSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771896077);
INSERT INTO `sessions` VALUES ('twINdyev11LJ42hWNNEbs2IiMA6yqPup1yirlwMt', NULL, '51.158.164.10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.5359.124 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid01WZVJ0NndoR2NXWlQ3V3lBN0kzOHRhUlQ5WW9GZmsxcEx2REZUciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vaWxpZGVzYXZhLmNvbSI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771891221);
INSERT INTO `sessions` VALUES ('TxP9shQYJHbeHSYkc2Q4KeJYvdNGz4vEHw3vjfkD', NULL, '43.153.204.189', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia1Q4VFk3SEdON2RKR1BxZmhOS1RLSlM1ZHYwcTFZdGJIQ09rbDdVOSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vaWxpZGVzYXZhLmNvbSI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771895303);
INSERT INTO `sessions` VALUES ('u8iuKBTakMKD4eGGIRDv2CBhBV9Zou5hIcwlrHCP', NULL, '13.55.69.224', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYjc5aVZoOUdKYkw4eG9TUWs5aXJybUF2MlVUNk9PN2EzeWRZNGhmUiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771899602);
INSERT INTO `sessions` VALUES ('uEPRHwYx8JCbR04Hm5GWZcfcOZQdGWp1zm3ZXR7k', NULL, '3.29.134.16', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_2 like Mac OS X) AppleWebKit/605.1.15 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMURiNzBHZk9JOXNESW9xdUZBYXhoRFdlYmhRRGg2ZTF4a3JFZHU1aSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vd3d3LmRldi5ncHNza2llcy5jb20iO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771892602);
INSERT INTO `sessions` VALUES ('VedmTZtxTmuPnsaaLK7zSyOT9vqibWu5GmHfzdF1', NULL, '162.142.125.205', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ2hFdjc2MlppSFVFdzlUclhnRGhtbDA5S2syWERtVGl2dFZpMVdlcCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771885482);
INSERT INTO `sessions` VALUES ('vXcWgSY8m1a0K0pMJRoi3cbWUukgtFm4LanJWddU', NULL, '100.27.169.19', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiODY1ME9GY2drQWxHek9lTEVjazJhYUhCZ3FXVGNuR1JLN0JuMzV2NyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771894752);
INSERT INTO `sessions` VALUES ('wgSiMZroPCaoxIMq5BPerNmhZSY6wXzza49gtgo0', NULL, '87.236.176.172', 'Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicjJaYXB6NGxGSkExZTFvUGxKNjBZYk9FVENoTnFHSlhHdkMwOXdONiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771892120);
INSERT INTO `sessions` VALUES ('WNj6uo9liUPRV8Lo54o8jzzVkbs9rhF5gnEII6Lg', NULL, '43.133.66.51', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZG5YMlpXR3RydEhSZWZaaExBeU1vV3JNbTh6bDhlMGEycEZUY3g1UCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly9tLmlsaWRlc2F2YS5jb20vbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771891531);
INSERT INTO `sessions` VALUES ('WZZkDhIfRpCjFkdVQqyk7A4lIkraEw7OGeLInuvp', NULL, '79.124.40.174', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic0I3enZ2ZnpFeWg2cmhKWVlGM2RFY1NxMWRVZXlabEtTSnZYZjF1TyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTM6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQvP1hERUJVR19TRVNTSU9OX1NUQVJUPXBocHN0b3JtIjtzOjU6InJvdXRlIjtOO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771889887);
INSERT INTO `sessions` VALUES ('x3hrtd7TKwXABxxM5at2qcVFyqmEJm7oT9wtY3Lw', NULL, '3.29.134.16', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:121.0) Gecko/20100101 Firefox/121.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoielgxak9WMFpoNlRYWVlSRUxHOXk3TU92TU9pR3VsZGRoSkpuRlRkdiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzI6Imh0dHBzOi8vdy5kZXYuZ3Bzc2tpZXMuY29tL2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771899258);
INSERT INTO `sessions` VALUES ('y1vFjBJthkjRuyvg0CKKCPkQszpRfOATUh6AGHji', NULL, '13.55.69.224', 'Go-http-client/1.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidFdxZXEwTEJsYVpyUTROVnBUUTdZRWZaZ0tpZzdRUG54NFF6V1hZRiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771899602);
INSERT INTO `sessions` VALUES ('YcMU8BMdBJ8kCgtr87kOrFojShiWdZqo476rJNaR', NULL, '103.120.189.68', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibURxdzcxd0dRaXAyYzZpWUFLbEhXdGJXNmY5dXJ3SHhLS1NFZGJKMyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjI6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771887705);
INSERT INTO `sessions` VALUES ('YhCU9H0VwFeKme91DkDlguKNzvyQktwl76RpZmAJ', NULL, '206.81.29.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/118.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicnJralhUcVZxTzZmamRDNzRlekoyNTFGQ2oyVUZBNlBlWmpLaWxnZCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8yMTMuMTk5LjM2LjIwNCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771898275);
INSERT INTO `sessions` VALUES ('yicH6mRmMEjjgRiLjIKbopGEOinSUseKwyXs6BkS', NULL, '81.29.142.6', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 YaBrowser/21.2.4.165 Yowser/2.5 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia3hRa01oZEF6dHVPamY0TkU0cXJGZmZHdzRZbGVra2FmY2RzSkwyRiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vaWxpZGVzYXZhLmNvbS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1771885058);
INSERT INTO `sessions` VALUES ('ZiltUXocBl6nD1QvmQ4xtEBYgZqmwGkEBBCZxzYO', NULL, '147.185.132.100', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYXU0RmVGVkVpQTFsZnVvMmRESktSOVJTQWxyYjVVRnNNUlJFbzRjcyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjg6Imh0dHBzOi8vMjEzLjE5OS4zNi4yMDQvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1771887105);
INSERT INTO `sessions` VALUES ('ZlMP7SrYFRiNcEU9SvE9AUwZLxhToc9BebDdkj07', NULL, '93.158.90.137', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Viewer/99.9.8853.8', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTngwUWF2ckZlVTh6UHpFeHdiNHM3ajNZTHFFNzNBVE9iNGNEOU5SWCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHBzOi8vaWxpZGVzYXZhLmNvbSI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1771888454);

-- ----------------------------
-- Table structure for ubigeo_inei
-- ----------------------------
DROP TABLE IF EXISTS `ubigeo_inei`;
CREATE TABLE `ubigeo_inei`  (
  `id_ubigeo` int NOT NULL,
  `departamento` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `provincia` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `distrito` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nombre` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_ubigeo`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ubigeo_inei
-- ----------------------------
INSERT INTO `ubigeo_inei` VALUES (1, '01', '00', '00', 'AMAZONAS');
INSERT INTO `ubigeo_inei` VALUES (2, '01', '01', '00', 'CHACHAPOYAS');
INSERT INTO `ubigeo_inei` VALUES (3, '01', '01', '01', 'CHACHAPOYAS');
INSERT INTO `ubigeo_inei` VALUES (4, '01', '01', '02', 'ASUNCION');
INSERT INTO `ubigeo_inei` VALUES (5, '01', '01', '03', 'BALSAS');
INSERT INTO `ubigeo_inei` VALUES (6, '01', '01', '04', 'CHETO');
INSERT INTO `ubigeo_inei` VALUES (7, '01', '01', '05', 'CHILIQUIN');
INSERT INTO `ubigeo_inei` VALUES (8, '01', '01', '06', 'CHUQUIBAMBA');
INSERT INTO `ubigeo_inei` VALUES (9, '01', '01', '07', 'GRANADA');
INSERT INTO `ubigeo_inei` VALUES (10, '01', '01', '08', 'HUANCAS');
INSERT INTO `ubigeo_inei` VALUES (11, '01', '01', '09', 'LA JALCA');
INSERT INTO `ubigeo_inei` VALUES (12, '01', '01', '10', 'LEIMEBAMBA');
INSERT INTO `ubigeo_inei` VALUES (13, '01', '01', '11', 'LEVANTO');
INSERT INTO `ubigeo_inei` VALUES (14, '01', '01', '12', 'MAGDALENA');
INSERT INTO `ubigeo_inei` VALUES (15, '01', '01', '13', 'MARISCAL CASTILLA');
INSERT INTO `ubigeo_inei` VALUES (16, '01', '01', '14', 'MOLINOPAMPA');
INSERT INTO `ubigeo_inei` VALUES (17, '01', '01', '15', 'MONTEVIDEO');
INSERT INTO `ubigeo_inei` VALUES (18, '01', '01', '16', 'OLLEROS');
INSERT INTO `ubigeo_inei` VALUES (19, '01', '01', '17', 'QUINJALCA');
INSERT INTO `ubigeo_inei` VALUES (20, '01', '01', '18', 'SAN FRANCISCO DE DAGUAS');
INSERT INTO `ubigeo_inei` VALUES (21, '01', '01', '19', 'SAN ISIDRO DE MAINO');
INSERT INTO `ubigeo_inei` VALUES (22, '01', '01', '20', 'SOLOCO');
INSERT INTO `ubigeo_inei` VALUES (23, '01', '01', '21', 'SONCHE');
INSERT INTO `ubigeo_inei` VALUES (24, '01', '02', '00', 'BAGUA');
INSERT INTO `ubigeo_inei` VALUES (25, '01', '02', '01', 'BAGUA');
INSERT INTO `ubigeo_inei` VALUES (26, '01', '02', '02', 'ARAMANGO');
INSERT INTO `ubigeo_inei` VALUES (27, '01', '02', '03', 'COPALLIN');
INSERT INTO `ubigeo_inei` VALUES (28, '01', '02', '04', 'EL PARCO');
INSERT INTO `ubigeo_inei` VALUES (29, '01', '02', '05', 'IMAZA');
INSERT INTO `ubigeo_inei` VALUES (30, '01', '02', '06', 'LA PECA');
INSERT INTO `ubigeo_inei` VALUES (31, '01', '03', '00', 'BONGARA');
INSERT INTO `ubigeo_inei` VALUES (32, '01', '03', '01', 'JUMBILLA');
INSERT INTO `ubigeo_inei` VALUES (33, '01', '03', '02', 'CHISQUILLA');
INSERT INTO `ubigeo_inei` VALUES (34, '01', '03', '03', 'CHURUJA');
INSERT INTO `ubigeo_inei` VALUES (35, '01', '03', '04', 'COROSHA');
INSERT INTO `ubigeo_inei` VALUES (36, '01', '03', '05', 'CUISPES');
INSERT INTO `ubigeo_inei` VALUES (37, '01', '03', '06', 'FLORIDA');
INSERT INTO `ubigeo_inei` VALUES (38, '01', '03', '07', 'JAZÁN');
INSERT INTO `ubigeo_inei` VALUES (39, '01', '03', '08', 'RECTA');
INSERT INTO `ubigeo_inei` VALUES (40, '01', '03', '09', 'SAN CARLOS');
INSERT INTO `ubigeo_inei` VALUES (41, '01', '03', '10', 'SHIPASBAMBA');
INSERT INTO `ubigeo_inei` VALUES (42, '01', '03', '11', 'VALERA');
INSERT INTO `ubigeo_inei` VALUES (43, '01', '03', '12', 'YAMBRASBAMBA');
INSERT INTO `ubigeo_inei` VALUES (44, '01', '04', '00', 'CONDORCANQUI');
INSERT INTO `ubigeo_inei` VALUES (45, '01', '04', '01', 'NIEVA');
INSERT INTO `ubigeo_inei` VALUES (46, '01', '04', '02', 'EL CENEPA');
INSERT INTO `ubigeo_inei` VALUES (47, '01', '04', '03', 'RIO SANTIAGO');
INSERT INTO `ubigeo_inei` VALUES (48, '01', '05', '00', 'LUYA');
INSERT INTO `ubigeo_inei` VALUES (49, '01', '05', '01', 'LAMUD');
INSERT INTO `ubigeo_inei` VALUES (50, '01', '05', '02', 'CAMPORREDONDO');
INSERT INTO `ubigeo_inei` VALUES (51, '01', '05', '03', 'COCABAMBA');
INSERT INTO `ubigeo_inei` VALUES (52, '01', '05', '04', 'COLCAMAR');
INSERT INTO `ubigeo_inei` VALUES (53, '01', '05', '05', 'CONILA');
INSERT INTO `ubigeo_inei` VALUES (54, '01', '05', '06', 'INGUILPATA');
INSERT INTO `ubigeo_inei` VALUES (55, '01', '05', '07', 'LONGUITA');
INSERT INTO `ubigeo_inei` VALUES (56, '01', '05', '08', 'LONYA CHICO');
INSERT INTO `ubigeo_inei` VALUES (57, '01', '05', '09', 'LUYA');
INSERT INTO `ubigeo_inei` VALUES (58, '01', '05', '10', 'LUYA VIEJO');
INSERT INTO `ubigeo_inei` VALUES (59, '01', '05', '11', 'MARIA');
INSERT INTO `ubigeo_inei` VALUES (60, '01', '05', '12', 'OCALLI');
INSERT INTO `ubigeo_inei` VALUES (61, '01', '05', '13', 'OCUMAL');
INSERT INTO `ubigeo_inei` VALUES (62, '01', '05', '14', 'PISUQUIA');
INSERT INTO `ubigeo_inei` VALUES (63, '01', '05', '15', 'PROVIDENCIA');
INSERT INTO `ubigeo_inei` VALUES (64, '01', '05', '16', 'SAN CRISTOBAL');
INSERT INTO `ubigeo_inei` VALUES (65, '01', '05', '17', 'SAN FRANCISCO DEL YESO');
INSERT INTO `ubigeo_inei` VALUES (66, '01', '05', '18', 'SAN JERONIMO');
INSERT INTO `ubigeo_inei` VALUES (67, '01', '05', '19', 'SAN JUAN DE LOPECANCHA');
INSERT INTO `ubigeo_inei` VALUES (68, '01', '05', '20', 'SANTA CATALINA');
INSERT INTO `ubigeo_inei` VALUES (69, '01', '05', '21', 'SANTO TOMAS');
INSERT INTO `ubigeo_inei` VALUES (70, '01', '05', '22', 'TINGO');
INSERT INTO `ubigeo_inei` VALUES (71, '01', '05', '23', 'TRITA');
INSERT INTO `ubigeo_inei` VALUES (72, '01', '06', '00', 'RODRIGUEZ DE MENDOZA');
INSERT INTO `ubigeo_inei` VALUES (73, '01', '06', '01', 'SAN NICOLAS');
INSERT INTO `ubigeo_inei` VALUES (74, '01', '06', '02', 'CHIRIMOTO');
INSERT INTO `ubigeo_inei` VALUES (75, '01', '06', '03', 'COCHAMAL');
INSERT INTO `ubigeo_inei` VALUES (76, '01', '06', '04', 'HUAMBO');
INSERT INTO `ubigeo_inei` VALUES (77, '01', '06', '05', 'LIMABAMBA');
INSERT INTO `ubigeo_inei` VALUES (78, '01', '06', '06', 'LONGAR');
INSERT INTO `ubigeo_inei` VALUES (79, '01', '06', '07', 'MARISCAL BENAVIDES');
INSERT INTO `ubigeo_inei` VALUES (80, '01', '06', '08', 'MILPUC');
INSERT INTO `ubigeo_inei` VALUES (81, '01', '06', '09', 'OMIA');
INSERT INTO `ubigeo_inei` VALUES (82, '01', '06', '10', 'SANTA ROSA');
INSERT INTO `ubigeo_inei` VALUES (83, '01', '06', '11', 'TOTORA');
INSERT INTO `ubigeo_inei` VALUES (84, '01', '06', '12', 'VISTA ALEGRE');
INSERT INTO `ubigeo_inei` VALUES (85, '01', '07', '00', 'UTCUBAMBA');
INSERT INTO `ubigeo_inei` VALUES (86, '01', '07', '01', 'BAGUA GRANDE');
INSERT INTO `ubigeo_inei` VALUES (87, '01', '07', '02', 'CAJARURO');
INSERT INTO `ubigeo_inei` VALUES (88, '01', '07', '03', 'CUMBA');
INSERT INTO `ubigeo_inei` VALUES (89, '01', '07', '04', 'EL MILAGRO');
INSERT INTO `ubigeo_inei` VALUES (90, '01', '07', '05', 'JAMALCA');
INSERT INTO `ubigeo_inei` VALUES (91, '01', '07', '06', 'LONYA GRANDE');
INSERT INTO `ubigeo_inei` VALUES (92, '01', '07', '07', 'YAMON');
INSERT INTO `ubigeo_inei` VALUES (93, '02', '00', '00', 'ANCASH');
INSERT INTO `ubigeo_inei` VALUES (94, '02', '01', '00', 'HUARAZ');
INSERT INTO `ubigeo_inei` VALUES (95, '02', '01', '01', 'HUARAZ');
INSERT INTO `ubigeo_inei` VALUES (96, '02', '01', '02', 'COCHABAMBA');
INSERT INTO `ubigeo_inei` VALUES (97, '02', '01', '03', 'COLCABAMBA');
INSERT INTO `ubigeo_inei` VALUES (98, '02', '01', '04', 'HUANCHAY');
INSERT INTO `ubigeo_inei` VALUES (99, '02', '01', '05', 'INDEPENDENCIA');
INSERT INTO `ubigeo_inei` VALUES (100, '02', '01', '06', 'JANGAS');
INSERT INTO `ubigeo_inei` VALUES (101, '02', '01', '07', 'LA LIBERTAD');
INSERT INTO `ubigeo_inei` VALUES (102, '02', '01', '08', 'OLLEROS');
INSERT INTO `ubigeo_inei` VALUES (103, '02', '01', '09', 'PAMPAS');
INSERT INTO `ubigeo_inei` VALUES (104, '02', '01', '10', 'PARIACOTO');
INSERT INTO `ubigeo_inei` VALUES (105, '02', '01', '11', 'PIRA');
INSERT INTO `ubigeo_inei` VALUES (106, '02', '01', '12', 'TARICA');
INSERT INTO `ubigeo_inei` VALUES (107, '02', '02', '00', 'AIJA');
INSERT INTO `ubigeo_inei` VALUES (108, '02', '02', '01', 'AIJA');
INSERT INTO `ubigeo_inei` VALUES (109, '02', '02', '02', 'CORIS');
INSERT INTO `ubigeo_inei` VALUES (110, '02', '02', '03', 'HUACLLAN');
INSERT INTO `ubigeo_inei` VALUES (111, '02', '02', '04', 'LA MERCED');
INSERT INTO `ubigeo_inei` VALUES (112, '02', '02', '05', 'SUCCHA');
INSERT INTO `ubigeo_inei` VALUES (113, '02', '03', '00', 'ANTONIO RAYMONDI');
INSERT INTO `ubigeo_inei` VALUES (114, '02', '03', '01', 'LLAMELLIN');
INSERT INTO `ubigeo_inei` VALUES (115, '02', '03', '02', 'ACZO');
INSERT INTO `ubigeo_inei` VALUES (116, '02', '03', '03', 'CHACCHO');
INSERT INTO `ubigeo_inei` VALUES (117, '02', '03', '04', 'CHINGAS');
INSERT INTO `ubigeo_inei` VALUES (118, '02', '03', '05', 'MIRGAS');
INSERT INTO `ubigeo_inei` VALUES (119, '02', '03', '06', 'SAN JUAN DE RONTOY');
INSERT INTO `ubigeo_inei` VALUES (120, '02', '04', '00', 'ASUNCION');
INSERT INTO `ubigeo_inei` VALUES (121, '02', '04', '01', 'CHACAS');
INSERT INTO `ubigeo_inei` VALUES (122, '02', '04', '02', 'ACOCHACA');
INSERT INTO `ubigeo_inei` VALUES (123, '02', '05', '00', 'BOLOGNESI');
INSERT INTO `ubigeo_inei` VALUES (124, '02', '05', '01', 'CHIQUIAN');
INSERT INTO `ubigeo_inei` VALUES (125, '02', '05', '02', 'ABELARDO PARDO LEZAMETA');
INSERT INTO `ubigeo_inei` VALUES (126, '02', '05', '03', 'ANTONIO RAYMONDI');
INSERT INTO `ubigeo_inei` VALUES (127, '02', '05', '04', 'AQUIA');
INSERT INTO `ubigeo_inei` VALUES (128, '02', '05', '05', 'CAJACAY');
INSERT INTO `ubigeo_inei` VALUES (129, '02', '05', '06', 'CANIS');
INSERT INTO `ubigeo_inei` VALUES (130, '02', '05', '07', 'COLQUIOC');
INSERT INTO `ubigeo_inei` VALUES (131, '02', '05', '08', 'HUALLANCA');
INSERT INTO `ubigeo_inei` VALUES (132, '02', '05', '09', 'HUASTA');
INSERT INTO `ubigeo_inei` VALUES (133, '02', '05', '10', 'HUAYLLACAYAN');
INSERT INTO `ubigeo_inei` VALUES (134, '02', '05', '11', 'LA PRIMAVERA');
INSERT INTO `ubigeo_inei` VALUES (135, '02', '05', '12', 'MANGAS');
INSERT INTO `ubigeo_inei` VALUES (136, '02', '05', '13', 'PACLLON');
INSERT INTO `ubigeo_inei` VALUES (137, '02', '05', '14', 'SAN MIGUEL DE CORPANQUI');
INSERT INTO `ubigeo_inei` VALUES (138, '02', '05', '15', 'TICLLOS');
INSERT INTO `ubigeo_inei` VALUES (139, '02', '06', '00', 'CARHUAZ');
INSERT INTO `ubigeo_inei` VALUES (140, '02', '06', '01', 'CARHUAZ');
INSERT INTO `ubigeo_inei` VALUES (141, '02', '06', '02', 'ACOPAMPA');
INSERT INTO `ubigeo_inei` VALUES (142, '02', '06', '03', 'AMASHCA');
INSERT INTO `ubigeo_inei` VALUES (143, '02', '06', '04', 'ANTA');
INSERT INTO `ubigeo_inei` VALUES (144, '02', '06', '05', 'ATAQUERO');
INSERT INTO `ubigeo_inei` VALUES (145, '02', '06', '06', 'MARCARA');
INSERT INTO `ubigeo_inei` VALUES (146, '02', '06', '07', 'PARIAHUANCA');
INSERT INTO `ubigeo_inei` VALUES (147, '02', '06', '08', 'SAN MIGUEL DE ACO');
INSERT INTO `ubigeo_inei` VALUES (148, '02', '06', '09', 'SHILLA');
INSERT INTO `ubigeo_inei` VALUES (149, '02', '06', '10', 'TINCO');
INSERT INTO `ubigeo_inei` VALUES (150, '02', '06', '11', 'YUNGAR');
INSERT INTO `ubigeo_inei` VALUES (151, '02', '07', '00', 'CARLOS FERMIN FITZCARRALD');
INSERT INTO `ubigeo_inei` VALUES (152, '02', '07', '01', 'SAN LUIS');
INSERT INTO `ubigeo_inei` VALUES (153, '02', '07', '02', 'SAN NICOLAS');
INSERT INTO `ubigeo_inei` VALUES (154, '02', '07', '03', 'YAUYA');
INSERT INTO `ubigeo_inei` VALUES (155, '02', '08', '00', 'CASMA');
INSERT INTO `ubigeo_inei` VALUES (156, '02', '08', '01', 'CASMA');
INSERT INTO `ubigeo_inei` VALUES (157, '02', '08', '02', 'BUENA VISTA ALTA');
INSERT INTO `ubigeo_inei` VALUES (158, '02', '08', '03', 'COMANDANTE NOEL');
INSERT INTO `ubigeo_inei` VALUES (159, '02', '08', '04', 'YAUTAN');
INSERT INTO `ubigeo_inei` VALUES (160, '02', '09', '00', 'CORONGO');
INSERT INTO `ubigeo_inei` VALUES (161, '02', '09', '01', 'CORONGO');
INSERT INTO `ubigeo_inei` VALUES (162, '02', '09', '02', 'ACO');
INSERT INTO `ubigeo_inei` VALUES (163, '02', '09', '03', 'BAMBAS');
INSERT INTO `ubigeo_inei` VALUES (164, '02', '09', '04', 'CUSCA');
INSERT INTO `ubigeo_inei` VALUES (165, '02', '09', '05', 'LA PAMPA');
INSERT INTO `ubigeo_inei` VALUES (166, '02', '09', '06', 'YANAC');
INSERT INTO `ubigeo_inei` VALUES (167, '02', '09', '07', 'YUPAN');
INSERT INTO `ubigeo_inei` VALUES (168, '02', '10', '00', 'HUARI');
INSERT INTO `ubigeo_inei` VALUES (169, '02', '10', '01', 'HUARI');
INSERT INTO `ubigeo_inei` VALUES (170, '02', '10', '02', 'ANRA');
INSERT INTO `ubigeo_inei` VALUES (171, '02', '10', '03', 'CAJAY');
INSERT INTO `ubigeo_inei` VALUES (172, '02', '10', '04', 'CHAVIN DE HUANTAR');
INSERT INTO `ubigeo_inei` VALUES (173, '02', '10', '05', 'HUACACHI');
INSERT INTO `ubigeo_inei` VALUES (174, '02', '10', '06', 'HUACCHIS');
INSERT INTO `ubigeo_inei` VALUES (175, '02', '10', '07', 'HUACHIS');
INSERT INTO `ubigeo_inei` VALUES (176, '02', '10', '08', 'HUANTAR');
INSERT INTO `ubigeo_inei` VALUES (177, '02', '10', '09', 'MASIN');
INSERT INTO `ubigeo_inei` VALUES (178, '02', '10', '10', 'PAUCAS');
INSERT INTO `ubigeo_inei` VALUES (179, '02', '10', '11', 'PONTO');
INSERT INTO `ubigeo_inei` VALUES (180, '02', '10', '12', 'RAHUAPAMPA');
INSERT INTO `ubigeo_inei` VALUES (181, '02', '10', '13', 'RAPAYAN');
INSERT INTO `ubigeo_inei` VALUES (182, '02', '10', '14', 'SAN MARCOS');
INSERT INTO `ubigeo_inei` VALUES (183, '02', '10', '15', 'SAN PEDRO DE CHANA');
INSERT INTO `ubigeo_inei` VALUES (184, '02', '10', '16', 'UCO');
INSERT INTO `ubigeo_inei` VALUES (185, '02', '11', '00', 'HUARMEY');
INSERT INTO `ubigeo_inei` VALUES (186, '02', '11', '01', 'HUARMEY');
INSERT INTO `ubigeo_inei` VALUES (187, '02', '11', '02', 'COCHAPETI');
INSERT INTO `ubigeo_inei` VALUES (188, '02', '11', '03', 'CULEBRAS');
INSERT INTO `ubigeo_inei` VALUES (189, '02', '11', '04', 'HUAYAN');
INSERT INTO `ubigeo_inei` VALUES (190, '02', '11', '05', 'MALVAS');
INSERT INTO `ubigeo_inei` VALUES (191, '02', '12', '00', 'HUAYLAS');
INSERT INTO `ubigeo_inei` VALUES (192, '02', '12', '01', 'CARAZ');
INSERT INTO `ubigeo_inei` VALUES (193, '02', '12', '02', 'HUALLANCA');
INSERT INTO `ubigeo_inei` VALUES (194, '02', '12', '03', 'HUATA');
INSERT INTO `ubigeo_inei` VALUES (195, '02', '12', '04', 'HUAYLAS');
INSERT INTO `ubigeo_inei` VALUES (196, '02', '12', '05', 'MATO');
INSERT INTO `ubigeo_inei` VALUES (197, '02', '12', '06', 'PAMPAROMAS');
INSERT INTO `ubigeo_inei` VALUES (198, '02', '12', '07', 'PUEBLO LIBRE');
INSERT INTO `ubigeo_inei` VALUES (199, '02', '12', '08', 'SANTA CRUZ');
INSERT INTO `ubigeo_inei` VALUES (200, '02', '12', '09', 'SANTO TORIBIO');
INSERT INTO `ubigeo_inei` VALUES (201, '02', '12', '10', 'YURACMARCA');
INSERT INTO `ubigeo_inei` VALUES (202, '02', '13', '00', 'MARISCAL LUZURIAGA');
INSERT INTO `ubigeo_inei` VALUES (203, '02', '13', '01', 'PISCOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (204, '02', '13', '02', 'CASCA');
INSERT INTO `ubigeo_inei` VALUES (205, '02', '13', '03', 'ELEAZAR GUZMAN BARRON');
INSERT INTO `ubigeo_inei` VALUES (206, '02', '13', '04', 'FIDEL OLIVAS ESCUDERO');
INSERT INTO `ubigeo_inei` VALUES (207, '02', '13', '05', 'LLAMA');
INSERT INTO `ubigeo_inei` VALUES (208, '02', '13', '06', 'LLUMPA');
INSERT INTO `ubigeo_inei` VALUES (209, '02', '13', '07', 'LUCMA');
INSERT INTO `ubigeo_inei` VALUES (210, '02', '13', '08', 'MUSGA');
INSERT INTO `ubigeo_inei` VALUES (211, '02', '14', '00', 'OCROS');
INSERT INTO `ubigeo_inei` VALUES (212, '02', '14', '01', 'OCROS');
INSERT INTO `ubigeo_inei` VALUES (213, '02', '14', '02', 'ACAS');
INSERT INTO `ubigeo_inei` VALUES (214, '02', '14', '03', 'CAJAMARQUILLA');
INSERT INTO `ubigeo_inei` VALUES (215, '02', '14', '04', 'CARHUAPAMPA');
INSERT INTO `ubigeo_inei` VALUES (216, '02', '14', '05', 'COCHAS');
INSERT INTO `ubigeo_inei` VALUES (217, '02', '14', '06', 'CONGAS');
INSERT INTO `ubigeo_inei` VALUES (218, '02', '14', '07', 'LLIPA');
INSERT INTO `ubigeo_inei` VALUES (219, '02', '14', '08', 'SAN CRISTOBAL DE RAJAN');
INSERT INTO `ubigeo_inei` VALUES (220, '02', '14', '09', 'SAN PEDRO');
INSERT INTO `ubigeo_inei` VALUES (221, '02', '14', '10', 'SANTIAGO DE CHILCAS');
INSERT INTO `ubigeo_inei` VALUES (222, '02', '15', '00', 'PALLASCA');
INSERT INTO `ubigeo_inei` VALUES (223, '02', '15', '01', 'CABANA');
INSERT INTO `ubigeo_inei` VALUES (224, '02', '15', '02', 'BOLOGNESI');
INSERT INTO `ubigeo_inei` VALUES (225, '02', '15', '03', 'CONCHUCOS');
INSERT INTO `ubigeo_inei` VALUES (226, '02', '15', '04', 'HUACASCHUQUE');
INSERT INTO `ubigeo_inei` VALUES (227, '02', '15', '05', 'HUANDOVAL');
INSERT INTO `ubigeo_inei` VALUES (228, '02', '15', '06', 'LACABAMBA');
INSERT INTO `ubigeo_inei` VALUES (229, '02', '15', '07', 'LLAPO');
INSERT INTO `ubigeo_inei` VALUES (230, '02', '15', '08', 'PALLASCA');
INSERT INTO `ubigeo_inei` VALUES (231, '02', '15', '09', 'PAMPAS');
INSERT INTO `ubigeo_inei` VALUES (232, '02', '15', '10', 'SANTA ROSA');
INSERT INTO `ubigeo_inei` VALUES (233, '02', '15', '11', 'TAUCA');
INSERT INTO `ubigeo_inei` VALUES (234, '02', '16', '00', 'POMABAMBA');
INSERT INTO `ubigeo_inei` VALUES (235, '02', '16', '01', 'POMABAMBA');
INSERT INTO `ubigeo_inei` VALUES (236, '02', '16', '02', 'HUAYLLAN');
INSERT INTO `ubigeo_inei` VALUES (237, '02', '16', '03', 'PAROBAMBA');
INSERT INTO `ubigeo_inei` VALUES (238, '02', '16', '04', 'QUINUABAMBA');
INSERT INTO `ubigeo_inei` VALUES (239, '02', '17', '00', 'RECUAY');
INSERT INTO `ubigeo_inei` VALUES (240, '02', '17', '01', 'RECUAY');
INSERT INTO `ubigeo_inei` VALUES (241, '02', '17', '02', 'CATAC');
INSERT INTO `ubigeo_inei` VALUES (242, '02', '17', '03', 'COTAPARACO');
INSERT INTO `ubigeo_inei` VALUES (243, '02', '17', '04', 'HUAYLLAPAMPA');
INSERT INTO `ubigeo_inei` VALUES (244, '02', '17', '05', 'LLACLLIN');
INSERT INTO `ubigeo_inei` VALUES (245, '02', '17', '06', 'MARCA');
INSERT INTO `ubigeo_inei` VALUES (246, '02', '17', '07', 'PAMPAS CHICO');
INSERT INTO `ubigeo_inei` VALUES (247, '02', '17', '08', 'PARARIN');
INSERT INTO `ubigeo_inei` VALUES (248, '02', '17', '09', 'TAPACOCHA');
INSERT INTO `ubigeo_inei` VALUES (249, '02', '17', '10', 'TICAPAMPA');
INSERT INTO `ubigeo_inei` VALUES (250, '02', '18', '00', 'SANTA');
INSERT INTO `ubigeo_inei` VALUES (251, '02', '18', '01', 'CHIMBOTE');
INSERT INTO `ubigeo_inei` VALUES (252, '02', '18', '02', 'CACERES DEL PERU');
INSERT INTO `ubigeo_inei` VALUES (253, '02', '18', '03', 'COISHCO');
INSERT INTO `ubigeo_inei` VALUES (254, '02', '18', '04', 'MACATE');
INSERT INTO `ubigeo_inei` VALUES (255, '02', '18', '05', 'MORO');
INSERT INTO `ubigeo_inei` VALUES (256, '02', '18', '06', 'NEPEÑA');
INSERT INTO `ubigeo_inei` VALUES (257, '02', '18', '07', 'SAMANCO');
INSERT INTO `ubigeo_inei` VALUES (258, '02', '18', '08', 'SANTA');
INSERT INTO `ubigeo_inei` VALUES (259, '02', '18', '09', 'NUEVO CHIMBOTE');
INSERT INTO `ubigeo_inei` VALUES (260, '02', '19', '00', 'SIHUAS');
INSERT INTO `ubigeo_inei` VALUES (261, '02', '19', '01', 'SIHUAS');
INSERT INTO `ubigeo_inei` VALUES (262, '02', '19', '02', 'ACOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (263, '02', '19', '03', 'ALFONSO UGARTE');
INSERT INTO `ubigeo_inei` VALUES (264, '02', '19', '04', 'CASHAPAMPA');
INSERT INTO `ubigeo_inei` VALUES (265, '02', '19', '05', 'CHINGALPO');
INSERT INTO `ubigeo_inei` VALUES (266, '02', '19', '06', 'HUAYLLABAMBA');
INSERT INTO `ubigeo_inei` VALUES (267, '02', '19', '07', 'QUICHES');
INSERT INTO `ubigeo_inei` VALUES (268, '02', '19', '08', 'RAGASH');
INSERT INTO `ubigeo_inei` VALUES (269, '02', '19', '09', 'SAN JUAN');
INSERT INTO `ubigeo_inei` VALUES (270, '02', '19', '10', 'SICSIBAMBA');
INSERT INTO `ubigeo_inei` VALUES (271, '02', '20', '00', 'YUNGAY');
INSERT INTO `ubigeo_inei` VALUES (272, '02', '20', '01', 'YUNGAY');
INSERT INTO `ubigeo_inei` VALUES (273, '02', '20', '02', 'CASCAPARA');
INSERT INTO `ubigeo_inei` VALUES (274, '02', '20', '03', 'MANCOS');
INSERT INTO `ubigeo_inei` VALUES (275, '02', '20', '04', 'MATACOTO');
INSERT INTO `ubigeo_inei` VALUES (276, '02', '20', '05', 'QUILLO');
INSERT INTO `ubigeo_inei` VALUES (277, '02', '20', '06', 'RANRAHIRCA');
INSERT INTO `ubigeo_inei` VALUES (278, '02', '20', '07', 'SHUPLUY');
INSERT INTO `ubigeo_inei` VALUES (279, '02', '20', '08', 'YANAMA');
INSERT INTO `ubigeo_inei` VALUES (280, '03', '00', '00', 'APURIMAC');
INSERT INTO `ubigeo_inei` VALUES (281, '03', '01', '00', 'ABANCAY');
INSERT INTO `ubigeo_inei` VALUES (282, '03', '01', '01', 'ABANCAY');
INSERT INTO `ubigeo_inei` VALUES (283, '03', '01', '02', 'CHACOCHE');
INSERT INTO `ubigeo_inei` VALUES (284, '03', '01', '03', 'CIRCA');
INSERT INTO `ubigeo_inei` VALUES (285, '03', '01', '04', 'CURAHUASI');
INSERT INTO `ubigeo_inei` VALUES (286, '03', '01', '05', 'HUANIPACA');
INSERT INTO `ubigeo_inei` VALUES (287, '03', '01', '06', 'LAMBRAMA');
INSERT INTO `ubigeo_inei` VALUES (288, '03', '01', '07', 'PICHIRHUA');
INSERT INTO `ubigeo_inei` VALUES (289, '03', '01', '08', 'SAN PEDRO DE CACHORA');
INSERT INTO `ubigeo_inei` VALUES (290, '03', '01', '09', 'TAMBURCO');
INSERT INTO `ubigeo_inei` VALUES (291, '03', '02', '00', 'ANDAHUAYLAS');
INSERT INTO `ubigeo_inei` VALUES (292, '03', '02', '01', 'ANDAHUAYLAS');
INSERT INTO `ubigeo_inei` VALUES (293, '03', '02', '02', 'ANDARAPA');
INSERT INTO `ubigeo_inei` VALUES (294, '03', '02', '03', 'CHIARA');
INSERT INTO `ubigeo_inei` VALUES (295, '03', '02', '04', 'HUANCARAMA');
INSERT INTO `ubigeo_inei` VALUES (296, '03', '02', '05', 'HUANCARAY');
INSERT INTO `ubigeo_inei` VALUES (297, '03', '02', '06', 'HUAYANA');
INSERT INTO `ubigeo_inei` VALUES (298, '03', '02', '07', 'KISHUARA');
INSERT INTO `ubigeo_inei` VALUES (299, '03', '02', '08', 'PACOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (300, '03', '02', '09', 'PACUCHA');
INSERT INTO `ubigeo_inei` VALUES (301, '03', '02', '10', 'PAMPACHIRI');
INSERT INTO `ubigeo_inei` VALUES (302, '03', '02', '11', 'POMACOCHA');
INSERT INTO `ubigeo_inei` VALUES (303, '03', '02', '12', 'SAN ANTONIO DE CACHI');
INSERT INTO `ubigeo_inei` VALUES (304, '03', '02', '13', 'SAN JERONIMO');
INSERT INTO `ubigeo_inei` VALUES (305, '03', '02', '14', 'SAN MIGUEL DE CHACCRAMPA');
INSERT INTO `ubigeo_inei` VALUES (306, '03', '02', '15', 'SANTA MARIA DE CHICMO');
INSERT INTO `ubigeo_inei` VALUES (307, '03', '02', '16', 'TALAVERA');
INSERT INTO `ubigeo_inei` VALUES (308, '03', '02', '17', 'TUMAY HUARACA');
INSERT INTO `ubigeo_inei` VALUES (309, '03', '02', '18', 'TURPO');
INSERT INTO `ubigeo_inei` VALUES (310, '03', '02', '19', 'KAQUIABAMBA');
INSERT INTO `ubigeo_inei` VALUES (311, '03', '03', '00', 'ANTABAMBA');
INSERT INTO `ubigeo_inei` VALUES (312, '03', '03', '01', 'ANTABAMBA');
INSERT INTO `ubigeo_inei` VALUES (313, '03', '03', '02', 'EL ORO');
INSERT INTO `ubigeo_inei` VALUES (314, '03', '03', '03', 'HUAQUIRCA');
INSERT INTO `ubigeo_inei` VALUES (315, '03', '03', '04', 'JUAN ESPINOZA MEDRANO');
INSERT INTO `ubigeo_inei` VALUES (316, '03', '03', '05', 'OROPESA');
INSERT INTO `ubigeo_inei` VALUES (317, '03', '03', '06', 'PACHACONAS');
INSERT INTO `ubigeo_inei` VALUES (318, '03', '03', '07', 'SABAINO');
INSERT INTO `ubigeo_inei` VALUES (319, '03', '04', '00', 'AYMARAES');
INSERT INTO `ubigeo_inei` VALUES (320, '03', '04', '01', 'CHALHUANCA');
INSERT INTO `ubigeo_inei` VALUES (321, '03', '04', '02', 'CAPAYA');
INSERT INTO `ubigeo_inei` VALUES (322, '03', '04', '03', 'CARAYBAMBA');
INSERT INTO `ubigeo_inei` VALUES (323, '03', '04', '04', 'CHAPIMARCA');
INSERT INTO `ubigeo_inei` VALUES (324, '03', '04', '05', 'COLCABAMBA');
INSERT INTO `ubigeo_inei` VALUES (325, '03', '04', '06', 'COTARUSE');
INSERT INTO `ubigeo_inei` VALUES (326, '03', '04', '07', 'HUAYLLO');
INSERT INTO `ubigeo_inei` VALUES (327, '03', '04', '08', 'JUSTO APU SAHUARAURA');
INSERT INTO `ubigeo_inei` VALUES (328, '03', '04', '09', 'LUCRE');
INSERT INTO `ubigeo_inei` VALUES (329, '03', '04', '10', 'POCOHUANCA');
INSERT INTO `ubigeo_inei` VALUES (330, '03', '04', '11', 'SAN JUAN DE CHACÑA');
INSERT INTO `ubigeo_inei` VALUES (331, '03', '04', '12', 'SAÑAYCA');
INSERT INTO `ubigeo_inei` VALUES (332, '03', '04', '13', 'SORAYA');
INSERT INTO `ubigeo_inei` VALUES (333, '03', '04', '14', 'TAPAIRIHUA');
INSERT INTO `ubigeo_inei` VALUES (334, '03', '04', '15', 'TINTAY');
INSERT INTO `ubigeo_inei` VALUES (335, '03', '04', '16', 'TORAYA');
INSERT INTO `ubigeo_inei` VALUES (336, '03', '04', '17', 'YANACA');
INSERT INTO `ubigeo_inei` VALUES (337, '03', '05', '00', 'COTABAMBAS');
INSERT INTO `ubigeo_inei` VALUES (338, '03', '05', '01', 'TAMBOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (339, '03', '05', '02', 'COTABAMBAS');
INSERT INTO `ubigeo_inei` VALUES (340, '03', '05', '03', 'COYLLURQUI');
INSERT INTO `ubigeo_inei` VALUES (341, '03', '05', '04', 'HAQUIRA');
INSERT INTO `ubigeo_inei` VALUES (342, '03', '05', '05', 'MARA');
INSERT INTO `ubigeo_inei` VALUES (343, '03', '05', '06', 'CHALLHUAHUACHO');
INSERT INTO `ubigeo_inei` VALUES (344, '03', '06', '00', 'CHINCHEROS');
INSERT INTO `ubigeo_inei` VALUES (345, '03', '06', '01', 'CHINCHEROS');
INSERT INTO `ubigeo_inei` VALUES (346, '03', '06', '02', 'ANCO-HUALLO');
INSERT INTO `ubigeo_inei` VALUES (347, '03', '06', '03', 'COCHARCAS');
INSERT INTO `ubigeo_inei` VALUES (348, '03', '06', '04', 'HUACCANA');
INSERT INTO `ubigeo_inei` VALUES (349, '03', '06', '05', 'OCOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (350, '03', '06', '06', 'ONGOY');
INSERT INTO `ubigeo_inei` VALUES (351, '03', '06', '07', 'URANMARCA');
INSERT INTO `ubigeo_inei` VALUES (352, '03', '06', '08', 'RANRACANCHA');
INSERT INTO `ubigeo_inei` VALUES (353, '03', '07', '00', 'GRAU');
INSERT INTO `ubigeo_inei` VALUES (354, '03', '07', '01', 'CHUQUIBAMBILLA');
INSERT INTO `ubigeo_inei` VALUES (355, '03', '07', '02', 'CURPAHUASI');
INSERT INTO `ubigeo_inei` VALUES (356, '03', '07', '03', 'GAMARRA');
INSERT INTO `ubigeo_inei` VALUES (357, '03', '07', '04', 'HUAYLLATI');
INSERT INTO `ubigeo_inei` VALUES (358, '03', '07', '05', 'MAMARA');
INSERT INTO `ubigeo_inei` VALUES (359, '03', '07', '06', 'MICAELA BASTIDAS');
INSERT INTO `ubigeo_inei` VALUES (360, '03', '07', '07', 'PATAYPAMPA');
INSERT INTO `ubigeo_inei` VALUES (361, '03', '07', '08', 'PROGRESO');
INSERT INTO `ubigeo_inei` VALUES (362, '03', '07', '09', 'SAN ANTONIO');
INSERT INTO `ubigeo_inei` VALUES (363, '03', '07', '10', 'SANTA ROSA');
INSERT INTO `ubigeo_inei` VALUES (364, '03', '07', '11', 'TURPAY');
INSERT INTO `ubigeo_inei` VALUES (365, '03', '07', '12', 'VILCABAMBA');
INSERT INTO `ubigeo_inei` VALUES (366, '03', '07', '13', 'VIRUNDO');
INSERT INTO `ubigeo_inei` VALUES (367, '03', '07', '14', 'CURASCO');
INSERT INTO `ubigeo_inei` VALUES (368, '04', '00', '00', 'AREQUIPA');
INSERT INTO `ubigeo_inei` VALUES (369, '04', '01', '00', 'AREQUIPA');
INSERT INTO `ubigeo_inei` VALUES (370, '04', '01', '01', 'AREQUIPA');
INSERT INTO `ubigeo_inei` VALUES (371, '04', '01', '02', 'ALTO SELVA ALEGRE');
INSERT INTO `ubigeo_inei` VALUES (372, '04', '01', '03', 'CAYMA');
INSERT INTO `ubigeo_inei` VALUES (373, '04', '01', '04', 'CERRO COLORADO');
INSERT INTO `ubigeo_inei` VALUES (374, '04', '01', '05', 'CHARACATO');
INSERT INTO `ubigeo_inei` VALUES (375, '04', '01', '06', 'CHIGUATA');
INSERT INTO `ubigeo_inei` VALUES (376, '04', '01', '07', 'JACOBO HUNTER');
INSERT INTO `ubigeo_inei` VALUES (377, '04', '01', '08', 'LA JOYA');
INSERT INTO `ubigeo_inei` VALUES (378, '04', '01', '09', 'MARIANO MELGAR');
INSERT INTO `ubigeo_inei` VALUES (379, '04', '01', '10', 'MIRAFLORES');
INSERT INTO `ubigeo_inei` VALUES (380, '04', '01', '11', 'MOLLEBAYA');
INSERT INTO `ubigeo_inei` VALUES (381, '04', '01', '12', 'PAUCARPATA');
INSERT INTO `ubigeo_inei` VALUES (382, '04', '01', '13', 'POCSI');
INSERT INTO `ubigeo_inei` VALUES (383, '04', '01', '14', 'POLOBAYA');
INSERT INTO `ubigeo_inei` VALUES (384, '04', '01', '15', 'QUEQUEÑA');
INSERT INTO `ubigeo_inei` VALUES (385, '04', '01', '16', 'SABANDIA');
INSERT INTO `ubigeo_inei` VALUES (386, '04', '01', '17', 'SACHACA');
INSERT INTO `ubigeo_inei` VALUES (387, '04', '01', '18', 'SAN JUAN DE SIGUAS');
INSERT INTO `ubigeo_inei` VALUES (388, '04', '01', '19', 'SAN JUAN DE TARUCANI');
INSERT INTO `ubigeo_inei` VALUES (389, '04', '01', '20', 'SANTA ISABEL DE SIGUAS');
INSERT INTO `ubigeo_inei` VALUES (390, '04', '01', '21', 'SANTA RITA DE SIGUAS');
INSERT INTO `ubigeo_inei` VALUES (391, '04', '01', '22', 'SOCABAYA');
INSERT INTO `ubigeo_inei` VALUES (392, '04', '01', '23', 'TIABAYA');
INSERT INTO `ubigeo_inei` VALUES (393, '04', '01', '24', 'UCHUMAYO');
INSERT INTO `ubigeo_inei` VALUES (394, '04', '01', '25', 'VITOR');
INSERT INTO `ubigeo_inei` VALUES (395, '04', '01', '26', 'YANAHUARA');
INSERT INTO `ubigeo_inei` VALUES (396, '04', '01', '27', 'YARABAMBA');
INSERT INTO `ubigeo_inei` VALUES (397, '04', '01', '28', 'YURA');
INSERT INTO `ubigeo_inei` VALUES (398, '04', '01', '29', 'JOSE LUIS BUSTAMANTE Y RIVERO');
INSERT INTO `ubigeo_inei` VALUES (399, '04', '02', '00', 'CAMANA');
INSERT INTO `ubigeo_inei` VALUES (400, '04', '02', '01', 'CAMANA');
INSERT INTO `ubigeo_inei` VALUES (401, '04', '02', '02', 'JOSE MARIA QUIMPER');
INSERT INTO `ubigeo_inei` VALUES (402, '04', '02', '03', 'MARIANO NICOLAS VALCARCEL');
INSERT INTO `ubigeo_inei` VALUES (403, '04', '02', '04', 'MARISCAL CACERES');
INSERT INTO `ubigeo_inei` VALUES (404, '04', '02', '05', 'NICOLAS DE PIEROLA');
INSERT INTO `ubigeo_inei` VALUES (405, '04', '02', '06', 'OCOÑA');
INSERT INTO `ubigeo_inei` VALUES (406, '04', '02', '07', 'QUILCA');
INSERT INTO `ubigeo_inei` VALUES (407, '04', '02', '08', 'SAMUEL PASTOR');
INSERT INTO `ubigeo_inei` VALUES (408, '04', '03', '00', 'CARAVELI');
INSERT INTO `ubigeo_inei` VALUES (409, '04', '03', '01', 'CARAVELI');
INSERT INTO `ubigeo_inei` VALUES (410, '04', '03', '02', 'ACARI');
INSERT INTO `ubigeo_inei` VALUES (411, '04', '03', '03', 'ATICO');
INSERT INTO `ubigeo_inei` VALUES (412, '04', '03', '04', 'ATIQUIPA');
INSERT INTO `ubigeo_inei` VALUES (413, '04', '03', '05', 'BELLA UNION');
INSERT INTO `ubigeo_inei` VALUES (414, '04', '03', '06', 'CAHUACHO');
INSERT INTO `ubigeo_inei` VALUES (415, '04', '03', '07', 'CHALA');
INSERT INTO `ubigeo_inei` VALUES (416, '04', '03', '08', 'CHAPARRA');
INSERT INTO `ubigeo_inei` VALUES (417, '04', '03', '09', 'HUANUHUANU');
INSERT INTO `ubigeo_inei` VALUES (418, '04', '03', '10', 'JAQUI');
INSERT INTO `ubigeo_inei` VALUES (419, '04', '03', '11', 'LOMAS');
INSERT INTO `ubigeo_inei` VALUES (420, '04', '03', '12', 'QUICACHA');
INSERT INTO `ubigeo_inei` VALUES (421, '04', '03', '13', 'YAUCA');
INSERT INTO `ubigeo_inei` VALUES (422, '04', '04', '00', 'CASTILLA');
INSERT INTO `ubigeo_inei` VALUES (423, '04', '04', '01', 'APLAO');
INSERT INTO `ubigeo_inei` VALUES (424, '04', '04', '02', 'ANDAGUA');
INSERT INTO `ubigeo_inei` VALUES (425, '04', '04', '03', 'AYO');
INSERT INTO `ubigeo_inei` VALUES (426, '04', '04', '04', 'CHACHAS');
INSERT INTO `ubigeo_inei` VALUES (427, '04', '04', '05', 'CHILCAYMARCA');
INSERT INTO `ubigeo_inei` VALUES (428, '04', '04', '06', 'CHOCO');
INSERT INTO `ubigeo_inei` VALUES (429, '04', '04', '07', 'HUANCARQUI');
INSERT INTO `ubigeo_inei` VALUES (430, '04', '04', '08', 'MACHAGUAY');
INSERT INTO `ubigeo_inei` VALUES (431, '04', '04', '09', 'ORCOPAMPA');
INSERT INTO `ubigeo_inei` VALUES (432, '04', '04', '10', 'PAMPACOLCA');
INSERT INTO `ubigeo_inei` VALUES (433, '04', '04', '11', 'TIPAN');
INSERT INTO `ubigeo_inei` VALUES (434, '04', '04', '12', 'UÑON');
INSERT INTO `ubigeo_inei` VALUES (435, '04', '04', '13', 'URACA');
INSERT INTO `ubigeo_inei` VALUES (436, '04', '04', '14', 'VIRACO');
INSERT INTO `ubigeo_inei` VALUES (437, '04', '05', '00', 'CAYLLOMA');
INSERT INTO `ubigeo_inei` VALUES (438, '04', '05', '01', 'CHIVAY');
INSERT INTO `ubigeo_inei` VALUES (439, '04', '05', '02', 'ACHOMA');
INSERT INTO `ubigeo_inei` VALUES (440, '04', '05', '03', 'CABANACONDE');
INSERT INTO `ubigeo_inei` VALUES (441, '04', '05', '04', 'CALLALLI');
INSERT INTO `ubigeo_inei` VALUES (442, '04', '05', '05', 'CAYLLOMA');
INSERT INTO `ubigeo_inei` VALUES (443, '04', '05', '06', 'COPORAQUE');
INSERT INTO `ubigeo_inei` VALUES (444, '04', '05', '07', 'HUAMBO');
INSERT INTO `ubigeo_inei` VALUES (445, '04', '05', '08', 'HUANCA');
INSERT INTO `ubigeo_inei` VALUES (446, '04', '05', '09', 'ICHUPAMPA');
INSERT INTO `ubigeo_inei` VALUES (447, '04', '05', '10', 'LARI');
INSERT INTO `ubigeo_inei` VALUES (448, '04', '05', '11', 'LLUTA');
INSERT INTO `ubigeo_inei` VALUES (449, '04', '05', '12', 'MACA');
INSERT INTO `ubigeo_inei` VALUES (450, '04', '05', '13', 'MADRIGAL');
INSERT INTO `ubigeo_inei` VALUES (451, '04', '05', '14', 'SAN ANTONIO DE CHUCA');
INSERT INTO `ubigeo_inei` VALUES (452, '04', '05', '15', 'SIBAYO');
INSERT INTO `ubigeo_inei` VALUES (453, '04', '05', '16', 'TAPAY');
INSERT INTO `ubigeo_inei` VALUES (454, '04', '05', '17', 'TISCO');
INSERT INTO `ubigeo_inei` VALUES (455, '04', '05', '18', 'TUTI');
INSERT INTO `ubigeo_inei` VALUES (456, '04', '05', '19', 'YANQUE');
INSERT INTO `ubigeo_inei` VALUES (457, '04', '05', '20', 'MAJES');
INSERT INTO `ubigeo_inei` VALUES (458, '04', '06', '00', 'CONDESUYOS');
INSERT INTO `ubigeo_inei` VALUES (459, '04', '06', '01', 'CHUQUIBAMBA');
INSERT INTO `ubigeo_inei` VALUES (460, '04', '06', '02', 'ANDARAY');
INSERT INTO `ubigeo_inei` VALUES (461, '04', '06', '03', 'CAYARANI');
INSERT INTO `ubigeo_inei` VALUES (462, '04', '06', '04', 'CHICHAS');
INSERT INTO `ubigeo_inei` VALUES (463, '04', '06', '05', 'IRAY');
INSERT INTO `ubigeo_inei` VALUES (464, '04', '06', '06', 'RIO GRANDE');
INSERT INTO `ubigeo_inei` VALUES (465, '04', '06', '07', 'SALAMANCA');
INSERT INTO `ubigeo_inei` VALUES (466, '04', '06', '08', 'YANAQUIHUA');
INSERT INTO `ubigeo_inei` VALUES (467, '04', '07', '00', 'ISLAY');
INSERT INTO `ubigeo_inei` VALUES (468, '04', '07', '01', 'MOLLENDO');
INSERT INTO `ubigeo_inei` VALUES (469, '04', '07', '02', 'COCACHACRA');
INSERT INTO `ubigeo_inei` VALUES (470, '04', '07', '03', 'DEAN VALDIVIA');
INSERT INTO `ubigeo_inei` VALUES (471, '04', '07', '04', 'ISLAY');
INSERT INTO `ubigeo_inei` VALUES (472, '04', '07', '05', 'MEJIA');
INSERT INTO `ubigeo_inei` VALUES (473, '04', '07', '06', 'PUNTA DE BOMBON');
INSERT INTO `ubigeo_inei` VALUES (474, '04', '08', '00', 'LA UNION');
INSERT INTO `ubigeo_inei` VALUES (475, '04', '08', '01', 'COTAHUASI');
INSERT INTO `ubigeo_inei` VALUES (476, '04', '08', '02', 'ALCA');
INSERT INTO `ubigeo_inei` VALUES (477, '04', '08', '03', 'CHARCANA');
INSERT INTO `ubigeo_inei` VALUES (478, '04', '08', '04', 'HUAYNACOTAS');
INSERT INTO `ubigeo_inei` VALUES (479, '04', '08', '05', 'PAMPAMARCA');
INSERT INTO `ubigeo_inei` VALUES (480, '04', '08', '06', 'PUYCA');
INSERT INTO `ubigeo_inei` VALUES (481, '04', '08', '07', 'QUECHUALLA');
INSERT INTO `ubigeo_inei` VALUES (482, '04', '08', '08', 'SAYLA');
INSERT INTO `ubigeo_inei` VALUES (483, '04', '08', '09', 'TAURIA');
INSERT INTO `ubigeo_inei` VALUES (484, '04', '08', '10', 'TOMEPAMPA');
INSERT INTO `ubigeo_inei` VALUES (485, '04', '08', '11', 'TORO');
INSERT INTO `ubigeo_inei` VALUES (486, '05', '00', '00', 'AYACUCHO');
INSERT INTO `ubigeo_inei` VALUES (487, '05', '01', '00', 'HUAMANGA');
INSERT INTO `ubigeo_inei` VALUES (488, '05', '01', '01', 'AYACUCHO');
INSERT INTO `ubigeo_inei` VALUES (489, '05', '01', '02', 'ACOCRO');
INSERT INTO `ubigeo_inei` VALUES (490, '05', '01', '03', 'ACOS VINCHOS');
INSERT INTO `ubigeo_inei` VALUES (491, '05', '01', '04', 'CARMEN ALTO');
INSERT INTO `ubigeo_inei` VALUES (492, '05', '01', '05', 'CHIARA');
INSERT INTO `ubigeo_inei` VALUES (493, '05', '01', '06', 'OCROS');
INSERT INTO `ubigeo_inei` VALUES (494, '05', '01', '07', 'PACAYCASA');
INSERT INTO `ubigeo_inei` VALUES (495, '05', '01', '08', 'QUINUA');
INSERT INTO `ubigeo_inei` VALUES (496, '05', '01', '09', 'SAN JOSE DE TICLLAS');
INSERT INTO `ubigeo_inei` VALUES (497, '05', '01', '10', 'SAN JUAN BAUTISTA');
INSERT INTO `ubigeo_inei` VALUES (498, '05', '01', '11', 'SANTIAGO DE PISCHA');
INSERT INTO `ubigeo_inei` VALUES (499, '05', '01', '12', 'SOCOS');
INSERT INTO `ubigeo_inei` VALUES (500, '05', '01', '13', 'TAMBILLO');
INSERT INTO `ubigeo_inei` VALUES (501, '05', '01', '14', 'VINCHOS');
INSERT INTO `ubigeo_inei` VALUES (502, '05', '01', '15', 'JESÚS NAZARENO');
INSERT INTO `ubigeo_inei` VALUES (503, '05', '01', '16', 'ANDRÉS AVELINO CÁCERES DORREGAY');
INSERT INTO `ubigeo_inei` VALUES (504, '05', '02', '00', 'CANGALLO');
INSERT INTO `ubigeo_inei` VALUES (505, '05', '02', '01', 'CANGALLO');
INSERT INTO `ubigeo_inei` VALUES (506, '05', '02', '02', 'CHUSCHI');
INSERT INTO `ubigeo_inei` VALUES (507, '05', '02', '03', 'LOS MOROCHUCOS');
INSERT INTO `ubigeo_inei` VALUES (508, '05', '02', '04', 'MARIA PARADO DE BELLIDO');
INSERT INTO `ubigeo_inei` VALUES (509, '05', '02', '05', 'PARAS');
INSERT INTO `ubigeo_inei` VALUES (510, '05', '02', '06', 'TOTOS');
INSERT INTO `ubigeo_inei` VALUES (511, '05', '03', '00', 'HUANCA SANCOS');
INSERT INTO `ubigeo_inei` VALUES (512, '05', '03', '01', 'SANCOS');
INSERT INTO `ubigeo_inei` VALUES (513, '05', '03', '02', 'CARAPO');
INSERT INTO `ubigeo_inei` VALUES (514, '05', '03', '03', 'SACSAMARCA');
INSERT INTO `ubigeo_inei` VALUES (515, '05', '03', '04', 'SANTIAGO DE LUCANAMARCA');
INSERT INTO `ubigeo_inei` VALUES (516, '05', '04', '00', 'HUANTA');
INSERT INTO `ubigeo_inei` VALUES (517, '05', '04', '01', 'HUANTA');
INSERT INTO `ubigeo_inei` VALUES (518, '05', '04', '02', 'AYAHUANCO');
INSERT INTO `ubigeo_inei` VALUES (519, '05', '04', '03', 'HUAMANGUILLA');
INSERT INTO `ubigeo_inei` VALUES (520, '05', '04', '04', 'IGUAIN');
INSERT INTO `ubigeo_inei` VALUES (521, '05', '04', '05', 'LURICOCHA');
INSERT INTO `ubigeo_inei` VALUES (522, '05', '04', '06', 'SANTILLANA');
INSERT INTO `ubigeo_inei` VALUES (523, '05', '04', '07', 'SIVIA');
INSERT INTO `ubigeo_inei` VALUES (524, '05', '04', '08', 'LLOCHEGUA');
INSERT INTO `ubigeo_inei` VALUES (525, '05', '04', '09', 'CANAYRE');
INSERT INTO `ubigeo_inei` VALUES (526, '05', '04', '10', 'UCHURACCAY');
INSERT INTO `ubigeo_inei` VALUES (527, '05', '04', '11', 'PUCACOLPA');
INSERT INTO `ubigeo_inei` VALUES (528, '05', '05', '00', 'LA MAR');
INSERT INTO `ubigeo_inei` VALUES (529, '05', '05', '01', 'SAN MIGUEL');
INSERT INTO `ubigeo_inei` VALUES (530, '05', '05', '02', 'ANCO');
INSERT INTO `ubigeo_inei` VALUES (531, '05', '05', '03', 'AYNA');
INSERT INTO `ubigeo_inei` VALUES (532, '05', '05', '04', 'CHILCAS');
INSERT INTO `ubigeo_inei` VALUES (533, '05', '05', '05', 'CHUNGUI');
INSERT INTO `ubigeo_inei` VALUES (534, '05', '05', '06', 'LUIS CARRANZA');
INSERT INTO `ubigeo_inei` VALUES (535, '05', '05', '07', 'SANTA ROSA');
INSERT INTO `ubigeo_inei` VALUES (536, '05', '05', '08', 'TAMBO');
INSERT INTO `ubigeo_inei` VALUES (537, '05', '05', '09', 'SAMUGARI');
INSERT INTO `ubigeo_inei` VALUES (538, '05', '05', '10', 'ANCHIHUAY');
INSERT INTO `ubigeo_inei` VALUES (539, '05', '06', '00', 'LUCANAS');
INSERT INTO `ubigeo_inei` VALUES (540, '05', '06', '01', 'PUQUIO');
INSERT INTO `ubigeo_inei` VALUES (541, '05', '06', '02', 'AUCARA');
INSERT INTO `ubigeo_inei` VALUES (542, '05', '06', '03', 'CABANA');
INSERT INTO `ubigeo_inei` VALUES (543, '05', '06', '04', 'CARMEN SALCEDO');
INSERT INTO `ubigeo_inei` VALUES (544, '05', '06', '05', 'CHAVIÑA');
INSERT INTO `ubigeo_inei` VALUES (545, '05', '06', '06', 'CHIPAO');
INSERT INTO `ubigeo_inei` VALUES (546, '05', '06', '07', 'HUAC-HUAS');
INSERT INTO `ubigeo_inei` VALUES (547, '05', '06', '08', 'LARAMATE');
INSERT INTO `ubigeo_inei` VALUES (548, '05', '06', '09', 'LEONCIO PRADO');
INSERT INTO `ubigeo_inei` VALUES (549, '05', '06', '10', 'LLAUTA');
INSERT INTO `ubigeo_inei` VALUES (550, '05', '06', '11', 'LUCANAS');
INSERT INTO `ubigeo_inei` VALUES (551, '05', '06', '12', 'OCAÑA');
INSERT INTO `ubigeo_inei` VALUES (552, '05', '06', '13', 'OTOCA');
INSERT INTO `ubigeo_inei` VALUES (553, '05', '06', '14', 'SAISA');
INSERT INTO `ubigeo_inei` VALUES (554, '05', '06', '15', 'SAN CRISTOBAL');
INSERT INTO `ubigeo_inei` VALUES (555, '05', '06', '16', 'SAN JUAN');
INSERT INTO `ubigeo_inei` VALUES (556, '05', '06', '17', 'SAN PEDRO');
INSERT INTO `ubigeo_inei` VALUES (557, '05', '06', '18', 'SAN PEDRO DE PALCO');
INSERT INTO `ubigeo_inei` VALUES (558, '05', '06', '19', 'SANCOS');
INSERT INTO `ubigeo_inei` VALUES (559, '05', '06', '20', 'SANTA ANA DE HUAYCAHUACHO');
INSERT INTO `ubigeo_inei` VALUES (560, '05', '06', '21', 'SANTA LUCIA');
INSERT INTO `ubigeo_inei` VALUES (561, '05', '07', '00', 'PARINACOCHAS');
INSERT INTO `ubigeo_inei` VALUES (562, '05', '07', '01', 'CORACORA');
INSERT INTO `ubigeo_inei` VALUES (563, '05', '07', '02', 'CHUMPI');
INSERT INTO `ubigeo_inei` VALUES (564, '05', '07', '03', 'CORONEL CASTAÑEDA');
INSERT INTO `ubigeo_inei` VALUES (565, '05', '07', '04', 'PACAPAUSA');
INSERT INTO `ubigeo_inei` VALUES (566, '05', '07', '05', 'PULLO');
INSERT INTO `ubigeo_inei` VALUES (567, '05', '07', '06', 'PUYUSCA');
INSERT INTO `ubigeo_inei` VALUES (568, '05', '07', '07', 'SAN FRANCISCO DE RAVACAYCO');
INSERT INTO `ubigeo_inei` VALUES (569, '05', '07', '08', 'UPAHUACHO');
INSERT INTO `ubigeo_inei` VALUES (570, '05', '08', '00', 'PAUCAR DEL SARA SARA');
INSERT INTO `ubigeo_inei` VALUES (571, '05', '08', '01', 'PAUSA');
INSERT INTO `ubigeo_inei` VALUES (572, '05', '08', '02', 'COLTA');
INSERT INTO `ubigeo_inei` VALUES (573, '05', '08', '03', 'CORCULLA');
INSERT INTO `ubigeo_inei` VALUES (574, '05', '08', '04', 'LAMPA');
INSERT INTO `ubigeo_inei` VALUES (575, '05', '08', '05', 'MARCABAMBA');
INSERT INTO `ubigeo_inei` VALUES (576, '05', '08', '06', 'OYOLO');
INSERT INTO `ubigeo_inei` VALUES (577, '05', '08', '07', 'PARARCA');
INSERT INTO `ubigeo_inei` VALUES (578, '05', '08', '08', 'SAN JAVIER DE ALPABAMBA');
INSERT INTO `ubigeo_inei` VALUES (579, '05', '08', '09', 'SAN JOSE DE USHUA');
INSERT INTO `ubigeo_inei` VALUES (580, '05', '08', '10', 'SARA SARA');
INSERT INTO `ubigeo_inei` VALUES (581, '05', '09', '00', 'SUCRE');
INSERT INTO `ubigeo_inei` VALUES (582, '05', '09', '01', 'QUEROBAMBA');
INSERT INTO `ubigeo_inei` VALUES (583, '05', '09', '02', 'BELEN');
INSERT INTO `ubigeo_inei` VALUES (584, '05', '09', '03', 'CHALCOS');
INSERT INTO `ubigeo_inei` VALUES (585, '05', '09', '04', 'CHILCAYOC');
INSERT INTO `ubigeo_inei` VALUES (586, '05', '09', '05', 'HUACAÑA');
INSERT INTO `ubigeo_inei` VALUES (587, '05', '09', '06', 'MORCOLLA');
INSERT INTO `ubigeo_inei` VALUES (588, '05', '09', '07', 'PAICO');
INSERT INTO `ubigeo_inei` VALUES (589, '05', '09', '08', 'SAN PEDRO DE LARCAY');
INSERT INTO `ubigeo_inei` VALUES (590, '05', '09', '09', 'SAN SALVADOR DE QUIJE');
INSERT INTO `ubigeo_inei` VALUES (591, '05', '09', '10', 'SANTIAGO DE PAUCARAY');
INSERT INTO `ubigeo_inei` VALUES (592, '05', '09', '11', 'SORAS');
INSERT INTO `ubigeo_inei` VALUES (593, '05', '10', '00', 'VICTOR FAJARDO');
INSERT INTO `ubigeo_inei` VALUES (594, '05', '10', '01', 'HUANCAPI');
INSERT INTO `ubigeo_inei` VALUES (595, '05', '10', '02', 'ALCAMENCA');
INSERT INTO `ubigeo_inei` VALUES (596, '05', '10', '03', 'APONGO');
INSERT INTO `ubigeo_inei` VALUES (597, '05', '10', '04', 'ASQUIPATA');
INSERT INTO `ubigeo_inei` VALUES (598, '05', '10', '05', 'CANARIA');
INSERT INTO `ubigeo_inei` VALUES (599, '05', '10', '06', 'CAYARA');
INSERT INTO `ubigeo_inei` VALUES (600, '05', '10', '07', 'COLCA');
INSERT INTO `ubigeo_inei` VALUES (601, '05', '10', '08', 'HUAMANQUIQUIA');
INSERT INTO `ubigeo_inei` VALUES (602, '05', '10', '09', 'HUANCARAYLLA');
INSERT INTO `ubigeo_inei` VALUES (603, '05', '10', '10', 'HUAYA');
INSERT INTO `ubigeo_inei` VALUES (604, '05', '10', '11', 'SARHUA');
INSERT INTO `ubigeo_inei` VALUES (605, '05', '10', '12', 'VILCANCHOS');
INSERT INTO `ubigeo_inei` VALUES (606, '05', '11', '00', 'VILCAS HUAMAN');
INSERT INTO `ubigeo_inei` VALUES (607, '05', '11', '01', 'VILCAS HUAMAN');
INSERT INTO `ubigeo_inei` VALUES (608, '05', '11', '02', 'ACCOMARCA');
INSERT INTO `ubigeo_inei` VALUES (609, '05', '11', '03', 'CARHUANCA');
INSERT INTO `ubigeo_inei` VALUES (610, '05', '11', '04', 'CONCEPCION');
INSERT INTO `ubigeo_inei` VALUES (611, '05', '11', '05', 'HUAMBALPA');
INSERT INTO `ubigeo_inei` VALUES (612, '05', '11', '06', 'INDEPENDENCIA');
INSERT INTO `ubigeo_inei` VALUES (613, '05', '11', '07', 'SAURAMA');
INSERT INTO `ubigeo_inei` VALUES (614, '05', '11', '08', 'VISCHONGO');
INSERT INTO `ubigeo_inei` VALUES (615, '06', '00', '00', 'CAJAMARCA');
INSERT INTO `ubigeo_inei` VALUES (616, '06', '01', '00', 'CAJAMARCA');
INSERT INTO `ubigeo_inei` VALUES (617, '06', '01', '01', 'CAJAMARCA');
INSERT INTO `ubigeo_inei` VALUES (618, '06', '01', '02', 'ASUNCION');
INSERT INTO `ubigeo_inei` VALUES (619, '06', '01', '03', 'CHETILLA');
INSERT INTO `ubigeo_inei` VALUES (620, '06', '01', '04', 'COSPAN');
INSERT INTO `ubigeo_inei` VALUES (621, '06', '01', '05', 'ENCAÑADA');
INSERT INTO `ubigeo_inei` VALUES (622, '06', '01', '06', 'JESUS');
INSERT INTO `ubigeo_inei` VALUES (623, '06', '01', '07', 'LLACANORA');
INSERT INTO `ubigeo_inei` VALUES (624, '06', '01', '08', 'LOS BAÑOS DEL INCA');
INSERT INTO `ubigeo_inei` VALUES (625, '06', '01', '09', 'MAGDALENA');
INSERT INTO `ubigeo_inei` VALUES (626, '06', '01', '10', 'MATARA');
INSERT INTO `ubigeo_inei` VALUES (627, '06', '01', '11', 'NAMORA');
INSERT INTO `ubigeo_inei` VALUES (628, '06', '01', '12', 'SAN JUAN');
INSERT INTO `ubigeo_inei` VALUES (629, '06', '02', '00', 'CAJABAMBA');
INSERT INTO `ubigeo_inei` VALUES (630, '06', '02', '01', 'CAJABAMBA');
INSERT INTO `ubigeo_inei` VALUES (631, '06', '02', '02', 'CACHACHI');
INSERT INTO `ubigeo_inei` VALUES (632, '06', '02', '03', 'CONDEBAMBA');
INSERT INTO `ubigeo_inei` VALUES (633, '06', '02', '04', 'SITACOCHA');
INSERT INTO `ubigeo_inei` VALUES (634, '06', '03', '00', 'CELENDIN');
INSERT INTO `ubigeo_inei` VALUES (635, '06', '03', '01', 'CELENDIN');
INSERT INTO `ubigeo_inei` VALUES (636, '06', '03', '02', 'CHUMUCH');
INSERT INTO `ubigeo_inei` VALUES (637, '06', '03', '03', 'CORTEGANA');
INSERT INTO `ubigeo_inei` VALUES (638, '06', '03', '04', 'HUASMIN');
INSERT INTO `ubigeo_inei` VALUES (639, '06', '03', '05', 'JORGE CHAVEZ');
INSERT INTO `ubigeo_inei` VALUES (640, '06', '03', '06', 'JOSE GALVEZ');
INSERT INTO `ubigeo_inei` VALUES (641, '06', '03', '07', 'MIGUEL IGLESIAS');
INSERT INTO `ubigeo_inei` VALUES (642, '06', '03', '08', 'OXAMARCA');
INSERT INTO `ubigeo_inei` VALUES (643, '06', '03', '09', 'SOROCHUCO');
INSERT INTO `ubigeo_inei` VALUES (644, '06', '03', '10', 'SUCRE');
INSERT INTO `ubigeo_inei` VALUES (645, '06', '03', '11', 'UTCO');
INSERT INTO `ubigeo_inei` VALUES (646, '06', '03', '12', 'LA LIBERTAD DE PALLAN');
INSERT INTO `ubigeo_inei` VALUES (647, '06', '04', '00', 'CHOTA');
INSERT INTO `ubigeo_inei` VALUES (648, '06', '04', '01', 'CHOTA');
INSERT INTO `ubigeo_inei` VALUES (649, '06', '04', '02', 'ANGUIA');
INSERT INTO `ubigeo_inei` VALUES (650, '06', '04', '03', 'CHADIN');
INSERT INTO `ubigeo_inei` VALUES (651, '06', '04', '04', 'CHIGUIRIP');
INSERT INTO `ubigeo_inei` VALUES (652, '06', '04', '05', 'CHIMBAN');
INSERT INTO `ubigeo_inei` VALUES (653, '06', '04', '06', 'CHOROPAMPA');
INSERT INTO `ubigeo_inei` VALUES (654, '06', '04', '07', 'COCHABAMBA');
INSERT INTO `ubigeo_inei` VALUES (655, '06', '04', '08', 'CONCHAN');
INSERT INTO `ubigeo_inei` VALUES (656, '06', '04', '09', 'HUAMBOS');
INSERT INTO `ubigeo_inei` VALUES (657, '06', '04', '10', 'LAJAS');
INSERT INTO `ubigeo_inei` VALUES (658, '06', '04', '11', 'LLAMA');
INSERT INTO `ubigeo_inei` VALUES (659, '06', '04', '12', 'MIRACOSTA');
INSERT INTO `ubigeo_inei` VALUES (660, '06', '04', '13', 'PACCHA');
INSERT INTO `ubigeo_inei` VALUES (661, '06', '04', '14', 'PION');
INSERT INTO `ubigeo_inei` VALUES (662, '06', '04', '15', 'QUEROCOTO');
INSERT INTO `ubigeo_inei` VALUES (663, '06', '04', '16', 'SAN JUAN DE LICUPIS');
INSERT INTO `ubigeo_inei` VALUES (664, '06', '04', '17', 'TACABAMBA');
INSERT INTO `ubigeo_inei` VALUES (665, '06', '04', '18', 'TOCMOCHE');
INSERT INTO `ubigeo_inei` VALUES (666, '06', '04', '19', 'CHALAMARCA');
INSERT INTO `ubigeo_inei` VALUES (667, '06', '05', '00', 'CONTUMAZA');
INSERT INTO `ubigeo_inei` VALUES (668, '06', '05', '01', 'CONTUMAZA');
INSERT INTO `ubigeo_inei` VALUES (669, '06', '05', '02', 'CHILETE');
INSERT INTO `ubigeo_inei` VALUES (670, '06', '05', '03', 'CUPISNIQUE');
INSERT INTO `ubigeo_inei` VALUES (671, '06', '05', '04', 'GUZMANGO');
INSERT INTO `ubigeo_inei` VALUES (672, '06', '05', '05', 'SAN BENITO');
INSERT INTO `ubigeo_inei` VALUES (673, '06', '05', '06', 'SANTA CRUZ DE TOLED');
INSERT INTO `ubigeo_inei` VALUES (674, '06', '05', '07', 'TANTARICA');
INSERT INTO `ubigeo_inei` VALUES (675, '06', '05', '08', 'YONAN');
INSERT INTO `ubigeo_inei` VALUES (676, '06', '06', '00', 'CUTERVO');
INSERT INTO `ubigeo_inei` VALUES (677, '06', '06', '01', 'CUTERVO');
INSERT INTO `ubigeo_inei` VALUES (678, '06', '06', '02', 'CALLAYUC');
INSERT INTO `ubigeo_inei` VALUES (679, '06', '06', '03', 'CHOROS');
INSERT INTO `ubigeo_inei` VALUES (680, '06', '06', '04', 'CUJILLO');
INSERT INTO `ubigeo_inei` VALUES (681, '06', '06', '05', 'LA RAMADA');
INSERT INTO `ubigeo_inei` VALUES (682, '06', '06', '06', 'PIMPINGOS');
INSERT INTO `ubigeo_inei` VALUES (683, '06', '06', '07', 'QUEROCOTILLO');
INSERT INTO `ubigeo_inei` VALUES (684, '06', '06', '08', 'SAN ANDRES DE CUTERVO');
INSERT INTO `ubigeo_inei` VALUES (685, '06', '06', '09', 'SAN JUAN DE CUTERVO');
INSERT INTO `ubigeo_inei` VALUES (686, '06', '06', '10', 'SAN LUIS DE LUCMA');
INSERT INTO `ubigeo_inei` VALUES (687, '06', '06', '11', 'SANTA CRUZ');
INSERT INTO `ubigeo_inei` VALUES (688, '06', '06', '12', 'SANTO DOMINGO DE LA CAPILLA');
INSERT INTO `ubigeo_inei` VALUES (689, '06', '06', '13', 'SANTO TOMAS');
INSERT INTO `ubigeo_inei` VALUES (690, '06', '06', '14', 'SOCOTA');
INSERT INTO `ubigeo_inei` VALUES (691, '06', '06', '15', 'TORIBIO CASANOVA');
INSERT INTO `ubigeo_inei` VALUES (692, '06', '07', '00', 'HUALGAYOC');
INSERT INTO `ubigeo_inei` VALUES (693, '06', '07', '01', 'BAMBAMARCA');
INSERT INTO `ubigeo_inei` VALUES (694, '06', '07', '02', 'CHUGUR');
INSERT INTO `ubigeo_inei` VALUES (695, '06', '07', '03', 'HUALGAYOC');
INSERT INTO `ubigeo_inei` VALUES (696, '06', '08', '00', 'JAEN');
INSERT INTO `ubigeo_inei` VALUES (697, '06', '08', '01', 'JAEN');
INSERT INTO `ubigeo_inei` VALUES (698, '06', '08', '02', 'BELLAVISTA');
INSERT INTO `ubigeo_inei` VALUES (699, '06', '08', '03', 'CHONTALI');
INSERT INTO `ubigeo_inei` VALUES (700, '06', '08', '04', 'COLASAY');
INSERT INTO `ubigeo_inei` VALUES (701, '06', '08', '05', 'HUABAL');
INSERT INTO `ubigeo_inei` VALUES (702, '06', '08', '06', 'LAS PIRIAS');
INSERT INTO `ubigeo_inei` VALUES (703, '06', '08', '07', 'POMAHUACA');
INSERT INTO `ubigeo_inei` VALUES (704, '06', '08', '08', 'PUCARA');
INSERT INTO `ubigeo_inei` VALUES (705, '06', '08', '09', 'SALLIQUE');
INSERT INTO `ubigeo_inei` VALUES (706, '06', '08', '10', 'SAN FELIPE');
INSERT INTO `ubigeo_inei` VALUES (707, '06', '08', '11', 'SAN JOSE DEL ALTO');
INSERT INTO `ubigeo_inei` VALUES (708, '06', '08', '12', 'SANTA ROSA');
INSERT INTO `ubigeo_inei` VALUES (709, '06', '09', '00', 'SAN IGNACIO');
INSERT INTO `ubigeo_inei` VALUES (710, '06', '09', '01', 'SAN IGNACIO');
INSERT INTO `ubigeo_inei` VALUES (711, '06', '09', '02', 'CHIRINOS');
INSERT INTO `ubigeo_inei` VALUES (712, '06', '09', '03', 'HUARANGO');
INSERT INTO `ubigeo_inei` VALUES (713, '06', '09', '04', 'LA COIPA');
INSERT INTO `ubigeo_inei` VALUES (714, '06', '09', '05', 'NAMBALLE');
INSERT INTO `ubigeo_inei` VALUES (715, '06', '09', '06', 'SAN JOSE DE LOURDES');
INSERT INTO `ubigeo_inei` VALUES (716, '06', '09', '07', 'TABACONAS');
INSERT INTO `ubigeo_inei` VALUES (717, '06', '10', '00', 'SAN MARCOS');
INSERT INTO `ubigeo_inei` VALUES (718, '06', '10', '01', 'PEDRO GALVEZ');
INSERT INTO `ubigeo_inei` VALUES (719, '06', '10', '02', 'CHANCAY');
INSERT INTO `ubigeo_inei` VALUES (720, '06', '10', '03', 'EDUARDO VILLANUEVA');
INSERT INTO `ubigeo_inei` VALUES (721, '06', '10', '04', 'GREGORIO PITA');
INSERT INTO `ubigeo_inei` VALUES (722, '06', '10', '05', 'ICHOCAN');
INSERT INTO `ubigeo_inei` VALUES (723, '06', '10', '06', 'JOSE MANUEL QUIROZ');
INSERT INTO `ubigeo_inei` VALUES (724, '06', '10', '07', 'JOSE SABOGAL');
INSERT INTO `ubigeo_inei` VALUES (725, '06', '11', '00', 'SAN MIGUEL');
INSERT INTO `ubigeo_inei` VALUES (726, '06', '11', '01', 'SAN MIGUEL');
INSERT INTO `ubigeo_inei` VALUES (727, '06', '11', '02', 'BOLIVAR');
INSERT INTO `ubigeo_inei` VALUES (728, '06', '11', '03', 'CALQUIS');
INSERT INTO `ubigeo_inei` VALUES (729, '06', '11', '04', 'CATILLUC');
INSERT INTO `ubigeo_inei` VALUES (730, '06', '11', '05', 'EL PRADO');
INSERT INTO `ubigeo_inei` VALUES (731, '06', '11', '06', 'LA FLORIDA');
INSERT INTO `ubigeo_inei` VALUES (732, '06', '11', '07', 'LLAPA');
INSERT INTO `ubigeo_inei` VALUES (733, '06', '11', '08', 'NANCHOC');
INSERT INTO `ubigeo_inei` VALUES (734, '06', '11', '09', 'NIEPOS');
INSERT INTO `ubigeo_inei` VALUES (735, '06', '11', '10', 'SAN GREGORIO');
INSERT INTO `ubigeo_inei` VALUES (736, '06', '11', '11', 'SAN SILVESTRE DE COCHAN');
INSERT INTO `ubigeo_inei` VALUES (737, '06', '11', '12', 'TONGOD');
INSERT INTO `ubigeo_inei` VALUES (738, '06', '11', '13', 'UNION AGUA BLANCA');
INSERT INTO `ubigeo_inei` VALUES (739, '06', '12', '00', 'SAN PABLO');
INSERT INTO `ubigeo_inei` VALUES (740, '06', '12', '01', 'SAN PABLO');
INSERT INTO `ubigeo_inei` VALUES (741, '06', '12', '02', 'SAN BERNARDINO');
INSERT INTO `ubigeo_inei` VALUES (742, '06', '12', '03', 'SAN LUIS');
INSERT INTO `ubigeo_inei` VALUES (743, '06', '12', '04', 'TUMBADEN');
INSERT INTO `ubigeo_inei` VALUES (744, '06', '13', '00', 'SANTA CRUZ');
INSERT INTO `ubigeo_inei` VALUES (745, '06', '13', '01', 'SANTA CRUZ');
INSERT INTO `ubigeo_inei` VALUES (746, '06', '13', '02', 'ANDABAMBA');
INSERT INTO `ubigeo_inei` VALUES (747, '06', '13', '03', 'CATACHE');
INSERT INTO `ubigeo_inei` VALUES (748, '06', '13', '04', 'CHANCAYBAÑOS');
INSERT INTO `ubigeo_inei` VALUES (749, '06', '13', '05', 'LA ESPERANZA');
INSERT INTO `ubigeo_inei` VALUES (750, '06', '13', '06', 'NINABAMBA');
INSERT INTO `ubigeo_inei` VALUES (751, '06', '13', '07', 'PULAN');
INSERT INTO `ubigeo_inei` VALUES (752, '06', '13', '08', 'SAUCEPAMPA');
INSERT INTO `ubigeo_inei` VALUES (753, '06', '13', '09', 'SEXI');
INSERT INTO `ubigeo_inei` VALUES (754, '06', '13', '10', 'UTICYACU');
INSERT INTO `ubigeo_inei` VALUES (755, '06', '13', '11', 'YAUYUCAN');
INSERT INTO `ubigeo_inei` VALUES (756, '07', '00', '00', 'CALLAO');
INSERT INTO `ubigeo_inei` VALUES (757, '07', '01', '00', 'PROV. CONST. DEL CALLAO');
INSERT INTO `ubigeo_inei` VALUES (758, '07', '01', '01', 'CALLAO');
INSERT INTO `ubigeo_inei` VALUES (759, '07', '01', '02', 'BELLAVISTA');
INSERT INTO `ubigeo_inei` VALUES (760, '07', '01', '03', 'CARMEN DE LA LEGUA REYNOSO');
INSERT INTO `ubigeo_inei` VALUES (761, '07', '01', '04', 'LA PERLA');
INSERT INTO `ubigeo_inei` VALUES (762, '07', '01', '05', 'LA PUNTA');
INSERT INTO `ubigeo_inei` VALUES (763, '07', '01', '06', 'VENTANILLA');
INSERT INTO `ubigeo_inei` VALUES (764, '07', '01', '07', 'MI PERÚ');
INSERT INTO `ubigeo_inei` VALUES (765, '08', '00', '00', 'CUSCO');
INSERT INTO `ubigeo_inei` VALUES (766, '08', '01', '00', 'CUSCO');
INSERT INTO `ubigeo_inei` VALUES (767, '08', '01', '01', 'CUSCO');
INSERT INTO `ubigeo_inei` VALUES (768, '08', '01', '02', 'CCORCA');
INSERT INTO `ubigeo_inei` VALUES (769, '08', '01', '03', 'POROY');
INSERT INTO `ubigeo_inei` VALUES (770, '08', '01', '04', 'SAN JERONIMO');
INSERT INTO `ubigeo_inei` VALUES (771, '08', '01', '05', 'SAN SEBASTIAN');
INSERT INTO `ubigeo_inei` VALUES (772, '08', '01', '06', 'SANTIAGO');
INSERT INTO `ubigeo_inei` VALUES (773, '08', '01', '07', 'SAYLLA');
INSERT INTO `ubigeo_inei` VALUES (774, '08', '01', '08', 'WANCHAQ');
INSERT INTO `ubigeo_inei` VALUES (775, '08', '02', '00', 'ACOMAYO');
INSERT INTO `ubigeo_inei` VALUES (776, '08', '02', '01', 'ACOMAYO');
INSERT INTO `ubigeo_inei` VALUES (777, '08', '02', '02', 'ACOPIA');
INSERT INTO `ubigeo_inei` VALUES (778, '08', '02', '03', 'ACOS');
INSERT INTO `ubigeo_inei` VALUES (779, '08', '02', '04', 'MOSOC LLACTA');
INSERT INTO `ubigeo_inei` VALUES (780, '08', '02', '05', 'POMACANCHI');
INSERT INTO `ubigeo_inei` VALUES (781, '08', '02', '06', 'RONDOCAN');
INSERT INTO `ubigeo_inei` VALUES (782, '08', '02', '07', 'SANGARARA');
INSERT INTO `ubigeo_inei` VALUES (783, '08', '03', '00', 'ANTA');
INSERT INTO `ubigeo_inei` VALUES (784, '08', '03', '01', 'ANTA');
INSERT INTO `ubigeo_inei` VALUES (785, '08', '03', '02', 'ANCAHUASI');
INSERT INTO `ubigeo_inei` VALUES (786, '08', '03', '03', 'CACHIMAYO');
INSERT INTO `ubigeo_inei` VALUES (787, '08', '03', '04', 'CHINCHAYPUJIO');
INSERT INTO `ubigeo_inei` VALUES (788, '08', '03', '05', 'HUAROCONDO');
INSERT INTO `ubigeo_inei` VALUES (789, '08', '03', '06', 'LIMATAMBO');
INSERT INTO `ubigeo_inei` VALUES (790, '08', '03', '07', 'MOLLEPATA');
INSERT INTO `ubigeo_inei` VALUES (791, '08', '03', '08', 'PUCYURA');
INSERT INTO `ubigeo_inei` VALUES (792, '08', '03', '09', 'ZURITE');
INSERT INTO `ubigeo_inei` VALUES (793, '08', '04', '00', 'CALCA');
INSERT INTO `ubigeo_inei` VALUES (794, '08', '04', '01', 'CALCA');
INSERT INTO `ubigeo_inei` VALUES (795, '08', '04', '02', 'COYA');
INSERT INTO `ubigeo_inei` VALUES (796, '08', '04', '03', 'LAMAY');
INSERT INTO `ubigeo_inei` VALUES (797, '08', '04', '04', 'LARES');
INSERT INTO `ubigeo_inei` VALUES (798, '08', '04', '05', 'PISAC');
INSERT INTO `ubigeo_inei` VALUES (799, '08', '04', '06', 'SAN SALVADOR');
INSERT INTO `ubigeo_inei` VALUES (800, '08', '04', '07', 'TARAY');
INSERT INTO `ubigeo_inei` VALUES (801, '08', '04', '08', 'YANATILE');
INSERT INTO `ubigeo_inei` VALUES (802, '08', '05', '00', 'CANAS');
INSERT INTO `ubigeo_inei` VALUES (803, '08', '05', '01', 'YANAOCA');
INSERT INTO `ubigeo_inei` VALUES (804, '08', '05', '02', 'CHECCA');
INSERT INTO `ubigeo_inei` VALUES (805, '08', '05', '03', 'KUNTURKANKI');
INSERT INTO `ubigeo_inei` VALUES (806, '08', '05', '04', 'LANGUI');
INSERT INTO `ubigeo_inei` VALUES (807, '08', '05', '05', 'LAYO');
INSERT INTO `ubigeo_inei` VALUES (808, '08', '05', '06', 'PAMPAMARCA');
INSERT INTO `ubigeo_inei` VALUES (809, '08', '05', '07', 'QUEHUE');
INSERT INTO `ubigeo_inei` VALUES (810, '08', '05', '08', 'TUPAC AMARU');
INSERT INTO `ubigeo_inei` VALUES (811, '08', '06', '00', 'CANCHIS');
INSERT INTO `ubigeo_inei` VALUES (812, '08', '06', '01', 'SICUANI');
INSERT INTO `ubigeo_inei` VALUES (813, '08', '06', '02', 'CHECACUPE');
INSERT INTO `ubigeo_inei` VALUES (814, '08', '06', '03', 'COMBAPATA');
INSERT INTO `ubigeo_inei` VALUES (815, '08', '06', '04', 'MARANGANI');
INSERT INTO `ubigeo_inei` VALUES (816, '08', '06', '05', 'PITUMARCA');
INSERT INTO `ubigeo_inei` VALUES (817, '08', '06', '06', 'SAN PABLO');
INSERT INTO `ubigeo_inei` VALUES (818, '08', '06', '07', 'SAN PEDRO');
INSERT INTO `ubigeo_inei` VALUES (819, '08', '06', '08', 'TINTA');
INSERT INTO `ubigeo_inei` VALUES (820, '08', '07', '00', 'CHUMBIVILCAS');
INSERT INTO `ubigeo_inei` VALUES (821, '08', '07', '01', 'SANTO TOMAS');
INSERT INTO `ubigeo_inei` VALUES (822, '08', '07', '02', 'CAPACMARCA');
INSERT INTO `ubigeo_inei` VALUES (823, '08', '07', '03', 'CHAMACA');
INSERT INTO `ubigeo_inei` VALUES (824, '08', '07', '04', 'COLQUEMARCA');
INSERT INTO `ubigeo_inei` VALUES (825, '08', '07', '05', 'LIVITACA');
INSERT INTO `ubigeo_inei` VALUES (826, '08', '07', '06', 'LLUSCO');
INSERT INTO `ubigeo_inei` VALUES (827, '08', '07', '07', 'QUIÑOTA');
INSERT INTO `ubigeo_inei` VALUES (828, '08', '07', '08', 'VELILLE');
INSERT INTO `ubigeo_inei` VALUES (829, '08', '08', '00', 'ESPINAR');
INSERT INTO `ubigeo_inei` VALUES (830, '08', '08', '01', 'ESPINAR');
INSERT INTO `ubigeo_inei` VALUES (831, '08', '08', '02', 'CONDOROMA');
INSERT INTO `ubigeo_inei` VALUES (832, '08', '08', '03', 'COPORAQUE');
INSERT INTO `ubigeo_inei` VALUES (833, '08', '08', '04', 'OCORURO');
INSERT INTO `ubigeo_inei` VALUES (834, '08', '08', '05', 'PALLPATA');
INSERT INTO `ubigeo_inei` VALUES (835, '08', '08', '06', 'PICHIGUA');
INSERT INTO `ubigeo_inei` VALUES (836, '08', '08', '07', 'SUYCKUTAMBO');
INSERT INTO `ubigeo_inei` VALUES (837, '08', '08', '08', 'ALTO PICHIGUA');
INSERT INTO `ubigeo_inei` VALUES (838, '08', '09', '00', 'LA CONVENCION');
INSERT INTO `ubigeo_inei` VALUES (839, '08', '09', '01', 'SANTA ANA');
INSERT INTO `ubigeo_inei` VALUES (840, '08', '09', '02', 'ECHARATE');
INSERT INTO `ubigeo_inei` VALUES (841, '08', '09', '03', 'HUAYOPATA');
INSERT INTO `ubigeo_inei` VALUES (842, '08', '09', '04', 'MARANURA');
INSERT INTO `ubigeo_inei` VALUES (843, '08', '09', '05', 'OCOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (844, '08', '09', '06', 'QUELLOUNO');
INSERT INTO `ubigeo_inei` VALUES (845, '08', '09', '07', 'KIMBIRI');
INSERT INTO `ubigeo_inei` VALUES (846, '08', '09', '08', 'SANTA TERESA');
INSERT INTO `ubigeo_inei` VALUES (847, '08', '09', '09', 'VILCABAMBA');
INSERT INTO `ubigeo_inei` VALUES (848, '08', '09', '10', 'PICHARI');
INSERT INTO `ubigeo_inei` VALUES (849, '08', '09', '11', 'INKAWASI');
INSERT INTO `ubigeo_inei` VALUES (850, '08', '09', '12', 'VILLA VIRGEN');
INSERT INTO `ubigeo_inei` VALUES (851, '08', '10', '00', 'PARURO');
INSERT INTO `ubigeo_inei` VALUES (852, '08', '10', '01', 'PARURO');
INSERT INTO `ubigeo_inei` VALUES (853, '08', '10', '02', 'ACCHA');
INSERT INTO `ubigeo_inei` VALUES (854, '08', '10', '03', 'CCAPI');
INSERT INTO `ubigeo_inei` VALUES (855, '08', '10', '04', 'COLCHA');
INSERT INTO `ubigeo_inei` VALUES (856, '08', '10', '05', 'HUANOQUITE');
INSERT INTO `ubigeo_inei` VALUES (857, '08', '10', '06', 'OMACHA');
INSERT INTO `ubigeo_inei` VALUES (858, '08', '10', '07', 'PACCARITAMBO');
INSERT INTO `ubigeo_inei` VALUES (859, '08', '10', '08', 'PILLPINTO');
INSERT INTO `ubigeo_inei` VALUES (860, '08', '10', '09', 'YAURISQUE');
INSERT INTO `ubigeo_inei` VALUES (861, '08', '11', '00', 'PAUCARTAMBO');
INSERT INTO `ubigeo_inei` VALUES (862, '08', '11', '01', 'PAUCARTAMBO');
INSERT INTO `ubigeo_inei` VALUES (863, '08', '11', '02', 'CAICAY');
INSERT INTO `ubigeo_inei` VALUES (864, '08', '11', '03', 'CHALLABAMBA');
INSERT INTO `ubigeo_inei` VALUES (865, '08', '11', '04', 'COLQUEPATA');
INSERT INTO `ubigeo_inei` VALUES (866, '08', '11', '05', 'HUANCARANI');
INSERT INTO `ubigeo_inei` VALUES (867, '08', '11', '06', 'KOSÑIPATA');
INSERT INTO `ubigeo_inei` VALUES (868, '08', '12', '00', 'QUISPICANCHI');
INSERT INTO `ubigeo_inei` VALUES (869, '08', '12', '01', 'URCOS');
INSERT INTO `ubigeo_inei` VALUES (870, '08', '12', '02', 'ANDAHUAYLILLAS');
INSERT INTO `ubigeo_inei` VALUES (871, '08', '12', '03', 'CAMANTI');
INSERT INTO `ubigeo_inei` VALUES (872, '08', '12', '04', 'CCARHUAYO');
INSERT INTO `ubigeo_inei` VALUES (873, '08', '12', '05', 'CCATCA');
INSERT INTO `ubigeo_inei` VALUES (874, '08', '12', '06', 'CUSIPATA');
INSERT INTO `ubigeo_inei` VALUES (875, '08', '12', '07', 'HUARO');
INSERT INTO `ubigeo_inei` VALUES (876, '08', '12', '08', 'LUCRE');
INSERT INTO `ubigeo_inei` VALUES (877, '08', '12', '09', 'MARCAPATA');
INSERT INTO `ubigeo_inei` VALUES (878, '08', '12', '10', 'OCONGATE');
INSERT INTO `ubigeo_inei` VALUES (879, '08', '12', '11', 'OROPESA');
INSERT INTO `ubigeo_inei` VALUES (880, '08', '12', '12', 'QUIQUIJANA');
INSERT INTO `ubigeo_inei` VALUES (881, '08', '13', '00', 'URUBAMBA');
INSERT INTO `ubigeo_inei` VALUES (882, '08', '13', '01', 'URUBAMBA');
INSERT INTO `ubigeo_inei` VALUES (883, '08', '13', '02', 'CHINCHERO');
INSERT INTO `ubigeo_inei` VALUES (884, '08', '13', '03', 'HUAYLLABAMBA');
INSERT INTO `ubigeo_inei` VALUES (885, '08', '13', '04', 'MACHUPICCHU');
INSERT INTO `ubigeo_inei` VALUES (886, '08', '13', '05', 'MARAS');
INSERT INTO `ubigeo_inei` VALUES (887, '08', '13', '06', 'OLLANTAYTAMBO');
INSERT INTO `ubigeo_inei` VALUES (888, '08', '13', '07', 'YUCAY');
INSERT INTO `ubigeo_inei` VALUES (889, '09', '00', '00', 'HUANCAVELICA');
INSERT INTO `ubigeo_inei` VALUES (890, '09', '01', '00', 'HUANCAVELICA');
INSERT INTO `ubigeo_inei` VALUES (891, '09', '01', '01', 'HUANCAVELICA');
INSERT INTO `ubigeo_inei` VALUES (892, '09', '01', '02', 'ACOBAMBILLA');
INSERT INTO `ubigeo_inei` VALUES (893, '09', '01', '03', 'ACORIA');
INSERT INTO `ubigeo_inei` VALUES (894, '09', '01', '04', 'CONAYCA');
INSERT INTO `ubigeo_inei` VALUES (895, '09', '01', '05', 'CUENCA');
INSERT INTO `ubigeo_inei` VALUES (896, '09', '01', '06', 'HUACHOCOLPA');
INSERT INTO `ubigeo_inei` VALUES (897, '09', '01', '07', 'HUAYLLAHUARA');
INSERT INTO `ubigeo_inei` VALUES (898, '09', '01', '08', 'IZCUCHACA');
INSERT INTO `ubigeo_inei` VALUES (899, '09', '01', '09', 'LARIA');
INSERT INTO `ubigeo_inei` VALUES (900, '09', '01', '10', 'MANTA');
INSERT INTO `ubigeo_inei` VALUES (901, '09', '01', '11', 'MARISCAL CACERES');
INSERT INTO `ubigeo_inei` VALUES (902, '09', '01', '12', 'MOYA');
INSERT INTO `ubigeo_inei` VALUES (903, '09', '01', '13', 'NUEVO OCCORO');
INSERT INTO `ubigeo_inei` VALUES (904, '09', '01', '14', 'PALCA');
INSERT INTO `ubigeo_inei` VALUES (905, '09', '01', '15', 'PILCHACA');
INSERT INTO `ubigeo_inei` VALUES (906, '09', '01', '16', 'VILCA');
INSERT INTO `ubigeo_inei` VALUES (907, '09', '01', '17', 'YAULI');
INSERT INTO `ubigeo_inei` VALUES (908, '09', '01', '18', 'ASCENSIÓN');
INSERT INTO `ubigeo_inei` VALUES (909, '09', '01', '19', 'HUANDO');
INSERT INTO `ubigeo_inei` VALUES (910, '09', '02', '00', 'ACOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (911, '09', '02', '01', 'ACOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (912, '09', '02', '02', 'ANDABAMBA');
INSERT INTO `ubigeo_inei` VALUES (913, '09', '02', '03', 'ANTA');
INSERT INTO `ubigeo_inei` VALUES (914, '09', '02', '04', 'CAJA');
INSERT INTO `ubigeo_inei` VALUES (915, '09', '02', '05', 'MARCAS');
INSERT INTO `ubigeo_inei` VALUES (916, '09', '02', '06', 'PAUCARA');
INSERT INTO `ubigeo_inei` VALUES (917, '09', '02', '07', 'POMACOCHA');
INSERT INTO `ubigeo_inei` VALUES (918, '09', '02', '08', 'ROSARIO');
INSERT INTO `ubigeo_inei` VALUES (919, '09', '03', '00', 'ANGARAES');
INSERT INTO `ubigeo_inei` VALUES (920, '09', '03', '01', 'LIRCAY');
INSERT INTO `ubigeo_inei` VALUES (921, '09', '03', '02', 'ANCHONGA');
INSERT INTO `ubigeo_inei` VALUES (922, '09', '03', '03', 'CALLANMARCA');
INSERT INTO `ubigeo_inei` VALUES (923, '09', '03', '04', 'CCOCHACCASA');
INSERT INTO `ubigeo_inei` VALUES (924, '09', '03', '05', 'CHINCHO');
INSERT INTO `ubigeo_inei` VALUES (925, '09', '03', '06', 'CONGALLA');
INSERT INTO `ubigeo_inei` VALUES (926, '09', '03', '07', 'HUANCA-HUANCA');
INSERT INTO `ubigeo_inei` VALUES (927, '09', '03', '08', 'HUAYLLAY GRANDE');
INSERT INTO `ubigeo_inei` VALUES (928, '09', '03', '09', 'JULCAMARCA');
INSERT INTO `ubigeo_inei` VALUES (929, '09', '03', '10', 'SAN ANTONIO DE ANTAPARCO');
INSERT INTO `ubigeo_inei` VALUES (930, '09', '03', '11', 'SANTO TOMAS DE PATA');
INSERT INTO `ubigeo_inei` VALUES (931, '09', '03', '12', 'SECCLLA');
INSERT INTO `ubigeo_inei` VALUES (932, '09', '04', '00', 'CASTROVIRREYNA');
INSERT INTO `ubigeo_inei` VALUES (933, '09', '04', '01', 'CASTROVIRREYNA');
INSERT INTO `ubigeo_inei` VALUES (934, '09', '04', '02', 'ARMA');
INSERT INTO `ubigeo_inei` VALUES (935, '09', '04', '03', 'AURAHUA');
INSERT INTO `ubigeo_inei` VALUES (936, '09', '04', '04', 'CAPILLAS');
INSERT INTO `ubigeo_inei` VALUES (937, '09', '04', '05', 'CHUPAMARCA');
INSERT INTO `ubigeo_inei` VALUES (938, '09', '04', '06', 'COCAS');
INSERT INTO `ubigeo_inei` VALUES (939, '09', '04', '07', 'HUACHOS');
INSERT INTO `ubigeo_inei` VALUES (940, '09', '04', '08', 'HUAMATAMBO');
INSERT INTO `ubigeo_inei` VALUES (941, '09', '04', '09', 'MOLLEPAMPA');
INSERT INTO `ubigeo_inei` VALUES (942, '09', '04', '10', 'SAN JUAN');
INSERT INTO `ubigeo_inei` VALUES (943, '09', '04', '11', 'SANTA ANA');
INSERT INTO `ubigeo_inei` VALUES (944, '09', '04', '12', 'TANTARA');
INSERT INTO `ubigeo_inei` VALUES (945, '09', '04', '13', 'TICRAPO');
INSERT INTO `ubigeo_inei` VALUES (946, '09', '05', '00', 'CHURCAMPA');
INSERT INTO `ubigeo_inei` VALUES (947, '09', '05', '01', 'CHURCAMPA');
INSERT INTO `ubigeo_inei` VALUES (948, '09', '05', '02', 'ANCO');
INSERT INTO `ubigeo_inei` VALUES (949, '09', '05', '03', 'CHINCHIHUASI');
INSERT INTO `ubigeo_inei` VALUES (950, '09', '05', '04', 'EL CARMEN');
INSERT INTO `ubigeo_inei` VALUES (951, '09', '05', '05', 'LA MERCED');
INSERT INTO `ubigeo_inei` VALUES (952, '09', '05', '06', 'LOCROJA');
INSERT INTO `ubigeo_inei` VALUES (953, '09', '05', '07', 'PAUCARBAMBA');
INSERT INTO `ubigeo_inei` VALUES (954, '09', '05', '08', 'SAN MIGUEL DE MAYOCC');
INSERT INTO `ubigeo_inei` VALUES (955, '09', '05', '09', 'SAN PEDRO DE CORIS');
INSERT INTO `ubigeo_inei` VALUES (956, '09', '05', '10', 'PACHAMARCA');
INSERT INTO `ubigeo_inei` VALUES (957, '09', '05', '11', 'COSME');
INSERT INTO `ubigeo_inei` VALUES (958, '09', '06', '00', 'HUAYTARA');
INSERT INTO `ubigeo_inei` VALUES (959, '09', '06', '01', 'HUAYTARA');
INSERT INTO `ubigeo_inei` VALUES (960, '09', '06', '02', 'AYAVI');
INSERT INTO `ubigeo_inei` VALUES (961, '09', '06', '03', 'CORDOVA');
INSERT INTO `ubigeo_inei` VALUES (962, '09', '06', '04', 'HUAYACUNDO ARMA');
INSERT INTO `ubigeo_inei` VALUES (963, '09', '06', '05', 'LARAMARCA');
INSERT INTO `ubigeo_inei` VALUES (964, '09', '06', '06', 'OCOYO');
INSERT INTO `ubigeo_inei` VALUES (965, '09', '06', '07', 'PILPICHACA');
INSERT INTO `ubigeo_inei` VALUES (966, '09', '06', '08', 'QUERCO');
INSERT INTO `ubigeo_inei` VALUES (967, '09', '06', '09', 'QUITO-ARMA');
INSERT INTO `ubigeo_inei` VALUES (968, '09', '06', '10', 'SAN ANTONIO DE CUSICANCHA');
INSERT INTO `ubigeo_inei` VALUES (969, '09', '06', '11', 'SAN FRANCISCO DE SANGAYAICO');
INSERT INTO `ubigeo_inei` VALUES (970, '09', '06', '12', 'SAN ISIDRO');
INSERT INTO `ubigeo_inei` VALUES (971, '09', '06', '13', 'SANTIAGO DE CHOCORVOS');
INSERT INTO `ubigeo_inei` VALUES (972, '09', '06', '14', 'SANTIAGO DE QUIRAHUARA');
INSERT INTO `ubigeo_inei` VALUES (973, '09', '06', '15', 'SANTO DOMINGO DE CAPILLAS');
INSERT INTO `ubigeo_inei` VALUES (974, '09', '06', '16', 'TAMBO');
INSERT INTO `ubigeo_inei` VALUES (975, '09', '07', '00', 'TAYACAJA');
INSERT INTO `ubigeo_inei` VALUES (976, '09', '07', '01', 'PAMPAS');
INSERT INTO `ubigeo_inei` VALUES (977, '09', '07', '02', 'ACOSTAMBO');
INSERT INTO `ubigeo_inei` VALUES (978, '09', '07', '03', 'ACRAQUIA');
INSERT INTO `ubigeo_inei` VALUES (979, '09', '07', '04', 'AHUAYCHA');
INSERT INTO `ubigeo_inei` VALUES (980, '09', '07', '05', 'COLCABAMBA');
INSERT INTO `ubigeo_inei` VALUES (981, '09', '07', '06', 'DANIEL HERNANDEZ');
INSERT INTO `ubigeo_inei` VALUES (982, '09', '07', '07', 'HUACHOCOLPA');
INSERT INTO `ubigeo_inei` VALUES (983, '09', '07', '09', 'HUARIBAMBA');
INSERT INTO `ubigeo_inei` VALUES (984, '09', '07', '10', 'ÑAHUIMPUQUIO');
INSERT INTO `ubigeo_inei` VALUES (985, '09', '07', '11', 'PAZOS');
INSERT INTO `ubigeo_inei` VALUES (986, '09', '07', '13', 'QUISHUAR');
INSERT INTO `ubigeo_inei` VALUES (987, '09', '07', '14', 'SALCABAMBA');
INSERT INTO `ubigeo_inei` VALUES (988, '09', '07', '15', 'SALCAHUASI');
INSERT INTO `ubigeo_inei` VALUES (989, '09', '07', '16', 'SAN MARCOS DE ROCCHAC');
INSERT INTO `ubigeo_inei` VALUES (990, '09', '07', '17', 'SURCUBAMBA');
INSERT INTO `ubigeo_inei` VALUES (991, '09', '07', '18', 'TINTAY PUNCU');
INSERT INTO `ubigeo_inei` VALUES (992, '10', '00', '00', 'HUANUCO');
INSERT INTO `ubigeo_inei` VALUES (993, '10', '01', '00', 'HUANUCO');
INSERT INTO `ubigeo_inei` VALUES (994, '10', '01', '01', 'HUANUCO');
INSERT INTO `ubigeo_inei` VALUES (995, '10', '01', '02', 'AMARILIS');
INSERT INTO `ubigeo_inei` VALUES (996, '10', '01', '03', 'CHINCHAO');
INSERT INTO `ubigeo_inei` VALUES (997, '10', '01', '04', 'CHURUBAMBA');
INSERT INTO `ubigeo_inei` VALUES (998, '10', '01', '05', 'MARGOS');
INSERT INTO `ubigeo_inei` VALUES (999, '10', '01', '06', 'QUISQUI');
INSERT INTO `ubigeo_inei` VALUES (1000, '10', '01', '07', 'SAN FRANCISCO DE CAYRAN');
INSERT INTO `ubigeo_inei` VALUES (1001, '10', '01', '08', 'SAN PEDRO DE CHAULAN');
INSERT INTO `ubigeo_inei` VALUES (1002, '10', '01', '09', 'SANTA MARIA DEL VALLE');
INSERT INTO `ubigeo_inei` VALUES (1003, '10', '01', '10', 'YARUMAYO');
INSERT INTO `ubigeo_inei` VALUES (1004, '10', '01', '11', 'PILLCO MARCA');
INSERT INTO `ubigeo_inei` VALUES (1005, '10', '01', '12', 'YACUS');
INSERT INTO `ubigeo_inei` VALUES (1006, '10', '02', '00', 'AMBO');
INSERT INTO `ubigeo_inei` VALUES (1007, '10', '02', '01', 'AMBO');
INSERT INTO `ubigeo_inei` VALUES (1008, '10', '02', '02', 'CAYNA');
INSERT INTO `ubigeo_inei` VALUES (1009, '10', '02', '03', 'COLPAS');
INSERT INTO `ubigeo_inei` VALUES (1010, '10', '02', '04', 'CONCHAMARCA');
INSERT INTO `ubigeo_inei` VALUES (1011, '10', '02', '05', 'HUACAR');
INSERT INTO `ubigeo_inei` VALUES (1012, '10', '02', '06', 'SAN FRANCISCO');
INSERT INTO `ubigeo_inei` VALUES (1013, '10', '02', '07', 'SAN RAFAEL');
INSERT INTO `ubigeo_inei` VALUES (1014, '10', '02', '08', 'TOMAY KICHWA');
INSERT INTO `ubigeo_inei` VALUES (1015, '10', '03', '00', 'DOS DE MAYO');
INSERT INTO `ubigeo_inei` VALUES (1016, '10', '03', '01', 'LA UNION');
INSERT INTO `ubigeo_inei` VALUES (1017, '10', '03', '07', 'CHUQUIS');
INSERT INTO `ubigeo_inei` VALUES (1018, '10', '03', '11', 'MARIAS');
INSERT INTO `ubigeo_inei` VALUES (1019, '10', '03', '13', 'PACHAS');
INSERT INTO `ubigeo_inei` VALUES (1020, '10', '03', '16', 'QUIVILLA');
INSERT INTO `ubigeo_inei` VALUES (1021, '10', '03', '17', 'RIPAN');
INSERT INTO `ubigeo_inei` VALUES (1022, '10', '03', '21', 'SHUNQUI');
INSERT INTO `ubigeo_inei` VALUES (1023, '10', '03', '22', 'SILLAPATA');
INSERT INTO `ubigeo_inei` VALUES (1024, '10', '03', '23', 'YANAS');
INSERT INTO `ubigeo_inei` VALUES (1025, '10', '04', '00', 'HUACAYBAMBA');
INSERT INTO `ubigeo_inei` VALUES (1026, '10', '04', '01', 'HUACAYBAMBA');
INSERT INTO `ubigeo_inei` VALUES (1027, '10', '04', '02', 'CANCHABAMBA');
INSERT INTO `ubigeo_inei` VALUES (1028, '10', '04', '03', 'COCHABAMBA');
INSERT INTO `ubigeo_inei` VALUES (1029, '10', '04', '04', 'PINRA');
INSERT INTO `ubigeo_inei` VALUES (1030, '10', '05', '00', 'HUAMALIES');
INSERT INTO `ubigeo_inei` VALUES (1031, '10', '05', '01', 'LLATA');
INSERT INTO `ubigeo_inei` VALUES (1032, '10', '05', '02', 'ARANCAY');
INSERT INTO `ubigeo_inei` VALUES (1033, '10', '05', '03', 'CHAVIN DE PARIARCA');
INSERT INTO `ubigeo_inei` VALUES (1034, '10', '05', '04', 'JACAS GRANDE');
INSERT INTO `ubigeo_inei` VALUES (1035, '10', '05', '05', 'JIRCAN');
INSERT INTO `ubigeo_inei` VALUES (1036, '10', '05', '06', 'MIRAFLORES');
INSERT INTO `ubigeo_inei` VALUES (1037, '10', '05', '07', 'MONZON');
INSERT INTO `ubigeo_inei` VALUES (1038, '10', '05', '08', 'PUNCHAO');
INSERT INTO `ubigeo_inei` VALUES (1039, '10', '05', '09', 'PUÑOS');
INSERT INTO `ubigeo_inei` VALUES (1040, '10', '05', '10', 'SINGA');
INSERT INTO `ubigeo_inei` VALUES (1041, '10', '05', '11', 'TANTAMAYO');
INSERT INTO `ubigeo_inei` VALUES (1042, '10', '06', '00', 'LEONCIO PRADO');
INSERT INTO `ubigeo_inei` VALUES (1043, '10', '06', '01', 'RUPA-RUPA');
INSERT INTO `ubigeo_inei` VALUES (1044, '10', '06', '02', 'DANIEL ALOMIAS ROBLES');
INSERT INTO `ubigeo_inei` VALUES (1045, '10', '06', '03', 'HERMILIO VALDIZAN');
INSERT INTO `ubigeo_inei` VALUES (1046, '10', '06', '04', 'JOSE CRESPO Y CASTILLO');
INSERT INTO `ubigeo_inei` VALUES (1047, '10', '06', '05', 'LUYANDO');
INSERT INTO `ubigeo_inei` VALUES (1048, '10', '06', '06', 'MARIANO DAMASO BERAUN');
INSERT INTO `ubigeo_inei` VALUES (1049, '10', '07', '00', 'MARAÑON');
INSERT INTO `ubigeo_inei` VALUES (1050, '10', '07', '01', 'HUACRACHUCO');
INSERT INTO `ubigeo_inei` VALUES (1051, '10', '07', '02', 'CHOLON');
INSERT INTO `ubigeo_inei` VALUES (1052, '10', '07', '03', 'SAN BUENAVENTURA');
INSERT INTO `ubigeo_inei` VALUES (1053, '10', '08', '00', 'PACHITEA');
INSERT INTO `ubigeo_inei` VALUES (1054, '10', '08', '01', 'PANAO');
INSERT INTO `ubigeo_inei` VALUES (1055, '10', '08', '02', 'CHAGLLA');
INSERT INTO `ubigeo_inei` VALUES (1056, '10', '08', '03', 'MOLINO');
INSERT INTO `ubigeo_inei` VALUES (1057, '10', '08', '04', 'UMARI');
INSERT INTO `ubigeo_inei` VALUES (1058, '10', '09', '00', 'PUERTO INCA');
INSERT INTO `ubigeo_inei` VALUES (1059, '10', '09', '01', 'PUERTO INCA');
INSERT INTO `ubigeo_inei` VALUES (1060, '10', '09', '02', 'CODO DEL POZUZO');
INSERT INTO `ubigeo_inei` VALUES (1061, '10', '09', '03', 'HONORIA');
INSERT INTO `ubigeo_inei` VALUES (1062, '10', '09', '04', 'TOURNAVISTA');
INSERT INTO `ubigeo_inei` VALUES (1063, '10', '09', '05', 'YUYAPICHIS');
INSERT INTO `ubigeo_inei` VALUES (1064, '10', '10', '00', 'LAURICOCHA');
INSERT INTO `ubigeo_inei` VALUES (1065, '10', '10', '01', 'JESUS');
INSERT INTO `ubigeo_inei` VALUES (1066, '10', '10', '02', 'BAÑOS');
INSERT INTO `ubigeo_inei` VALUES (1067, '10', '10', '03', 'JIVIA');
INSERT INTO `ubigeo_inei` VALUES (1068, '10', '10', '04', 'QUEROPALCA');
INSERT INTO `ubigeo_inei` VALUES (1069, '10', '10', '05', 'RONDOS');
INSERT INTO `ubigeo_inei` VALUES (1070, '10', '10', '06', 'SAN FRANCISCO DE ASIS');
INSERT INTO `ubigeo_inei` VALUES (1071, '10', '10', '07', 'SAN MIGUEL DE CAURI');
INSERT INTO `ubigeo_inei` VALUES (1072, '10', '11', '00', 'YAROWILCA');
INSERT INTO `ubigeo_inei` VALUES (1073, '10', '11', '01', 'CHAVINILLO');
INSERT INTO `ubigeo_inei` VALUES (1074, '10', '11', '02', 'CAHUAC');
INSERT INTO `ubigeo_inei` VALUES (1075, '10', '11', '03', 'CHACABAMBA');
INSERT INTO `ubigeo_inei` VALUES (1076, '10', '11', '04', 'CHUPAN');
INSERT INTO `ubigeo_inei` VALUES (1077, '10', '11', '05', 'JACAS CHICO');
INSERT INTO `ubigeo_inei` VALUES (1078, '10', '11', '06', 'OBAS');
INSERT INTO `ubigeo_inei` VALUES (1079, '10', '11', '07', 'PAMPAMARCA');
INSERT INTO `ubigeo_inei` VALUES (1080, '10', '11', '08', 'CHORAS');
INSERT INTO `ubigeo_inei` VALUES (1081, '11', '00', '00', 'ICA');
INSERT INTO `ubigeo_inei` VALUES (1082, '11', '01', '00', 'ICA');
INSERT INTO `ubigeo_inei` VALUES (1083, '11', '01', '01', 'ICA');
INSERT INTO `ubigeo_inei` VALUES (1084, '11', '01', '02', 'LA TINGUIÑA');
INSERT INTO `ubigeo_inei` VALUES (1085, '11', '01', '03', 'LOS AQUIJES');
INSERT INTO `ubigeo_inei` VALUES (1086, '11', '01', '04', 'OCUCAJE');
INSERT INTO `ubigeo_inei` VALUES (1087, '11', '01', '05', 'PACHACUTEC');
INSERT INTO `ubigeo_inei` VALUES (1088, '11', '01', '06', 'PARCONA');
INSERT INTO `ubigeo_inei` VALUES (1089, '11', '01', '07', 'PUEBLO NUEVO');
INSERT INTO `ubigeo_inei` VALUES (1090, '11', '01', '08', 'SALAS');
INSERT INTO `ubigeo_inei` VALUES (1091, '11', '01', '09', 'SAN JOSE DE LOS MOLINOS');
INSERT INTO `ubigeo_inei` VALUES (1092, '11', '01', '10', 'SAN JUAN BAUTISTA');
INSERT INTO `ubigeo_inei` VALUES (1093, '11', '01', '11', 'SANTIAGO');
INSERT INTO `ubigeo_inei` VALUES (1094, '11', '01', '12', 'SUBTANJALLA');
INSERT INTO `ubigeo_inei` VALUES (1095, '11', '01', '13', 'TATE');
INSERT INTO `ubigeo_inei` VALUES (1096, '11', '01', '14', 'YAUCA DEL ROSARIO');
INSERT INTO `ubigeo_inei` VALUES (1097, '11', '02', '00', 'CHINCHA');
INSERT INTO `ubigeo_inei` VALUES (1098, '11', '02', '01', 'CHINCHA ALTA');
INSERT INTO `ubigeo_inei` VALUES (1099, '11', '02', '02', 'ALTO LARAN');
INSERT INTO `ubigeo_inei` VALUES (1100, '11', '02', '03', 'CHAVIN');
INSERT INTO `ubigeo_inei` VALUES (1101, '11', '02', '04', 'CHINCHA BAJA');
INSERT INTO `ubigeo_inei` VALUES (1102, '11', '02', '05', 'EL CARMEN');
INSERT INTO `ubigeo_inei` VALUES (1103, '11', '02', '06', 'GROCIO PRADO');
INSERT INTO `ubigeo_inei` VALUES (1104, '11', '02', '07', 'PUEBLO NUEVO');
INSERT INTO `ubigeo_inei` VALUES (1105, '11', '02', '08', 'SAN JUAN DE YANAC');
INSERT INTO `ubigeo_inei` VALUES (1106, '11', '02', '09', 'SAN PEDRO DE HUACARPANA');
INSERT INTO `ubigeo_inei` VALUES (1107, '11', '02', '10', 'SUNAMPE');
INSERT INTO `ubigeo_inei` VALUES (1108, '11', '02', '11', 'TAMBO DE MORA');
INSERT INTO `ubigeo_inei` VALUES (1109, '11', '03', '00', 'NAZCA');
INSERT INTO `ubigeo_inei` VALUES (1110, '11', '03', '01', 'NAZCA');
INSERT INTO `ubigeo_inei` VALUES (1111, '11', '03', '02', 'CHANGUILLO');
INSERT INTO `ubigeo_inei` VALUES (1112, '11', '03', '03', 'EL INGENIO');
INSERT INTO `ubigeo_inei` VALUES (1113, '11', '03', '04', 'MARCONA');
INSERT INTO `ubigeo_inei` VALUES (1114, '11', '03', '05', 'VISTA ALEGRE');
INSERT INTO `ubigeo_inei` VALUES (1115, '11', '04', '00', 'PALPA');
INSERT INTO `ubigeo_inei` VALUES (1116, '11', '04', '01', 'PALPA');
INSERT INTO `ubigeo_inei` VALUES (1117, '11', '04', '02', 'LLIPATA');
INSERT INTO `ubigeo_inei` VALUES (1118, '11', '04', '03', 'RIO GRANDE');
INSERT INTO `ubigeo_inei` VALUES (1119, '11', '04', '04', 'SANTA CRUZ');
INSERT INTO `ubigeo_inei` VALUES (1120, '11', '04', '05', 'TIBILLO');
INSERT INTO `ubigeo_inei` VALUES (1121, '11', '05', '00', 'PISCO');
INSERT INTO `ubigeo_inei` VALUES (1122, '11', '05', '01', 'PISCO');
INSERT INTO `ubigeo_inei` VALUES (1123, '11', '05', '02', 'HUANCANO');
INSERT INTO `ubigeo_inei` VALUES (1124, '11', '05', '03', 'HUMAY');
INSERT INTO `ubigeo_inei` VALUES (1125, '11', '05', '04', 'INDEPENDENCIA');
INSERT INTO `ubigeo_inei` VALUES (1126, '11', '05', '05', 'PARACAS');
INSERT INTO `ubigeo_inei` VALUES (1127, '11', '05', '06', 'SAN ANDRES');
INSERT INTO `ubigeo_inei` VALUES (1128, '11', '05', '07', 'SAN CLEMENTE');
INSERT INTO `ubigeo_inei` VALUES (1129, '11', '05', '08', 'TUPAC AMARU INCA');
INSERT INTO `ubigeo_inei` VALUES (1130, '12', '00', '00', 'JUNIN');
INSERT INTO `ubigeo_inei` VALUES (1131, '12', '01', '00', 'HUANCAYO');
INSERT INTO `ubigeo_inei` VALUES (1132, '12', '01', '01', 'HUANCAYO');
INSERT INTO `ubigeo_inei` VALUES (1133, '12', '01', '04', 'CARHUACALLANGA');
INSERT INTO `ubigeo_inei` VALUES (1134, '12', '01', '05', 'CHACAPAMPA');
INSERT INTO `ubigeo_inei` VALUES (1135, '12', '01', '06', 'CHICCHE');
INSERT INTO `ubigeo_inei` VALUES (1136, '12', '01', '07', 'CHILCA');
INSERT INTO `ubigeo_inei` VALUES (1137, '12', '01', '08', 'CHONGOS ALTO');
INSERT INTO `ubigeo_inei` VALUES (1138, '12', '01', '11', 'CHUPURO');
INSERT INTO `ubigeo_inei` VALUES (1139, '12', '01', '12', 'COLCA');
INSERT INTO `ubigeo_inei` VALUES (1140, '12', '01', '13', 'CULLHUAS');
INSERT INTO `ubigeo_inei` VALUES (1141, '12', '01', '14', 'EL TAMBO');
INSERT INTO `ubigeo_inei` VALUES (1142, '12', '01', '16', 'HUACRAPUQUIO');
INSERT INTO `ubigeo_inei` VALUES (1143, '12', '01', '17', 'HUALHUAS');
INSERT INTO `ubigeo_inei` VALUES (1144, '12', '01', '19', 'HUANCAN');
INSERT INTO `ubigeo_inei` VALUES (1145, '12', '01', '20', 'HUASICANCHA');
INSERT INTO `ubigeo_inei` VALUES (1146, '12', '01', '21', 'HUAYUCACHI');
INSERT INTO `ubigeo_inei` VALUES (1147, '12', '01', '22', 'INGENIO');
INSERT INTO `ubigeo_inei` VALUES (1148, '12', '01', '24', 'PARIAHUANCA');
INSERT INTO `ubigeo_inei` VALUES (1149, '12', '01', '25', 'PILCOMAYO');
INSERT INTO `ubigeo_inei` VALUES (1150, '12', '01', '26', 'PUCARA');
INSERT INTO `ubigeo_inei` VALUES (1151, '12', '01', '27', 'QUICHUAY');
INSERT INTO `ubigeo_inei` VALUES (1152, '12', '01', '28', 'QUILCAS');
INSERT INTO `ubigeo_inei` VALUES (1153, '12', '01', '29', 'SAN AGUSTIN');
INSERT INTO `ubigeo_inei` VALUES (1154, '12', '01', '30', 'SAN JERONIMO DE TUNAN');
INSERT INTO `ubigeo_inei` VALUES (1155, '12', '01', '32', 'SAÑO');
INSERT INTO `ubigeo_inei` VALUES (1156, '12', '01', '33', 'SAPALLANGA');
INSERT INTO `ubigeo_inei` VALUES (1157, '12', '01', '34', 'SICAYA');
INSERT INTO `ubigeo_inei` VALUES (1158, '12', '01', '35', 'SANTO DOMINGO DE ACOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (1159, '12', '01', '36', 'VIQUES');
INSERT INTO `ubigeo_inei` VALUES (1160, '12', '02', '00', 'CONCEPCION');
INSERT INTO `ubigeo_inei` VALUES (1161, '12', '02', '01', 'CONCEPCION');
INSERT INTO `ubigeo_inei` VALUES (1162, '12', '02', '02', 'ACO');
INSERT INTO `ubigeo_inei` VALUES (1163, '12', '02', '03', 'ANDAMARCA');
INSERT INTO `ubigeo_inei` VALUES (1164, '12', '02', '04', 'CHAMBARA');
INSERT INTO `ubigeo_inei` VALUES (1165, '12', '02', '05', 'COCHAS');
INSERT INTO `ubigeo_inei` VALUES (1166, '12', '02', '06', 'COMAS');
INSERT INTO `ubigeo_inei` VALUES (1167, '12', '02', '07', 'HEROINAS TOLEDO');
INSERT INTO `ubigeo_inei` VALUES (1168, '12', '02', '08', 'MANZANARES');
INSERT INTO `ubigeo_inei` VALUES (1169, '12', '02', '09', 'MARISCAL CASTILLA');
INSERT INTO `ubigeo_inei` VALUES (1170, '12', '02', '10', 'MATAHUASI');
INSERT INTO `ubigeo_inei` VALUES (1171, '12', '02', '11', 'MITO');
INSERT INTO `ubigeo_inei` VALUES (1172, '12', '02', '12', 'NUEVE DE JULIO');
INSERT INTO `ubigeo_inei` VALUES (1173, '12', '02', '13', 'ORCOTUNA');
INSERT INTO `ubigeo_inei` VALUES (1174, '12', '02', '14', 'SAN JOSE DE QUERO');
INSERT INTO `ubigeo_inei` VALUES (1175, '12', '02', '15', 'SANTA ROSA DE OCOPA');
INSERT INTO `ubigeo_inei` VALUES (1176, '12', '03', '00', 'CHANCHAMAYO');
INSERT INTO `ubigeo_inei` VALUES (1177, '12', '03', '01', 'CHANCHAMAYO');
INSERT INTO `ubigeo_inei` VALUES (1178, '12', '03', '02', 'PERENE');
INSERT INTO `ubigeo_inei` VALUES (1179, '12', '03', '03', 'PICHANAQUI');
INSERT INTO `ubigeo_inei` VALUES (1180, '12', '03', '04', 'SAN LUIS DE SHUARO');
INSERT INTO `ubigeo_inei` VALUES (1181, '12', '03', '05', 'SAN RAMON');
INSERT INTO `ubigeo_inei` VALUES (1182, '12', '03', '06', 'VITOC');
INSERT INTO `ubigeo_inei` VALUES (1183, '12', '04', '00', 'JAUJA');
INSERT INTO `ubigeo_inei` VALUES (1184, '12', '04', '01', 'JAUJA');
INSERT INTO `ubigeo_inei` VALUES (1185, '12', '04', '02', 'ACOLLA');
INSERT INTO `ubigeo_inei` VALUES (1186, '12', '04', '03', 'APATA');
INSERT INTO `ubigeo_inei` VALUES (1187, '12', '04', '04', 'ATAURA');
INSERT INTO `ubigeo_inei` VALUES (1188, '12', '04', '05', 'CANCHAYLLO');
INSERT INTO `ubigeo_inei` VALUES (1189, '12', '04', '06', 'CURICACA');
INSERT INTO `ubigeo_inei` VALUES (1190, '12', '04', '07', 'EL MANTARO');
INSERT INTO `ubigeo_inei` VALUES (1191, '12', '04', '08', 'HUAMALI');
INSERT INTO `ubigeo_inei` VALUES (1192, '12', '04', '09', 'HUARIPAMPA');
INSERT INTO `ubigeo_inei` VALUES (1193, '12', '04', '10', 'HUERTAS');
INSERT INTO `ubigeo_inei` VALUES (1194, '12', '04', '11', 'JANJAILLO');
INSERT INTO `ubigeo_inei` VALUES (1195, '12', '04', '12', 'JULCAN');
INSERT INTO `ubigeo_inei` VALUES (1196, '12', '04', '13', 'LEONOR ORDOÑEZ');
INSERT INTO `ubigeo_inei` VALUES (1197, '12', '04', '14', 'LLOCLLAPAMPA');
INSERT INTO `ubigeo_inei` VALUES (1198, '12', '04', '15', 'MARCO');
INSERT INTO `ubigeo_inei` VALUES (1199, '12', '04', '16', 'MASMA');
INSERT INTO `ubigeo_inei` VALUES (1200, '12', '04', '17', 'MASMA CHICCHE');
INSERT INTO `ubigeo_inei` VALUES (1201, '12', '04', '18', 'MOLINOS');
INSERT INTO `ubigeo_inei` VALUES (1202, '12', '04', '19', 'MONOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (1203, '12', '04', '20', 'MUQUI');
INSERT INTO `ubigeo_inei` VALUES (1204, '12', '04', '21', 'MUQUIYAUYO');
INSERT INTO `ubigeo_inei` VALUES (1205, '12', '04', '22', 'PACA');
INSERT INTO `ubigeo_inei` VALUES (1206, '12', '04', '23', 'PACCHA');
INSERT INTO `ubigeo_inei` VALUES (1207, '12', '04', '24', 'PANCAN');
INSERT INTO `ubigeo_inei` VALUES (1208, '12', '04', '25', 'PARCO');
INSERT INTO `ubigeo_inei` VALUES (1209, '12', '04', '26', 'POMACANCHA');
INSERT INTO `ubigeo_inei` VALUES (1210, '12', '04', '27', 'RICRAN');
INSERT INTO `ubigeo_inei` VALUES (1211, '12', '04', '28', 'SAN LORENZO');
INSERT INTO `ubigeo_inei` VALUES (1212, '12', '04', '29', 'SAN PEDRO DE CHUNAN');
INSERT INTO `ubigeo_inei` VALUES (1213, '12', '04', '30', 'SAUSA');
INSERT INTO `ubigeo_inei` VALUES (1214, '12', '04', '31', 'SINCOS');
INSERT INTO `ubigeo_inei` VALUES (1215, '12', '04', '32', 'TUNAN MARCA');
INSERT INTO `ubigeo_inei` VALUES (1216, '12', '04', '33', 'YAULI');
INSERT INTO `ubigeo_inei` VALUES (1217, '12', '04', '34', 'YAUYOS');
INSERT INTO `ubigeo_inei` VALUES (1218, '12', '05', '00', 'JUNIN');
INSERT INTO `ubigeo_inei` VALUES (1219, '12', '05', '01', 'JUNIN');
INSERT INTO `ubigeo_inei` VALUES (1220, '12', '05', '02', 'CARHUAMAYO');
INSERT INTO `ubigeo_inei` VALUES (1221, '12', '05', '03', 'ONDORES');
INSERT INTO `ubigeo_inei` VALUES (1222, '12', '05', '04', 'ULCUMAYO');
INSERT INTO `ubigeo_inei` VALUES (1223, '12', '06', '00', 'SATIPO');
INSERT INTO `ubigeo_inei` VALUES (1224, '12', '06', '01', 'SATIPO');
INSERT INTO `ubigeo_inei` VALUES (1225, '12', '06', '02', 'COVIRIALI');
INSERT INTO `ubigeo_inei` VALUES (1226, '12', '06', '03', 'LLAYLLA');
INSERT INTO `ubigeo_inei` VALUES (1227, '12', '06', '04', 'MAZAMARI');
INSERT INTO `ubigeo_inei` VALUES (1228, '12', '06', '05', 'PAMPA HERMOSA');
INSERT INTO `ubigeo_inei` VALUES (1229, '12', '06', '06', 'PANGOA');
INSERT INTO `ubigeo_inei` VALUES (1230, '12', '06', '07', 'RIO NEGRO');
INSERT INTO `ubigeo_inei` VALUES (1231, '12', '06', '08', 'RIO TAMBO');
INSERT INTO `ubigeo_inei` VALUES (1232, '12', '06', '99', 'MAZAMARI-PANGOA');
INSERT INTO `ubigeo_inei` VALUES (1233, '12', '07', '00', 'TARMA');
INSERT INTO `ubigeo_inei` VALUES (1234, '12', '07', '01', 'TARMA');
INSERT INTO `ubigeo_inei` VALUES (1235, '12', '07', '02', 'ACOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (1236, '12', '07', '03', 'HUARICOLCA');
INSERT INTO `ubigeo_inei` VALUES (1237, '12', '07', '04', 'HUASAHUASI');
INSERT INTO `ubigeo_inei` VALUES (1238, '12', '07', '05', 'LA UNION');
INSERT INTO `ubigeo_inei` VALUES (1239, '12', '07', '06', 'PALCA');
INSERT INTO `ubigeo_inei` VALUES (1240, '12', '07', '07', 'PALCAMAYO');
INSERT INTO `ubigeo_inei` VALUES (1241, '12', '07', '08', 'SAN PEDRO DE CAJAS');
INSERT INTO `ubigeo_inei` VALUES (1242, '12', '07', '09', 'TAPO');
INSERT INTO `ubigeo_inei` VALUES (1243, '12', '08', '00', 'YAULI');
INSERT INTO `ubigeo_inei` VALUES (1244, '12', '08', '01', 'LA OROYA');
INSERT INTO `ubigeo_inei` VALUES (1245, '12', '08', '02', 'CHACAPALPA');
INSERT INTO `ubigeo_inei` VALUES (1246, '12', '08', '03', 'HUAY-HUAY');
INSERT INTO `ubigeo_inei` VALUES (1247, '12', '08', '04', 'MARCAPOMACOCHA');
INSERT INTO `ubigeo_inei` VALUES (1248, '12', '08', '05', 'MOROCOCHA');
INSERT INTO `ubigeo_inei` VALUES (1249, '12', '08', '06', 'PACCHA');
INSERT INTO `ubigeo_inei` VALUES (1250, '12', '08', '07', 'SANTA BARBARA DE CARHUACAYAN');
INSERT INTO `ubigeo_inei` VALUES (1251, '12', '08', '08', 'SANTA ROSA DE SACCO');
INSERT INTO `ubigeo_inei` VALUES (1252, '12', '08', '09', 'SUITUCANCHA');
INSERT INTO `ubigeo_inei` VALUES (1253, '12', '08', '10', 'YAULI');
INSERT INTO `ubigeo_inei` VALUES (1254, '12', '09', '00', 'CHUPACA');
INSERT INTO `ubigeo_inei` VALUES (1255, '12', '09', '01', 'CHUPACA');
INSERT INTO `ubigeo_inei` VALUES (1256, '12', '09', '02', 'AHUAC');
INSERT INTO `ubigeo_inei` VALUES (1257, '12', '09', '03', 'CHONGOS BAJO');
INSERT INTO `ubigeo_inei` VALUES (1258, '12', '09', '04', 'HUACHAC');
INSERT INTO `ubigeo_inei` VALUES (1259, '12', '09', '05', 'HUAMANCACA CHICO');
INSERT INTO `ubigeo_inei` VALUES (1260, '12', '09', '06', 'SAN JUAN DE ISCOS');
INSERT INTO `ubigeo_inei` VALUES (1261, '12', '09', '07', 'SAN JUAN DE JARPA');
INSERT INTO `ubigeo_inei` VALUES (1262, '12', '09', '08', '3 DE DICIEMBRE');
INSERT INTO `ubigeo_inei` VALUES (1263, '12', '09', '09', 'YANACANCHA');
INSERT INTO `ubigeo_inei` VALUES (1264, '13', '00', '00', 'LA LIBERTAD');
INSERT INTO `ubigeo_inei` VALUES (1265, '13', '01', '00', 'TRUJILLO');
INSERT INTO `ubigeo_inei` VALUES (1266, '13', '01', '01', 'TRUJILLO');
INSERT INTO `ubigeo_inei` VALUES (1267, '13', '01', '02', 'EL PORVENIR');
INSERT INTO `ubigeo_inei` VALUES (1268, '13', '01', '03', 'FLORENCIA DE MORA');
INSERT INTO `ubigeo_inei` VALUES (1269, '13', '01', '04', 'HUANCHACO');
INSERT INTO `ubigeo_inei` VALUES (1270, '13', '01', '05', 'LA ESPERANZA');
INSERT INTO `ubigeo_inei` VALUES (1271, '13', '01', '06', 'LAREDO');
INSERT INTO `ubigeo_inei` VALUES (1272, '13', '01', '07', 'MOCHE');
INSERT INTO `ubigeo_inei` VALUES (1273, '13', '01', '08', 'POROTO');
INSERT INTO `ubigeo_inei` VALUES (1274, '13', '01', '09', 'SALAVERRY');
INSERT INTO `ubigeo_inei` VALUES (1275, '13', '01', '10', 'SIMBAL');
INSERT INTO `ubigeo_inei` VALUES (1276, '13', '01', '11', 'VICTOR LARCO HERRERA');
INSERT INTO `ubigeo_inei` VALUES (1277, '13', '02', '00', 'ASCOPE');
INSERT INTO `ubigeo_inei` VALUES (1278, '13', '02', '01', 'ASCOPE');
INSERT INTO `ubigeo_inei` VALUES (1279, '13', '02', '02', 'CHICAMA');
INSERT INTO `ubigeo_inei` VALUES (1280, '13', '02', '03', 'CHOCOPE');
INSERT INTO `ubigeo_inei` VALUES (1281, '13', '02', '04', 'MAGDALENA DE CAO');
INSERT INTO `ubigeo_inei` VALUES (1282, '13', '02', '05', 'PAIJAN');
INSERT INTO `ubigeo_inei` VALUES (1283, '13', '02', '06', 'RAZURI');
INSERT INTO `ubigeo_inei` VALUES (1284, '13', '02', '07', 'SANTIAGO DE CAO');
INSERT INTO `ubigeo_inei` VALUES (1285, '13', '02', '08', 'CASA GRANDE');
INSERT INTO `ubigeo_inei` VALUES (1286, '13', '03', '00', 'BOLIVAR');
INSERT INTO `ubigeo_inei` VALUES (1287, '13', '03', '01', 'BOLIVAR');
INSERT INTO `ubigeo_inei` VALUES (1288, '13', '03', '02', 'BAMBAMARCA');
INSERT INTO `ubigeo_inei` VALUES (1289, '13', '03', '03', 'CONDORMARCA');
INSERT INTO `ubigeo_inei` VALUES (1290, '13', '03', '04', 'LONGOTEA');
INSERT INTO `ubigeo_inei` VALUES (1291, '13', '03', '05', 'UCHUMARCA');
INSERT INTO `ubigeo_inei` VALUES (1292, '13', '03', '06', 'UCUNCHA');
INSERT INTO `ubigeo_inei` VALUES (1293, '13', '04', '00', 'CHEPEN');
INSERT INTO `ubigeo_inei` VALUES (1294, '13', '04', '01', 'CHEPEN');
INSERT INTO `ubigeo_inei` VALUES (1295, '13', '04', '02', 'PACANGA');
INSERT INTO `ubigeo_inei` VALUES (1296, '13', '04', '03', 'PUEBLO NUEVO');
INSERT INTO `ubigeo_inei` VALUES (1297, '13', '05', '00', 'JULCAN');
INSERT INTO `ubigeo_inei` VALUES (1298, '13', '05', '01', 'JULCAN');
INSERT INTO `ubigeo_inei` VALUES (1299, '13', '05', '02', 'CALAMARCA');
INSERT INTO `ubigeo_inei` VALUES (1300, '13', '05', '03', 'CARABAMBA');
INSERT INTO `ubigeo_inei` VALUES (1301, '13', '05', '04', 'HUASO');
INSERT INTO `ubigeo_inei` VALUES (1302, '13', '06', '00', 'OTUZCO');
INSERT INTO `ubigeo_inei` VALUES (1303, '13', '06', '01', 'OTUZCO');
INSERT INTO `ubigeo_inei` VALUES (1304, '13', '06', '02', 'AGALLPAMPA');
INSERT INTO `ubigeo_inei` VALUES (1305, '13', '06', '04', 'CHARAT');
INSERT INTO `ubigeo_inei` VALUES (1306, '13', '06', '05', 'HUARANCHAL');
INSERT INTO `ubigeo_inei` VALUES (1307, '13', '06', '06', 'LA CUESTA');
INSERT INTO `ubigeo_inei` VALUES (1308, '13', '06', '08', 'MACHE');
INSERT INTO `ubigeo_inei` VALUES (1309, '13', '06', '10', 'PARANDAY');
INSERT INTO `ubigeo_inei` VALUES (1310, '13', '06', '11', 'SALPO');
INSERT INTO `ubigeo_inei` VALUES (1311, '13', '06', '13', 'SINSICAP');
INSERT INTO `ubigeo_inei` VALUES (1312, '13', '06', '14', 'USQUIL');
INSERT INTO `ubigeo_inei` VALUES (1313, '13', '07', '00', 'PACASMAYO');
INSERT INTO `ubigeo_inei` VALUES (1314, '13', '07', '01', 'SAN PEDRO DE LLOC');
INSERT INTO `ubigeo_inei` VALUES (1315, '13', '07', '02', 'GUADALUPE');
INSERT INTO `ubigeo_inei` VALUES (1316, '13', '07', '03', 'JEQUETEPEQUE');
INSERT INTO `ubigeo_inei` VALUES (1317, '13', '07', '04', 'PACASMAYO');
INSERT INTO `ubigeo_inei` VALUES (1318, '13', '07', '05', 'SAN JOSE');
INSERT INTO `ubigeo_inei` VALUES (1319, '13', '08', '00', 'PATAZ');
INSERT INTO `ubigeo_inei` VALUES (1320, '13', '08', '01', 'TAYABAMBA');
INSERT INTO `ubigeo_inei` VALUES (1321, '13', '08', '02', 'BULDIBUYO');
INSERT INTO `ubigeo_inei` VALUES (1322, '13', '08', '03', 'CHILLIA');
INSERT INTO `ubigeo_inei` VALUES (1323, '13', '08', '04', 'HUANCASPATA');
INSERT INTO `ubigeo_inei` VALUES (1324, '13', '08', '05', 'HUAYLILLAS');
INSERT INTO `ubigeo_inei` VALUES (1325, '13', '08', '06', 'HUAYO');
INSERT INTO `ubigeo_inei` VALUES (1326, '13', '08', '07', 'ONGON');
INSERT INTO `ubigeo_inei` VALUES (1327, '13', '08', '08', 'PARCOY');
INSERT INTO `ubigeo_inei` VALUES (1328, '13', '08', '09', 'PATAZ');
INSERT INTO `ubigeo_inei` VALUES (1329, '13', '08', '10', 'PIAS');
INSERT INTO `ubigeo_inei` VALUES (1330, '13', '08', '11', 'SANTIAGO DE CHALLAS');
INSERT INTO `ubigeo_inei` VALUES (1331, '13', '08', '12', 'TAURIJA');
INSERT INTO `ubigeo_inei` VALUES (1332, '13', '08', '13', 'URPAY');
INSERT INTO `ubigeo_inei` VALUES (1333, '13', '09', '00', 'SANCHEZ CARRION');
INSERT INTO `ubigeo_inei` VALUES (1334, '13', '09', '01', 'HUAMACHUCO');
INSERT INTO `ubigeo_inei` VALUES (1335, '13', '09', '02', 'CHUGAY');
INSERT INTO `ubigeo_inei` VALUES (1336, '13', '09', '03', 'COCHORCO');
INSERT INTO `ubigeo_inei` VALUES (1337, '13', '09', '04', 'CURGOS');
INSERT INTO `ubigeo_inei` VALUES (1338, '13', '09', '05', 'MARCABAL');
INSERT INTO `ubigeo_inei` VALUES (1339, '13', '09', '06', 'SANAGORAN');
INSERT INTO `ubigeo_inei` VALUES (1340, '13', '09', '07', 'SARIN');
INSERT INTO `ubigeo_inei` VALUES (1341, '13', '09', '08', 'SARTIMBAMBA');
INSERT INTO `ubigeo_inei` VALUES (1342, '13', '10', '00', 'SANTIAGO DE CHUCO');
INSERT INTO `ubigeo_inei` VALUES (1343, '13', '10', '01', 'SANTIAGO DE CHUCO');
INSERT INTO `ubigeo_inei` VALUES (1344, '13', '10', '02', 'ANGASMARCA');
INSERT INTO `ubigeo_inei` VALUES (1345, '13', '10', '03', 'CACHICADAN');
INSERT INTO `ubigeo_inei` VALUES (1346, '13', '10', '04', 'MOLLEBAMBA');
INSERT INTO `ubigeo_inei` VALUES (1347, '13', '10', '05', 'MOLLEPATA');
INSERT INTO `ubigeo_inei` VALUES (1348, '13', '10', '06', 'QUIRUVILCA');
INSERT INTO `ubigeo_inei` VALUES (1349, '13', '10', '07', 'SANTA CRUZ DE CHUCA');
INSERT INTO `ubigeo_inei` VALUES (1350, '13', '10', '08', 'SITABAMBA');
INSERT INTO `ubigeo_inei` VALUES (1351, '13', '11', '00', 'GRAN CHIMU');
INSERT INTO `ubigeo_inei` VALUES (1352, '13', '11', '01', 'CASCAS');
INSERT INTO `ubigeo_inei` VALUES (1353, '13', '11', '02', 'LUCMA');
INSERT INTO `ubigeo_inei` VALUES (1354, '13', '11', '03', 'MARMOT');
INSERT INTO `ubigeo_inei` VALUES (1355, '13', '11', '04', 'SAYAPULLO');
INSERT INTO `ubigeo_inei` VALUES (1356, '13', '12', '00', 'VIRU');
INSERT INTO `ubigeo_inei` VALUES (1357, '13', '12', '01', 'VIRU');
INSERT INTO `ubigeo_inei` VALUES (1358, '13', '12', '02', 'CHAO');
INSERT INTO `ubigeo_inei` VALUES (1359, '13', '12', '03', 'GUADALUPITO');
INSERT INTO `ubigeo_inei` VALUES (1360, '14', '00', '00', 'LAMBAYEQUE');
INSERT INTO `ubigeo_inei` VALUES (1361, '14', '01', '00', 'CHICLAYO');
INSERT INTO `ubigeo_inei` VALUES (1362, '14', '01', '01', 'CHICLAYO');
INSERT INTO `ubigeo_inei` VALUES (1363, '14', '01', '02', 'CHONGOYAPE');
INSERT INTO `ubigeo_inei` VALUES (1364, '14', '01', '03', 'ETEN');
INSERT INTO `ubigeo_inei` VALUES (1365, '14', '01', '04', 'ETEN PUERTO');
INSERT INTO `ubigeo_inei` VALUES (1366, '14', '01', '05', 'JOSE LEONARDO ORTIZ');
INSERT INTO `ubigeo_inei` VALUES (1367, '14', '01', '06', 'LA VICTORIA');
INSERT INTO `ubigeo_inei` VALUES (1368, '14', '01', '07', 'LAGUNAS');
INSERT INTO `ubigeo_inei` VALUES (1369, '14', '01', '08', 'MONSEFU');
INSERT INTO `ubigeo_inei` VALUES (1370, '14', '01', '09', 'NUEVA ARICA');
INSERT INTO `ubigeo_inei` VALUES (1371, '14', '01', '10', 'OYOTUN');
INSERT INTO `ubigeo_inei` VALUES (1372, '14', '01', '11', 'PICSI');
INSERT INTO `ubigeo_inei` VALUES (1373, '14', '01', '12', 'PIMENTEL');
INSERT INTO `ubigeo_inei` VALUES (1374, '14', '01', '13', 'REQUE');
INSERT INTO `ubigeo_inei` VALUES (1375, '14', '01', '14', 'SANTA ROSA');
INSERT INTO `ubigeo_inei` VALUES (1376, '14', '01', '15', 'SAÑA');
INSERT INTO `ubigeo_inei` VALUES (1377, '14', '01', '16', 'CAYALTÍ');
INSERT INTO `ubigeo_inei` VALUES (1378, '14', '01', '17', 'PATAPO');
INSERT INTO `ubigeo_inei` VALUES (1379, '14', '01', '18', 'POMALCA');
INSERT INTO `ubigeo_inei` VALUES (1380, '14', '01', '19', 'PUCALÁ');
INSERT INTO `ubigeo_inei` VALUES (1381, '14', '01', '20', 'TUMÁN');
INSERT INTO `ubigeo_inei` VALUES (1382, '14', '02', '00', 'FERREÑAFE');
INSERT INTO `ubigeo_inei` VALUES (1383, '14', '02', '01', 'FERREÑAFE');
INSERT INTO `ubigeo_inei` VALUES (1384, '14', '02', '02', 'CAÑARIS');
INSERT INTO `ubigeo_inei` VALUES (1385, '14', '02', '03', 'INCAHUASI');
INSERT INTO `ubigeo_inei` VALUES (1386, '14', '02', '04', 'MANUEL ANTONIO MESONES MURO');
INSERT INTO `ubigeo_inei` VALUES (1387, '14', '02', '05', 'PITIPO');
INSERT INTO `ubigeo_inei` VALUES (1388, '14', '02', '06', 'PUEBLO NUEVO');
INSERT INTO `ubigeo_inei` VALUES (1389, '14', '03', '00', 'LAMBAYEQUE');
INSERT INTO `ubigeo_inei` VALUES (1390, '14', '03', '01', 'LAMBAYEQUE');
INSERT INTO `ubigeo_inei` VALUES (1391, '14', '03', '02', 'CHOCHOPE');
INSERT INTO `ubigeo_inei` VALUES (1392, '14', '03', '03', 'ILLIMO');
INSERT INTO `ubigeo_inei` VALUES (1393, '14', '03', '04', 'JAYANCA');
INSERT INTO `ubigeo_inei` VALUES (1394, '14', '03', '05', 'MOCHUMI');
INSERT INTO `ubigeo_inei` VALUES (1395, '14', '03', '06', 'MORROPE');
INSERT INTO `ubigeo_inei` VALUES (1396, '14', '03', '07', 'MOTUPE');
INSERT INTO `ubigeo_inei` VALUES (1397, '14', '03', '08', 'OLMOS');
INSERT INTO `ubigeo_inei` VALUES (1398, '14', '03', '09', 'PACORA');
INSERT INTO `ubigeo_inei` VALUES (1399, '14', '03', '10', 'SALAS');
INSERT INTO `ubigeo_inei` VALUES (1400, '14', '03', '11', 'SAN JOSE');
INSERT INTO `ubigeo_inei` VALUES (1401, '14', '03', '12', 'TUCUME');
INSERT INTO `ubigeo_inei` VALUES (1402, '15', '00', '00', 'LIMA');
INSERT INTO `ubigeo_inei` VALUES (1403, '15', '01', '00', 'LIMA');
INSERT INTO `ubigeo_inei` VALUES (1404, '15', '01', '01', 'LIMA');
INSERT INTO `ubigeo_inei` VALUES (1405, '15', '01', '02', 'ANCON');
INSERT INTO `ubigeo_inei` VALUES (1406, '15', '01', '03', 'ATE');
INSERT INTO `ubigeo_inei` VALUES (1407, '15', '01', '04', 'BARRANCO');
INSERT INTO `ubigeo_inei` VALUES (1408, '15', '01', '05', 'BREÑA');
INSERT INTO `ubigeo_inei` VALUES (1409, '15', '01', '06', 'CARABAYLLO');
INSERT INTO `ubigeo_inei` VALUES (1410, '15', '01', '07', 'CHACLACAYO');
INSERT INTO `ubigeo_inei` VALUES (1411, '15', '01', '08', 'CHORRILLOS');
INSERT INTO `ubigeo_inei` VALUES (1412, '15', '01', '09', 'CIENEGUILLA');
INSERT INTO `ubigeo_inei` VALUES (1413, '15', '01', '10', 'COMAS');
INSERT INTO `ubigeo_inei` VALUES (1414, '15', '01', '11', 'EL AGUSTINO');
INSERT INTO `ubigeo_inei` VALUES (1415, '15', '01', '12', 'INDEPENDENCIA');
INSERT INTO `ubigeo_inei` VALUES (1416, '15', '01', '13', 'JESUS MARIA');
INSERT INTO `ubigeo_inei` VALUES (1417, '15', '01', '14', 'LA MOLINA');
INSERT INTO `ubigeo_inei` VALUES (1418, '15', '01', '15', 'LA VICTORIA');
INSERT INTO `ubigeo_inei` VALUES (1419, '15', '01', '16', 'LINCE');
INSERT INTO `ubigeo_inei` VALUES (1420, '15', '01', '17', 'LOS OLIVOS');
INSERT INTO `ubigeo_inei` VALUES (1421, '15', '01', '18', 'LURIGANCHO');
INSERT INTO `ubigeo_inei` VALUES (1422, '15', '01', '19', 'LURIN');
INSERT INTO `ubigeo_inei` VALUES (1423, '15', '01', '20', 'MAGDALENA DEL MAR');
INSERT INTO `ubigeo_inei` VALUES (1424, '15', '01', '21', 'PUEBLO LIBRE (MAGDALENA VIEJA)');
INSERT INTO `ubigeo_inei` VALUES (1425, '15', '01', '22', 'MIRAFLORES');
INSERT INTO `ubigeo_inei` VALUES (1426, '15', '01', '23', 'PACHACAMAC');
INSERT INTO `ubigeo_inei` VALUES (1427, '15', '01', '24', 'PUCUSANA');
INSERT INTO `ubigeo_inei` VALUES (1428, '15', '01', '25', 'PUENTE PIEDRA');
INSERT INTO `ubigeo_inei` VALUES (1429, '15', '01', '26', 'PUNTA HERMOSA');
INSERT INTO `ubigeo_inei` VALUES (1430, '15', '01', '27', 'PUNTA NEGRA');
INSERT INTO `ubigeo_inei` VALUES (1431, '15', '01', '28', 'RIMAC');
INSERT INTO `ubigeo_inei` VALUES (1432, '15', '01', '29', 'SAN BARTOLO');
INSERT INTO `ubigeo_inei` VALUES (1433, '15', '01', '30', 'SAN BORJA');
INSERT INTO `ubigeo_inei` VALUES (1434, '15', '01', '31', 'SAN ISIDRO');
INSERT INTO `ubigeo_inei` VALUES (1435, '15', '01', '32', 'SAN JUAN DE LURIGANCHO');
INSERT INTO `ubigeo_inei` VALUES (1436, '15', '01', '33', 'SAN JUAN DE MIRAFLORES');
INSERT INTO `ubigeo_inei` VALUES (1437, '15', '01', '34', 'SAN LUIS');
INSERT INTO `ubigeo_inei` VALUES (1438, '15', '01', '35', 'SAN MARTIN DE PORRES');
INSERT INTO `ubigeo_inei` VALUES (1439, '15', '01', '36', 'SAN MIGUEL');
INSERT INTO `ubigeo_inei` VALUES (1440, '15', '01', '37', 'SANTA ANITA');
INSERT INTO `ubigeo_inei` VALUES (1441, '15', '01', '38', 'SANTA MARIA DEL MAR');
INSERT INTO `ubigeo_inei` VALUES (1442, '15', '01', '39', 'SANTA ROSA');
INSERT INTO `ubigeo_inei` VALUES (1443, '15', '01', '40', 'SANTIAGO DE SURCO');
INSERT INTO `ubigeo_inei` VALUES (1444, '15', '01', '41', 'SURQUILLO');
INSERT INTO `ubigeo_inei` VALUES (1445, '15', '01', '42', 'VILLA EL SALVADOR');
INSERT INTO `ubigeo_inei` VALUES (1446, '15', '01', '43', 'VILLA MARIA DEL TRIUNFO');
INSERT INTO `ubigeo_inei` VALUES (1447, '15', '02', '00', 'BARRANCA');
INSERT INTO `ubigeo_inei` VALUES (1448, '15', '02', '01', 'BARRANCA');
INSERT INTO `ubigeo_inei` VALUES (1449, '15', '02', '02', 'PARAMONGA');
INSERT INTO `ubigeo_inei` VALUES (1450, '15', '02', '03', 'PATIVILCA');
INSERT INTO `ubigeo_inei` VALUES (1451, '15', '02', '04', 'SUPE');
INSERT INTO `ubigeo_inei` VALUES (1452, '15', '02', '05', 'SUPE PUERTO');
INSERT INTO `ubigeo_inei` VALUES (1453, '15', '03', '00', 'CAJATAMBO');
INSERT INTO `ubigeo_inei` VALUES (1454, '15', '03', '01', 'CAJATAMBO');
INSERT INTO `ubigeo_inei` VALUES (1455, '15', '03', '02', 'COPA');
INSERT INTO `ubigeo_inei` VALUES (1456, '15', '03', '03', 'GORGOR');
INSERT INTO `ubigeo_inei` VALUES (1457, '15', '03', '04', 'HUANCAPON');
INSERT INTO `ubigeo_inei` VALUES (1458, '15', '03', '05', 'MANAS');
INSERT INTO `ubigeo_inei` VALUES (1459, '15', '04', '00', 'CANTA');
INSERT INTO `ubigeo_inei` VALUES (1460, '15', '04', '01', 'CANTA');
INSERT INTO `ubigeo_inei` VALUES (1461, '15', '04', '02', 'ARAHUAY');
INSERT INTO `ubigeo_inei` VALUES (1462, '15', '04', '03', 'HUAMANTANGA');
INSERT INTO `ubigeo_inei` VALUES (1463, '15', '04', '04', 'HUAROS');
INSERT INTO `ubigeo_inei` VALUES (1464, '15', '04', '05', 'LACHAQUI');
INSERT INTO `ubigeo_inei` VALUES (1465, '15', '04', '06', 'SAN BUENAVENTURA');
INSERT INTO `ubigeo_inei` VALUES (1466, '15', '04', '07', 'SANTA ROSA DE QUIVES');
INSERT INTO `ubigeo_inei` VALUES (1467, '15', '05', '00', 'CAÑETE');
INSERT INTO `ubigeo_inei` VALUES (1468, '15', '05', '01', 'SAN VICENTE DE CAÑETE');
INSERT INTO `ubigeo_inei` VALUES (1469, '15', '05', '02', 'ASIA');
INSERT INTO `ubigeo_inei` VALUES (1470, '15', '05', '03', 'CALANGO');
INSERT INTO `ubigeo_inei` VALUES (1471, '15', '05', '04', 'CERRO AZUL');
INSERT INTO `ubigeo_inei` VALUES (1472, '15', '05', '05', 'CHILCA');
INSERT INTO `ubigeo_inei` VALUES (1473, '15', '05', '06', 'COAYLLO');
INSERT INTO `ubigeo_inei` VALUES (1474, '15', '05', '07', 'IMPERIAL');
INSERT INTO `ubigeo_inei` VALUES (1475, '15', '05', '08', 'LUNAHUANA');
INSERT INTO `ubigeo_inei` VALUES (1476, '15', '05', '09', 'MALA');
INSERT INTO `ubigeo_inei` VALUES (1477, '15', '05', '10', 'NUEVO IMPERIAL');
INSERT INTO `ubigeo_inei` VALUES (1478, '15', '05', '11', 'PACARAN');
INSERT INTO `ubigeo_inei` VALUES (1479, '15', '05', '12', 'QUILMANA');
INSERT INTO `ubigeo_inei` VALUES (1480, '15', '05', '13', 'SAN ANTONIO');
INSERT INTO `ubigeo_inei` VALUES (1481, '15', '05', '14', 'SAN LUIS');
INSERT INTO `ubigeo_inei` VALUES (1482, '15', '05', '15', 'SANTA CRUZ DE FLORES');
INSERT INTO `ubigeo_inei` VALUES (1483, '15', '05', '16', 'ZUÑIGA');
INSERT INTO `ubigeo_inei` VALUES (1484, '15', '06', '00', 'HUARAL');
INSERT INTO `ubigeo_inei` VALUES (1485, '15', '06', '01', 'HUARAL');
INSERT INTO `ubigeo_inei` VALUES (1486, '15', '06', '02', 'ATAVILLOS ALTO');
INSERT INTO `ubigeo_inei` VALUES (1487, '15', '06', '03', 'ATAVILLOS BAJO');
INSERT INTO `ubigeo_inei` VALUES (1488, '15', '06', '04', 'AUCALLAMA');
INSERT INTO `ubigeo_inei` VALUES (1489, '15', '06', '05', 'CHANCAY');
INSERT INTO `ubigeo_inei` VALUES (1490, '15', '06', '06', 'IHUARI');
INSERT INTO `ubigeo_inei` VALUES (1491, '15', '06', '07', 'LAMPIAN');
INSERT INTO `ubigeo_inei` VALUES (1492, '15', '06', '08', 'PACARAOS');
INSERT INTO `ubigeo_inei` VALUES (1493, '15', '06', '09', 'SAN MIGUEL DE ACOS');
INSERT INTO `ubigeo_inei` VALUES (1494, '15', '06', '10', 'SANTA CRUZ DE ANDAMARCA');
INSERT INTO `ubigeo_inei` VALUES (1495, '15', '06', '11', 'SUMBILCA');
INSERT INTO `ubigeo_inei` VALUES (1496, '15', '06', '12', 'VEINTISIETE DE NOVIEMBRE');
INSERT INTO `ubigeo_inei` VALUES (1497, '15', '07', '00', 'HUAROCHIRI');
INSERT INTO `ubigeo_inei` VALUES (1498, '15', '07', '01', 'MATUCANA');
INSERT INTO `ubigeo_inei` VALUES (1499, '15', '07', '02', 'ANTIOQUIA');
INSERT INTO `ubigeo_inei` VALUES (1500, '15', '07', '03', 'CALLAHUANCA');
INSERT INTO `ubigeo_inei` VALUES (1501, '15', '07', '04', 'CARAMPOMA');
INSERT INTO `ubigeo_inei` VALUES (1502, '15', '07', '05', 'CHICLA');
INSERT INTO `ubigeo_inei` VALUES (1503, '15', '07', '06', 'CUENCA');
INSERT INTO `ubigeo_inei` VALUES (1504, '15', '07', '07', 'HUACHUPAMPA');
INSERT INTO `ubigeo_inei` VALUES (1505, '15', '07', '08', 'HUANZA');
INSERT INTO `ubigeo_inei` VALUES (1506, '15', '07', '09', 'HUAROCHIRI');
INSERT INTO `ubigeo_inei` VALUES (1507, '15', '07', '10', 'LAHUAYTAMBO');
INSERT INTO `ubigeo_inei` VALUES (1508, '15', '07', '11', 'LANGA');
INSERT INTO `ubigeo_inei` VALUES (1509, '15', '07', '12', 'LARAOS');
INSERT INTO `ubigeo_inei` VALUES (1510, '15', '07', '13', 'MARIATANA');
INSERT INTO `ubigeo_inei` VALUES (1511, '15', '07', '14', 'RICARDO PALMA');
INSERT INTO `ubigeo_inei` VALUES (1512, '15', '07', '15', 'SAN ANDRES DE TUPICOCHA');
INSERT INTO `ubigeo_inei` VALUES (1513, '15', '07', '16', 'SAN ANTONIO');
INSERT INTO `ubigeo_inei` VALUES (1514, '15', '07', '17', 'SAN BARTOLOME');
INSERT INTO `ubigeo_inei` VALUES (1515, '15', '07', '18', 'SAN DAMIAN');
INSERT INTO `ubigeo_inei` VALUES (1516, '15', '07', '19', 'SAN JUAN DE IRIS');
INSERT INTO `ubigeo_inei` VALUES (1517, '15', '07', '20', 'SAN JUAN DE TANTARANCHE');
INSERT INTO `ubigeo_inei` VALUES (1518, '15', '07', '21', 'SAN LORENZO DE QUINTI');
INSERT INTO `ubigeo_inei` VALUES (1519, '15', '07', '22', 'SAN MATEO');
INSERT INTO `ubigeo_inei` VALUES (1520, '15', '07', '23', 'SAN MATEO DE OTAO');
INSERT INTO `ubigeo_inei` VALUES (1521, '15', '07', '24', 'SAN PEDRO DE CASTA');
INSERT INTO `ubigeo_inei` VALUES (1522, '15', '07', '25', 'SAN PEDRO DE HUANCAYRE');
INSERT INTO `ubigeo_inei` VALUES (1523, '15', '07', '26', 'SANGALLAYA');
INSERT INTO `ubigeo_inei` VALUES (1524, '15', '07', '27', 'SANTA CRUZ DE COCACHACRA');
INSERT INTO `ubigeo_inei` VALUES (1525, '15', '07', '28', 'SANTA EULALIA');
INSERT INTO `ubigeo_inei` VALUES (1526, '15', '07', '29', 'SANTIAGO DE ANCHUCAYA');
INSERT INTO `ubigeo_inei` VALUES (1527, '15', '07', '30', 'SANTIAGO DE TUNA');
INSERT INTO `ubigeo_inei` VALUES (1528, '15', '07', '31', 'SANTO DOMINGO DE LOS OLLEROS');
INSERT INTO `ubigeo_inei` VALUES (1529, '15', '07', '32', 'SURCO');
INSERT INTO `ubigeo_inei` VALUES (1530, '15', '08', '00', 'HUAURA');
INSERT INTO `ubigeo_inei` VALUES (1531, '15', '08', '01', 'HUACHO');
INSERT INTO `ubigeo_inei` VALUES (1532, '15', '08', '02', 'AMBAR');
INSERT INTO `ubigeo_inei` VALUES (1533, '15', '08', '03', 'CALETA DE CARQUIN');
INSERT INTO `ubigeo_inei` VALUES (1534, '15', '08', '04', 'CHECRAS');
INSERT INTO `ubigeo_inei` VALUES (1535, '15', '08', '05', 'HUALMAY');
INSERT INTO `ubigeo_inei` VALUES (1536, '15', '08', '06', 'HUAURA');
INSERT INTO `ubigeo_inei` VALUES (1537, '15', '08', '07', 'LEONCIO PRADO');
INSERT INTO `ubigeo_inei` VALUES (1538, '15', '08', '08', 'PACCHO');
INSERT INTO `ubigeo_inei` VALUES (1539, '15', '08', '09', 'SANTA LEONOR');
INSERT INTO `ubigeo_inei` VALUES (1540, '15', '08', '10', 'SANTA MARIA');
INSERT INTO `ubigeo_inei` VALUES (1541, '15', '08', '11', 'SAYAN');
INSERT INTO `ubigeo_inei` VALUES (1542, '15', '08', '12', 'VEGUETA');
INSERT INTO `ubigeo_inei` VALUES (1543, '15', '09', '00', 'OYON');
INSERT INTO `ubigeo_inei` VALUES (1544, '15', '09', '01', 'OYON');
INSERT INTO `ubigeo_inei` VALUES (1545, '15', '09', '02', 'ANDAJES');
INSERT INTO `ubigeo_inei` VALUES (1546, '15', '09', '03', 'CAUJUL');
INSERT INTO `ubigeo_inei` VALUES (1547, '15', '09', '04', 'COCHAMARCA');
INSERT INTO `ubigeo_inei` VALUES (1548, '15', '09', '05', 'NAVAN');
INSERT INTO `ubigeo_inei` VALUES (1549, '15', '09', '06', 'PACHANGARA');
INSERT INTO `ubigeo_inei` VALUES (1550, '15', '10', '00', 'YAUYOS');
INSERT INTO `ubigeo_inei` VALUES (1551, '15', '10', '01', 'YAUYOS');
INSERT INTO `ubigeo_inei` VALUES (1552, '15', '10', '02', 'ALIS');
INSERT INTO `ubigeo_inei` VALUES (1553, '15', '10', '03', 'AYAUCA');
INSERT INTO `ubigeo_inei` VALUES (1554, '15', '10', '04', 'AYAVIRI');
INSERT INTO `ubigeo_inei` VALUES (1555, '15', '10', '05', 'AZANGARO');
INSERT INTO `ubigeo_inei` VALUES (1556, '15', '10', '06', 'CACRA');
INSERT INTO `ubigeo_inei` VALUES (1557, '15', '10', '07', 'CARANIA');
INSERT INTO `ubigeo_inei` VALUES (1558, '15', '10', '08', 'CATAHUASI');
INSERT INTO `ubigeo_inei` VALUES (1559, '15', '10', '09', 'CHOCOS');
INSERT INTO `ubigeo_inei` VALUES (1560, '15', '10', '10', 'COCHAS');
INSERT INTO `ubigeo_inei` VALUES (1561, '15', '10', '11', 'COLONIA');
INSERT INTO `ubigeo_inei` VALUES (1562, '15', '10', '12', 'HONGOS');
INSERT INTO `ubigeo_inei` VALUES (1563, '15', '10', '13', 'HUAMPARA');
INSERT INTO `ubigeo_inei` VALUES (1564, '15', '10', '14', 'HUANCAYA');
INSERT INTO `ubigeo_inei` VALUES (1565, '15', '10', '15', 'HUANGASCAR');
INSERT INTO `ubigeo_inei` VALUES (1566, '15', '10', '16', 'HUANTAN');
INSERT INTO `ubigeo_inei` VALUES (1567, '15', '10', '17', 'HUAÑEC');
INSERT INTO `ubigeo_inei` VALUES (1568, '15', '10', '18', 'LARAOS');
INSERT INTO `ubigeo_inei` VALUES (1569, '15', '10', '19', 'LINCHA');
INSERT INTO `ubigeo_inei` VALUES (1570, '15', '10', '20', 'MADEAN');
INSERT INTO `ubigeo_inei` VALUES (1571, '15', '10', '21', 'MIRAFLORES');
INSERT INTO `ubigeo_inei` VALUES (1572, '15', '10', '22', 'OMAS');
INSERT INTO `ubigeo_inei` VALUES (1573, '15', '10', '23', 'PUTINZA');
INSERT INTO `ubigeo_inei` VALUES (1574, '15', '10', '24', 'QUINCHES');
INSERT INTO `ubigeo_inei` VALUES (1575, '15', '10', '25', 'QUINOCAY');
INSERT INTO `ubigeo_inei` VALUES (1576, '15', '10', '26', 'SAN JOAQUIN');
INSERT INTO `ubigeo_inei` VALUES (1577, '15', '10', '27', 'SAN PEDRO DE PILAS');
INSERT INTO `ubigeo_inei` VALUES (1578, '15', '10', '28', 'TANTA');
INSERT INTO `ubigeo_inei` VALUES (1579, '15', '10', '29', 'TAURIPAMPA');
INSERT INTO `ubigeo_inei` VALUES (1580, '15', '10', '30', 'TOMAS');
INSERT INTO `ubigeo_inei` VALUES (1581, '15', '10', '31', 'TUPE');
INSERT INTO `ubigeo_inei` VALUES (1582, '15', '10', '32', 'VIÑAC');
INSERT INTO `ubigeo_inei` VALUES (1583, '15', '10', '33', 'VITIS');
INSERT INTO `ubigeo_inei` VALUES (1584, '16', '00', '00', 'LORETO');
INSERT INTO `ubigeo_inei` VALUES (1585, '16', '01', '00', 'MAYNAS');
INSERT INTO `ubigeo_inei` VALUES (1586, '16', '01', '01', 'IQUITOS');
INSERT INTO `ubigeo_inei` VALUES (1587, '16', '01', '02', 'ALTO NANAY');
INSERT INTO `ubigeo_inei` VALUES (1588, '16', '01', '03', 'FERNANDO LORES');
INSERT INTO `ubigeo_inei` VALUES (1589, '16', '01', '04', 'INDIANA');
INSERT INTO `ubigeo_inei` VALUES (1590, '16', '01', '05', 'LAS AMAZONAS');
INSERT INTO `ubigeo_inei` VALUES (1591, '16', '01', '06', 'MAZAN');
INSERT INTO `ubigeo_inei` VALUES (1592, '16', '01', '07', 'NAPO');
INSERT INTO `ubigeo_inei` VALUES (1593, '16', '01', '08', 'PUNCHANA');
INSERT INTO `ubigeo_inei` VALUES (1594, '16', '01', '09', 'PUTUMAYO');
INSERT INTO `ubigeo_inei` VALUES (1595, '16', '01', '10', 'TORRES CAUSANA');
INSERT INTO `ubigeo_inei` VALUES (1596, '16', '01', '12', 'BELÉN');
INSERT INTO `ubigeo_inei` VALUES (1597, '16', '01', '13', 'SAN JUAN BAUTISTA');
INSERT INTO `ubigeo_inei` VALUES (1598, '16', '01', '14', 'TENIENTE MANUEL CLAVERO');
INSERT INTO `ubigeo_inei` VALUES (1599, '16', '02', '00', 'ALTO AMAZONAS');
INSERT INTO `ubigeo_inei` VALUES (1600, '16', '02', '01', 'YURIMAGUAS');
INSERT INTO `ubigeo_inei` VALUES (1601, '16', '02', '02', 'BALSAPUERTO');
INSERT INTO `ubigeo_inei` VALUES (1602, '16', '02', '05', 'JEBEROS');
INSERT INTO `ubigeo_inei` VALUES (1603, '16', '02', '06', 'LAGUNAS');
INSERT INTO `ubigeo_inei` VALUES (1604, '16', '02', '10', 'SANTA CRUZ');
INSERT INTO `ubigeo_inei` VALUES (1605, '16', '02', '11', 'TENIENTE CESAR LOPEZ ROJAS');
INSERT INTO `ubigeo_inei` VALUES (1606, '16', '03', '00', 'LORETO');
INSERT INTO `ubigeo_inei` VALUES (1607, '16', '03', '01', 'NAUTA');
INSERT INTO `ubigeo_inei` VALUES (1608, '16', '03', '02', 'PARINARI');
INSERT INTO `ubigeo_inei` VALUES (1609, '16', '03', '03', 'TIGRE');
INSERT INTO `ubigeo_inei` VALUES (1610, '16', '03', '04', 'TROMPETEROS');
INSERT INTO `ubigeo_inei` VALUES (1611, '16', '03', '05', 'URARINAS');
INSERT INTO `ubigeo_inei` VALUES (1612, '16', '04', '00', 'MARISCAL RAMON CASTILLA');
INSERT INTO `ubigeo_inei` VALUES (1613, '16', '04', '01', 'RAMON CASTILLA');
INSERT INTO `ubigeo_inei` VALUES (1614, '16', '04', '02', 'PEBAS');
INSERT INTO `ubigeo_inei` VALUES (1615, '16', '04', '03', 'YAVARI');
INSERT INTO `ubigeo_inei` VALUES (1616, '16', '04', '04', 'SAN PABLO');
INSERT INTO `ubigeo_inei` VALUES (1617, '16', '05', '00', 'REQUENA');
INSERT INTO `ubigeo_inei` VALUES (1618, '16', '05', '01', 'REQUENA');
INSERT INTO `ubigeo_inei` VALUES (1619, '16', '05', '02', 'ALTO TAPICHE');
INSERT INTO `ubigeo_inei` VALUES (1620, '16', '05', '03', 'CAPELO');
INSERT INTO `ubigeo_inei` VALUES (1621, '16', '05', '04', 'EMILIO SAN MARTIN');
INSERT INTO `ubigeo_inei` VALUES (1622, '16', '05', '05', 'MAQUIA');
INSERT INTO `ubigeo_inei` VALUES (1623, '16', '05', '06', 'PUINAHUA');
INSERT INTO `ubigeo_inei` VALUES (1624, '16', '05', '07', 'SAQUENA');
INSERT INTO `ubigeo_inei` VALUES (1625, '16', '05', '08', 'SOPLIN');
INSERT INTO `ubigeo_inei` VALUES (1626, '16', '05', '09', 'TAPICHE');
INSERT INTO `ubigeo_inei` VALUES (1627, '16', '05', '10', 'JENARO HERRERA');
INSERT INTO `ubigeo_inei` VALUES (1628, '16', '05', '11', 'YAQUERANA');
INSERT INTO `ubigeo_inei` VALUES (1629, '16', '06', '00', 'UCAYALI');
INSERT INTO `ubigeo_inei` VALUES (1630, '16', '06', '01', 'CONTAMANA');
INSERT INTO `ubigeo_inei` VALUES (1631, '16', '06', '02', 'INAHUAYA');
INSERT INTO `ubigeo_inei` VALUES (1632, '16', '06', '03', 'PADRE MARQUEZ');
INSERT INTO `ubigeo_inei` VALUES (1633, '16', '06', '04', 'PAMPA HERMOSA');
INSERT INTO `ubigeo_inei` VALUES (1634, '16', '06', '05', 'SARAYACU');
INSERT INTO `ubigeo_inei` VALUES (1635, '16', '06', '06', 'VARGAS GUERRA');
INSERT INTO `ubigeo_inei` VALUES (1636, '16', '07', '00', 'DATEM DEL MARAÑÓN');
INSERT INTO `ubigeo_inei` VALUES (1637, '16', '07', '01', 'BARRANCA');
INSERT INTO `ubigeo_inei` VALUES (1638, '16', '07', '02', 'CAHUAPANAS');
INSERT INTO `ubigeo_inei` VALUES (1639, '16', '07', '03', 'MANSERICHE');
INSERT INTO `ubigeo_inei` VALUES (1640, '16', '07', '04', 'MORONA');
INSERT INTO `ubigeo_inei` VALUES (1641, '16', '07', '05', 'PASTAZA');
INSERT INTO `ubigeo_inei` VALUES (1642, '16', '07', '06', 'ANDOAS');
INSERT INTO `ubigeo_inei` VALUES (1643, '16', '08', '00', 'PUTUMAYO');
INSERT INTO `ubigeo_inei` VALUES (1644, '16', '08', '01', 'PUTUMAYO');
INSERT INTO `ubigeo_inei` VALUES (1645, '16', '08', '02', 'ROSA PANDURO');
INSERT INTO `ubigeo_inei` VALUES (1646, '16', '08', '03', 'TENIENTE MANUEL CLAVERO');
INSERT INTO `ubigeo_inei` VALUES (1647, '16', '08', '04', 'YAGUAS');
INSERT INTO `ubigeo_inei` VALUES (1648, '17', '00', '00', 'MADRE DE DIOS');
INSERT INTO `ubigeo_inei` VALUES (1649, '17', '01', '00', 'TAMBOPATA');
INSERT INTO `ubigeo_inei` VALUES (1650, '17', '01', '01', 'TAMBOPATA');
INSERT INTO `ubigeo_inei` VALUES (1651, '17', '01', '02', 'INAMBARI');
INSERT INTO `ubigeo_inei` VALUES (1652, '17', '01', '03', 'LAS PIEDRAS');
INSERT INTO `ubigeo_inei` VALUES (1653, '17', '01', '04', 'LABERINTO');
INSERT INTO `ubigeo_inei` VALUES (1654, '17', '02', '00', 'MANU');
INSERT INTO `ubigeo_inei` VALUES (1655, '17', '02', '01', 'MANU');
INSERT INTO `ubigeo_inei` VALUES (1656, '17', '02', '02', 'FITZCARRALD');
INSERT INTO `ubigeo_inei` VALUES (1657, '17', '02', '03', 'MADRE DE DIOS');
INSERT INTO `ubigeo_inei` VALUES (1658, '17', '02', '04', 'HUEPETUHE');
INSERT INTO `ubigeo_inei` VALUES (1659, '17', '03', '00', 'TAHUAMANU');
INSERT INTO `ubigeo_inei` VALUES (1660, '17', '03', '01', 'IÑAPARI');
INSERT INTO `ubigeo_inei` VALUES (1661, '17', '03', '02', 'IBERIA');
INSERT INTO `ubigeo_inei` VALUES (1662, '17', '03', '03', 'TAHUAMANU');
INSERT INTO `ubigeo_inei` VALUES (1663, '18', '00', '00', 'MOQUEGUA');
INSERT INTO `ubigeo_inei` VALUES (1664, '18', '01', '00', 'MARISCAL NIETO');
INSERT INTO `ubigeo_inei` VALUES (1665, '18', '01', '01', 'MOQUEGUA');
INSERT INTO `ubigeo_inei` VALUES (1666, '18', '01', '02', 'CARUMAS');
INSERT INTO `ubigeo_inei` VALUES (1667, '18', '01', '03', 'CUCHUMBAYA');
INSERT INTO `ubigeo_inei` VALUES (1668, '18', '01', '04', 'SAMEGUA');
INSERT INTO `ubigeo_inei` VALUES (1669, '18', '01', '05', 'SAN CRISTOBAL');
INSERT INTO `ubigeo_inei` VALUES (1670, '18', '01', '06', 'TORATA');
INSERT INTO `ubigeo_inei` VALUES (1671, '18', '02', '00', 'GENERAL SANCHEZ CERRO');
INSERT INTO `ubigeo_inei` VALUES (1672, '18', '02', '01', 'OMATE');
INSERT INTO `ubigeo_inei` VALUES (1673, '18', '02', '02', 'CHOJATA');
INSERT INTO `ubigeo_inei` VALUES (1674, '18', '02', '03', 'COALAQUE');
INSERT INTO `ubigeo_inei` VALUES (1675, '18', '02', '04', 'ICHUÑA');
INSERT INTO `ubigeo_inei` VALUES (1676, '18', '02', '05', 'LA CAPILLA');
INSERT INTO `ubigeo_inei` VALUES (1677, '18', '02', '06', 'LLOQUE');
INSERT INTO `ubigeo_inei` VALUES (1678, '18', '02', '07', 'MATALAQUE');
INSERT INTO `ubigeo_inei` VALUES (1679, '18', '02', '08', 'PUQUINA');
INSERT INTO `ubigeo_inei` VALUES (1680, '18', '02', '09', 'QUINISTAQUILLAS');
INSERT INTO `ubigeo_inei` VALUES (1681, '18', '02', '10', 'UBINAS');
INSERT INTO `ubigeo_inei` VALUES (1682, '18', '02', '11', 'YUNGA');
INSERT INTO `ubigeo_inei` VALUES (1683, '18', '03', '00', 'ILO');
INSERT INTO `ubigeo_inei` VALUES (1684, '18', '03', '01', 'ILO');
INSERT INTO `ubigeo_inei` VALUES (1685, '18', '03', '02', 'EL ALGARROBAL');
INSERT INTO `ubigeo_inei` VALUES (1686, '18', '03', '03', 'PACOCHA');
INSERT INTO `ubigeo_inei` VALUES (1687, '19', '00', '00', 'PASCO');
INSERT INTO `ubigeo_inei` VALUES (1688, '19', '01', '00', 'PASCO');
INSERT INTO `ubigeo_inei` VALUES (1689, '19', '01', '01', 'CHAUPIMARCA');
INSERT INTO `ubigeo_inei` VALUES (1690, '19', '01', '02', 'HUACHON');
INSERT INTO `ubigeo_inei` VALUES (1691, '19', '01', '03', 'HUARIACA');
INSERT INTO `ubigeo_inei` VALUES (1692, '19', '01', '04', 'HUAYLLAY');
INSERT INTO `ubigeo_inei` VALUES (1693, '19', '01', '05', 'NINACACA');
INSERT INTO `ubigeo_inei` VALUES (1694, '19', '01', '06', 'PALLANCHACRA');
INSERT INTO `ubigeo_inei` VALUES (1695, '19', '01', '07', 'PAUCARTAMBO');
INSERT INTO `ubigeo_inei` VALUES (1696, '19', '01', '08', 'SAN FCO. DE ASÍS DE YARUSYACÁN');
INSERT INTO `ubigeo_inei` VALUES (1697, '19', '01', '09', 'SIMON BOLIVAR');
INSERT INTO `ubigeo_inei` VALUES (1698, '19', '01', '10', 'TICLACAYAN');
INSERT INTO `ubigeo_inei` VALUES (1699, '19', '01', '11', 'TINYAHUARCO');
INSERT INTO `ubigeo_inei` VALUES (1700, '19', '01', '12', 'VICCO');
INSERT INTO `ubigeo_inei` VALUES (1701, '19', '01', '13', 'YANACANCHA');
INSERT INTO `ubigeo_inei` VALUES (1702, '19', '02', '00', 'DANIEL ALCIDES CARRION');
INSERT INTO `ubigeo_inei` VALUES (1703, '19', '02', '01', 'YANAHUANCA');
INSERT INTO `ubigeo_inei` VALUES (1704, '19', '02', '02', 'CHACAYAN');
INSERT INTO `ubigeo_inei` VALUES (1705, '19', '02', '03', 'GOYLLARISQUIZGA');
INSERT INTO `ubigeo_inei` VALUES (1706, '19', '02', '04', 'PAUCAR');
INSERT INTO `ubigeo_inei` VALUES (1707, '19', '02', '05', 'SAN PEDRO DE PILLAO');
INSERT INTO `ubigeo_inei` VALUES (1708, '19', '02', '06', 'SANTA ANA DE TUSI');
INSERT INTO `ubigeo_inei` VALUES (1709, '19', '02', '07', 'TAPUC');
INSERT INTO `ubigeo_inei` VALUES (1710, '19', '02', '08', 'VILCABAMBA');
INSERT INTO `ubigeo_inei` VALUES (1711, '19', '03', '00', 'OXAPAMPA');
INSERT INTO `ubigeo_inei` VALUES (1712, '19', '03', '01', 'OXAPAMPA');
INSERT INTO `ubigeo_inei` VALUES (1713, '19', '03', '02', 'CHONTABAMBA');
INSERT INTO `ubigeo_inei` VALUES (1714, '19', '03', '03', 'HUANCABAMBA');
INSERT INTO `ubigeo_inei` VALUES (1715, '19', '03', '04', 'PALCAZU');
INSERT INTO `ubigeo_inei` VALUES (1716, '19', '03', '05', 'POZUZO');
INSERT INTO `ubigeo_inei` VALUES (1717, '19', '03', '06', 'PUERTO BERMUDEZ');
INSERT INTO `ubigeo_inei` VALUES (1718, '19', '03', '07', 'VILLA RICA');
INSERT INTO `ubigeo_inei` VALUES (1719, '19', '03', '08', 'CONSTITUCION');
INSERT INTO `ubigeo_inei` VALUES (1720, '20', '00', '00', 'PIURA');
INSERT INTO `ubigeo_inei` VALUES (1721, '20', '01', '00', 'PIURA');
INSERT INTO `ubigeo_inei` VALUES (1722, '20', '01', '01', 'PIURA');
INSERT INTO `ubigeo_inei` VALUES (1723, '20', '01', '04', 'CASTILLA');
INSERT INTO `ubigeo_inei` VALUES (1724, '20', '01', '05', 'CATACAOS');
INSERT INTO `ubigeo_inei` VALUES (1725, '20', '01', '07', 'CURA MORI');
INSERT INTO `ubigeo_inei` VALUES (1726, '20', '01', '08', 'EL TALLAN');
INSERT INTO `ubigeo_inei` VALUES (1727, '20', '01', '09', 'LA ARENA');
INSERT INTO `ubigeo_inei` VALUES (1728, '20', '01', '10', 'LA UNION');
INSERT INTO `ubigeo_inei` VALUES (1729, '20', '01', '11', 'LAS LOMAS');
INSERT INTO `ubigeo_inei` VALUES (1730, '20', '01', '14', 'TAMBO GRANDE');
INSERT INTO `ubigeo_inei` VALUES (1731, '20', '01', '15', 'VEINTISÉIS DE OCTUBRE');
INSERT INTO `ubigeo_inei` VALUES (1732, '20', '02', '00', 'AYABACA');
INSERT INTO `ubigeo_inei` VALUES (1733, '20', '02', '01', 'AYABACA');
INSERT INTO `ubigeo_inei` VALUES (1734, '20', '02', '02', 'FRIAS');
INSERT INTO `ubigeo_inei` VALUES (1735, '20', '02', '03', 'JILILI');
INSERT INTO `ubigeo_inei` VALUES (1736, '20', '02', '04', 'LAGUNAS');
INSERT INTO `ubigeo_inei` VALUES (1737, '20', '02', '05', 'MONTERO');
INSERT INTO `ubigeo_inei` VALUES (1738, '20', '02', '06', 'PACAIPAMPA');
INSERT INTO `ubigeo_inei` VALUES (1739, '20', '02', '07', 'PAIMAS');
INSERT INTO `ubigeo_inei` VALUES (1740, '20', '02', '08', 'SAPILLICA');
INSERT INTO `ubigeo_inei` VALUES (1741, '20', '02', '09', 'SICCHEZ');
INSERT INTO `ubigeo_inei` VALUES (1742, '20', '02', '10', 'SUYO');
INSERT INTO `ubigeo_inei` VALUES (1743, '20', '03', '00', 'HUANCABAMBA');
INSERT INTO `ubigeo_inei` VALUES (1744, '20', '03', '01', 'HUANCABAMBA');
INSERT INTO `ubigeo_inei` VALUES (1745, '20', '03', '02', 'CANCHAQUE');
INSERT INTO `ubigeo_inei` VALUES (1746, '20', '03', '03', 'EL CARMEN DE LA FRONTERA');
INSERT INTO `ubigeo_inei` VALUES (1747, '20', '03', '04', 'HUARMACA');
INSERT INTO `ubigeo_inei` VALUES (1748, '20', '03', '05', 'LALAQUIZ');
INSERT INTO `ubigeo_inei` VALUES (1749, '20', '03', '06', 'SAN MIGUEL DE EL FAIQUE');
INSERT INTO `ubigeo_inei` VALUES (1750, '20', '03', '07', 'SONDOR');
INSERT INTO `ubigeo_inei` VALUES (1751, '20', '03', '08', 'SONDORILLO');
INSERT INTO `ubigeo_inei` VALUES (1752, '20', '04', '00', 'MORROPON');
INSERT INTO `ubigeo_inei` VALUES (1753, '20', '04', '01', 'CHULUCANAS');
INSERT INTO `ubigeo_inei` VALUES (1754, '20', '04', '02', 'BUENOS AIRES');
INSERT INTO `ubigeo_inei` VALUES (1755, '20', '04', '03', 'CHALACO');
INSERT INTO `ubigeo_inei` VALUES (1756, '20', '04', '04', 'LA MATANZA');
INSERT INTO `ubigeo_inei` VALUES (1757, '20', '04', '05', 'MORROPON');
INSERT INTO `ubigeo_inei` VALUES (1758, '20', '04', '06', 'SALITRAL');
INSERT INTO `ubigeo_inei` VALUES (1759, '20', '04', '07', 'SAN JUAN DE BIGOTE');
INSERT INTO `ubigeo_inei` VALUES (1760, '20', '04', '08', 'SANTA CATALINA DE MOSSA');
INSERT INTO `ubigeo_inei` VALUES (1761, '20', '04', '09', 'SANTO DOMINGO');
INSERT INTO `ubigeo_inei` VALUES (1762, '20', '04', '10', 'YAMANGO');
INSERT INTO `ubigeo_inei` VALUES (1763, '20', '05', '00', 'PAITA');
INSERT INTO `ubigeo_inei` VALUES (1764, '20', '05', '01', 'PAITA');
INSERT INTO `ubigeo_inei` VALUES (1765, '20', '05', '02', 'AMOTAPE');
INSERT INTO `ubigeo_inei` VALUES (1766, '20', '05', '03', 'ARENAL');
INSERT INTO `ubigeo_inei` VALUES (1767, '20', '05', '04', 'COLAN');
INSERT INTO `ubigeo_inei` VALUES (1768, '20', '05', '05', 'LA HUACA');
INSERT INTO `ubigeo_inei` VALUES (1769, '20', '05', '06', 'TAMARINDO');
INSERT INTO `ubigeo_inei` VALUES (1770, '20', '05', '07', 'VICHAYAL');
INSERT INTO `ubigeo_inei` VALUES (1771, '20', '06', '00', 'SULLANA');
INSERT INTO `ubigeo_inei` VALUES (1772, '20', '06', '01', 'SULLANA');
INSERT INTO `ubigeo_inei` VALUES (1773, '20', '06', '02', 'BELLAVISTA');
INSERT INTO `ubigeo_inei` VALUES (1774, '20', '06', '03', 'IGNACIO ESCUDERO');
INSERT INTO `ubigeo_inei` VALUES (1775, '20', '06', '04', 'LANCONES');
INSERT INTO `ubigeo_inei` VALUES (1776, '20', '06', '05', 'MARCAVELICA');
INSERT INTO `ubigeo_inei` VALUES (1777, '20', '06', '06', 'MIGUEL CHECA');
INSERT INTO `ubigeo_inei` VALUES (1778, '20', '06', '07', 'QUERECOTILLO');
INSERT INTO `ubigeo_inei` VALUES (1779, '20', '06', '08', 'SALITRAL');
INSERT INTO `ubigeo_inei` VALUES (1780, '20', '07', '00', 'TALARA');
INSERT INTO `ubigeo_inei` VALUES (1781, '20', '07', '01', 'PARIÑAS');
INSERT INTO `ubigeo_inei` VALUES (1782, '20', '07', '02', 'EL ALTO');
INSERT INTO `ubigeo_inei` VALUES (1783, '20', '07', '03', 'LA BREA');
INSERT INTO `ubigeo_inei` VALUES (1784, '20', '07', '04', 'LOBITOS');
INSERT INTO `ubigeo_inei` VALUES (1785, '20', '07', '05', 'LOS ORGANOS');
INSERT INTO `ubigeo_inei` VALUES (1786, '20', '07', '06', 'MANCORA');
INSERT INTO `ubigeo_inei` VALUES (1787, '20', '08', '00', 'SECHURA');
INSERT INTO `ubigeo_inei` VALUES (1788, '20', '08', '01', 'SECHURA');
INSERT INTO `ubigeo_inei` VALUES (1789, '20', '08', '02', 'BELLAVISTA DE LA UNION');
INSERT INTO `ubigeo_inei` VALUES (1790, '20', '08', '03', 'BERNAL');
INSERT INTO `ubigeo_inei` VALUES (1791, '20', '08', '04', 'CRISTO NOS VALGA');
INSERT INTO `ubigeo_inei` VALUES (1792, '20', '08', '05', 'VICE');
INSERT INTO `ubigeo_inei` VALUES (1793, '20', '08', '06', 'RINCONADA LLICUAR');
INSERT INTO `ubigeo_inei` VALUES (1794, '21', '00', '00', 'PUNO');
INSERT INTO `ubigeo_inei` VALUES (1795, '21', '01', '00', 'PUNO');
INSERT INTO `ubigeo_inei` VALUES (1796, '21', '01', '01', 'PUNO');
INSERT INTO `ubigeo_inei` VALUES (1797, '21', '01', '02', 'ACORA');
INSERT INTO `ubigeo_inei` VALUES (1798, '21', '01', '03', 'AMANTANI');
INSERT INTO `ubigeo_inei` VALUES (1799, '21', '01', '04', 'ATUNCOLLA');
INSERT INTO `ubigeo_inei` VALUES (1800, '21', '01', '05', 'CAPACHICA');
INSERT INTO `ubigeo_inei` VALUES (1801, '21', '01', '06', 'CHUCUITO');
INSERT INTO `ubigeo_inei` VALUES (1802, '21', '01', '07', 'COATA');
INSERT INTO `ubigeo_inei` VALUES (1803, '21', '01', '08', 'HUATA');
INSERT INTO `ubigeo_inei` VALUES (1804, '21', '01', '09', 'MAÑAZO');
INSERT INTO `ubigeo_inei` VALUES (1805, '21', '01', '10', 'PAUCARCOLLA');
INSERT INTO `ubigeo_inei` VALUES (1806, '21', '01', '11', 'PICHACANI');
INSERT INTO `ubigeo_inei` VALUES (1807, '21', '01', '12', 'PLATERIA');
INSERT INTO `ubigeo_inei` VALUES (1808, '21', '01', '13', 'SAN ANTONIO');
INSERT INTO `ubigeo_inei` VALUES (1809, '21', '01', '14', 'TIQUILLACA');
INSERT INTO `ubigeo_inei` VALUES (1810, '21', '01', '15', 'VILQUE');
INSERT INTO `ubigeo_inei` VALUES (1811, '21', '02', '00', 'AZANGARO');
INSERT INTO `ubigeo_inei` VALUES (1812, '21', '02', '01', 'AZANGARO');
INSERT INTO `ubigeo_inei` VALUES (1813, '21', '02', '02', 'ACHAYA');
INSERT INTO `ubigeo_inei` VALUES (1814, '21', '02', '03', 'ARAPA');
INSERT INTO `ubigeo_inei` VALUES (1815, '21', '02', '04', 'ASILLO');
INSERT INTO `ubigeo_inei` VALUES (1816, '21', '02', '05', 'CAMINACA');
INSERT INTO `ubigeo_inei` VALUES (1817, '21', '02', '06', 'CHUPA');
INSERT INTO `ubigeo_inei` VALUES (1818, '21', '02', '07', 'JOSE DOMINGO CHOQUEHUANCA');
INSERT INTO `ubigeo_inei` VALUES (1819, '21', '02', '08', 'MUÑANI');
INSERT INTO `ubigeo_inei` VALUES (1820, '21', '02', '09', 'POTONI');
INSERT INTO `ubigeo_inei` VALUES (1821, '21', '02', '10', 'SAMAN');
INSERT INTO `ubigeo_inei` VALUES (1822, '21', '02', '11', 'SAN ANTON');
INSERT INTO `ubigeo_inei` VALUES (1823, '21', '02', '12', 'SAN JOSE');
INSERT INTO `ubigeo_inei` VALUES (1824, '21', '02', '13', 'SAN JUAN DE SALINAS');
INSERT INTO `ubigeo_inei` VALUES (1825, '21', '02', '14', 'SANTIAGO DE PUPUJA');
INSERT INTO `ubigeo_inei` VALUES (1826, '21', '02', '15', 'TIRAPATA');
INSERT INTO `ubigeo_inei` VALUES (1827, '21', '03', '00', 'CARABAYA');
INSERT INTO `ubigeo_inei` VALUES (1828, '21', '03', '01', 'MACUSANI');
INSERT INTO `ubigeo_inei` VALUES (1829, '21', '03', '02', 'AJOYANI');
INSERT INTO `ubigeo_inei` VALUES (1830, '21', '03', '03', 'AYAPATA');
INSERT INTO `ubigeo_inei` VALUES (1831, '21', '03', '04', 'COASA');
INSERT INTO `ubigeo_inei` VALUES (1832, '21', '03', '05', 'CORANI');
INSERT INTO `ubigeo_inei` VALUES (1833, '21', '03', '06', 'CRUCERO');
INSERT INTO `ubigeo_inei` VALUES (1834, '21', '03', '07', 'ITUATA');
INSERT INTO `ubigeo_inei` VALUES (1835, '21', '03', '08', 'OLLACHEA');
INSERT INTO `ubigeo_inei` VALUES (1836, '21', '03', '09', 'SAN GABAN');
INSERT INTO `ubigeo_inei` VALUES (1837, '21', '03', '10', 'USICAYOS');
INSERT INTO `ubigeo_inei` VALUES (1838, '21', '04', '00', 'CHUCUITO');
INSERT INTO `ubigeo_inei` VALUES (1839, '21', '04', '01', 'JULI');
INSERT INTO `ubigeo_inei` VALUES (1840, '21', '04', '02', 'DESAGUADERO');
INSERT INTO `ubigeo_inei` VALUES (1841, '21', '04', '03', 'HUACULLANI');
INSERT INTO `ubigeo_inei` VALUES (1842, '21', '04', '04', 'KELLUYO');
INSERT INTO `ubigeo_inei` VALUES (1843, '21', '04', '05', 'PISACOMA');
INSERT INTO `ubigeo_inei` VALUES (1844, '21', '04', '06', 'POMATA');
INSERT INTO `ubigeo_inei` VALUES (1845, '21', '04', '07', 'ZEPITA');
INSERT INTO `ubigeo_inei` VALUES (1846, '21', '05', '00', 'EL COLLAO');
INSERT INTO `ubigeo_inei` VALUES (1847, '21', '05', '01', 'ILAVE');
INSERT INTO `ubigeo_inei` VALUES (1848, '21', '05', '02', 'CAPASO');
INSERT INTO `ubigeo_inei` VALUES (1849, '21', '05', '03', 'PILCUYO');
INSERT INTO `ubigeo_inei` VALUES (1850, '21', '05', '04', 'SANTA ROSA');
INSERT INTO `ubigeo_inei` VALUES (1851, '21', '05', '05', 'CONDURIRI');
INSERT INTO `ubigeo_inei` VALUES (1852, '21', '06', '00', 'HUANCANE');
INSERT INTO `ubigeo_inei` VALUES (1853, '21', '06', '01', 'HUANCANE');
INSERT INTO `ubigeo_inei` VALUES (1854, '21', '06', '02', 'COJATA');
INSERT INTO `ubigeo_inei` VALUES (1855, '21', '06', '03', 'HUATASANI');
INSERT INTO `ubigeo_inei` VALUES (1856, '21', '06', '04', 'INCHUPALLA');
INSERT INTO `ubigeo_inei` VALUES (1857, '21', '06', '05', 'PUSI');
INSERT INTO `ubigeo_inei` VALUES (1858, '21', '06', '06', 'ROSASPATA');
INSERT INTO `ubigeo_inei` VALUES (1859, '21', '06', '07', 'TARACO');
INSERT INTO `ubigeo_inei` VALUES (1860, '21', '06', '08', 'VILQUE CHICO');
INSERT INTO `ubigeo_inei` VALUES (1861, '21', '07', '00', 'LAMPA');
INSERT INTO `ubigeo_inei` VALUES (1862, '21', '07', '01', 'LAMPA');
INSERT INTO `ubigeo_inei` VALUES (1863, '21', '07', '02', 'CABANILLA');
INSERT INTO `ubigeo_inei` VALUES (1864, '21', '07', '03', 'CALAPUJA');
INSERT INTO `ubigeo_inei` VALUES (1865, '21', '07', '04', 'NICASIO');
INSERT INTO `ubigeo_inei` VALUES (1866, '21', '07', '05', 'OCUVIRI');
INSERT INTO `ubigeo_inei` VALUES (1867, '21', '07', '06', 'PALCA');
INSERT INTO `ubigeo_inei` VALUES (1868, '21', '07', '07', 'PARATIA');
INSERT INTO `ubigeo_inei` VALUES (1869, '21', '07', '08', 'PUCARA');
INSERT INTO `ubigeo_inei` VALUES (1870, '21', '07', '09', 'SANTA LUCIA');
INSERT INTO `ubigeo_inei` VALUES (1871, '21', '07', '10', 'VILAVILA');
INSERT INTO `ubigeo_inei` VALUES (1872, '21', '08', '00', 'MELGAR');
INSERT INTO `ubigeo_inei` VALUES (1873, '21', '08', '01', 'AYAVIRI');
INSERT INTO `ubigeo_inei` VALUES (1874, '21', '08', '02', 'ANTAUTA');
INSERT INTO `ubigeo_inei` VALUES (1875, '21', '08', '03', 'CUPI');
INSERT INTO `ubigeo_inei` VALUES (1876, '21', '08', '04', 'LLALLI');
INSERT INTO `ubigeo_inei` VALUES (1877, '21', '08', '05', 'MACARI');
INSERT INTO `ubigeo_inei` VALUES (1878, '21', '08', '06', 'NUÑOA');
INSERT INTO `ubigeo_inei` VALUES (1879, '21', '08', '07', 'ORURILLO');
INSERT INTO `ubigeo_inei` VALUES (1880, '21', '08', '08', 'SANTA ROSA');
INSERT INTO `ubigeo_inei` VALUES (1881, '21', '08', '09', 'UMACHIRI');
INSERT INTO `ubigeo_inei` VALUES (1882, '21', '09', '00', 'MOHO');
INSERT INTO `ubigeo_inei` VALUES (1883, '21', '09', '01', 'MOHO');
INSERT INTO `ubigeo_inei` VALUES (1884, '21', '09', '02', 'CONIMA');
INSERT INTO `ubigeo_inei` VALUES (1885, '21', '09', '03', 'HUAYRAPATA');
INSERT INTO `ubigeo_inei` VALUES (1886, '21', '09', '04', 'TILALI');
INSERT INTO `ubigeo_inei` VALUES (1887, '21', '10', '00', 'SAN ANTONIO DE PUTINA');
INSERT INTO `ubigeo_inei` VALUES (1888, '21', '10', '01', 'PUTINA');
INSERT INTO `ubigeo_inei` VALUES (1889, '21', '10', '02', 'ANANEA');
INSERT INTO `ubigeo_inei` VALUES (1890, '21', '10', '03', 'PEDRO VILCA APAZA');
INSERT INTO `ubigeo_inei` VALUES (1891, '21', '10', '04', 'QUILCAPUNCU');
INSERT INTO `ubigeo_inei` VALUES (1892, '21', '10', '05', 'SINA');
INSERT INTO `ubigeo_inei` VALUES (1893, '21', '11', '00', 'SAN ROMAN');
INSERT INTO `ubigeo_inei` VALUES (1894, '21', '11', '01', 'JULIACA');
INSERT INTO `ubigeo_inei` VALUES (1895, '21', '11', '02', 'CABANA');
INSERT INTO `ubigeo_inei` VALUES (1896, '21', '11', '03', 'CABANILLAS');
INSERT INTO `ubigeo_inei` VALUES (1897, '21', '11', '04', 'CARACOTO');
INSERT INTO `ubigeo_inei` VALUES (1898, '21', '12', '00', 'SANDIA');
INSERT INTO `ubigeo_inei` VALUES (1899, '21', '12', '01', 'SANDIA');
INSERT INTO `ubigeo_inei` VALUES (1900, '21', '12', '02', 'CUYOCUYO');
INSERT INTO `ubigeo_inei` VALUES (1901, '21', '12', '03', 'LIMBANI');
INSERT INTO `ubigeo_inei` VALUES (1902, '21', '12', '04', 'PATAMBUCO');
INSERT INTO `ubigeo_inei` VALUES (1903, '21', '12', '05', 'PHARA');
INSERT INTO `ubigeo_inei` VALUES (1904, '21', '12', '06', 'QUIACA');
INSERT INTO `ubigeo_inei` VALUES (1905, '21', '12', '07', 'SAN JUAN DEL ORO');
INSERT INTO `ubigeo_inei` VALUES (1906, '21', '12', '08', 'YANAHUAYA');
INSERT INTO `ubigeo_inei` VALUES (1907, '21', '12', '09', 'ALTO INAMBARI');
INSERT INTO `ubigeo_inei` VALUES (1908, '21', '12', '10', 'SAN PEDRO DE PUTINA PUNCO');
INSERT INTO `ubigeo_inei` VALUES (1909, '21', '13', '00', 'YUNGUYO');
INSERT INTO `ubigeo_inei` VALUES (1910, '21', '13', '01', 'YUNGUYO');
INSERT INTO `ubigeo_inei` VALUES (1911, '21', '13', '02', 'ANAPIA');
INSERT INTO `ubigeo_inei` VALUES (1912, '21', '13', '03', 'COPANI');
INSERT INTO `ubigeo_inei` VALUES (1913, '21', '13', '04', 'CUTURAPI');
INSERT INTO `ubigeo_inei` VALUES (1914, '21', '13', '05', 'OLLARAYA');
INSERT INTO `ubigeo_inei` VALUES (1915, '21', '13', '06', 'TINICACHI');
INSERT INTO `ubigeo_inei` VALUES (1916, '21', '13', '07', 'UNICACHI');
INSERT INTO `ubigeo_inei` VALUES (1917, '22', '00', '00', 'SAN MARTIN');
INSERT INTO `ubigeo_inei` VALUES (1918, '22', '01', '00', 'MOYOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (1919, '22', '01', '01', 'MOYOBAMBA');
INSERT INTO `ubigeo_inei` VALUES (1920, '22', '01', '02', 'CALZADA');
INSERT INTO `ubigeo_inei` VALUES (1921, '22', '01', '03', 'HABANA');
INSERT INTO `ubigeo_inei` VALUES (1922, '22', '01', '04', 'JEPELACIO');
INSERT INTO `ubigeo_inei` VALUES (1923, '22', '01', '05', 'SORITOR');
INSERT INTO `ubigeo_inei` VALUES (1924, '22', '01', '06', 'YANTALO');
INSERT INTO `ubigeo_inei` VALUES (1925, '22', '02', '00', 'BELLAVISTA');
INSERT INTO `ubigeo_inei` VALUES (1926, '22', '02', '01', 'BELLAVISTA');
INSERT INTO `ubigeo_inei` VALUES (1927, '22', '02', '02', 'ALTO BIAVO');
INSERT INTO `ubigeo_inei` VALUES (1928, '22', '02', '03', 'BAJO BIAVO');
INSERT INTO `ubigeo_inei` VALUES (1929, '22', '02', '04', 'HUALLAGA');
INSERT INTO `ubigeo_inei` VALUES (1930, '22', '02', '05', 'SAN PABLO');
INSERT INTO `ubigeo_inei` VALUES (1931, '22', '02', '06', 'SAN RAFAEL');
INSERT INTO `ubigeo_inei` VALUES (1932, '22', '03', '00', 'EL DORADO');
INSERT INTO `ubigeo_inei` VALUES (1933, '22', '03', '01', 'SAN JOSE DE SISA');
INSERT INTO `ubigeo_inei` VALUES (1934, '22', '03', '02', 'AGUA BLANCA');
INSERT INTO `ubigeo_inei` VALUES (1935, '22', '03', '03', 'SAN MARTIN');
INSERT INTO `ubigeo_inei` VALUES (1936, '22', '03', '04', 'SANTA ROSA');
INSERT INTO `ubigeo_inei` VALUES (1937, '22', '03', '05', 'SHATOJA');
INSERT INTO `ubigeo_inei` VALUES (1938, '22', '04', '00', 'HUALLAGA');
INSERT INTO `ubigeo_inei` VALUES (1939, '22', '04', '01', 'SAPOSOA');
INSERT INTO `ubigeo_inei` VALUES (1940, '22', '04', '02', 'ALTO SAPOSOA');
INSERT INTO `ubigeo_inei` VALUES (1941, '22', '04', '03', 'EL ESLABON');
INSERT INTO `ubigeo_inei` VALUES (1942, '22', '04', '04', 'PISCOYACU');
INSERT INTO `ubigeo_inei` VALUES (1943, '22', '04', '05', 'SACANCHE');
INSERT INTO `ubigeo_inei` VALUES (1944, '22', '04', '06', 'TINGO DE SAPOSOA');
INSERT INTO `ubigeo_inei` VALUES (1945, '22', '05', '00', 'LAMAS');
INSERT INTO `ubigeo_inei` VALUES (1946, '22', '05', '01', 'LAMAS');
INSERT INTO `ubigeo_inei` VALUES (1947, '22', '05', '02', 'ALONSO DE ALVARADO');
INSERT INTO `ubigeo_inei` VALUES (1948, '22', '05', '03', 'BARRANQUITA');
INSERT INTO `ubigeo_inei` VALUES (1949, '22', '05', '04', 'CAYNARACHI');
INSERT INTO `ubigeo_inei` VALUES (1950, '22', '05', '05', 'CUÑUMBUQUI');
INSERT INTO `ubigeo_inei` VALUES (1951, '22', '05', '06', 'PINTO RECODO');
INSERT INTO `ubigeo_inei` VALUES (1952, '22', '05', '07', 'RUMISAPA');
INSERT INTO `ubigeo_inei` VALUES (1953, '22', '05', '08', 'SAN ROQUE DE CUMBAZA');
INSERT INTO `ubigeo_inei` VALUES (1954, '22', '05', '09', 'SHANAO');
INSERT INTO `ubigeo_inei` VALUES (1955, '22', '05', '10', 'TABALOSOS');
INSERT INTO `ubigeo_inei` VALUES (1956, '22', '05', '11', 'ZAPATERO');
INSERT INTO `ubigeo_inei` VALUES (1957, '22', '06', '00', 'MARISCAL CACERES');
INSERT INTO `ubigeo_inei` VALUES (1958, '22', '06', '01', 'JUANJUI');
INSERT INTO `ubigeo_inei` VALUES (1959, '22', '06', '02', 'CAMPANILLA');
INSERT INTO `ubigeo_inei` VALUES (1960, '22', '06', '03', 'HUICUNGO');
INSERT INTO `ubigeo_inei` VALUES (1961, '22', '06', '04', 'PACHIZA');
INSERT INTO `ubigeo_inei` VALUES (1962, '22', '06', '05', 'PAJARILLO');
INSERT INTO `ubigeo_inei` VALUES (1963, '22', '07', '00', 'PICOTA');
INSERT INTO `ubigeo_inei` VALUES (1964, '22', '07', '01', 'PICOTA');
INSERT INTO `ubigeo_inei` VALUES (1965, '22', '07', '02', 'BUENOS AIRES');
INSERT INTO `ubigeo_inei` VALUES (1966, '22', '07', '03', 'CASPISAPA');
INSERT INTO `ubigeo_inei` VALUES (1967, '22', '07', '04', 'PILLUANA');
INSERT INTO `ubigeo_inei` VALUES (1968, '22', '07', '05', 'PUCACACA');
INSERT INTO `ubigeo_inei` VALUES (1969, '22', '07', '06', 'SAN CRISTOBAL');
INSERT INTO `ubigeo_inei` VALUES (1970, '22', '07', '07', 'SAN HILARION');
INSERT INTO `ubigeo_inei` VALUES (1971, '22', '07', '08', 'SHAMBOYACU');
INSERT INTO `ubigeo_inei` VALUES (1972, '22', '07', '09', 'TINGO DE PONASA');
INSERT INTO `ubigeo_inei` VALUES (1973, '22', '07', '10', 'TRES UNIDOS');
INSERT INTO `ubigeo_inei` VALUES (1974, '22', '08', '00', 'RIOJA');
INSERT INTO `ubigeo_inei` VALUES (1975, '22', '08', '01', 'RIOJA');
INSERT INTO `ubigeo_inei` VALUES (1976, '22', '08', '02', 'AWAJUN');
INSERT INTO `ubigeo_inei` VALUES (1977, '22', '08', '03', 'ELIAS SOPLIN VARGAS');
INSERT INTO `ubigeo_inei` VALUES (1978, '22', '08', '04', 'NUEVA CAJAMARCA');
INSERT INTO `ubigeo_inei` VALUES (1979, '22', '08', '05', 'PARDO MIGUEL');
INSERT INTO `ubigeo_inei` VALUES (1980, '22', '08', '06', 'POSIC');
INSERT INTO `ubigeo_inei` VALUES (1981, '22', '08', '07', 'SAN FERNANDO');
INSERT INTO `ubigeo_inei` VALUES (1982, '22', '08', '08', 'YORONGOS');
INSERT INTO `ubigeo_inei` VALUES (1983, '22', '08', '09', 'YURACYACU');
INSERT INTO `ubigeo_inei` VALUES (1984, '22', '09', '00', 'SAN MARTIN');
INSERT INTO `ubigeo_inei` VALUES (1985, '22', '09', '01', 'TARAPOTO');
INSERT INTO `ubigeo_inei` VALUES (1986, '22', '09', '02', 'ALBERTO LEVEAU');
INSERT INTO `ubigeo_inei` VALUES (1987, '22', '09', '03', 'CACATACHI');
INSERT INTO `ubigeo_inei` VALUES (1988, '22', '09', '04', 'CHAZUTA');
INSERT INTO `ubigeo_inei` VALUES (1989, '22', '09', '05', 'CHIPURANA');
INSERT INTO `ubigeo_inei` VALUES (1990, '22', '09', '06', 'EL PORVENIR');
INSERT INTO `ubigeo_inei` VALUES (1991, '22', '09', '07', 'HUIMBAYOC');
INSERT INTO `ubigeo_inei` VALUES (1992, '22', '09', '08', 'JUAN GUERRA');
INSERT INTO `ubigeo_inei` VALUES (1993, '22', '09', '09', 'LA BANDA DE SHILCAYO');
INSERT INTO `ubigeo_inei` VALUES (1994, '22', '09', '10', 'MORALES');
INSERT INTO `ubigeo_inei` VALUES (1995, '22', '09', '11', 'PAPAPLAYA');
INSERT INTO `ubigeo_inei` VALUES (1996, '22', '09', '12', 'SAN ANTONIO');
INSERT INTO `ubigeo_inei` VALUES (1997, '22', '09', '13', 'SAUCE');
INSERT INTO `ubigeo_inei` VALUES (1998, '22', '09', '14', 'SHAPAJA');
INSERT INTO `ubigeo_inei` VALUES (1999, '22', '10', '00', 'TOCACHE');
INSERT INTO `ubigeo_inei` VALUES (2000, '22', '10', '01', 'TOCACHE');
INSERT INTO `ubigeo_inei` VALUES (2001, '22', '10', '02', 'NUEVO PROGRESO');
INSERT INTO `ubigeo_inei` VALUES (2002, '22', '10', '03', 'POLVORA');
INSERT INTO `ubigeo_inei` VALUES (2003, '22', '10', '04', 'SHUNTE');
INSERT INTO `ubigeo_inei` VALUES (2004, '22', '10', '05', 'UCHIZA');
INSERT INTO `ubigeo_inei` VALUES (2005, '23', '00', '00', 'TACNA');
INSERT INTO `ubigeo_inei` VALUES (2006, '23', '01', '00', 'TACNA');
INSERT INTO `ubigeo_inei` VALUES (2007, '23', '01', '01', 'TACNA');
INSERT INTO `ubigeo_inei` VALUES (2008, '23', '01', '02', 'ALTO DE LA ALIANZA');
INSERT INTO `ubigeo_inei` VALUES (2009, '23', '01', '03', 'CALANA');
INSERT INTO `ubigeo_inei` VALUES (2010, '23', '01', '04', 'CIUDAD NUEVA');
INSERT INTO `ubigeo_inei` VALUES (2011, '23', '01', '05', 'INCLAN');
INSERT INTO `ubigeo_inei` VALUES (2012, '23', '01', '06', 'PACHIA');
INSERT INTO `ubigeo_inei` VALUES (2013, '23', '01', '07', 'PALCA');
INSERT INTO `ubigeo_inei` VALUES (2014, '23', '01', '08', 'POCOLLAY');
INSERT INTO `ubigeo_inei` VALUES (2015, '23', '01', '09', 'SAMA');
INSERT INTO `ubigeo_inei` VALUES (2016, '23', '01', '10', 'CORONEL GREGORIO ALBARRACÍN L');
INSERT INTO `ubigeo_inei` VALUES (2017, '23', '02', '00', 'CANDARAVE');
INSERT INTO `ubigeo_inei` VALUES (2018, '23', '02', '01', 'CANDARAVE');
INSERT INTO `ubigeo_inei` VALUES (2019, '23', '02', '02', 'CAIRANI');
INSERT INTO `ubigeo_inei` VALUES (2020, '23', '02', '03', 'CAMILACA');
INSERT INTO `ubigeo_inei` VALUES (2021, '23', '02', '04', 'CURIBAYA');
INSERT INTO `ubigeo_inei` VALUES (2022, '23', '02', '05', 'HUANUARA');
INSERT INTO `ubigeo_inei` VALUES (2023, '23', '02', '06', 'QUILAHUANI');
INSERT INTO `ubigeo_inei` VALUES (2024, '23', '03', '00', 'JORGE BASADRE');
INSERT INTO `ubigeo_inei` VALUES (2025, '23', '03', '01', 'LOCUMBA');
INSERT INTO `ubigeo_inei` VALUES (2026, '23', '03', '02', 'ILABAYA');
INSERT INTO `ubigeo_inei` VALUES (2027, '23', '03', '03', 'ITE');
INSERT INTO `ubigeo_inei` VALUES (2028, '23', '04', '00', 'TARATA');
INSERT INTO `ubigeo_inei` VALUES (2029, '23', '04', '01', 'TARATA');
INSERT INTO `ubigeo_inei` VALUES (2030, '23', '04', '02', 'CHUCATAMANI');
INSERT INTO `ubigeo_inei` VALUES (2031, '23', '04', '03', 'ESTIQUE');
INSERT INTO `ubigeo_inei` VALUES (2032, '23', '04', '04', 'ESTIQUE-PAMPA');
INSERT INTO `ubigeo_inei` VALUES (2033, '23', '04', '05', 'SITAJARA');
INSERT INTO `ubigeo_inei` VALUES (2034, '23', '04', '06', 'SUSAPAYA');
INSERT INTO `ubigeo_inei` VALUES (2035, '23', '04', '07', 'TARUCACHI');
INSERT INTO `ubigeo_inei` VALUES (2036, '23', '04', '08', 'TICACO');
INSERT INTO `ubigeo_inei` VALUES (2037, '24', '00', '00', 'TUMBES');
INSERT INTO `ubigeo_inei` VALUES (2038, '24', '01', '00', 'TUMBES');
INSERT INTO `ubigeo_inei` VALUES (2039, '24', '01', '01', 'TUMBES');
INSERT INTO `ubigeo_inei` VALUES (2040, '24', '01', '02', 'CORRALES');
INSERT INTO `ubigeo_inei` VALUES (2041, '24', '01', '03', 'LA CRUZ');
INSERT INTO `ubigeo_inei` VALUES (2042, '24', '01', '04', 'PAMPAS DE HOSPITAL');
INSERT INTO `ubigeo_inei` VALUES (2043, '24', '01', '05', 'SAN JACINTO');
INSERT INTO `ubigeo_inei` VALUES (2044, '24', '01', '06', 'SAN JUAN DE LA VIRGEN');
INSERT INTO `ubigeo_inei` VALUES (2045, '24', '02', '00', 'CONTRALMIRANTE VILLAR');
INSERT INTO `ubigeo_inei` VALUES (2046, '24', '02', '01', 'ZORRITOS');
INSERT INTO `ubigeo_inei` VALUES (2047, '24', '02', '02', 'CASITAS');
INSERT INTO `ubigeo_inei` VALUES (2048, '24', '02', '03', 'CANOAS DE PUNTA SAL');
INSERT INTO `ubigeo_inei` VALUES (2049, '24', '03', '00', 'ZARUMILLA');
INSERT INTO `ubigeo_inei` VALUES (2050, '24', '03', '01', 'ZARUMILLA');
INSERT INTO `ubigeo_inei` VALUES (2051, '24', '03', '02', 'AGUAS VERDES');
INSERT INTO `ubigeo_inei` VALUES (2052, '24', '03', '03', 'MATAPALO');
INSERT INTO `ubigeo_inei` VALUES (2053, '24', '03', '04', 'PAPAYAL');
INSERT INTO `ubigeo_inei` VALUES (2054, '25', '00', '00', 'UCAYALI');
INSERT INTO `ubigeo_inei` VALUES (2055, '25', '01', '00', 'CORONEL PORTILLO');
INSERT INTO `ubigeo_inei` VALUES (2056, '25', '01', '01', 'CALLARIA');
INSERT INTO `ubigeo_inei` VALUES (2057, '25', '01', '02', 'CAMPOVERDE');
INSERT INTO `ubigeo_inei` VALUES (2058, '25', '01', '03', 'IPARIA');
INSERT INTO `ubigeo_inei` VALUES (2059, '25', '01', '04', 'MASISEA');
INSERT INTO `ubigeo_inei` VALUES (2060, '25', '01', '05', 'YARINACOCHA');
INSERT INTO `ubigeo_inei` VALUES (2061, '25', '01', '06', 'NUEVA REQUENA');
INSERT INTO `ubigeo_inei` VALUES (2062, '25', '01', '07', 'MANANTAY');
INSERT INTO `ubigeo_inei` VALUES (2063, '25', '02', '00', 'ATALAYA');
INSERT INTO `ubigeo_inei` VALUES (2064, '25', '02', '01', 'RAYMONDI');
INSERT INTO `ubigeo_inei` VALUES (2065, '25', '02', '02', 'SEPAHUA');
INSERT INTO `ubigeo_inei` VALUES (2066, '25', '02', '03', 'TAHUANIA');
INSERT INTO `ubigeo_inei` VALUES (2067, '25', '02', '04', 'YURUA');
INSERT INTO `ubigeo_inei` VALUES (2068, '25', '03', '00', 'PADRE ABAD');
INSERT INTO `ubigeo_inei` VALUES (2069, '25', '03', '01', 'PADRE ABAD');
INSERT INTO `ubigeo_inei` VALUES (2070, '25', '03', '02', 'IRAZOLA');
INSERT INTO `ubigeo_inei` VALUES (2071, '25', '03', '03', 'CURIMANA');
INSERT INTO `ubigeo_inei` VALUES (2072, '25', '04', '00', 'PURUS');
INSERT INTO `ubigeo_inei` VALUES (2073, '25', '04', '01', 'PURUS');
INSERT INTO `ubigeo_inei` VALUES (2074, '99', '00', '00', 'EXTRANJERO');
INSERT INTO `ubigeo_inei` VALUES (2075, '99', '99', '00', 'EXTRANJERO');
INSERT INTO `ubigeo_inei` VALUES (2076, '99', '99', '99', 'EXTRANJERO');

-- ----------------------------
-- Table structure for unidades
-- ----------------------------
DROP TABLE IF EXISTS `unidades`;
CREATE TABLE `unidades`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `estado` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of unidades
-- ----------------------------
INSERT INTO `unidades` VALUES (1, 'UNIDAD', 'NIU', 'Unidad', '1', '2026-01-06 13:06:05', '2026-01-06 13:06:05');
INSERT INTO `unidades` VALUES (2, 'CAJA', 'BX', 'Caja', '1', '2026-01-06 13:06:05', '2026-01-06 13:06:05');
INSERT INTO `unidades` VALUES (3, 'PAQUETE', 'PK', 'Paquete', '1', '2026-01-06 13:06:05', '2026-01-06 13:06:05');
INSERT INTO `unidades` VALUES (4, 'KILOGRAMO', 'KGM', 'Kilogramo', '1', '2026-01-06 13:06:05', '2026-01-06 13:06:05');
INSERT INTO `unidades` VALUES (5, 'LITRO', 'LTR', 'Litro', '1', '2026-01-06 13:06:05', '2026-01-06 13:06:05');
INSERT INTO `unidades` VALUES (6, 'METRO', 'MTR', 'Metro', '1', '2026-01-06 13:06:05', '2026-01-06 13:06:05');
INSERT INTO `unidades` VALUES (7, 'JUEGO', 'SET', 'Juego o Set', '1', '2026-01-06 13:06:05', '2026-01-06 13:06:05');
INSERT INTO `unidades` VALUES (8, 'DOCENA', 'DZN', 'Docena', '1', '2026-01-06 13:06:05', '2026-01-06 13:06:05');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol_id` int NULL DEFAULT NULL COMMENT 'Rol del usuario',
  `id_empresa` int NULL DEFAULT NULL COMMENT 'Empresa del usuario',
  `num_doc` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'DNI o documento',
  `nombres` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `apellidos` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `telefono` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Activo, 0=Inactivo',
  `foto_perfil` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Ruta foto perfil',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE,
  INDEX `idx_rol`(`rol_id` ASC) USING BTREE,
  INDEX `idx_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `fk_users_rol`(`rol_id` ASC) USING BTREE,
  INDEX `fk_users_empresa`(`id_empresa` ASC) USING BTREE,
  CONSTRAINT `fk_users_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_users_rol` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Test User', 'test@example.com', 1, 1, '12345678', 'Administrador', 'Sistema', NULL, '1', NULL, '2026-01-06 13:01:58', '$2y$12$i8TQgyX4j4g8Ki6V/EAsiu5SpTwpbOY.eExFoOA8xoqLTy7v7fKGu', 'nJhRB8uy71', '2026-01-06 13:01:59', '2026-01-06 13:01:59');
INSERT INTO `users` VALUES (2, 'Administrador', 'admin@ilidesava.com', 1, 1, '12345678', 'Administrador', 'Sistema', NULL, '1', NULL, NULL, '$2y$12$okDNrzSC1Yat79SuILcmPOum/XwnRsu.mq/viZZvQgtrJOPlp/Qhu', NULL, '2026-01-06 08:07:15', '2026-01-06 08:07:15');

-- ----------------------------
-- Table structure for venta_empresa
-- ----------------------------
DROP TABLE IF EXISTS `venta_empresa`;
CREATE TABLE `venta_empresa`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venta` bigint UNSIGNED NOT NULL,
  `id_empresa` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id_venta`(`id_venta` ASC, `id_empresa` ASC) USING BTREE,
  INDEX `id_empresa`(`id_empresa` ASC) USING BTREE,
  CONSTRAINT `venta_empresa_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `venta_empresa_ibfk_2` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of venta_empresa
-- ----------------------------
INSERT INTO `venta_empresa` VALUES (1, 1, 3, '2026-01-19 15:44:32', '2026-01-19 15:44:32');
INSERT INTO `venta_empresa` VALUES (2, 1, 2, '2026-01-19 15:44:32', '2026-01-19 15:44:32');
INSERT INTO `venta_empresa` VALUES (3, 1, 1, '2026-01-19 15:44:32', '2026-01-19 15:44:32');
INSERT INTO `venta_empresa` VALUES (4, 2, 3, '2026-01-19 15:46:16', '2026-01-19 15:46:16');
INSERT INTO `venta_empresa` VALUES (5, 2, 2, '2026-01-19 15:46:16', '2026-01-19 15:46:16');
INSERT INTO `venta_empresa` VALUES (6, 3, 3, '2026-01-19 17:09:22', '2026-01-19 17:09:22');
INSERT INTO `venta_empresa` VALUES (7, 4, 3, '2026-01-19 22:19:17', '2026-01-19 22:19:17');
INSERT INTO `venta_empresa` VALUES (8, 4, 2, '2026-01-19 22:19:17', '2026-01-19 22:19:17');
INSERT INTO `venta_empresa` VALUES (9, 5, 3, '2026-02-06 14:19:38', '2026-02-06 14:19:38');
INSERT INTO `venta_empresa` VALUES (10, 7, 3, '2026-02-06 14:50:27', '2026-02-06 14:50:27');
INSERT INTO `venta_empresa` VALUES (11, 8, 3, '2026-02-06 14:51:32', '2026-02-06 14:51:32');

-- ----------------------------
-- Table structure for ventas
-- ----------------------------
DROP TABLE IF EXISTS `ventas`;
CREATE TABLE `ventas`  (
  `id_venta` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_tido` bigint UNSIGNED NOT NULL,
  `id_tipo_pago` bigint UNSIGNED NULL DEFAULT NULL,
  `afecta_stock` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_emision` date NULL DEFAULT NULL,
  `fecha_vencimiento` date NULL DEFAULT NULL,
  `dias_pagos` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `direccion` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `serie` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `numero` int NULL DEFAULT NULL,
  `id_cliente` bigint UNSIGNED NOT NULL,
  `total` decimal(10, 2) NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `num_cuotas` int NULL DEFAULT NULL,
  `monto_cuota` decimal(10, 2) NULL DEFAULT NULL,
  `num_op_tarjeta` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_empresa` bigint UNSIGNED NOT NULL,
  `hash_cpe` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mon_inafecto` decimal(10, 2) NULL DEFAULT NULL,
  `mon_exonerado` decimal(10, 2) NULL DEFAULT NULL,
  `mon_gratuito` decimal(10, 2) NULL DEFAULT NULL,
  `estado_sunat` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `codigo_sunat` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mensaje_sunat` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `intentos` int NULL DEFAULT NULL,
  `pdf_url` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `xml_url` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cdr_url` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `tipo_moneda` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PEN',
  `tipo_cambio` decimal(10, 4) NULL DEFAULT NULL,
  `descuento_global` decimal(10, 2) NULL DEFAULT NULL,
  `subtotal` decimal(10, 2) NULL DEFAULT NULL,
  `igv` decimal(10, 2) NULL DEFAULT NULL,
  `id_usuario` bigint UNSIGNED NULL DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_venta`) USING BTREE,
  INDEX `ventas_id_cliente_index`(`id_cliente` ASC) USING BTREE,
  INDEX `ventas_id_empresa_index`(`id_empresa` ASC) USING BTREE,
  INDEX `ventas_id_tido_index`(`id_tido` ASC) USING BTREE,
  INDEX `ventas_estado_index`(`estado` ASC) USING BTREE,
  INDEX `ventas_fecha_emision_index`(`fecha_emision` ASC) USING BTREE,
  INDEX `ventas_serie_numero_index`(`serie` ASC, `numero` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ventas
-- ----------------------------
INSERT INTO `ventas` VALUES (1, 6, NULL, 1, '2026-01-19', NULL, NULL, '', 'NV01', 1, 5, 141.60, '1', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 120.00, 21.60, 2, '2026-01-19 15:44:32', '2026-01-19 15:44:32', '2026-01-19 15:44:32');
INSERT INTO `ventas` VALUES (2, 6, NULL, 1, '2026-01-19', NULL, NULL, '', 'NV01', 2, 5, 287.33, '1', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 243.50, 43.83, 2, '2026-01-19 15:46:16', '2026-01-19 15:46:16', '2026-01-19 15:46:16');
INSERT INTO `ventas` VALUES (3, 6, NULL, 1, '2026-01-19', NULL, NULL, '', 'NV01', 3, 5, 148.68, '1', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 126.00, 22.68, 2, '2026-01-19 17:09:22', '2026-01-19 17:09:22', '2026-01-19 17:09:22');
INSERT INTO `ventas` VALUES (4, 6, NULL, 1, '2026-01-19', NULL, NULL, '', 'NV01', 4, 5, 171.40, '1', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 145.25, 26.15, 2, '2026-01-19 22:19:17', '2026-01-19 22:19:17', '2026-01-19 22:19:17');
INSERT INTO `ventas` VALUES (5, 6, NULL, 1, '2026-02-06', NULL, NULL, '', 'NV01', 5, 8, 7.08, '1', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 6.00, 1.08, 2, '2026-02-06 14:19:38', '2026-02-06 14:19:38', '2026-02-06 14:19:38');
INSERT INTO `ventas` VALUES (6, 6, NULL, 0, '2026-02-06', NULL, NULL, '', 'NV01', 6, 4, 7.08, '1', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 6.00, 1.08, 2, '2026-02-06 14:20:58', '2026-02-06 14:20:58', '2026-02-06 14:20:58');
INSERT INTO `ventas` VALUES (7, 6, NULL, 1, '2026-02-06', NULL, NULL, '', 'NV01', 7, 8, 7.08, '1', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 6.00, 1.08, 2, '2026-02-06 14:50:27', '2026-02-06 14:50:27', '2026-02-06 14:50:27');
INSERT INTO `ventas` VALUES (8, 6, NULL, 0, '2026-02-06', NULL, NULL, '', 'NV01', 8, 4, 7.08, '1', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 6.00, 1.08, 2, '2026-02-06 14:51:32', '2026-02-06 14:51:32', '2026-02-06 14:51:32');

-- ----------------------------
-- Table structure for ventas_anuladas
-- ----------------------------
DROP TABLE IF EXISTS `ventas_anuladas`;
CREATE TABLE `ventas_anuladas`  (
  `id_venta_anulada` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venta` bigint UNSIGNED NOT NULL,
  `id_usuario` bigint UNSIGNED NOT NULL,
  `motivo_anulacion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_anulacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `tipo_documento` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `serie` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` int NOT NULL,
  `total_anulado` decimal(10, 2) NOT NULL,
  `estado_comunicacion_baja` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `ticket_baja` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `codigo_respuesta_sunat` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mensaje_respuesta_sunat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `fecha_envio_sunat` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_venta_anulada`) USING BTREE,
  INDEX `ventas_anuladas_id_venta_index`(`id_venta` ASC) USING BTREE,
  INDEX `ventas_anuladas_id_usuario_index`(`id_usuario` ASC) USING BTREE,
  INDEX `ventas_anuladas_fecha_anulacion_index`(`fecha_anulacion` ASC) USING BTREE,
  CONSTRAINT `ventas_anuladas_id_venta_foreign` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ventas_anuladas
-- ----------------------------

-- ----------------------------
-- Table structure for ventas_equipos
-- ----------------------------
DROP TABLE IF EXISTS `ventas_equipos`;
CREATE TABLE `ventas_equipos`  (
  `id_venta_equipo` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venta` bigint UNSIGNED NOT NULL,
  `id_equipo` bigint UNSIGNED NULL DEFAULT NULL,
  `marca` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `modelo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `serie` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `accesorios` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `fallas_reportadas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `precio_servicio` decimal(10, 2) NULL DEFAULT NULL,
  `estado` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'P',
  `fecha_ingreso` date NULL DEFAULT NULL,
  `fecha_salida` date NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_venta_equipo`) USING BTREE,
  INDEX `ventas_equipos_id_venta_index`(`id_venta` ASC) USING BTREE,
  INDEX `ventas_equipos_id_equipo_index`(`id_equipo` ASC) USING BTREE,
  INDEX `ventas_equipos_estado_index`(`estado` ASC) USING BTREE,
  CONSTRAINT `ventas_equipos_id_venta_foreign` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ventas_equipos
-- ----------------------------

-- ----------------------------
-- Table structure for ventas_pagos
-- ----------------------------
DROP TABLE IF EXISTS `ventas_pagos`;
CREATE TABLE `ventas_pagos`  (
  `id_venta_pago` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venta` bigint UNSIGNED NOT NULL,
  `id_tipo_pago` bigint UNSIGNED NOT NULL,
  `monto` decimal(10, 2) NOT NULL,
  `numero_operacion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `fecha_pago` date NOT NULL,
  `banco` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `tipo_moneda` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PEN',
  `tipo_cambio` decimal(10, 4) NULL DEFAULT NULL,
  `monto_moneda_origen` decimal(10, 2) NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_venta_pago`) USING BTREE,
  INDEX `ventas_pagos_id_venta_index`(`id_venta` ASC) USING BTREE,
  INDEX `ventas_pagos_id_tipo_pago_index`(`id_tipo_pago` ASC) USING BTREE,
  INDEX `ventas_pagos_fecha_pago_index`(`fecha_pago` ASC) USING BTREE,
  CONSTRAINT `ventas_pagos_id_venta_foreign` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ventas_pagos
-- ----------------------------

-- ----------------------------
-- Table structure for ventas_servicios
-- ----------------------------
DROP TABLE IF EXISTS `ventas_servicios`;
CREATE TABLE `ventas_servicios`  (
  `id_venta_servicio` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venta` bigint UNSIGNED NOT NULL,
  `id_servicio` bigint UNSIGNED NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10, 2) NOT NULL,
  `subtotal` decimal(10, 2) NOT NULL,
  `igv` decimal(10, 2) NULL DEFAULT NULL,
  `total` decimal(10, 2) NOT NULL,
  `descuento` decimal(10, 2) NULL DEFAULT NULL,
  `unidad_medida` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ZZ',
  `tipo_afectacion_igv` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '10',
  `valor_unitario` decimal(10, 2) NULL DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `codigo_servicio` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_venta_servicio`) USING BTREE,
  INDEX `ventas_servicios_id_venta_index`(`id_venta` ASC) USING BTREE,
  INDEX `ventas_servicios_id_servicio_index`(`id_servicio` ASC) USING BTREE,
  CONSTRAINT `ventas_servicios_id_venta_foreign` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ventas_servicios
-- ----------------------------

-- ----------------------------
-- Table structure for ventas_sunat
-- ----------------------------
DROP TABLE IF EXISTS `ventas_sunat`;
CREATE TABLE `ventas_sunat`  (
  `id_venta_sunat` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venta` bigint UNSIGNED NOT NULL,
  `numero_documento` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_documento` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `serie` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` int NOT NULL,
  `xml_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cdr_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `hash_cpe` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `codigo_respuesta_sunat` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mensaje_respuesta_sunat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `estado_sunat` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `intentos_envio` int NOT NULL DEFAULT 0,
  `fecha_envio` timestamp NULL DEFAULT NULL,
  `fecha_respuesta` timestamp NULL DEFAULT NULL,
  `ticket_sunat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_venta_sunat`) USING BTREE,
  INDEX `ventas_sunat_id_venta_index`(`id_venta` ASC) USING BTREE,
  INDEX `ventas_sunat_tipo_documento_serie_numero_index`(`tipo_documento` ASC, `serie` ASC, `numero` ASC) USING BTREE,
  INDEX `ventas_sunat_estado_sunat_index`(`estado_sunat` ASC) USING BTREE,
  CONSTRAINT `ventas_sunat_id_venta_foreign` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ventas_sunat
-- ----------------------------

-- ----------------------------
-- View structure for view_clientes_completo
-- ----------------------------
DROP VIEW IF EXISTS `view_clientes_completo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_clientes_completo` AS select `c`.`id_cliente` AS `id_cliente`,`c`.`documento` AS `documento`,`c`.`datos` AS `datos`,`c`.`direccion` AS `direccion`,`c`.`direccion2` AS `direccion2`,`c`.`telefono` AS `telefono`,`c`.`telefono2` AS `telefono2`,`c`.`email` AS `email`,`c`.`ultima_venta` AS `ultima_venta`,`c`.`total_venta` AS `total_venta`,`c`.`ubigeo` AS `ubigeo`,`c`.`departamento` AS `departamento`,`c`.`provincia` AS `provincia`,`c`.`distrito` AS `distrito`,`e`.`id_empresa` AS `id_empresa`,`e`.`ruc` AS `empresa_ruc`,`e`.`razon_social` AS `empresa_razon_social`,`e`.`comercial` AS `empresa_comercial`,`c`.`created_at` AS `created_at`,`c`.`updated_at` AS `updated_at` from (`clientes` `c` join `empresas` `e` on(`c`.`id_empresa` = `e`.`id_empresa`));

-- ----------------------------
-- View structure for view_compras_detalle
-- ----------------------------
DROP VIEW IF EXISTS `view_compras_detalle`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_compras_detalle` AS select `c`.`id_compra` AS `id_compra`,`c`.`serie` AS `serie`,`c`.`numero` AS `numero`,concat(`c`.`serie`,'-',lpad(`c`.`numero`,8,'0')) AS `documento`,`c`.`fecha_emision` AS `fecha_emision`,`c`.`fecha_vencimiento` AS `fecha_vencimiento`,`c`.`id_proveedor` AS `id_proveedor`,`c`.`proveedor_id` AS `proveedor_id`,`p`.`ruc` AS `proveedor_ruc`,`p`.`razon_social` AS `proveedor_nombre`,`c`.`id_tipo_pago` AS `id_tipo_pago`,case when `c`.`id_tipo_pago` = 1 then 'Contado' when `c`.`id_tipo_pago` = 2 then 'Crédito' else 'Otro' end AS `tipo_pago_nombre`,`c`.`moneda` AS `moneda`,`c`.`subtotal` AS `subtotal`,`c`.`igv` AS `igv`,`c`.`total` AS `total`,`c`.`observaciones` AS `observaciones`,`c`.`id_empresa` AS `id_empresa`,`c`.`id_usuario` AS `id_usuario`,`c`.`estado` AS `estado`,case when `c`.`estado` = '1' then 'Activo' when `c`.`estado` = '0' then 'Anulado' else 'Desconocido' end AS `estado_nombre`,`c`.`created_at` AS `created_at`,`c`.`updated_at` AS `updated_at`,(select count(0) from `productos_compras` `pc` where `pc`.`id_compra` = `c`.`id_compra`) AS `total_productos`,(select count(0) from `dias_compras` `dc` where `dc`.`id_compra` = `c`.`id_compra`) AS `total_cuotas`,(select count(0) from `dias_compras` `dc` where `dc`.`id_compra` = `c`.`id_compra` and `dc`.`estado` = '1') AS `cuotas_pendientes`,(select count(0) from `dias_compras` `dc` where `dc`.`id_compra` = `c`.`id_compra` and `dc`.`estado` = '0') AS `cuotas_pagadas`,(select ifnull(sum(`dc`.`monto`),0) from `dias_compras` `dc` where `dc`.`id_compra` = `c`.`id_compra` and `dc`.`estado` = '1') AS `monto_pendiente`,(select ifnull(sum(`dc`.`monto`),0) from `dias_compras` `dc` where `dc`.`id_compra` = `c`.`id_compra` and `dc`.`estado` = '0') AS `monto_pagado` from (`compras` `c` left join `proveedores` `p` on(`c`.`proveedor_id` = `p`.`proveedor_id`)) order by `c`.`id_compra` desc;

-- ----------------------------
-- View structure for view_cotizaciones
-- ----------------------------
DROP VIEW IF EXISTS `view_cotizaciones`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_cotizaciones` AS select `c`.`id` AS `id`,`c`.`numero` AS `numero`,`c`.`fecha` AS `fecha`,`c`.`subtotal` AS `subtotal`,`c`.`igv` AS `igv`,`c`.`total` AS `total`,`c`.`descuento` AS `descuento`,`c`.`aplicar_igv` AS `aplicar_igv`,`c`.`moneda` AS `moneda`,`c`.`estado` AS `estado`,`c`.`asunto` AS `asunto`,`cl`.`documento` AS `cliente_documento`,`cl`.`datos` AS `cliente_nombre`,`cl`.`email` AS `cliente_email`,`cl`.`telefono` AS `cliente_telefono`,`u`.`name` AS `vendedor_nombre`,`u`.`email` AS `vendedor_email`,`c`.`id_empresa` AS `id_empresa`,`c`.`id_usuario` AS `id_usuario`,`c`.`created_at` AS `created_at`,`c`.`updated_at` AS `updated_at`,(select count(0) from `cotizacion_detalles` where `cotizacion_detalles`.`cotizacion_id` = `c`.`id`) AS `total_items` from ((`cotizaciones` `c` join `clientes` `cl` on(`c`.`id_cliente` = `cl`.`id_cliente`)) join `users` `u` on(`c`.`id_usuario` = `u`.`id`)) order by `c`.`id` desc;

-- ----------------------------
-- View structure for view_movimientos_stock_detalle
-- ----------------------------
DROP VIEW IF EXISTS `view_movimientos_stock_detalle`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_movimientos_stock_detalle` AS select `m`.`id_movimiento` AS `id_movimiento`,`m`.`id_producto` AS `id_producto`,`p`.`codigo` AS `producto_codigo`,`p`.`nombre` AS `producto_nombre`,`m`.`tipo_movimiento` AS `tipo_movimiento`,`m`.`cantidad` AS `cantidad`,`m`.`stock_anterior` AS `stock_anterior`,`m`.`stock_nuevo` AS `stock_nuevo`,`m`.`tipo_documento` AS `tipo_documento`,`m`.`id_documento` AS `id_documento`,`m`.`documento_referencia` AS `documento_referencia`,`m`.`motivo` AS `motivo`,`m`.`observaciones` AS `observaciones`,`m`.`id_almacen` AS `id_almacen`,`m`.`id_empresa` AS `id_empresa`,`m`.`id_usuario` AS `id_usuario`,`u`.`name` AS `usuario_nombre`,`m`.`fecha_movimiento` AS `fecha_movimiento`,`m`.`created_at` AS `created_at`,`m`.`updated_at` AS `updated_at` from ((`movimientos_stock` `m` left join `productos` `p` on(`m`.`id_producto` = `p`.`id_producto`)) left join `users` `u` on(`m`.`id_usuario` = `u`.`id`)) order by `m`.`fecha_movimiento` desc;

-- ----------------------------
-- View structure for view_pagos_pendientes
-- ----------------------------
DROP VIEW IF EXISTS `view_pagos_pendientes`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_pagos_pendientes` AS select `dc`.`dias_compra_id` AS `dias_compra_id`,`dc`.`id_compra` AS `id_compra`,`c`.`serie` AS `serie`,`c`.`numero` AS `numero`,concat(`c`.`serie`,'-',lpad(`c`.`numero`,8,'0')) AS `documento`,`c`.`id_proveedor` AS `id_proveedor`,`c`.`proveedor_id` AS `proveedor_id`,`p`.`ruc` AS `proveedor_ruc`,`p`.`razon_social` AS `proveedor_nombre`,`dc`.`monto` AS `monto`,`dc`.`fecha` AS `fecha_vencimiento`,`dc`.`estado` AS `estado`,case when `dc`.`estado` = '1' then 'Pendiente' when `dc`.`estado` = '0' then 'Pagado' else 'Desconocido' end AS `estado_nombre`,`dc`.`fecha_pago` AS `fecha_pago`,`c`.`moneda` AS `moneda`,`c`.`id_empresa` AS `id_empresa`,case when `dc`.`estado` = '1' and `dc`.`fecha` < curdate() then to_days(curdate()) - to_days(`dc`.`fecha`) else 0 end AS `dias_atraso`,case when `dc`.`estado` = '0' then 'Pagado' when `dc`.`estado` = '1' and `dc`.`fecha` < curdate() then 'Vencido' when `dc`.`estado` = '1' and `dc`.`fecha` = curdate() then 'Vence Hoy' when `dc`.`estado` = '1' and `dc`.`fecha` > curdate() then 'Por Vencer' else 'Desconocido' end AS `clasificacion` from ((`dias_compras` `dc` join `compras` `c` on(`dc`.`id_compra` = `c`.`id_compra`)) left join `proveedores` `p` on(`c`.`proveedor_id` = `p`.`proveedor_id`)) where `dc`.`estado` = '1' and `c`.`estado` = '1' order by `dc`.`fecha`;

-- ----------------------------
-- View structure for view_productos_1
-- ----------------------------
DROP VIEW IF EXISTS `view_productos_1`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_productos_1` AS select `p`.`id_producto` AS `id_producto`,`p`.`codigo` AS `codigo`,`p`.`cod_barra` AS `cod_barra`,`p`.`nombre` AS `nombre`,`p`.`descripcion` AS `descripcion`,`p`.`precio` AS `precio`,`p`.`costo` AS `costo`,`p`.`precio_mayor` AS `precio_mayor`,`p`.`precio_menor` AS `precio_menor`,`p`.`precio_unidad` AS `precio_unidad`,`p`.`cantidad` AS `cantidad`,`p`.`stock_minimo` AS `stock_minimo`,`p`.`stock_maximo` AS `stock_maximo`,`p`.`id_empresa` AS `id_empresa`,`p`.`almacen` AS `almacen`,`p`.`codsunat` AS `codsunat`,`p`.`usar_barra` AS `usar_barra`,`p`.`usar_multiprecio` AS `usar_multiprecio`,`p`.`moneda` AS `moneda`,`p`.`estado` AS `estado`,`p`.`imagen` AS `imagen`,`p`.`ultima_salida` AS `ultima_salida`,`p`.`fecha_registro` AS `fecha_registro`,`p`.`fecha_ultimo_ingreso` AS `fecha_ultimo_ingreso`,`c`.`nombre` AS `categoria`,`u`.`nombre` AS `unidad`,`u`.`codigo` AS `unidad_codigo` from ((`productos` `p` left join `categorias` `c` on(`c`.`id` = `p`.`categoria_id`)) left join `unidades` `u` on(`u`.`id` = `p`.`unidad_id`)) where `p`.`almacen` = '1' and `p`.`estado` = '1' order by `p`.`id_producto` desc;

-- ----------------------------
-- View structure for view_productos_2
-- ----------------------------
DROP VIEW IF EXISTS `view_productos_2`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_productos_2` AS select `p`.`id_producto` AS `id_producto`,`p`.`codigo` AS `codigo`,`p`.`cod_barra` AS `cod_barra`,`p`.`nombre` AS `nombre`,`p`.`descripcion` AS `descripcion`,`p`.`precio` AS `precio`,`p`.`costo` AS `costo`,`p`.`precio_mayor` AS `precio_mayor`,`p`.`precio_menor` AS `precio_menor`,`p`.`precio_unidad` AS `precio_unidad`,`p`.`cantidad` AS `cantidad`,`p`.`stock_minimo` AS `stock_minimo`,`p`.`stock_maximo` AS `stock_maximo`,`p`.`id_empresa` AS `id_empresa`,`p`.`almacen` AS `almacen`,`p`.`codsunat` AS `codsunat`,`p`.`usar_barra` AS `usar_barra`,`p`.`usar_multiprecio` AS `usar_multiprecio`,`p`.`moneda` AS `moneda`,`p`.`estado` AS `estado`,`p`.`imagen` AS `imagen`,`p`.`ultima_salida` AS `ultima_salida`,`p`.`fecha_registro` AS `fecha_registro`,`p`.`fecha_ultimo_ingreso` AS `fecha_ultimo_ingreso`,`c`.`nombre` AS `categoria`,`u`.`nombre` AS `unidad`,`u`.`codigo` AS `unidad_codigo` from ((`productos` `p` left join `categorias` `c` on(`c`.`id` = `p`.`categoria_id`)) left join `unidades` `u` on(`u`.`id` = `p`.`unidad_id`)) where `p`.`almacen` = '2' and `p`.`estado` = '1' order by `p`.`id_producto` desc;

-- ----------------------------
-- View structure for view_proveedores_activos
-- ----------------------------
DROP VIEW IF EXISTS `view_proveedores_activos`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_proveedores_activos` AS select `p`.`proveedor_id` AS `proveedor_id`,`p`.`ruc` AS `ruc`,`p`.`razon_social` AS `razon_social`,`p`.`direccion` AS `direccion`,`p`.`telefono` AS `telefono`,`p`.`email` AS `email`,`p`.`id_empresa` AS `id_empresa`,`p`.`departamento` AS `departamento`,`p`.`provincia` AS `provincia`,`p`.`distrito` AS `distrito`,`p`.`ubigeo` AS `ubigeo`,`p`.`estado` AS `estado`,`p`.`fecha_create` AS `fecha_create`,`p`.`created_at` AS `created_at`,`p`.`updated_at` AS `updated_at`,concat_ws(', ',nullif(`p`.`distrito`,''),nullif(`p`.`provincia`,''),nullif(`p`.`departamento`,'')) AS `ubicacion_completa`,(select count(0) from `compras` `c` where `c`.`proveedor_id` = `p`.`proveedor_id` and `c`.`estado` = '1') AS `total_compras`,(select ifnull(sum(`c`.`total`),0) from `compras` `c` where `c`.`proveedor_id` = `p`.`proveedor_id` and `c`.`estado` = '1') AS `total_comprado` from `proveedores` `p` where `p`.`estado` = 1 order by `p`.`razon_social`;

-- ----------------------------
-- View structure for view_usuarios_completo
-- ----------------------------
DROP VIEW IF EXISTS `view_usuarios_completo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_usuarios_completo` AS select `u`.`id` AS `id`,`u`.`name` AS `name`,`u`.`email` AS `email`,`u`.`num_doc` AS `num_doc`,`u`.`nombres` AS `nombres`,`u`.`apellidos` AS `apellidos`,`u`.`telefono` AS `telefono`,`u`.`estado` AS `estado`,`u`.`foto_perfil` AS `foto_perfil`,`r`.`rol_id` AS `rol_id`,`r`.`nombre` AS `rol_nombre`,`r`.`ver_precios` AS `ver_precios`,`r`.`puede_eliminar` AS `puede_eliminar`,`e`.`id_empresa` AS `id_empresa`,`e`.`ruc` AS `ruc`,`e`.`razon_social` AS `razon_social`,`e`.`comercial` AS `comercial`,`u`.`created_at` AS `created_at`,`u`.`updated_at` AS `updated_at` from ((`users` `u` left join `roles` `r` on(`u`.`rol_id` = `r`.`rol_id`)) left join `empresas` `e` on(`u`.`id_empresa` = `e`.`id_empresa`));

-- ----------------------------
-- Triggers structure for table clientes
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_clientes_before_insert`;
delimiter ;;
CREATE TRIGGER `trg_clientes_before_insert` BEFORE INSERT ON `clientes` FOR EACH ROW BEGIN
  IF NEW.created_at IS NULL THEN
    SET NEW.created_at = NOW();
  END IF;
  IF NEW.updated_at IS NULL THEN
    SET NEW.updated_at = NOW();
  END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table clientes
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_clientes_before_update`;
delimiter ;;
CREATE TRIGGER `trg_clientes_before_update` BEFORE UPDATE ON `clientes` FOR EACH ROW BEGIN
  SET NEW.updated_at = NOW();
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
