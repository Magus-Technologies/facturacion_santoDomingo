-- Script para arreglar la tabla cajas en producción
-- Ejecutar en: mysql -u usuario -p base_datos < fix_cajas_enum_produccion.sql

-- Paso 1: Verificar estado actual
SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME='cajas' AND COLUMN_NAME='estado';

-- Paso 2: Actualizar el enum de estado
ALTER TABLE cajas MODIFY COLUMN estado enum('Abierta','Cerrada','Inactiva') NOT NULL DEFAULT 'Inactiva';

-- Paso 3: Verificar que se actualizó correctamente
SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME='cajas' AND COLUMN_NAME='estado';

-- Paso 4: Ver los datos actuales
SELECT id_caja, nombre, estado FROM cajas;

-- Paso 5: Confirmar que todo está bien
DESCRIBE cajas;
