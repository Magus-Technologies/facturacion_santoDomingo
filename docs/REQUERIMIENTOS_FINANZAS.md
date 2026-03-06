# Requerimientos de Módulos de Finanzas

## RESUMEN EJECUTIVO

Este documento define los requerimientos completos para el módulo de Finanzas del sistema, con énfasis especial en la **Gestión de Cajas Diarias**.

### Documentos Relacionados
- **CAJA_UI_ESPECIFICACIONES.md** - Mockups y especificaciones de UI/UX
- **CAJA_ESPECIFICACIONES_BD.md** - Esquema de base de datos
- **CAJA_PLAN_IMPLEMENTACION.md** - Plan detallado de implementación

### Flujo General del Sistema

```
ADMINISTRADOR
    ↓
Crea estructura de cajas
    ↓
VENDEDOR
    ├─ Apertura de Caja (Diaria - OBLIGATORIA)
    ├─ Realiza Ventas (Registra automáticamente en Caja)
    ├─ Registra Ingresos/Egresos Manuales
    ├─ Cierre de Caja (Genera Resumen)
    └─ Estado: PENDIENTE DE VALIDACIÓN
    ↓
ADMINISTRADOR
    ├─ Revisa Resumen de Cierre
    ├─ Valida o Rechaza
    └─ Si Valida: Se registra Arqueo Diario (Histórico)
```

### Puntos Clave

1. **Apertura Obligatoria**: El vendedor DEBE aperturar caja antes de poder vender
2. **Dos Formas de Registro**: Monto fijo O desglose de billetes
3. **Resumen Claro**: Antes de cerrar, el vendedor ve resumen con lupa para detalle por método
4. **Validación Requerida**: El cierre no es final hasta que administrador lo valide
5. **Histórico Completo**: Se registra arqueo diario con todos los datos para auditoría

## 1. MÓDULO DE CAJA

### 1.1 Roles y Responsabilidades

#### Administrador
- Crea la estructura de cajas en el sistema
- Es el responsable final
- Confirma/valida el cierre de cajas
- Autoriza el arqueo diario
- Puede ver todo el resumen
- Puede aceptar o rechazar el cierre

#### Vendedor
- NO crea caja (la crea el administrador)
- DEBE aperturar caja todos los días para poder vender
- No puede hacer ventas si no ha aperturado
- Solo ve los métodos de pago disponibles
- Registra ventas
- Hace el cierre de caja
- El cierre queda pendiente hasta validación del administrador

### 1.2 Apertura de Caja (OBLIGATORIA DIARIA)

**Responsable**: Vendedor/Usuario con permiso `puede_abrir_caja`

**Requisito**: El vendedor DEBE aperturar antes de poder vender

**Datos requeridos**:
- Saldo inicial (monto fijo O por numeración de billetes)
- Usuario que abre
- Fecha y hora de apertura
- Empresa

**Dos formas de registro**:

1. **Opción 1 - Monto Fijo**: 
   - Ingresar directamente el saldo inicial
   - Ejemplo: Saldo inicial = 1000

2. **Opción 2 - Enumeración de Billetes**:
   - Registrar cantidad de cada denominación:
     - Billetes: S/. 200, 100, 50, 20, 10, 5, 2, 1
     - Monedas: S/. 0.50, 0.20, 0.10, 0.05
   - Sistema calcula automáticamente:
     - Cantidad × Valor = Subtotal por denominación
     - Suma total = Saldo inicial

**Validaciones**:
- No puede haber dos cajas abiertas simultáneamente por usuario
- Saldo inicial >= 0
- Usuario debe tener permisos
- Debe ser la primera acción del día

### 1.3 Movimientos de Caja (Durante el Día)

**Tipos**: Ingreso, Egreso

**Datos**:
- Concepto (descripción del movimiento)
- Monto
- Tipo (Ingreso/Egreso)
- Número de operación (opcional, para transferencias/billeteras)
- Referencia (tipo y ID del documento relacionado)
- Usuario que registra
- Descripción adicional

**Validaciones**:
- Solo en cajas abiertas
- Monto > 0
- Usuario debe tener permiso `puede_registrar_movimientos`

**Registro Automático de Ventas**:
- Cada venta se registra automáticamente como movimiento de ingreso
- Se relaciona al método de pago utilizado
- Se suma automáticamente al resumen

### 1.4 Resumen para Cierre (Antes de Cerrar)

El vendedor debe ver un resumen claro con:

#### Apertura
- Monto con el que abrió ese día
- Mostrar si fue por monto fijo o desglose de billetes

#### Resumen de Ventas por Método
- Cada método de pago debe mostrar:
  - Nombre del método (Yape, Efectivo, Transferencia BCP, etc.)
  - Monto total de ventas con ese método
  - **Ícono de lupa** para ver detalle
  
**Funcionalidad de Lupa (Detalle de Ventas)**:
- Al presionar la lupa se abre una tabla
- Muestra SOLO las ventas de ese día con ese método
- Columnas: Número de venta, Cliente, Monto, Hora, Referencia (si aplica)
- Permite verificar antes de cerrar

#### Ingresos Manuales
- Si hubo ingresos adicionales (depósitos, devoluciones, etc.)
- Mostrar total

#### Egresos
- Gastos, retiros, cambios, etc.
- Mostrar total

#### Total en Caja (Teórico)
- Cálculo automático:
  - Saldo inicial
  - + Ingresos (ventas + ingresos manuales)
  - - Egresos
  - = Total Teórico

### 1.5 Cierre de Caja

**Responsable**: Vendedor/Usuario con permiso `puede_cerrar_caja`

**Datos requeridos**:
- Saldo final real (monto fijo O por numeración de billetes)
- Usuario que cierra
- Observaciones (opcional)

**Dos formas de registro**:

1. **Opción 1 - Monto Fijo**:
   - Ingresar directamente el saldo final contado
   - Ejemplo: Total contado = 1500

2. **Opción 2 - Enumeración de Billetes**:
   - Registrar cantidad de cada denominación contada
   - Sistema calcula automáticamente el total

**Cálculos automáticos**:
- Saldo final teórico = Saldo inicial + Ingresos - Egresos
- Diferencia = Saldo final real - Saldo final teórico
- Tipo de diferencia:
  - Sobrante (si real > teórico)
  - Faltante (si real < teórico)
  - Exacto (si real = teórico)

**Estados después de cerrar**:
- Pendiente de Validación (esperando que administrador valide)

**Validaciones**:
- Caja debe estar abierta
- Usuario debe tener permisos
- No se puede cerrar sin haber aperturado

### 1.6 Validación/Autorización de Cierre

**Responsable**: Administrador/Usuario con permiso `puede_autorizar_cierre`

**Datos**:
- Revisar diferencia (si hay sobrante/faltante)
- Autorizar o rechazar con observaciones
- Contraseña/PIN para confirmar

**Flujo**:
1. Vendedor cierra caja → Estado: "Pendiente de Validación"
2. Administrador revisa el resumen
3. Administrador autoriza o rechaza
4. Si autoriza → Estado: "Cerrada" + Se registra Arqueo Diario
5. Si rechaza → Vuelve a "Abierta" para revisión del vendedor

### 1.7 Arqueo Diario (Histórico)

Se registra automáticamente cuando se valida el cierre. Guarda:
- Con cuánto aperturó (saldo inicial)
- Total de ventas por método
- Total ingresos manuales
- Total egresos
- Total teórico
- Total real (contado)
- Diferencia (sobrante/faltante/exacto)
- Usuario que cerró
- Usuario que validó
- Fecha y hora
- Observaciones

Este registro es histórico y no se puede modificar.

### 1.8 Permisos Requeridos
- `puede_abrir_caja`: Abrir caja
- `puede_cerrar_caja`: Cerrar caja
- `puede_autorizar_cierre`: Autorizar cierre (solo administrador)
- `puede_rechazar_cierre`: Rechazar cierre
- `puede_registrar_movimientos`: Registrar movimientos
- `puede_ver_reportes`: Ver reportes

### 1.9 Auditoría
- Registrar: Quién, Cuándo, Qué acción, IP, User Agent
- Acciones: Apertura, Cierre, Autorización, Rechazo, Modificación

---

## 2. MÓDULO DE MÉTODOS DE PAGO

### 2.1 Métodos Base del Sistema
- Efectivo
- Tarjeta de Crédito
- Tarjeta de Débito
- Transferencia Bancaria
- Cheque
- Billetera Digital (Yape, Plin, Tunki)
- Otros

### 2.2 Métodos Peruanos Específicos
- **Yape** (BCP)
- **Plin** (Interbank, BBVA, Scotiabank, etc.)
- **Tunki** (Banco de la Nación)
- **Billetera Móvil** (varios bancos)

### 2.3 Configuración por Empresa
- Métodos habilitados/deshabilitados
- Comisión por método (%)
- Límite mínimo de monto
- Límite máximo de monto
- Requiere comprobante (boolean)
- Requiere referencia (boolean)

### 2.4 Validaciones
- Método válido para tipo de documento
- Método habilitado en empresa
- Monto dentro de límites
- Comisión se calcula automáticamente

### 2.5 Datos Adicionales
- Número de operación (para transferencias, billeteras)
- Referencia bancaria
- Comprobante (archivo)

---

## 3. MÓDULO DE BANCO

### 3.1 Bancos
- Información de bancos peruanos
- Código SUNAT
- Código SWIFT
- Contacto

### 3.2 Cuentas Bancarias
- **Datos**:
  - Número de cuenta (único)
  - Tipo (Corriente, Ahorros)
  - Moneda (PEN, USD, etc.)
  - CCI (17 dígitos)
  - Saldo actual
  - Saldo según banco
  - Activa (boolean)
- **Múltiples Titulares**:
  - Nombre
  - Documento (DNI, RUC, etc.)
  - Titular principal (boolean)
- **Saldo Inicial**:
  - Se registra al crear la cuenta
  - Puede ser monto fijo

### 3.3 Movimientos Bancarios
- **Tipos**: Depósito, Retiro, Transferencia, Comisión, Interés
- **Datos**:
  - Monto
  - Fecha del movimiento
  - Número de operación
  - Referencia
  - Descripción
  - Conciliado (boolean)

### 3.4 Conciliación Bancaria
- **Datos**:
  - Saldo según empresa
  - Saldo según banco
  - Diferencia (calculada automáticamente)
  - Estado (Pendiente, Conciliada, Diferencia)
  - Observaciones
  - Usuario que realiza
  - Fecha de conciliación
- **Validaciones**:
  - Solo usuarios autorizados
  - Movimientos no conciliados se marcan

### 3.5 Reportes
- Estado de cuentas
- Movimientos por período
- Conciliaciones realizadas
- Diferencias pendientes

---

## 4. BILLETERAS DIGITALES

### 4.1 Estructura
- Vinculada a Método de Pago (Yape, Plin, Tunki)
- Vinculada a Banco (BCP, Interbank, BBVA, Banco de la Nación)
- Número de cuenta/teléfono registrado
- Titular
- Documento de identidad
- Saldo

### 4.2 Ejemplo de Datos
```
Billetera: Yape - 987654321 (BCP)
Billetera: Plin - 987654321 (Interbank)
Billetera: Plin - 987654322 (BBVA)
Billetera: Tunki - 987654323 (Banco de la Nación)
```

### 4.3 Validaciones
- Número de cuenta único
- Documento válido
- Saldo >= 0

---

## 5. DENOMINACIONES DE BILLETES

### 5.1 Billetes Peruanos (PEN)
- S/. 200
- S/. 100
- S/. 50
- S/. 20
- S/. 10
- S/. 5
- S/. 2
- S/. 1

### 5.2 Monedas Peruanas (PEN)
- S/. 0.50
- S/. 0.20
- S/. 0.10
- S/. 0.05

### 5.3 Billetes USD (USD)
- $ 100
- $ 50
- $ 20
- $ 10
- $ 5
- $ 1

### 5.4 Uso
- Apertura de caja: Registrar cantidad de cada denominación
- Cierre de caja: Registrar cantidad contada de cada denominación
- Cálculo automático: Cantidad × Valor = Subtotal

---

## 6. FLUJOS DE NEGOCIO

### 6.1 Flujo Completo de Caja Diaria

```
INICIO DEL DÍA
├─ Vendedor abre caja
│  ├─ Opción 1: Ingresa monto fijo (ej: 1000)
│  └─ Opción 2: Registra billetes por denominación
│     └─ Sistema calcula total automáticamente
│  └─ Estado: ABIERTA
│
DURANTE EL DÍA
├─ Vendedor realiza ventas
│  ├─ Selecciona método de pago (Yape, Efectivo, BCP, etc.)
│  ├─ Sistema registra automáticamente como movimiento de ingreso
│  └─ Se suma al resumen por método
│
├─ Vendedor puede registrar ingresos/egresos manuales
│  ├─ Depósitos
│  ├─ Devoluciones
│  ├─ Gastos
│  └─ Cambios
│
ANTES DE CERRAR
├─ Vendedor revisa RESUMEN DE CIERRE
│  ├─ Apertura: Monto inicial
│  ├─ Resumen de Ventas por Método:
│  │  ├─ Yape: $500 [LUPA] → Abre tabla con ventas de Yape del día
│  │  ├─ Efectivo: $800 [LUPA] → Abre tabla con ventas en Efectivo del día
│  │  ├─ Transferencia BCP: $300 [LUPA] → Abre tabla con transferencias del día
│  │  └─ Otros métodos...
│  ├─ Ingresos Manuales: $100
│  ├─ Egresos: $50
│  └─ Total Teórico: 1000 + 500 + 800 + 300 + 100 - 50 = 2650
│
CIERRE DE CAJA
├─ Vendedor cierra caja
│  ├─ Opción 1: Ingresa monto total contado (ej: 2650)
│  └─ Opción 2: Registra billetes contados por denominación
│     └─ Sistema calcula total automáticamente
│  ├─ Sistema calcula:
│  │  ├─ Diferencia = Total Real - Total Teórico
│  │  ├─ Si diferencia = 0 → EXACTO
│  │  ├─ Si diferencia > 0 → SOBRANTE
│  │  └─ Si diferencia < 0 → FALTANTE
│  └─ Estado: PENDIENTE DE VALIDACIÓN
│
VALIDACIÓN (Administrador)
├─ Administrador revisa cierre
│  ├─ Ve resumen completo
│  ├─ Ve diferencia (sobrante/faltante/exacto)
│  └─ Puede ver detalle de cada método con lupa
│
├─ Administrador autoriza o rechaza
│  ├─ Si AUTORIZA:
│  │  ├─ Estado: CERRADA
│  │  ├─ Se registra ARQUEO DIARIO (histórico)
│  │  └─ Fin del proceso
│  │
│  └─ Si RECHAZA:
│     ├─ Estado: ABIERTA (vuelve a abrirse)
│     ├─ Vendedor puede revisar y cerrar nuevamente
│     └─ Vuelve a PENDIENTE DE VALIDACIÓN
│
FIN DEL DÍA
└─ Caja cerrada y validada
   └─ Arqueo registrado en histórico
```

### 6.2 Detalle de Resumen de Cierre (Lo que ve el Vendedor)

```
┌─────────────────────────────────────────────────────┐
│           RESUMEN DE CIERRE DE CAJA                 │
├─────────────────────────────────────────────────────┤
│                                                     │
│ APERTURA                                            │
│ ├─ Saldo Inicial: S/. 1,000.00                     │
│ └─ Registrado por: Monto Fijo                      │
│                                                     │
│ RESUMEN DE VENTAS POR MÉTODO                        │
│ ├─ Yape                    S/. 500.00  [LUPA]      │
│ ├─ Efectivo                S/. 800.00  [LUPA]      │
│ ├─ Transferencia BCP       S/. 300.00  [LUPA]      │
│ └─ Otros                   S/. 0.00    [LUPA]      │
│                                                     │
│ INGRESOS MANUALES          S/. 100.00              │
│ EGRESOS                    S/. 50.00               │
│                                                     │
│ TOTAL TEÓRICO              S/. 2,650.00            │
│                                                     │
│ TOTAL REAL (Contado)       S/. 2,650.00            │
│                                                     │
│ DIFERENCIA                 S/. 0.00 (EXACTO)       │
│                                                     │
└─────────────────────────────────────────────────────┘
```

### 6.3 Detalle de Lupa (Tabla de Ventas por Método)

```
┌──────────────────────────────────────────────────────────────┐
│  VENTAS CON MÉTODO: YAPE (04/03/2026)                        │
├──────────────────────────────────────────────────────────────┤
│ # │ Número │ Cliente      │ Monto    │ Hora     │ Referencia │
├──────────────────────────────────────────────────────────────┤
│ 1 │ V-001  │ Juan Pérez   │ 150.00   │ 09:30    │ 123456789  │
│ 2 │ V-002  │ María García │ 200.00   │ 10:15    │ 987654321  │
│ 3 │ V-003  │ Carlos López │ 150.00   │ 14:45    │ 555666777  │
├──────────────────────────────────────────────────────────────┤
│ TOTAL YAPE                                      S/. 500.00   │
└──────────────────────────────────────────────────────────────┘
```

### 6.4 Arqueo Diario (Histórico - Se guarda automáticamente)

```
{
  "id_arqueo": 1,
  "fecha": "2026-03-04",
  "usuario_cierre": "vendedor@empresa.com",
  "usuario_validacion": "admin@empresa.com",
  "saldo_inicial": 1000.00,
  "ventas_por_metodo": {
    "Yape": 500.00,
    "Efectivo": 800.00,
    "Transferencia BCP": 300.00
  },
  "total_ventas": 1600.00,
  "ingresos_manuales": 100.00,
  "egresos": 50.00,
  "total_teorico": 2650.00,
  "total_real": 2650.00,
  "diferencia": 0.00,
  "tipo_diferencia": "EXACTO",
  "estado": "CERRADA",
  "observaciones": "Cierre normal",
  "fecha_cierre": "2026-03-04 17:30:00",
  "fecha_validacion": "2026-03-04 17:35:00"
}
```

### 6.5 Flujo de Pago (Integración con Ventas)
```
1. Vendedor crea venta
2. Selecciona método de pago (debe estar disponible)
3. Valida método habilitado
4. Valida límites (mínimo/máximo)
5. Registra número de operación (si aplica)
6. Calcula comisión (si aplica)
7. Registra automáticamente en movimiento de caja
8. Actualiza saldo de billetera (si es Yape/Plin/Tunki)
9. Venta se suma al resumen de cierre
```

### 6.6 Flujo de Conciliación Bancaria
```
1. Obtener saldo según empresa
2. Obtener saldo según banco
3. Calcular diferencia
4. Marcar movimientos como conciliados
5. Registrar observaciones
6. Cambiar estado a Conciliada o Diferencia
```

---

## 7. RELACIONES ENTRE MÓDULOS

```
Venta
├─ VentaPago (Método de Pago)
├─ Movimiento de Caja (Ingreso)
└─ Billetera Digital (si es Yape/Plin/Tunki)

Compra
├─ Movimiento de Caja (Egreso)
└─ Cuenta Bancaria (si es transferencia)

Caja
├─ Movimientos de Caja
├─ Apertura con Billetes
├─ Cierre con Billetes
├─ Auditoría
└─ Permisos

Método de Pago
├─ Configuración por Empresa
├─ Billetera Digital
└─ Movimiento de Caja

Banco
├─ Cuenta Bancaria
├─ Titular
├─ Movimiento Bancario
└─ Conciliación Bancaria
```

---

## 8. SEGURIDAD Y AUDITORÍA

### 8.1 Permisos Granulares
- Por usuario
- Por empresa
- Por acción (abrir, cerrar, autorizar, etc.)

### 8.2 Auditoría Completa
- Quién realizó la acción
- Cuándo (fecha y hora)
- Qué acción
- IP y User Agent
- Cambios realizados

### 8.3 Validaciones
- Contraseña/PIN para autorizar cierre
- Solo usuarios autorizados pueden autorizar
- No se puede modificar caja cerrada
- Transacciones atómicas (todo o nada)

---

## 9. REPORTES Y ANÁLISIS

### 9.1 Reportes de Caja
- Resumen diario
- Movimientos por período
- Cajas con diferencias
- Historial completo

### 9.2 Reportes de Métodos de Pago
- Uso por método
- Comisiones cobradas
- Métodos más usados

### 9.3 Reportes Bancarios
- Estado de cuentas
- Movimientos por período
- Conciliaciones
- Diferencias pendientes

### 9.4 Análisis Financiero
- Flujo de caja
- Ingresos vs Egresos
- Tendencias
- Proyecciones

---

## 10. CONSIDERACIONES TÉCNICAS

### 10.1 Base de Datos
- Transacciones ACID
- Índices en campos de búsqueda frecuente
- Relaciones con integridad referencial
- Soft deletes para auditoría

### 10.2 API
- Endpoints RESTful
- Validación de entrada
- Manejo de errores
- Paginación en listados

### 10.3 Frontend
- Interfaz intuitiva
- Validaciones en cliente
- Confirmaciones antes de acciones críticas
- Reportes exportables (PDF, Excel)

### 10.4 Performance
- Cacheo de denominaciones
- Índices en tablas grandes
- Queries optimizadas
- Paginación en reportes

---

## 11. PRÓXIMOS PASOS

1. Crear migraciones de base de datos
2. Crear modelos Eloquent
3. Crear controllers y rutas
4. Crear validaciones
5. Crear servicios de lógica de negocio
6. Crear tests
7. Crear frontend (componentes Vue/React)
8. Documentar API
