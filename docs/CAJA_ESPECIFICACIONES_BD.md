# Especificaciones Técnicas - Base de Datos Módulo de Caja

## 1. TABLAS PRINCIPALES

### 1.1 Tabla: `cajas`

```sql
CREATE TABLE cajas (
    id_caja BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_empresa BIGINT UNSIGNED NOT NULL,
    id_usuario BIGINT UNSIGNED NOT NULL,
    id_usuario_validacion BIGINT UNSIGNED NULLABLE,
    
    -- Apertura
    saldo_inicial DECIMAL(12, 2) NOT NULL,
    tipo_apertura ENUM('monto_fijo', 'billetes') NOT NULL DEFAULT 'monto_fijo',
    fecha_apertura DATETIME NOT NULL,
    
    -- Cierre
    saldo_final DECIMAL(12, 2) NULLABLE,
    tipo_cierre ENUM('monto_fijo', 'billetes') NULLABLE,
    fecha_cierre DATETIME NULLABLE,
    
    -- Cálculos
    total_teorico DECIMAL(12, 2) NULLABLE,
    total_real DECIMAL(12, 2) NULLABLE,
    diferencia DECIMAL(12, 2) NULLABLE,
    tipo_diferencia ENUM('exacto', 'sobrante', 'faltante') NULLABLE,
    
    -- Estado
    estado ENUM('abierta', 'cerrada', 'pendiente_validacion') NOT NULL DEFAULT 'abierta',
    
    -- Observaciones
    observaciones_cierre TEXT NULLABLE,
    observaciones_validacion TEXT NULLABLE,
    
    -- Auditoría
    fecha_validacion DATETIME NULLABLE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULLABLE,
    
    -- Índices
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa),
    FOREIGN KEY (id_usuario) REFERENCES users(id),
    FOREIGN KEY (id_usuario_validacion) REFERENCES users(id),
    INDEX idx_empresa_usuario (id_empresa, id_usuario),
    INDEX idx_estado (estado),
    INDEX idx_fecha_apertura (fecha_apertura),
    INDEX idx_usuario_validacion (id_usuario_validacion)
);
```

### 1.2 Tabla: `apertura_caja_billetes`

Guarda el desglose de billetes en la apertura.

```sql
CREATE TABLE apertura_caja_billetes (
    id_apertura_billete BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_caja BIGINT UNSIGNED NOT NULL,
    id_denominacion BIGINT UNSIGNED NOT NULL,
    
    cantidad INT UNSIGNED NOT NULL DEFAULT 0,
    subtotal DECIMAL(12, 2) NOT NULL DEFAULT 0,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_caja) REFERENCES cajas(id_caja) ON DELETE CASCADE,
    FOREIGN KEY (id_denominacion) REFERENCES denominaciones_billetes(id_denominacion),
    INDEX idx_caja (id_caja)
);
```

### 1.3 Tabla: `cierre_caja_billetes`

Guarda el desglose de billetes en el cierre.

```sql
CREATE TABLE cierre_caja_billetes (
    id_cierre_billete BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_caja BIGINT UNSIGNED NOT NULL,
    id_denominacion BIGINT UNSIGNED NOT NULL,
    
    cantidad INT UNSIGNED NOT NULL DEFAULT 0,
    subtotal DECIMAL(12, 2) NOT NULL DEFAULT 0,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_caja) REFERENCES cajas(id_caja) ON DELETE CASCADE,
    FOREIGN KEY (id_denominacion) REFERENCES denominaciones_billetes(id_denominacion),
    INDEX idx_caja (id_caja)
);
```

### 1.4 Tabla: `movimientos_caja`

Registra todos los movimientos (ingresos/egresos) de la caja.

```sql
CREATE TABLE movimientos_caja (
    id_movimiento BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_caja BIGINT UNSIGNED NOT NULL,
    id_usuario BIGINT UNSIGNED NOT NULL,
    
    tipo ENUM('ingreso', 'egreso') NOT NULL,
    concepto VARCHAR(255) NOT NULL,
    monto DECIMAL(12, 2) NOT NULL,
    
    -- Referencia a documento
    tipo_referencia VARCHAR(50) NULLABLE, -- 'venta', 'compra', 'manual', etc.
    id_referencia BIGINT UNSIGNED NULLABLE,
    numero_operacion VARCHAR(50) NULLABLE,
    
    descripcion TEXT NULLABLE,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_caja) REFERENCES cajas(id_caja) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES users(id),
    INDEX idx_caja (id_caja),
    INDEX idx_tipo (tipo),
    INDEX idx_referencia (tipo_referencia, id_referencia)
);
```

### 1.5 Tabla: `denominaciones_billetes`

Catálogo de denominaciones de billetes y monedas.

```sql
CREATE TABLE denominaciones_billetes (
    id_denominacion BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    
    nombre VARCHAR(100) NOT NULL,
    valor DECIMAL(8, 2) NOT NULL,
    tipo ENUM('billete', 'moneda') NOT NULL,
    moneda VARCHAR(3) NOT NULL DEFAULT 'PEN', -- PEN, USD, etc.
    
    activo BOOLEAN DEFAULT TRUE,
    orden INT UNSIGNED DEFAULT 0,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    UNIQUE KEY unique_valor_moneda (valor, moneda),
    INDEX idx_moneda (moneda),
    INDEX idx_activo (activo)
);
```

### 1.6 Tabla: `arqueos_diarios`

Histórico de arqueos (se crea cuando se valida un cierre).

```sql
CREATE TABLE arqueos_diarios (
    id_arqueo BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_caja BIGINT UNSIGNED NOT NULL,
    id_empresa BIGINT UNSIGNED NOT NULL,
    
    fecha_arqueo DATE NOT NULL,
    usuario_cierre BIGINT UNSIGNED NOT NULL,
    usuario_validacion BIGINT UNSIGNED NOT NULL,
    
    -- Montos
    saldo_inicial DECIMAL(12, 2) NOT NULL,
    total_ventas DECIMAL(12, 2) NOT NULL,
    total_ingresos_manuales DECIMAL(12, 2) NOT NULL DEFAULT 0,
    total_egresos DECIMAL(12, 2) NOT NULL DEFAULT 0,
    total_teorico DECIMAL(12, 2) NOT NULL,
    total_real DECIMAL(12, 2) NOT NULL,
    diferencia DECIMAL(12, 2) NOT NULL,
    tipo_diferencia ENUM('exacto', 'sobrante', 'faltante') NOT NULL,
    
    -- Desglose de ventas por método (JSON)
    ventas_por_metodo JSON NOT NULL,
    
    -- Estado
    estado ENUM('cerrada', 'rechazada') NOT NULL DEFAULT 'cerrada',
    observaciones TEXT NULLABLE,
    
    -- Auditoría
    fecha_cierre DATETIME NOT NULL,
    fecha_validacion DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_caja) REFERENCES cajas(id_caja),
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa),
    FOREIGN KEY (usuario_cierre) REFERENCES users(id),
    FOREIGN KEY (usuario_validacion) REFERENCES users(id),
    INDEX idx_empresa_fecha (id_empresa, fecha_arqueo),
    INDEX idx_usuario_cierre (usuario_cierre),
    INDEX idx_usuario_validacion (usuario_validacion)
);
```

### 1.7 Tabla: `auditoria_caja`

Registro de auditoría de todas las acciones en cajas.

```sql
CREATE TABLE auditoria_caja (
    id_auditoria BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_caja BIGINT UNSIGNED NOT NULL,
    id_usuario BIGINT UNSIGNED NOT NULL,
    
    accion VARCHAR(100) NOT NULL, -- 'apertura', 'cierre', 'validacion', 'rechazo', etc.
    descripcion TEXT NULLABLE,
    
    -- Datos antes y después (JSON)
    datos_anteriores JSON NULLABLE,
    datos_nuevos JSON NULLABLE,
    
    -- Información de la solicitud
    ip_address VARCHAR(45) NULLABLE,
    user_agent TEXT NULLABLE,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_caja) REFERENCES cajas(id_caja) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES users(id),
    INDEX idx_caja (id_caja),
    INDEX idx_usuario (id_usuario),
    INDEX idx_accion (accion),
    INDEX idx_fecha (created_at)
);
```

---

## 2. DATOS INICIALES

### 2.1 Denominaciones de Billetes (PEN)

```sql
INSERT INTO denominaciones_billetes (nombre, valor, tipo, moneda, orden) VALUES
('Billete S/. 200', 200.00, 'billete', 'PEN', 1),
('Billete S/. 100', 100.00, 'billete', 'PEN', 2),
('Billete S/. 50', 50.00, 'billete', 'PEN', 3),
('Billete S/. 20', 20.00, 'billete', 'PEN', 4),
('Billete S/. 10', 10.00, 'billete', 'PEN', 5),
('Billete S/. 5', 5.00, 'billete', 'PEN', 6),
('Billete S/. 2', 2.00, 'billete', 'PEN', 7),
('Billete S/. 1', 1.00, 'billete', 'PEN', 8),
('Moneda S/. 0.50', 0.50, 'moneda', 'PEN', 9),
('Moneda S/. 0.20', 0.20, 'moneda', 'PEN', 10),
('Moneda S/. 0.10', 0.10, 'moneda', 'PEN', 11),
('Moneda S/. 0.05', 0.05, 'moneda', 'PEN', 12);
```

### 2.2 Denominaciones de Billetes (USD)

```sql
INSERT INTO denominaciones_billetes (nombre, valor, tipo, moneda, orden) VALUES
('Billete $ 100', 100.00, 'billete', 'USD', 1),
('Billete $ 50', 50.00, 'billete', 'USD', 2),
('Billete $ 20', 20.00, 'billete', 'USD', 3),
('Billete $ 10', 10.00, 'billete', 'USD', 4),
('Billete $ 5', 5.00, 'billete', 'USD', 5),
('Billete $ 1', 1.00, 'billete', 'USD', 6);
```

---

## 3. RELACIONES CON OTRAS TABLAS

### 3.1 Relación: Caja ↔ Venta

Cuando se crea una venta:
1. Se registra automáticamente un movimiento de ingreso en `movimientos_caja`
2. El movimiento tiene:
   - `tipo_referencia` = 'venta'
   - `id_referencia` = id de la venta
   - `tipo` = 'ingreso'
   - `monto` = monto de la venta

### 3.2 Relación: Caja ↔ Método de Pago

En el resumen de cierre, se agrupan los movimientos por método de pago:
- Se consultan todos los movimientos de tipo 'ingreso' de la caja
- Se agrupan por el método de pago de la venta relacionada
- Se calcula el total por método

### 3.3 Relación: Caja ↔ Usuario

- `id_usuario`: Usuario que abrió la caja
- `id_usuario_validacion`: Usuario que validó el cierre

---

## 4. VISTAS (OPCIONAL)

### 4.1 Vista: `v_resumen_caja_diaria`

```sql
CREATE VIEW v_resumen_caja_diaria AS
SELECT
    c.id_caja,
    c.id_empresa,
    c.id_usuario,
    u.name as usuario_nombre,
    c.fecha_apertura,
    c.saldo_inicial,
    COALESCE(SUM(CASE WHEN mc.tipo = 'ingreso' THEN mc.monto ELSE 0 END), 0) as total_ingresos,
    COALESCE(SUM(CASE WHEN mc.tipo = 'egreso' THEN mc.monto ELSE 0 END), 0) as total_egresos,
    c.saldo_inicial + COALESCE(SUM(CASE WHEN mc.tipo = 'ingreso' THEN mc.monto ELSE 0 END), 0) - COALESCE(SUM(CASE WHEN mc.tipo = 'egreso' THEN mc.monto ELSE 0 END), 0) as total_teorico,
    c.saldo_final,
    c.diferencia,
    c.tipo_diferencia,
    c.estado
FROM cajas c
LEFT JOIN users u ON c.id_usuario = u.id
LEFT JOIN movimientos_caja mc ON c.id_caja = mc.id_caja
GROUP BY c.id_caja;
```

### 4.2 Vista: `v_ventas_por_metodo_caja`

```sql
CREATE VIEW v_ventas_por_metodo_caja AS
SELECT
    c.id_caja,
    mp.id_metodo_pago,
    mp.nombre as metodo_nombre,
    COUNT(v.id_venta) as cantidad_ventas,
    COALESCE(SUM(v.total), 0) as total_ventas
FROM cajas c
LEFT JOIN movimientos_caja mc ON c.id_caja = mc.id_caja AND mc.tipo = 'ingreso' AND mc.tipo_referencia = 'venta'
LEFT JOIN ventas v ON mc.id_referencia = v.id_venta
LEFT JOIN metodos_pago mp ON v.id_metodo_pago = mp.id_metodo_pago
GROUP BY c.id_caja, mp.id_metodo_pago;
```

---

## 5. ÍNDICES RECOMENDADOS

```sql
-- Búsquedas frecuentes
CREATE INDEX idx_cajas_empresa_fecha ON cajas(id_empresa, fecha_apertura DESC);
CREATE INDEX idx_cajas_usuario_estado ON cajas(id_usuario, estado);
CREATE INDEX idx_movimientos_caja_tipo ON movimientos_caja(id_caja, tipo);
CREATE INDEX idx_arqueos_empresa_fecha ON arqueos_diarios(id_empresa, fecha_arqueo DESC);

-- Auditoría
CREATE INDEX idx_auditoria_caja_fecha ON auditoria_caja(id_caja, created_at DESC);
```

---

## 6. PROCEDIMIENTOS ALMACENADOS (OPCIONAL)

### 6.1 Procedimiento: Calcular Resumen de Caja

```sql
DELIMITER //

CREATE PROCEDURE sp_calcular_resumen_caja(
    IN p_id_caja BIGINT UNSIGNED
)
BEGIN
    DECLARE v_total_ingresos DECIMAL(12, 2);
    DECLARE v_total_egresos DECIMAL(12, 2);
    DECLARE v_total_teorico DECIMAL(12, 2);
    
    -- Calcular totales
    SELECT
        COALESCE(SUM(CASE WHEN tipo = 'ingreso' THEN monto ELSE 0 END), 0),
        COALESCE(SUM(CASE WHEN tipo = 'egreso' THEN monto ELSE 0 END), 0)
    INTO v_total_ingresos, v_total_egresos
    FROM movimientos_caja
    WHERE id_caja = p_id_caja;
    
    -- Calcular total teórico
    SELECT saldo_inicial INTO v_total_teorico FROM cajas WHERE id_caja = p_id_caja;
    SET v_total_teorico = v_total_teorico + v_total_ingresos - v_total_egresos;
    
    -- Actualizar caja
    UPDATE cajas
    SET total_teorico = v_total_teorico
    WHERE id_caja = p_id_caja;
END //

DELIMITER ;
```

### 6.2 Procedimiento: Registrar Arqueo Diario

```sql
DELIMITER //

CREATE PROCEDURE sp_registrar_arqueo_diario(
    IN p_id_caja BIGINT UNSIGNED,
    IN p_id_usuario_validacion BIGINT UNSIGNED,
    IN p_observaciones TEXT
)
BEGIN
    DECLARE v_id_empresa BIGINT UNSIGNED;
    DECLARE v_id_usuario BIGINT UNSIGNED;
    DECLARE v_saldo_inicial DECIMAL(12, 2);
    DECLARE v_total_ventas DECIMAL(12, 2);
    DECLARE v_total_ingresos DECIMAL(12, 2);
    DECLARE v_total_egresos DECIMAL(12, 2);
    DECLARE v_total_teorico DECIMAL(12, 2);
    DECLARE v_total_real DECIMAL(12, 2);
    DECLARE v_diferencia DECIMAL(12, 2);
    DECLARE v_tipo_diferencia VARCHAR(20);
    DECLARE v_fecha_cierre DATETIME;
    
    -- Obtener datos de la caja
    SELECT id_empresa, id_usuario, saldo_inicial, total_teorico, saldo_final, fecha_cierre
    INTO v_id_empresa, v_id_usuario, v_saldo_inicial, v_total_teorico, v_total_real, v_fecha_cierre
    FROM cajas
    WHERE id_caja = p_id_caja;
    
    -- Calcular diferencia
    SET v_diferencia = v_total_real - v_total_teorico;
    
    -- Determinar tipo de diferencia
    IF v_diferencia = 0 THEN
        SET v_tipo_diferencia = 'exacto';
    ELSEIF v_diferencia > 0 THEN
        SET v_tipo_diferencia = 'sobrante';
    ELSE
        SET v_tipo_diferencia = 'faltante';
    END IF;
    
    -- Calcular totales de ventas e ingresos/egresos
    SELECT
        COALESCE(SUM(CASE WHEN tipo = 'ingreso' AND tipo_referencia = 'venta' THEN monto ELSE 0 END), 0),
        COALESCE(SUM(CASE WHEN tipo = 'ingreso' AND tipo_referencia != 'venta' THEN monto ELSE 0 END), 0),
        COALESCE(SUM(CASE WHEN tipo = 'egreso' THEN monto ELSE 0 END), 0)
    INTO v_total_ventas, v_total_ingresos, v_total_egresos
    FROM movimientos_caja
    WHERE id_caja = p_id_caja;
    
    -- Insertar arqueo
    INSERT INTO arqueos_diarios (
        id_caja, id_empresa, fecha_arqueo, usuario_cierre, usuario_validacion,
        saldo_inicial, total_ventas, total_ingresos_manuales, total_egresos,
        total_teorico, total_real, diferencia, tipo_diferencia,
        ventas_por_metodo, estado, observaciones, fecha_cierre, fecha_validacion
    ) VALUES (
        p_id_caja, v_id_empresa, CURDATE(), v_id_usuario, p_id_usuario_validacion,
        v_saldo_inicial, v_total_ventas, v_total_ingresos, v_total_egresos,
        v_total_teorico, v_total_real, v_diferencia, v_tipo_diferencia,
        '{}', 'cerrada', p_observaciones, v_fecha_cierre, NOW()
    );
    
    -- Actualizar estado de caja
    UPDATE cajas
    SET estado = 'cerrada', id_usuario_validacion = p_id_usuario_validacion, fecha_validacion = NOW()
    WHERE id_caja = p_id_caja;
END //

DELIMITER ;
```

---

## 7. MIGRACIONES LARAVEL

### 7.1 Migración: Crear Tabla Cajas

```php
// database/migrations/YYYY_MM_DD_HHMMSS_create_cajas_table.php

Schema::create('cajas', function (Blueprint $table) {
    $table->id('id_caja');
    $table->foreignId('id_empresa')->constrained('empresas', 'id_empresa');
    $table->foreignId('id_usuario')->constrained('users');
    $table->foreignId('id_usuario_validacion')->nullable()->constrained('users');
    
    // Apertura
    $table->decimal('saldo_inicial', 12, 2);
    $table->enum('tipo_apertura', ['monto_fijo', 'billetes'])->default('monto_fijo');
    $table->dateTime('fecha_apertura');
    
    // Cierre
    $table->decimal('saldo_final', 12, 2)->nullable();
    $table->enum('tipo_cierre', ['monto_fijo', 'billetes'])->nullable();
    $table->dateTime('fecha_cierre')->nullable();
    
    // Cálculos
    $table->decimal('total_teorico', 12, 2)->nullable();
    $table->decimal('total_real', 12, 2)->nullable();
    $table->decimal('diferencia', 12, 2)->nullable();
    $table->enum('tipo_diferencia', ['exacto', 'sobrante', 'faltante'])->nullable();
    
    // Estado
    $table->enum('estado', ['abierta', 'cerrada', 'pendiente_validacion'])->default('abierta');
    
    // Observaciones
    $table->text('observaciones_cierre')->nullable();
    $table->text('observaciones_validacion')->nullable();
    
    // Auditoría
    $table->dateTime('fecha_validacion')->nullable();
    $table->timestamps();
    $table->softDeletes();
    
    // Índices
    $table->index(['id_empresa', 'id_usuario']);
    $table->index('estado');
    $table->index('fecha_apertura');
});
```

