import { useState, useEffect } from 'react';
import { Modal } from '@/components/ui/modal';
import { Button } from '@/components/ui/button';
import { Loader2, Plus, TrendingUp, TrendingDown } from 'lucide-react';
import { toast } from '@/lib/sweetalert';
import MovimientoBancarioModal from './MovimientoBancarioModal';

const fmt = (val, moneda = 'PEN') => {
    const symbol = moneda === 'USD' ? '$' : moneda === 'EUR' ? '€' : 'S/';
    return val != null ? `${symbol} ${parseFloat(val).toFixed(2)}` : '—';
};

export default function CuentaBancariaDetalle({ isOpen, onClose, cuenta }) {
    const [movimientos, setMovimientos] = useState([]);
    const [loading, setLoading] = useState(false);
    const [isMovimientoOpen, setIsMovimientoOpen] = useState(false);

    useEffect(() => {
        if (isOpen && cuenta) fetchMovimientos();
    }, [isOpen, cuenta]);

    const fetchMovimientos = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch(`/api/cuentas-bancarias/${cuenta.id_cuenta}/movimientos`, {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
            });
            const data = await res.json();
            if (data.success) setMovimientos(data.data);
            else toast.error(data.message || 'Error al cargar movimientos');
        } catch {
            toast.error('Error de conexión');
        } finally {
            setLoading(false);
        }
    };

    const totalEntradas = movimientos.filter(m => ['Deposito', 'Interes'].includes(m.tipo)).reduce((s, m) => s + parseFloat(m.monto), 0);
    const totalSalidas = movimientos.filter(m => !['Deposito', 'Interes'].includes(m.tipo)).reduce((s, m) => s + parseFloat(m.monto), 0);
    const moneda = cuenta?.moneda ?? 'PEN';

    const title = `${cuenta?.banco?.nombre ?? 'Cuenta'} — ${cuenta?.numero_cuenta ?? ''}`;

    return (
        <>
            <Modal isOpen={isOpen} onClose={onClose} title={title} size="xl">
                {loading ? (
                    <div className="flex justify-center py-10">
                        <Loader2 className="h-8 w-8 animate-spin text-primary-600" />
                    </div>
                ) : (
                    <div className="space-y-5">
                        {/* Cabecera con info y botón */}
                        <div className="flex items-center justify-between -mt-2">
                            <p className="text-sm text-gray-500">
                                {cuenta?.tipo_cuenta} · {cuenta?.moneda} · Saldo: <span className="font-semibold">{fmt(cuenta?.saldo_actual, moneda)}</span>
                            </p>
                            {cuenta?.activa && (
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
                        <div className="grid grid-cols-2 gap-3">
                            <div className="bg-green-50 border border-green-200 rounded-lg p-3 text-center">
                                <div className="flex items-center justify-center gap-1 text-green-700 mb-1">
                                    <TrendingUp className="h-4 w-4" />
                                    <span className="text-xs font-medium">Entradas</span>
                                </div>
                                <p className="text-lg font-bold text-green-800">{fmt(totalEntradas, moneda)}</p>
                            </div>
                            <div className="bg-red-50 border border-red-200 rounded-lg p-3 text-center">
                                <div className="flex items-center justify-center gap-1 text-red-700 mb-1">
                                    <TrendingDown className="h-4 w-4" />
                                    <span className="text-xs font-medium">Salidas</span>
                                </div>
                                <p className="text-lg font-bold text-red-800">{fmt(totalSalidas, moneda)}</p>
                            </div>
                        </div>

                        {/* Movimientos */}
                        <div>
                            <h3 className="text-sm font-semibold text-gray-700 mb-2">Movimientos ({movimientos.length})</h3>
                            {movimientos.length === 0 ? (
                                <p className="text-sm text-gray-400 text-center py-6">Sin movimientos registrados</p>
                            ) : (
                                <div className="overflow-x-auto">
                                    <table className="w-full text-sm">
                                        <thead>
                                            <tr className="border-b text-gray-500 text-xs uppercase">
                                                <th className="text-left py-2 pr-3">Fecha</th>
                                                <th className="text-left py-2 pr-3">Tipo</th>
                                                <th className="text-left py-2 pr-3">Concepto</th>
                                                <th className="text-right py-2 pr-3">Monto</th>
                                                <th className="text-left py-2">Estado</th>
                                            </tr>
                                        </thead>
                                        <tbody className="divide-y divide-gray-100">
                                            {movimientos.map((m) => {
                                                const esEntrada = ['Deposito', 'Interes'].includes(m.tipo);
                                                return (
                                                    <tr key={m.id_movimiento_bancario} className="hover:bg-gray-50">
                                                        <td className="py-2 pr-3 text-gray-500 text-xs">
                                                            {new Date(m.fecha_movimiento).toLocaleDateString('es-PE')}
                                                        </td>
                                                        <td className="py-2 pr-3">
                                                            <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${esEntrada ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                                                                {m.tipo}
                                                            </span>
                                                        </td>
                                                        <td className="py-2 pr-3 text-gray-700">{m.concepto}</td>
                                                        <td className={`py-2 pr-3 text-right font-medium ${esEntrada ? 'text-green-700' : 'text-red-700'}`}>
                                                            {esEntrada ? '+' : '-'}{fmt(m.monto, moneda)}
                                                        </td>
                                                        <td className="py-2">
                                                            <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${m.conciliado ? 'bg-blue-100 text-blue-700' : 'bg-gray-100 text-gray-500'}`}>
                                                                {m.conciliado ? 'Conciliado' : 'Pendiente'}
                                                            </span>
                                                        </td>
                                                    </tr>
                                                );
                                            })}
                                        </tbody>
                                    </table>
                                </div>
                            )}
                        </div>
                    </div>
                )}
            </Modal>

            {cuenta && (
                <MovimientoBancarioModal
                    isOpen={isMovimientoOpen}
                    onClose={() => setIsMovimientoOpen(false)}
                    cuentaId={cuenta.id_cuenta}
                    moneda={cuenta.moneda}
                    onSuccess={() => { setIsMovimientoOpen(false); fetchMovimientos(); }}
                />
            )}
        </>
    );
}
