import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { useEffect } from 'react';
import { baseUrl } from '@/lib/baseUrl';

/**
 * Store global de permisos usando Zustand
 */
export const usePermissionsStore = create(
    persist(
        (set, get) => ({
            permissions: [],
            loading: false,
            lastUpdate: null,
            
            setPermissions: (permissions) => set({ 
                permissions,
                lastUpdate: Date.now()
            }),
            
            hasPermission: (permission) => {
                const { permissions } = get();
                return permissions.includes(permission);
            },
            
            hasAnyPermission: (permissionArray) => {
                const { permissions } = get();
                return permissionArray.some(p => permissions.includes(p));
            },
            
            hasAllPermissions: (permissionArray) => {
                const { permissions } = get();
                return permissionArray.every(p => permissions.includes(p));
            },
            
            canView: (module) => {
                return get().hasPermission(`${module}.view`);
            },
            
            canCreate: (module) => {
                return get().hasPermission(`${module}.create`);
            },
            
            canEdit: (module) => {
                return get().hasPermission(`${module}.edit`);
            },
            
            canDelete: (module) => {
                return get().hasPermission(`${module}.delete`);
            },
            
            clearPermissions: () => set({ permissions: [], lastUpdate: null }),
        }),
        {
            name: 'permissions-storage',
        }
    )
);

/**
 * Hook para cargar permisos del usuario
 */
export const useLoadPermissions = () => {
    const { setPermissions, permissions } = usePermissionsStore();

    const loadPermissions = async () => {
        try {
            const token = localStorage.getItem('auth_token');
            if (!token) return;

            const response = await fetch(baseUrl('/api/permissions/user'), {
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Accept': 'application/json',
                },
            });

            const data = await response.json();
            
            if (data.success) {
                setPermissions(data.permissions);
                return true;
            }
            return false;
        } catch (error) {
            console.error('Error al cargar permisos:', error);
            return false;
        }
    };

    return { loadPermissions, permissions };
};

/**
 * Hook para verificar y recargar permisos periódicamente
 */
export const usePermissionsSync = (intervalMs = 30000) => {
    const { loadPermissions } = useLoadPermissions();

    useEffect(() => {
        let previousPermissions = JSON.stringify(usePermissionsStore.getState().permissions);
        
        // Verificar permisos cada X segundos
        const interval = setInterval(async () => {
            await loadPermissions();
            const currentPermissions = JSON.stringify(usePermissionsStore.getState().permissions);
            
            // Si los permisos cambiaron, recargar la página
            if (currentPermissions !== previousPermissions) {
                console.log('Permisos actualizados, recargando página...');
                window.location.reload();
            }
        }, intervalMs);

        return () => clearInterval(interval);
    }, [intervalMs, loadPermissions]);
};

/**
 * Hook principal para usar permisos en componentes
 */
export const usePermissions = () => {
    const store = usePermissionsStore();
    
    return {
        permissions: store.permissions,
        hasPermission: store.hasPermission,
        hasAnyPermission: store.hasAnyPermission,
        hasAllPermissions: store.hasAllPermissions,
        canView: store.canView,
        canCreate: store.canCreate,
        canEdit: store.canEdit,
        canDelete: store.canDelete,
    };
};
