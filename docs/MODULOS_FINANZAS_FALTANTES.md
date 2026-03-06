# Módulos Faltantes en Finanzas

## 📊 Estado Actual del Sistema

### ✅ Módulos Existentes
- Ventas (100%)
- Compras (100%)
- Cuentas por Cobrar (90%)
- Cuentas por Pagar (90%)
- Documentos SUNAT (100%)
- Cotizaciones (100%)

### ❌ Módulos Faltantes
1. Caja
2. Métodos de Pago
3. Banco
4. Análisis Financiero

---

## 1. MÓDULO DE CAJA

### Descripción
Sistema de gestión de caja diaria para registrar ingresos y egresos de efectivo, realizar arqueos y mantener un historial de movimientos.

### Funcionalidades Principales

#### 1.1 Apertura de Caja
- Crear nueva caja diaria
- Saldo inicial
- Usuario responsable
- Fecha y hora de apertura
- Estado: Abierta

#### 1.2 Movimientos de Caja
- Registrar ingresos (ventas en efectivo, depósitos, etc.)
- Registrar egresos (gastos, cambios, etc.)
- Tipo de movimiento (Ingreso/Egreso)
- Concepto/Descripción
- Monto
- Referencia (Venta, Compra, etc.)
- Usuario que registra

#### 1.3 Cierre de Caja
- Saldo final teórico (inicial + ingresos - egresos)
- Saldo real (conteo físico)
- Diferencia (sobrante/faltante)
- Observaciones
- Usuario que cierra
- Fecha y hora de cierre
- Estado: Cerrada

#### 1.4 Reportes
- Resumen diario de caja
- Movimientos por período
- Cajas con diferencias
- Historial de cajas

### Modelos Necesarios

#### Caja
```
- id_caja (PK)
- id_empresa (FK)
- id_usuario_apertura (FK)
- id_usuario_cierre (FK)
- fecha_apertura
- fecha_cierre
- hora_apertura
- hora_cierre
- saldo_inicial
- saldo_final_teorico
- saldo_final_real
- diferencia
- estado (Abierta, Cerrada)
- observaciones
- created_at
- updated_at
```

#### MovimientoCaja
```
- id_movimiento (PK)
- id_caja (FK)
- id_empresa (FK)
- id_usuario (FK)
- tipo (Ingreso, Egreso)
- concepto
- monto
- referencia_tipo (Venta, Compra, Gasto, etc.)
- referencia_id
- descripcion
- created_at
- updated_at
```

### Rutas API

```
GET    /api/cajas                          - Listar cajas
POST   /api/cajas                          - Crear caja (apertura)
GET    /api/cajas/{id}                     - Ver detalle de caja
PUT    /api/cajas/{id}/cierre              - Cerrar caja
GET    /api/cajas/{id}/movimientos         - Listar movimientos de caja
POST   /api/cajas/{id}/movimientos         - Registrar movimiento
GET    /api/cajas/reporte/diario           - Reporte diario
GET    /api/cajas/reporte/periodo          - Reporte por período
```

### Validaciones
- No puede haber dos cajas abiertas simultáneamente por usuario
- Saldo inicial debe ser >= 0
- Movimientos solo en cajas abiertas
- Diferencia se calcula automáticamente al cerrar
- Solo usuarios con permiso pueden abrir/cerrar caja

---

## 2. MÓDULO DE MÉTODOS DE PAGO

### Descripción
Gestión de métodos de pago disponibles en el sistema (Efectivo, Tarjeta, Transferencia, Cheque, etc.) y su configuración por empresa.

### Funcionalidades Principales

#### 2.1 Métodos de Pago Base
- Efectivo
- Tarjeta de Crédito
- Tarjeta de Débito
- Transferencia Bancaria
- Cheque
- Depósito en Cuenta
- Otros

#### 2.2 Configuración por Empresa
- Métodos habilitados/deshabilitados
- Comisión por método
- Límite de monto
- Requiere comprobante
- Requiere referencia bancaria

#### 2.3 Validaciones
- Método válido para tipo de documento
- Método habilitado en empresa
- Monto dentro de límites

### Modelos Necesarios

#### MetodoPago
```
- id_metodo_pago (PK)
- nombre (Efectivo, Tarjeta, etc.)
- codigo (CASH, CARD, TRANSFER, etc.)
- descripcion
- requiere_referencia (boolean)
- requiere_comprobante (boolean)
- activo (boolean)
- created_at
- updated_at
```

#### ConfiguracionMetodoPago
```
- id_config (PK)
- id_empresa (FK)
- id_metodo_pago (FK)
- habilitado (boolean)
- comision (decimal)
- limite_minimo (decimal)
- limite_maximo (decimal)
- requiere_comprobante (boolean)
- requiere_referencia (boolean)
- created_at
- updated_at
```

### Rutas API

```
GET    /api/metodos-pago                   - Listar métodos
POST   /api/metodos-pago                   - Crear método
GET    /api/metodos-pago/{id}              - Ver detalle
PUT    /api/metodos-pago/{id}              - Actualizar método
DELETE /api/metodos-pago/{id}              - Eliminar método

GET    /api/empresas/{id}/metodos-pago     - Métodos habilitados por empresa
POST   /api/empresas/{id}/metodos-pago     - Configurar método para empresa
PUT    /api/empresas/{id}/metodos-pago/{id} - Actualizar configuración
```

### Validaciones
- Nombre único
- Código único
- Comisión >= 0
- Límites coherentes (mínimo <= máximo)

---

## 3. MÓDULO DE BANCO

### Descripción
Gestión de cuentas bancarias de la empresa, conciliación bancaria y movimientos bancarios.

### Funcionalidades Principales

#### 3.1 Bancos
- Información de bancos (nombre, código, etc.)
- Datos de contacto

#### 3.2 Cuentas Bancarias
- Número de cuenta
- Tipo de cuenta (Corriente, Ahorros)
- Moneda
- Banco
- Saldo actual
- Saldo según banco
- Empresa propietaria

#### 3.3 Movimientos Bancarios
- Depósitos
- Retiros
- Transferencias
- Comisiones
- Intereses
- Fecha de movimiento
- Referencia

#### 3.4 Conciliación Bancaria
- Saldo según empresa
- Saldo según banco
- Diferencias
- Movimientos no conciliados
- Fecha de conciliación
- Observaciones

#### 3.5 Reportes
- Estado de cuentas
- Movimientos por período
- Conciliaciones realizadas
- Diferencias pendientes

### Modelos Necesarios

#### Banco
```
- id_banco (PK)
- nombre
- codigo_sunat
- codigo_swift
- telefono
- email
- website
- activo (boolean)
- created_at
- updated_at
```

#### CuentaBancaria
```
- id_cuenta (PK)
- id_empresa (FK)
- id_banco (FK)
- numero_cuenta
- tipo_cuenta (Corriente, Ahorros)
- moneda (PEN, USD, etc.)
- saldo_actual (decimal)
- saldo_banco (decimal)
- titular
- cci
- activa (boolean)
- created_at
- updated_at
```

#### MovimientoBancario
```
- id_movimiento (PK)
- id_cuenta (PK)
- id_empresa (FK)
- tipo (Deposito, Retiro, Transferencia, Comision, Interes)
- monto (decimal)
- fecha_movimiento
- referencia
- descripcion
- conciliado (boolean)
- created_at
- updated_at
```

#### ConciliacionBancaria
```
- id_conciliacion (PK)
- id_cuenta (FK)
- id_empresa (FK)
- id_usuario (FK)
- fecha_conciliacion
- saldo_empresa (decimal)
- saldo_banco (decimal)
- diferencia (decimal)
- estado (Pendiente, Conciliada, Diferencia)
- observaciones
- created_at
- updated_at
```

### Rutas API

```
GET    /api/bancos                         - Listar bancos
POST   /api/bancos                         - Crear banco
GET    /api/bancos/{id}                    - Ver detalle

GET    /api/cuentas-bancarias              - Listar cuentas
POST   /api/cuentas-bancarias              - Crear cuenta
GET    /api/cuentas-bancarias/{id}         - Ver detalle
PUT    /api/cuentas-bancarias/{id}         - Actualizar cuenta

GET    /api/cuentas-bancarias/{id}/movimientos - Movimientos
POST   /api/cuentas-bancarias/{id}/movimientos - Registrar movimiento

GET    /api/conciliaciones                 - Listar conciliaciones
POST   /api/conciliaciones                 - Crear conciliación
GET    /api/conciliaciones/{id}            - Ver detalle
PUT    /api/conciliaciones/{id}            - Actualizar conciliación
```

### Validaciones
- Número de cuenta único por banco
- CCI válido (17 dígitos)
- Saldo no negativo
- Movimientos solo en cuentas activas
- Conciliación solo por usuario autorizado

---

## 4. MÓDULO DE ANÁLISIS FINANCIERO

### Descripción
Análisis y reportes financieros para toma de decisiones estratégicas.

### Funcionalidades Principales

#### 4.1 Flujo de Caja
- Ingresos por período
- Egresos por período
- Flujo neto
- Proyecciones
- Gráficos de tendencia

#### 4.2 Rentabilidad
- Margen bruto
- Margen neto
- ROI (Return on Investment)
- Ganancia por producto
- Ganancia por cliente

#### 4.3 Indicadores Financieros
- Razón corriente (Activos/Pasivos)
- Razón rápida
- Rotación de inventario
- Días de cobranza
- Días de pago

#### 4.4 Análisis de Deuda
- Deuda total
- Deuda por proveedor
- Deuda vencida
- Proyección de pagos

#### 4.5 Reportes
- Estado de resultados
- Balance general
- Flujo de caja
- Análisis comparativo (período anterior)
- Gráficos y dashboards

### Modelos Necesarios

#### ReporteFinanciero
```
- id_reporte (PK)
- id_empresa (FK)
- id_usuario (FK)
- tipo (Flujo, Rentabilidad, Indicadores, Deuda)
- fecha_inicio
- fecha_fin
- datos_json (JSON con datos del reporte)
- generado_en
- created_at
- updated_at
```

### Rutas API

```
GET    /api/reportes/flujo-caja            - Flujo de caja
GET    /api/reportes/rentabilidad          - Análisis de rentabilidad
GET    /api/reportes/indicadores           - Indicadores financieros
GET    /api/reportes/deuda                 - Análisis de deuda
GET    /api/reportes/estado-resultados     - Estado de resultados
GET    /api/reportes/balance-general       - Balance general
GET    /api/reportes/comparativo           - Análisis comparativo
GET    /api/dashboard/financiero           - Dashboard financiero
```

### Validaciones
- Fechas válidas (inicio <= fin)
- Empresa existe
- Usuario tiene permisos
- Datos suficientes para generar reporte

---

## 📋 PLAN DE IMPLEMENTACIÓN

### Fase 1: Caja + Métodos de Pago (Semana 1)
- [ ] Crear migraciones
- [ ] Crear modelos
- [ ] Crear controllers
- [ ] Crear rutas
- [ ] Crear validaciones
- [ ] Crear tests

### Fase 2: Banco (Semana 2)
- [ ] Crear migraciones
- [ ] Crear modelos
- [ ] Crear controllers
- [ ] Crear rutas
- [ ] Crear validaciones
- [ ] Crear tests

### Fase 3: Análisis Financiero (Semana 3)
- [ ] Crear modelos
- [ ] Crear controllers
- [ ] Crear rutas
- [ ] Crear lógica de cálculos
- [ ] Crear tests

---

## 🔗 Relaciones Entre Módulos

```
Venta
├── VentaPago (Método de Pago)
├── Caja (Ingresos)
└── CuentaBancaria (Si es transferencia)

Compra
├── DiaCompra (Cuentas por Pagar)
└── CuentaBancaria (Si es transferencia)

Caja
├── MovimientoCaja
└── Empresa

MetodoPago
├── ConfiguracionMetodoPago
└── Empresa

CuentaBancaria
├── Banco
├── MovimientoBancario
├── ConciliacionBancaria
└── Empresa

ReporteFinanciero
├── Venta
├── Compra
├── Caja
└── CuentaBancaria
```

---

## 📝 Notas Importantes

1. **Integridad de Datos**: Todos los movimientos deben ser auditables
2. **Permisos**: Cada módulo debe tener permisos específicos
3. **Validaciones**: Validar en modelo y controller
4. **Transacciones**: Usar transacciones para operaciones críticas
5. **Reportes**: Cachear reportes para mejor rendimiento
6. **Auditoría**: Registrar quién, cuándo y qué cambió

---

## 🎯 Próximos Pasos

1. Revisar y aprobar especificación
2. Crear migraciones de base de datos
3. Crear modelos y relaciones
4. Crear controllers y rutas
5. Crear validaciones
6. Crear tests
7. Crear frontend (componentes Vue/React)
