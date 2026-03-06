# Plan de Implementación - Módulo de Caja

## FASE 1: PREPARACIÓN (Backend)

### 1.1 Crear Migraciones de Base de Datos
- [ ] Migración: Tabla `cajas`
- [ ] Migración: Tabla `apertura_caja_billetes`
- [ ] Migración: Tabla `cierre_caja_billetes`
- [ ] Migración: Tabla `movimientos_caja`
- [ ] Migración: Tabla `denominaciones_billetes`
- [ ] Migración: Tabla `arqueos_diarios`
- [ ] Migración: Tabla `auditoria_caja`
- [ ] Seed: Insertar denominaciones de billetes (PEN y USD)

**Archivos a crear:**
- `database/migrations/YYYY_MM_DD_create_cajas_table.php`
- `database/migrations/YYYY_MM_DD_create_apertura_caja_billetes_table.php`
- `database/migrations/YYYY_MM_DD_create_cierre_caja_billetes_table.php`
- `database/migrations/YYYY_MM_DD_create_movimientos_caja_table.php`
- `database/migrations/YYYY_MM_DD_create_denominaciones_billetes_table.php`
- `database/migrations/YYYY_MM_DD_create_arqueos_diarios_table.php`
- `database/migrations/YYYY_MM_DD_create_auditoria_caja_table.php`
- `database/seeders/DenominacionesBilletesSeeder.php`

### 1.2 Crear Modelos Eloquent
- [ ] Modelo: `Caja`
- [ ] Modelo: `AperturaCajaBillete`
- [ ] Modelo: `CierreCajaBillete`
- [ ] Modelo: `MovimientoCaja`
- [ ] Modelo: `DenominacionBillete`
- [ ] Modelo: `ArqueoDiario`
- [ ] Modelo: `AuditoriaCaja`

**Archivos a crear:**
- `app/Models/Caja.php`
- `app/Models/AperturaCajaBillete.php`
- `app/Models/CierreCajaBillete.php`
- `app/Models/MovimientoCaja.php`
- `app/Models/DenominacionBillete.php`
- `app/Models/ArqueoDiario.php`
- `app/Models/AuditoriaCaja.php`

**Relaciones a definir:**
- `Caja` → `hasMany(AperturaCajaBillete)`
- `Caja` → `hasMany(CierreCajaBillete)`
- `Caja` → `hasMany(MovimientoCaja)`
- `Caja` → `belongsTo(User)` (usuario que abrió)
- `Caja` → `belongsTo(User, 'id_usuario_validacion')` (usuario que validó)
- `Caja` → `belongsTo(Empresa)`
- `MovimientoCaja` → `belongsTo(Caja)`
- `MovimientoCaja` → `belongsTo(User)`

### 1.3 Crear Requests (Validaciones)
- [ ] `CajaAperturaRequest` - Validar apertura de caja
- [ ] `CajaCierreRequest` - Validar cierre de caja
- [ ] `MovimientoCajaRequest` - Validar movimiento manual
- [ ] `CajaValidacionRequest` - Validar autorización de cierre

**Archivos a crear:**
- `app/Http/Requests/CajaAperturaRequest.php`
- `app/Http/Requests/CajaCierreRequest.php`
- `app/Http/Requests/MovimientoCajaRequest.php`
- `app/Http/Requests/CajaValidacionRequest.php`

### 1.4 Crear Servicios de Lógica de Negocio
- [ ] `CajaService` - Lógica principal de cajas
  - `abrirCaja()`
  - `cerrarCaja()`
  - `validarCierre()`
  - `rechazarCierre()`
  - `calcularResumen()`
  - `registrarMovimiento()`
  - `registrarArqueo()`

- [ ] `DenominacionesService` - Manejo de denominaciones
  - `obtenerDenominaciones()`
  - `calcularTotalBilletes()`

- [ ] `AuditoriaService` - Registro de auditoría
  - `registrarAccion()`

**Archivos a crear:**
- `app/Services/CajaService.php`
- `app/Services/DenominacionesService.php`
- `app/Services/AuditoriaService.php`

---

## FASE 2: CONTROLLERS Y RUTAS

### 2.1 Crear Controllers
- [ ] `CajaController` - CRUD de cajas
  - `index()` - Listar cajas
  - `store()` - Crear/Abrir caja
  - `show()` - Ver detalle de caja
  - `update()` - Actualizar caja
  - `destroy()` - Eliminar caja (soft delete)
  - `cerrar()` - Cerrar caja
  - `validar()` - Validar cierre
  - `rechazar()` - Rechazar cierre
  - `resumen()` - Obtener resumen de cierre
  - `ventasPorMetodo()` - Obtener ventas agrupadas por método

- [ ] `MovimientoCajaController` - Movimientos
  - `index()` - Listar movimientos de una caja
  - `store()` - Crear movimiento manual
  - `destroy()` - Eliminar movimiento

- [ ] `DenominacionBilletesController` - Denominaciones
  - `index()` - Listar denominaciones
  - `show()` - Ver denominación

- [ ] `ArqueoDiarioController` - Histórico
  - `index()` - Listar arqueos
  - `show()` - Ver detalle de arqueo

**Archivos a crear:**
- `app/Http/Controllers/Api/CajaController.php`
- `app/Http/Controllers/Api/MovimientoCajaController.php`
- `app/Http/Controllers/Api/DenominacionBilletesController.php`
- `app/Http/Controllers/Api/ArqueoDiarioController.php`

### 2.2 Definir Rutas API
```php
// routes/api.php

Route::middleware('auth:sanctum')->group(function () {
    // Cajas
    Route::apiResource('cajas', CajaController::class);
    Route::post('cajas/{id}/cerrar', [CajaController::class, 'cerrar']);
    Route::post('cajas/{id}/validar', [CajaController::class, 'validar']);
    Route::post('cajas/{id}/rechazar', [CajaController::class, 'rechazar']);
    Route::get('cajas/{id}/resumen', [CajaController::class, 'resumen']);
    Route::get('cajas/{id}/ventas-por-metodo', [CajaController::class, 'ventasPorMetodo']);
    
    // Movimientos de Caja
    Route::apiResource('movimientos-caja', MovimientoCajaController::class);
    
    // Denominaciones
    Route::apiResource('denominaciones-billetes', DenominacionBilletesController::class, ['only' => ['index', 'show']]);
    
    // Arqueos
    Route::apiResource('arqueos-diarios', ArqueoDiarioController::class, ['only' => ['index', 'show']]);
});
```

### 2.3 Crear Permisos
- [ ] `puede_abrir_caja`
- [ ] `puede_cerrar_caja`
- [ ] `puede_autorizar_cierre`
- [ ] `puede_rechazar_cierre`
- [ ] `puede_registrar_movimientos`
- [ ] `puede_ver_reportes_caja`

**Comando:**
```bash
php artisan permissions:add-caja
```

---

## FASE 3: FRONTEND - COMPONENTES BÁSICOS

### 3.1 Crear Componentes Reutilizables
- [ ] `DenominacionesTable.jsx` - Tabla de denominaciones
- [ ] `ResumenVentasPorMetodo.jsx` - Resumen de ventas por método
- [ ] `ModalDetalleVentas.jsx` - Modal con detalle de ventas
- [ ] `CajaEstadoBadge.jsx` - Badge de estado de caja

**Archivos a crear:**
- `resources/js/components/Finanzas/Caja/components/DenominacionesTable.jsx`
- `resources/js/components/Finanzas/Caja/components/ResumenVentasPorMetodo.jsx`
- `resources/js/components/Finanzas/Caja/components/ModalDetalleVentas.jsx`
- `resources/js/components/Finanzas/Caja/components/CajaEstadoBadge.jsx`

### 3.2 Crear Hooks Personalizados
- [ ] `useCajas.js` - Hook para gestionar cajas
- [ ] `useDenominaciones.js` - Hook para denominaciones
- [ ] `useMovimientosCaja.js` - Hook para movimientos

**Archivos a crear:**
- `resources/js/components/Finanzas/Caja/hooks/useCajas.js`
- `resources/js/components/Finanzas/Caja/hooks/useDenominaciones.js`
- `resources/js/components/Finanzas/Caja/hooks/useMovimientosCaja.js`

### 3.3 Crear Columnas para Tablas
- [ ] `cajasColumns.jsx` - Columnas para lista de cajas
- [ ] `movimientosCajaColumns.jsx` - Columnas para movimientos
- [ ] `arqueosColumns.jsx` - Columnas para histórico de arqueos

**Archivos a crear:**
- `resources/js/components/Finanzas/Caja/columns/cajasColumns.jsx`
- `resources/js/components/Finanzas/Caja/columns/movimientosCajaColumns.jsx`
- `resources/js/components/Finanzas/Caja/columns/arqueosColumns.jsx`

---

## FASE 4: FRONTEND - PANTALLAS PRINCIPALES

### 4.1 Crear Pantalla: Lista de Cajas
- [ ] `CajasList.jsx` - Componente principal
  - Listar cajas
  - Filtros (estado, fecha, usuario)
  - Botón para crear nueva caja
  - Botón para ver detalle

**Archivo a crear:**
- `resources/js/components/Finanzas/Caja/CajasList.jsx`

### 4.2 Crear Modal: Apertura de Caja
- [ ] `CajaAperturaModal.jsx`
  - Opción: Monto Fijo
  - Opción: Por Billetes
  - Validaciones
  - Envío a API

**Archivo a crear:**
- `resources/js/components/Finanzas/Caja/modals/CajaAperturaModal.jsx`

### 4.3 Crear Pantalla: Caja Abierta
- [ ] `CajaAbiertaDetail.jsx`
  - Mostrar estado actual
  - Mostrar movimientos del día
  - Botones: Ingreso Manual, Egreso, Cerrar Caja

**Archivo a crear:**
- `resources/js/components/Finanzas/Caja/CajaAbiertaDetail.jsx`

### 4.4 Crear Modal: Resumen de Cierre
- [ ] `CajaResumenCierreModal.jsx`
  - Mostrar apertura
  - Mostrar resumen de ventas por método (con lupa)
  - Mostrar ingresos/egresos
  - Mostrar total teórico
  - Botón: Proceder a Cierre

**Archivo a crear:**
- `resources/js/components/Finanzas/Caja/modals/CajaResumenCierreModal.jsx`

### 4.5 Crear Modal: Cierre de Caja
- [ ] `CajaCierreModal.jsx`
  - Opción: Monto Fijo
  - Opción: Por Billetes
  - Mostrar cálculo de diferencia
  - Mostrar tipo de diferencia (exacto/sobrante/faltante)
  - Validaciones
  - Envío a API

**Archivo a crear:**
- `resources/js/components/Finanzas/Caja/modals/CajaCierreModal.jsx`

### 4.6 Crear Modal: Validación de Cierre
- [ ] `CajaValidacionModal.jsx`
  - Mostrar resumen completo
  - Mostrar diferencia
  - Opción: Autorizar o Rechazar
  - Requerir contraseña
  - Envío a API

**Archivo a crear:**
- `resources/js/components/Finanzas/Caja/modals/CajaValidacionModal.jsx`

### 4.7 Crear Pantalla: Histórico de Arqueos
- [ ] `ArqueosHistoricoList.jsx`
  - Listar arqueos
  - Filtros (fecha, usuario, estado)
  - Botón para ver detalle

**Archivo a crear:**
- `resources/js/components/Finanzas/Caja/ArqueosHistoricoList.jsx`

---

## FASE 5: INTEGRACIÓN CON VENTAS

### 5.1 Modificar Componente de Ventas
- [ ] Verificar que caja esté abierta antes de crear venta
- [ ] Registrar automáticamente movimiento de ingreso en caja
- [ ] Agrupar venta por método de pago

**Archivos a modificar:**
- `resources/js/components/Ventas/VentasForm.jsx` (o similar)

### 5.2 Actualizar MetodoPago.jsx
- [ ] Ya está actualizado para cargar desde API ✓

---

## FASE 6: TESTING

### 6.1 Tests Unitarios
- [ ] Test: `CajaService::abrirCaja()`
- [ ] Test: `CajaService::cerrarCaja()`
- [ ] Test: `CajaService::validarCierre()`
- [ ] Test: `CajaService::calcularResumen()`

### 6.2 Tests de Integración
- [ ] Test: Flujo completo de apertura → ventas → cierre → validación
- [ ] Test: Validaciones de permisos
- [ ] Test: Cálculo de diferencias

### 6.3 Tests de API
- [ ] Test: POST `/api/cajas` (apertura)
- [ ] Test: POST `/api/cajas/{id}/cerrar` (cierre)
- [ ] Test: POST `/api/cajas/{id}/validar` (validación)
- [ ] Test: GET `/api/cajas/{id}/resumen` (resumen)

---

## FASE 7: DOCUMENTACIÓN Y DEPLOYMENT

### 7.1 Documentación
- [ ] Documentar endpoints API
- [ ] Documentar flujos de negocio
- [ ] Documentar permisos requeridos
- [ ] Crear guía de usuario

### 7.2 Deployment
- [ ] Ejecutar migraciones en producción
- [ ] Ejecutar seeders
- [ ] Verificar permisos
- [ ] Realizar pruebas en producción

---

## TIMELINE ESTIMADO

| Fase | Duración | Inicio | Fin |
|------|----------|--------|-----|
| Fase 1: Backend | 2-3 días | - | - |
| Fase 2: Controllers | 1-2 días | - | - |
| Fase 3: Componentes | 2-3 días | - | - |
| Fase 4: Pantallas | 3-4 días | - | - |
| Fase 5: Integración | 1-2 días | - | - |
| Fase 6: Testing | 2-3 días | - | - |
| Fase 7: Documentación | 1 día | - | - |
| **TOTAL** | **12-18 días** | - | - |

---

## CHECKLIST DE VALIDACIÓN

### Antes de Pasar a Producción
- [ ] Todas las migraciones ejecutadas
- [ ] Todos los modelos creados
- [ ] Todos los controllers creados
- [ ] Todas las rutas definidas
- [ ] Todos los permisos creados
- [ ] Todos los componentes frontend creados
- [ ] Todas las pantallas creadas
- [ ] Integración con Ventas completada
- [ ] Tests pasando
- [ ] Documentación completa
- [ ] Revisión de código
- [ ] Pruebas manuales completadas

---

## NOTAS IMPORTANTES

1. **Permisos**: Asegurar que los permisos se creen correctamente y se asignen a los roles apropiados.

2. **Auditoría**: Registrar todas las acciones en la tabla `auditoria_caja` para trazabilidad.

3. **Transacciones**: Usar transacciones de base de datos para operaciones críticas (apertura, cierre, validación).

4. **Validaciones**: Implementar validaciones robustas en backend y frontend.

5. **Errores**: Manejar errores de forma clara y proporcionar mensajes útiles al usuario.

6. **Performance**: Optimizar queries con índices y eager loading de relaciones.

7. **Seguridad**: Requerir contraseña para validar cierre de caja.

8. **Histórico**: Mantener histórico completo de arqueos para auditoría.

