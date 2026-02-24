<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Permission;
use Illuminate\Support\Facades\File;

class SyncPermissions extends Command
{
    protected $signature = 'permissions:sync';
    protected $description = 'Sincroniza permisos desde menuModules.json';

    public function handle()
    {
        $this->info('Sincronizando permisos desde menuModules.json...');

        // Leer el archivo JSON
        $jsonPath = resource_path('js/data/menuModules.json');
        
        if (!File::exists($jsonPath)) {
            $this->error('No se encontró el archivo menuModules.json');
            return 1;
        }

        $menuData = json_decode(File::get($jsonPath), true);
        
        if (!isset($menuData['modules'])) {
            $this->error('Formato de JSON inválido');
            return 1;
        }

        $modules = $this->extractModules($menuData['modules']);
        $actions = ['view', 'create', 'edit', 'delete'];
        $actionNames = [
            'view' => 'Ver',
            'create' => 'Crear',
            'edit' => 'Editar',
            'delete' => 'Eliminar',
        ];

        $created = 0;
        $updated = 0;

        foreach ($modules as $moduleId => $moduleName) {
            foreach ($actions as $action) {
                $permissionName = "{$moduleId}.{$action}";
                $displayName = "{$actionNames[$action]} {$moduleName}";

                $permission = Permission::updateOrCreate(
                    ['name' => $permissionName],
                    [
                        'display_name' => $displayName,
                        'module' => $moduleId,
                        'action' => $action,
                        'description' => "Permiso para {$actionNames[$action]} en el módulo de {$moduleName}",
                    ]
                );

                if ($permission->wasRecentlyCreated) {
                    $created++;
                    $this->line("✓ Creado: {$permissionName}");
                } else {
                    $updated++;
                }
            }
        }

        $this->newLine();
        $this->info("✓ Sincronización completada:");
        $this->line("  - Permisos creados: {$created}");
        $this->line("  - Permisos actualizados: {$updated}");
        $this->line("  - Total de módulos: " . count($modules));

        return 0;
    }

    /**
     * Extraer todos los módulos del JSON (incluyendo submódulos)
     */
    private function extractModules($modules, &$result = [])
    {
        foreach ($modules as $module) {
            // Agregar el módulo principal
            if ($module['id'] !== 'dashboard') { // Dashboard no necesita permisos CRUD
                $result[$module['id']] = $module['name'];
            }

            // Si tiene submódulos, procesarlos recursivamente
            if (isset($module['submodules']) && is_array($module['submodules'])) {
                $this->extractModules($module['submodules'], $result);
            }
        }

        return $result;
    }
}
