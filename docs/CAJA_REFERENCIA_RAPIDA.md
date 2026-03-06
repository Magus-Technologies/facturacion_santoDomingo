# Referencia Rápida - Módulo de Caja

## 1. ENDPOINTS API

### Cajas
```
GET    /api/cajas                          # Listar cajas
POST   /api/cajas                          # Abrir caja
GET    /api/cajas/{id}                     # Ver detalle
PUT    /api/cajas/{id}                     # Actualizar
DELETE /api/cajas/{id}                     # Eliminar (soft delete)
POST   /api/cajas/{id}/cerrar              # Cerrar caja
POST   /api/cajas/{id}/validar             # Validar cierre
POST   /api/cajas/{id}/rechazar            # Rechazar cierre
GET    /api/cajas/{id}/resumen             # Obtener resumen
GET    /api/cajas/{id}/ventas-por-metodo   # Ventas agrupadas por método
```

### Movimientos de Caja
```
GET    /api/movimientos-caja               # Listar movimientos
POST   /api/movimientos-caja               # Crear movimiento
DELETE /api/movimientos-caja/{id}          # Eliminar movimiento
```

### Denominaciones
```
GET    /api/denominaciones-billetes        # Listar denominaciones
GET    /api/denominaciones-billetes/{id}   # Ver denominación
```

### Arqueos
```
GET    /api/arqueos-diarios                # Listar arqueos
GET    /api/arqueos-diarios/{id}           # Ver detalle de arqueo
```

---

## 2. PAYLOADS DE EJEMPLO

### Abrir Caja (Monto Fijo)
```json
{
  "id_empresa": 1,
  "saldo_inicial": 1000.00,
  "tipo_apertura": "monto_fijo",
  "observaciones": "Apertura normal"
}
```

### Abrir Caja (Por Billetes)
```json
{
  "id_empresa": 1,
  "tipo_apertura": "billetes",
  "billetes": [
    { "id_denominacion": 1, "cantidad": 5 },    // 5 × S/. 200 = 1000
    { "id_denominacion": 2, "cantidad": 0 },    // 0 × S/. 100 = 0
    // ... resto de denominaciones
  ],
  "observaciones": "Apertura con billetes"
}
```

### Registrar Movimiento Manual
```json
{
  "id_caja": 1,
  "tipo": "ingreso",
  "concepto": "Depósito",
  "monto": 100.00,
  "numero_operacion": "OP-123456",
  "descripcion": "Depósito de cliente"
}
```

### Cerrar Caja (Monto Fijo)
```json
{
  "saldo_final": 2650.00,
  "tipo_cierre": "monto_fijo",
  "observaciones_cierre": "Cierre normal"
}
```

### Cerrar Caja (Por Billetes)
```json
{
  "tipo_cierre": "billetes",
  "billetes": [
    { "id_denominacion": 1, "cantidad": 13 },   // 13 × S/. 200 = 2600
    { "id_denominacion": 2, "cantidad": 0 },    // 0 × S/. 100 = 0
    // ... resto de denominaciones
  ],
  "observaciones_cierre": "Cierre con billetes"
}
```

### Validar Cierre
```json
{
  "accion": "autorizar",
  "observaciones": "Cierre validado correctamente",
  "contraseña": "admin123"
}
```

### Rechazar Cierre
```json
{
  "accion": "rechazar",
  "observaciones": "Diferencia no justificada, revisar movimientos",
  "contraseña": "admin123"
}
```

---

## 3. RESPUESTAS DE EJEMPLO

### Listar Cajas
```json
{
  "success": true,
  "data": [
    {
      "id_caja": 1,
      "id_empresa": 1,
      "id_usuario": 5,
      "usuario": { "id": 5, "name": "Juan Pérez" },
      "saldo_inicial": 1000.00,
      "saldo_final": 2650.00,
      "total_teorico": 2650.00,
      "total_real": 2650.00,
      "diferencia": 0.00,
      "tipo_diferencia": "exacto",
      "estado": "cerrada",
      "fecha_apertura": "2026-03-04 09:00:00",
      "fecha_cierre": "2026-03-04 17:30:00",
      "fecha_validacion": "2026-03-04 17:35:00"
    }
  ],
  "pagination": { "total": 10, "per_page": 15, "current_page": 1 }
}
```

### Resumen de Cierre
```json
{
  "success": true,
  "data": {
    "apertura": {
      "saldo_inicial": 1000.00,
      "tipo_apertura": "monto_fijo"
    },
    "ventas_por_metodo": [
      {
        "id_metodo_pago": 1,
        "nombre": "Yape",
        "total": 500.00,
        "cantidad_ventas": 3,
        "ventas": [
          { "numero": "V-001", "cliente": "Juan Pérez", "monto": 150.00, "hora": "09:30" },
          { "numero": "V-002", "cliente": "María García", "monto": 200.00", "hora": "10:15" },
          { "numero": "V-003", "cliente": "Carlos López", "monto": 150.00", "hora": "14:45" }
        ]
      },
      {
        "id_metodo_pago": 2,
        "nombre": "Efectivo",
        "total": 800.00,
        "cantidad_ventas": 4
      },
      {
        "id_metodo_pago": 3,
        "nombre": "Transferencia BCP",
        "total": 300.00,
        "cantidad_ventas": 2
      }
    ],
    "ingresos_manuales": 100.00,
    "egresos": 50.00,
    "total_teorico": 2650.00
  }
}
```

### Arqueo Diario
```json
{
  "success": true,
  "data": {
    "id_arqueo": 1,
    "fecha_arqueo": "2026-03-04",
    "usuario_cierre": { "id": 5, "name": "Juan Pérez" },
    "usuario_validacion": { "id": 1, "name": "Admin" },
    "saldo_inicial": 1000.00,
    "total_ventas": 1600.00,
    "total_ingresos_manuales": 100.00,
    "total_egresos": 50.00,
    "total_teorico": 2650.00,
    "total_real": 2650.00,
    "diferencia": 0.00,
    "tipo_diferencia": "exacto",
    "ventas_por_metodo": {
      "Yape": 500.00,
      "Efectivo": 800.00,
      "Transferencia BCP": 300.00
    },
    "estado": "cerrada",
    "fecha_cierre": "2026-03-04 17:30:00",
    "fecha_validacion": "2026-03-04 17:35:00"
  }
}
```

---

## 4. ESTADOS DE CAJA

| Estado | Descripción | Acciones Permitidas |
|--------|-------------|-------------------|
| `abierta` | Caja operativa | Registrar ventas, movimientos, cerrar |
| `pendiente_validacion` | Esperando aprobación | Ver resumen, rechazar (admin) |
| `cerrada` | Finalizada y validada | Ver histórico, generar reportes |

---

## 5. TIPOS DE DIFERENCIA

| Tipo | Condición | Significado |
|------|-----------|------------|
| `exacto` | Real = Teórico | Diferencia = 0 |
| `sobrante` | Real > Teórico | Hay más dinero del esperado |
| `faltante` | Real < Teórico | Hay menos dinero del esperado |

---

## 6. PERMISOS REQUERIDOS

```php
// En el controlador
$this->authorize('puede_abrir_caja');
$this->authorize('puede_cerrar_caja');
$this->authorize('puede_autorizar_cierre');
$this->authorize('puede_rechazar_cierre');
$this->authorize('puede_registrar_movimientos');
$this->authorize('puede_ver_reportes_caja');
```

---

## 7. VALIDACIONES CLAVE

### Apertura
```php
'saldo_inicial' => 'required|numeric|min:0',
'tipo_apertura' => 'required|in:monto_fijo,billetes',
'id_empresa' => 'required|exists:empresas,id_empresa',
```

### Cierre
```php
'saldo_final' => 'required|numeric|min:0',
'tipo_cierre' => 'required|in:monto_fijo,billetes',
```

### Movimiento
```php
'id_caja' => 'required|exists:cajas,id_caja',
'tipo' => 'required|in:ingreso,egreso',
'concepto' => 'required|string|max:255',
'monto' => 'required|numeric|min:0.01',
```

---

## 8. FLUJO DE ESTADOS

```
┌─────────────────────────────────────────────────────┐
│                                                     │
│  ABIERTA                                            │
│  ├─ Registrar ventas                               │
│  ├─ Registrar movimientos                          │
│  └─ [Cerrar Caja]                                  │
│       ↓                                             │
│  PENDIENTE DE VALIDACIÓN                           │
│  ├─ [Autorizar] → CERRADA                          │
│  └─ [Rechazar] → ABIERTA (vuelve)                  │
│       ↓                                             │
│  CERRADA                                            │
│  ├─ Arqueo registrado                              │
│  └─ No se puede modificar                          │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

## 9. CÁLCULOS AUTOMÁTICOS

### Total Teórico
```
Total Teórico = Saldo Inicial + Ingresos - Egresos
```

### Diferencia
```
Diferencia = Total Real - Total Teórico
```

### Subtotal por Denominación
```
Subtotal = Cantidad × Valor
```

### Total de Billetes
```
Total = Σ(Cantidad × Valor) para todas las denominaciones
```

---

## 10. DENOMINACIONES PREDEFINIDAS

### Soles Peruanos (PEN)
- Billetes: 200, 100, 50, 20, 10, 5, 2, 1
- Monedas: 0.50, 0.20, 0.10, 0.05

### Dólares Estadounidenses (USD)
- Billetes: 100, 50, 20, 10, 5, 1

---

## 11. QUERIES ÚTILES

### Obtener caja abierta del usuario actual
```php
$caja = Caja::where('id_usuario', auth()->id())
    ->where('estado', 'abierta')
    ->first();
```

### Obtener resumen de ventas por método
```php
$ventas = MovimientoCaja::where('id_caja', $id_caja)
    ->where('tipo', 'ingreso')
    ->where('tipo_referencia', 'venta')
    ->with('venta.metodoPago')
    ->get()
    ->groupBy('venta.metodoPago.nombre');
```

### Calcular total teórico
```php
$ingresos = MovimientoCaja::where('id_caja', $id_caja)
    ->where('tipo', 'ingreso')
    ->sum('monto');

$egresos = MovimientoCaja::where('id_caja', $id_caja)
    ->where('tipo', 'egreso')
    ->sum('monto');

$total_teorico = $caja->saldo_inicial + $ingresos - $egresos;
```

---

## 12. ARCHIVOS CLAVE

### Backend
- `app/Models/Caja.php`
- `app/Models/MovimientoCaja.php`
- `app/Services/CajaService.php`
- `app/Http/Controllers/Api/CajaController.php`

### Frontend
- `resources/js/components/Finanzas/Caja/CajasList.jsx`
- `resources/js/components/Finanzas/Caja/CajaAbiertaDetail.jsx`
- `resources/js/components/Finanzas/Caja/modals/CajaAperturaModal.jsx`
- `resources/js/components/Finanzas/Caja/modals/CajaCierreModal.jsx`
- `resources/js/components/Finanzas/Caja/modals/CajaValidacionModal.jsx`

### Hooks
- `resources/js/components/Finanzas/Caja/hooks/useCajas.js`
- `resources/js/components/Finanzas/Caja/hooks/useDenominaciones.js`

---

## 13. COMANDOS ÚTILES

```bash
# Crear migraciones
php artisan make:migration create_cajas_table
php artisan make:migration create_movimientos_caja_table

# Crear modelos
php artisan make:model Caja
php artisan make:model MovimientoCaja

# Crear controllers
php artisan make:controller Api/CajaController --api
php artisan make:controller Api/MovimientoCajaController --api

# Crear requests
php artisan make:request CajaAperturaRequest
php artisan make:request CajaCierreRequest

# Ejecutar migraciones
php artisan migrate

# Ejecutar seeders
php artisan db:seed --class=DenominacionesBilletesSeeder

# Crear permisos
php artisan permissions:add-caja
```

---

## 14. DEBUGGING

### Ver caja actual del usuario
```php
dd(Caja::where('id_usuario', auth()->id())->where('estado', 'abierta')->first());
```

### Ver movimientos de una caja
```php
dd(MovimientoCaja::where('id_caja', 1)->get());
```

### Ver resumen de cierre
```php
dd(app(CajaService::class)->calcularResumen(1));
```

### Ver auditoría de una caja
```php
dd(AuditoriaCaja::where('id_caja', 1)->get());
```

