import { usePermissions } from "@/hooks/usePermissions";

/**
 * Componente para mostrar/ocultar elementos según permisos
 * 
 * Ejemplos de uso:
 * <PermissionGuard permission="productos.create">
 *   <Button>Crear Producto</Button>
 * </PermissionGuard>
 * 
 * <PermissionGuard permissions={["productos.edit", "productos.delete"]} requireAll={false}>
 *   <Button>Editar o Eliminar</Button>
 * </PermissionGuard>
 */
export function PermissionGuard({ 
    permission, 
    permissions, 
    requireAll = true, 
    fallback = null,
    children 
}) {
    const { hasPermission, hasAnyPermission, hasAllPermissions } = usePermissions();

    let hasAccess = false;

    if (permission) {
        // Verificar un solo permiso
        hasAccess = hasPermission(permission);
    } else if (permissions && Array.isArray(permissions)) {
        // Verificar múltiples permisos
        hasAccess = requireAll 
            ? hasAllPermissions(permissions)
            : hasAnyPermission(permissions);
    }

    if (!hasAccess) {
        return fallback;
    }

    return children;
}

/**
 * Hook para verificar permisos de forma más simple
 */
export function useCanAccess(module) {
    const { canView, canCreate, canEdit, canDelete } = usePermissions();

    return {
        canView: canView(module),
        canCreate: canCreate(module),
        canEdit: canEdit(module),
        canDelete: canDelete(module),
    };
}
