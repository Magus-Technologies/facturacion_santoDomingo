import { useEffect } from 'react';
import { usePermissions } from '@/hooks/usePermissions';

/**
 * Componente para proteger rutas completas
 * Redirige al dashboard si el usuario no tiene el permiso requerido
 */
export default function ProtectedRoute({ children, permission, redirectTo = '/dashboard' }) {
    const { hasPermission } = usePermissions();

    useEffect(() => {
        // Verificar permiso al montar el componente
        if (permission && !hasPermission(permission)) {
            console.warn(`Acceso denegado: permiso "${permission}" requerido`);
            window.location.href = redirectTo;
        }
    }, [permission, hasPermission, redirectTo]);

    // Si no tiene permiso, mostrar mensaje mientras redirige
    if (permission && !hasPermission(permission)) {
        return (
            <div className="flex items-center justify-center min-h-screen bg-gray-50">
                <div className="text-center">
                    <div className="inline-flex items-center justify-center w-16 h-16 mb-4 bg-red-100 rounded-full">
                        <svg className="w-8 h-8 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                        </svg>
                    </div>
                    <h2 className="text-2xl font-bold text-gray-900 mb-2">Acceso Denegado</h2>
                    <p className="text-gray-600 mb-4">No tienes permisos para acceder a esta página</p>
                    <p className="text-sm text-gray-500">Redirigiendo...</p>
                </div>
            </div>
        );
    }

    return children;
}
