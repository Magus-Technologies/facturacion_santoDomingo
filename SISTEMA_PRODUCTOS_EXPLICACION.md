# 📦 SISTEMA DE PRODUCTOS Y FACTURACIÓN - EXPLICACIÓN COMPLETA

## 1️⃣ CAMPOS DE PRODUCTOS

Tu tabla `productos` tiene estos campos importantes:

### Identificación del Producto

```
- codigo         → Tu código interno (ej: "PROD-001" o código de China)
- cod_barra      → Código de barras para escaneo
- codsunat       → Código del catálogo SUNAT (obligatorio para facturación)
- nombre         → Nombre corto del producto
- descripcion    → Descripción detallada (SE USA EN FACTURACIÓN)
```

### Stock y Precios

```
- cantidad       → Stock actual disponible
- stock_minimo   → Alerta de stock bajo
- stock_maximo   → Stock máximo recomendado
- precio         → Precio de venta normal
- costo          → Costo de compra
- precio_mayor   → Precio por mayor
- precio_menor   → Precio por menor
- precio2/3/4    → Precios adicionales
```

### Control

```
- almacen        → '1' o '2' (múltiples almacenes)
- ultima_salida  → Última fecha de venta
- fecha_ultimo_ingreso → Última fecha de compra
```

---

## 2️⃣ ¿QUÉ SE USA PARA FACTURACIÓN?

### En el PDF y SUNAT se muestra:

- **Código**: `producto->codigo` (tu código interno o de China)
- **Descripción**: `producto->descripcion` (descripción detallada)
- **Código SUNAT**: `producto->codsunat` (se envía a SUNAT en el XML)

### Ejemplo en el PDF actual:

```
| # | Código      | Producto                           | Cant. | Unidad | P. Unit. | Total   |
|---|-------------|------------------------------------|-------|--------|----------|---------|
| 1 | PROD-CH-001 | Filtro de aceite para motor 2.5L  | 2     | NIU    | 50.00    | 100.00  |
```

---

## 3️⃣ SISTEMA DE CÓDIGOS

### Tu Código Interno (`codigo`)

- **Propósito**: Control interno de tu empresa
- **Ejemplo**: "PROD-001", "CH-12345" (código de China), "REP-FILTRO-01"
- **Uso**: Búsqueda rápida, identificación en almacén
- **¿Se envía a SUNAT?**: NO, solo es para tu gestión

### Código SUNAT (`codsunat`)

- **Propósito**: Clasificación oficial para facturación electrónica
- **Ejemplo**: "51121703" (Repuestos y accesorios para vehículos)
- **Uso**: Obligatorio para XML de facturación electrónica
- **¿Se envía a SUNAT?**: SÍ, en el XML del comprobante

### Código de Barras (`cod_barra`)

- **Propósito**: Escaneo con lector de códigos de barras
- **Ejemplo**: "7501234567890" (EAN-13)
- **Uso**: Agilizar ventas en punto de venta

---

## 4️⃣ FLUJO DE TRABAJO RECOMENDADO

### Al Registrar un Producto Nuevo:

1. **Código Interno** (`codigo`):
    - Si viene de China: usa el código del proveedor (ej: "CH-12345")
    - Si es tuyo: crea tu propio código (ej: "PROD-001")
    - Este código es ÚNICO y te ayuda a identificar el producto

2. **Nombre** (`nombre`):
    - Nombre corto para búsquedas rápidas
    - Ejemplo: "Filtro de aceite"

3. **Descripción** (`descripcion`):
    - Descripción detallada que aparecerá en la factura
    - Ejemplo: "Filtro de aceite para motor diesel 2.5L marca XYZ"

4. **Código SUNAT** (`codsunat`):
    - Busca en el catálogo SUNAT el código que corresponda
    - Por defecto: "51121703" (Repuestos y accesorios)
    - Otros ejemplos:
        - "51121701" - Llantas y neumáticos
        - "51121702" - Baterías para vehículos
        - "51121704" - Aceites y lubricantes

---

## 5️⃣ DESCUENTO DE STOCK

### ✅ AHORA IMPLEMENTADO

Cuando se crea una venta, el sistema automáticamente:

1. **Descuenta el stock**: `cantidad = cantidad - cantidad_vendida`
2. **Actualiza última salida**: `ultima_salida = fecha_actual`

### Código implementado:

```php
// En VentasController::store()
foreach ($validated['productos'] as $producto) {
    // Crear línea de venta
    ProductoVenta::create([...]);

    // Descontar stock automáticamente
    $productoModel = Producto::find($producto['id_producto']);
    $productoModel->decrement('cantidad', $producto['cantidad']);
    $productoModel->update(['ultima_salida' => now()]);
}
```

### ⚠️ IMPORTANTE:

- Si **anulas una venta**, deberías **devolver el stock**
- Si **editas una venta**, deberías **ajustar el stock** (restar lo nuevo, sumar lo viejo)

---

## 6️⃣ CONTROL DUAL: SUNAT + STOCK FÍSICO

Tu sistema maneja **DOS aspectos simultáneamente**:

### 📊 Control de Stock Físico

- Stock actual (`cantidad`)
- Alertas de stock bajo/alto (`stock_minimo`, `stock_maximo`)
- Múltiples almacenes (`almacen = '1' o '2'`)
- Historial de movimientos (`ultima_salida`, `fecha_ultimo_ingreso`)

### 📄 Facturación Electrónica SUNAT

- Código SUNAT (`codsunat`)
- Tipo de afectación IGV (gravado, exonerado, inafecto)
- Unidad de medida SUNAT (`unidad_medida = 'NIU'`)
- Envío de XML/CDR (`ventas_sunat` table)
- Estados de SUNAT (`estado_sunat`, `hash_cpe`, `xml_url`, `cdr_url`)

---

## 7️⃣ CATÁLOGO SUNAT DE PRODUCTOS

Algunos códigos comunes para repuestos:

| Código   | Descripción                       |
| -------- | --------------------------------- |
| 51121701 | Llantas y neumáticos              |
| 51121702 | Baterías para vehículos           |
| 51121703 | Repuestos y accesorios (GENÉRICO) |
| 51121704 | Aceites y lubricantes             |
| 51121705 | Filtros para vehículos            |
| 51121706 | Frenos y componentes              |
| 51121707 | Sistema de escape                 |
| 51121708 | Sistema eléctrico                 |

**Recomendación**: Usa códigos específicos cuando sea posible, no siempre el genérico.

---

## 8️⃣ RESPUESTAS A TUS PREGUNTAS

### ❓ "¿Cuál es el nombre del producto que sirve para la facturación?"

**Respuesta**: Se usa el campo **`descripcion`** porque es más detallado y cumple con los requisitos de SUNAT.

### ❓ "¿El código SUNAT se genera automáticamente?"

**Respuesta**: NO. Debes seleccionarlo del catálogo SUNAT según el tipo de producto. El sistema tiene un valor por defecto ("51121703") pero deberías cambiarlo según corresponda.

### ❓ "A veces uso el código SUNAT, otras veces mi código de China"

**Respuesta**:

- **Código interno** (`codigo`): Usa el que quieras (de China o tuyo)
- **Código SUNAT** (`codsunat`): SIEMPRE debe estar (obligatorio para facturación)
- Son **independientes**: puedes tener tu código de China en `codigo` y el código SUNAT en `codsunat`

### ❓ "¿El stock se descuenta al hacer la venta?"

**Respuesta**: **SÍ, ahora sí**. Acabo de implementar el descuento automático de stock.

---

## 9️⃣ MEJORAS PENDIENTES

### 1. Devolver stock al anular venta

```php
// En VentasController::anular()
foreach ($venta->productosVentas as $item) {
    $producto = Producto::find($item->id_producto);
    $producto->increment('cantidad', $item->cantidad);
}
```

### 2. Validar stock antes de vender

```php
// En VentasController::store()
foreach ($validated['productos'] as $producto) {
    $productoModel = Producto::find($producto['id_producto']);
    if ($productoModel->cantidad < $producto['cantidad']) {
        throw new \Exception("Stock insuficiente para {$productoModel->nombre}");
    }
}
```

### 3. Selector de código SUNAT en el formulario

- Agregar un campo en el formulario de productos
- Mostrar catálogo SUNAT para seleccionar
- Validar que sea un código válido

---

## 🎯 RESUMEN EJECUTIVO

1. ✅ **Código interno** (`codigo`): Usa el de China o el tuyo
2. ✅ **Código SUNAT** (`codsunat`): Obligatorio, del catálogo oficial
3. ✅ **Descripción** (`descripcion`): Se usa en facturación
4. ✅ **Stock se descuenta**: Ahora implementado automáticamente
5. ✅ **Sistema dual**: Controla stock físico Y facturación SUNAT
6. ⚠️ **Pendiente**: Devolver stock al anular, validar stock antes de vender

---

**Fecha**: 27 de enero de 2026
**Sistema**: Factura SAVA - Laravel 12
CREATE UNIQUE INDEX unique_codigo_almacen ON productos (codigo, almacen);
