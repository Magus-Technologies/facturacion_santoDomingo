# Skill: Corrección de Lógica de Apertura de Caja

## Problema Identificado

La lógica actual de "apertura de caja" es incorrecta. Se está implementando como:
- **Actual (Incorrecto)**: Activar/Abrir una caja (cambiar estado de Inactiva a Abierta)
- **Correcto**: Agregar dinero a un vendedor diariamente (movimiento diario de fondo)

### Síntomas del Problema

1. **En el modal de apertura**: Solo lista cajas con estado "Inactiva"
2. **Lógica de negocio**: Trata apertura como activación permanente
3. **Flujo diario**: No permite que el mismo vendedor abra caja múltiples días

## Concepto Correcto

### ¿Qué es realmente la "Apertura de Caja"?

Es un **movimiento diario** donde:
- El vendedor recibe un fondo inicial (dinero en efectivo)
- Este fondo es responsabilidad del vendedor durante el día
- Al final del día, el vendedor devuelve el dinero (cierre)
- Al día siguiente, puede recibir un nuevo fondo (nueva apertura)

### Analogía

```
Vendedor = Empleado
Caja = Fondo de caja diario (como un "float" en caja registradora)

Día 1:
├─ Mañana: Recibe S/. 1000 (apertura)
├─ Durante: Vende y maneja el dinero
└─ Tarde: Devuelve S/. 1000 + ganancias (cierre)

Día 2:
├─ Mañana: Recibe S/. 1000 nuevamente (nueva apertura)
├─ Durante: Vende y maneja el dinero
└─ Tarde: Devuelve S/. 1000 + ganancias (cierre)
```

## Cambios Necesarios

### 1. Modelo Caja

**Cambio conceptual**:
- NO es un registro que se "activa" y "desactiva"
- ES un registro que representa la relación vendedor-empresa
- Tiene múltiples "sesiones" (aperturas/cierres diarios)

**Estructura actual (INCORRECTA)**:
```php
cajas
├─ id_caja (PK)
├─ id_empresa
├─ nombre
├─ id_responsable (vendedor)
├─ estado (Inactiva, Abierta, Cerrada) ← PROBLEMA
├─ saldo_inicial
├─ fecha_apertura
└─ ...
```

**Estructura correcta (PROPUESTA)**:
```php
cajas (Configuración - NO cambia)
├─ id_caja (PK)
├─ id_empresa
├─ nombre
├─ id_responsable (vendedor)
├─ estado (Activa) ← Siempre activa
├─ activo (boolean) ← Para habilitar/deshabilitar
└─ ...

sesiones_caja (Movimientos diarios - NUEVO)
├─ id_sesion (PK)
├─ id_caja (FK)
├─ id_empresa
├─ fecha_apertura
├─ fecha_cierre
├─ saldo_inicial (fondo del día)
├─ saldo_final
├─ estado (Abierta, Cerrada, Validada)
├─ id_usuario_apertura
├─ id_usuario_cierre
├─ id_usuario_validacion
└─ ...
```

### 2. Cambios en el Controlador

**Antes (INCORRECTO)**:
```php
// Activar caja (cambiar estado)
public function activar(Request $request, int $id)
{
    $caja->estado = 'Abierta';
    $caja->save();
}
```

**Después (CORRECTO)**:
```php
// Crear sesión de caja (movimiento diario)
public function abrirSesion(CajaAperturaRequest $request, int $id)
{
    $caja = $this->cajaService->obtener($id);
    
    // Crear nueva sesión (no modificar caja)
    $sesion = $this->sesionService->crearSesion($caja, $request->validated());
    
    return $this->success($sesion);
}
```

### 3. Cambios en el Frontend

**Antes (INCORRECTO)**:
```jsx
// Modal lista cajas inactivas
const cajasInactivas = cajas.filter(c => c.estado === 'Inactiva');
```

**Después (CORRECTO)**:
```jsx
// Modal lista cajas activas (sin sesión abierta hoy)
const cajasDisponibles = cajas.filter(c => 
    c.activo && !c.sesion_abierta_hoy
);
```

### 4. Cambios en la Lógica de Negocio

**Flujo Actual (INCORRECTO)**:
```
Caja Inactiva → Apertura → Caja Abierta → Cierre → Caja Cerrada
(Permanente)   (Cambio)   (Permanente)  (Cambio) (Permanente)
```

**Flujo Correcto (PROPUESTO)**:
```
Caja Activa (Configuración)
    ↓
Día 1: Crear Sesión → Sesión Abierta → Cierre → Sesión Cerrada
Día 2: Crear Sesión → Sesión Abierta → Cierre → Sesión Cerrada
Día 3: Crear Sesión → Sesión Abierta → Cierre → Sesión Cerrada
```

## Impacto en Otras Áreas

### Ventas
- Debe verificar si hay sesión abierta (no solo caja abierta)
- Registra movimiento en sesión (no en caja)

### Reportes
- Debe agrupar por sesión (no por caja)
- Histórico de sesiones (no de cajas)

### Permisos
- `puede_abrir_caja` → `puede_crear_sesion_caja`
- Mismo concepto, mejor nombre

## Beneficios de este Cambio

1. ✅ Permite múltiples aperturas del mismo vendedor
2. ✅ Separación clara: Configuración (caja) vs Operación (sesión)
3. ✅ Histórico completo de sesiones
4. ✅ Mejor auditoría
5. ✅ Más flexible para cambios futuros

## Implementación

### Fase 1: Crear tabla sesiones_caja
- Nueva migración
- Copiar datos de cajas a sesiones_caja
- Mantener compatibilidad

### Fase 2: Actualizar modelos
- Crear modelo SesionCaja
- Actualizar relaciones en Caja
- Actualizar relaciones en MovimientoCaja

### Fase 3: Actualizar controladores
- CajaController: Cambiar lógica
- SesionCajaController: Crear nuevo

### Fase 4: Actualizar frontend
- CajaAperturaModal: Cambiar filtro
- Actualizar hooks
- Actualizar llamadas API

### Fase 5: Migración de datos
- Convertir cajas existentes a sesiones
- Actualizar referencias

## Próximos Pasos

1. Crear skill de migración de datos
2. Crear skill de actualización de modelos
3. Crear skill de actualización de controladores
4. Crear skill de actualización de frontend
5. Crear skill de tests

---

**Nota**: Esta skill es un análisis y propuesta. La implementación se hará en skills separadas.
