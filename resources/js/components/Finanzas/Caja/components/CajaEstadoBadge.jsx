export default function CajaEstadoBadge({ estado }) {
    const estadoConfig = {
        'Inactiva': {
            bg: 'bg-slate-100',
            text: 'text-slate-600',
            label: 'Inactiva',
        },
        'Abierta': {
            bg: 'bg-green-100',
            text: 'text-green-800',
            label: 'Abierta'
        },
        'Cerrada': {
            bg: 'bg-gray-100',
            text: 'text-gray-800',
            label: 'Cerrada'
        },
        'Pendiente Autorización': {
            bg: 'bg-yellow-100',
            text: 'text-yellow-800',
            label: 'Pendiente'
        },
        'abierta': {
            bg: 'bg-green-100',
            text: 'text-green-800',
            label: 'Abierta'
        },
        'cerrada': {
            bg: 'bg-gray-100',
            text: 'text-gray-800',
            label: 'Cerrada'
        },
        'pendiente_validacion': {
            bg: 'bg-yellow-100',
            text: 'text-yellow-800',
            label: 'Pendiente'
        },
    };

    const config = estadoConfig[estado] || { bg: 'bg-gray-100', text: 'text-gray-600', label: estado || 'Desconocido' };

    return (
        <span className={`inline-flex items-center px-3 py-1 rounded-full text-xs font-medium ${config.bg} ${config.text}`}>
            {config.label}
        </span>
    );
}
