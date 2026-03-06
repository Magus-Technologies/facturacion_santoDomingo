import { Eye, LogOut, CheckCircle, XCircle, PlayCircle } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { usePermissions } from '@/hooks/usePermissions';
import CajaEstadoBadge from '../components/CajaEstadoBadge';

export const getCajasColumns = ({ handleVerDetalle, handleCerrar, handleAutorizar, handleRechazar, handleAbrirCaja, handleActivarCaja }) => {
    const { hasPermission } = usePermissions();

    return [
        {
            accessorKey: 'nombre',
            header: 'Caja',
            cell: ({ row }) => (
                <div>
                    <p className="font-semibold text-gray-900">{row.original.nombre || `Caja #${row.original.id_caja}`}</p>
                    {row.original.descripcion && (
                        <p className="text-xs text-gray-400">{row.original.descripcion}</p>
                    )}
                </div>
            ),
        },
        {
            accessorKey: 'responsable.name',
            header: 'Responsable',
            cell: ({ row }) => (
                <span className="text-sm text-gray-700">{row.original.responsable?.name || '—'}</span>
            ),
        },
        {
            accessorKey: 'estado',
            header: 'Estado',
            cell: ({ row }) => <CajaEstadoBadge estado={row.original.estado} />,
        },
        {
            accessorKey: 'saldo_inicial',
            header: 'Apertura',
            cell: ({ row }) => (
                <span className="font-mono text-sm">
                    {row.original.saldo_inicial != null
                        ? `S/. ${parseFloat(row.original.saldo_inicial).toFixed(2)}`
                        : '—'}
                </span>
            ),
        },
        {
            accessorKey: 'saldo_final_real',
            header: 'Cierre',
            cell: ({ row }) => (
                <span className="font-mono text-sm">
                    {row.original.saldo_final_real ? `S/. ${parseFloat(row.original.saldo_final_real).toFixed(2)}` : '—'}
                </span>
            ),
        },
        {
            accessorKey: 'diferencia',
            header: 'Diferencia',
            cell: ({ row }) => {
                const diff = row.original.diferencia;
                if (diff == null) return <span className="text-gray-400">—</span>;
                const color = Math.abs(diff) < 0.01 ? 'text-green-600' : diff > 0 ? 'text-blue-600' : 'text-red-600';
                return <span className={`font-mono text-sm ${color}`}>S/. {parseFloat(diff).toFixed(2)}</span>;
            },
        },
        {
            id: 'acciones',
            header: 'Acciones',
            enableSorting: false,
            cell: ({ row }) => {
                const caja = row.original;
                const isInactiva = caja.estado === 'Inactiva';
                const isAbierta = caja.estado === 'Abierta';
                const isPendiente = caja.estado === 'Pendiente Autorización';

                return (
                    <div className="flex items-center gap-2">
                        {hasPermission('caja.view') && (
                            <Button
                                variant="ghost"
                                size="sm"
                                onClick={() => handleVerDetalle(caja)}
                                title="Ver detalle"
                                className="hover:bg-blue-50"
                            >
                                <Eye className="h-4 w-4 text-primary-600" />
                            </Button>
                        )}

                        {isInactiva && (
                            <Button
                                variant="ghost"
                                size="sm"
                                onClick={() => handleActivarCaja(caja)}
                                title="Habilitar caja"
                                className="hover:bg-green-50"
                            >
                                <PlayCircle className="h-4 w-4 text-green-600 opacity-50" />
                            </Button>
                        )}

                        {caja.estado === 'Cerrada' && (
                            <Button
                                variant="ghost"
                                size="sm"
                                onClick={() => handleAbrirCaja(caja)}
                                title="Aperturar caja"
                                className="hover:bg-green-50"
                            >
                                <PlayCircle className="h-4 w-4 text-green-600" />
                            </Button>
                        )}

                        {isAbierta && hasPermission('caja.cerrar') && (
                            <Button
                                variant="ghost"
                                size="sm"
                                onClick={() => handleCerrar(caja)}
                                title="Cerrar caja"
                                className="hover:bg-orange-50"
                            >
                                <LogOut className="h-4 w-4 text-orange-600" />
                            </Button>
                        )}

                        {isPendiente && hasPermission('caja.autorizar') && (
                            <>
                                <Button
                                    variant="ghost"
                                    size="sm"
                                    onClick={() => handleAutorizar(caja)}
                                    title="Autorizar"
                                    className="hover:bg-green-50"
                                >
                                    <CheckCircle className="h-4 w-4 text-green-600" />
                                </Button>
                                <Button
                                    variant="ghost"
                                    size="sm"
                                    onClick={() => handleRechazar(caja)}
                                    title="Rechazar"
                                    className="hover:bg-red-50"
                                >
                                    <XCircle className="h-4 w-4 text-red-600" />
                                </Button>
                            </>
                        )}
                    </div>
                );
            },
        },
    ];
};
