<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Permission;
use App\Models\Rol;
use Illuminate\Http\Request;

class PermissionController extends Controller
{
    /**
     * Obtener todos los permisos agrupados por módulo
     */
    public function index()
    {
        try {
            $permissions = Permission::orderBy('module')->orderBy('action')->get();
            
            // Agrupar por módulo
            $grouped = $permissions->groupBy('module')->map(function ($items, $module) {
                return [
                    'module' => $module,
                    'module_name' => $items->first()->display_name,
                    'permissions' => $items->map(function ($permission) {
                        return [
                            'id' => $permission->permission_id,
                            'name' => $permission->name,
                            'display_name' => $permission->display_name,
                            'action' => $permission->action,
                        ];
                    })->values()
                ];
            })->values();

            return response()->json([
                'success' => true,
                'data' => $grouped
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener permisos: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Obtener permisos del usuario autenticado
     */
    public function getUserPermissions(Request $request)
    {
        try {
            $user = $request->user();
            
            // Admin tiene todos los permisos automáticamente
            if ($user->rol_id == 1) {
                $permissions = Permission::pluck('name')->toArray();
                return response()->json([
                    'success' => true,
                    'permissions' => $permissions
                ]);
            }
            
            if (!$user->rol) {
                return response()->json([
                    'success' => true,
                    'permissions' => []
                ]);
            }

            $permissions = $user->rol->permissions->pluck('name')->toArray();

            return response()->json([
                'success' => true,
                'permissions' => $permissions
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener permisos del usuario: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Obtener permisos de un rol específico
     */
    public function getRolePermissions($rolId)
    {
        try {
            $rol = Rol::with('permissions')->findOrFail($rolId);
            
            $permissions = $rol->permissions->pluck('permission_id')->toArray();

            return response()->json([
                'success' => true,
                'data' => [
                    'rol_id' => $rol->rol_id,
                    'rol_name' => $rol->nombre,
                    'permissions' => $permissions
                ]
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener permisos del rol: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Actualizar permisos de un rol
     */
    public function updateRolePermissions(Request $request, $rolId)
    {
        try {
            $validated = $request->validate([
                'permissions' => 'required|array',
                'permissions.*' => 'exists:permissions,permission_id'
            ]);

            $rol = Rol::findOrFail($rolId);
            
            // Sincronizar permisos (elimina los antiguos y agrega los nuevos)
            $rol->permissions()->sync($validated['permissions']);

            return response()->json([
                'success' => true,
                'message' => 'Permisos actualizados correctamente',
                'should_reload' => true // Indicar que se deben recargar permisos
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar permisos: ' . $e->getMessage()
            ], 500);
        }
    }
}
