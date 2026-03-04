/*
 Navicat Premium Dump SQL

 Source Server         : localhist
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : factura_santod

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 04/03/2026 14:38:08
*/

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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categorias
-- ----------------------------
INSERT INTO `categorias` VALUES (1, 'ART ESCOLAR', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (2, 'CLIP', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (3, 'JUGUETE', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (4, 'REPELENTE', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (5, 'MOTOS', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (6, 'ASIENTO', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (7, 'TERMO', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (8, 'ART HOGAR', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (9, 'LLAVERO', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (10, 'ADORNO', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (11, 'CONSOLA', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (12, 'VENTILADOR', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (13, 'SILICONA', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (14, 'ART BEBE', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (15, 'TECNOLOGIA', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (16, 'ART CARRO', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (17, 'ART FIESTA', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (18, 'MOMEDIC', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (19, 'MONEDERO', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (20, 'MORRAL', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (21, 'CARTERA', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (22, 'MOCHILA', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (23, 'MOCHILAS', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (24, 'TRIMOTO', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (25, 'CASACA', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (26, 'CLIP BUBU', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (27, 'GUANTES', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (28, 'TECLA', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (29, 'PARLANTE', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (30, 'CAMARA', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (31, 'RELOJ', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (32, 'AUDIFONO', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (33, 'ESPEJO', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (34, 'PARAGUAS', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (35, 'ART. ESCOLAR', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (36, 'PELUCHES', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (37, 'HOGAR', NULL, '1', '2026-02-27 18:02:12', '2026-02-27 18:02:12');
INSERT INTO `categorias` VALUES (38, 'BRAZALETE', NULL, '1', '2026-02-27 18:02:13', '2026-02-27 18:02:13');
INSERT INTO `categorias` VALUES (39, 'PASTILLAS', NULL, '1', '2026-02-27 18:02:13', '2026-02-27 18:02:13');
INSERT INTO `categorias` VALUES (40, 'SNDALIAS', NULL, '1', '2026-02-27 18:02:13', '2026-02-27 18:02:13');
INSERT INTO `categorias` VALUES (41, 'CEPILLO', NULL, '1', '2026-02-27 18:02:13', '2026-02-27 18:02:13');
INSERT INTO `categorias` VALUES (42, 'ANDADOR', NULL, '1', '2026-02-27 18:02:13', '2026-02-27 18:02:13');
INSERT INTO `categorias` VALUES (43, 'JGTE', NULL, '1', '2026-02-27 18:02:13', '2026-02-27 18:02:13');
INSERT INTO `categorias` VALUES (44, 'LEGO', NULL, '1', '2026-02-27 18:02:13', '2026-02-27 18:02:13');
INSERT INTO `categorias` VALUES (45, 'ESCOLAR', NULL, '1', '2026-02-27 18:02:13', '2026-02-27 18:02:13');
INSERT INTO `categorias` VALUES (46, 'PELUCHE', NULL, '1', '2026-02-27 18:02:13', '2026-02-27 18:02:13');
INSERT INTO `categorias` VALUES (47, 'AUDIFONOS', NULL, '1', '2026-02-27 18:02:13', '2026-02-27 18:02:13');
INSERT INTO `categorias` VALUES (48, 'LLAVEROS', NULL, '1', '2026-02-27 18:02:13', '2026-02-27 18:02:13');
INSERT INTO `categorias` VALUES (49, 'Repuestos', NULL, '1', '2026-02-27 18:06:07', '2026-02-27 18:06:07');
INSERT INTO `categorias` VALUES (50, 'VARIOS', NULL, '1', '2026-03-02 16:17:22', '2026-03-02 16:17:22');

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
  `documento` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_doc` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
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
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of clientes
-- ----------------------------
INSERT INTO `clientes` VALUES (4, '20608300393', '6', 'COMPAÑIA FOOD RETAIL S.A.C.', 'CAL. CESAR MORELLI NRO. 181 URB. SAN BORJA NORTE LIMA LIMA SAN BORJA', NULL, NULL, NULL, NULL, 1, NULL, 0.00, '15', NULL, NULL, NULL, '2026-01-06 17:25:33', '2026-03-04 12:36:22');
INSERT INTO `clientes` VALUES (5, '77425200', '1', 'EMER RODRIGO YARLEQUE ZAPATA', NULL, NULL, '+51 993 321 920', NULL, 'kiyotakahitori@gmail.com', 1, NULL, 0.00, NULL, NULL, NULL, NULL, '2026-01-06 17:25:53', '2026-03-04 12:36:22');
INSERT INTO `clientes` VALUES (8, '20100128056', '6', 'SAGA FALABELLA S A', 'AV. PASEO DE LA REPUBLICA NRO. 3220 URB. JARDIN LIMA LIMA SAN ISIDRO', NULL, NULL, NULL, NULL, 1, NULL, 0.00, '150131', 'LIMA', 'LIMA', 'SAN ISIDRO', '2026-01-06 17:42:01', '2026-03-04 12:36:22');
INSERT INTO `clientes` VALUES (9, '77426190', '1', 'CLAUDIA NAOMI OQUENDO JUAREZ', '', NULL, NULL, NULL, NULL, 2, NULL, 0.00, NULL, NULL, NULL, NULL, '2026-02-28 15:12:11', '2026-03-04 12:36:22');
INSERT INTO `clientes` VALUES (10, '10774252008', '6', 'YARLEQUE ZAPATA EMER RODRIGO', '', NULL, NULL, NULL, NULL, 2, NULL, 0.00, NULL, NULL, NULL, NULL, '2026-03-02 17:10:12', '2026-03-04 12:36:22');
INSERT INTO `clientes` VALUES (11, '77425200', '1', 'EMER RODRIGO YARLEQUE ZAPATA', '', NULL, NULL, NULL, NULL, 3, NULL, 0.00, NULL, NULL, NULL, NULL, '2026-03-04 12:24:29', '2026-03-04 12:36:22');
INSERT INTO `clientes` VALUES (12, '00000000', '1', 'CLIENTES VARIOS', '', NULL, NULL, NULL, NULL, 3, NULL, 0.00, NULL, NULL, NULL, NULL, '2026-03-04 13:39:05', '2026-03-04 12:36:22');
INSERT INTO `clientes` VALUES (13, '', NULL, 'EMER CLIUS', '', NULL, NULL, NULL, NULL, 3, NULL, 0.00, NULL, NULL, NULL, NULL, '2026-03-04 16:20:18', '2026-03-04 12:36:22');
INSERT INTO `clientes` VALUES (14, '576756765756', '4', 'emesdffsdv', 'fbdsbfbfsd', NULL, NULL, NULL, NULL, 3, NULL, 0.00, NULL, NULL, NULL, NULL, '2026-03-04 16:53:57', '2026-03-04 12:36:22');
INSERT INTO `clientes` VALUES (15, '455464', '4', 'jorhe', 'vcscvsacsa', NULL, NULL, NULL, NULL, 3, NULL, 0.00, NULL, NULL, NULL, NULL, '2026-03-04 17:16:41', '2026-03-04 12:36:22');
INSERT INTO `clientes` VALUES (16, '534656756756', '4', 'fgnfn', 'gfnhgnngfnghf', NULL, NULL, NULL, NULL, 3, NULL, 0.00, NULL, NULL, NULL, NULL, '2026-03-04 17:45:07', '2026-03-04 17:45:07');
INSERT INTO `clientes` VALUES (17, '77425200', '1', 'EMER RODRIGO YARLEQUE ZAPATA', '', NULL, NULL, NULL, NULL, 4, NULL, 0.00, NULL, NULL, NULL, NULL, '2026-03-04 17:59:01', '2026-03-04 17:59:01');
INSERT INTO `clientes` VALUES (18, '456456544', '4', 'wefghfgd', '', NULL, NULL, NULL, NULL, 4, NULL, 0.00, NULL, NULL, NULL, NULL, '2026-03-04 17:59:15', '2026-03-04 17:59:15');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of compra_empresa
-- ----------------------------

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
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of compras
-- ----------------------------
INSERT INTO `compras` VALUES (1, 2, 'F001', '21', 5, 5, '2026-03-04', '2026-03-04', NULL, 1, 'PEN', 231.00, 0.00, 231.00, '', '', 2, 2, 1, '1', '2026-03-04 05:46:03', '2026-03-04 05:46:03');

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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_cotizacion`(`cotizacion_id` ASC) USING BTREE,
  CONSTRAINT `fk_cotizacion_cuotas_cotizacion` FOREIGN KEY (`cotizacion_id`) REFERENCES `cotizaciones` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_cotizacion`(`cotizacion_id` ASC) USING BTREE,
  INDEX `idx_producto`(`producto_id` ASC) USING BTREE,
  CONSTRAINT `fk_cotizacion_detalles_cotizacion` FOREIGN KEY (`cotizacion_id`) REFERENCES `cotizaciones` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cotizacion_detalles
-- ----------------------------
INSERT INTO `cotizacion_detalles` VALUES (4, 4, 162, 'PROD-001', 'prueba', 'prueba', 1.00, 15.00000, NULL, 15.00, '2026-02-28 10:05:38');
INSERT INTO `cotizacion_detalles` VALUES (5, 5, 161, '2L', 'JARRA ELECTRICA 2 LT X 16 PCS', 'JARRA ELECTRICA 2 LT X 16 PCS', 1.00, 1.00000, NULL, 1.00, '2026-02-28 10:12:11');
INSERT INTO `cotizacion_detalles` VALUES (6, 6, 628, 'ZMVSC020-16', 'BICICLETA SPIDERMAN ARO 16 X 12', 'BICICLETA SPIDERMAN ARO 16 X 12', 1.00, 110.00000, NULL, 110.00, '2026-03-02 11:17:53');
INSERT INTO `cotizacion_detalles` VALUES (7, 7, 628, 'ZMVSC020-16', 'BICICLETA SPIDERMAN ARO 16 X 12', 'BICICLETA SPIDERMAN ARO 16 X 12', 1.00, 110.00000, NULL, 110.00, '2026-03-02 12:10:12');
INSERT INTO `cotizacion_detalles` VALUES (9, 8, 627, 'ZDNSC033-16', 'BICICLETA MICKEY ARO 16 X 12', 'BICICLETA MICKEY ARO 16 X 12', 1.00, 110.00000, NULL, 110.00, '2026-03-04 00:47:28');

-- ----------------------------
-- Table structure for cotizaciones
-- ----------------------------
DROP TABLE IF EXISTS `cotizaciones`;
CREATE TABLE `cotizaciones`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `numero` int NULL DEFAULT NULL COMMENT 'Número correlativo de cotización',
  `fecha` date NOT NULL,
  `id_cliente` bigint UNSIGNED NULL DEFAULT NULL,
  `cliente_nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_cliente`(`id_cliente` ASC) USING BTREE,
  INDEX `idx_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `idx_usuario`(`id_usuario` ASC) USING BTREE,
  INDEX `idx_fecha`(`fecha` ASC) USING BTREE,
  INDEX `idx_estado`(`estado` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cotizaciones
-- ----------------------------
INSERT INTO `cotizaciones` VALUES (4, 1, '2026-02-28', 5, NULL, NULL, 12.71, 2.29, 15.00, 0.00, 1, 'PEN', 1.0000, NULL, NULL, NULL, 'pendiente', 1, 2, '2026-02-28 15:05:38', '2026-02-28 15:05:38');
INSERT INTO `cotizaciones` VALUES (5, 1, '2026-02-28', 9, NULL, NULL, 0.85, 0.15, 1.00, 0.00, 1, 'PEN', 1.0000, NULL, NULL, NULL, 'pendiente', 2, 2, '2026-02-28 15:12:11', '2026-02-28 15:12:11');
INSERT INTO `cotizaciones` VALUES (6, 2, '2026-03-02', 9, NULL, NULL, 93.22, 16.78, 110.00, 0.00, 1, 'PEN', 1.0000, NULL, NULL, NULL, 'pendiente', 2, 2, '2026-03-02 16:17:53', '2026-03-02 16:17:53');
INSERT INTO `cotizaciones` VALUES (7, 3, '2026-03-02', 10, NULL, NULL, 93.22, 16.78, 110.00, 0.00, 1, 'PEN', 1.0000, NULL, NULL, NULL, 'aprobada', 2, 2, '2026-03-02 17:10:12', '2026-03-02 17:40:50');
INSERT INTO `cotizaciones` VALUES (8, 4, '2026-03-02', NULL, 'emer', NULL, 93.22, 16.78, 110.00, 0.00, 1, 'PEN', 1.0000, NULL, NULL, NULL, 'pendiente', 2, 2, '2026-03-02 20:33:48', '2026-03-04 05:47:28');

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
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`dias_compra_id`) USING BTREE,
  INDEX `idx_compra`(`id_compra` ASC) USING BTREE,
  INDEX `idx_fecha`(`fecha` ASC) USING BTREE,
  INDEX `idx_estado`(`estado` ASC) USING BTREE,
  CONSTRAINT `dias_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `documentos_sunat` VALUES (13, 'DUA', '50', 'DUA', NULL, NULL);

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
  `gre_client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `gre_client_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of empresas
-- ----------------------------
INSERT INTO `empresas` VALUES (1, '20612058424', 'ARIES D & M SOCIEDAD ANONIMA CERRADA', 'ARIES D & M SOCIEDAD ANONIMA CERRADA', NULL, 'JR. ANDAHUAYLAS NRO. 1049 INT. 109S URB. BARRIOS ALTOS LIMA LIMA LIMA', 'contacto@ilidesava.com', '054-123456', NULL, NULL, '1', NULL, 'MODDATOS', 'MODDATOS', NULL, NULL, 'empresasLogos/logo_20612058424_1772291605.webp', '150101', 'LIMA', 'LIMA', 'LIMA', NULL, 'test', 0.18, NULL, NULL, '2026-02-28 15:13:25');

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
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for guia_remision
-- ----------------------------
DROP TABLE IF EXISTS `guia_remision`;
CREATE TABLE `guia_remision`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `id_usuario` bigint UNSIGNED NOT NULL,
  `id_venta` bigint UNSIGNED NULL DEFAULT NULL,
  `serie` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'T001',
  `numero` int NOT NULL,
  `fecha_emision` date NOT NULL,
  `destinatario_tipo_doc` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '6',
  `destinatario_documento` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `destinatario_nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `motivo_traslado` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_motivo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mod_transporte` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '01',
  `fecha_traslado` date NOT NULL,
  `peso_total` decimal(12, 3) NOT NULL,
  `und_peso_total` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'KGM',
  `ubigeo_partida` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir_partida` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubigeo_llegada` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir_llegada` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transportista_tipo_doc` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `transportista_documento` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `transportista_nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `transportista_nro_mtc` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `conductor_tipo_doc` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `conductor_documento` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `conductor_nombres` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `conductor_apellidos` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `conductor_licencia` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `vehiculo_placa` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `vehiculo_m1l` tinyint(1) NOT NULL DEFAULT 0,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `estado` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `nombre_xml` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `xml_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cdr_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `hash_cpe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `codigo_sunat` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mensaje_sunat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `ticket_sunat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `guia_remision_id_empresa_foreign`(`id_empresa` ASC) USING BTREE,
  INDEX `guia_remision_id_usuario_foreign`(`id_usuario` ASC) USING BTREE,
  INDEX `guia_remision_id_venta_foreign`(`id_venta` ASC) USING BTREE,
  CONSTRAINT `guia_remision_id_empresa_foreign` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `guia_remision_id_usuario_foreign` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `guia_remision_id_venta_foreign` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of guia_remision
-- ----------------------------
INSERT INTO `guia_remision` VALUES (7, 3, 2, 9, 'T001', 1, '2026-03-04', '1', '77425200', 'EMER RODRIGO YARLEQUE ZAPATA', '01', NULL, '01', '2026-03-04', 5.000, 'KGM', '150101', 'Jr República de Ecuador # 495 interior C - Lima - Lima - Lima', '150101', 'Av. Los Olivos 123 - Lima', '6', '20000000001', 'TRANSPORTES BETA SAC', NULL, '1', NULL, NULL, NULL, NULL, NULL, 0, NULL, 'pendiente', '20987654321-09-T001-1', 'sunat/xml/20987654321/20987654321-09-T001-1.xml', NULL, '80Mo7u627Kmuba6QO5QLhAb2ILU=', NULL, NULL, NULL, '2026-03-04 12:32:07', '2026-03-04 12:32:14');
INSERT INTO `guia_remision` VALUES (8, 3, 2, 20, 'T001', 2, '2026-03-04', '1', '576756765756', 'emesdffsdv', '01', NULL, '02', '2026-03-04', 1.000, 'KGM', '150101', 'Jr República de Ecuador # 495 interior C - Lima - Lima - Lima', '150101', 'fbdsbfbfsd', '6', NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, 1, NULL, 'pendiente', '20000000001-09-T001-2', 'sunat/xml/20000000001/20000000001-09-T001-2.xml', NULL, '8fbOV+8NNw89+YSZDKIN4HOYME8=', NULL, NULL, NULL, '2026-03-04 16:54:58', '2026-03-04 16:54:58');
INSERT INTO `guia_remision` VALUES (9, 3, 2, 20, 'T001', 3, '2026-03-04', '4', '576756765756', 'emesdffsdv', '01', NULL, '02', '2026-03-04', 1.000, 'KGM', '150101', 'Jr República de Ecuador # 495 interior C - Lima - Lima - Lima', '150101', 'fbdsbfbfsd', '6', NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, 1, NULL, 'pendiente', '20000000001-09-T001-3', 'sunat/xml/20000000001/20000000001-09-T001-3.xml', NULL, '6fdw1/30F0fTza/89d80PnHBfeg=', NULL, NULL, NULL, '2026-03-04 16:57:27', '2026-03-04 16:57:27');

-- ----------------------------
-- Table structure for guia_remision_detalles
-- ----------------------------
DROP TABLE IF EXISTS `guia_remision_detalles`;
CREATE TABLE `guia_remision_detalles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_guia` bigint UNSIGNED NOT NULL,
  `id_producto` int NULL DEFAULT NULL,
  `codigo` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` decimal(12, 3) NOT NULL,
  `unidad` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NIU',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `guia_remision_detalles_id_guia_foreign`(`id_guia` ASC) USING BTREE,
  INDEX `guia_remision_detalles_id_producto_foreign`(`id_producto` ASC) USING BTREE,
  CONSTRAINT `guia_remision_detalles_id_guia_foreign` FOREIGN KEY (`id_guia`) REFERENCES `guia_remision` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `guia_remision_detalles_id_producto_foreign` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of guia_remision_detalles
-- ----------------------------
INSERT INTO `guia_remision_detalles` VALUES (7, 7, 320, 'PROD-A1-00001', 'holaaa', 1.000, 'NIU', '2026-03-04 12:32:07', '2026-03-04 12:32:07');
INSERT INTO `guia_remision_detalles` VALUES (8, 8, 320, 'PROD-A1-00001', 'holaaa', 1.000, 'NIU', '2026-03-04 16:54:58', '2026-03-04 16:54:58');
INSERT INTO `guia_remision_detalles` VALUES (9, 9, 320, 'PROD-A1-00001', 'holaaa', 1.000, 'NIU', '2026-03-04 16:57:27', '2026-03-04 16:57:27');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (14, '2026_02_24_023530_create_permissions_and_role_permission_tables', 1);
INSERT INTO `migrations` VALUES (15, '2026_02_24_100000_create_motivo_nota_table', 2);
INSERT INTO `migrations` VALUES (16, '2026_02_24_100001_create_nota_credito_table', 2);
INSERT INTO `migrations` VALUES (17, '2026_02_24_100002_create_nota_debito_table', 2);
INSERT INTO `migrations` VALUES (18, '2026_02_24_162201_update_motivo_nota_descripciones_sunat', 3);
INSERT INTO `migrations` VALUES (19, '2026_02_24_172807_create_guia_remision_table', 4);
INSERT INTO `migrations` VALUES (20, '2026_02_24_172807_create_motivo_traslado_table', 4);
INSERT INTO `migrations` VALUES (21, '2026_02_24_172808_create_guia_remision_detalles_table', 4);
INSERT INTO `migrations` VALUES (22, '2026_02_24_193923_add_voucher_to_ventas_pagos_table', 5);
INSERT INTO `migrations` VALUES (23, '2026_02_24_202752_add_nota_venta_id_to_ventas_table', 6);
INSERT INTO `migrations` VALUES (24, '2026_02_24_213623_add_stock_real_descontado_to_ventas_table', 7);
INSERT INTO `migrations` VALUES (25, '2026_02_27_000001_create_plantilla_impresion_table', 8);
INSERT INTO `migrations` VALUES (26, '2026_02_27_100000_add_nombre_xml_to_ventas_table', 9);
INSERT INTO `migrations` VALUES (27, '2026_02_28_190559_add_vehiculo_m1l_to_guia_remision', 10);
INSERT INTO `migrations` VALUES (28, '2026_03_02_201358_make_cotizaciones_cliente_optional', 11);
INSERT INTO `migrations` VALUES (29, '2026_03_04_165324_ampliar_documento_clientes', 12);

-- ----------------------------
-- Table structure for motivo_nota
-- ----------------------------
DROP TABLE IF EXISTS `motivo_nota`;
CREATE TABLE `motivo_nota`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo` enum('NC','ND') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_sunat` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of motivo_nota
-- ----------------------------
INSERT INTO `motivo_nota` VALUES (1, 'NC', '01', 'Anulación de la operación', 1, '2026-02-24 15:35:44', '2026-02-24 16:22:25');
INSERT INTO `motivo_nota` VALUES (2, 'NC', '02', 'Anulación por error en el RUC', 1, '2026-02-24 15:35:44', '2026-02-24 16:22:25');
INSERT INTO `motivo_nota` VALUES (3, 'NC', '03', 'Corrección por error en la descripción', 1, '2026-02-24 15:35:44', '2026-02-24 16:22:25');
INSERT INTO `motivo_nota` VALUES (4, 'NC', '04', 'Descuento global', 1, '2026-02-24 15:35:44', '2026-02-24 16:22:25');
INSERT INTO `motivo_nota` VALUES (5, 'NC', '05', 'Descuento por ítem', 1, '2026-02-24 15:35:44', '2026-02-24 16:22:25');
INSERT INTO `motivo_nota` VALUES (6, 'NC', '06', 'Devolución total', 1, '2026-02-24 15:35:44', '2026-02-24 16:22:25');
INSERT INTO `motivo_nota` VALUES (7, 'NC', '07', 'Devolución por ítem', 1, '2026-02-24 15:35:44', '2026-02-24 16:22:25');
INSERT INTO `motivo_nota` VALUES (8, 'NC', '08', 'Bonificación', 1, '2026-02-24 15:35:44', '2026-02-24 16:22:25');
INSERT INTO `motivo_nota` VALUES (9, 'NC', '09', 'Disminución en el valor', 1, '2026-02-24 15:35:44', '2026-02-24 16:22:25');
INSERT INTO `motivo_nota` VALUES (10, 'NC', '10', 'Otros conceptos', 1, '2026-02-24 15:35:44', '2026-02-24 16:22:25');
INSERT INTO `motivo_nota` VALUES (11, 'ND', '01', 'Intereses por mora', 1, '2026-02-24 15:35:44', '2026-02-24 15:35:44');
INSERT INTO `motivo_nota` VALUES (12, 'ND', '02', 'Aumento en el valor', 1, '2026-02-24 15:35:44', '2026-02-24 15:35:44');
INSERT INTO `motivo_nota` VALUES (13, 'ND', '03', 'Penalidades / otros conceptos', 1, '2026-02-24 15:35:44', '2026-02-24 15:35:44');
INSERT INTO `motivo_nota` VALUES (14, 'ND', '10', 'Otros conceptos', 1, '2026-02-24 15:35:44', '2026-02-24 15:35:44');
INSERT INTO `motivo_nota` VALUES (15, 'NC', '11', 'Ajustes de operaciones de exportación', 1, '2026-02-24 16:22:25', '2026-02-24 16:22:25');
INSERT INTO `motivo_nota` VALUES (16, 'NC', '12', 'Ajustes afectos al IVAP', 1, '2026-02-24 16:22:25', '2026-02-24 16:22:25');
INSERT INTO `motivo_nota` VALUES (17, 'NC', '13', 'Corrección del monto neto pendiente de pago', 1, '2026-02-24 16:22:25', '2026-02-24 16:22:25');

-- ----------------------------
-- Table structure for motivo_traslado
-- ----------------------------
DROP TABLE IF EXISTS `motivo_traslado`;
CREATE TABLE `motivo_traslado`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `motivo_traslado_codigo_unique`(`codigo` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of motivo_traslado
-- ----------------------------
INSERT INTO `motivo_traslado` VALUES (1, '01', 'Venta', 1, '2026-02-24 17:34:24', '2026-02-24 17:34:24');
INSERT INTO `motivo_traslado` VALUES (2, '02', 'Compra', 1, '2026-02-24 17:34:24', '2026-02-24 17:34:24');
INSERT INTO `motivo_traslado` VALUES (3, '03', 'Venta con entrega a terceros', 1, '2026-02-24 17:34:24', '2026-02-24 17:34:24');
INSERT INTO `motivo_traslado` VALUES (4, '04', 'Traslado entre establecimientos de la misma empresa', 1, '2026-02-24 17:34:24', '2026-02-24 17:34:24');
INSERT INTO `motivo_traslado` VALUES (5, '08', 'Emisor itinerante de comprobantes de pago', 1, '2026-02-24 17:34:24', '2026-02-24 17:34:24');
INSERT INTO `motivo_traslado` VALUES (6, '09', 'Traslado de bienes para transformación', 1, '2026-02-24 17:34:24', '2026-02-24 17:34:24');
INSERT INTO `motivo_traslado` VALUES (7, '13', 'Otros', 1, '2026-02-24 17:34:24', '2026-02-24 17:34:24');
INSERT INTO `motivo_traslado` VALUES (8, '14', 'Venta sujeta a confirmación del comprador', 1, '2026-02-24 17:34:24', '2026-02-24 17:34:24');
INSERT INTO `motivo_traslado` VALUES (9, '17', 'Traslado de bienes para transformación', 1, '2026-02-24 17:34:24', '2026-02-24 17:34:24');
INSERT INTO `motivo_traslado` VALUES (10, '18', 'Recojo de bienes transformados', 1, '2026-02-24 17:34:24', '2026-02-24 17:34:24');
INSERT INTO `motivo_traslado` VALUES (11, '19', 'Traslado emisor itinerante de comprobantes de pago', 1, '2026-02-24 17:34:24', '2026-02-24 17:34:24');

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
  `fecha_movimiento` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_movimiento`) USING BTREE,
  INDEX `idx_producto`(`id_producto` ASC) USING BTREE,
  INDEX `idx_tipo_movimiento`(`tipo_movimiento` ASC) USING BTREE,
  INDEX `idx_fecha`(`fecha_movimiento` ASC) USING BTREE,
  INDEX `idx_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `idx_documento`(`tipo_documento` ASC, `id_documento` ASC) USING BTREE,
  CONSTRAINT `movimientos_stock_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `movimientos_stock_ibfk_2` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of movimientos_stock
-- ----------------------------
INSERT INTO `movimientos_stock` VALUES (1, 628, 'salida', 1.00, 1.00, 0.00, 'venta', 7, 'B001-000004', 'Venta realizada', NULL, 1, 2, 2, '2026-03-04 04:28:21', '2026-03-04 04:28:21', '2026-03-04 04:28:21');
INSERT INTO `movimientos_stock` VALUES (2, 628, 'entrada', 11.00, 0.00, 11.00, 'compra', 1, 'F001-21', 'Compra a proveedor', NULL, 1, 2, 2, '2026-03-04 05:46:03', '2026-03-04 05:46:03', '2026-03-04 05:46:03');
INSERT INTO `movimientos_stock` VALUES (3, 320, 'salida', 1.00, 230.00, 229.00, 'venta', 8, 'B001-000001', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 12:24:29', '2026-03-04 12:24:29', '2026-03-04 12:24:29');
INSERT INTO `movimientos_stock` VALUES (4, 320, 'salida', 1.00, 229.00, 228.00, 'venta', 9, 'B001-000002', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 12:28:19', '2026-03-04 12:28:19', '2026-03-04 12:28:19');
INSERT INTO `movimientos_stock` VALUES (5, 320, 'salida', 1.00, 228.00, 227.00, 'venta', 11, 'B001-000003', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 13:43:55', '2026-03-04 13:43:55', '2026-03-04 13:43:55');
INSERT INTO `movimientos_stock` VALUES (6, 320, 'salida', 1.00, 227.00, 226.00, 'venta', 12, 'B001-000004', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 13:51:33', '2026-03-04 13:51:33', '2026-03-04 13:51:33');
INSERT INTO `movimientos_stock` VALUES (7, 320, 'salida', 1.00, 226.00, 225.00, 'venta', 13, 'B001-000005', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 13:52:43', '2026-03-04 13:52:43', '2026-03-04 13:52:43');
INSERT INTO `movimientos_stock` VALUES (8, 320, 'salida', 1.00, 225.00, 224.00, 'venta', 14, 'B001-000006', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 14:02:40', '2026-03-04 14:02:40', '2026-03-04 14:02:40');
INSERT INTO `movimientos_stock` VALUES (9, 631, 'salida', 12.00, 0.00, -12.00, 'venta', 16, 'B001-000007', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 14:17:24', '2026-03-04 14:17:24', '2026-03-04 14:17:24');
INSERT INTO `movimientos_stock` VALUES (10, 320, 'salida', 1.00, 224.00, 223.00, 'venta', 17, 'B001-000008', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 14:24:03', '2026-03-04 14:24:03', '2026-03-04 14:24:03');
INSERT INTO `movimientos_stock` VALUES (11, 320, 'salida', 1.00, 223.00, 222.00, 'venta', 18, 'B001-000009', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 14:28:23', '2026-03-04 14:28:23', '2026-03-04 14:28:23');
INSERT INTO `movimientos_stock` VALUES (12, 320, 'salida', 1.00, 222.00, 221.00, 'venta', 19, 'B001-000010', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 16:20:18', '2026-03-04 16:20:18', '2026-03-04 16:20:18');
INSERT INTO `movimientos_stock` VALUES (13, 320, 'salida', 1.00, 221.00, 220.00, 'venta', 20, 'B001-000011', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 16:53:57', '2026-03-04 16:53:57', '2026-03-04 16:53:57');
INSERT INTO `movimientos_stock` VALUES (14, 320, 'salida', 1.00, 220.00, 219.00, 'venta', 21, 'B001-000012', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 17:16:41', '2026-03-04 17:16:41', '2026-03-04 17:16:41');
INSERT INTO `movimientos_stock` VALUES (15, 320, 'salida', 1.00, 219.00, 218.00, 'venta', 22, 'B001-000013', 'Venta realizada', NULL, 1, 3, 2, '2026-03-04 17:45:07', '2026-03-04 17:45:07', '2026-03-04 17:45:07');
INSERT INTO `movimientos_stock` VALUES (16, 936, 'salida', 1.00, 32.00, 31.00, 'venta', 23, 'B001-000001', 'Venta realizada', NULL, 1, 4, 2, '2026-03-04 17:59:01', '2026-03-04 17:59:01', '2026-03-04 17:59:01');
INSERT INTO `movimientos_stock` VALUES (17, 936, 'salida', 1.00, 31.00, 30.00, 'venta', 24, 'B001-000002', 'Venta realizada', NULL, 1, 4, 2, '2026-03-04 17:59:15', '2026-03-04 17:59:15', '2026-03-04 17:59:15');

-- ----------------------------
-- Table structure for nota_credito
-- ----------------------------
DROP TABLE IF EXISTS `nota_credito`;
CREATE TABLE `nota_credito`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venta` bigint UNSIGNED NOT NULL,
  `motivo_id` bigint UNSIGNED NOT NULL,
  `serie` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` int NOT NULL,
  `tipo_doc_afectado` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `serie_num_afectado` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_motivo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `monto_subtotal` decimal(12, 2) NOT NULL DEFAULT 0.00,
  `monto_igv` decimal(12, 2) NOT NULL DEFAULT 0.00,
  `monto_total` decimal(12, 2) NOT NULL DEFAULT 0.00,
  `moneda` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PEN',
  `fecha_emision` date NOT NULL,
  `estado` enum('pendiente','enviado','aceptado','rechazado') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `hash_cpe` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `xml_url` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cdr_url` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `codigo_sunat` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mensaje_sunat` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nombre_xml` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_empresa` bigint UNSIGNED NOT NULL,
  `id_usuario` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `nota_credito_id_venta_foreign`(`id_venta` ASC) USING BTREE,
  INDEX `nota_credito_motivo_id_foreign`(`motivo_id` ASC) USING BTREE,
  CONSTRAINT `nota_credito_id_venta_foreign` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `nota_credito_motivo_id_foreign` FOREIGN KEY (`motivo_id`) REFERENCES `motivo_nota` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nota_credito
-- ----------------------------

-- ----------------------------
-- Table structure for nota_debito
-- ----------------------------
DROP TABLE IF EXISTS `nota_debito`;
CREATE TABLE `nota_debito`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venta` bigint UNSIGNED NOT NULL,
  `motivo_id` bigint UNSIGNED NOT NULL,
  `serie` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` int NOT NULL,
  `tipo_doc_afectado` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `serie_num_afectado` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_motivo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `monto_subtotal` decimal(12, 2) NOT NULL DEFAULT 0.00,
  `monto_igv` decimal(12, 2) NOT NULL DEFAULT 0.00,
  `monto_total` decimal(12, 2) NOT NULL DEFAULT 0.00,
  `moneda` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PEN',
  `fecha_emision` date NOT NULL,
  `estado` enum('pendiente','enviado','aceptado','rechazado') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `hash_cpe` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `xml_url` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cdr_url` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `codigo_sunat` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mensaje_sunat` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nombre_xml` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_empresa` bigint UNSIGNED NOT NULL,
  `id_usuario` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `nota_debito_id_venta_foreign`(`id_venta` ASC) USING BTREE,
  INDEX `nota_debito_motivo_id_foreign`(`motivo_id` ASC) USING BTREE,
  CONSTRAINT `nota_debito_id_venta_foreign` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `nota_debito_motivo_id_foreign` FOREIGN KEY (`motivo_id`) REFERENCES `motivo_nota` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nota_debito
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
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `permission_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`permission_id`) USING BTREE,
  UNIQUE INDEX `permissions_name_unique`(`name` ASC) USING BTREE,
  INDEX `permissions_module_index`(`module` ASC) USING BTREE,
  INDEX `permissions_action_index`(`action` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES (1, 'ventas.view', 'Ver Ventas', 'ventas', 'view', 'Permiso para Ver en el módulo de Ventas', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (2, 'ventas.create', 'Crear Ventas', 'ventas', 'create', 'Permiso para Crear en el módulo de Ventas', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (3, 'ventas.edit', 'Editar Ventas', 'ventas', 'edit', 'Permiso para Editar en el módulo de Ventas', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (4, 'ventas.delete', 'Eliminar Ventas', 'ventas', 'delete', 'Permiso para Eliminar en el módulo de Ventas', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (5, 'productos.view', 'Ver Productos', 'productos', 'view', 'Permiso para Ver en el módulo de Productos', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (6, 'productos.create', 'Crear Productos', 'productos', 'create', 'Permiso para Crear en el módulo de Productos', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (7, 'productos.edit', 'Editar Productos', 'productos', 'edit', 'Permiso para Editar en el módulo de Productos', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (8, 'productos.delete', 'Eliminar Productos', 'productos', 'delete', 'Permiso para Eliminar en el módulo de Productos', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (9, 'clientes.view', 'Ver Clientes', 'clientes', 'view', 'Permiso para Ver en el módulo de Clientes', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (10, 'clientes.create', 'Crear Clientes', 'clientes', 'create', 'Permiso para Crear en el módulo de Clientes', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (11, 'clientes.edit', 'Editar Clientes', 'clientes', 'edit', 'Permiso para Editar en el módulo de Clientes', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (12, 'clientes.delete', 'Eliminar Clientes', 'clientes', 'delete', 'Permiso para Eliminar en el módulo de Clientes', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (13, 'proveedores.view', 'Ver Proveedores', 'proveedores', 'view', 'Permiso para Ver en el módulo de Proveedores', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (14, 'proveedores.create', 'Crear Proveedores', 'proveedores', 'create', 'Permiso para Crear en el módulo de Proveedores', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (15, 'proveedores.edit', 'Editar Proveedores', 'proveedores', 'edit', 'Permiso para Editar en el módulo de Proveedores', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (16, 'proveedores.delete', 'Eliminar Proveedores', 'proveedores', 'delete', 'Permiso para Eliminar en el módulo de Proveedores', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (17, 'compras.view', 'Ver Compras', 'compras', 'view', 'Permiso para Ver en el módulo de Compras', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (18, 'compras.create', 'Crear Compras', 'compras', 'create', 'Permiso para Crear en el módulo de Compras', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (19, 'compras.edit', 'Editar Compras', 'compras', 'edit', 'Permiso para Editar en el módulo de Compras', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (20, 'compras.delete', 'Eliminar Compras', 'compras', 'delete', 'Permiso para Eliminar en el módulo de Compras', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (21, 'cotizaciones.view', 'Ver Cotizaciones', 'cotizaciones', 'view', 'Permiso para Ver en el módulo de Cotizaciones', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (22, 'cotizaciones.create', 'Crear Cotizaciones', 'cotizaciones', 'create', 'Permiso para Crear en el módulo de Cotizaciones', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (23, 'cotizaciones.edit', 'Editar Cotizaciones', 'cotizaciones', 'edit', 'Permiso para Editar en el módulo de Cotizaciones', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (24, 'cotizaciones.delete', 'Eliminar Cotizaciones', 'cotizaciones', 'delete', 'Permiso para Eliminar en el módulo de Cotizaciones', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (25, 'empresas.view', 'Ver Empresas', 'empresas', 'view', 'Permiso para Ver en el módulo de Empresas', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (26, 'empresas.create', 'Crear Empresas', 'empresas', 'create', 'Permiso para Crear en el módulo de Empresas', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (27, 'empresas.edit', 'Editar Empresas', 'empresas', 'edit', 'Permiso para Editar en el módulo de Empresas', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (28, 'empresas.delete', 'Eliminar Empresas', 'empresas', 'delete', 'Permiso para Eliminar en el módulo de Empresas', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (29, 'usuarios.view', 'Ver Usuarios', 'usuarios', 'view', 'Permiso para Ver en el módulo de Usuarios', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (30, 'usuarios.create', 'Crear Usuarios', 'usuarios', 'create', 'Permiso para Crear en el módulo de Usuarios', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (31, 'usuarios.edit', 'Editar Usuarios', 'usuarios', 'edit', 'Permiso para Editar en el módulo de Usuarios', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (32, 'usuarios.delete', 'Eliminar Usuarios', 'usuarios', 'delete', 'Permiso para Eliminar en el módulo de Usuarios', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (33, 'reportes.view', 'Ver Reportes', 'reportes', 'view', 'Permiso para Ver en el módulo de Reportes', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (34, 'reportes.create', 'Crear Reportes', 'reportes', 'create', 'Permiso para Crear en el módulo de Reportes', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (35, 'reportes.edit', 'Editar Reportes', 'reportes', 'edit', 'Permiso para Editar en el módulo de Reportes', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (36, 'reportes.delete', 'Eliminar Reportes', 'reportes', 'delete', 'Permiso para Eliminar en el módulo de Reportes', '2026-02-24 02:58:25', '2026-02-24 02:58:25');
INSERT INTO `permissions` VALUES (37, 'facturacion.view', 'Ver Facturación', 'facturacion', 'view', 'Permiso para Ver en el módulo de Facturación', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (38, 'facturacion.create', 'Crear Facturación', 'facturacion', 'create', 'Permiso para Crear en el módulo de Facturación', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (39, 'facturacion.edit', 'Editar Facturación', 'facturacion', 'edit', 'Permiso para Editar en el módulo de Facturación', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (40, 'facturacion.delete', 'Eliminar Facturación', 'facturacion', 'delete', 'Permiso para Eliminar en el módulo de Facturación', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (41, 'facturas.view', 'Ver Facturas', 'facturas', 'view', 'Permiso para Ver en el módulo de Facturas', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (42, 'facturas.create', 'Crear Facturas', 'facturas', 'create', 'Permiso para Crear en el módulo de Facturas', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (43, 'facturas.edit', 'Editar Facturas', 'facturas', 'edit', 'Permiso para Editar en el módulo de Facturas', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (44, 'facturas.delete', 'Eliminar Facturas', 'facturas', 'delete', 'Permiso para Eliminar en el módulo de Facturas', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (45, 'boletas.view', 'Ver Boletas', 'boletas', 'view', 'Permiso para Ver en el módulo de Boletas', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (46, 'boletas.create', 'Crear Boletas', 'boletas', 'create', 'Permiso para Crear en el módulo de Boletas', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (47, 'boletas.edit', 'Editar Boletas', 'boletas', 'edit', 'Permiso para Editar en el módulo de Boletas', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (48, 'boletas.delete', 'Eliminar Boletas', 'boletas', 'delete', 'Permiso para Eliminar en el módulo de Boletas', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (49, 'notas-venta.view', 'Ver Notas de Venta', 'notas-venta', 'view', 'Permiso para Ver en el módulo de Notas de Venta', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (50, 'notas-venta.create', 'Crear Notas de Venta', 'notas-venta', 'create', 'Permiso para Crear en el módulo de Notas de Venta', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (51, 'notas-venta.edit', 'Editar Notas de Venta', 'notas-venta', 'edit', 'Permiso para Editar en el módulo de Notas de Venta', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (52, 'notas-venta.delete', 'Eliminar Notas de Venta', 'notas-venta', 'delete', 'Permiso para Eliminar en el módulo de Notas de Venta', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (53, 'notas-credito.view', 'Ver Notas de Crédito', 'notas-credito', 'view', 'Permiso para Ver en el módulo de Notas de Crédito', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (54, 'notas-credito.create', 'Crear Notas de Crédito', 'notas-credito', 'create', 'Permiso para Crear en el módulo de Notas de Crédito', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (55, 'notas-credito.edit', 'Editar Notas de Crédito', 'notas-credito', 'edit', 'Permiso para Editar en el módulo de Notas de Crédito', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (56, 'notas-credito.delete', 'Eliminar Notas de Crédito', 'notas-credito', 'delete', 'Permiso para Eliminar en el módulo de Notas de Crédito', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (57, 'guias-remision.view', 'Ver Guías de Remisión', 'guias-remision', 'view', 'Permiso para Ver en el módulo de Guías de Remisión', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (58, 'guias-remision.create', 'Crear Guías de Remisión', 'guias-remision', 'create', 'Permiso para Crear en el módulo de Guías de Remisión', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (59, 'guias-remision.edit', 'Editar Guías de Remisión', 'guias-remision', 'edit', 'Permiso para Editar en el módulo de Guías de Remisión', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (60, 'guias-remision.delete', 'Eliminar Guías de Remisión', 'guias-remision', 'delete', 'Permiso para Eliminar en el módulo de Guías de Remisión', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (61, 'configuracion.view', 'Ver Configuración', 'configuracion', 'view', 'Permiso para Ver en el módulo de Configuración', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (62, 'configuracion.create', 'Crear Configuración', 'configuracion', 'create', 'Permiso para Crear en el módulo de Configuración', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (63, 'configuracion.edit', 'Editar Configuración', 'configuracion', 'edit', 'Permiso para Editar en el módulo de Configuración', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (64, 'configuracion.delete', 'Eliminar Configuración', 'configuracion', 'delete', 'Permiso para Eliminar en el módulo de Configuración', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (65, 'empresa.view', 'Ver Datos de Empresa', 'empresa', 'view', 'Permiso para Ver en el módulo de Datos de Empresa', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (66, 'empresa.create', 'Crear Datos de Empresa', 'empresa', 'create', 'Permiso para Crear en el módulo de Datos de Empresa', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (67, 'empresa.edit', 'Editar Datos de Empresa', 'empresa', 'edit', 'Permiso para Editar en el módulo de Datos de Empresa', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (68, 'empresa.delete', 'Eliminar Datos de Empresa', 'empresa', 'delete', 'Permiso para Eliminar en el módulo de Datos de Empresa', '2026-02-24 03:01:24', '2026-02-24 03:01:24');
INSERT INTO `permissions` VALUES (69, 'permisos.view', 'Ver Permisos', 'permisos', 'view', 'Permiso para Ver en el módulo de Permisos', '2026-02-24 03:08:20', '2026-02-24 03:08:20');
INSERT INTO `permissions` VALUES (70, 'permisos.create', 'Crear Permisos', 'permisos', 'create', 'Permiso para Crear en el módulo de Permisos', '2026-02-24 03:08:20', '2026-02-24 03:08:20');
INSERT INTO `permissions` VALUES (71, 'permisos.edit', 'Editar Permisos', 'permisos', 'edit', 'Permiso para Editar en el módulo de Permisos', '2026-02-24 03:08:20', '2026-02-24 03:08:20');
INSERT INTO `permissions` VALUES (72, 'permisos.delete', 'Eliminar Permisos', 'permisos', 'delete', 'Permiso para Eliminar en el módulo de Permisos', '2026-02-24 03:08:20', '2026-02-24 03:08:20');
INSERT INTO `permissions` VALUES (73, 'plantilla-impresion.view', 'Ver Plantillas de Impresión', 'plantilla-impresion', 'view', 'Permiso para Ver en el módulo de Plantillas de Impresión', '2026-02-27 14:32:04', '2026-02-27 14:32:04');
INSERT INTO `permissions` VALUES (74, 'plantilla-impresion.create', 'Crear Plantillas de Impresión', 'plantilla-impresion', 'create', 'Permiso para Crear en el módulo de Plantillas de Impresión', '2026-02-27 14:32:04', '2026-02-27 14:32:04');
INSERT INTO `permissions` VALUES (75, 'plantilla-impresion.edit', 'Editar Plantillas de Impresión', 'plantilla-impresion', 'edit', 'Permiso para Editar en el módulo de Plantillas de Impresión', '2026-02-27 14:32:04', '2026-02-27 14:32:04');
INSERT INTO `permissions` VALUES (76, 'plantilla-impresion.delete', 'Eliminar Plantillas de Impresión', 'plantilla-impresion', 'delete', 'Permiso para Eliminar en el módulo de Plantillas de Impresión', '2026-02-27 14:32:04', '2026-02-27 14:32:04');
INSERT INTO `permissions` VALUES (77, 'finanzas.view', 'Ver Finanzas', 'finanzas', 'view', 'Permiso para Ver en el módulo de Finanzas', '2026-03-04 19:14:12', '2026-03-04 19:14:12');
INSERT INTO `permissions` VALUES (78, 'finanzas.create', 'Crear Finanzas', 'finanzas', 'create', 'Permiso para Crear en el módulo de Finanzas', '2026-03-04 19:14:12', '2026-03-04 19:14:12');
INSERT INTO `permissions` VALUES (79, 'finanzas.edit', 'Editar Finanzas', 'finanzas', 'edit', 'Permiso para Editar en el módulo de Finanzas', '2026-03-04 19:14:12', '2026-03-04 19:14:12');
INSERT INTO `permissions` VALUES (80, 'finanzas.delete', 'Eliminar Finanzas', 'finanzas', 'delete', 'Permiso para Eliminar en el módulo de Finanzas', '2026-03-04 19:14:12', '2026-03-04 19:14:12');
INSERT INTO `permissions` VALUES (81, 'cuentas-cobrar.view', 'Ver Cuentas por Cobrar', 'cuentas-cobrar', 'view', 'Permiso para Ver en el módulo de Cuentas por Cobrar', '2026-03-04 19:14:12', '2026-03-04 19:14:12');
INSERT INTO `permissions` VALUES (82, 'cuentas-cobrar.create', 'Crear Cuentas por Cobrar', 'cuentas-cobrar', 'create', 'Permiso para Crear en el módulo de Cuentas por Cobrar', '2026-03-04 19:14:12', '2026-03-04 19:14:12');
INSERT INTO `permissions` VALUES (83, 'cuentas-cobrar.edit', 'Editar Cuentas por Cobrar', 'cuentas-cobrar', 'edit', 'Permiso para Editar en el módulo de Cuentas por Cobrar', '2026-03-04 19:14:12', '2026-03-04 19:14:12');
INSERT INTO `permissions` VALUES (84, 'cuentas-cobrar.delete', 'Eliminar Cuentas por Cobrar', 'cuentas-cobrar', 'delete', 'Permiso para Eliminar en el módulo de Cuentas por Cobrar', '2026-03-04 19:14:12', '2026-03-04 19:14:12');
INSERT INTO `permissions` VALUES (85, 'cuentas-pagar.view', 'Ver Cuentas por Pagar', 'cuentas-pagar', 'view', 'Permiso para Ver en el módulo de Cuentas por Pagar', '2026-03-04 19:14:12', '2026-03-04 19:14:12');
INSERT INTO `permissions` VALUES (86, 'cuentas-pagar.create', 'Crear Cuentas por Pagar', 'cuentas-pagar', 'create', 'Permiso para Crear en el módulo de Cuentas por Pagar', '2026-03-04 19:14:12', '2026-03-04 19:14:12');
INSERT INTO `permissions` VALUES (87, 'cuentas-pagar.edit', 'Editar Cuentas por Pagar', 'cuentas-pagar', 'edit', 'Permiso para Editar en el módulo de Cuentas por Pagar', '2026-03-04 19:14:12', '2026-03-04 19:14:12');
INSERT INTO `permissions` VALUES (88, 'cuentas-pagar.delete', 'Eliminar Cuentas por Pagar', 'cuentas-pagar', 'delete', 'Permiso para Eliminar en el módulo de Cuentas por Pagar', '2026-03-04 19:14:12', '2026-03-04 19:14:12');

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
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `personal_access_tokens` VALUES (57, 'App\\Models\\User', 2, 'auth_token', '396978df0ec8fde98e0c5796641e623cf82dc447e38b2c6825ae5ea8b2aae28a', '[\"*\"]', '2026-02-24 04:41:50', '2026-02-24 11:25:14', '2026-02-24 03:25:14', '2026-02-24 04:41:50');
INSERT INTO `personal_access_tokens` VALUES (62, 'App\\Models\\User', 3, 'auth_token', 'ec7837914122e4d52483d082174ef6404d1ddb1a89310f7e7a96ab0de5bd12fe', '[\"*\"]', '2026-02-24 04:01:19', '2026-02-24 12:00:25', '2026-02-24 04:00:25', '2026-02-24 04:01:19');
INSERT INTO `personal_access_tokens` VALUES (65, 'App\\Models\\User', 3, 'auth_token', 'fc9fa411b0740de4fa5cee4fa681c2288df809bd15c27f55dd227bb893c8a094', '[\"*\"]', '2026-02-24 04:16:17', '2026-02-24 12:13:32', '2026-02-24 04:13:32', '2026-02-24 04:16:17');
INSERT INTO `personal_access_tokens` VALUES (67, 'App\\Models\\User', 2, 'auth_token', 'e19a16d8d3e8cdae62c5349c43ff5976e2ef9eb62f4851083b269870d11f0d00', '[\"*\"]', '2026-02-24 17:49:08', '2026-02-24 22:28:22', '2026-02-24 14:28:22', '2026-02-24 17:49:08');
INSERT INTO `personal_access_tokens` VALUES (68, 'App\\Models\\User', 2, 'auth_token', '4a2e5c6b4afe666de441e5e98c074d12aeb3597482e17be50573c25beeb48695', '[\"*\"]', '2026-02-24 18:47:41', '2026-02-25 00:32:05', '2026-02-24 16:32:05', '2026-02-24 18:47:41');
INSERT INTO `personal_access_tokens` VALUES (69, 'App\\Models\\User', 2, 'auth_token', 'c63f8c33b872c59a3bd4e31392ccbdf803875c5c7c8a0413b8d8af16a5672797', '[\"*\"]', NULL, '2026-02-25 10:28:55', '2026-02-25 02:28:56', '2026-02-25 02:28:56');
INSERT INTO `personal_access_tokens` VALUES (70, 'App\\Models\\User', 2, 'auth_token', '223fc5570e618472099a456abd06c667626f070fa9fe263f8ee84ca5dee9a3c1', '[\"*\"]', NULL, '2026-02-26 01:39:13', '2026-02-25 17:39:13', '2026-02-25 17:39:13');
INSERT INTO `personal_access_tokens` VALUES (71, 'App\\Models\\User', 2, 'auth_token', '6ee0d5f39ec74aaca43970ecf21d0fa476856865c707120a1baf1638b115617d', '[\"*\"]', NULL, '2026-02-26 01:48:51', '2026-02-25 17:48:51', '2026-02-25 17:48:51');
INSERT INTO `personal_access_tokens` VALUES (72, 'App\\Models\\User', 2, 'auth_token', '272b92384d3783275b9c3cc032018a584af83226a6cd4072cace4211a9dc0759', '[\"*\"]', NULL, '2026-02-26 01:56:12', '2026-02-25 17:56:12', '2026-02-25 17:56:12');
INSERT INTO `personal_access_tokens` VALUES (73, 'App\\Models\\User', 2, 'auth_token', '14628b6e0620f775e5f90ff1a1be3deb1b312fb0bd56ec37ed403a5c568f1dc1', '[\"*\"]', NULL, '2026-02-26 01:56:41', '2026-02-25 17:56:41', '2026-02-25 17:56:41');
INSERT INTO `personal_access_tokens` VALUES (74, 'App\\Models\\User', 2, 'auth_token', 'f7527f7789e4f2708320133aa66c8382c0582dbf311fd8fcb0a06b7ba26bc080', '[\"*\"]', NULL, '2026-02-27 04:20:52', '2026-02-26 20:20:52', '2026-02-26 20:20:52');
INSERT INTO `personal_access_tokens` VALUES (75, 'App\\Models\\User', 2, 'auth_token', 'c9726cae0271c911ebd30dcbde8f484553ec71e5d0fc21d1925bc76310e9e467', '[\"*\"]', '2026-02-27 02:39:24', '2026-02-27 04:22:45', '2026-02-26 20:22:45', '2026-02-27 02:39:24');
INSERT INTO `personal_access_tokens` VALUES (76, 'App\\Models\\User', 2, 'auth_token', '1944f87654a786a89b55415a0369835e306187c412cf1344636d976f1fbd110d', '[\"*\"]', NULL, '2026-02-27 21:27:00', '2026-02-27 13:27:00', '2026-02-27 13:27:00');
INSERT INTO `personal_access_tokens` VALUES (77, 'App\\Models\\User', 2, 'auth_token', '452b4b03fad5d963b2054bf6df3fa8ba33e20d8cae2e9e2aa0d8220fc3c09da1', '[\"*\"]', NULL, '2026-02-27 22:52:19', '2026-02-27 14:52:19', '2026-02-27 14:52:19');
INSERT INTO `personal_access_tokens` VALUES (78, 'App\\Models\\User', 2, 'auth_token', 'd1c79593896846aa889327b0c5cfef4a93cdb26ff9fb15249bf590c59de139eb', '[\"*\"]', '2026-02-28 02:26:00', '2026-02-28 07:16:18', '2026-02-27 23:16:19', '2026-02-28 02:26:00');
INSERT INTO `personal_access_tokens` VALUES (79, 'App\\Models\\User', 2, 'auth_token', '00a959139985f9b5ff2fa0e889a3731ebae206c44e96ad6d8283512f35d16c78', '[\"*\"]', NULL, '2026-02-28 22:00:54', '2026-02-28 14:00:54', '2026-02-28 14:00:54');
INSERT INTO `personal_access_tokens` VALUES (81, 'App\\Models\\User', 2, 'auth_token', '64602509e71c4a1e6179c0e92d09c743caa8953db6a4155996e2c8768d88a58d', '[\"*\"]', NULL, '2026-02-28 23:04:14', '2026-02-28 15:04:14', '2026-02-28 15:04:14');
INSERT INTO `personal_access_tokens` VALUES (82, 'App\\Models\\User', 2, 'auth_token', 'c1fe3538f152dd3669de8de8f5027dd69a276a1fd53528fa6e0da98c1ebf3e64', '[\"*\"]', NULL, '2026-03-02 23:32:10', '2026-03-02 15:32:10', '2026-03-02 15:32:10');
INSERT INTO `personal_access_tokens` VALUES (83, 'App\\Models\\User', 2, 'auth_token', '9c0af910d8d37181569acba7a20e4d42c54a13a414390b3dda3c828fbe234592', '[\"*\"]', NULL, '2026-03-03 00:06:21', '2026-03-02 16:06:21', '2026-03-02 16:06:21');
INSERT INTO `personal_access_tokens` VALUES (84, 'App\\Models\\User', 2, 'auth_token', 'a34fdf456ded99a51b935d16363f32ecd9c7603ebd6503211c384008ea1898c2', '[\"*\"]', '2026-03-04 12:06:32', '2026-03-04 12:14:04', '2026-03-04 04:14:04', '2026-03-04 12:06:32');
INSERT INTO `personal_access_tokens` VALUES (85, 'App\\Models\\User', 2, 'auth_token', 'df48129293a10fa5705cb54483fbac507f84bccebe1813b46e4c04346e8bc897', '[\"*\"]', NULL, '2026-03-04 20:17:44', '2026-03-04 12:17:44', '2026-03-04 12:17:44');
INSERT INTO `personal_access_tokens` VALUES (86, 'App\\Models\\User', 2, 'auth_token', '10cbd905f87695fe0fc878088bb6934d8b708f88407825787f08c5952232edda', '[\"*\"]', NULL, '2026-03-04 20:21:11', '2026-03-04 12:21:11', '2026-03-04 12:21:11');
INSERT INTO `personal_access_tokens` VALUES (87, 'App\\Models\\User', 2, 'auth_token', '4c1bcde84fea00edbc916188f20fa3427bc085c973869a3b78427d7484d23d2e', '[\"*\"]', NULL, '2026-03-04 23:00:15', '2026-03-04 15:00:16', '2026-03-04 15:00:16');
INSERT INTO `personal_access_tokens` VALUES (88, 'App\\Models\\User', 2, 'auth_token', 'f18274c7e60c589abfef297134f816e44ec50073cd3f15c5ee026239a99d405d', '[\"*\"]', NULL, '2026-03-05 01:49:33', '2026-03-04 17:49:33', '2026-03-04 17:49:33');
INSERT INTO `personal_access_tokens` VALUES (89, 'App\\Models\\User', 2, 'auth_token', '3a74b66de74b7297005e2553bb2e7b9a2bdbd6f8b48cd24558a3676279bae72a', '[\"*\"]', NULL, '2026-03-05 02:16:46', '2026-03-04 18:16:46', '2026-03-04 18:16:46');
INSERT INTO `personal_access_tokens` VALUES (90, 'App\\Models\\User', 2, 'auth_token', 'f98e94c2ec09131541bdef764c5a5ecf6083ed33cedf0d2e7d1c26bd1a5c6569', '[\"*\"]', NULL, '2026-03-05 03:32:55', '2026-03-04 19:32:55', '2026-03-04 19:32:55');

-- ----------------------------
-- Table structure for plantilla_impresion
-- ----------------------------
DROP TABLE IF EXISTS `plantilla_impresion`;
CREATE TABLE `plantilla_impresion`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `empresa_id` int NOT NULL,
  `mensaje_cabecera` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cabecera_activo` tinyint(1) NOT NULL DEFAULT 1,
  `mensaje_inferior` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `inferior_activo` tinyint(1) NOT NULL DEFAULT 1,
  `mensaje_despedida` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `despedida_activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `plantilla_impresion_empresa_id_unique`(`empresa_id` ASC) USING BTREE,
  CONSTRAINT `plantilla_impresion_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of plantilla_impresion
-- ----------------------------
INSERT INTO `plantilla_impresion` VALUES (1, 2, '<p><strong style=\"color: rgb(220, 38, 38); font-size: 15pt;\">ILIDESAVA &amp; DESAVA S.R.L.</strong></p><p><strong>VENTA POR MAYOR Y MENOR DE ARTICULOS DE CAMPAÑA A PRECIOS BAJOS, MAYOR CALIDAD. \" ILIDESAVA &amp; DESAVA\" EL ALIADO PARA TU EMPRENDIMIENTO</strong></p>', 1, '<p>BCP Cta Cte soles: 1912490742008</p><p>CCI Soles: 002-19100249074200857</p><p>BBVA Cta cte SOLES:0011-0103-01000687-45</p><p>CCI: 011-103-000100068745-97</p><p>CÓDIGO DE RECAUDO: 17238 SOLES</p><p><br></p><p>BBVA Cta cte Dólares: 0011-0103-9101000788-13</p><p>CCI: 011-103-000100078813-91</p><p>CÓDIGO DE RECAUDO: 17239 DÓLARES</p>', 1, '<p>DIOS NUNCA SE CANSARA DE CUIDARTE Y BENDECIRTE DE PELEAR TUS BATALLAS Y DE CUMPLIR TUS SUEÑOS</p>', 1, '2026-02-27 14:33:27', '2026-02-27 14:33:38');
INSERT INTO `plantilla_impresion` VALUES (2, 1, '<p><strong style=\"color: rgb(220, 38, 38); font-size: 15pt;\">ILIDESAVA &amp; DESAVA S.R.Lf.</strong></p><p><strong>VENTA POR MAYOR Y MENOR DE ARTICULOS DE CAMPAÑA A PRECIOS BAJOS, MAYOR CALIDAD. \" ILIDESAVA &amp; DESAVA\" EL ALIADO PARA TU EMPRENDIMIENTO</strong></p>', 1, '<p>BCP Cta Cte soles: 1912490742008</p><p>CCI Soles: 002-19100249074200857</p><p>BBVA Cta cte SOLES:0011-0103-01000687-45</p><p>CCI: 011-103-000100068745-97</p><p>CÓDIGO DE RECAUDO: 17238 SOLES</p><p><br></p><p>BBVA Cta cte Dólares: 0011-0103-9101000788-13</p><p>CCI: 011-103-000100078813-91</p><p>CÓDIGO DE RECAUDO: 17239 DÓLARES</p>', 1, '<p>DIOS NUNCA SE CANSARA DE CUIDARTE Y BENDECIRTE DE PELEAR TUS BATALLAS Y DE CUMPLIR TUS SUEÑOS</p>', 1, '2026-02-27 15:31:39', '2026-02-28 16:48:01');

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
  `fecha_registro` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultimo_ingreso` datetime NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_producto`) USING BTREE,
  UNIQUE INDEX `unique_codigo_empresa_almacen`(`codigo` ASC, `id_empresa` ASC, `almacen` ASC) USING BTREE,
  INDEX `idx_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `idx_almacen`(`almacen` ASC) USING BTREE,
  INDEX `idx_categoria`(`categoria_id` ASC) USING BTREE,
  INDEX `idx_unidad`(`unidad_id` ASC) USING BTREE,
  INDEX `idx_codigo`(`codigo` ASC) USING BTREE,
  INDEX `idx_estado`(`estado` ASC) USING BTREE,
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `productos_ibfk_3` FOREIGN KEY (`unidad_id`) REFERENCES `unidades` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 937 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of productos
-- ----------------------------
INSERT INTO `productos` VALUES (162, 'PROD-001', NULL, 'prueba', 'Descripción opcional', 15.00, 10.50, 13.00, 12.00, 15.00, 99, 0, 0, 1, 49, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, '2026-02-28', '2026-02-27 18:06:07', NULL, '2026-02-27 18:06:07', '2026-02-28 15:14:23');
INSERT INTO `productos` VALUES (320, 'PROD-A1-00001', NULL, 'holaaa', 'sdvcsavsa', 1.00, 23.00, 0.00, 0.00, 0.00, 218, 0, 0, 3, 6, 1, '1', '51121703', '0', '0', 'PEN', '1', 'productos/1772234216_logo2.jpg.jpeg', '2026-03-04', '2026-02-27 18:16:57', NULL, '2026-02-27 23:16:57', '2026-03-04 17:45:07');
INSERT INTO `productos` VALUES (321, 'P00493', NULL, 'LLAVERO SURTIDO, S/M, 2955  MEDIDA: 5 CM', '', 0.30, 0.00, 0.00, 0.00, 0.30, 498188, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (322, 'P00502', NULL, 'LLAVERO SURTIDO, MEDIDA: 5CM S/M, 2955', '', 0.20, 0.00, 0.00, 0.00, 0.20, 321000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (323, 'ST501A', NULL, 'BALINES, BOLITAS DE GEL, S/M CODIGO: ST501A, COMPOSICION:GEL', '', 0.00, 0.00, 0.00, 0.00, 0.00, 264389, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (324, '2955', NULL, 'MINI LLAVERO C/ADORNO, PAQUETE X 100 UNIDADES, CARTON X 10 PAQUETES,  S/M, 2955', '', 0.18, 0.00, 0.00, 0.00, 0.18, 255133, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (325, 'M5', NULL, 'RELOJ PULSERA DIGITAL  DE PLASTICO P/NIÑOS M5', '', 1.55, 0.00, 0.00, 0.00, 1.55, 138943, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (326, 'YXJ127', NULL, 'MINI PICO DE PATO C/ADORNO, S/M, YXJ127', '', 0.05, 0.00, 0.00, 0.00, 0.05, 103149, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (327, 'P00501', NULL, 'AUDIFONO INALAMBRICOS DIVERSOS MODELOS, S/M, M10/A31/X15/Air39  ITEM: F9', '', 4.90, 0.00, 0.00, 0.00, 4.90, 60400, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (328, 'P00494', NULL, 'BRAZALETE PELUCHE, S/M, 1219 DIMENSIONES: 15X21CM', '', 2.25, 0.00, 0.00, 0.00, 2.25, 30912, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (329, 'P00498', NULL, 'ARMABLES', '', 2.59, 0.00, 0.00, 0.00, 2.59, 27000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (330, 'T655', NULL, 'CHALA, CHANCLA, CHANCLETA, SLAPS, S/M, T655  PARA NIÑO, TALLA: 34 -35 (EUR), INYECTADO , SIN TALON, DEJA LIBRE LOS DEDOS DEL PIE, CUBRE EL EMPEINE DEL PIE, CASUAL', '', 2.50, 0.00, 0.00, 0.00, 2.50, 26329, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (331, 'P00499', NULL, 'PELUCHE SURTIDO DE FELPA, S/M, S/M CODIGO:1219, DIMENSIONES:30.00cmx20.00cm', '', 10.00, 0.00, 0.00, 0.00, 10.00, 18960, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (332, 'P00489', NULL, 'AUDIFONO INALAMBRICOS DIVERSOS MODELOS, S/M, BTH-F9-5 ITEM: F9', '', 5.00, 0.00, 0.00, 0.00, 5.00, 16956, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (333, '300-9', NULL, 'SET ESCOLAR ARTISTICO, S/M, 300-9  APLICACION:ESCOLAR DISPOSITIVO:NO RETRÁCTIL ACCESORIO:SET 208 PCS  PRESENTACION:ESTUCHE DE PLÁSTICO de 208 PIEZAS', '', 7.00, 0.00, 0.00, 0.00, 7.00, 14993, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (334, 'P00486', NULL, 'LLAVERO CAMARITA CON DISEÑO DE LABUBU S/M ITEM: 2955', '', 1.00, 0.00, 0.00, 0.00, 1.00, 11806, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (335, '88039', NULL, 'MORRAL JUVENIL, S/M, 88039  MEDIDAS:025.0cmx008.0cmx010.0cm', '', 7.00, 0.00, 0.00, 0.00, 7.00, 10998, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (336, 'Y8809-24', NULL, 'PLUMON 24PCS CAJA X120  Y8809-24', '', 2.90, 0.00, 0.00, 0.00, 2.90, 10440, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (337, '5665', NULL, 'PASTILLA MUSICAL 3X5, S/M, 5665', '', 0.45, 0.00, 0.00, 0.00, 0.45, 10000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (338, 'P00492', NULL, 'PARAGUAS DISEÑOS SURTIDOS, S/M, 2525', '', 3.00, 0.00, 0.00, 0.00, 3.00, 9467, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (339, 'P00490', NULL, 'MINI PARLANTE CON MICROFONO, S/M, K12', '', 7.00, 0.00, 0.00, 0.00, 7.00, 9060, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (340, '24620', NULL, 'CHIP DE MEMORIA PCBA S/M S/M CAPACIDAD 8 GB', '', 2.00, 0.00, 0.00, 0.00, 2.00, 7000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (341, '01006', NULL, 'PERFUMES X 96 PCS COD: 01006', '', 4.00, 0.00, 0.00, 0.00, 4.00, 6904, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (342, '24627', NULL, 'USB 1CZH-1906', '', 7.00, 0.00, 0.00, 0.00, 7.00, 6489, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (343, '2025-46', NULL, '2025-46 - TOMATODO X 120 PCS 2025-46', '', 1.70, 0.00, 0.00, 0.00, 1.70, 5800, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (344, 'MP-01', NULL, 'MINI PULSERA S/M MP-01', '', 0.03, 0.00, 0.00, 0.00, 0.03, 5754, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (345, 'CN922', NULL, 'HELICOPTERO CAPYBARA CAJA X120   CN922', '', 4.00, 0.00, 0.00, 0.00, 4.00, 5232, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (346, 'YXJ120', NULL, 'FUNDA DE SILICONA PARA EL CONTROL DE JUEGO 15CM X 4CM, S/M, YXJ120', '', 1.00, 0.00, 0.00, 0.00, 1.00, 5000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (347, '2025-111', NULL, '2025-111 NECESER X 100 PCS 2025-111', '', 2.90, 0.00, 0.00, 0.00, 2.90, 5000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (348, 'P00500', NULL, 'CAMARA DIGITAL PARA NIÑOS DIFERENTES DISEÑOS, S/M, 1219  MEDIDAS: 10X7X4 CM', '', 6.00, 0.00, 0.00, 0.00, 6.00, 4800, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (349, 'P00488', NULL, 'CAMARA DIGITAL PARA NIÑOS DIFERENTES DISEÑOS, S/M, 1219 MEDIDAS: 10X7X4 CM', '', 7.50, 0.00, 0.00, 0.00, 7.50, 4546, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (350, 'IR-1255', NULL, 'PELUCHES FUGGLER, IR-1255 CODIGO:IR-1255, USUARIO:NIÑO/NIÑA,PRESENTA:BOLSA,', '', 4.50, 0.00, 0.00, 0.00, 4.50, 4200, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (351, '24641', NULL, 'USB MADERA RECTANGULAR', '', 8.00, 0.00, 0.00, 0.00, 8.00, 4009, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (352, '24619', NULL, 'CHIP DE MEMORIA PCBA S/M S/M CAPACIDAD 14.60 GB', '', 2.00, 0.00, 0.00, 0.00, 2.00, 4000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (353, '00358', NULL, 'NO.650C-D24 - JUGUETE PIMBOLL DE SIRENITA X 384 PCS (1.9C/U)', '', 1.90, 0.00, 0.00, 0.00, 1.90, 3840, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (354, 'IR-1254', NULL, 'MONSTRUO TIRA PEDO X 240 PCS IR-1254', '', 4.50, 0.00, 0.00, 0.00, 4.50, 3840, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (355, 'A-5112', NULL, 'TOLLA CAPUCHA CAJA X 200 COD. A-5112', '', 3.15, 0.00, 0.00, 0.00, 3.15, 3800, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (356, 'P00482', NULL, 'TERMO CON TACITA', '', 6.70, 0.00, 0.00, 0.00, 6.70, 3794, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (357, '1219', NULL, 'PELUCHE DE FELPA, S/M CODIGO:1219A,B,C,D,E,F,G,H..., DIMENSIONES:030.0cmx012.0cmx005.0cm  FUENTE DE MOVI:ELECTRICIDAD A TRAVÉS DE PILAS O BATERÍA,USUARIO:NIÑO/NIÑA,PRESENTA:CAJA', '', 12.00, 0.00, 0.00, 0.00, 12.00, 3614, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (358, 'JHV-41', NULL, 'JUGUETES X 720 PCS JHV-41', '', 1.50, 0.00, 0.00, 0.00, 1.50, 3600, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (359, '2025-101', NULL, '2025-101 CAJA DE ALMACENAMIENTO X 60 PCD 2025-101', '', 4.99, 0.00, 0.00, 0.00, 4.99, 3600, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (360, 'D20', NULL, 'RELOJ INTELIGENTE DIVERSOS MODELOS, S/M, D20', '', 5.00, 0.00, 0.00, 0.00, 5.00, 3374, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (361, 'P00399', NULL, 'MOCHILA, S/M, 1219 MEDIDAS:047.0cmx031.0cmx020.0cm, PRESENTACION:3 PIEZAS', '', 30.00, 0.00, 0.00, 0.00, 30.00, 3230, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (362, '24623', NULL, 'CARCASA DE MEMORIA PCBA S/M S/M MADERA BAMBU', '', 1.00, 0.00, 0.00, 0.00, 1.00, 3000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (363, 'C-2630', NULL, 'TACHO DE BASURA CAJA X 60 COD. C-2630', '', 1.75, 0.00, 0.00, 0.00, 1.75, 3000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (364, 'A-6623', NULL, 'AURICULARES BLUETOOTH A-6623 X CAJA 100', '', 5.00, 0.00, 0.00, 0.00, 5.00, 3000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (365, '9333', NULL, 'LEGOS X 600 COD. 9333-9334-9335', '', 2.12, 0.00, 0.00, 0.00, 2.12, 3000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (366, 'GP-452', NULL, 'CARTUCHERA KAWAII SLIM', '', 0.70, 0.00, 0.00, 0.00, 0.70, 2880, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (367, '00356', NULL, 'NO.333R JUGUETE PIMBOLL DE AGUA X 288 PCS', '', 1.57, 0.00, 0.00, 0.00, 1.57, 2880, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (368, 'P00491', NULL, 'ENCENDEDOR ELECTRICO PARA COCINA, RECARGA MEDIANTE USB, S/M, 1912', '', 2.50, 0.00, 0.00, 0.00, 2.50, 2596, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (369, '24624', NULL, 'CARCASA DE MEMORIA PCBA S/M S/M PLASTICO 100%', '', 1.00, 0.00, 0.00, 0.00, 1.00, 2500, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (370, '320C', NULL, 'ESQUINERO DE DUCHA X 24 UND COD 320C', '', 12.50, 0.00, 0.00, 0.00, 12.50, 2206, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (371, 'A-4014', NULL, 'SHORT DE YOGA CAJA X 200 COD. A-4014', '', 4.50, 0.00, 0.00, 0.00, 4.50, 2188, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (372, 'C-1345', NULL, 'SHAMPOO CAMELLIA 500ML CAJA X 40 UND', '', 2.50, 0.00, 0.00, 0.00, 2.50, 2160, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (373, 'YXJ-161', NULL, 'MOCHILA, S/M, YXJ-161,162,163,164,165 MEDIDAS:047.0cmx031.0cmx020.0cm', '', 7.00, 0.00, 0.00, 0.00, 7.00, 2020, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (374, '207', NULL, 'USB MODELO LLAVE DE 16 GB, S/M, S/M', '', 4.60, 0.00, 0.00, 0.00, 4.60, 2000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (375, '1985', NULL, 'PORTAMONEDAS, S/M, 1985  MEDIDAS:008.0cmx008.0cmx002.0cm, PRESENTACION:12 PIEZAS', '', 2.20, 0.00, 0.00, 0.00, 2.20, 2000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (376, 'AMI2015-22GRC', NULL, 'MINI NOLITAS CRECIENTES S/M AMI2015-22GRC', '', 0.17, 0.00, 0.00, 0.00, 0.17, 2000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (377, 'C-1272', NULL, 'HISOPO CAJA X 240 COD. C-1272', '', 0.50, 0.00, 0.00, 0.00, 0.50, 1894, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (378, '15-115', NULL, 'CAPUCHINA EN CARRO X 72 PCS', '', 9.00, 0.00, 0.00, 0.00, 9.00, 1800, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (379, 'XX004', NULL, 'MUÑECO VOLADOR', '', 9.50, 0.00, 0.00, 0.00, 9.50, 1572, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (380, 'A-6624', NULL, 'AURICULAR A-6624 CAJA X 100', '', 7.00, 0.00, 0.00, 0.00, 7.00, 1500, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (381, 'C-2334', NULL, 'PIJAMA DE ENCAJE X 300 UND', '', 4.00, 0.00, 0.00, 0.00, 4.00, 1490, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (382, 'JHV-36', NULL, 'JUGUETE BRAINROT X 240 PCS COD. JHV-36 - HH85', '', 3.50, 0.00, 0.00, 0.00, 3.50, 1440, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (383, 'A-3920', NULL, 'PANTALON DE YOGA CJA X 150 COD. A-3920', '', 6.00, 0.00, 0.00, 0.00, 6.00, 1350, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (384, '00354', NULL, 'YT-190 - SET DE PISTOLA DE JUGUETE X 132 PCS (4.50C/U)', '', 4.50, 0.00, 0.00, 0.00, 4.50, 1320, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (385, 'MIA-2023M', NULL, 'MORRAL PARA NIÑOS, S/M, MIA-2023M', '', 2.30, 0.00, 0.00, 0.00, 2.30, 1314, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (386, 'JHV-116', NULL, 'JUGUETE X 144 PCS COD. JHV-116', '', 13.00, 0.00, 0.00, 0.00, 13.00, 1296, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (387, 'A-829-2', NULL, 'SET DE TAPER Y BEBETODO A-829#2', '', 3.50, 0.00, 0.00, 0.00, 3.50, 1221, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (388, 'B-2012', NULL, 'PIZARRA LCD CAJA X120 B-2012', '', 4.00, 0.00, 0.00, 0.00, 4.00, 1162, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (389, 'B-2011', NULL, 'PIZARRA LCD CAJA X120 B-2011', '', 4.00, 0.00, 0.00, 0.00, 4.00, 1040, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (390, 'A-935-2', NULL, 'TAPER + TOMATODO A-935#2', '', 3.50, 0.00, 0.00, 0.00, 3.50, 1020, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (391, 'MIA-2024U', NULL, 'PELUCHE, S/M, MIA-2024U', '', 2.30, 0.00, 0.00, 0.00, 2.30, 1010, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (392, '24621', NULL, 'CHIP DE MEMORIA PCBA S/M S/M CAPACIDAD 1 GB', '', 2.00, 0.00, 0.00, 0.00, 2.00, 1000, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (393, '15-120', NULL, 'JUGUETES', '', 9.00, 0.00, 0.00, 0.00, 9.00, 936, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (394, 'YXJ-174', NULL, 'PARAGUAS, S/M, YXJ-174-A,B,C.', '', 3.80, 0.00, 0.00, 0.00, 3.80, 873, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (395, 'P00222', NULL, 'TAZON DE ACERO CAPACIDAD 240ML , S/M, S/M', '', 1.40, 0.00, 0.00, 0.00, 1.40, 842, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (396, 'MIA-2023H', NULL, 'MOCHILA, S/M, MIA-2023 H', '', 4.80, 0.00, 0.00, 0.00, 4.80, 832, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (397, 'JTB-44', NULL, 'LEGOS IMANTADOS X 36 PCS JTB-44', '', 25.60, 0.00, 0.00, 0.00, 25.60, 828, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (398, '24644', NULL, 'USB CUERO IMAN CLASICO 16GB', '', 7.00, 0.00, 0.00, 0.00, 7.00, 750, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (399, 'PP-3', NULL, 'SET PAPEL TISSUE - CAPIBARA', '', 1.50, 0.00, 0.00, 0.00, 1.50, 720, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (400, 'PP-2', NULL, 'SET PAPEL TISSUE - FROG', '', 1.50, 0.00, 0.00, 0.00, 1.50, 720, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (401, '01135', NULL, 'MBL-124 MUÑECAS X 48 PCS', '', 13.17, 0.00, 0.00, 0.00, 13.17, 720, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (402, '01137', NULL, 'MBL-126 MUÑECAS X 48 PCS 01137', '', 12.98, 0.00, 0.00, 0.00, 12.98, 720, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (403, 'MIA-2023A', NULL, 'PELUCHE, S/M, MIA-2023A', '', 2.30, 0.00, 0.00, 0.00, 2.30, 704, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (404, '44206496', NULL, 'TRENCITOS DE JUGUETES', '', 3.43, 0.00, 0.00, 0.00, 3.43, 702, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (405, 'SYD-CD032', NULL, 'BARRA LED SYD-CD032', '', 1.50, 0.00, 0.00, 0.00, 1.50, 600, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (406, '0000287', NULL, 'REPUESTO DE PROTECCION FACIAL', '', 0.31, 0.00, 0.00, 0.00, 0.31, 600, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (407, '2025-165', NULL, 'BANCA BRAINSTON X 60 PCS', '', 7.00, 0.00, 0.00, 0.00, 7.00, 600, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (408, 'MIA-2023W', NULL, 'PELUCHE, S/M, MIA-2023 W', '', 2.30, 0.00, 0.00, 0.00, 2.30, 586, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (409, 'PP-1', NULL, 'SET PAPEL TISSUE - SWEET', '', 1.50, 0.00, 0.00, 0.00, 1.50, 576, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (410, '2025-1014', NULL, '2025-1014 TOMATODO X 40 PCS 2025-1014', '', 8.99, 0.00, 0.00, 0.00, 8.99, 555, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (411, 'YXJ108', NULL, 'TERMO DE 600ML CON DISEÑO, S/M, YXJ108', '', 4.50, 0.00, 0.00, 0.00, 4.50, 500, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (412, 'M38', NULL, 'M38 AUDIFONO V5.3 X 100 PCS', '', 5.50, 0.00, 0.00, 0.00, 5.50, 500, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (413, 'YXJ08', NULL, 'TERMO 750 ML, S/M, YXJ08', '', 4.70, 0.00, 0.00, 0.00, 4.70, 486, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (414, '01138', NULL, 'MBL-253 MUÑECAS X 48 PCS 01138', '', 11.98, 0.00, 0.00, 0.00, 11.98, 480, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (415, '1912-A', NULL, 'CAMARA DE ESPEJO RETROSIVOR PARA AUTO, S/M, 1912-A   BATERIA 450MAH', '', 25.00, 0.00, 0.00, 0.00, 25.00, 450, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (416, 'GP-453', NULL, 'CARTUCHERA KIDS MIX LINTERNA', '', 1.30, 0.00, 0.00, 0.00, 1.30, 432, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (417, '0000429', NULL, 'MOCHILA DE NIÑO DRAGON BALL', '', 8.18, 0.00, 0.00, 0.00, 8.18, 430, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (418, '24637', NULL, 'MULTIPUERTO V8 / TIPO C', '', 4.00, 0.00, 0.00, 0.00, 4.00, 400, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (419, '0000284', NULL, 'CF-SALSA CUCHARITA', '', 0.24, 0.00, 0.00, 0.00, 0.24, 400, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (420, 'MIA-2024AA', NULL, 'PELUCHE, S/M, MIA-2024AA', '', 3.20, 0.00, 0.00, 0.00, 3.20, 384, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (421, '00355', NULL, 'YT-191 - SET DE PISTOLA DE JUGUETE X 78 PCS (7.50C/U)', '', 7.50, 0.00, 0.00, 0.00, 7.50, 382, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (422, 'GP-450', NULL, 'CARTUCHERA SHARP UNICORN KIDS', '', 1.30, 0.00, 0.00, 0.00, 1.30, 360, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (423, '00352', NULL, 'CAT-480 JUGUETE DE CONSTRUCCION PARA NIÑOS X 36 PCS', '', 15.00, 0.00, 0.00, 0.00, 15.00, 360, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (424, '0001528', NULL, 'MOCHILA MC 1020', '', 23.39, 0.00, 0.00, 0.00, 23.39, 342, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (425, '0000280', NULL, 'CUCHARITA AD3', '', 0.35, 0.00, 0.00, 0.00, 0.35, 300, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (426, '62517490', NULL, 'TAXA CERAMICA 400ML/ S/M YGS-105', '', 1.56, 0.00, 0.00, 0.00, 1.56, 283, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (427, '0000979', NULL, 'MINI ROCEADOR S/M BOTELLA TOCADO / ST-2030ML', '', 0.21, 0.00, 0.00, 0.00, 0.21, 280, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (428, 'YXJ07', NULL, 'TERMO 500 ML, S/M, YXJ07', '', 3.70, 0.00, 0.00, 0.00, 3.70, 276, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (429, '49541739', NULL, 'PLUSH TOYS THE MONSTER', '', 7.80, 0.00, 0.00, 0.00, 7.80, 250, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (430, 'C-1346', NULL, 'SHAMPOO CLEAN 500 ML CAJA X 35', '', 2.50, 0.00, 0.00, 0.00, 2.50, 245, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (431, '01139', NULL, 'MBL-254 MUÑECAS X 24 PCS 01139', '', 17.98, 0.00, 0.00, 0.00, 17.98, 240, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (432, 'P00223', NULL, 'TAZON DE ACERO CAPACIDAD: 140 ML , S/M, S/M', '', 1.00, 0.00, 0.00, 0.00, 1.00, 220, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (433, '2955-H', NULL, 'PELUCHE, S/M, 2955-H', '', 2.30, 0.00, 0.00, 0.00, 2.30, 200, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (434, 'SOF-34', NULL, 'MOCHILA UNICORNIO ARCOIRIS', '', 4.00, 0.00, 0.00, 0.00, 4.00, 200, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (435, '0001009', NULL, 'CAJA PERCHERO NA190179', '', 1.04, 0.00, 0.00, 0.00, 1.04, 200, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (436, 'M25', NULL, 'M25 AUDIFONOS M25 X 100 PCS', '', 5.50, 0.00, 0.00, 0.00, 5.50, 200, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (437, '0001494', NULL, 'TAPER DE PLASTIO S/M TIPO LONCHERA / X 110-1', '', 0.76, 0.00, 0.00, 0.00, 0.76, 199, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (438, 'P00225', NULL, 'TAZON DE ACERO CAPACIDAD: 300 ML   , S/M, S/M', '', 2.35, 0.00, 0.00, 0.00, 2.35, 188, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (439, 'A-2895', NULL, 'ARRANCADOR DE BATERIA AUTO CAJA X 10COD. A-2895', '', 50.00, 0.00, 0.00, 0.00, 50.00, 180, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (440, '0000121', NULL, 'ST24343B / MINI MOCHILA PELUCHE S/M SINTETICO', '', 7.60, 0.00, 0.00, 0.00, 7.60, 170, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (441, 'ZDNSC012-16', NULL, 'BICICLETA MICKEY ARO 16 X 12', '', 110.00, 0.00, 0.00, 0.00, 110.00, 165, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (442, 'GP-456', NULL, 'CARTUCHERA KAWAI KIDS BASIC', '', 1.30, 0.00, 0.00, 0.00, 1.30, 160, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (443, '24645', NULL, 'USB CUERO CON BROCHE 16GB', '', 7.00, 0.00, 0.00, 0.00, 7.00, 150, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (444, 'AMIR-2025', NULL, 'SET DE BAÑO S/M AMIR-2025', '', 19.00, 0.00, 0.00, 0.00, 19.00, 150, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (445, '0000684', NULL, 'TOALLITAS HUMEDAS', '', 1.95, 0.00, 0.00, 0.00, 1.95, 150, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (446, '0000374', NULL, 'ST25822H / ART. DE FIESTA SOMBRERO S/M PARA FIESTA', '', 2.50, 0.00, 0.00, 0.00, 2.50, 132, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (447, '61020748', NULL, 'CAJA KITCHEN FAUCET NA4613V', '', 1.42, 0.00, 0.00, 0.00, 1.42, 120, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (448, 'YXJ123', NULL, 'PURIFICADOR DE AGUA C/ACCESORIOS, DESARMADO, S/M, YXJ123   POTENCIA 3000W', '', 22.50, 0.00, 0.00, 0.00, 22.50, 119, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (449, 'YXJ09', NULL, 'TERMO 750 ML, S/M, YXJ09', '', 3.70, 0.00, 0.00, 0.00, 3.70, 118, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (450, '0000394', NULL, 'GUANTES PARA NIÑO DE COLORES  ST24GS09', '', 0.34, 0.00, 0.00, 0.00, 0.34, 101, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (451, '00233', NULL, 'GOROO M. MAZZE COD: DM-3401', '', 3.17, 0.00, 0.00, 0.00, 3.17, 100, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (452, '0000135', NULL, 'ST2409FM-0C/ ADORNO ROSITAA S/M SINTETICO', '', 0.31, 0.00, 0.00, 0.00, 0.31, 100, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (453, '0000078', NULL, 'J37 CUCHARITA', '', 2.79, 0.00, 0.00, 0.00, 2.79, 100, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (454, '0000169', NULL, 'SL-D060-8P/ GLOBOS S/M TIPO CORAZON PARA SAN VALENTIN', '', 0.53, 0.00, 0.00, 0.00, 0.53, 100, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (455, '0000328', NULL, 'SALTYA SOGA S/M DE PLASTICO S5014', '', 0.85, 0.00, 0.00, 0.00, 0.85, 100, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (456, '0000553', NULL, 'TAPER S/M DE PLASTICO / 100-1', '', 0.85, 0.00, 0.00, 0.00, 0.85, 100, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (457, '0000201', NULL, 'UND.OREJERAS M/MAZZE P/.NIÑO COD DM-5876', '', 2.44, 0.00, 0.00, 0.00, 2.44, 100, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (458, '69346863', NULL, 'GUANTE M/. RACE READY COD DM-3281', '', 1.44, 0.00, 0.00, 0.00, 1.44, 100, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (459, 'MC-374', NULL, 'BANCA PLEGABLE X 20 COD: MC-374', '', 9.00, 0.00, 0.00, 0.00, 9.00, 100, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (460, 'MC-04', NULL, 'ESQUINERO DE DUCHA X 20 PCS', '', 13.00, 0.00, 0.00, 0.00, 13.00, 100, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (461, '00101', NULL, 'TAZA GK-22', '', 1.27, 0.00, 0.00, 0.00, 1.27, 96, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (462, '00584', NULL, 'BLOQUES DIDACTICO X 120 PCS  9333', '', 3.00, 0.00, 0.00, 0.00, 3.00, 83, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (463, 'ZDNSC034-12', NULL, 'BICICLETA MICKEY ARO 12 X 12', '', 110.00, 0.00, 0.00, 0.00, 110.00, 65, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (464, '001040', NULL, 'INCH PLATE HAND PAINTED', '', 2.09, 0.00, 0.00, 0.00, 2.09, 60, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (465, '0000285', NULL, 'CUBETA 655602', '', 2.51, 0.00, 0.00, 0.00, 2.51, 60, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (466, 'ZDNSC033-12', NULL, 'BICICLETA MICKEY ARO 12 X 12', '', 110.00, 0.00, 0.00, 0.00, 110.00, 59, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (467, '0000824', NULL, 'RESPUESTO DE PROTECCION FACIAL / 686 (1T)', '', 0.63, 0.00, 0.00, 0.00, 0.63, 58, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (468, '0000300', NULL, 'POSA OLLA A5754', '', 1.06, 0.00, 0.00, 0.00, 1.06, 54, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (469, '43144947', NULL, 'GUANTES DE POLIESTER SIN DEDO PAE=PE RN-046', '', 1.00, 0.00, 0.00, 0.00, 1.00, 50, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (470, '44215027', NULL, 'BOLSO DE MANO SINTETICO 28X11X21CM RN-028', '', 14.55, 0.00, 0.00, 0.00, 14.55, 50, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (471, '001072', NULL, 'BOLSO PELUCHE RN-026', '', 7.21, 0.00, 0.00, 0.00, 7.21, 50, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (472, 'P00495', NULL, 'RN-046 GUANTES DE POLIESTER SIN DEDO , PAR=PE', '', 1.00, 0.00, 0.00, 0.00, 1.00, 50, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (473, '0001072', NULL, 'BOLSO PELUCHE RN-026', '', 6.11, 0.00, 0.00, 0.00, 6.11, 45, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (474, 'M106', NULL, 'HUMIFICADOR 20 ML,  5V-1A, S/M, M106 MEDIDA: 143X88X88MM  	REF: MONG CHONG', '', 4.60, 0.00, 0.00, 0.00, 4.60, 44, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (475, 'ZDNSC013-16', NULL, 'BICICLETA FROZEN ARO 16', '', 110.00, 0.00, 0.00, 0.00, 110.00, 41, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (476, '0000224', NULL, 'BOLSO PELUCHE RN-001', '', 15.10, 0.00, 0.00, 0.00, 15.10, 38, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (477, '62245408', NULL, 'MOCHILA PARA NIÑOS MC2024', '', 28.80, 0.00, 0.00, 0.00, 28.80, 33, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (478, '0000825', NULL, 'RESPUESTO DE PROTECCION FACIAL /686 (1L)', '', 1.50, 0.00, 0.00, 0.00, 1.50, 33, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (479, '59859679', NULL, 'GUANTES D/ INVIERNO YX1032', '', 2.40, 0.00, 0.00, 0.00, 2.40, 30, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (480, '60057612', NULL, 'GUABTES D/INVIERNO P/NIÑAS YX1070', '', 3.12, 0.00, 0.00, 0.00, 3.12, 30, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (481, '43062647', NULL, 'GUANTES DE POLIESTER PAR=PE RN-045', '', 1.00, 0.00, 0.00, 0.00, 1.00, 30, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (482, '0000231', NULL, 'P2612 TOMATODO', '', 4.75, 0.00, 0.00, 0.00, 4.75, 30, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (483, '0000362', NULL, 'BOLSO PELUCHE RN-041', '', 11.42, 0.00, 0.00, 0.00, 11.42, 20, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (484, '0000751', NULL, 'MINI MOCHILA PELUCHE S/M SINTETICO / ST24344B', '', 7.94, 0.00, 0.00, 0.00, 7.94, 20, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (485, '000336', NULL, 'CASACA (CHAMARRA) DE MUJER S/M P-555', '', 30.00, 0.00, 0.00, 0.00, 30.00, 19, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (486, '0001121', NULL, 'SET DE MOCHILA S/M S/M CON RUEDAS C/MADERA C/LONCHERA', '', 35.59, 0.00, 0.00, 0.00, 35.59, 19, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (487, '0000782', NULL, 'MINI MOCHILA PELUCHE S/M SINTETICO / ST24349B', '', 7.39, 0.00, 0.00, 0.00, 7.39, 19, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (488, 'YXJ118', NULL, 'CONTROL INALAMBRICO CON CABLE USB PARA PC, S/M, HS-SW570  ITEM: YXJ118 / YXJ119', '', 13.50, 0.00, 0.00, 0.00, 13.50, 17, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (489, 'C-1407', NULL, 'OLLA ARROCERA 900W CJA X 6 UND', '', 23.00, 0.00, 0.00, 0.00, 23.00, 16, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (490, '84223587', NULL, 'MINI MONOPOD CH-2189', '', 3.24, 0.00, 0.00, 0.00, 3.24, 15, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (491, 'C-1408', NULL, 'OLLA ARROCERA DE 900W CAJA X 6 UND', '', 23.00, 0.00, 0.00, 0.00, 23.00, 14, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (492, '0000748', NULL, 'MINI MOCHILA PELUCHE S/M SINTETICO / ST24341B', '', 7.70, 0.00, 0.00, 0.00, 7.70, 12, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (493, 'ZDNSC011-16', NULL, 'BICICLETAS SURTIDAS DISNEY', '', 110.00, 0.00, 0.00, 0.00, 110.00, 12, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (494, '00576', NULL, 'DIE CAST METAL CAR TOYS QZ614-4C', '', 6.96, 0.00, 0.00, 0.00, 6.96, 10, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (495, '65633028', NULL, 'BOLSO 5 PZS YH559-24B', '', 48.40, 0.00, 0.00, 0.00, 48.40, 10, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (496, '0000225', NULL, 'RN-016 CALENTADOR DE TAZA DE CAFE, 220V', '', 6.72, 0.00, 0.00, 0.00, 6.72, 10, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (497, 'A-6525', NULL, 'MOTOCICLETA ELECTRICA DE DINOSAURIO A-6525', '', 170.00, 0.00, 0.00, 0.00, 170.00, 10, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (498, 'ZDNSC031-12', NULL, 'BICICLETAS SURTIDAS DISNEY', '', 110.00, 0.00, 0.00, 0.00, 110.00, 9, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (499, 'ZMVSC009-16', NULL, 'BICICLETA SPIDER-MAN ARO 16', '', 110.00, 0.00, 0.00, 0.00, 110.00, 7, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (500, 'ZMVSC009-12', NULL, 'BICICLETAS SURTIDAS DISNEY', '', 110.00, 0.00, 0.00, 0.00, 110.00, 4, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (501, '0000324', NULL, 'SARTEN N°20 980982001', '', 17.41, 0.00, 0.00, 0.00, 17.41, 3, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (502, 'ZMVSC019-16', NULL, 'BICICLETA SPIDERMAN ARO 16 X 12', '', 110.00, 0.00, 0.00, 0.00, 110.00, 3, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (503, 'ZDNSC030-12', NULL, 'BICICLETA FROZEN ARO 12 X 12', '', 110.00, 0.00, 0.00, 0.00, 110.00, 2, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (504, 'ZDNSC032-16', NULL, 'BICICLETA MINNIE ARO 16 X 12', '', 110.00, 0.00, 0.00, 0.00, 110.00, 2, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (505, 'P00138', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91146, VI:HL55WFB21R1D91146,MO:24D091146, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 ...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91146, VI:HL55WFB21R1D91146,MO:24D091146, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (506, 'P00140', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91148, VI:HL55WFB21R1D91148, MO:24D091148, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91148, VI:HL55WFB21R1D91148, MO:24D091148, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (507, 'P00142', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91150, VI:HL55WFB21R1D91150, MO:24D091150, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91150, VI:HL55WFB21R1D91150, MO:24D091150, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (508, 'P00148', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91156, VI:HL55WFB21R1D91156, MO:24D091156, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91156, VI:HL55WFB21R1D91156, MO:24D091156, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (509, 'P00149', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91157, VI:HL55WFB21R1D91157, MO:24D091157, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91157, VI:HL55WFB21R1D91157, MO:24D091157, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (510, 'P00152', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91160, VI:HL55WFB21R1D91160, MO:24D091160, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91160, VI:HL55WFB21R1D91160, MO:24D091160, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (511, 'P00153', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91161, VI:HL55WFB21R1D91161, MO:24D091161, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91161, VI:HL55WFB21R1D91161, MO:24D091161, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (512, 'P00154', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91162, VI:HL55WFB21R1D91162, MO:24D091162, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91162, VI:HL55WFB21R1D91162, MO:24D091162, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (513, 'P00155', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91163, VI:HL55WFB21R1D91163, MO:24D091163, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91163, VI:HL55WFB21R1D91163, MO:24D091163, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (514, 'P00157', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91165, VI:HL55WFB21R1D91165, MO:24D091165, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91165, VI:HL55WFB21R1D91165, MO:24D091165, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (515, 'P00158', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91166, VI:HL55WFB21R1D91166, MO:24D091166, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91166, VI:HL55WFB21R1D91166, MO:24D091166, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (516, 'P00159', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91167, VI:HL55WFB21R1D91167, MO:24D091167, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91167, VI:HL55WFB21R1D91167, MO:24D091167, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (517, 'P00160', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91168, VI:HL55WFB21R1D91168, MO:24D091168, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91168, VI:HL55WFB21R1D91168, MO:24D091168, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (518, 'P00161', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91169, VI:HL55WFB21R1D91169, MO:24D091169, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91169, VI:HL55WFB21R1D91169, MO:24D091169, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (519, 'P00164', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91172, VI:HL55WFB21R1D91172, MO:24D091172, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91172, VI:HL55WFB21R1D91172, MO:24D091172, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (520, 'P00168', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000172, VI:HU4DWH402R1000172, MO:240220794, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000172, VI:HU4DWH402R1000172, MO:240220794, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (521, 'P00172', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000176, VI:HU4DWH402R1000176, MO:240220798, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000176, VI:HU4DWH402R1000176, MO:240220798, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (522, 'P00174', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000178, VI:HU4DWH402R1000178, MO:240220800, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000178, VI:HU4DWH402R1000178, MO:240220800, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (523, 'P00176', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000180, VI:HU4DWH402R1000180, MO:240220802, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000180, VI:HU4DWH402R1000180, MO:240220802, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (524, 'P00178', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000182, VI:HU4DWH402R1000182, MO:240220804, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000182, VI:HU4DWH402R1000182, MO:240220804, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (525, 'P00179', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000183, VI:HU4DWH402R1000183, MO:240220805, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000183, VI:HU4DWH402R1000183, MO:240220805, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (526, 'P00183', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000187, VI:HU4DWH402R1000187, MO:240220809, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000187, VI:HU4DWH402R1000187, MO:240220809, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (527, 'P00184', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000188, VI:HU4DWH402R1000188, MO:240220810, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000188, VI:HU4DWH402R1000188, MO:240220810, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (528, 'P00189', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000193, VI:HU4DWH402R1000193, MO:240220815, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000193, VI:HU4DWH402R1000193, MO:240220815, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (529, 'P00191', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000195, VI:HU4DWH402R1000195, MO:240220817, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000195, VI:HU4DWH402R1000195, MO:240220817, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (530, 'P00193', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000197, VI:HU4DWH402R1000197, MO:240220819, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000197, VI:HU4DWH402R1000197, MO:240220819, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (531, 'P00194', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000198, VI:HU4DWH402R1000198, MO:240220820, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000198, VI:HU4DWH402R1000198, MO:240220820, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (532, 'P00199', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000203, VI:HU4DWH402R1000203, MO:240220825, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000203, VI:HU4DWH402R1000203, MO:240220825, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (533, 'P00200', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000204, VI:HU4DWH402R1000204, MO:240220826, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000204, VI:HU4DWH402R1000204, MO:240220826, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (534, 'P00203', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000207, VI:HU4DWH402R1000207, MO:240220829, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000207, VI:HU4DWH402R1000207, MO:240220829, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (535, 'P00205', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000209, VI:HU4DWH402R1000209, MO:240220831, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000209, VI:HU4DWH402R1000209, MO:240220831, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (536, 'P00207', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000211, VI:HU4DWH402R1000211, MO:240220833, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000211, VI:HU4DWH402R1000211, MO:240220833, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (537, 'P00212', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000216, VI:HU4DWH402R1000216, MO:240220838, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000216, VI:HU4DWH402R1000216, MO:240220838, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (538, 'P00246', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005231,VI:202410180R1005231, MO:2410746,CC:0,CO:ELECTRICO,SNTT:0 , CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS, PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3, TE:ELEC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005231,VI:202410180R1005231, MO:2410746,CC:0,CO:ELECTRICO,SNTT:0 , CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS, PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3, TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1700.00, 0.00, 0.00, 0.00, 1700.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (539, 'P00247', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005232,VI:202410180R2005232,MO:2410747,CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005232,VI:202410180R2005232,MO:2410747,CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (540, 'P00251', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R6005236,VI:202410180R6005236,MO:2410745, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R6005236,VI:202410180R6005236,MO:2410745, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (541, 'P00253', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R8005238,VI:202410180R8005238,MO:2410738, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R8005238,VI:202410180R8005238,MO:2410738, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (542, 'P00255', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005240,VI:202410180R1005240,MO:2410741,CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005240,VI:202410180R1005240,MO:2410741,CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (543, 'P00256', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005241,VI:202410180R2005241,MO:2410749, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005241,VI:202410180R2005241,MO:2410749, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (544, 'P00258', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R4005243,VI:202410180R4005243,MO:2410753, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R4005243,VI:202410180R4005243,MO:2410753, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (545, 'P00263', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R9005248,VI:202410180R9005248,MO:2410757, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R9005248,VI:202410180R9005248,MO:2410757, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (546, 'P00264', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005249,VI:202410180R1005249,MO:2410756, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005249,VI:202410180R1005249,MO:2410756, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (547, 'P00265', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005250,VI:202410180R2005250,MO:2410755, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005250,VI:202410180R2005250,MO:2410755, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (548, 'P00268', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R5005253,VI:202410180R5005253,MO:2410762,  CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRI...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R5005253,VI:202410180R5005253,MO:2410762,  CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (549, 'P00272', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R9005257,VI:202410180R9005257,MO:2410758, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R9005257,VI:202410180R9005257,MO:2410758, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (550, 'P00273', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005258,VI:202410180R1005258,MO:2410759, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005258,VI:202410180R1005258,MO:2410759, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (551, 'P00274', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005259,VI:202410180R2005259,MO:2410760, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005259,VI:202410180R2005259,MO:2410760, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (552, 'P00276', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024  CH:202422410R0180046, VI:202422410R0180046, MO:QZ48v500w2408010364,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024  CH:202422410R0180046, VI:202422410R0180046, MO:QZ48v500w2408010364,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 400.00, 0.00, 0.00, 0.00, 400.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (553, 'P00279', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024CH:202422410R0080044,VI:202422410R0080044,MO:QZ48v500w2408010333, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELE...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024CH:202422410R0080044,VI:202422410R0080044,MO:QZ48v500w2408010333, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 400.00, 0.00, 0.00, 0.00, 400.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (554, 'P00289', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R7080020,VI:202422410R7080020,MO:QZ48v500w2410141021, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R7080020,VI:202422410R7080020,MO:QZ48v500w2410141021, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (555, 'P00293', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0980030,VI:202422410R0980030,MO:QZ48v500w2410141005,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELE...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0980030,VI:202422410R0980030,MO:QZ48v500w2410141005,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (556, 'P00299', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080077,VI:202422410R2080077,MO:QZ48v500w2410141046,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELE...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080077,VI:202422410R2080077,MO:QZ48v500w2410141046,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (557, 'P00304', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0980036,VI:202422410R0980036,MO:QZ48v500w2410141042, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0980036,VI:202422410R0980036,MO:QZ48v500w2410141042, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (558, 'P00305', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R4080080,VI:202422410R4080080,MO:QZ48v500w2410141016, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R4080080,VI:202422410R4080080,MO:QZ48v500w2410141016, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (559, 'P00306', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080095,VI:202422410R0080095,MO:QZ48v500w2410141026, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080095,VI:202422410R0080095,MO:QZ48v500w2410141026, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (560, 'P00309', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080072,VI:202422410R8080072,MO:QZ48v500w2410141029, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080072,VI:202422410R8080072,MO:QZ48v500w2410141029, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (561, 'P00310', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080070,VI:202422410R9080070,MO:QZ48v500w2408010326, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080070,VI:202422410R9080070,MO:QZ48v500w2408010326, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (562, 'P00311', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R1080084,VI:202422410R1080084,MO:QZ48v500w2410141049,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELE...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R1080084,VI:202422410R1080084,MO:QZ48v500w2410141049,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (563, 'P00320', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R7080097,VI:202422410R7080097,MO:QZ48v500w2410141040,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELEC...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R7080097,VI:202422410R7080097,MO:QZ48v500w2410141040,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (564, 'P00321', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080066,VI:202422410R3080066,MO:QZ48v500w2410141030,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELEC...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080066,VI:202422410R3080066,MO:QZ48v500w2410141030,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (565, 'P00325', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080093,VI:202422410R9080093,MO:QZ48v500w2407172331,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080093,VI:202422410R9080093,MO:QZ48v500w2407172331,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (566, 'P00326', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080059,VI:202422410R2080059,MO:QZ48v500w2408010373,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADA,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080059,VI:202422410R2080059,MO:QZ48v500w2408010373,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADA,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (567, 'P00327', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080103,VI:202422410R9080103,MO:QZ48v500w2408010311,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080103,VI:202422410R9080103,MO:QZ48v500w2408010311,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (568, 'P00328', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080039,VI:202422410R0080039,MO:QZ48v500w2408010362,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080039,VI:202422410R0080039,MO:QZ48v500w2408010362,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (569, 'P00331', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080022,VI:202422410R8080022,MO:QZ48v500w2408010349,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080022,VI:202422410R8080022,MO:QZ48v500w2408010349,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (570, 'P00332', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080063,VI:202422410R3080063,MO:QZ48v500w2410141011,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080063,VI:202422410R3080063,MO:QZ48v500w2410141011,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (571, 'P00335', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R5080006,VI:202422410R5080006,MO:QZ48v500w2410141025,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R5080006,VI:202422410R5080006,MO:QZ48v500w2410141025,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (572, 'P00339', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080048,VI:202422410R0080048,MO:QZ48v500w2408010381,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080048,VI:202422410R0080048,MO:QZ48v500w2408010381,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (573, 'P00343', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080015,VI:202422410R9080015,MO:QZ48v500w2410141048,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080015,VI:202422410R9080015,MO:QZ48v500w2410141048,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (574, 'P00344', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080054,VI:202422410R0080054,MO:QZ48v500w2408010380,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080054,VI:202422410R0080054,MO:QZ48v500w2408010380,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (575, 'P00348', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080081,VI:202422410R3080081,MO:QZ48v500w2407172334,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080081,VI:202422410R3080081,MO:QZ48v500w2407172334,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (576, 'P00349', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080094,VI:202422410R8080094,MO:QZ48v500w2410141002,,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELEC...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080094,VI:202422410R8080094,MO:QZ48v500w2410141002,,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (577, 'P00351', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080004,VI:202422410R0080004,MO:QZ48v500w2410141010,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080004,VI:202422410R0080004,MO:QZ48v500w2410141010,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (578, 'P00352', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R5080005,VI:202422410R5080005,MO:QZ48v500w2408010399,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R5080005,VI:202422410R5080005,MO:QZ48v500w2408010399,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (579, 'P00353', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R6080086,VI:202422410R6080086,MO:QZ48v500w2408010321,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R6080086,VI:202422410R6080086,MO:QZ48v500w2408010321,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (580, 'P00354', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R1080089,VI:202422410R1080089,MO:QZ48v500w2408010329,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R1080089,VI:202422410R1080089,MO:QZ48v500w2408010329,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (581, 'P00355', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080043,VI:202422410R2080043,MO:QZ48v500w2410141027,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080043,VI:202422410R2080043,MO:QZ48v500w2410141027,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (582, 'P00356', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080045,VI:202422410R3080045,MO:QZ48v500w2410141034,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080045,VI:202422410R3080045,MO:QZ48v500w2410141034,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (583, 'P00359', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080021,VI:202422410R2080021,MO:QZ48v500w2408010390,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080021,VI:202422410R2080021,MO:QZ48v500w2408010390,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (584, 'P00361', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R4080083,VI:202422410R4080083,MO:QZ48v500w2408010330,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R4080083,VI:202422410R4080083,MO:QZ48v500w2408010330,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (585, 'P00364', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R7080057,VI:202422410R7080057,MO:QZ48v500w2408010352,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRI...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R7080057,VI:202422410R7080057,MO:QZ48v500w2408010352,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (586, 'P00367', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R1080034,VI:202422410R1080034,MO:QZ48v500w2408010305,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRI...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R1080034,VI:202422410R1080034,MO:QZ48v500w2408010305,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (587, 'P00368', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080061,VI:202422410R2080061,MO:QZ48v500w2408010397,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080061,VI:202422410R2080061,MO:QZ48v500w2408010397,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (588, 'P00372', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R6080027,VI:202422410R6080027,MO:QZ48v500w2408081380,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRI...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R6080027,VI:202422410R6080027,MO:QZ48v500w2408081380,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (589, 'P00374', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080106,VI:202422410R8080106,MO:QZ48v500w2407239327,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080106,VI:202422410R8080106,MO:QZ48v500w2407239327,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (590, 'P00378', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:Y666278Z6R3500029,VI:Y666278Z6R3500029,MO:YJ48v500w2406131949,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:Y666278Z6R3500029,VI:Y666278Z6R3500029,MO:YJ48v500w2406131949,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (591, 'P00379', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 	CH:Y666278Z6R4500020,VI:Y666278Z6R4500020,MO:YJ48v500w2406131880,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 	CH:Y666278Z6R4500020,VI:Y666278Z6R4500020,MO:YJ48v500w2406131880,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (592, 'P00382', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:Y666278Z6R7500016,VI:Y666278Z6R7500016,MO:YJ48v500w2406131842,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:Y666278Z6R7500016,VI:Y666278Z6R7500016,MO:YJ48v500w2406131842,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (593, 'P00386', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:HL1162283R8966008,VI:HL1162283R8966008,MO:YJ48v500w2406081778,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELEC...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:HL1162283R8966008,VI:HL1162283R8966008,MO:YJ48v500w2406081778,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (594, 'P00394', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:HL1162283R8966004,VI:HL1162283R8966004,MO:YJ48v500w2406131861,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELEC...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:HL1162283R8966004,VI:HL1162283R8966004,MO:YJ48v500w2406131861,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (595, 'P00395', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:HL1162283R8966003,VI:HL1162283R8966003,MO:YJ48v500w2406131902,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELEC...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:HL1162283R8966003,VI:HL1162283R8966003,MO:YJ48v500w2406131902,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (596, 'P00396', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:LY2226668R2410089,VI:LY2226668R2410089,MO:YJ60v500w2405071115,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:AZUL,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:LY2226668R2410089,VI:LY2226668R2410089,MO:YJ60v500w2405071115,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:AZUL,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (597, 'P00402', NULL, 'L1, MARCA:ILIDESAVA,MODELO:TPC, AÑO MOD:2025 CH:202501100S0959106,VI:202501100S0959106,MO:1000959106, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:NEGRO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:...', 'L1, MARCA:ILIDESAVA,MODELO:TPC, AÑO MOD:2025 CH:202501100S0959106,VI:202501100S0959106,MO:1000959106, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:NEGRO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (598, 'P00404', NULL, 'L1, MARCA:ILIDESAVA,MODELO:TPC, AÑO MOD:2025 CH:202501100S0959109, VI:202501100S0959109, MO:1000959109, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE...', 'L1, MARCA:ILIDESAVA,MODELO:TPC, AÑO MOD:2025 CH:202501100S0959109, VI:202501100S0959109, MO:1000959109, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (599, 'P00412', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959204, VI:202501100S0959204, MO:1000959204 , CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:NEGRO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959204, VI:202501100S0959204, MO:1000959204 , CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:NEGRO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (600, 'P00414', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959206, VI:202501100S0959206, MO:1000959206 , CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959206, VI:202501100S0959206, MO:1000959206 , CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (601, 'P00424', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959305, VI:202501100S0959305, MO:1000959305, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:NEGRO  PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959305, VI:202501100S0959305, MO:1000959305, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:NEGRO  PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (602, 'P00427', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959309, VI:202501100S0959309, MO:1000959309, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO  PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959309, VI:202501100S0959309, MO:1000959309, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO  PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (603, 'P00430', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959313,VI:202501100S0959313,MO:1000959313, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE  PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959313,VI:202501100S0959313,MO:1000959313, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE  PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (604, 'P00436', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959404, VI:202501100S0959404, MO:1000959404, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 ...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959404, VI:202501100S0959404, MO:1000959404, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (605, 'P00437', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959405 , VI:202501100S0959405, MO:1000959405, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959405 , VI:202501100S0959405, MO:1000959405, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (606, 'P00438', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959406, VI:202501100S0959406, MO:1000959406, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 ...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959406, VI:202501100S0959406, MO:1000959406, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (607, 'P00439', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959407, VI:202501100S0959407, MO:1000959407, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959407, VI:202501100S0959407, MO:1000959407, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (608, 'P00440', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959408, VI:202501100S0959408, MO:1000959408, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959408, VI:202501100S0959408, MO:1000959408, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (609, 'P00441', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959409, VI:202501100S0959409, MO:1000959409, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959409, VI:202501100S0959409, MO:1000959409, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (610, 'P00442', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959410, VI:202501100S0959410, MO:1000959410, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:VERDE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 ...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959410, VI:202501100S0959410, MO:1000959410, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:VERDE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (611, 'P00443', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959411, VI:202501100S0959411, MO:1000959411, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:VERDE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 ...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959411, VI:202501100S0959411, MO:1000959411, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:VERDE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (612, 'P00444', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959412, VI:202501100S0959412, MO:1000959412, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:VERDE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 ...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959412, VI:202501100S0959412, MO:1000959412, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:VERDE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (613, 'P00446', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959414, VI:202501100S0959414, MO:1000959414, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:GRIS PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 T...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959414, VI:202501100S0959414, MO:1000959414, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:GRIS PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (614, 'P00447', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959415, VI:202501100S0959415, MO:1000959415, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:GRIS PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 T...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959415, VI:202501100S0959415, MO:1000959415, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:GRIS PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (615, 'P00450', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:882024052S7000004, VI:882024052S7000004, MO:XZS627240506, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:AMARILLO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, ...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:882024052S7000004, VI:882024052S7000004, MO:XZS627240506, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:AMARILLO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (616, 'P00455', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1KWE103S4000888, VI:HE1KWE103S4000888, MO:20250193143, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:ROJO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:E...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1KWE103S4000888, VI:HE1KWE103S4000888, MO:20250193143, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:ROJO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1575.00, 0.00, 0.00, 0.00, 1575.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (617, 'P00459', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1KWE100S4000900, VI:HE1KWE100S4000900, MO:20250193151, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 T...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1KWE100S4000900, VI:HE1KWE100S4000900, MO:20250193151, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1575.00, 0.00, 0.00, 0.00, 1575.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (618, 'P00460', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1KWE104S4000902, VI:HE1KWE104S4000902, MO:20250193149, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 T...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1KWE104S4000902, VI:HE1KWE104S4000902, MO:20250193149, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1575.00, 0.00, 0.00, 0.00, 1575.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (619, 'P00468', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU207S4000177, VI:HE1CWU207S4000177, MO:2025011178,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:NEGRO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU207S4000177, VI:HE1CWU207S4000177, MO:2025011178,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:NEGRO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1575.00, 0.00, 0.00, 0.00, 1575.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (620, 'P00470', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU201S4000174,VI:HE1CWU201S4000174,MO:2025011179,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:NEGRO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:EL...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU201S4000174,VI:HE1CWU201S4000174,MO:2025011179,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:NEGRO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1375.00, 0.00, 0.00, 0.00, 1375.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (621, 'P00472', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU208S4000169, VI:HE1CWU208S4000169, MO:2025011168,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 T...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU208S4000169, VI:HE1CWU208S4000169, MO:2025011168,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1375.00, 0.00, 0.00, 0.00, 1375.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (622, 'P00474', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU206S4000171, VI:HE1CWU206S4000171, MO:2025011165,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 T...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU206S4000171, VI:HE1CWU206S4000171, MO:2025011165,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1375.00, 0.00, 0.00, 0.00, 1375.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (623, 'P00475', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU208S4000172, VI:HE1CWU208S4000172, MO:2025011169,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 T...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU208S4000172, VI:HE1CWU208S4000172, MO:2025011169,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1375.00, 0.00, 0.00, 0.00, 1375.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (624, 'P00476', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU20XS4000173, VI:HE1CWU20XS4000173, MO:2025011166, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU20XS4000173, VI:HE1CWU20XS4000173, MO:2025011166, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1375.00, 0.00, 0.00, 0.00, 1375.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (625, 'P00478', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU207S4000180, VI:HE1CWU207S4000180, MO:2025011163, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:ROJO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:EL...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU207S4000180, VI:HE1CWU207S4000180, MO:2025011163, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:ROJO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1375.00, 0.00, 0.00, 0.00, 1375.00, 1, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 16:17:22');
INSERT INTO `productos` VALUES (626, 'D-38', NULL, 'OLLA ARROCERA', '', 23.00, 0.00, 0.00, 0.00, 23.00, 0, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, '2026-03-02', '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 20:53:26');
INSERT INTO `productos` VALUES (627, 'ZDNSC033-16', NULL, 'BICICLETA MICKEY ARO 16 X 12', '', 110.00, 0.00, 0.00, 0.00, 110.00, 0, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, '2026-03-02', '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-02 20:52:51');
INSERT INTO `productos` VALUES (628, 'ZMVSC020-16', NULL, 'BICICLETA SPIDERMAN ARO 16 X 12', NULL, 110.00, 21.00, 0.00, 0.00, 110.00, 11, 0, 0, 2, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, '2026-03-04', '2026-03-02 16:17:22', NULL, '2026-03-02 16:17:22', '2026-03-04 05:46:03');
INSERT INTO `productos` VALUES (629, 'PROD-A2-00001', NULL, 'holas', 'sdcsacd', 12.00, 11.00, 0.00, 0.00, 0.00, 21, 0, 0, 3, 14, 1, '2', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 08:38:50', NULL, '2026-03-04 13:38:50', '2026-03-04 13:38:50');
INSERT INTO `productos` VALUES (631, 'LIB-0001', NULL, 'Servicio de consultoría', NULL, 25.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 3, NULL, NULL, '1', '51121703', '0', '0', 'PEN', '1', NULL, '2026-03-04', '2026-03-04 09:17:24', NULL, '2026-03-04 14:17:24', '2026-03-04 09:19:45');
INSERT INTO `productos` VALUES (635, 'P00493', NULL, 'LLAVERO SURTIDO, S/M, 2955  MEDIDA: 5 CM', '', 0.30, 0.00, 0.00, 0.00, 0.30, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (636, 'P00502', NULL, 'LLAVERO SURTIDO, MEDIDA: 5CM S/M, 2955', '', 0.20, 0.00, 0.00, 0.00, 0.20, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (637, 'ST501A', NULL, 'BALINES, BOLITAS DE GEL, S/M CODIGO: ST501A, COMPOSICION:GEL', '', 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (638, '2955', NULL, 'MINI LLAVERO C/ADORNO, PAQUETE X 100 UNIDADES, CARTON X 10 PAQUETES,  S/M, 2955', '', 0.18, 0.00, 0.00, 0.00, 0.18, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (639, 'M5', NULL, 'RELOJ PULSERA DIGITAL  DE PLASTICO P/NIÑOS M5', '', 1.55, 0.00, 0.00, 0.00, 1.55, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (640, 'YXJ127', NULL, 'MINI PICO DE PATO C/ADORNO, S/M, YXJ127', '', 0.05, 0.00, 0.00, 0.00, 0.05, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (641, 'P00501', NULL, 'AUDIFONO INALAMBRICOS DIVERSOS MODELOS, S/M, M10/A31/X15/Air39  ITEM: F9', '', 4.90, 0.00, 0.00, 0.00, 4.90, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (642, 'P00494', NULL, 'BRAZALETE PELUCHE, S/M, 1219 DIMENSIONES: 15X21CM', '', 2.25, 0.00, 0.00, 0.00, 2.25, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (643, 'P00498', NULL, 'ARMABLES', '', 2.59, 0.00, 0.00, 0.00, 2.59, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (644, 'T655', NULL, 'CHALA, CHANCLA, CHANCLETA, SLAPS, S/M, T655  PARA NIÑO, TALLA: 34 -35 (EUR), INYECTADO , SIN TALON, DEJA LIBRE LOS DEDOS DEL PIE, CUBRE EL EMPEINE DEL PIE, CASUAL', '', 2.50, 0.00, 0.00, 0.00, 2.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (645, 'P00499', NULL, 'PELUCHE SURTIDO DE FELPA, S/M, S/M CODIGO:1219, DIMENSIONES:30.00cmx20.00cm', '', 10.00, 0.00, 0.00, 0.00, 10.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (646, 'P00489', NULL, 'AUDIFONO INALAMBRICOS DIVERSOS MODELOS, S/M, BTH-F9-5 ITEM: F9', '', 5.00, 0.00, 0.00, 0.00, 5.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (647, '300-9', NULL, 'SET ESCOLAR ARTISTICO, S/M, 300-9  APLICACION:ESCOLAR DISPOSITIVO:NO RETRÁCTIL ACCESORIO:SET 208 PCS  PRESENTACION:ESTUCHE DE PLÁSTICO de 208 PIEZAS', '', 7.00, 0.00, 0.00, 0.00, 7.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (648, 'P00486', NULL, 'LLAVERO CAMARITA CON DISEÑO DE LABUBU S/M ITEM: 2955', '', 1.00, 0.00, 0.00, 0.00, 1.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (649, '88039', NULL, 'MORRAL JUVENIL, S/M, 88039  MEDIDAS:025.0cmx008.0cmx010.0cm', '', 7.00, 0.00, 0.00, 0.00, 7.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (650, 'Y8809-24', NULL, 'PLUMON 24PCS CAJA X120  Y8809-24', '', 2.90, 0.00, 0.00, 0.00, 2.90, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (651, '5665', NULL, 'PASTILLA MUSICAL 3X5, S/M, 5665', '', 0.45, 0.00, 0.00, 0.00, 0.45, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (652, 'P00492', NULL, 'PARAGUAS DISEÑOS SURTIDOS, S/M, 2525', '', 3.00, 0.00, 0.00, 0.00, 3.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (653, 'P00490', NULL, 'MINI PARLANTE CON MICROFONO, S/M, K12', '', 7.00, 0.00, 0.00, 0.00, 7.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (654, '24620', NULL, 'CHIP DE MEMORIA PCBA S/M S/M CAPACIDAD 8 GB', '', 2.00, 0.00, 0.00, 0.00, 2.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (655, '01006', NULL, 'PERFUMES X 96 PCS COD: 01006', '', 4.00, 0.00, 0.00, 0.00, 4.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (656, '24627', NULL, 'USB 1CZH-1906', '', 7.00, 0.00, 0.00, 0.00, 7.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (657, '2025-46', NULL, '2025-46 - TOMATODO X 120 PCS 2025-46', '', 1.70, 0.00, 0.00, 0.00, 1.70, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (658, 'MP-01', NULL, 'MINI PULSERA S/M MP-01', '', 0.03, 0.00, 0.00, 0.00, 0.03, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (659, 'CN922', NULL, 'HELICOPTERO CAPYBARA CAJA X120   CN922', '', 4.00, 0.00, 0.00, 0.00, 4.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (660, 'YXJ120', NULL, 'FUNDA DE SILICONA PARA EL CONTROL DE JUEGO 15CM X 4CM, S/M, YXJ120', '', 1.00, 0.00, 0.00, 0.00, 1.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (661, '2025-111', NULL, '2025-111 NECESER X 100 PCS 2025-111', '', 2.90, 0.00, 0.00, 0.00, 2.90, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (662, 'P00500', NULL, 'CAMARA DIGITAL PARA NIÑOS DIFERENTES DISEÑOS, S/M, 1219  MEDIDAS: 10X7X4 CM', '', 6.00, 0.00, 0.00, 0.00, 6.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (663, 'P00488', NULL, 'CAMARA DIGITAL PARA NIÑOS DIFERENTES DISEÑOS, S/M, 1219 MEDIDAS: 10X7X4 CM', '', 7.50, 0.00, 0.00, 0.00, 7.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (664, 'IR-1255', NULL, 'PELUCHES FUGGLER, IR-1255 CODIGO:IR-1255, USUARIO:NIÑO/NIÑA,PRESENTA:BOLSA,', '', 4.50, 0.00, 0.00, 0.00, 4.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (665, '24641', NULL, 'USB MADERA RECTANGULAR', '', 8.00, 0.00, 0.00, 0.00, 8.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (666, '24619', NULL, 'CHIP DE MEMORIA PCBA S/M S/M CAPACIDAD 14.60 GB', '', 2.00, 0.00, 0.00, 0.00, 2.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (667, '00358', NULL, 'NO.650C-D24 - JUGUETE PIMBOLL DE SIRENITA X 384 PCS (1.9C/U)', '', 1.90, 0.00, 0.00, 0.00, 1.90, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (668, 'IR-1254', NULL, 'MONSTRUO TIRA PEDO X 240 PCS IR-1254', '', 4.50, 0.00, 0.00, 0.00, 4.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (669, 'A-5112', NULL, 'TOLLA CAPUCHA CAJA X 200 COD. A-5112', '', 3.15, 0.00, 0.00, 0.00, 3.15, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (670, 'P00482', NULL, 'TERMO CON TACITA', '', 6.70, 0.00, 0.00, 0.00, 6.70, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (671, '1219', NULL, 'PELUCHE DE FELPA, S/M CODIGO:1219A,B,C,D,E,F,G,H..., DIMENSIONES:030.0cmx012.0cmx005.0cm  FUENTE DE MOVI:ELECTRICIDAD A TRAVÉS DE PILAS O BATERÍA,USUARIO:NIÑO/NIÑA,PRESENTA:CAJA', '', 12.00, 0.00, 0.00, 0.00, 12.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (672, 'JHV-41', NULL, 'JUGUETES X 720 PCS JHV-41', '', 1.50, 0.00, 0.00, 0.00, 1.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (673, '2025-101', NULL, '2025-101 CAJA DE ALMACENAMIENTO X 60 PCD 2025-101', '', 4.99, 0.00, 0.00, 0.00, 4.99, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (674, 'D20', NULL, 'RELOJ INTELIGENTE DIVERSOS MODELOS, S/M, D20', '', 5.00, 0.00, 0.00, 0.00, 5.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (675, 'P00399', NULL, 'MOCHILA, S/M, 1219 MEDIDAS:047.0cmx031.0cmx020.0cm, PRESENTACION:3 PIEZAS', '', 30.00, 0.00, 0.00, 0.00, 30.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (676, '24623', NULL, 'CARCASA DE MEMORIA PCBA S/M S/M MADERA BAMBU', '', 1.00, 0.00, 0.00, 0.00, 1.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (677, 'C-2630', NULL, 'TACHO DE BASURA CAJA X 60 COD. C-2630', '', 1.75, 0.00, 0.00, 0.00, 1.75, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (678, 'A-6623', NULL, 'AURICULARES BLUETOOTH A-6623 X CAJA 100', '', 5.00, 0.00, 0.00, 0.00, 5.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (679, '9333', NULL, 'LEGOS X 600 COD. 9333-9334-9335', '', 2.12, 0.00, 0.00, 0.00, 2.12, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (680, 'GP-452', NULL, 'CARTUCHERA KAWAII SLIM', '', 0.70, 0.00, 0.00, 0.00, 0.70, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (681, '00356', NULL, 'NO.333R JUGUETE PIMBOLL DE AGUA X 288 PCS', '', 1.57, 0.00, 0.00, 0.00, 1.57, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (682, 'P00491', NULL, 'ENCENDEDOR ELECTRICO PARA COCINA, RECARGA MEDIANTE USB, S/M, 1912', '', 2.50, 0.00, 0.00, 0.00, 2.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (683, '24624', NULL, 'CARCASA DE MEMORIA PCBA S/M S/M PLASTICO 100%', '', 1.00, 0.00, 0.00, 0.00, 1.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (684, '320C', NULL, 'ESQUINERO DE DUCHA X 24 UND COD 320C', '', 12.50, 0.00, 0.00, 0.00, 12.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (685, 'A-4014', NULL, 'SHORT DE YOGA CAJA X 200 COD. A-4014', '', 4.50, 0.00, 0.00, 0.00, 4.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (686, 'C-1345', NULL, 'SHAMPOO CAMELLIA 500ML CAJA X 40 UND', '', 2.50, 0.00, 0.00, 0.00, 2.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (687, 'YXJ-161', NULL, 'MOCHILA, S/M, YXJ-161,162,163,164,165 MEDIDAS:047.0cmx031.0cmx020.0cm', '', 7.00, 0.00, 0.00, 0.00, 7.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (688, '207', NULL, 'USB MODELO LLAVE DE 16 GB, S/M, S/M', '', 4.60, 0.00, 0.00, 0.00, 4.60, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (689, '1985', NULL, 'PORTAMONEDAS, S/M, 1985  MEDIDAS:008.0cmx008.0cmx002.0cm, PRESENTACION:12 PIEZAS', '', 2.20, 0.00, 0.00, 0.00, 2.20, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (690, 'AMI2015-22GRC', NULL, 'MINI NOLITAS CRECIENTES S/M AMI2015-22GRC', '', 0.17, 0.00, 0.00, 0.00, 0.17, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (691, 'C-1272', NULL, 'HISOPO CAJA X 240 COD. C-1272', '', 0.50, 0.00, 0.00, 0.00, 0.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (692, '15-115', NULL, 'CAPUCHINA EN CARRO X 72 PCS', '', 9.00, 0.00, 0.00, 0.00, 9.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (693, 'XX004', NULL, 'MUÑECO VOLADOR', '', 9.50, 0.00, 0.00, 0.00, 9.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (694, 'A-6624', NULL, 'AURICULAR A-6624 CAJA X 100', '', 7.00, 0.00, 0.00, 0.00, 7.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (695, 'C-2334', NULL, 'PIJAMA DE ENCAJE X 300 UND', '', 4.00, 0.00, 0.00, 0.00, 4.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (696, 'JHV-36', NULL, 'JUGUETE BRAINROT X 240 PCS COD. JHV-36 - HH85', '', 3.50, 0.00, 0.00, 0.00, 3.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (697, 'A-3920', NULL, 'PANTALON DE YOGA CJA X 150 COD. A-3920', '', 6.00, 0.00, 0.00, 0.00, 6.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (698, '00354', NULL, 'YT-190 - SET DE PISTOLA DE JUGUETE X 132 PCS (4.50C/U)', '', 4.50, 0.00, 0.00, 0.00, 4.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (699, 'MIA-2023M', NULL, 'MORRAL PARA NIÑOS, S/M, MIA-2023M', '', 2.30, 0.00, 0.00, 0.00, 2.30, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (700, 'JHV-116', NULL, 'JUGUETE X 144 PCS COD. JHV-116', '', 13.00, 0.00, 0.00, 0.00, 13.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (701, 'A-829-2', NULL, 'SET DE TAPER Y BEBETODO A-829#2', '', 3.50, 0.00, 0.00, 0.00, 3.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (702, 'B-2012', NULL, 'PIZARRA LCD CAJA X120 B-2012', '', 4.00, 0.00, 0.00, 0.00, 4.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (703, 'B-2011', NULL, 'PIZARRA LCD CAJA X120 B-2011', '', 4.00, 0.00, 0.00, 0.00, 4.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (704, 'A-935-2', NULL, 'TAPER + TOMATODO A-935#2', '', 3.50, 0.00, 0.00, 0.00, 3.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (705, 'MIA-2024U', NULL, 'PELUCHE, S/M, MIA-2024U', '', 2.30, 0.00, 0.00, 0.00, 2.30, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (706, '24621', NULL, 'CHIP DE MEMORIA PCBA S/M S/M CAPACIDAD 1 GB', '', 2.00, 0.00, 0.00, 0.00, 2.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (707, '15-120', NULL, 'JUGUETES', '', 9.00, 0.00, 0.00, 0.00, 9.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (708, 'YXJ-174', NULL, 'PARAGUAS, S/M, YXJ-174-A,B,C.', '', 3.80, 0.00, 0.00, 0.00, 3.80, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (709, 'P00222', NULL, 'TAZON DE ACERO CAPACIDAD 240ML , S/M, S/M', '', 1.40, 0.00, 0.00, 0.00, 1.40, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (710, 'MIA-2023H', NULL, 'MOCHILA, S/M, MIA-2023 H', '', 4.80, 0.00, 0.00, 0.00, 4.80, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (711, 'JTB-44', NULL, 'LEGOS IMANTADOS X 36 PCS JTB-44', '', 25.60, 0.00, 0.00, 0.00, 25.60, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (712, '24644', NULL, 'USB CUERO IMAN CLASICO 16GB', '', 7.00, 0.00, 0.00, 0.00, 7.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (713, 'PP-3', NULL, 'SET PAPEL TISSUE - CAPIBARA', '', 1.50, 0.00, 0.00, 0.00, 1.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (714, 'PP-2', NULL, 'SET PAPEL TISSUE - FROG', '', 1.50, 0.00, 0.00, 0.00, 1.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (715, '01135', NULL, 'MBL-124 MUÑECAS X 48 PCS', '', 13.17, 0.00, 0.00, 0.00, 13.17, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (716, '01137', NULL, 'MBL-126 MUÑECAS X 48 PCS 01137', '', 12.98, 0.00, 0.00, 0.00, 12.98, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (717, 'MIA-2023A', NULL, 'PELUCHE, S/M, MIA-2023A', '', 2.30, 0.00, 0.00, 0.00, 2.30, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (718, '44206496', NULL, 'TRENCITOS DE JUGUETES', '', 3.43, 0.00, 0.00, 0.00, 3.43, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (719, 'SYD-CD032', NULL, 'BARRA LED SYD-CD032', '', 1.50, 0.00, 0.00, 0.00, 1.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (720, '0000287', NULL, 'REPUESTO DE PROTECCION FACIAL', '', 0.31, 0.00, 0.00, 0.00, 0.31, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (721, '2025-165', NULL, 'BANCA BRAINSTON X 60 PCS', '', 7.00, 0.00, 0.00, 0.00, 7.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (722, 'MIA-2023W', NULL, 'PELUCHE, S/M, MIA-2023 W', '', 2.30, 0.00, 0.00, 0.00, 2.30, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (723, 'PP-1', NULL, 'SET PAPEL TISSUE - SWEET', '', 1.50, 0.00, 0.00, 0.00, 1.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (724, '2025-1014', NULL, '2025-1014 TOMATODO X 40 PCS 2025-1014', '', 8.99, 0.00, 0.00, 0.00, 8.99, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (725, 'YXJ108', NULL, 'TERMO DE 600ML CON DISEÑO, S/M, YXJ108', '', 4.50, 0.00, 0.00, 0.00, 4.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (726, 'M38', NULL, 'M38 AUDIFONO V5.3 X 100 PCS', '', 5.50, 0.00, 0.00, 0.00, 5.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (727, 'YXJ08', NULL, 'TERMO 750 ML, S/M, YXJ08', '', 4.70, 0.00, 0.00, 0.00, 4.70, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (728, '01138', NULL, 'MBL-253 MUÑECAS X 48 PCS 01138', '', 11.98, 0.00, 0.00, 0.00, 11.98, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (729, '1912-A', NULL, 'CAMARA DE ESPEJO RETROSIVOR PARA AUTO, S/M, 1912-A   BATERIA 450MAH', '', 25.00, 0.00, 0.00, 0.00, 25.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (730, 'GP-453', NULL, 'CARTUCHERA KIDS MIX LINTERNA', '', 1.30, 0.00, 0.00, 0.00, 1.30, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (731, '0000429', NULL, 'MOCHILA DE NIÑO DRAGON BALL', '', 8.18, 0.00, 0.00, 0.00, 8.18, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (732, '24637', NULL, 'MULTIPUERTO V8 / TIPO C', '', 4.00, 0.00, 0.00, 0.00, 4.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (733, '0000284', NULL, 'CF-SALSA CUCHARITA', '', 0.24, 0.00, 0.00, 0.00, 0.24, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (734, 'MIA-2024AA', NULL, 'PELUCHE, S/M, MIA-2024AA', '', 3.20, 0.00, 0.00, 0.00, 3.20, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (735, '00355', NULL, 'YT-191 - SET DE PISTOLA DE JUGUETE X 78 PCS (7.50C/U)', '', 7.50, 0.00, 0.00, 0.00, 7.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (736, 'GP-450', NULL, 'CARTUCHERA SHARP UNICORN KIDS', '', 1.30, 0.00, 0.00, 0.00, 1.30, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (737, '00352', NULL, 'CAT-480 JUGUETE DE CONSTRUCCION PARA NIÑOS X 36 PCS', '', 15.00, 0.00, 0.00, 0.00, 15.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (738, '0001528', NULL, 'MOCHILA MC 1020', '', 23.39, 0.00, 0.00, 0.00, 23.39, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (739, '0000280', NULL, 'CUCHARITA AD3', '', 0.35, 0.00, 0.00, 0.00, 0.35, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (740, '62517490', NULL, 'TAXA CERAMICA 400ML/ S/M YGS-105', '', 1.56, 0.00, 0.00, 0.00, 1.56, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (741, '0000979', NULL, 'MINI ROCEADOR S/M BOTELLA TOCADO / ST-2030ML', '', 0.21, 0.00, 0.00, 0.00, 0.21, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (742, 'YXJ07', NULL, 'TERMO 500 ML, S/M, YXJ07', '', 3.70, 0.00, 0.00, 0.00, 3.70, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (743, '49541739', NULL, 'PLUSH TOYS THE MONSTER', '', 7.80, 0.00, 0.00, 0.00, 7.80, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (744, 'C-1346', NULL, 'SHAMPOO CLEAN 500 ML CAJA X 35', '', 2.50, 0.00, 0.00, 0.00, 2.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (745, '01139', NULL, 'MBL-254 MUÑECAS X 24 PCS 01139', '', 17.98, 0.00, 0.00, 0.00, 17.98, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (746, 'P00223', NULL, 'TAZON DE ACERO CAPACIDAD: 140 ML , S/M, S/M', '', 1.00, 0.00, 0.00, 0.00, 1.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (747, '2955-H', NULL, 'PELUCHE, S/M, 2955-H', '', 2.30, 0.00, 0.00, 0.00, 2.30, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (748, 'SOF-34', NULL, 'MOCHILA UNICORNIO ARCOIRIS', '', 4.00, 0.00, 0.00, 0.00, 4.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (749, '0001009', NULL, 'CAJA PERCHERO NA190179', '', 1.04, 0.00, 0.00, 0.00, 1.04, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (750, 'M25', NULL, 'M25 AUDIFONOS M25 X 100 PCS', '', 5.50, 0.00, 0.00, 0.00, 5.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (751, '0001494', NULL, 'TAPER DE PLASTIO S/M TIPO LONCHERA / X 110-1', '', 0.76, 0.00, 0.00, 0.00, 0.76, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (752, 'P00225', NULL, 'TAZON DE ACERO CAPACIDAD: 300 ML   , S/M, S/M', '', 2.35, 0.00, 0.00, 0.00, 2.35, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (753, 'A-2895', NULL, 'ARRANCADOR DE BATERIA AUTO CAJA X 10COD. A-2895', '', 50.00, 0.00, 0.00, 0.00, 50.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (754, '0000121', NULL, 'ST24343B / MINI MOCHILA PELUCHE S/M SINTETICO', '', 7.60, 0.00, 0.00, 0.00, 7.60, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (755, 'ZDNSC012-16', NULL, 'BICICLETA MICKEY ARO 16 X 12', '', 110.00, 0.00, 0.00, 0.00, 110.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (756, 'GP-456', NULL, 'CARTUCHERA KAWAI KIDS BASIC', '', 1.30, 0.00, 0.00, 0.00, 1.30, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (757, '24645', NULL, 'USB CUERO CON BROCHE 16GB', '', 7.00, 0.00, 0.00, 0.00, 7.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (758, 'AMIR-2025', NULL, 'SET DE BAÑO S/M AMIR-2025', '', 19.00, 0.00, 0.00, 0.00, 19.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (759, '0000684', NULL, 'TOALLITAS HUMEDAS', '', 1.95, 0.00, 0.00, 0.00, 1.95, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (760, '0000374', NULL, 'ST25822H / ART. DE FIESTA SOMBRERO S/M PARA FIESTA', '', 2.50, 0.00, 0.00, 0.00, 2.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (761, '61020748', NULL, 'CAJA KITCHEN FAUCET NA4613V', '', 1.42, 0.00, 0.00, 0.00, 1.42, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (762, 'YXJ123', NULL, 'PURIFICADOR DE AGUA C/ACCESORIOS, DESARMADO, S/M, YXJ123   POTENCIA 3000W', '', 22.50, 0.00, 0.00, 0.00, 22.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (763, 'YXJ09', NULL, 'TERMO 750 ML, S/M, YXJ09', '', 3.70, 0.00, 0.00, 0.00, 3.70, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (764, '0000394', NULL, 'GUANTES PARA NIÑO DE COLORES  ST24GS09', '', 0.34, 0.00, 0.00, 0.00, 0.34, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (765, '00233', NULL, 'GOROO M. MAZZE COD: DM-3401', '', 3.17, 0.00, 0.00, 0.00, 3.17, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (766, '0000135', NULL, 'ST2409FM-0C/ ADORNO ROSITAA S/M SINTETICO', '', 0.31, 0.00, 0.00, 0.00, 0.31, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (767, '0000078', NULL, 'J37 CUCHARITA', '', 2.79, 0.00, 0.00, 0.00, 2.79, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (768, '0000169', NULL, 'SL-D060-8P/ GLOBOS S/M TIPO CORAZON PARA SAN VALENTIN', '', 0.53, 0.00, 0.00, 0.00, 0.53, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (769, '0000328', NULL, 'SALTYA SOGA S/M DE PLASTICO S5014', '', 0.85, 0.00, 0.00, 0.00, 0.85, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (770, '0000553', NULL, 'TAPER S/M DE PLASTICO / 100-1', '', 0.85, 0.00, 0.00, 0.00, 0.85, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (771, '0000201', NULL, 'UND.OREJERAS M/MAZZE P/.NIÑO COD DM-5876', '', 2.44, 0.00, 0.00, 0.00, 2.44, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (772, '69346863', NULL, 'GUANTE M/. RACE READY COD DM-3281', '', 1.44, 0.00, 0.00, 0.00, 1.44, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (773, 'MC-374', NULL, 'BANCA PLEGABLE X 20 COD: MC-374', '', 9.00, 0.00, 0.00, 0.00, 9.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (774, 'MC-04', NULL, 'ESQUINERO DE DUCHA X 20 PCS', '', 13.00, 0.00, 0.00, 0.00, 13.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (775, '00101', NULL, 'TAZA GK-22', '', 1.27, 0.00, 0.00, 0.00, 1.27, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (776, '00584', NULL, 'BLOQUES DIDACTICO X 120 PCS  9333', '', 3.00, 0.00, 0.00, 0.00, 3.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (777, 'ZDNSC034-12', NULL, 'BICICLETA MICKEY ARO 12 X 12', '', 110.00, 0.00, 0.00, 0.00, 110.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (778, '001040', NULL, 'INCH PLATE HAND PAINTED', '', 2.09, 0.00, 0.00, 0.00, 2.09, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (779, '0000285', NULL, 'CUBETA 655602', '', 2.51, 0.00, 0.00, 0.00, 2.51, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (780, '0000824', NULL, 'RESPUESTO DE PROTECCION FACIAL / 686 (1T)', '', 0.63, 0.00, 0.00, 0.00, 0.63, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (781, '0000300', NULL, 'POSA OLLA A5754', '', 1.06, 0.00, 0.00, 0.00, 1.06, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (782, '43144947', NULL, 'GUANTES DE POLIESTER SIN DEDO PAE=PE RN-046', '', 1.00, 0.00, 0.00, 0.00, 1.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (783, '44215027', NULL, 'BOLSO DE MANO SINTETICO 28X11X21CM RN-028', '', 14.55, 0.00, 0.00, 0.00, 14.55, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (784, '001072', NULL, 'BOLSO PELUCHE RN-026', '', 7.21, 0.00, 0.00, 0.00, 7.21, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (785, 'P00495', NULL, 'RN-046 GUANTES DE POLIESTER SIN DEDO , PAR=PE', '', 1.00, 0.00, 0.00, 0.00, 1.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (786, 'M106', NULL, 'HUMIFICADOR 20 ML,  5V-1A, S/M, M106 MEDIDA: 143X88X88MM  	REF: MONG CHONG', '', 4.60, 0.00, 0.00, 0.00, 4.60, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (787, 'ZDNSC013-16', NULL, 'BICICLETA FROZEN ARO 16', '', 110.00, 0.00, 0.00, 0.00, 110.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (788, '0000224', NULL, 'BOLSO PELUCHE RN-001', '', 15.10, 0.00, 0.00, 0.00, 15.10, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (789, '62245408', NULL, 'MOCHILA PARA NIÑOS MC2024', '', 28.80, 0.00, 0.00, 0.00, 28.80, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (790, '0000825', NULL, 'RESPUESTO DE PROTECCION FACIAL /686 (1L)', '', 1.50, 0.00, 0.00, 0.00, 1.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (791, '59859679', NULL, 'GUANTES D/ INVIERNO YX1032', '', 2.40, 0.00, 0.00, 0.00, 2.40, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (792, '60057612', NULL, 'GUABTES D/INVIERNO P/NIÑAS YX1070', '', 3.12, 0.00, 0.00, 0.00, 3.12, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (793, '43062647', NULL, 'GUANTES DE POLIESTER PAR=PE RN-045', '', 1.00, 0.00, 0.00, 0.00, 1.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (794, '0000231', NULL, 'P2612 TOMATODO', '', 4.75, 0.00, 0.00, 0.00, 4.75, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (795, '0000362', NULL, 'BOLSO PELUCHE RN-041', '', 11.42, 0.00, 0.00, 0.00, 11.42, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (796, '0000751', NULL, 'MINI MOCHILA PELUCHE S/M SINTETICO / ST24344B', '', 7.94, 0.00, 0.00, 0.00, 7.94, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (797, '000336', NULL, 'CASACA (CHAMARRA) DE MUJER S/M P-555', '', 30.00, 0.00, 0.00, 0.00, 30.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (798, '0001121', NULL, 'SET DE MOCHILA S/M S/M CON RUEDAS C/MADERA C/LONCHERA', '', 35.59, 0.00, 0.00, 0.00, 35.59, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (799, '0000782', NULL, 'MINI MOCHILA PELUCHE S/M SINTETICO / ST24349B', '', 7.39, 0.00, 0.00, 0.00, 7.39, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (800, 'YXJ118', NULL, 'CONTROL INALAMBRICO CON CABLE USB PARA PC, S/M, HS-SW570  ITEM: YXJ118 / YXJ119', '', 13.50, 0.00, 0.00, 0.00, 13.50, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (801, 'C-1407', NULL, 'OLLA ARROCERA 900W CJA X 6 UND', '', 23.00, 0.00, 0.00, 0.00, 23.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (802, '84223587', NULL, 'MINI MONOPOD CH-2189', '', 3.24, 0.00, 0.00, 0.00, 3.24, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (803, 'C-1408', NULL, 'OLLA ARROCERA DE 900W CAJA X 6 UND', '', 23.00, 0.00, 0.00, 0.00, 23.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (804, '0000748', NULL, 'MINI MOCHILA PELUCHE S/M SINTETICO / ST24341B', '', 7.70, 0.00, 0.00, 0.00, 7.70, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (805, 'ZDNSC011-16', NULL, 'BICICLETAS SURTIDAS DISNEY', '', 110.00, 0.00, 0.00, 0.00, 110.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (806, '00576', NULL, 'DIE CAST METAL CAR TOYS QZ614-4C', '', 6.96, 0.00, 0.00, 0.00, 6.96, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (807, '65633028', NULL, 'BOLSO 5 PZS YH559-24B', '', 48.40, 0.00, 0.00, 0.00, 48.40, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (808, '0000225', NULL, 'RN-016 CALENTADOR DE TAZA DE CAFE, 220V', '', 6.72, 0.00, 0.00, 0.00, 6.72, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (809, 'A-6525', NULL, 'MOTOCICLETA ELECTRICA DE DINOSAURIO A-6525', '', 170.00, 0.00, 0.00, 0.00, 170.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (810, 'ZMVSC009-16', NULL, 'BICICLETA SPIDER-MAN ARO 16', '', 110.00, 0.00, 0.00, 0.00, 110.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (811, '0000324', NULL, 'SARTEN N°20 980982001', '', 17.41, 0.00, 0.00, 0.00, 17.41, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (812, 'ZMVSC019-16', NULL, 'BICICLETA SPIDERMAN ARO 16 X 12', '', 110.00, 0.00, 0.00, 0.00, 110.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (813, 'ZDNSC030-12', NULL, 'BICICLETA FROZEN ARO 12 X 12', '', 110.00, 0.00, 0.00, 0.00, 110.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (814, 'ZDNSC032-16', NULL, 'BICICLETA MINNIE ARO 16 X 12', '', 110.00, 0.00, 0.00, 0.00, 110.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (815, 'P00138', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91146, VI:HL55WFB21R1D91146,MO:24D091146, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 ...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91146, VI:HL55WFB21R1D91146,MO:24D091146, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (816, 'P00140', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91148, VI:HL55WFB21R1D91148, MO:24D091148, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91148, VI:HL55WFB21R1D91148, MO:24D091148, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (817, 'P00142', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91150, VI:HL55WFB21R1D91150, MO:24D091150, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91150, VI:HL55WFB21R1D91150, MO:24D091150, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (818, 'P00148', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91156, VI:HL55WFB21R1D91156, MO:24D091156, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91156, VI:HL55WFB21R1D91156, MO:24D091156, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (819, 'P00149', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91157, VI:HL55WFB21R1D91157, MO:24D091157, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91157, VI:HL55WFB21R1D91157, MO:24D091157, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (820, 'P00152', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91160, VI:HL55WFB21R1D91160, MO:24D091160, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91160, VI:HL55WFB21R1D91160, MO:24D091160, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (821, 'P00153', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91161, VI:HL55WFB21R1D91161, MO:24D091161, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91161, VI:HL55WFB21R1D91161, MO:24D091161, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (822, 'P00154', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91162, VI:HL55WFB21R1D91162, MO:24D091162, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91162, VI:HL55WFB21R1D91162, MO:24D091162, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (823, 'P00155', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91163, VI:HL55WFB21R1D91163, MO:24D091163, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91163, VI:HL55WFB21R1D91163, MO:24D091163, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (824, 'P00157', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91165, VI:HL55WFB21R1D91165, MO:24D091165, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91165, VI:HL55WFB21R1D91165, MO:24D091165, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (825, 'P00158', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91166, VI:HL55WFB21R1D91166, MO:24D091166, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91166, VI:HL55WFB21R1D91166, MO:24D091166, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (826, 'P00159', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91167, VI:HL55WFB21R1D91167, MO:24D091167, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91167, VI:HL55WFB21R1D91167, MO:24D091167, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (827, 'P00160', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91168, VI:HL55WFB21R1D91168, MO:24D091168, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91168, VI:HL55WFB21R1D91168, MO:24D091168, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (828, 'P00161', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91169, VI:HL55WFB21R1D91169, MO:24D091169, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91169, VI:HL55WFB21R1D91169, MO:24D091169, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (829, 'P00164', NULL, 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91172, VI:HL55WFB21R1D91172, MO:24D091172, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3...', 'L2,MARCA:FENGLIDA, MODELO:YH1500DZH-2A, AÑO MOD:2024 CH:HL55WFB21R1D91172, VI:HL55WFB21R1D91172, MO:24D091172, CC:0, CO:ELECTRICO, SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1, PA:0,FR:3X2,TT:AUT, C1:GRIS PB:550,PN:250,CU:300,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (830, 'P00168', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000172, VI:HU4DWH402R1000172, MO:240220794, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000172, VI:HU4DWH402R1000172, MO:240220794, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (831, 'P00172', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000176, VI:HU4DWH402R1000176, MO:240220798, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000176, VI:HU4DWH402R1000176, MO:240220798, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (832, 'P00174', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000178, VI:HU4DWH402R1000178, MO:240220800, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000178, VI:HU4DWH402R1000178, MO:240220800, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (833, 'P00176', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000180, VI:HU4DWH402R1000180, MO:240220802, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000180, VI:HU4DWH402R1000180, MO:240220802, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (834, 'P00178', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000182, VI:HU4DWH402R1000182, MO:240220804, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000182, VI:HU4DWH402R1000182, MO:240220804, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (835, 'P00179', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000183, VI:HU4DWH402R1000183, MO:240220805, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000183, VI:HU4DWH402R1000183, MO:240220805, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (836, 'P00183', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000187, VI:HU4DWH402R1000187, MO:240220809, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000187, VI:HU4DWH402R1000187, MO:240220809, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (837, 'P00184', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000188, VI:HU4DWH402R1000188, MO:240220810, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000188, VI:HU4DWH402R1000188, MO:240220810, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (838, 'P00189', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000193, VI:HU4DWH402R1000193, MO:240220815, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000193, VI:HU4DWH402R1000193, MO:240220815, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (839, 'P00191', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000195, VI:HU4DWH402R1000195, MO:240220817, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000195, VI:HU4DWH402R1000195, MO:240220817, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (840, 'P00193', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000197, VI:HU4DWH402R1000197, MO:240220819, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000197, VI:HU4DWH402R1000197, MO:240220819, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (841, 'P00194', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000198, VI:HU4DWH402R1000198, MO:240220820, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000198, VI:HU4DWH402R1000198, MO:240220820, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (842, 'P00199', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000203, VI:HU4DWH402R1000203, MO:240220825, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000203, VI:HU4DWH402R1000203, MO:240220825, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (843, 'P00200', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000204, VI:HU4DWH402R1000204, MO:240220826, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000204, VI:HU4DWH402R1000204, MO:240220826, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (844, 'P00203', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000207, VI:HU4DWH402R1000207, MO:240220829, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000207, VI:HU4DWH402R1000207, MO:240220829, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (845, 'P00205', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000209, VI:HU4DWH402R1000209, MO:240220831, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000209, VI:HU4DWH402R1000209, MO:240220831, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (846, 'P00207', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000211, VI:HU4DWH402R1000211, MO:240220833, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000211, VI:HU4DWH402R1000211, MO:240220833, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (847, 'P00212', NULL, 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000216, VI:HU4DWH402R1000216, MO:240220838, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:FENGLIDA, MODELO:HL1000DT-4, AÑO MOD:2024  CH:HU4DWH402R1000216, VI:HU4DWH402R1000216, MO:240220838, CC:0, CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:GRIS  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 900.00, 0.00, 0.00, 0.00, 900.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (848, 'P00246', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005231,VI:202410180R1005231, MO:2410746,CC:0,CO:ELECTRICO,SNTT:0 , CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS, PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3, TE:ELEC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005231,VI:202410180R1005231, MO:2410746,CC:0,CO:ELECTRICO,SNTT:0 , CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS, PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3, TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 1700.00, 0.00, 0.00, 0.00, 1700.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (849, 'P00247', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005232,VI:202410180R2005232,MO:2410747,CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005232,VI:202410180R2005232,MO:2410747,CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (850, 'P00251', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R6005236,VI:202410180R6005236,MO:2410745, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R6005236,VI:202410180R6005236,MO:2410745, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (851, 'P00253', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R8005238,VI:202410180R8005238,MO:2410738, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R8005238,VI:202410180R8005238,MO:2410738, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (852, 'P00255', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005240,VI:202410180R1005240,MO:2410741,CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005240,VI:202410180R1005240,MO:2410741,CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (853, 'P00256', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005241,VI:202410180R2005241,MO:2410749, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005241,VI:202410180R2005241,MO:2410749, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (854, 'P00258', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R4005243,VI:202410180R4005243,MO:2410753, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R4005243,VI:202410180R4005243,MO:2410753, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (855, 'P00263', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R9005248,VI:202410180R9005248,MO:2410757, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R9005248,VI:202410180R9005248,MO:2410757, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (856, 'P00264', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005249,VI:202410180R1005249,MO:2410756, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005249,VI:202410180R1005249,MO:2410756, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (857, 'P00265', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005250,VI:202410180R2005250,MO:2410755, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005250,VI:202410180R2005250,MO:2410755, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (858, 'P00268', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R5005253,VI:202410180R5005253,MO:2410762,  CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRI...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R5005253,VI:202410180R5005253,MO:2410762,  CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (859, 'P00272', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R9005257,VI:202410180R9005257,MO:2410758, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R9005257,VI:202410180R9005257,MO:2410758, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (860, 'P00273', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005258,VI:202410180R1005258,MO:2410759, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R1005258,VI:202410180R1005258,MO:2410759, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (861, 'P00274', NULL, 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005259,VI:202410180R2005259,MO:2410760, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRIC...', 'L2,MARCA:ILIDESAVA,MODELO:YH1500DZH-A,AÑO MOD:2024 CH:202410180R2005259,VI:202410180R2005259,MO:2410760, CC:0,CO:ELECTRICO,SNTT:0 CA:TRIMOTO CARGA,PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:GRIS PB:550,PN:240,CU:310,LA:2400,AN:820,AL:1100,NR:3 TE:ELECTRICO,SAC,KILOMETRAJE:1', 1600.00, 0.00, 0.00, 0.00, 1600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (862, 'P00276', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024  CH:202422410R0180046, VI:202422410R0180046, MO:QZ48v500w2408010364,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024  CH:202422410R0180046, VI:202422410R0180046, MO:QZ48v500w2408010364,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 400.00, 0.00, 0.00, 0.00, 400.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (863, 'P00279', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024CH:202422410R0080044,VI:202422410R0080044,MO:QZ48v500w2408010333, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELE...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024CH:202422410R0080044,VI:202422410R0080044,MO:QZ48v500w2408010333, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 400.00, 0.00, 0.00, 0.00, 400.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (864, 'P00289', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R7080020,VI:202422410R7080020,MO:QZ48v500w2410141021, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R7080020,VI:202422410R7080020,MO:QZ48v500w2410141021, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (865, 'P00293', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0980030,VI:202422410R0980030,MO:QZ48v500w2410141005,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELE...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0980030,VI:202422410R0980030,MO:QZ48v500w2410141005,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (866, 'P00299', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080077,VI:202422410R2080077,MO:QZ48v500w2410141046,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELE...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080077,VI:202422410R2080077,MO:QZ48v500w2410141046,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,LA:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (867, 'P00304', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0980036,VI:202422410R0980036,MO:QZ48v500w2410141042, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0980036,VI:202422410R0980036,MO:QZ48v500w2410141042, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (868, 'P00305', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R4080080,VI:202422410R4080080,MO:QZ48v500w2410141016, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R4080080,VI:202422410R4080080,MO:QZ48v500w2410141016, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (869, 'P00306', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080095,VI:202422410R0080095,MO:QZ48v500w2410141026, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080095,VI:202422410R0080095,MO:QZ48v500w2410141026, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (870, 'P00309', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080072,VI:202422410R8080072,MO:QZ48v500w2410141029, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080072,VI:202422410R8080072,MO:QZ48v500w2410141029, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (871, 'P00310', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080070,VI:202422410R9080070,MO:QZ48v500w2408010326, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:EL...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080070,VI:202422410R9080070,MO:QZ48v500w2408010326, CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (872, 'P00311', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R1080084,VI:202422410R1080084,MO:QZ48v500w2410141049,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELE...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R1080084,VI:202422410R1080084,MO:QZ48v500w2410141049,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (873, 'P00320', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R7080097,VI:202422410R7080097,MO:QZ48v500w2410141040,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELEC...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R7080097,VI:202422410R7080097,MO:QZ48v500w2410141040,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (874, 'P00321', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080066,VI:202422410R3080066,MO:QZ48v500w2410141030,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELEC...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080066,VI:202422410R3080066,MO:QZ48v500w2410141030,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO  PB:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (875, 'P00325', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080093,VI:202422410R9080093,MO:QZ48v500w2407172331,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080093,VI:202422410R9080093,MO:QZ48v500w2407172331,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (876, 'P00326', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080059,VI:202422410R2080059,MO:QZ48v500w2408010373,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADA,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080059,VI:202422410R2080059,MO:QZ48v500w2408010373,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADA,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (877, 'P00327', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080103,VI:202422410R9080103,MO:QZ48v500w2408010311,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080103,VI:202422410R9080103,MO:QZ48v500w2408010311,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (878, 'P00328', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080039,VI:202422410R0080039,MO:QZ48v500w2408010362,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080039,VI:202422410R0080039,MO:QZ48v500w2408010362,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (879, 'P00331', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080022,VI:202422410R8080022,MO:QZ48v500w2408010349,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080022,VI:202422410R8080022,MO:QZ48v500w2408010349,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (880, 'P00332', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080063,VI:202422410R3080063,MO:QZ48v500w2410141011,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080063,VI:202422410R3080063,MO:QZ48v500w2410141011,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (881, 'P00335', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R5080006,VI:202422410R5080006,MO:QZ48v500w2410141025,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R5080006,VI:202422410R5080006,MO:QZ48v500w2410141025,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (882, 'P00339', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080048,VI:202422410R0080048,MO:QZ48v500w2408010381,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080048,VI:202422410R0080048,MO:QZ48v500w2408010381,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (883, 'P00343', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080015,VI:202422410R9080015,MO:QZ48v500w2410141048,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R9080015,VI:202422410R9080015,MO:QZ48v500w2410141048,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (884, 'P00344', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080054,VI:202422410R0080054,MO:QZ48v500w2408010380,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080054,VI:202422410R0080054,MO:QZ48v500w2408010380,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (885, 'P00348', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080081,VI:202422410R3080081,MO:QZ48v500w2407172334,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080081,VI:202422410R3080081,MO:QZ48v500w2407172334,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (886, 'P00349', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080094,VI:202422410R8080094,MO:QZ48v500w2410141002,,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELEC...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080094,VI:202422410R8080094,MO:QZ48v500w2410141002,,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROSADO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (887, 'P00351', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080004,VI:202422410R0080004,MO:QZ48v500w2410141010,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R0080004,VI:202422410R0080004,MO:QZ48v500w2410141010,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (888, 'P00352', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R5080005,VI:202422410R5080005,MO:QZ48v500w2408010399,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R5080005,VI:202422410R5080005,MO:QZ48v500w2408010399,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (889, 'P00353', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R6080086,VI:202422410R6080086,MO:QZ48v500w2408010321,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R6080086,VI:202422410R6080086,MO:QZ48v500w2408010321,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (890, 'P00354', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R1080089,VI:202422410R1080089,MO:QZ48v500w2408010329,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R1080089,VI:202422410R1080089,MO:QZ48v500w2408010329,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (891, 'P00355', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080043,VI:202422410R2080043,MO:QZ48v500w2410141027,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080043,VI:202422410R2080043,MO:QZ48v500w2410141027,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (892, 'P00356', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080045,VI:202422410R3080045,MO:QZ48v500w2410141034,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R3080045,VI:202422410R3080045,MO:QZ48v500w2410141034,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (893, 'P00359', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080021,VI:202422410R2080021,MO:QZ48v500w2408010390,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080021,VI:202422410R2080021,MO:QZ48v500w2408010390,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (894, 'P00361', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R4080083,VI:202422410R4080083,MO:QZ48v500w2408010330,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R4080083,VI:202422410R4080083,MO:QZ48v500w2408010330,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (895, 'P00364', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R7080057,VI:202422410R7080057,MO:QZ48v500w2408010352,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRI...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R7080057,VI:202422410R7080057,MO:QZ48v500w2408010352,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (896, 'P00367', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R1080034,VI:202422410R1080034,MO:QZ48v500w2408010305,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRI...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R1080034,VI:202422410R1080034,MO:QZ48v500w2408010305,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (897, 'P00368', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080061,VI:202422410R2080061,MO:QZ48v500w2408010397,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R2080061,VI:202422410R2080061,MO:QZ48v500w2408010397,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (898, 'P00372', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R6080027,VI:202422410R6080027,MO:QZ48v500w2408081380,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRI...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R6080027,VI:202422410R6080027,MO:QZ48v500w2408081380,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (899, 'P00374', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080106,VI:202422410R8080106,MO:QZ48v500w2407239327,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:202422410R8080106,VI:202422410R8080106,MO:QZ48v500w2407239327,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:NEGRO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (900, 'P00378', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:Y666278Z6R3500029,VI:Y666278Z6R3500029,MO:YJ48v500w2406131949,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECT...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 CH:Y666278Z6R3500029,VI:Y666278Z6R3500029,MO:YJ48v500w2406131949,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (901, 'P00379', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 	CH:Y666278Z6R4500020,VI:Y666278Z6R4500020,MO:YJ48v500w2406131880,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024 	CH:Y666278Z6R4500020,VI:Y666278Z6R4500020,MO:YJ48v500w2406131880,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (902, 'P00382', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:Y666278Z6R7500016,VI:Y666278Z6R7500016,MO:YJ48v500w2406131842,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:Y666278Z6R7500016,VI:Y666278Z6R7500016,MO:YJ48v500w2406131842,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:ROJO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (903, 'P00386', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:HL1162283R8966008,VI:HL1162283R8966008,MO:YJ48v500w2406081778,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELEC...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:HL1162283R8966008,VI:HL1162283R8966008,MO:YJ48v500w2406081778,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (904, 'P00394', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:HL1162283R8966004,VI:HL1162283R8966004,MO:YJ48v500w2406131861,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELEC...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:HL1162283R8966004,VI:HL1162283R8966004,MO:YJ48v500w2406131861,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (905, 'P00395', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:HL1162283R8966003,VI:HL1162283R8966003,MO:YJ48v500w2406131902,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELEC...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:HL1162283R8966003,VI:HL1162283R8966003,MO:YJ48v500w2406131902,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:BLANCO,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (906, 'P00396', NULL, 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:LY2226668R2410089,VI:LY2226668R2410089,MO:YJ60v500w2405071115,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:AZUL,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTR...', 'L1,MARCA:JOANIS,MODELO:ELEGANT,AÑO MOD:2024, CH:LY2226668R2410089,VI:LY2226668R2410089,MO:YJ60v500w2405071115,CC:0,CO:ELECTRICO,SNTT:0  CA:MOTOCICLETA,PM:1.20@3000,AS:1,PA:0,FR:2X1,TT:AUT,C1:AZUL,B:198,PN:48,CU:150,L:2200,AN:560,AL:1100,NR:2  TE:ELECTRICO,SAC,KILOMETRAJE:1.00', 600.00, 0.00, 0.00, 0.00, 600.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (907, 'P00402', NULL, 'L1, MARCA:ILIDESAVA,MODELO:TPC, AÑO MOD:2025 CH:202501100S0959106,VI:202501100S0959106,MO:1000959106, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:NEGRO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:...', 'L1, MARCA:ILIDESAVA,MODELO:TPC, AÑO MOD:2025 CH:202501100S0959106,VI:202501100S0959106,MO:1000959106, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:NEGRO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (908, 'P00404', NULL, 'L1, MARCA:ILIDESAVA,MODELO:TPC, AÑO MOD:2025 CH:202501100S0959109, VI:202501100S0959109, MO:1000959109, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE...', 'L1, MARCA:ILIDESAVA,MODELO:TPC, AÑO MOD:2025 CH:202501100S0959109, VI:202501100S0959109, MO:1000959109, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (909, 'P00412', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959204, VI:202501100S0959204, MO:1000959204 , CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:NEGRO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959204, VI:202501100S0959204, MO:1000959204 , CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:NEGRO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (910, 'P00414', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959206, VI:202501100S0959206, MO:1000959206 , CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959206, VI:202501100S0959206, MO:1000959206 , CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (911, 'P00424', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959305, VI:202501100S0959305, MO:1000959305, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:NEGRO  PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959305, VI:202501100S0959305, MO:1000959305, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:NEGRO  PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (912, 'P00427', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959309, VI:202501100S0959309, MO:1000959309, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO  PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959309, VI:202501100S0959309, MO:1000959309, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO  PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (913, 'P00430', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959313,VI:202501100S0959313,MO:1000959313, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE  PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959313,VI:202501100S0959313,MO:1000959313, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE  PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (914, 'P00436', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959404, VI:202501100S0959404, MO:1000959404, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 ...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959404, VI:202501100S0959404, MO:1000959404, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (915, 'P00437', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959405 , VI:202501100S0959405, MO:1000959405, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959405 , VI:202501100S0959405, MO:1000959405, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (916, 'P00438', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959406, VI:202501100S0959406, MO:1000959406, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 ...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959406, VI:202501100S0959406, MO:1000959406, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:ROJO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (917, 'P00439', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959407, VI:202501100S0959407, MO:1000959407, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH: 202501100S0959407, VI:202501100S0959407, MO:1000959407, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (918, 'P00440', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959408, VI:202501100S0959408, MO:1000959408, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959408, VI:202501100S0959408, MO:1000959408, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (919, 'P00441', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959409, VI:202501100S0959409, MO:1000959409, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959409, VI:202501100S0959409, MO:1000959409, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:CELESTE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (920, 'P00442', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959410, VI:202501100S0959410, MO:1000959410, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:VERDE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 ...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959410, VI:202501100S0959410, MO:1000959410, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:VERDE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (921, 'P00443', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959411, VI:202501100S0959411, MO:1000959411, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:VERDE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 ...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959411, VI:202501100S0959411, MO:1000959411, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:VERDE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (922, 'P00444', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959412, VI:202501100S0959412, MO:1000959412, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:VERDE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 ...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959412, VI:202501100S0959412, MO:1000959412, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:VERDE PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (923, 'P00446', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959414, VI:202501100S0959414, MO:1000959414, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:GRIS PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 T...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959414, VI:202501100S0959414, MO:1000959414, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:GRIS PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (924, 'P00447', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959415, VI:202501100S0959415, MO:1000959415, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:GRIS PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 T...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:202501100S0959415, VI:202501100S0959415, MO:1000959415, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:GRIS PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (925, 'P00450', NULL, 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:882024052S7000004, VI:882024052S7000004, MO:XZS627240506, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:AMARILLO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, ...', 'L1, MARCA:ILIDESAVA, MODELO:TPC, AÑO MOD:2025 CH:882024052S7000004, VI:882024052S7000004, MO:XZS627240506, CC:0, CO:ELECTRICO,SNTT:0 CA:MOTOCICLETA, PM:1.20@3000, AS:1, PA:0,FR:2X1, TT:AUT, C1:AMARILLO PB:550, PN:240, CU:310, LA:1600, AN:1050, AL:750, NR:3 TE:ELECTRICO, SAC, KILOMETRAJE:1.00', 750.00, 0.00, 0.00, 0.00, 750.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (926, 'P00455', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1KWE103S4000888, VI:HE1KWE103S4000888, MO:20250193143, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:ROJO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:E...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1KWE103S4000888, VI:HE1KWE103S4000888, MO:20250193143, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:ROJO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1575.00, 0.00, 0.00, 0.00, 1575.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (927, 'P00459', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1KWE100S4000900, VI:HE1KWE100S4000900, MO:20250193151, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 T...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1KWE100S4000900, VI:HE1KWE100S4000900, MO:20250193151, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1575.00, 0.00, 0.00, 0.00, 1575.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (928, 'P00460', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1KWE104S4000902, VI:HE1KWE104S4000902, MO:20250193149, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 T...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1KWE104S4000902, VI:HE1KWE104S4000902, MO:20250193149, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1575.00, 0.00, 0.00, 0.00, 1575.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (929, 'P00468', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU207S4000177, VI:HE1CWU207S4000177, MO:2025011178,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:NEGRO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU207S4000177, VI:HE1CWU207S4000177, MO:2025011178,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:NEGRO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1575.00, 0.00, 0.00, 0.00, 1575.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (930, 'P00470', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU201S4000174,VI:HE1CWU201S4000174,MO:2025011179,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:NEGRO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:EL...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU201S4000174,VI:HE1CWU201S4000174,MO:2025011179,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:NEGRO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1375.00, 0.00, 0.00, 0.00, 1375.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (931, 'P00472', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU208S4000169, VI:HE1CWU208S4000169, MO:2025011168,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 T...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU208S4000169, VI:HE1CWU208S4000169, MO:2025011168,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1375.00, 0.00, 0.00, 0.00, 1375.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (932, 'P00474', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU206S4000171, VI:HE1CWU206S4000171, MO:2025011165,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 T...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU206S4000171, VI:HE1CWU206S4000171, MO:2025011165,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1375.00, 0.00, 0.00, 0.00, 1375.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (933, 'P00475', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU208S4000172, VI:HE1CWU208S4000172, MO:2025011169,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 T...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU208S4000172, VI:HE1CWU208S4000172, MO:2025011169,  CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1375.00, 0.00, 0.00, 0.00, 1375.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (934, 'P00476', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU20XS4000173, VI:HE1CWU20XS4000173, MO:2025011166, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU20XS4000173, VI:HE1CWU20XS4000173, MO:2025011166, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:CELESTE PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1375.00, 0.00, 0.00, 0.00, 1375.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (935, 'P00478', NULL, 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU207S4000180, VI:HE1CWU207S4000180, MO:2025011163, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:ROJO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:EL...', 'L2, MARCA:ILIDESAVA, MODELO:XK, AÑO MOD:2025 CH:HE1CWU207S4000180, VI:HE1CWU207S4000180, MO:2025011163, CC:0, CO:ELECTRICO,SNTT:0  CA:TRIMOTO CARGA, PM:1.20@3000,AS:1,PA:0,FR:3X2,TT:AUT,C1:ROJO PB:250, PN:50, CU:200, LA:1800, AN:650, AL:1100,NR:2 TE:ELECTRICO, SAC, KILOMETRAJE:1', 1375.00, 0.00, 0.00, 0.00, 1375.00, 0, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, NULL, '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 15:07:51');
INSERT INTO `productos` VALUES (936, 'D-38', NULL, 'OLLA ARROCERA', NULL, 23.00, 0.00, 0.00, 0.00, 23.00, 30, 0, 0, 4, 50, 1, '1', '51121703', '0', '0', 'PEN', '1', NULL, '2026-03-04', '2026-03-04 15:07:51', NULL, '2026-03-04 15:07:51', '2026-03-04 17:59:15');

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
  `subtotal` decimal(10, 2) GENERATED ALWAYS AS ((`cantidad` * `precio`)) STORED NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_producto_compra`) USING BTREE,
  INDEX `idx_compra`(`id_compra` ASC) USING BTREE,
  INDEX `idx_producto`(`id_producto` ASC) USING BTREE,
  CONSTRAINT `productos_compras_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `productos_compras_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of productos_compras
-- ----------------------------
INSERT INTO `productos_compras` VALUES (1, 1, 628, 11.00, 21.000, 21.000, DEFAULT, '2026-03-04 05:46:03', '2026-03-04 05:46:03');

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
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of productos_ventas
-- ----------------------------
INSERT INTO `productos_ventas` VALUES (2, 2, 162, 1, 15.00, 12.71, 2.29, 15.00, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-02-28 15:14:23', '2026-02-28 15:14:23');
INSERT INTO `productos_ventas` VALUES (3, 3, 161, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-02-28 15:14:54', '2026-02-28 15:14:54');
INSERT INTO `productos_ventas` VALUES (4, 4, 628, 1, 110.00, 93.22, 16.78, 110.00, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-03-02 17:40:50', '2026-03-02 17:40:50');
INSERT INTO `productos_ventas` VALUES (5, 5, 627, 1, 110.00, 93.22, 16.78, 110.00, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-03-02 20:52:51', '2026-03-02 20:52:51');
INSERT INTO `productos_ventas` VALUES (6, 6, 626, 1, 23.00, 19.49, 3.51, 23.00, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-03-02 20:53:26', '2026-03-02 20:53:26');
INSERT INTO `productos_ventas` VALUES (7, 7, 628, 1, 110.00, 93.22, 16.78, 110.00, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-03-04 04:28:21', '2026-03-04 04:28:21');
INSERT INTO `productos_ventas` VALUES (8, 8, 320, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-03-04 12:24:29', '2026-03-04 12:24:29');
INSERT INTO `productos_ventas` VALUES (9, 9, 320, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, NULL, NULL, '2026-03-04 12:28:19', '2026-03-04 12:28:19');
INSERT INTO `productos_ventas` VALUES (10, 10, 629, 1, 12.00, 10.17, 1.83, 12.00, NULL, 'NIU', '10', NULL, 'holas', 'PROD-A2-00001', '2026-03-04 13:39:05', '2026-03-04 13:39:05');
INSERT INTO `productos_ventas` VALUES (11, 11, 320, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, 'holaaa', 'PROD-A1-00001', '2026-03-04 13:43:55', '2026-03-04 13:43:55');
INSERT INTO `productos_ventas` VALUES (12, 12, 320, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, 'holaaa', 'PROD-A1-00001', '2026-03-04 13:51:33', '2026-03-04 13:51:33');
INSERT INTO `productos_ventas` VALUES (13, 13, 320, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, 'holaaa', 'PROD-A1-00001', '2026-03-04 13:52:43', '2026-03-04 13:52:43');
INSERT INTO `productos_ventas` VALUES (14, 14, 320, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, 'holaaa', 'PROD-A1-00001', '2026-03-04 14:02:40', '2026-03-04 14:02:40');
INSERT INTO `productos_ventas` VALUES (16, 16, 631, 12, 25.00, 254.24, 45.76, 300.00, NULL, 'NIU', '10', NULL, 'Servicio de consultoría', 'LIB-0001', '2026-03-04 14:17:24', '2026-03-04 14:17:24');
INSERT INTO `productos_ventas` VALUES (17, 17, 320, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, 'holaaa', 'PROD-A1-00001', '2026-03-04 14:24:03', '2026-03-04 14:24:03');
INSERT INTO `productos_ventas` VALUES (18, 18, 320, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, 'holaaa', 'PROD-A1-00001', '2026-03-04 14:28:23', '2026-03-04 14:28:23');
INSERT INTO `productos_ventas` VALUES (19, 19, 320, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, 'holaaa', 'PROD-A1-00001', '2026-03-04 16:20:18', '2026-03-04 16:20:18');
INSERT INTO `productos_ventas` VALUES (20, 20, 320, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, 'holaaa', 'PROD-A1-00001', '2026-03-04 16:53:57', '2026-03-04 16:53:57');
INSERT INTO `productos_ventas` VALUES (21, 21, 320, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, 'holaaa', 'PROD-A1-00001', '2026-03-04 17:16:41', '2026-03-04 17:16:41');
INSERT INTO `productos_ventas` VALUES (22, 22, 320, 1, 1.00, 0.85, 0.15, 1.00, NULL, 'NIU', '10', NULL, 'holaaa', 'PROD-A1-00001', '2026-03-04 17:45:07', '2026-03-04 17:45:07');
INSERT INTO `productos_ventas` VALUES (23, 23, 936, 1, 23.00, 19.49, 3.51, 23.00, NULL, 'NIU', '10', NULL, 'OLLA ARROCERA', 'D-38', '2026-03-04 17:59:01', '2026-03-04 17:59:01');
INSERT INTO `productos_ventas` VALUES (24, 24, 936, 1, 23.00, 19.49, 3.51, 23.00, NULL, 'NIU', '10', NULL, 'OLLA ARROCERA', 'D-38', '2026-03-04 17:59:15', '2026-03-04 17:59:15');

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
  `fecha_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`proveedor_id`) USING BTREE,
  UNIQUE INDEX `ruc`(`ruc` ASC) USING BTREE,
  INDEX `idx_empresa`(`id_empresa` ASC) USING BTREE,
  INDEX `idx_ruc`(`ruc` ASC) USING BTREE,
  INDEX `idx_estado`(`estado` ASC) USING BTREE,
  INDEX `idx_razon_social`(`razon_social` ASC) USING BTREE,
  CONSTRAINT `proveedores_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of proveedores
-- ----------------------------
INSERT INTO `proveedores` VALUES (1, '20100131359', 'DATACONT S.A.C.', 'Av. Los Incas 123', '987654321', 'ventas@datacont.com', 1, 'Lima', 'Lima', 'San Isidro', '150131', 1, '2026-01-08 13:50:35', '2026-01-08 13:50:35', '2026-01-08 13:50:35');
INSERT INTO `proveedores` VALUES (2, '20601907063', 'CYBERGAMES (C.G.S.) E.I.R.L.', 'Jr. Comercio 456', '912345678', 'contacto@cybergames.com', 1, 'Lima', 'Lima', 'Miraflores', '150140', 1, '2026-01-08 13:50:35', '2026-01-08 13:50:35', '2026-01-08 13:50:35');
INSERT INTO `proveedores` VALUES (3, '20123456789', 'DISTRIBUIDORA PERU S.A.', 'Av. Industrial 789', '998877665', 'info@distriperu.com', 1, 'Lima', 'Lima', 'Los Olivos', '150117', 1, '2026-01-08 13:50:35', '2026-01-08 13:50:35', '2026-01-08 13:50:35');
INSERT INTO `proveedores` VALUES (4, '20608300393', 'COMPAÑIA FOOD RETAIL S.A.C.', 'CAL. CESAR MORELLI NRO. 181 URB. SAN BORJA NORTE LIMA LIMA SAN BORJA', '993321920', 'kiyotakahitori@gmail.com', 1, 'LIMA', 'LIMA', 'SAN BORJA', '150130', 1, '2026-01-09 00:36:05', '2026-01-08 23:36:05', '2026-01-08 23:36:05');
INSERT INTO `proveedores` VALUES (5, '10774252008', 'YARLEQUE ZAPATA EMER RODRIGO', NULL, '', '', 2, NULL, NULL, NULL, NULL, 1, '2026-03-04 00:45:46', '2026-03-04 05:45:46', '2026-03-04 05:45:46');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `rol_id` int NOT NULL,
  `permission_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `role_permission_rol_id_permission_id_unique`(`rol_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `role_permission_permission_id_foreign`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `role_permission_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `role_permission_rol_id_foreign` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (1, 6, 45, NULL, NULL);
INSERT INTO `role_permission` VALUES (2, 3, 45, NULL, NULL);
INSERT INTO `role_permission` VALUES (4, 3, 17, NULL, NULL);
INSERT INTO `role_permission` VALUES (8, 3, 61, NULL, NULL);
INSERT INTO `role_permission` VALUES (9, 3, 21, NULL, NULL);
INSERT INTO `role_permission` VALUES (10, 3, 65, NULL, NULL);
INSERT INTO `role_permission` VALUES (11, 3, 5, NULL, NULL);

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
INSERT INTO `sessions` VALUES ('4WUzo0xi01jZaQJKDPBQkdRxPkyKMvStAUGsvxBC', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiWHR5OUVRRDc5MFUzTHl5dmxzb1VhZzJ3MFp5dnJTd3VCWW96OElsbCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NjU6Imh0dHA6Ly9mYWN0dXJhY2lvbl9zYW50b2QudGVzdC9hcGkvcHJvdmVlZG9yZXM/c2VhcmNoPTEwNzYxNjU5NjIxIjtzOjU6InJvdXRlIjtOO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTIkb2tETnJ6U0MxWWF0NzlTdUlMY21QT3VtL1h3blJzdS5tcS92aVpadlFndHJKT1BscC9RaHUiO30=', 1772652718);
INSERT INTO `sessions` VALUES ('B0E7J8L5f4XGT0AwdaMESHTG52QoMrPlHE1lPyZf', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiU09MdGxQVmZsdHlITmlSN1JNN2Z0TkF6cFlZVHhoNjVnUURoa2pPdyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly9mYWN0dXJhX2lsaWRlc2F2YS50ZXN0L2FwaS9wZXJtaXNzaW9ucy91c2VyIjtzOjU6InJvdXRlIjtOO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTIkb2tETnJ6U0MxWWF0NzlTdUlMY21QT3VtL1h3blJzdS5tcS92aVpadlFndHJKT1BscC9RaHUiO30=', 1772647166);
INSERT INTO `sessions` VALUES ('cBQS9JA7sjOwKMfdBVFHFzfShnfrIzo9bCwMmyI7', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiZWtjVTRoVTMweXdSb3JPZzd6MkQ3R1lxNm1Fb0xpbWh2cFg3Z2RoRSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTI6Imh0dHA6Ly9mYWN0dXJhY2lvbl9zYW50b2QudGVzdC9hcGkvY3VlbnRhcy1wb3ItcGFnYXIiO3M6NToicm91dGUiO047fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRva0ROcnpTQzFZYXQ3OVN1SUxjbVBPdW0vWHduUnN1Lm1xL3ZpWlp2UWd0ckpPUGxwL1FodSI7fQ==', 1772652991);
INSERT INTO `sessions` VALUES ('HMf7nantBDdhSKNPrE9vdzhvw0MgkFE2EJq4Ly0t', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZXdSTHBwOEFYV3NWZHp0Y0huNkFwQlVudWNSczA5R1o4UVJHT25raCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9mYWN0dXJhY2lvbl9zYW50b2QudGVzdC9pbmljaW8iO3M6NToicm91dGUiO3M6NjoiaW5pY2lvIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1772649774);

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
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of unidades
-- ----------------------------
INSERT INTO `unidades` VALUES (1, 'UNIDAD', 'NIU', NULL, '1', '2026-02-27 18:02:12', '2026-03-04 09:29:19');
INSERT INTO `unidades` VALUES (2, 'BAG', 'BAG', NULL, '1', '2026-02-27 18:02:12', '2026-03-04 09:29:19');

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Test User', 'test@example.com', 1, 1, '12345678', 'Administrador', 'Sistema', NULL, '1', NULL, '2026-01-06 13:01:58', '$2y$12$i8TQgyX4j4g8Ki6V/EAsiu5SpTwpbOY.eExFoOA8xoqLTy7v7fKGu', 'nJhRB8uy71', '2026-01-06 13:01:59', '2026-01-06 13:01:59');
INSERT INTO `users` VALUES (2, 'Administrador', 'admin@ilidesava.com', 1, 1, '12345678', 'Administrador', 'Sistema', NULL, '1', NULL, NULL, '$2y$12$okDNrzSC1Yat79SuILcmPOum/XwnRsu.mq/viZZvQgtrJOPlp/Qhu', NULL, '2026-01-06 08:07:15', '2026-03-04 17:58:26');
INSERT INTO `users` VALUES (3, 'gojo', 'adan2025zapata@gmail.com', 3, 1, NULL, NULL, NULL, NULL, '1', NULL, NULL, '$2y$12$8j7Caoo/qMtU1uHBMih.2OHbCH4sXDgOH2FcYca06j2xguScuGrti', NULL, '2026-02-24 03:27:00', '2026-02-24 03:38:49');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of venta_empresa
-- ----------------------------

-- ----------------------------
-- Table structure for ventas
-- ----------------------------
DROP TABLE IF EXISTS `ventas`;
CREATE TABLE `ventas`  (
  `id_venta` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_tido` bigint UNSIGNED NOT NULL,
  `id_tipo_pago` bigint UNSIGNED NULL DEFAULT NULL,
  `afecta_stock` tinyint(1) NOT NULL DEFAULT 1,
  `stock_real_descontado` tinyint(1) NOT NULL DEFAULT 0,
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
  `nombre_xml` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cdr_url` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `observaciones` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `tipo_moneda` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PEN',
  `tipo_cambio` decimal(10, 4) NULL DEFAULT NULL,
  `descuento_global` decimal(10, 2) NULL DEFAULT NULL,
  `subtotal` decimal(10, 2) NULL DEFAULT NULL,
  `igv` decimal(10, 2) NULL DEFAULT NULL,
  `id_usuario` bigint UNSIGNED NULL DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cotizacion_id` bigint UNSIGNED NULL DEFAULT NULL,
  `nota_venta_id` bigint UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id_venta`) USING BTREE,
  INDEX `ventas_id_cliente_index`(`id_cliente` ASC) USING BTREE,
  INDEX `ventas_id_empresa_index`(`id_empresa` ASC) USING BTREE,
  INDEX `ventas_id_tido_index`(`id_tido` ASC) USING BTREE,
  INDEX `ventas_estado_index`(`estado` ASC) USING BTREE,
  INDEX `ventas_fecha_emision_index`(`fecha_emision` ASC) USING BTREE,
  INDEX `ventas_serie_numero_index`(`serie` ASC, `numero` ASC) USING BTREE,
  INDEX `fk_ventas_cotizacion`(`cotizacion_id` ASC) USING BTREE,
  INDEX `ventas_nota_venta_id_index`(`nota_venta_id` ASC) USING BTREE,
  CONSTRAINT `fk_ventas_cotizacion` FOREIGN KEY (`cotizacion_id`) REFERENCES `cotizaciones` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ventas
-- ----------------------------
INSERT INTO `ventas` VALUES (2, 1, 1, 1, 0, '2026-02-28', NULL, NULL, '', 'B001', 1, 5, 15.00, '1', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 12.71, 2.29, 2, '2026-02-28 15:14:23', '2026-02-28 15:14:23', '2026-02-28 15:14:23', NULL, NULL);
INSERT INTO `ventas` VALUES (3, 1, 1, 1, 0, '2026-02-28', NULL, NULL, '', 'B001', 1, 9, 1.00, '1', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-02-28 15:14:54', '2026-02-28 15:14:54', '2026-02-28 15:14:54', NULL, NULL);
INSERT INTO `ventas` VALUES (4, 2, 1, 1, 0, '2026-03-02', NULL, NULL, '', 'F001', 1, 10, 110.00, '1', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 93.22, 16.78, 2, '2026-03-02 17:40:50', '2026-03-02 17:40:50', '2026-03-02 17:40:50', 7, NULL);
INSERT INTO `ventas` VALUES (5, 1, 1, 1, 0, '2026-03-02', NULL, NULL, '', 'B001', 2, 9, 110.00, '1', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 93.22, 16.78, 2, '2026-03-02 20:52:51', '2026-03-02 20:52:51', '2026-03-02 20:52:51', 8, NULL);
INSERT INTO `ventas` VALUES (6, 1, 1, 1, 0, '2026-03-02', NULL, NULL, '', 'B001', 3, 9, 23.00, '1', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 19.49, 3.51, 2, '2026-03-02 20:53:26', '2026-03-02 20:53:26', '2026-03-02 20:53:26', NULL, NULL);
INSERT INTO `ventas` VALUES (7, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 4, 9, 110.00, '1', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 93.22, 16.78, 2, '2026-03-04 04:28:21', '2026-03-04 04:28:21', '2026-03-04 04:28:21', NULL, NULL);
INSERT INTO `ventas` VALUES (8, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 1, 11, 1.00, '1', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-03-04 12:24:29', '2026-03-04 12:24:29', '2026-03-04 12:24:29', NULL, NULL);
INSERT INTO `ventas` VALUES (9, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 2, 11, 1.00, '1', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-03-04 12:28:19', '2026-03-04 12:28:19', '2026-03-04 12:28:19', NULL, NULL);
INSERT INTO `ventas` VALUES (10, 6, 1, 0, 0, '2026-03-04', NULL, NULL, '', 'NV01', 1, 12, 12.00, '1', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 10.17, 1.83, 2, '2026-03-04 13:39:05', '2026-03-04 13:39:05', '2026-03-04 13:39:05', NULL, NULL);
INSERT INTO `ventas` VALUES (11, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 3, 12, 1.00, '1', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-03-04 13:43:55', '2026-03-04 13:43:55', '2026-03-04 13:43:55', NULL, NULL);
INSERT INTO `ventas` VALUES (12, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 4, 12, 1.00, '1', NULL, NULL, NULL, 3, 'hsydBrgOcsNoInrUnW3hzB2b59k=', NULL, NULL, NULL, '2', '0111', 'No tiene el perfil para enviar comprobantes electronicos - Detalle: Rejected by policy.', 1, NULL, 'sunat/xml/20987654321/20987654321-03-B001-4.xml', '20987654321-03-B001-4', NULL, NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-03-04 13:51:33', '2026-03-04 13:51:33', '2026-03-04 13:52:06', NULL, NULL);
INSERT INTO `ventas` VALUES (13, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 5, 12, 1.00, '1', NULL, NULL, NULL, 3, 'zLFs5C7iUVI0haxUGWNInXXyMH0=', NULL, NULL, NULL, '1', '0', 'La Boleta numero B001-5, ha sido aceptada', 1, NULL, 'sunat/xml/20000000001/20000000001-03-B001-5.xml', '20000000001-03-B001-5', 'sunat/cdr/20000000001/R-20000000001-03-B001-5.zip', NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-03-04 13:52:43', '2026-03-04 13:52:43', '2026-03-04 14:02:19', NULL, NULL);
INSERT INTO `ventas` VALUES (14, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 6, 12, 1.00, '1', NULL, NULL, NULL, 3, 'Tt1b0s+NMUwDG8FmYPO268NQW1s=', NULL, NULL, NULL, '1', '0', 'La Boleta numero B001-6, ha sido aceptada', NULL, NULL, 'sunat/xml/20000000001/20000000001-03-B001-6.xml', '20000000001-03-B001-6', 'sunat/cdr/20000000001/R-20000000001-03-B001-6.zip', NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-03-04 14:02:40', '2026-03-04 14:02:40', '2026-03-04 14:02:57', NULL, NULL);
INSERT INTO `ventas` VALUES (16, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 7, 12, 300.00, '1', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 254.24, 45.76, 2, '2026-03-04 14:17:24', '2026-03-04 14:17:24', '2026-03-04 14:17:24', NULL, NULL);
INSERT INTO `ventas` VALUES (17, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 8, 12, 1.00, '1', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-03-04 14:24:03', '2026-03-04 14:24:03', '2026-03-04 14:24:03', NULL, NULL);
INSERT INTO `ventas` VALUES (18, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 9, 12, 1.00, '1', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-03-04 14:28:23', '2026-03-04 14:28:23', '2026-03-04 14:28:23', NULL, NULL);
INSERT INTO `ventas` VALUES (19, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 10, 13, 1.00, '1', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-03-04 16:20:18', '2026-03-04 16:20:18', '2026-03-04 16:20:18', NULL, NULL);
INSERT INTO `ventas` VALUES (20, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 11, 14, 1.00, '1', NULL, NULL, NULL, 3, 'x9qRxMcR6fiUKQlLpxcney2WeJc=', NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, 'sunat/xml/20000000001/20000000001-03-B001-11.xml', '20000000001-03-B001-11', NULL, NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-03-04 16:53:57', '2026-03-04 16:53:57', '2026-03-04 16:54:13', NULL, NULL);
INSERT INTO `ventas` VALUES (21, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 12, 15, 1.00, '1', NULL, NULL, NULL, 3, 'nGS1vwsQUXJl6PD0pNSFAAL+H4Y=', NULL, NULL, NULL, '1', '0', 'La Boleta numero B001-12, ha sido aceptada', NULL, NULL, 'sunat/xml/20000000001/20000000001-03-B001-12.xml', '20000000001-03-B001-12', 'sunat/cdr/20000000001/R-20000000001-03-B001-12.zip', NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-03-04 17:16:41', '2026-03-04 17:16:41', '2026-03-04 17:17:10', NULL, NULL);
INSERT INTO `ventas` VALUES (22, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 13, 16, 1.00, '1', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 0.85, 0.15, 2, '2026-03-04 17:45:07', '2026-03-04 17:45:07', '2026-03-04 17:45:07', NULL, NULL);
INSERT INTO `ventas` VALUES (23, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 1, 17, 23.00, '1', NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 19.49, 3.51, 2, '2026-03-04 17:59:01', '2026-03-04 17:59:01', '2026-03-04 17:59:01', NULL, NULL);
INSERT INTO `ventas` VALUES (24, 1, 1, 1, 0, '2026-03-04', NULL, NULL, '', 'B001', 2, 18, 23.00, '1', NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PEN', NULL, NULL, 19.49, 3.51, 2, '2026-03-04 17:59:15', '2026-03-04 17:59:15', '2026-03-04 17:59:15', NULL, NULL);

-- ----------------------------
-- Table structure for ventas_anuladas
-- ----------------------------
DROP TABLE IF EXISTS `ventas_anuladas`;
CREATE TABLE `ventas_anuladas`  (
  `id_venta_anulada` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_venta` bigint UNSIGNED NOT NULL,
  `id_usuario` bigint UNSIGNED NOT NULL,
  `motivo_anulacion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_anulacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
  `voucher` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
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
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ventas_pagos
-- ----------------------------
INSERT INTO `ventas_pagos` VALUES (2, 2, 1, 15.00, NULL, '2026-02-28', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-02-28 15:14:23', '2026-02-28 15:14:23');
INSERT INTO `ventas_pagos` VALUES (3, 3, 1, 1.00, NULL, '2026-02-28', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-02-28 15:14:54', '2026-02-28 15:14:54');
INSERT INTO `ventas_pagos` VALUES (4, 4, 1, 110.00, NULL, '2026-03-02', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-02 17:40:50', '2026-03-02 17:40:50');
INSERT INTO `ventas_pagos` VALUES (5, 5, 1, 110.00, NULL, '2026-03-02', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-02 20:52:51', '2026-03-02 20:52:51');
INSERT INTO `ventas_pagos` VALUES (6, 6, 4, 23.00, '23423', '2026-03-02', NULL, NULL, 'vouchers/voucher_6_1772484806.webp', 'PEN', NULL, NULL, '2026-03-02 20:53:28', '2026-03-02 20:53:28');
INSERT INTO `ventas_pagos` VALUES (7, 7, 1, 110.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 04:28:21', '2026-03-04 04:28:21');
INSERT INTO `ventas_pagos` VALUES (8, 8, 1, 1.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 12:24:29', '2026-03-04 12:24:29');
INSERT INTO `ventas_pagos` VALUES (9, 9, 1, 1.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 12:28:19', '2026-03-04 12:28:19');
INSERT INTO `ventas_pagos` VALUES (10, 10, 1, 12.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 13:39:05', '2026-03-04 13:39:05');
INSERT INTO `ventas_pagos` VALUES (11, 11, 1, 1.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 13:43:55', '2026-03-04 13:43:55');
INSERT INTO `ventas_pagos` VALUES (12, 12, 5, 1.00, '234232', '2026-03-04', NULL, NULL, 'vouchers/voucher_12_1772632293.png', 'PEN', NULL, NULL, '2026-03-04 13:51:33', '2026-03-04 13:51:33');
INSERT INTO `ventas_pagos` VALUES (13, 13, 1, 1.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 13:52:43', '2026-03-04 13:52:43');
INSERT INTO `ventas_pagos` VALUES (14, 14, 1, 1.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 14:02:40', '2026-03-04 14:02:40');
INSERT INTO `ventas_pagos` VALUES (15, 16, 1, 300.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 14:17:24', '2026-03-04 14:17:24');
INSERT INTO `ventas_pagos` VALUES (16, 17, 1, 1.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 14:24:03', '2026-03-04 14:24:03');
INSERT INTO `ventas_pagos` VALUES (17, 18, 1, 1.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 14:28:23', '2026-03-04 14:28:23');
INSERT INTO `ventas_pagos` VALUES (18, 19, 1, 1.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 16:20:18', '2026-03-04 16:20:18');
INSERT INTO `ventas_pagos` VALUES (19, 20, 1, 1.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 16:53:57', '2026-03-04 16:53:57');
INSERT INTO `ventas_pagos` VALUES (20, 21, 1, 1.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 17:16:41', '2026-03-04 17:16:41');
INSERT INTO `ventas_pagos` VALUES (21, 22, 1, 1.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 17:45:07', '2026-03-04 17:45:07');
INSERT INTO `ventas_pagos` VALUES (22, 23, 1, 23.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 17:59:01', '2026-03-04 17:59:01');
INSERT INTO `ventas_pagos` VALUES (23, 24, 1, 23.00, NULL, '2026-03-04', NULL, NULL, NULL, 'PEN', NULL, NULL, '2026-03-04 17:59:15', '2026-03-04 17:59:15');

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
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_clientes_completo` AS select `c`.`id_cliente` AS `id_cliente`,`c`.`documento` AS `documento`,`c`.`datos` AS `datos`,`c`.`direccion` AS `direccion`,`c`.`direccion2` AS `direccion2`,`c`.`telefono` AS `telefono`,`c`.`telefono2` AS `telefono2`,`c`.`email` AS `email`,`c`.`ultima_venta` AS `ultima_venta`,`c`.`total_venta` AS `total_venta`,`c`.`ubigeo` AS `ubigeo`,`c`.`departamento` AS `departamento`,`c`.`provincia` AS `provincia`,`c`.`distrito` AS `distrito`,`e`.`id_empresa` AS `id_empresa`,`e`.`ruc` AS `empresa_ruc`,`e`.`razon_social` AS `empresa_razon_social`,`e`.`comercial` AS `empresa_comercial`,`c`.`created_at` AS `created_at`,`c`.`updated_at` AS `updated_at` from (`clientes` `c` join `empresas` `e` on((`c`.`id_empresa` = `e`.`id_empresa`)));

-- ----------------------------
-- View structure for view_compras_detalle
-- ----------------------------
DROP VIEW IF EXISTS `view_compras_detalle`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_compras_detalle` AS select `c`.`id_compra` AS `id_compra`,`c`.`serie` AS `serie`,`c`.`numero` AS `numero`,concat(`c`.`serie`,'-',lpad(`c`.`numero`,8,'0')) AS `documento`,`c`.`fecha_emision` AS `fecha_emision`,`c`.`fecha_vencimiento` AS `fecha_vencimiento`,`c`.`id_proveedor` AS `id_proveedor`,`c`.`proveedor_id` AS `proveedor_id`,`p`.`ruc` AS `proveedor_ruc`,`p`.`razon_social` AS `proveedor_nombre`,`c`.`id_tipo_pago` AS `id_tipo_pago`,(case when (`c`.`id_tipo_pago` = 1) then 'Contado' when (`c`.`id_tipo_pago` = 2) then 'Crédito' else 'Otro' end) AS `tipo_pago_nombre`,`c`.`moneda` AS `moneda`,`c`.`subtotal` AS `subtotal`,`c`.`igv` AS `igv`,`c`.`total` AS `total`,`c`.`observaciones` AS `observaciones`,`c`.`id_empresa` AS `id_empresa`,`c`.`id_usuario` AS `id_usuario`,`c`.`estado` AS `estado`,(case when (`c`.`estado` = '1') then 'Activo' when (`c`.`estado` = '0') then 'Anulado' else 'Desconocido' end) AS `estado_nombre`,`c`.`created_at` AS `created_at`,`c`.`updated_at` AS `updated_at`,(select count(0) from `productos_compras` `pc` where (`pc`.`id_compra` = `c`.`id_compra`)) AS `total_productos`,(select count(0) from `dias_compras` `dc` where (`dc`.`id_compra` = `c`.`id_compra`)) AS `total_cuotas`,(select count(0) from `dias_compras` `dc` where ((`dc`.`id_compra` = `c`.`id_compra`) and (`dc`.`estado` = '1'))) AS `cuotas_pendientes`,(select count(0) from `dias_compras` `dc` where ((`dc`.`id_compra` = `c`.`id_compra`) and (`dc`.`estado` = '0'))) AS `cuotas_pagadas`,(select ifnull(sum(`dc`.`monto`),0) from `dias_compras` `dc` where ((`dc`.`id_compra` = `c`.`id_compra`) and (`dc`.`estado` = '1'))) AS `monto_pendiente`,(select ifnull(sum(`dc`.`monto`),0) from `dias_compras` `dc` where ((`dc`.`id_compra` = `c`.`id_compra`) and (`dc`.`estado` = '0'))) AS `monto_pagado` from (`compras` `c` left join `proveedores` `p` on((`c`.`proveedor_id` = `p`.`proveedor_id`))) order by `c`.`id_compra` desc;

-- ----------------------------
-- View structure for view_cotizaciones
-- ----------------------------
DROP VIEW IF EXISTS `view_cotizaciones`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_cotizaciones` AS select `c`.`id` AS `id`,`c`.`numero` AS `numero`,`c`.`fecha` AS `fecha`,`c`.`subtotal` AS `subtotal`,`c`.`igv` AS `igv`,`c`.`total` AS `total`,`c`.`descuento` AS `descuento`,`c`.`aplicar_igv` AS `aplicar_igv`,`c`.`moneda` AS `moneda`,`c`.`estado` AS `estado`,`c`.`asunto` AS `asunto`,`cl`.`documento` AS `cliente_documento`,coalesce(`cl`.`datos`,`c`.`cliente_nombre`) AS `cliente_nombre`,`cl`.`email` AS `cliente_email`,`cl`.`telefono` AS `cliente_telefono`,`u`.`name` AS `vendedor_nombre`,`u`.`email` AS `vendedor_email`,`c`.`id_empresa` AS `id_empresa`,`c`.`id_usuario` AS `id_usuario`,`c`.`created_at` AS `created_at`,`c`.`updated_at` AS `updated_at`,(select count(0) from `cotizacion_detalles` where (`cotizacion_detalles`.`cotizacion_id` = `c`.`id`)) AS `total_items` from ((`cotizaciones` `c` left join `clientes` `cl` on((`c`.`id_cliente` = `cl`.`id_cliente`))) join `users` `u` on((`c`.`id_usuario` = `u`.`id`))) order by `c`.`id` desc;

-- ----------------------------
-- View structure for view_movimientos_stock_detalle
-- ----------------------------
DROP VIEW IF EXISTS `view_movimientos_stock_detalle`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_movimientos_stock_detalle` AS select `m`.`id_movimiento` AS `id_movimiento`,`m`.`id_producto` AS `id_producto`,`p`.`codigo` AS `producto_codigo`,`p`.`nombre` AS `producto_nombre`,`m`.`tipo_movimiento` AS `tipo_movimiento`,`m`.`cantidad` AS `cantidad`,`m`.`stock_anterior` AS `stock_anterior`,`m`.`stock_nuevo` AS `stock_nuevo`,`m`.`tipo_documento` AS `tipo_documento`,`m`.`id_documento` AS `id_documento`,`m`.`documento_referencia` AS `documento_referencia`,`m`.`motivo` AS `motivo`,`m`.`observaciones` AS `observaciones`,`m`.`id_almacen` AS `id_almacen`,`m`.`id_empresa` AS `id_empresa`,`m`.`id_usuario` AS `id_usuario`,`u`.`name` AS `usuario_nombre`,`m`.`fecha_movimiento` AS `fecha_movimiento`,`m`.`created_at` AS `created_at`,`m`.`updated_at` AS `updated_at` from ((`movimientos_stock` `m` left join `productos` `p` on((`m`.`id_producto` = `p`.`id_producto`))) left join `users` `u` on((`m`.`id_usuario` = `u`.`id`))) order by `m`.`fecha_movimiento` desc;

-- ----------------------------
-- View structure for view_pagos_pendientes
-- ----------------------------
DROP VIEW IF EXISTS `view_pagos_pendientes`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_pagos_pendientes` AS select `dc`.`dias_compra_id` AS `dias_compra_id`,`dc`.`id_compra` AS `id_compra`,`c`.`serie` AS `serie`,`c`.`numero` AS `numero`,concat(`c`.`serie`,'-',lpad(`c`.`numero`,8,'0')) AS `documento`,`c`.`id_proveedor` AS `id_proveedor`,`c`.`proveedor_id` AS `proveedor_id`,`p`.`ruc` AS `proveedor_ruc`,`p`.`razon_social` AS `proveedor_nombre`,`dc`.`monto` AS `monto`,`dc`.`fecha` AS `fecha_vencimiento`,`dc`.`estado` AS `estado`,(case when (`dc`.`estado` = '1') then 'Pendiente' when (`dc`.`estado` = '0') then 'Pagado' else 'Desconocido' end) AS `estado_nombre`,`dc`.`fecha_pago` AS `fecha_pago`,`c`.`moneda` AS `moneda`,`c`.`id_empresa` AS `id_empresa`,(case when ((`dc`.`estado` = '1') and (`dc`.`fecha` < curdate())) then (to_days(curdate()) - to_days(`dc`.`fecha`)) else 0 end) AS `dias_atraso`,(case when (`dc`.`estado` = '0') then 'Pagado' when ((`dc`.`estado` = '1') and (`dc`.`fecha` < curdate())) then 'Vencido' when ((`dc`.`estado` = '1') and (`dc`.`fecha` = curdate())) then 'Vence Hoy' when ((`dc`.`estado` = '1') and (`dc`.`fecha` > curdate())) then 'Por Vencer' else 'Desconocido' end) AS `clasificacion` from ((`dias_compras` `dc` join `compras` `c` on((`dc`.`id_compra` = `c`.`id_compra`))) left join `proveedores` `p` on((`c`.`proveedor_id` = `p`.`proveedor_id`))) where ((`dc`.`estado` = '1') and (`c`.`estado` = '1')) order by `dc`.`fecha`;

-- ----------------------------
-- View structure for view_productos_1
-- ----------------------------
DROP VIEW IF EXISTS `view_productos_1`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_productos_1` AS select `p`.`id_producto` AS `id_producto`,`p`.`codigo` AS `codigo`,`p`.`cod_barra` AS `cod_barra`,`p`.`nombre` AS `nombre`,`p`.`descripcion` AS `descripcion`,`p`.`precio` AS `precio`,`p`.`costo` AS `costo`,`p`.`precio_mayor` AS `precio_mayor`,`p`.`precio_menor` AS `precio_menor`,`p`.`precio_unidad` AS `precio_unidad`,`p`.`cantidad` AS `cantidad`,`p`.`stock_minimo` AS `stock_minimo`,`p`.`stock_maximo` AS `stock_maximo`,`p`.`id_empresa` AS `id_empresa`,`p`.`almacen` AS `almacen`,`p`.`codsunat` AS `codsunat`,`p`.`usar_barra` AS `usar_barra`,`p`.`usar_multiprecio` AS `usar_multiprecio`,`p`.`moneda` AS `moneda`,`p`.`estado` AS `estado`,`p`.`imagen` AS `imagen`,`p`.`ultima_salida` AS `ultima_salida`,`p`.`fecha_registro` AS `fecha_registro`,`p`.`fecha_ultimo_ingreso` AS `fecha_ultimo_ingreso`,`c`.`nombre` AS `categoria`,`u`.`nombre` AS `unidad`,`u`.`codigo` AS `unidad_codigo` from ((`productos` `p` left join `categorias` `c` on((`c`.`id` = `p`.`categoria_id`))) left join `unidades` `u` on((`u`.`id` = `p`.`unidad_id`))) where ((`p`.`almacen` = '1') and (`p`.`estado` = '1')) order by `p`.`id_producto` desc;

-- ----------------------------
-- View structure for view_productos_2
-- ----------------------------
DROP VIEW IF EXISTS `view_productos_2`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_productos_2` AS select `p`.`id_producto` AS `id_producto`,`p`.`codigo` AS `codigo`,`p`.`cod_barra` AS `cod_barra`,`p`.`nombre` AS `nombre`,`p`.`descripcion` AS `descripcion`,`p`.`precio` AS `precio`,`p`.`costo` AS `costo`,`p`.`precio_mayor` AS `precio_mayor`,`p`.`precio_menor` AS `precio_menor`,`p`.`precio_unidad` AS `precio_unidad`,`p`.`cantidad` AS `cantidad`,`p`.`stock_minimo` AS `stock_minimo`,`p`.`stock_maximo` AS `stock_maximo`,`p`.`id_empresa` AS `id_empresa`,`p`.`almacen` AS `almacen`,`p`.`codsunat` AS `codsunat`,`p`.`usar_barra` AS `usar_barra`,`p`.`usar_multiprecio` AS `usar_multiprecio`,`p`.`moneda` AS `moneda`,`p`.`estado` AS `estado`,`p`.`imagen` AS `imagen`,`p`.`ultima_salida` AS `ultima_salida`,`p`.`fecha_registro` AS `fecha_registro`,`p`.`fecha_ultimo_ingreso` AS `fecha_ultimo_ingreso`,`c`.`nombre` AS `categoria`,`u`.`nombre` AS `unidad`,`u`.`codigo` AS `unidad_codigo` from ((`productos` `p` left join `categorias` `c` on((`c`.`id` = `p`.`categoria_id`))) left join `unidades` `u` on((`u`.`id` = `p`.`unidad_id`))) where ((`p`.`almacen` = '2') and (`p`.`estado` = '1')) order by `p`.`id_producto` desc;

-- ----------------------------
-- View structure for view_proveedores_activos
-- ----------------------------
DROP VIEW IF EXISTS `view_proveedores_activos`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_proveedores_activos` AS select `p`.`proveedor_id` AS `proveedor_id`,`p`.`ruc` AS `ruc`,`p`.`razon_social` AS `razon_social`,`p`.`direccion` AS `direccion`,`p`.`telefono` AS `telefono`,`p`.`email` AS `email`,`p`.`id_empresa` AS `id_empresa`,`p`.`departamento` AS `departamento`,`p`.`provincia` AS `provincia`,`p`.`distrito` AS `distrito`,`p`.`ubigeo` AS `ubigeo`,`p`.`estado` AS `estado`,`p`.`fecha_create` AS `fecha_create`,`p`.`created_at` AS `created_at`,`p`.`updated_at` AS `updated_at`,concat_ws(', ',nullif(`p`.`distrito`,''),nullif(`p`.`provincia`,''),nullif(`p`.`departamento`,'')) AS `ubicacion_completa`,(select count(0) from `compras` `c` where ((`c`.`proveedor_id` = `p`.`proveedor_id`) and (`c`.`estado` = '1'))) AS `total_compras`,(select ifnull(sum(`c`.`total`),0) from `compras` `c` where ((`c`.`proveedor_id` = `p`.`proveedor_id`) and (`c`.`estado` = '1'))) AS `total_comprado` from `proveedores` `p` where (`p`.`estado` = 1) order by `p`.`razon_social`;

-- ----------------------------
-- View structure for view_usuarios_completo
-- ----------------------------
DROP VIEW IF EXISTS `view_usuarios_completo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_usuarios_completo` AS select `u`.`id` AS `id`,`u`.`name` AS `name`,`u`.`email` AS `email`,`u`.`num_doc` AS `num_doc`,`u`.`nombres` AS `nombres`,`u`.`apellidos` AS `apellidos`,`u`.`telefono` AS `telefono`,`u`.`estado` AS `estado`,`u`.`foto_perfil` AS `foto_perfil`,`r`.`rol_id` AS `rol_id`,`r`.`nombre` AS `rol_nombre`,`r`.`ver_precios` AS `ver_precios`,`r`.`puede_eliminar` AS `puede_eliminar`,`e`.`id_empresa` AS `id_empresa`,`e`.`ruc` AS `ruc`,`e`.`razon_social` AS `razon_social`,`e`.`comercial` AS `comercial`,`u`.`created_at` AS `created_at`,`u`.`updated_at` AS `updated_at` from ((`users` `u` left join `roles` `r` on((`u`.`rol_id` = `r`.`rol_id`))) left join `empresas` `e` on((`u`.`id_empresa` = `e`.`id_empresa`)));

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
