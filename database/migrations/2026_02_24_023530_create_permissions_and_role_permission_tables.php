<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Tabla de permisos
        Schema::create('permissions', function (Blueprint $table) {
            $table->id('permission_id');
            $table->string('name', 100)->unique(); // Ej: 'ventas.create', 'productos.delete'
            $table->string('display_name', 100); // Ej: 'Crear Ventas'
            $table->string('module', 50); // Ej: 'ventas', 'productos', 'clientes'
            $table->string('action', 50); // Ej: 'view', 'create', 'edit', 'delete'
            $table->text('description')->nullable();
            $table->timestamps();
            
            $table->index('module');
            $table->index('action');
        });

        // Tabla pivot: roles y permisos
        Schema::create('role_permission', function (Blueprint $table) {
            $table->id();
            $table->integer('rol_id'); // Sin unsigned para coincidir con roles.rol_id
            $table->unsignedBigInteger('permission_id');
            $table->timestamps();

            $table->foreign('rol_id')->references('rol_id')->on('roles')->onDelete('cascade');
            $table->foreign('permission_id')->references('permission_id')->on('permissions')->onDelete('cascade');
            
            $table->unique(['rol_id', 'permission_id']);
        });

        // Insertar permisos básicos
        $this->insertDefaultPermissions();
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('role_permission');
        Schema::dropIfExists('permissions');
    }

    /**
     * Insertar permisos por defecto
     */
    private function insertDefaultPermissions()
    {
        $modules = [
            'ventas' => 'Ventas',
            'productos' => 'Productos',
            'clientes' => 'Clientes',
            'proveedores' => 'Proveedores',
            'compras' => 'Compras',
            'cotizaciones' => 'Cotizaciones',
            'empresas' => 'Empresas',
            'usuarios' => 'Usuarios',
            'reportes' => 'Reportes',
        ];

        $actions = [
            'view' => 'Ver',
            'create' => 'Crear',
            'edit' => 'Editar',
            'delete' => 'Eliminar',
        ];

        $permissions = [];
        $now = now();

        foreach ($modules as $moduleKey => $moduleName) {
            foreach ($actions as $actionKey => $actionName) {
                $permissions[] = [
                    'name' => "{$moduleKey}.{$actionKey}",
                    'display_name' => "{$actionName} {$moduleName}",
                    'module' => $moduleKey,
                    'action' => $actionKey,
                    'description' => "Permiso para {$actionName} en el módulo de {$moduleName}",
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }
        }

        DB::table('permissions')->insert($permissions);
    }
};
