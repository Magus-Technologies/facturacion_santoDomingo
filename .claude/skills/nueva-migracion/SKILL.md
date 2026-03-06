---
name: nueva-migracion
description: Crea migraciones Laravel siguiendo las convenciones del proyecto Santo Domingo. Usar cuando el usuario pida crear tablas, agregar columnas o modificar la base de datos.
argument-hint: <nombre_tabla> [descripción de columnas]
allowed-tools: Read, Glob, Grep, Write, Bash
---

# Skill: Crear Nueva Migración Laravel

Crea la migración para **$ARGUMENTS** siguiendo las convenciones del proyecto.

## CONVENCIONES CRÍTICAS DEL PROYECTO

### Tipos de columnas obligatorios:
- **PK**: `$table->bigIncrements('id_$nombre');` (nunca `$table->id()`)
- **FK a `empresas`**: `$table->integer('id_empresa');` — ⚠️ SIGNED int, NO unsignedInteger
- **FK a `users`**: `$table->unsignedBigInteger('id_usuario');`
- **FK a otras tablas nuevas**: `$table->unsignedBigInteger('id_$otra');`
- **Fechas**: `$table->timestamps();` + campos adicionales con `->dateTime()` o `->date()`
- **Montos**: `$table->decimal('monto', 12, 2);` (12 dígitos totales, 2 decimales)
- **Montos grandes**: `$table->decimal('monto', 14, 2);` para cuentas bancarias
- **Porcentajes**: `$table->decimal('porcentaje', 5, 2);`
- **Booleanos**: `$table->boolean('activo')->default(true);`
- **Textos largos**: `$table->text('descripcion')->nullable();`
- **Enums**: `$table->enum('estado', ['Activo', 'Inactivo'])->default('Activo');`

### Formato de archivo:
- Nombre: `YYYY_MM_DD_NNNNNN_create_$nombre_table.php`
- Fecha actual: usar `date('Y_m_d')` o la fecha actual del sistema
- Usar patrón anonymous class: `return new class extends Migration`

## PASOS A SEGUIR

### 1. VERIFICAR DEPENDENCIAS
Antes de crear la migración, verificar que las tablas referenciadas existen en la DB o en migraciones anteriores. Si hay FKs a tablas nuevas, crear esas primero.

### 2. TEMPLATE BASE
```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('$nombre_tabla', function (Blueprint $table) {
            $table->bigIncrements('id_$nombre');
            $table->integer('id_empresa');           // FK a empresas (SIGNED int)
            // ... columnas de negocio
            $table->boolean('activo')->default(true);
            $table->timestamps();

            // Foreign keys
            $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
            // ... otras FKs

            // Índices
            $table->index('id_empresa');
            // ... otros índices útiles para queries frecuentes
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('$nombre_tabla');
    }
};
```

### 3. PARA TABLAS SIN `id_empresa` (tablas globales como bancos, metodos_pago)
```php
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('$nombre_tabla', function (Blueprint $table) {
            $table->bigIncrements('id_$nombre');
            $table->string('nombre')->unique();
            // ... columnas globales
            $table->boolean('activo')->default(true);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('$nombre_tabla');
    }
};
```

### 4. PARA TABLAS PIVOTE / RELACIÓN
```php
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('$tabla_a_tabla_b', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('id_$tabla_a');
            $table->unsignedBigInteger('id_$tabla_b');
            $table->timestamps();

            $table->foreign('id_$tabla_a')->references('id_$tabla_a')->on('$tabla_a')->cascadeOnDelete();
            $table->foreign('id_$tabla_b')->references('id_$tabla_b')->on('$tabla_b')->cascadeOnDelete();
            $table->unique(['id_$tabla_a', 'id_$tabla_b']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('$tabla_a_tabla_b');
    }
};
```

## REGLAS IMPORTANTES

1. **`id_empresa` SIEMPRE `integer()` (signed)** — La tabla `empresas.id_empresa` es `int NOT NULL` sin UNSIGNED. Usar `unsignedInteger()` causa error MySQL 3780.
2. **FKs a `users.id`**: Usar `unsignedBigInteger('id_usuario')` porque `users.id` es `bigint UNSIGNED`
3. **FKs a tablas nuevas** (creadas en este proyecto): Usar `unsignedBigInteger`
4. **Cascade on delete**: Solo usar `->cascadeOnDelete()` cuando tiene sentido lógico (ej. detalle de un documento)
5. **`nullOnDelete()`**: Para FK opcionales (ej. id_banco en metodos_pago puede ser null)
6. **Índices**: Crear índices para columnas usadas frecuentemente en WHERE o JOIN
7. **Ejecutar**: `php artisan migrate` para aplicar

## SI HAY ERROR AL MIGRAR

Errores comunes y soluciones:
- **Error 3780 (incompatible FK)**: Cambiar `unsignedInteger` → `integer` para FK a `empresas`
- **Table already exists**: La tabla se creó parcialmente. Ejecutar: `php artisan tinker --execute="DB::statement('DROP TABLE IF EXISTS $tabla');"` y re-migrar
- **Cannot add FK constraint**: Verificar que la tabla padre existe y el tipo de columna coincide exactamente
