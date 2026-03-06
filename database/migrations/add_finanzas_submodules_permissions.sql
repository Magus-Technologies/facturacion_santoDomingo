-- Agregar permisos para submódulos de Finanzas

-- Permisos para Bancos
INSERT INTO `permissions` (`name`, `display_name`, `module`, `action`, `description`, `created_at`, `updated_at`) 
VALUES 
('bancos.view', 'Ver Bancos', 'bancos', 'view', 'Permiso para Ver en el módulo de Bancos', NOW(), NOW()),
('bancos.create', 'Crear Bancos', 'bancos', 'create', 'Permiso para Crear en el módulo de Bancos', NOW(), NOW()),
('bancos.edit', 'Editar Bancos', 'bancos', 'edit', 'Permiso para Editar en el módulo de Bancos', NOW(), NOW()),
('bancos.delete', 'Eliminar Bancos', 'bancos', 'delete', 'Permiso para Eliminar en el módulo de Bancos', NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

-- Permisos para Métodos de Pago
INSERT INTO `permissions` (`name`, `display_name`, `module`, `action`, `description`, `created_at`, `updated_at`) 
VALUES 
('metodos-pago.view', 'Ver Métodos de Pago', 'metodos-pago', 'view', 'Permiso para Ver en el módulo de Métodos de Pago', NOW(), NOW()),
('metodos-pago.create', 'Crear Métodos de Pago', 'metodos-pago', 'create', 'Permiso para Crear en el módulo de Métodos de Pago', NOW(), NOW()),
('metodos-pago.edit', 'Editar Métodos de Pago', 'metodos-pago', 'edit', 'Permiso para Editar en el módulo de Métodos de Pago', NOW(), NOW()),
('metodos-pago.delete', 'Eliminar Métodos de Pago', 'metodos-pago', 'delete', 'Permiso para Eliminar en el módulo de Métodos de Pago', NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

-- Permisos para Caja
INSERT INTO `permissions` (`name`, `display_name`, `module`, `action`, `description`, `created_at`, `updated_at`) 
VALUES 
('caja.view', 'Ver Caja', 'caja', 'view', 'Permiso para Ver en el módulo de Caja', NOW(), NOW()),
('caja.create', 'Crear Caja', 'caja', 'create', 'Permiso para Crear en el módulo de Caja', NOW(), NOW()),
('caja.edit', 'Editar Caja', 'caja', 'edit', 'Permiso para Editar en el módulo de Caja', NOW(), NOW()),
('caja.delete', 'Eliminar Caja', 'caja', 'delete', 'Permiso para Eliminar en el módulo de Caja', NOW(), NOW()),
('caja.autorizar', 'Autorizar Cierre de Caja', 'caja', 'autorizar', 'Permiso para Autorizar Cierre en el módulo de Caja', NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_at` = NOW();

-- Permisos para Cuentas Bancarias
INSERT INTO `permissions` (`name`, `display_name`, `module`, `action`, `description`, `created_at`, `updated_at`) 
VALUES 
('cuentas-bancarias.view', 'Ver Cuentas Bancarias', 'cuentas-bancarias', 'view', 'Permiso para Ver en el módulo de Cuentas Bancarias', NOW(), NOW()),
('cuentas-bancarias.create', 'Crear Cuentas Bancarias', 'cuentas-bancarias', 'create', 'Permiso para Crear en el módulo de Cuentas Bancarias', NOW(), NOW()),
('cuentas-bancarias.edit', 'Editar Cuentas Bancarias', 'cuentas-bancarias', 'edit', 'Permiso para Editar en el módulo de Cuentas Bancarias', NOW(), NOW()),
('cuentas-bancarias.delete', 'Eliminar Cuentas Bancarias', 'cuentas-bancarias', 'delete', 'Permiso para Eliminar en el módulo de Cuentas Bancarias', NOW(), NOW()),
('banco.view', 'Ver Banco', 'banco', 'view', 'Permiso para Ver en el módulo de Banco', NOW(), NOW()),
('banco.create', 'Crear Banco', 'banco', 'create', 'Permiso para Crear en el módulo de Banco', NOW(), NOW()),
('banco.edit', 'Editar Banco', 'banco', 'edit', 'Permiso para Editar en el módulo de Banco', NOW(), NOW()),
('banco.delete', 'Eliminar Banco', 'banco', 'delete', 'Permiso para Eliminar en el módulo de Banco', NOW(), NOW())
ON DUPLICATE KEY UPDATE `updated_at` = NOW();
