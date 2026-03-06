<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Permission;

class AddFinanzasPermissions extends Command
{
    protected $signature = 'permissions:add-finanzas';
    protected $description = 'Agrega los permisos faltantes para los submódulos de Finanzas';

    public function handle()
    {
        $this->info('Agregando permisos para submódulos de Finanzas...');

        $permissions = [
            // Bancos
            ['name' => 'bancos.view', 'display_name' => 'Ver Bancos', 'module' => 'bancos', 'action' => 'view'],
            ['name' => 'bancos.create', 'display_name' => 'Crear Bancos', 'module' => 'bancos', 'action' => 'create'],
            ['name' => 'bancos.edit', 'display_name' => 'Editar Bancos', 'module' => 'bancos', 'action' => 'edit'],
            ['name' => 'bancos.delete', 'display_name' => 'Eliminar Bancos', 'module' => 'bancos', 'action' => 'delete'],
            
            // Métodos de Pago
            ['name' => 'metodos-pago.view', 'display_name' => 'Ver Métodos de Pago', 'module' => 'metodos-pago', 'action' => 'view'],
            ['name' => 'metodos-pago.create', 'display_name' => 'Crear Métodos de Pago', 'module' => 'metodos-pago', 'action' => 'create'],
            ['name' => 'metodos-pago.edit', 'display_name' => 'Editar Métodos de Pago', 'module' => 'metodos-pago', 'action' => 'edit'],
            ['name' => 'metodos-pago.delete', 'display_name' => 'Eliminar Métodos de Pago', 'module' => 'metodos-pago', 'action' => 'delete'],
            
            // Caja
            ['name' => 'caja.view', 'display_name' => 'Ver Caja', 'module' => 'caja', 'action' => 'view'],
            ['name' => 'caja.create', 'display_name' => 'Crear Caja', 'module' => 'caja', 'action' => 'create'],
            ['name' => 'caja.edit', 'display_name' => 'Editar Caja', 'module' => 'caja', 'action' => 'edit'],
            ['name' => 'caja.delete', 'display_name' => 'Eliminar Caja', 'module' => 'caja', 'action' => 'delete'],
            ['name' => 'caja.autorizar', 'display_name' => 'Autorizar Cierre de Caja', 'module' => 'caja', 'action' => 'autorizar'],
            
            // Cuentas Bancarias
            ['name' => 'cuentas-bancarias.view', 'display_name' => 'Ver Cuentas Bancarias', 'module' => 'cuentas-bancarias', 'action' => 'view'],
            ['name' => 'cuentas-bancarias.create', 'display_name' => 'Crear Cuentas Bancarias', 'module' => 'cuentas-bancarias', 'action' => 'create'],
            ['name' => 'cuentas-bancarias.edit', 'display_name' => 'Editar Cuentas Bancarias', 'module' => 'cuentas-bancarias', 'action' => 'edit'],
            ['name' => 'cuentas-bancarias.delete', 'display_name' => 'Eliminar Cuentas Bancarias', 'module' => 'cuentas-bancarias', 'action' => 'delete'],
            
            // Banco (alias para cuentas bancarias)
            ['name' => 'banco.view', 'display_name' => 'Ver Banco', 'module' => 'banco', 'action' => 'view'],
            ['name' => 'banco.create', 'display_name' => 'Crear Banco', 'module' => 'banco', 'action' => 'create'],
            ['name' => 'banco.edit', 'display_name' => 'Editar Banco', 'module' => 'banco', 'action' => 'edit'],
            ['name' => 'banco.delete', 'display_name' => 'Eliminar Banco', 'module' => 'banco', 'action' => 'delete'],
        ];

        $created = 0;
        $skipped = 0;

        foreach ($permissions as $perm) {
            $exists = Permission::where('name', $perm['name'])->exists();
            
            if (!$exists) {
                Permission::create([
                    'name' => $perm['name'],
                    'display_name' => $perm['display_name'],
                    'module' => $perm['module'],
                    'action' => $perm['action'],
                    'description' => "Permiso para {$perm['action']} en el módulo de {$perm['display_name']}",
                ]);
                $created++;
                $this->line("✓ Creado: {$perm['name']}");
            } else {
                $skipped++;
            }
        }

        $this->newLine();
        $this->info("✓ Proceso completado:");
        $this->line("  - Permisos creados: {$created}");
        $this->line("  - Permisos existentes: {$skipped}");

        return 0;
    }
}
