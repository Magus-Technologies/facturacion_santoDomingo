import { useState, useEffect } from 'react';
import { Modal } from '@/components/ui/modal';
import { Button } from '@/components/ui/button';
import { Plus, Minus } from 'lucide-react';
import { toast } from '@/lib/sweetalert';
import { usePermissions } from '@/hooks/usePermissions';
import MovimientoModal from './MovimientoModal';

export default function CajaAbiertaDetail({ isOpen, caja, onClose, onCerrar }) {
    const [movimientos, setMovimientos] = useState([]);
    const [loading, setLoading] = useState(false);
    const [isMovimientoOpen, setIsMovimientoOpen] = useState(false);
    const [tipoMovimiento, setTipoMovimiento] = useState('Ingreso');
    const { hasPermission } = usePermissions();

    useEffect(() => {
        if (isOpen && caja) {
            fetchMovimientos();
        }
    }, [isOpen, caja]);

    const fetchMovimientos = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch(`/api/cajas/${caja.id_caja}/movimientos`, {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' }
            });
            const data = await res.json();
            if (data.success) {
                setMovimientos(data.data || []);
            }
        } catch (error) {
            toast.error('Error al cargar movimientos');
        } finally {
            setLoading(false);
        }
    };

    const handleAbrirMovimiento = (tipo) => {
        setTipoMovimiento(tipo);
        setIsMovimientoOpen(true);
    };

    const handleMovimientoSuccess = () => {
        setIsMovimientoOpen(false);
        fetchMovimientos();
    };

    if (!caja) return null;

    const totalIngresos = movimientos
        .filter(m => m.tipo === 'Ingreso')
        .reduce((sum, m) => sum + parseFloat(m.monto || 0), 0);

    const totalEgresos = movimientos
        .filter(m => m.tipo === 'Egreso')
        .reduce((sum, m) => sum + parseFloat(m.monto || 0), 0);

    const saldoTeorico = parseFloat(caja.saldo_inicial || 0) + totalIngresos - totalEgresos;

    return (
        <Modal isOpen={isOpen} onClose={onClose} title={`Caja Abierta - ${new Date(caja.fecha_apertura).toLocaleDateString()}`} size="md">
            <div className="space-y-6">
                    {/* Información */}
                    <div className="bg-gray-50 p-4 rounded-lg">
                        <p className="text-sm text-gray-600">Vendedor</p>
                        <p className="font-semibold text-gray-900">{caja.usuarioApertura?.name || 'N/A'}</p>
                    </div>

                    {/* Estado Actual */}
                    <div className="bg-blue-50 p-4 rounded-lg space-y-3">
                        <p className="font-semibold text-gray-900">Estado Actual</p>
                        <div className="space-y-2 text-sm">
                            <div className="flex justify-between">
                                <span>Saldo Inicial:</span>
                                <span className="font-mono font-semibold">
                                    S/. {parseFloat(caja.saldo_inicial || 0).toFixed(2)}
                                </span>
                            </div>
                            <div className="flex justify-between">
                                <span>Ventas Registradas:</span>
                                <span className="font-mono font-semibold">
                                    S/. {totalIngresos.toFixed(2)}
                                </span>
                            </div>
                            <div className="flex justify-between">
                                <span>Egresos:</span>
                                <span className="font-mono font-semibold">
                                    S/. {totalEgresos.toFixed(2)}
                                </span>
                            </div>
                            <div className="border-t pt-2 flex justify-between font-bold">
                                <span>TOTAL TEÓRICO:</span>
                                <span className="font-mono">S/. {saldoTeorico.toFixed(2)}</span>
                            </div>
                        </div>
                    </div>

                    {/* Botones de Acción */}
                    {hasPermission('caja.registrar_movimientos') && (
                        <div className="flex gap-2">
                            <Button 
                                variant="outline" 
                                className="gap-2 flex-1 text-green-700 border-green-300 hover:bg-green-50"
                                onClick={() => handleAbrirMovimiento('Ingreso')}
                            >
                                <Plus className="h-4 w-4" />
                                Ingreso Manual
                            </Button>
                            <Button 
                                variant="outline" 
                                className="gap-2 flex-1 text-red-700 border-red-300 hover:bg-red-50"
                                onClick={() => handleAbrirMovimiento('Egreso')}
                            >
                                <Minus className="h-4 w-4" />
                                Egreso
                            </Button>
                        </div>
                    )}

                    {/* Movimientos del Día */}
                    <div className="space-y-2">
                        <p className="font-semibold text-gray-900">Movimientos del Día</p>
                        {loading ? (
                            <div className="text-center py-4 text-gray-500">Cargando movimientos...</div>
                        ) : movimientos.length > 0 ? (
                            <div className="overflow-x-auto">
                                <table className="w-full text-sm">
                                    <thead>
                                        <tr className="border-b">
                                            <th className="text-left py-2 px-3 font-semibold">Hora</th>
                                            <th className="text-left py-2 px-3 font-semibold">Tipo</th>
                                            <th className="text-left py-2 px-3 font-semibold">Concepto</th>
                                            <th className="text-right py-2 px-3 font-semibold">Monto</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {movimientos.map((mov, idx) => (
                                            <tr key={mov.id_movimiento || idx} className="border-b hover:bg-gray-50">
                                                <td className="py-3 px-3 text-sm text-gray-500">
                                                    {new Date(mov.created_at).toLocaleTimeString()}
                                                </td>
                                                <td className="py-3 px-3">
                                                    <span className={`inline-flex items-center px-2 py-1 rounded-full text-xs font-medium ${
                                                        mov.tipo === 'Ingreso' 
                                                            ? 'bg-green-100 text-green-800'
                                                            : 'bg-red-100 text-red-800'
                                                    }`}>
                                                        {mov.tipo}
                                                    </span>
                                                </td>
                                                <td className="py-3 px-3">{mov.concepto || 'N/A'}</td>
                                                <td className="py-3 px-3 text-right font-mono">
                                                    S/. {parseFloat(mov.monto || 0).toFixed(2)}
                                                </td>
                                            </tr>
                                        ))}
                                    </tbody>
                                </table>
                            </div>
                        ) : (
                            <div className="text-center py-4 text-gray-500">
                                No hay movimientos registrados
                            </div>
                        )}
                    </div>

                    {/* Botones */}
                    <div className="flex justify-end gap-2 pt-4 border-t">
                        <Button variant="outline" onClick={onClose}>
                            Cerrar
                        </Button>
                        {hasPermission('caja.cerrar') && (
                            <Button onClick={onCerrar}>
                                Cerrar Caja
                            </Button>
                        )}
                    </div>
                </div>

                <MovimientoModal
                    isOpen={isMovimientoOpen}
                    onClose={() => setIsMovimientoOpen(false)}
                    cajaId={caja?.id_caja}
                    onSuccess={handleMovimientoSuccess}
                />
            </Modal>
        );
    }
