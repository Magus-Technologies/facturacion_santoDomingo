# Resumen Visual - Módulo de Caja

## 1. ARQUITECTURA GENERAL

```
┌─────────────────────────────────────────────────────────────────┐
│                        MÓDULO DE CAJA                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                    FRONTEND (React)                      │  │
│  ├──────────────────────────────────────────────────────────┤  │
│  │                                                          │  │
│  │  CajasList.jsx                                          │  │
│  │  ├─ CajaAperturaModal.jsx                              │  │
│  │  ├─ CajaAbiertaDetail.jsx                              │  │
│  │  ├─ CajaResumenCierreModal.jsx                         │  │
│  │  │  └─ ModalDetalleVentas.jsx (Lupa)                  │  │
│  │  ├─ CajaCierreModal.jsx                               │  │
│  │  ├─ CajaValidacionModal.jsx                           │  │
│  │  └─ ArqueosHistoricoList.jsx                          │  │
│  │                                                          │  │
│  │  Hooks:                                                 │  │
│  │  ├─ useCajas.js                                        │  │
│  │  ├─ useDenominaciones.js                              │  │
│  │  └─ useMovimientosCaja.js                             │  │
│  │                                                          │  │
│  └──────────────────────────────────────────────────────────┘  │
│                            ↕                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                    API (Laravel)                         │  │
│  ├──────────────────────────────────────────────────────────┤  │
│  │                                                          │  │
│  │  CajaController                                         │  │
│  │  ├─ index()                                            │  │
│  │  ├─ store() [Apertura]                                │  │
│  │  ├─ cerrar()                                          │  │
│  │  ├─ validar()                                         │  │
│  │  ├─ rechazar()                                        │  │
│  │  ├─ resumen()                                         │  │
│  │  └─ ventasPorMetodo()                                │  │
│  │                                                          │  │
│  │  MovimientoCajaController                              │  │
│  │  ├─ index()                                            │  │
│  │  ├─ store()                                            │  │
│  │  └─ destroy()                                          │  │
│  │                                                          │  │
│  │  Services:                                              │  │
│  │  ├─ CajaService                                        │  │
│  │  ├─ DenominacionesService                             │  │
│  │  └─ AuditoriaService                                  │  │
│  │                                                          │  │
│  └──────────────────────────────────────────────────────────┘  │
│                            ↕                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                  BASE DE DATOS (MySQL)                  │  │
│  ├──────────────────────────────────────────────────────────┤  │
│  │                                                          │  │
│  │  cajas                                                  │  │
│  │  ├─ apertura_caja_billetes                            │  │
│  │  ├─ cierre_caja_billetes                              │  │
│  │  ├─ movimientos_caja                                  │  │
│  │  ├─ denominaciones_billetes                           │  │
│  │  ├─ arqueos_diarios                                   │  │
│  │  └─ auditoria_caja                                    │  │
│  │                                                          │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 2. FLUJO DE DATOS - APERTURA

```
┌─────────────────────────────────────────────────────────────┐
│  USUARIO ABRE CAJA                                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Frontend: CajaAperturaModal.jsx                           │
│  ├─ Selecciona: Monto Fijo O Por Billetes                │
│  ├─ Ingresa datos                                         │
│  └─ [Aperturar Caja]                                      │
│       ↓                                                    │
│  POST /api/cajas                                          │
│  {                                                         │
│    "id_empresa": 1,                                       │
│    "saldo_inicial": 1000.00,                             │
│    "tipo_apertura": "monto_fijo"                         │
│  }                                                         │
│       ↓                                                    │
│  Backend: CajaController::store()                         │
│  ├─ Valida con CajaAperturaRequest                       │
│  ├─ Llama CajaService::abrirCaja()                       │
│  ├─ Crea registro en tabla cajas                         │
│  ├─ Si es por billetes:                                  │
│  │  └─ Crea registros en apertura_caja_billetes         │
│  ├─ Registra auditoría                                   │
│  └─ Retorna caja creada                                  │
│       ↓                                                    │
│  Frontend: Actualiza estado                              │
│  ├─ Cierra modal                                         │
│  ├─ Actualiza lista de cajas                            │
│  └─ Muestra mensaje de éxito                            │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 3. FLUJO DE DATOS - VENTA

```
┌─────────────────────────────────────────────────────────────┐
│  USUARIO CREA VENTA                                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Frontend: VentasForm.jsx                                  │
│  ├─ Verifica que caja esté abierta                        │
│  ├─ Selecciona método de pago                            │
│  ├─ Ingresa datos de venta                               │
│  └─ [Guardar Venta]                                       │
│       ↓                                                    │
│  POST /api/ventas                                         │
│  {                                                         │
│    "id_metodo_pago": 1,                                  │
│    "total": 150.00,                                      │
│    ...                                                    │
│  }                                                         │
│       ↓                                                    │
│  Backend: VentasController::store()                       │
│  ├─ Crea venta                                           │
│  ├─ Llama CajaService::registrarMovimiento()            │
│  │  ├─ Obtiene caja abierta del usuario                 │
│  │  ├─ Crea movimiento de ingreso                       │
│  │  │  {                                                 │
│  │  │    "id_caja": 1,                                  │
│  │  │    "tipo": "ingreso",                             │
│  │  │    "concepto": "Venta V-001",                     │
│  │  │    "monto": 150.00,                               │
│  │  │    "tipo_referencia": "venta",                    │
│  │  │    "id_referencia": 1                             │
│  │  │  }                                                 │
│  │  └─ Registra auditoría                               │
│  └─ Retorna venta creada                                │
│       ↓                                                    │
│  Frontend: Actualiza estado                              │
│  ├─ Cierra modal                                         │
│  ├─ Actualiza lista de ventas                           │
│  └─ Muestra mensaje de éxito                            │
│                                                             │
│  Base de Datos:                                           │
│  ├─ ventas (nueva fila)                                  │
│  ├─ movimientos_caja (nueva fila)                        │
│  └─ auditoria_caja (nueva fila)                          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 4. FLUJO DE DATOS - RESUMEN Y CIERRE

```
┌─────────────────────────────────────────────────────────────┐
│  USUARIO VE RESUMEN Y CIERRA CAJA                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Frontend: CajaAbiertaDetail.jsx                           │
│  ├─ [Cerrar Caja]                                         │
│  └─ Abre CajaResumenCierreModal.jsx                       │
│       ↓                                                    │
│  GET /api/cajas/{id}/resumen                             │
│       ↓                                                    │
│  Backend: CajaController::resumen()                       │
│  ├─ Obtiene caja                                         │
│  ├─ Calcula totales:                                     │
│  │  ├─ Total ingresos                                   │
│  │  ├─ Total egresos                                    │
│  │  └─ Total teórico                                    │
│  ├─ Agrupa ventas por método:                           │
│  │  ├─ Yape: 500.00                                     │
│  │  ├─ Efectivo: 800.00                                 │
│  │  └─ Transferencia: 300.00                            │
│  └─ Retorna resumen                                      │
│       ↓                                                    │
│  Frontend: Muestra CajaResumenCierreModal                │
│  ├─ Apertura: 1000.00                                    │
│  ├─ Resumen de Ventas:                                   │
│  │  ├─ Yape: 500.00 [🔍]                                │
│  │  ├─ Efectivo: 800.00 [🔍]                            │
│  │  └─ Transferencia: 300.00 [🔍]                       │
│  ├─ Ingresos Manuales: 100.00                           │
│  ├─ Egresos: 50.00                                       │
│  ├─ Total Teórico: 2650.00                              │
│  └─ [Proceder a Cierre]                                  │
│       ↓                                                    │
│  Si usuario hace clic en [🔍]:                           │
│  ├─ Abre ModalDetalleVentas                             │
│  ├─ Muestra tabla con ventas del método                 │
│  └─ Permite verificar antes de cerrar                   │
│       ↓                                                    │
│  Usuario hace clic [Proceder a Cierre]:                 │
│  ├─ Abre CajaCierreModal.jsx                            │
│  ├─ Selecciona: Monto Fijo O Por Billetes              │
│  ├─ Ingresa total contado                               │
│  ├─ Sistema calcula diferencia                          │
│  └─ [Cerrar Caja]                                        │
│       ↓                                                    │
│  POST /api/cajas/{id}/cerrar                            │
│  {                                                         │
│    "saldo_final": 2650.00,                              │
│    "tipo_cierre": "monto_fijo",                         │
│    "observaciones_cierre": "Cierre normal"              │
│  }                                                         │
│       ↓                                                    │
│  Backend: CajaController::cerrar()                       │
│  ├─ Valida con CajaCierreRequest                        │
│  ├─ Llama CajaService::cerrarCaja()                     │
│  ├─ Calcula diferencia                                  │
│  ├─ Actualiza caja:                                     │
│  │  ├─ saldo_final = 2650.00                            │
│  │  ├─ total_real = 2650.00                             │
│  │  ├─ diferencia = 0.00                                │
│  │  ├─ tipo_diferencia = "exacto"                       │
│  │  └─ estado = "pendiente_validacion"                  │
│  ├─ Si es por billetes:                                 │
│  │  └─ Crea registros en cierre_caja_billetes          │
│  ├─ Registra auditoría                                  │
│  └─ Retorna caja actualizada                            │
│       ↓                                                    │
│  Frontend: Actualiza estado                              │
│  ├─ Cierra modal                                         │
│  ├─ Muestra mensaje: "Pendiente de validación"         │
│  └─ Actualiza lista de cajas                            │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 5. FLUJO DE DATOS - VALIDACIÓN

```
┌─────────────────────────────────────────────────────────────┐
│  ADMINISTRADOR VALIDA CIERRE                                │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Frontend: CajasList.jsx                                   │
│  ├─ Filtra cajas con estado "pendiente_validacion"       │
│  ├─ Hace clic en [Ver]                                    │
│  └─ Abre CajaValidacionModal.jsx                         │
│       ↓                                                    │
│  GET /api/cajas/{id}                                      │
│       ↓                                                    │
│  Backend: CajaController::show()                          │
│  ├─ Obtiene caja con relaciones                          │
│  ├─ Carga usuario que abrió                              │
│  ├─ Carga movimientos                                    │
│  └─ Retorna caja completa                                │
│       ↓                                                    │
│  Frontend: Muestra CajaValidacionModal                   │
│  ├─ Resumen completo (no editable)                       │
│  ├─ Diferencia: 0.00 (EXACTO)                            │
│  ├─ Detalle de ventas por método [🔍]                    │
│  ├─ Opción: Autorizar O Rechazar                         │
│  ├─ Campo: Observaciones                                 │
│  ├─ Campo: Contraseña                                    │
│  └─ [Procesar]                                            │
│       ↓                                                    │
│  Si AUTORIZAR:                                            │
│  ├─ POST /api/cajas/{id}/validar                         │
│  │  {                                                     │
│  │    "accion": "autorizar",                             │
│  │    "observaciones": "Validado",                       │
│  │    "contraseña": "admin123"                           │
│  │  }                                                     │
│  │       ↓                                                │
│  │  Backend: CajaController::validar()                   │
│  │  ├─ Valida contraseña                                │
│  │  ├─ Llama CajaService::validarCierre()              │
│  │  ├─ Actualiza caja:                                  │
│  │  │  ├─ estado = "cerrada"                            │
│  │  │  ├─ id_usuario_validacion = admin_id              │
│  │  │  └─ fecha_validacion = NOW()                      │
│  │  ├─ Llama sp_registrar_arqueo_diario()              │
│  │  │  └─ Crea registro en arqueos_diarios             │
│  │  ├─ Registra auditoría                               │
│  │  └─ Retorna caja actualizada                         │
│  │       ↓                                                │
│  │  Frontend: Muestra éxito                              │
│  │  ├─ Cierra modal                                      │
│  │  ├─ Actualiza lista                                   │
│  │  └─ Muestra: "Caja validada y cerrada"              │
│  │                                                        │
│  └─ Si RECHAZAR:                                          │
│     ├─ POST /api/cajas/{id}/rechazar                     │
│     │  {                                                  │
│     │    "accion": "rechazar",                           │
│     │    "observaciones": "Revisar movimientos",         │
│     │    "contraseña": "admin123"                        │
│     │  }                                                  │
│     │       ↓                                             │
│     │  Backend: CajaController::rechazar()               │
│     │  ├─ Valida contraseña                             │
│     │  ├─ Actualiza caja:                               │
│     │  │  ├─ estado = "abierta"                         │
│     │  │  ├─ saldo_final = NULL                         │
│     │  │  └─ fecha_cierre = NULL                        │
│     │  ├─ Registra auditoría                            │
│     │  └─ Retorna caja actualizada                      │
│     │       ↓                                             │
│     │  Frontend: Muestra rechazo                         │
│     │  ├─ Cierra modal                                   │
│     │  ├─ Actualiza lista                                │
│     │  └─ Muestra: "Cierre rechazado, caja reabierta"  │
│     │                                                    │
│     └─ Vendedor puede revisar y cerrar nuevamente       │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 6. ESTRUCTURA DE CARPETAS

```
resources/js/components/Finanzas/Caja/
├── CajasList.jsx                          # Pantalla principal
├── CajaAbiertaDetail.jsx                  # Detalle de caja abierta
├── ArqueosHistoricoList.jsx               # Histórico de arqueos
│
├── modals/
│   ├── CajaAperturaModal.jsx              # Apertura
│   ├── CajaCierreModal.jsx                # Cierre
│   ├── CajaResumenCierreModal.jsx         # Resumen antes de cerrar
│   └── CajaValidacionModal.jsx            # Validación (admin)
│
├── components/
│   ├── DenominacionesTable.jsx            # Tabla de billetes
│   ├── ResumenVentasPorMetodo.jsx         # Resumen de ventas
│   ├── ModalDetalleVentas.jsx             # Detalle con lupa
│   └── CajaEstadoBadge.jsx                # Badge de estado
│
├── columns/
│   ├── cajasColumns.jsx                   # Columnas de lista
│   ├── movimientosCajaColumns.jsx         # Columnas de movimientos
│   └── arqueosColumns.jsx                 # Columnas de arqueos
│
└── hooks/
    ├── useCajas.js                        # Hook principal
    ├── useDenominaciones.js               # Hook de denominaciones
    └── useMovimientosCaja.js              # Hook de movimientos
```

---

## 7. TABLA DE RELACIONES

```
┌─────────────────────────────────────────────────────────────┐
│                    RELACIONES DE DATOS                      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  cajas                                                      │
│  ├─ 1 → N apertura_caja_billetes                          │
│  ├─ 1 → N cierre_caja_billetes                            │
│  ├─ 1 → N movimientos_caja                                │
│  ├─ N → 1 users (id_usuario)                              │
│  ├─ N → 1 users (id_usuario_validacion)                   │
│  ├─ N → 1 empresas                                        │
│  └─ 1 → 1 arqueos_diarios                                 │
│                                                             │
│  movimientos_caja                                           │
│  ├─ N → 1 cajas                                            │
│  ├─ N → 1 users                                            │
│  └─ N → 1 ventas (si tipo_referencia = 'venta')          │
│                                                             │
│  ventas                                                     │
│  ├─ N → 1 metodos_pago                                    │
│  ├─ N → 1 cajas (a través de movimientos_caja)           │
│  └─ 1 → 1 movimientos_caja                                │
│                                                             │
│  denominaciones_billetes                                    │
│  ├─ 1 → N apertura_caja_billetes                          │
│  └─ 1 → N cierre_caja_billetes                            │
│                                                             │
│  arqueos_diarios                                            │
│  ├─ N → 1 cajas                                            │
│  ├─ N → 1 empresas                                        │
│  ├─ N → 1 users (usuario_cierre)                          │
│  └─ N → 1 users (usuario_validacion)                      │
│                                                             │
│  auditoria_caja                                             │
│  ├─ N → 1 cajas                                            │
│  └─ N → 1 users                                            │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 8. MATRIZ DE PERMISOS

```
┌──────────────────────────────────────────────────────────────┐
│                    MATRIZ DE PERMISOS                        │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Permiso                    │ Vendedor │ Administrador       │
│  ────────────────────────────┼──────────┼──────────────────  │
│  puede_abrir_caja           │    ✓     │        ✓           │
│  puede_cerrar_caja          │    ✓     │        ✓           │
│  puede_autorizar_cierre     │    ✗     │        ✓           │
│  puede_rechazar_cierre      │    ✗     │        ✓           │
│  puede_registrar_movimientos│    ✓     │        ✓           │
│  puede_ver_reportes_caja    │    ✓     │        ✓           │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## 9. CICLO DE VIDA DE UNA CAJA

```
┌─────────────────────────────────────────────────────────────┐
│                  CICLO DE VIDA DE UNA CAJA                  │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Día 1 - Mañana                                             │
│  ├─ 09:00 - Vendedor abre caja                            │
│  │  └─ Estado: ABIERTA                                    │
│  │                                                         │
│  Día 1 - Durante el día                                    │
│  ├─ 09:30 - Venta 1 (Yape)                               │
│  ├─ 10:15 - Venta 2 (Efectivo)                           │
│  ├─ 11:00 - Egreso (Cambio)                              │
│  ├─ 14:45 - Venta 3 (Transferencia)                      │
│  └─ 16:00 - Ingreso Manual (Depósito)                    │
│                                                             │
│  Día 1 - Tarde                                              │
│  ├─ 17:00 - Vendedor ve resumen                          │
│  │  ├─ Apertura: 1000.00                                 │
│  │  ├─ Ventas: 1600.00                                   │
│  │  ├─ Ingresos: 100.00                                  │
│  │  ├─ Egresos: 50.00                                    │
│  │  └─ Total Teórico: 2650.00                            │
│  │                                                         │
│  ├─ 17:30 - Vendedor cierra caja                         │
│  │  ├─ Ingresa total contado: 2650.00                    │
│  │  ├─ Diferencia: 0.00 (EXACTO)                         │
│  │  └─ Estado: PENDIENTE DE VALIDACIÓN                   │
│  │                                                         │
│  Día 1 - Noche                                              │
│  ├─ 17:35 - Administrador valida                         │
│  │  ├─ Revisa resumen                                    │
│  │  ├─ Autoriza con contraseña                           │
│  │  ├─ Estado: CERRADA                                   │
│  │  └─ Arqueo registrado en histórico                    │
│  │                                                         │
│  Día 2 - Mañana                                             │
│  ├─ 09:00 - Vendedor abre nueva caja                     │
│  │  └─ Ciclo se repite...                                │
│  │                                                         │
│  Histórico                                                  │
│  └─ Arqueo del Día 1 guardado permanentemente             │
│     ├─ Fecha: 2026-03-04                                 │
│     ├─ Usuario: Juan Pérez                               │
│     ├─ Saldo Inicial: 1000.00                            │
│     ├─ Total Ventas: 1600.00                             │
│     ├─ Diferencia: 0.00 (EXACTO)                         │
│     └─ Validado por: Admin                               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 10. CHECKLIST DE IMPLEMENTACIÓN

```
BACKEND
  ☐ Migraciones creadas
  ☐ Modelos creados
  ☐ Requests creados
  ☐ Services creados
  ☐ Controllers creados
  ☐ Rutas definidas
  ☐ Permisos creados
  ☐ Tests pasando

FRONTEND
  ☐ Componentes reutilizables
  ☐ Hooks personalizados
  ☐ Columnas de tablas
  ☐ Pantalla: Lista de Cajas
  ☐ Modal: Apertura
  ☐ Pantalla: Caja Abierta
  ☐ Modal: Resumen
  ☐ Modal: Cierre
  ☐ Modal: Validación
  ☐ Pantalla: Histórico

INTEGRACIÓN
  ☐ Ventas registran movimientos
  ☐ MetodoPago carga desde API
  ☐ Permisos asignados a roles

TESTING
  ☐ Tests unitarios
  ☐ Tests de integración
  ☐ Tests de API
  ☐ Pruebas manuales

DOCUMENTACIÓN
  ☐ API documentada
  ☐ Flujos documentados
  ☐ Guía de usuario
  ☐ Guía de administrador
```

