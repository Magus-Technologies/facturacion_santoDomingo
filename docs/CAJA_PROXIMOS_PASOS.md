# Próximos Pasos - Módulo de Caja

## 📊 Estado Actual

✅ **Completado:**
- Tablas de BD creadas
- Modelos creados
- Controller creado con métodos principales
- Rutas API definidas
- Permisos configurados
- Documentación completa

❌ **Pendiente:**
- 2 métodos en CajaController
- Componentes React
- Hooks personalizados
- Modales
- Pantallas

---

## 🎯 PASO 1: Agregar Métodos Faltantes al CajaController

### Método 1: `resumen()`

**Ubicación:** `app/Http/Controllers/Api/CajaController.php`

**Propósito:** Obtener el resumen de cierre con:
- Apertura
- Ventas agrupadas por método
- Ingresos/egresos manuales
- Total teórico

**Respuesta esperada:**
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
          { "numero": "V-001", "cliente": "Juan", "monto": 150.00, "hora": "09:30" }
        ]
      }
    ],
    "ingresos_manuales": 100.00,
    "egresos": 50.00,
    "total_teorico": 2650.00
  }
}
```

**Ruta:** `GET /api/cajas/{id}/resumen`

---

### Método 2: `ventasPorMetodo()`

**Ubicación:** `app/Http/Controllers/Api/CajaController.php`

**Propósito:** Obtener ventas agrupadas por método de pago

**Respuesta esperada:**
```json
{
  "success": true,
  "data": [
    {
      "id_metodo_pago": 1,
      "nombre": "Yape",
      "total": 500.00,
      "cantidad": 3,
      "ventas": [
        { "numero": "V-001", "cliente": "Juan", "monto": 150.00, "hora": "09:30" }
      ]
    }
  ]
}
```

**Ruta:** `GET /api/cajas/{id}/ventas-por-metodo`

---

## 🎨 PASO 2: Crear Componentes React

### Estructura de Carpetas

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

## 📝 PASO 3: Crear Hooks Personalizados

### Hook 1: `useCajas.js`

**Ubicación:** `resources/js/components/Finanzas/Caja/hooks/useCajas.js`

**Funcionalidad:**
- Listar cajas
- Obtener caja activa
- Abrir caja
- Cerrar caja
- Autorizar cierre
- Rechazar cierre
- Obtener resumen

**Ejemplo de uso:**
```jsx
const { cajas, loading, error, abrirCaja, cerrarCaja } = useCajas();
```

---

### Hook 2: `useDenominaciones.js`

**Ubicación:** `resources/js/components/Finanzas/Caja/hooks/useDenominaciones.js`

**Funcionalidad:**
- Obtener denominaciones
- Calcular total de billetes

**Ejemplo de uso:**
```jsx
const { denominaciones, calcularTotal } = useDenominaciones();
```

---

### Hook 3: `useMovimientosCaja.js`

**Ubicación:** `resources/js/components/Finanzas/Caja/hooks/useMovimientosCaja.js`

**Funcionalidad:**
- Listar movimientos
- Registrar movimiento
- Eliminar movimiento

**Ejemplo de uso:**
```jsx
const { movimientos, registrarMovimiento } = useMovimientosCaja(cajaId);
```

---

## 🎯 PASO 4: Crear Componentes Reutilizables

### Componente 1: `DenominacionesTable.jsx`

**Ubicación:** `resources/js/components/Finanzas/Caja/components/DenominacionesTable.jsx`

**Props:**
```jsx
<DenominacionesTable
  denominaciones={[...]}
  onChange={(denominaciones) => {}}
  total={0}
/>
```

---

### Componente 2: `ResumenVentasPorMetodo.jsx`

**Ubicación:** `resources/js/components/Finanzas/Caja/components/ResumenVentasPorMetodo.jsx`

**Props:**
```jsx
<ResumenVentasPorMetodo
  metodos={[...]}
  onVerDetalle={(metodo) => {}}
/>
```

---

### Componente 3: `ModalDetalleVentas.jsx`

**Ubicación:** `resources/js/components/Finanzas/Caja/components/ModalDetalleVentas.jsx`

**Props:**
```jsx
<ModalDetalleVentas
  isOpen={true}
  metodo="Yape"
  ventas={[...]}
  total={500}
  onClose={() => {}}
/>
```

---

## 🖼️ PASO 5: Crear Pantallas Principales

### Pantalla 1: `CajasList.jsx`

**Ubicación:** `resources/js/components/Finanzas/Caja/CajasList.jsx`

**Funcionalidad:**
- Listar cajas
- Filtros (estado, fecha, usuario)
- Botón para crear nueva caja
- Botón para ver detalle

**Estructura:**
```jsx
export default function CajasList() {
  const { cajas, loading } = useCajas();
  
  return (
    <MainLayout>
      {/* Encabezado */}
      {/* Filtros */}
      {/* Tabla */}
      {/* Paginación */}
      {/* Modales */}
    </MainLayout>
  );
}
```

---

### Pantalla 2: `CajaAbiertaDetail.jsx`

**Ubicación:** `resources/js/components/Finanzas/Caja/CajaAbiertaDetail.jsx`

**Funcionalidad:**
- Mostrar estado actual de caja
- Mostrar movimientos del día
- Botones: Ingreso Manual, Egreso, Cerrar Caja

---

### Pantalla 3: `ArqueosHistoricoList.jsx`

**Ubicación:** `resources/js/components/Finanzas/Caja/ArqueosHistoricoList.jsx`

**Funcionalidad:**
- Listar arqueos
- Filtros
- Ver detalle

---

## 📋 PASO 6: Crear Modales

### Modal 1: `CajaAperturaModal.jsx`

**Ubicación:** `resources/js/components/Finanzas/Caja/modals/CajaAperturaModal.jsx`

**Funcionalidad:**
- Opción: Monto Fijo
- Opción: Por Billetes
- Validaciones
- Envío a API

---

### Modal 2: `CajaCierreModal.jsx`

**Ubicación:** `resources/js/components/Finanzas/Caja/modals/CajaCierreModal.jsx`

**Funcionalidad:**
- Opción: Monto Fijo
- Opción: Por Billetes
- Cálculo de diferencia
- Tipo de diferencia (exacto/sobrante/faltante)

---

### Modal 3: `CajaResumenCierreModal.jsx`

**Ubicación:** `resources/js/components/Finanzas/Caja/modals/CajaResumenCierreModal.jsx`

**Funcionalidad:**
- Mostrar apertura
- Mostrar resumen de ventas por método (con lupa)
- Mostrar ingresos/egresos
- Mostrar total teórico

---

### Modal 4: `CajaValidacionModal.jsx`

**Ubicación:** `resources/js/components/Finanzas/Caja/modals/CajaValidacionModal.jsx`

**Funcionalidad:**
- Mostrar resumen completo
- Mostrar diferencia
- Opción: Autorizar o Rechazar
- Requerir contraseña

---

## 🔗 PASO 7: Integración con Ventas

### Cambios necesarios en Ventas

1. **Verificar que caja esté abierta**
   - Antes de crear venta, verificar `GET /api/cajas/activa`
   - Si no hay caja abierta, mostrar error

2. **Registrar movimiento automáticamente**
   - Cuando se crea venta, registrar movimiento en caja
   - `POST /api/cajas/{id}/movimientos`

3. **Agrupar por método de pago**
   - En el resumen de cierre, agrupar ventas por método

---

## ✅ Checklist de Implementación

### Fase 1: Backend (1-2 días)
- [ ] Agregar método `resumen()` en CajaController
- [ ] Agregar método `ventasPorMetodo()` en CajaController
- [ ] Actualizar rutas en `routes/api.php`
- [ ] Testing de endpoints

### Fase 2: Frontend - Hooks (1 día)
- [ ] Crear `useCajas.js`
- [ ] Crear `useDenominaciones.js`
- [ ] Crear `useMovimientosCaja.js`

### Fase 3: Frontend - Componentes (2 días)
- [ ] Crear `DenominacionesTable.jsx`
- [ ] Crear `ResumenVentasPorMetodo.jsx`
- [ ] Crear `ModalDetalleVentas.jsx`
- [ ] Crear `CajaEstadoBadge.jsx`

### Fase 4: Frontend - Columnas (1 día)
- [ ] Crear `cajasColumns.jsx`
- [ ] Crear `movimientosCajaColumns.jsx`
- [ ] Crear `arqueosColumns.jsx`

### Fase 5: Frontend - Pantallas (3 días)
- [ ] Crear `CajasList.jsx`
- [ ] Crear `CajaAbiertaDetail.jsx`
- [ ] Crear `ArqueosHistoricoList.jsx`

### Fase 6: Frontend - Modales (2 días)
- [ ] Crear `CajaAperturaModal.jsx`
- [ ] Crear `CajaCierreModal.jsx`
- [ ] Crear `CajaResumenCierreModal.jsx`
- [ ] Crear `CajaValidacionModal.jsx`

### Fase 7: Integración (1 día)
- [ ] Integrar con Ventas
- [ ] Verificar flujo completo

### Fase 8: Testing (1-2 días)
- [ ] Tests unitarios
- [ ] Tests de integración
- [ ] Pruebas manuales

---

## 📊 Timeline Estimado

| Fase | Duración | Inicio | Fin |
|------|----------|--------|-----|
| Fase 1: Backend | 1-2 días | - | - |
| Fase 2: Hooks | 1 día | - | - |
| Fase 3: Componentes | 2 días | - | - |
| Fase 4: Columnas | 1 día | - | - |
| Fase 5: Pantallas | 3 días | - | - |
| Fase 6: Modales | 2 días | - | - |
| Fase 7: Integración | 1 día | - | - |
| Fase 8: Testing | 1-2 días | - | - |
| **TOTAL** | **12-16 días** | - | - |

---

## 🚀 Cómo Empezar

1. **Lee el documento de mapeo:** `CAJA_MAPEO_EXISTENTE.md`
2. **Entiende el estado actual:** Tablas, modelos, controller, rutas
3. **Comienza con Paso 1:** Agregar métodos faltantes
4. **Sigue el orden:** No saltes pasos
5. **Usa la documentación:** Consulta `CAJA_REFERENCIA_RAPIDA.md` durante desarrollo

---

## 📞 Preguntas Frecuentes

### ¿Por dónde empiezo?
→ Por el Paso 1: Agregar métodos faltantes al CajaController

### ¿Cuánto tiempo toma?
→ Aproximadamente 12-16 días según el plan

### ¿Necesito crear migraciones?
→ No, las tablas ya existen

### ¿Necesito crear modelos?
→ No, los modelos ya existen

### ¿Necesito crear el controller?
→ No, el controller existe. Solo necesitas agregar 2 métodos

### ¿Necesito crear rutas?
→ No, las rutas ya existen. Solo necesitas agregar 2 rutas

---

## 📚 Documentos de Referencia

- `REQUERIMIENTOS_FINANZAS.md` - Requerimientos completos
- `CAJA_UI_ESPECIFICACIONES.md` - Mockups de UI
- `CAJA_ESPECIFICACIONES_BD.md` - Esquema de BD
- `CAJA_REFERENCIA_RAPIDA.md` - Endpoints y payloads
- `CAJA_RESUMEN_VISUAL.md` - Diagramas y flujos
- `CAJA_MAPEO_EXISTENTE.md` - Estado actual

