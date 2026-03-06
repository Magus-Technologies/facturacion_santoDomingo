# Especificaciones UI/UX - Módulo de Caja

## 1. PANTALLA PRINCIPAL - LISTA DE CAJAS

### 1.1 Estructura
```
┌─────────────────────────────────────────────────────────────┐
│  [Icono] Cajas                                  [+ Nueva]   │
│  Gestiona la apertura y cierre de cajas diarias             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Filtros: [Estado ▼] [Fecha ▼] [Usuario ▼]  [Buscar...]   │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐
│  │ # │ Usuario    │ Estado      │ Apertura │ Cierre │ Acc. │
│  ├─────────────────────────────────────────────────────────┤
│  │ 1 │ Juan Pérez │ CERRADA     │ 1000.00  │ 2650   │ [👁] │
│  │ 2 │ María G.   │ ABIERTA     │ 500.00   │ —      │ [👁] │
│  │ 3 │ Carlos L.  │ PENDIENTE   │ 800.00   │ 2100   │ [👁] │
│  └─────────────────────────────────────────────────────────┘
│
│  Paginación: [< 1 2 3 >]
└─────────────────────────────────────────────────────────────┘
```

### 1.2 Columnas
- **#**: Número de fila
- **Usuario**: Quien abrió la caja
- **Estado**: ABIERTA, CERRADA, PENDIENTE DE VALIDACIÓN
- **Apertura**: Saldo inicial
- **Cierre**: Saldo final (si está cerrada)
- **Acciones**: Botón de ojo para ver detalle

### 1.3 Estados y Colores
- **ABIERTA**: Verde claro (puede seguir operando)
- **CERRADA**: Gris (finalizada y validada)
- **PENDIENTE DE VALIDACIÓN**: Amarillo (esperando aprobación)

---

## 2. MODAL - APERTURA DE CAJA

### 2.1 Estructura
```
┌──────────────────────────────────────────────────────────┐
│  APERTURA DE CAJA                                    [X] │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  Empresa: [Empresa Seleccionada]                        │
│  Fecha: [04/03/2026]                                    │
│  Hora: [09:00]                                          │
│                                                          │
│  ┌─ SALDO INICIAL ─────────────────────────────────────┐
│  │                                                      │
│  │  ○ Monto Fijo                                       │
│  │    Ingrese el saldo inicial: [_____________]        │
│  │                                                      │
│  │  ○ Por Billetes                                     │
│  │    ┌──────────────────────────────────────────────┐ │
│  │    │ Denominación    │ Cantidad │ Subtotal       │ │
│  │    ├──────────────────────────────────────────────┤ │
│  │    │ Billete S/. 200 │ [_]      │ 0.00           │ │
│  │    │ Billete S/. 100 │ [_]      │ 0.00           │ │
│  │    │ Billete S/. 50  │ [_]      │ 0.00           │ │
│  │    │ Billete S/. 20  │ [_]      │ 0.00           │ │
│  │    │ Billete S/. 10  │ [_]      │ 0.00           │ │
│  │    │ Billete S/. 5   │ [_]      │ 0.00           │ │
│  │    │ Billete S/. 2   │ [_]      │ 0.00           │ │
│  │    │ Billete S/. 1   │ [_]      │ 0.00           │ │
│  │    │ Moneda S/. 0.50 │ [_]      │ 0.00           │ │
│  │    │ Moneda S/. 0.20 │ [_]      │ 0.00           │ │
│  │    │ Moneda S/. 0.10 │ [_]      │ 0.00           │ │
│  │    │ Moneda S/. 0.05 │ [_]      │ 0.00           │ │
│  │    ├──────────────────────────────────────────────┤ │
│  │    │ TOTAL                              1000.00   │ │
│  │    └──────────────────────────────────────────────┘ │
│  │                                                      │
│  └──────────────────────────────────────────────────────┘
│
│  Observaciones: [_________________________________]
│
│  [Cancelar]  [Aperturar Caja]
└──────────────────────────────────────────────────────────┘
```

### 2.2 Comportamiento
- Por defecto seleccionar "Monto Fijo"
- Al cambiar a "Por Billetes", mostrar tabla
- Cada cantidad ingresada calcula automáticamente el subtotal
- El total se actualiza en tiempo real
- Validar que saldo inicial >= 0

---

## 3. PANTALLA - CAJA ABIERTA (Durante el Día)

### 3.1 Estructura
```
┌──────────────────────────────────────────────────────────┐
│  [Icono] Caja Abierta - 04/03/2026                       │
│  Vendedor: Juan Pérez                                    │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  ┌─ ESTADO ACTUAL ──────────────────────────────────────┐
│  │                                                      │
│  │  Saldo Inicial:        S/. 1,000.00                 │
│  │  Ventas Registradas:   S/. 1,600.00                 │
│  │  Ingresos Manuales:    S/. 100.00                   │
│  │  Egresos:              S/. 50.00                    │
│  │  ─────────────────────────────────                  │
│  │  TOTAL TEÓRICO:        S/. 2,650.00                 │
│  │                                                      │
│  └──────────────────────────────────────────────────────┘
│
│  [+ Ingreso Manual]  [+ Egreso]  [Cerrar Caja]
│
│  ┌─ MOVIMIENTOS DEL DÍA ────────────────────────────────┐
│  │ Hora     │ Tipo      │ Concepto      │ Monto        │
│  ├──────────────────────────────────────────────────────┤
│  │ 09:30    │ Ingreso   │ Venta V-001   │ 150.00       │
│  │ 10:15    │ Ingreso   │ Venta V-002   │ 200.00       │
│  │ 11:00    │ Egreso    │ Cambio        │ 50.00        │
│  │ 14:45    │ Ingreso   │ Venta V-003   │ 150.00       │
│  └──────────────────────────────────────────────────────┘
│
└──────────────────────────────────────────────────────────┘
```

### 3.2 Botones
- **[+ Ingreso Manual]**: Abre modal para registrar ingreso
- **[+ Egreso]**: Abre modal para registrar egreso
- **[Cerrar Caja]**: Abre modal de cierre

---

## 4. MODAL - RESUMEN DE CIERRE (Antes de Cerrar)

### 4.1 Estructura
```
┌──────────────────────────────────────────────────────────┐
│  RESUMEN DE CIERRE DE CAJA                           [X] │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  ┌─ APERTURA ───────────────────────────────────────────┐
│  │  Saldo Inicial: S/. 1,000.00                         │
│  │  Registrado por: Monto Fijo                          │
│  └──────────────────────────────────────────────────────┘
│
│  ┌─ RESUMEN DE VENTAS POR MÉTODO ──────────────────────┐
│  │                                                      │
│  │  Yape                    S/. 500.00  [🔍]           │
│  │  Efectivo                S/. 800.00  [🔍]           │
│  │  Transferencia BCP       S/. 300.00  [🔍]           │
│  │  ─────────────────────────────────────              │
│  │  TOTAL VENTAS            S/. 1,600.00               │
│  │                                                      │
│  └──────────────────────────────────────────────────────┘
│
│  ┌─ OTROS MOVIMIENTOS ──────────────────────────────────┐
│  │  Ingresos Manuales:      S/. 100.00                 │
│  │  Egresos:                S/. 50.00                  │
│  └──────────────────────────────────────────────────────┘
│
│  ┌─ TOTALES ────────────────────────────────────────────┐
│  │  Saldo Inicial:          S/. 1,000.00               │
│  │  + Ingresos:             S/. 1,700.00               │
│  │  - Egresos:              S/. 50.00                  │
│  │  ═════════════════════════════════════              │
│  │  TOTAL TEÓRICO:          S/. 2,650.00               │
│  └──────────────────────────────────────────────────────┘
│
│  [Cancelar]  [Proceder a Cierre]
└──────────────────────────────────────────────────────────┘
```

### 4.2 Funcionalidad de Lupa [🔍]
Al hacer clic en la lupa de un método, se abre un modal con:

```
┌──────────────────────────────────────────────────────────┐
│  VENTAS CON MÉTODO: YAPE (04/03/2026)              [X]   │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  ┌──────────────────────────────────────────────────────┐
│  │ # │ Número │ Cliente      │ Monto    │ Hora │ Ref.  │
│  ├──────────────────────────────────────────────────────┤
│  │ 1 │ V-001  │ Juan Pérez   │ 150.00   │ 09:30│ 12345 │
│  │ 2 │ V-002  │ María García │ 200.00   │ 10:15│ 67890 │
│  │ 3 │ V-003  │ Carlos López │ 150.00   │ 14:45│ 11111 │
│  ├──────────────────────────────────────────────────────┤
│  │ TOTAL YAPE                              S/. 500.00   │
│  └──────────────────────────────────────────────────────┘
│
│  [Cerrar]
└──────────────────────────────────────────────────────────┘
```

---

## 5. MODAL - CIERRE DE CAJA

### 5.1 Estructura
```
┌──────────────────────────────────────────────────────────┐
│  CIERRE DE CAJA                                      [X] │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  ┌─ SALDO FINAL ────────────────────────────────────────┐
│  │                                                      │
│  │  ○ Monto Fijo                                       │
│  │    Total Contado: [_____________]                   │
│  │                                                      │
│  │  ○ Por Billetes                                     │
│  │    ┌──────────────────────────────────────────────┐ │
│  │    │ Denominación    │ Cantidad │ Subtotal       │ │
│  │    ├──────────────────────────────────────────────┤ │
│  │    │ Billete S/. 200 │ [_]      │ 0.00           │ │
│  │    │ Billete S/. 100 │ [_]      │ 0.00           │ │
│  │    │ ... (resto de denominaciones)                │ │
│  │    ├──────────────────────────────────────────────┤ │
│  │    │ TOTAL                              2650.00   │ │
│  │    └──────────────────────────────────────────────┘ │
│  │                                                      │
│  └──────────────────────────────────────────────────────┘
│
│  ┌─ CÁLCULO DE DIFERENCIA ──────────────────────────────┐
│  │  Total Teórico:          S/. 2,650.00               │
│  │  Total Real (Contado):   S/. 2,650.00               │
│  │  ─────────────────────────────────────              │
│  │  DIFERENCIA:             S/. 0.00 (EXACTO)          │
│  │                                                      │
│  │  [Tipo: EXACTO / SOBRANTE / FALTANTE]               │
│  └──────────────────────────────────────────────────────┘
│
│  Observaciones: [_________________________________]
│
│  [Cancelar]  [Cerrar Caja]
└──────────────────────────────────────────────────────────┘
```

### 5.2 Comportamiento
- Por defecto seleccionar "Monto Fijo"
- Mostrar total teórico (no editable)
- Calcular diferencia en tiempo real
- Mostrar tipo de diferencia con color:
  - EXACTO: Verde
  - SOBRANTE: Azul
  - FALTANTE: Rojo

---

## 6. MODAL - VALIDACIÓN DE CIERRE (Administrador)

### 6.1 Estructura
```
┌──────────────────────────────────────────────────────────┐
│  VALIDACIÓN DE CIERRE DE CAJA                        [X] │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  Vendedor: Juan Pérez                                    │
│  Fecha: 04/03/2026                                       │
│  Hora Cierre: 17:30                                      │
│                                                          │
│  ┌─ RESUMEN ────────────────────────────────────────────┐
│  │  Saldo Inicial:          S/. 1,000.00               │
│  │  Total Ventas:           S/. 1,600.00               │
│  │  Ingresos Manuales:      S/. 100.00                 │
│  │  Egresos:                S/. 50.00                  │
│  │  ─────────────────────────────────────              │
│  │  TOTAL TEÓRICO:          S/. 2,650.00               │
│  │  TOTAL REAL:             S/. 2,650.00               │
│  │  ═════════════════════════════════════              │
│  │  DIFERENCIA:             S/. 0.00 (EXACTO)          │
│  └──────────────────────────────────────────────────────┘
│
│  ┌─ DETALLE DE VENTAS ──────────────────────────────────┐
│  │  Yape                    S/. 500.00  [🔍]           │
│  │  Efectivo                S/. 800.00  [🔍]           │
│  │  Transferencia BCP       S/. 300.00  [🔍]           │
│  └──────────────────────────────────────────────────────┘
│
│  Observaciones del Vendedor:
│  [_________________________________________________]
│
│  ┌─ DECISIÓN ───────────────────────────────────────────┐
│  │  ○ Autorizar Cierre                                 │
│  │  ○ Rechazar Cierre                                  │
│  │                                                      │
│  │  Observaciones: [_____________________________]      │
│  │                                                      │
│  │  Contraseña: [_____________________________]         │
│  └──────────────────────────────────────────────────────┘
│
│  [Cancelar]  [Procesar]
└──────────────────────────────────────────────────────────┘
```

### 6.2 Comportamiento
- Mostrar resumen completo (no editable)
- Permitir ver detalle de ventas con lupa
- Requerir contraseña para confirmar
- Si autoriza: Estado → CERRADA, se registra Arqueo
- Si rechaza: Estado → ABIERTA, vuelve a vendedor

---

## 7. PANTALLA - HISTÓRICO DE ARQUEOS

### 7.1 Estructura
```
┌──────────────────────────────────────────────────────────┐
│  [Icono] Histórico de Arqueos                            │
│  Registro de cajas cerradas y validadas                  │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  Filtros: [Fecha ▼] [Usuario ▼] [Estado ▼]  [Buscar...]│
│                                                          │
│  ┌──────────────────────────────────────────────────────┐
│  │ Fecha │ Usuario │ Apertura │ Cierre │ Diferencia │ Acc.
│  ├──────────────────────────────────────────────────────┤
│  │ 04/03 │ Juan P. │ 1000.00  │ 2650   │ 0.00 ✓     │ [👁]
│  │ 03/03 │ María G.│ 500.00   │ 1200   │ -50.00 ⚠   │ [👁]
│  │ 02/03 │ Carlos L│ 800.00   │ 2100   │ 100.00 ⚠   │ [👁]
│  └──────────────────────────────────────────────────────┘
│
│  Paginación: [< 1 2 3 >]
└──────────────────────────────────────────────────────────┘
```

### 7.2 Iconos de Diferencia
- ✓ Verde: EXACTO (diferencia = 0)
- ⚠ Naranja: SOBRANTE o FALTANTE (diferencia ≠ 0)

---

## 8. COMPONENTES REUTILIZABLES

### 8.1 Tabla de Denominaciones
```jsx
<DenominacionesTable
  denominaciones={[
    { nombre: "Billete S/. 200", valor: 200, cantidad: 0 },
    { nombre: "Billete S/. 100", valor: 100, cantidad: 0 },
    // ...
  ]}
  onChange={(denominaciones) => {}}
  total={0}
/>
```

### 8.2 Resumen de Ventas por Método
```jsx
<ResumenVentasPorMetodo
  metodos={[
    { nombre: "Yape", monto: 500, ventas: [...] },
    { nombre: "Efectivo", monto: 800, ventas: [...] },
    // ...
  ]}
  onVerDetalle={(metodo) => {}}
/>
```

### 8.3 Modal de Detalle de Ventas
```jsx
<ModalDetalleVentas
  metodo="Yape"
  ventas={[
    { numero: "V-001", cliente: "Juan", monto: 150, hora: "09:30" },
    // ...
  ]}
  total={500}
/>
```

---

## 9. VALIDACIONES Y REGLAS

### 9.1 Apertura
- ✓ Saldo inicial >= 0
- ✓ No puede haber dos cajas abiertas simultáneamente
- ✓ Usuario debe tener permiso `puede_abrir_caja`

### 9.2 Cierre
- ✓ Caja debe estar abierta
- ✓ Total real >= 0
- ✓ Usuario debe tener permiso `puede_cerrar_caja`
- ✓ Debe haber al menos una venta o movimiento

### 9.3 Validación
- ✓ Usuario debe tener permiso `puede_autorizar_cierre`
- ✓ Requerir contraseña
- ✓ Registrar automáticamente Arqueo Diario

---

## 10. FLUJO DE NAVEGACIÓN

```
Lista de Cajas
    ↓
[+ Nueva] → Modal Apertura → Caja Abierta
    ↓
[Ver] → Detalle de Caja Abierta
    ↓
[Cerrar Caja] → Resumen de Cierre → Modal Cierre
    ↓
Estado: PENDIENTE DE VALIDACIÓN
    ↓
Administrador revisa → Modal Validación
    ↓
[Autorizar] → Estado: CERRADA + Arqueo Registrado
[Rechazar] → Estado: ABIERTA (vuelve a vendedor)
    ↓
Histórico de Arqueos
```

