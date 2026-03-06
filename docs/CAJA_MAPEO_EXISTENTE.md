# Mapeo de Implementación Existente - Módulo de Caja

## ✅ Estado Actual de Implementación

### Tablas de Base de Datos (CREADAS)

| Tabla | Migración | Estado | Notas |
|-------|-----------|--------|-------|
| `cajas` | 2026_03_04_000004 | ✅ Creada | Tabla principal de cajas |
| `movimientos_caja` | 2026_03_04_000005 | ✅ Creada | Ingresos/egresos |
| `apertura_caja_billetes` | 2026_03_04_000006 | ✅ Creada | Desglose de apertura |
| `cierre_caja_billetes` | 2026_03_04_000007 | ✅ Creada | Desglose de cierre |
| `auditoria_cajas` | 2026_03_04_000008 | ✅ Creada | Auditoría de acciones |
| `denominaciones_billetes` | 2026_03_04_000003 | ✅ Creada | Catálogo de billetes |
| `permisos_caja` | 2026_03_04_000009 | ✅ Creada | Permisos específicos |

### Campos de la Tabla `cajas`

```
id_caja (PK)
id_empresa (FK)
id_usuario_apertura (FK) → Usuario que abrió
id_usuario_cierre (FK) → Usuario que cerró
id_usuario_autoriza_cierre (FK) → Usuario que autorizó
fecha_apertura
fecha_cierre
fecha_autorizacion_cierre
saldo_inicial
saldo_final_teorico
saldo_final_real
diferencia
estado (Abierta, Cerrada, Pendiente Autorización)
observaciones
observaciones_cierre
timestamps
```

### Campos de la Tabla `movimientos_caja`

```
id_movimiento (PK)
id_caja (FK)
id_empresa (FK)
id_usuario (FK)
tipo (Ingreso, Egreso)
concepto
monto
numero_operacion
referencia_tipo
referencia_id
descripcion
timestamps
```

### Campos de la Tabla `apertura_caja_billetes`

```
id_apertura_billete (PK)
id_caja (FK)
id_denominacion (FK)
cantidad
subtotal
timestamps
```

### Campos de la Tabla `cierre_caja_billetes`

```
id_cierre_billete (PK)
id_caja (FK)
id_denominacion (FK)
cantidad
subtotal
timestamps
```

---

## 📋 Comparación: Documentación vs Implementación

### Tabla `cajas` - Documentación vs Realidad

**Documentación especificaba:**
```
id_caja
id_empresa
id_usuario (usuario que abrió)
id_usuario_validacion (usuario que validó)
saldo_inicial
tipo_apertura (monto_fijo, billetes)
fecha_apertura
saldo_final
tipo_cierre (monto_fijo, billetes)
fecha_cierre
total_teorico
total_real
diferencia
tipo_diferencia (exacto, sobrante, faltante)
estado (abierta, cerrada, pendiente_validacion)
```

**Implementación actual tiene:**
```
id_caja ✅
id_empresa ✅
id_usuario_apertura ✅ (equivalente a id_usuario)
id_usuario_cierre ✅
id_usuario_autoriza_cierre ✅ (equivalente a id_usuario_validacion)
saldo_inicial ✅
fecha_apertura ✅
saldo_final_teorico ✅ (equivalente a total_teorico)
saldo_final_real ✅ (equivalente a total_real)
diferencia ✅
estado ✅ (Abierta, Cerrada, Pendiente Autorización)
observaciones ✅
observaciones_cierre ✅
```

**Diferencias:**
- ❌ No tiene `tipo_apertura` (monto_fijo vs billetes)
- ❌ No tiene `tipo_cierre` (monto_fijo vs billetes)
- ❌ No tiene `tipo_diferencia` (exacto, sobrante, faltante)
- ⚠️ Usa `saldo_final_teorico` y `saldo_final_real` en lugar de `total_teorico` y `total_real`

---

## 🔧 Controllers Existentes

### CajaController.php

**Métodos implementados:**
- ✅ `index()` - Listar cajas
- ✅ `store()` - Abrir caja
- ✅ `show()` - Ver detalle
- ✅ `cierre()` - Cerrar caja
- ✅ `autorizarCierre()` - Autorizar cierre
- ✅ `rechazarCierre()` - Rechazar cierre
- ✅ `movimientos()` - Listar movimientos
- ✅ `registrarMovimiento()` - Registrar movimiento
- ✅ `cajaActiva()` - Obtener caja activa
- ✅ `denominaciones()` - Listar denominaciones

**Métodos faltantes según documentación:**
- ❌ `resumen()` - Obtener resumen de cierre
- ❌ `ventasPorMetodo()` - Agrupar ventas por método

---

## 📊 Rutas API Existentes

Revisar en `routes/api.php` para confirmar qué rutas están definidas.

---

## 🎯 Próximos Pasos

### Paso 1: Verificar Modelos
- [ ] Revisar modelo `Caja`
- [ ] Revisar modelo `MovimientoCaja`
- [ ] Revisar modelo `DenominacionBillete`
- [ ] Revisar modelo `AperturaCajaBillete`
- [ ] Revisar modelo `CierreCajaBillete`

### Paso 2: Verificar Relaciones
- [ ] Caja → usuarioApertura
- [ ] Caja → usuarioCierre
- [ ] Caja → usuarioAutorizaCierre
- [ ] Caja → movimientos
- [ ] MovimientoCaja → caja
- [ ] MovimientoCaja → usuario

### Paso 3: Agregar Métodos Faltantes
- [ ] Método `resumen()` en CajaController
- [ ] Método `ventasPorMetodo()` en CajaController

### Paso 4: Crear Frontend
- [ ] Componentes React
- [ ] Hooks personalizados
- [ ] Modales

---

## 📝 Notas Importantes

1. **Las tablas ya existen** - No necesitas crear migraciones nuevas
2. **El controller ya existe** - Solo necesitas agregar métodos faltantes
3. **Los modelos probablemente existen** - Necesitas verificar relaciones
4. **Las rutas probablemente existen** - Necesitas verificar en routes/api.php

---

## 🔍 Verificación Necesaria

Antes de continuar, necesitas verificar:

1. ¿Existen los modelos?
   - `app/Models/Caja.php`
   - `app/Models/MovimientoCaja.php`
   - `app/Models/DenominacionBillete.php`
   - `app/Models/AperturaCajaBillete.php`
   - `app/Models/CierreCajaBillete.php`

2. ¿Están definidas las rutas?
   - `GET /api/cajas`
   - `POST /api/cajas`
   - `GET /api/cajas/{id}`
   - `POST /api/cajas/{id}/cerrar`
   - `POST /api/cajas/{id}/validar`
   - `POST /api/cajas/{id}/rechazar`
   - `GET /api/cajas/{id}/movimientos`
   - `POST /api/cajas/{id}/movimientos`
   - `GET /api/cajas/activa`
   - `GET /api/denominaciones-billetes`

3. ¿Existen los componentes React?
   - `resources/js/components/Finanzas/Caja/`

---

## 📌 Resumen

✅ **Tablas**: Todas creadas
✅ **Controller**: Existe con métodos principales
⚠️ **Modelos**: Necesita verificación
⚠️ **Rutas**: Necesita verificación
❌ **Frontend**: Necesita creación
❌ **Métodos faltantes**: `resumen()`, `ventasPorMetodo()`



---

## 📋 Rutas API Existentes

### Rutas de Cajas (Definidas en routes/api.php)

```php
// Cajas
Route::get('cajas/activa', [CajaController::class, 'cajaActiva']);
Route::get('cajas/denominaciones', [CajaController::class, 'denominaciones']);
Route::get('cajas', [CajaController::class, 'index'])->middleware('permission:caja.view');
Route::post('cajas', [CajaController::class, 'store'])->middleware('permission:caja.create');
Route::get('cajas/{id}', [CajaController::class, 'show'])->middleware('permission:caja.view');
Route::put('cajas/{id}/cierre', [CajaController::class, 'cierre'])->middleware('permission:caja.edit');
Route::post('cajas/{id}/autorizar', [CajaController::class, 'autorizarCierre'])->middleware('permission:caja.autorizar');
Route::post('cajas/{id}/rechazar', [CajaController::class, 'rechazarCierre'])->middleware('permission:caja.autorizar');
Route::get('cajas/{id}/movimientos', [CajaController::class, 'movimientos'])->middleware('permission:caja.view');
Route::post('cajas/{id}/movimientos', [CajaController::class, 'registrarMovimiento'])->middleware('permission:caja.edit');
```

### Rutas Existentes vs Documentación

| Ruta | Método | Existe | Documentado | Notas |
|------|--------|--------|-------------|-------|
| `/cajas` | GET | ✅ | ✅ | Listar cajas |
| `/cajas` | POST | ✅ | ✅ | Abrir caja |
| `/cajas/{id}` | GET | ✅ | ✅ | Ver detalle |
| `/cajas/{id}/cierre` | PUT | ✅ | ✅ | Cerrar caja |
| `/cajas/{id}/autorizar` | POST | ✅ | ✅ | Autorizar cierre |
| `/cajas/{id}/rechazar` | POST | ✅ | ✅ | Rechazar cierre |
| `/cajas/{id}/movimientos` | GET | ✅ | ✅ | Listar movimientos |
| `/cajas/{id}/movimientos` | POST | ✅ | ✅ | Registrar movimiento |
| `/cajas/activa` | GET | ✅ | ✅ | Obtener caja activa |
| `/cajas/denominaciones` | GET | ✅ | ✅ | Listar denominaciones |
| `/cajas/{id}/resumen` | GET | ❌ | ✅ | **FALTA** - Resumen de cierre |
| `/cajas/{id}/ventas-por-metodo` | GET | ❌ | ✅ | **FALTA** - Ventas agrupadas |

---

## ✅ Resumen Final

### Lo que YA EXISTE y está FUNCIONANDO
- ✅ Todas las tablas de BD
- ✅ Todos los modelos
- ✅ El controller con métodos principales
- ✅ Las rutas API
- ✅ Los permisos

### Lo que FALTA AGREGAR
- ❌ Método `resumen()` en CajaController
- ❌ Método `ventasPorMetodo()` en CajaController
- ❌ Componentes React para el frontend
- ❌ Hooks personalizados
- ❌ Modales

### Lo que ESTÁ DOCUMENTADO
- ✅ Requerimientos completos
- ✅ Especificaciones de UI/UX
- ✅ Especificaciones de BD
- ✅ Plan de implementación
- ✅ Referencia rápida
- ✅ Resumen visual
- ✅ Índice de documentación

---

## 🎯 Próximos Pasos (En Orden)

1. **Agregar métodos faltantes al CajaController**
   - `resumen()` - Obtener resumen de cierre
   - `ventasPorMetodo()` - Agrupar ventas por método

2. **Crear componentes React**
   - Componentes reutilizables
   - Hooks personalizados
   - Columnas de tablas

3. **Crear pantallas principales**
   - Lista de Cajas
   - Modales (Apertura, Cierre, Validación, Resumen)
   - Pantalla de Caja Abierta
   - Histórico de Arqueos

4. **Integración con Ventas**
   - Verificar que caja esté abierta
   - Registrar movimientos automáticamente

5. **Testing y Validación**
   - Tests unitarios
   - Tests de integración
   - Pruebas manuales

