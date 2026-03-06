import { useState, useEffect } from 'react';
import { Modal } from '@/components/ui/modal';
import { Button } from '@/components/ui/button';
import { Loader2, TrendingUp, TrendingDown, DollarSign, Plus } from 'lucide-react';
import { toast } from '@/lib/sweetalert';
import { baseUrl } from '@/lib/baseUrl';
import MovimientoModal from './MovimientoModal';

const fmt = (val) => val != null ? `S/ ${parseFloat(val).toFixed(2)}` : '—';

export default function CajaDetalle({ isOpen, onClose, caja }) {
    const [detalle, setDetalle] = useState(null);
    const [loading, setLoading] = useState(false);
    const [isMovimientoOpen, setIsMovimientoOpen] = useState(false);

    useEffect(() => {
        if (isOpen && caja) fetchDetalle();
    }, [isOpen, caja]);

    const fetchDetalle = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl(`/api/cajas/${caja.id_caja}`), {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
            });
            const data = await res.json();
            if (data.success) setDetalle(data);
            else toast.error(data.message || 'Error al cargar detalle');
        } catch {
            toast.error('Error de conexión');
        } finally {
            setLoading(false);
        }
    };

    const movimientos = detalle?.data?.movimientos ?? [];
    const resumen = detalle?.resumen;

    return (
        <>
            <Modal isOpen={isOpen} onClose={onClose} title={`Detalle de Caja #${caja?.id_caja ?? ''}`} size="xl">
                {loading ? (
                    <div className="flex justify-center py-10">
                        <Loader2 className="h-8 w-8 animate-spin text-primary-600" />
                    </div>
                ) : (
                    <div className="space-y-5">
                        {/* Cabecera con info y botón */}
                        <div className="flex items-center justify-between">
                            <p className="text-sm text-gray-500">Cajero: <span className="font-medium text-gray-700">{caja?.usuario_apertura?.name ?? '—'}</span></p>
                            {caja?.estado === 'Abierta' && (
                                <Button
                                    size="sm"
                                    className="gap-2 bg-primary-600 hover:bg-primary-700 text-white"
                                    onClick={() => setIsMovimientoOpen(true)}
                                >
                                    <Plus className="h-4 w-4" /> Movimiento
                                </Button>
                            )}
                        </div>

                        {/* Resumen */}
                        {resumen && (
                            <div className="grid grid-cols-3 gap-3">
                                <div className="bg-green-50 border border-green-200 rounded-lg p-3 text-center">
                                    <div className="flex items-center justify-center gap-1 text-green-700 mb-1">
                                        <TrendingUp className="h-4 w-4" />
                                        <span className="text-xs font-medium">Ingresos</span>
                                    </div>
                                    <p className="text-lg font-bold text-green-800">{fmt(resumen.total_ingresos)}</p>
                                </div>
                                <div className="bg-red-50 border border-red-200 rounded-lg p-3 text-center">
                                    <div className="flex items-center justify-center gap-1 text-red-700 mb-1">
                                        <TrendingDown className="h-4 w-4" />
                                        <span className="text-xs font-medium">Egresos</span>
                                    </div>
                                    <p className="text-lg font-bold text-red-800">{fmt(resumen.total_egresos)}</p>
                                </div>
                                <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 text-center">
                                    <div className="flex items-center justify-center gap-1 text-blue-700 mb-1">
                                        <DollarSign className="h-4 w-4" />
                                        <span className="text-xs font-medium">Saldo Teórico</span>
                                    </div>
                                    <p className="text-lg font-bold text-blue-800">{fmt(resumen.saldo_teorico)}</p>
                                </div>
                            </div>
                        )}

                        {/* Movimientos */}
                        <div>
                            <h3 className="text-sm font-semibold text-gray-700 mb-2">Movimientos ({movimientos.length})</h3>
                            {movimientos.length === 0 ? (
                                <p className="text-sm text-gray-400 text-center py-4">Sin movimientos registrados</p>
                            ) : (
                                <div className="overflow-x-auto">
                                    <table className="w-full text-sm">
                                        <thead>
                                            <tr className="border-b text-gray-500 text-xs uppercase">
                                                <th className="text-left py-2 pr-3">Tipo</th>
                                                <th className="text-left py-2 pr-3">Concepto</th>
                                                <th className="text-right py-2 pr-3">Monto</th>
                                                <th className="text-left py-2 pr-3">Usuario</th>
                                                <th className="text-left py-2">Fecha</th>
                                            </tr>
                                        </thead>
                                        <tbody className="divide-y divide-gray-100">
                                            {movimientos.map((m) => (
                                                <tr key={m.id_movimiento_caja} className="hover:bg-gray-50">
                                                    <td className="py-2 pr-3">
                                                        <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${m.tipo === 'Ingreso' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                                                            {m.tipo}
                                                        </span>
                                                    </td>
                                                    <td className="py-2 pr-3 text-gray-700">{m.concepto}</td>
                                                    <td className={`py-2 pr-3 text-right font-medium ${m.tipo === 'Ingreso' ? 'text-green-700' : 'text-red-700'}`}>
                                                        {m.tipo === 'Ingreso' ? '+' : '-'}{fmt(m.monto)}
                                                    </td>
                                                    <td className="py-2 pr-3 text-gray-500 text-xs">{m.usuario?.name ?? '—'}</td>
                                                    <td className="py-2 text-gray-400 text-xs">
                                                        {new Date(m.created_at).toLocaleString('es-PE', { dateStyle: 'short', timeStyle: 'short' })}
                                                    </td>
                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>
                                </div>
                            )}
                        </div>
                    </div>
                )}
            </Modal>

            {caja && (
                <MovimientoModal
                    isOpen={isMovimientoOpen}
                    onClose={() => setIsMovimientoOpen(false)}
                    cajaId={caja.id_caja}
                    onSuccess={() => { setIsMovimientoOpen(false); fetchDetalle(); }}
                />
            )}
        </>
    );
}
