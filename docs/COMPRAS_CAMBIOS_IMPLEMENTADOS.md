# ✅ Cambios Implementados en el Módulo de Compras

## 📋 Resumen

Se corrigió el módulo de compras para que funcione correctamente como un **registro de documentos del proveedor** en lugar de generar documentos propios.

---

## 🔧 Cambios Realizados

### 1. ✅ Nuevo Componente: SelectTipoDocumentoCompra.jsx

**Archivo:** `resources/js/components/ui/SelectTipoDocumentoCompra.jsx`

Selector que permite elegir el tipo de documento del proveedor:
- Factura (01)
- Boleta (03)
- Nota de Crédito (07)
- Nota de Débito (08)
- Guía de Remisión (09)
- Recibo por Honorarios (RH)
- Nota de Compra (NC)

### 2. ✅ Actualizado: CompraSidebar.jsx

**Cambios:**
- ✅ Agregado selector de tipo de documento
- ✅ Campos serie y número ahora son **editables**
- ✅ Agregadas ayudas visuales (placeholders y textos explicativos)
- ✅ Validación de formato en tiempo real:
  - Serie: Solo mayúsculas, máximo 4 caracteres
  - Número: Solo dígitos, máximo 8 caracteres

**Antes:**
```jsx
<Input
    type="text"
    value={formData.serie}
    readOnly  // ❌ No editable
    className="bg-gray-50"
/>
```

**Después:**
```jsx
<Input
    type="text"
    value={formData.serie}
    onChange={(e) => handleChange("serie", e.target.value.toUpperCase())}
    placeholder="Ej: F001"
    maxLength={4}
/>
```

### 3. ✅ Actualizado: useCompraForm.js

**Cambios:**
- ✅ Eliminada función `obtenerProximoNumero()`
- ✅ Eliminada llamada a API para obtener número
- ✅ Campos serie y número inician vacíos
- ✅ Tipo de documento por defecto: Factura (id: 2)

**Antes:**
```javascript
const [formData, setFormData] = useState({
    tipo_doc: '12', // Hardcodeado
    serie: 'OC',    // Hardcodeado
    numero: '',     // Se obtiene de API
});

useEffect(() => {
    if (!isEditing) {
        obtenerProximoNumero(); // ❌ Innecesario
    }
}, []);
```

**Después:**
```javascript
const [formData, setFormData] = useState({
    tipo_doc: '2',  // Factura por defecto
    serie: '',      // Usuario lo ingresa
    numero: '',     // Usuario lo ingresa
});

useEffect(() => {
    if (isEditing) {
        cargarCompra();
    }
    // No se llama a obtenerProximoNumero
}, [compraId]);
```

### 4. ✅ Actualizado: CompraController.php

**Cambios:**
- ✅ Eliminado método `proximoNumero()`
- ✅ Agregada validación de `tipo_doc`
- ✅ Agregada validación de formato de serie (regex)
- ✅ Agregada validación de formato de número (regex)
- ✅ Agregada validación de duplicados por proveedor
- ✅ El `id_tido` ahora viene del frontend

**Validaciones agregadas:**
```php
// Validar formato de serie
if (!preg_match('/^[A-Z0-9]{1,4}$/', $request->serie)) {
    return response()->json([
        'success' => false,
        'message' => 'Serie inválida. Use 1-4 caracteres alfanuméricos'
    ], 400);
}

// Validar formato de número
if (!preg_match('/^[0-9]{1,8}$/', $request->numero)) {
    return response()->json([
        'success' => false,
        'message' => 'Número inválido. Use solo dígitos (máximo 8)'
    ], 400);
}

// Validar duplicados
$existe = Compra::where('id_empresa', $idEmpresa)
    ->where('id_proveedor', $request->id_proveedor)
    ->where('id_tido', $request->tipo_doc)
    ->where('serie', $request->serie)
    ->where('numero', $request->numero)
    ->exists();

if ($existe) {
    return response()->json([
        'success' => false,
        'message' => 'Ya existe una compra registrada con este documento del proveedor'
    ], 400);
}
```

### 5. ✅ Actualizado: routes/api.php

**Cambio:**
- ✅ Eliminada ruta `/api/compras/proximo-numero`

**Antes:**
```php
Route::get('compras/proximo-numero', [CompraController::class, 'proximoNumero']);
Route::get('compras', [CompraController::class, 'index']);
```

**Después:**
```php
Route::get('compras', [CompraController::class, 'index']);
```

---

## 🎯 Resultado Final

### Flujo de Trabajo Correcto:

1. Usuario abre el formulario de compra
2. Selecciona el proveedor
3. **Selecciona el tipo de documento** (Factura, Boleta, etc.)
4. **Ingresa la serie** del documento del proveedor (Ej: F001)
5. **Ingresa el número** del documento del proveedor (Ej: 00001234)
6. Agrega productos
7. Guarda la compra

### Validaciones Implementadas:

✅ Serie: 1-4 caracteres alfanuméricos (A-Z, 0-9)
✅ Número: 1-8 dígitos (0-9)
✅ No permite duplicar el mismo documento del mismo proveedor
✅ Tipo de documento es obligatorio

---

## 📊 Comparación: Antes vs Después

| Aspecto | Antes ❌ | Después ✅ |
|---------|---------|-----------|
| Tipo de documento | Hardcodeado (Nota de Compra) | Seleccionable (7 opciones) |
| Serie | ReadOnly, generada automáticamente | Editable, ingresada por usuario |
| Número | ReadOnly, generado automáticamente | Editable, ingresado por usuario |
| Correlatividad | Intentaba ser correlativo (incorrecto) | No correlativo (correcto) |
| Validación duplicados | No existía | Valida por proveedor + tipo + serie + número |
| Formato | Sin validación | Valida formato con regex |

---

## 🔍 Diferencia Conceptual

### VENTAS (Documentos que TÚ emites):
- ✅ Números correlativos automáticos
- ✅ Serie fija por empresa
- ✅ Control estricto de secuencia
- ✅ Reportes a SUNAT

### COMPRAS (Documentos que RECIBES):
- ✅ Números NO correlativos (son del proveedor)
- ✅ Serie variable (cada proveedor tiene su serie)
- ✅ Solo registro de lo recibido
- ✅ No se reporta a SUNAT

---

## ✅ Testing Recomendado

1. Crear una compra con factura F001-00000001
2. Intentar crear otra compra con la misma factura → Debe rechazar
3. Crear compra con boleta B001-00000001 del mismo proveedor → Debe permitir
4. Intentar ingresar serie con caracteres especiales → Debe rechazar
5. Intentar ingresar número con letras → Debe rechazar

---

## 📝 Notas Adicionales

- Los cambios son **retrocompatibles** con compras existentes
- Las compras antiguas seguirán mostrándose correctamente
- El sistema ahora refleja correctamente el flujo de negocio real
- Se eliminó código innecesario (método proximoNumero)

---

## 🚀 Próximos Pasos Opcionales

1. Agregar índice único en BD para garantizar unicidad a nivel de base de datos
2. Implementar búsqueda de compras por documento del proveedor
3. Agregar reporte de compras por tipo de documento
4. Implementar validación de RUC del proveedor vs tipo de documento
