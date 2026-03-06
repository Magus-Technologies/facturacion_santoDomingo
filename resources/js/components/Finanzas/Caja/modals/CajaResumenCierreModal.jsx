import { useState, useEffect } from 'react';
import { Modal } from '@/components/ui/modal';
import { Button } from '@/components/ui/button';
import ResumenVentasPorMetodo from '../components/ResumenVentasPorMetodo';
import ModalDetalleVentas from '../components/ModalDetalleVentas';
import { toast } from '@/lib/sweetalert';
import { baseUrl } from '@/lib/baseUrl';

export default function CajaResumenCierreModal({ isOpen, caja, onClose, onProceedCierre }) {
    const [resumen, setResumen] = useState(null);
    const [loading, setLoading] = useState(false);
    const [detalleOpen, setDetalleOpen] = useState(false);
    const [metodoSeleccionado, setMetodoSeleccionado] = useState(null);

    useEffect(() => {
        if (isOpen && caja) {
            fetchResumen();
        }
    }, [isOpen, caja]);

    const fetchResumen = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl(`/api/cajas/${caja.id_caja}/resumen`), {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' }
            });
            const data = await res.json();
            if (data.success) {
                setResumen(data.data);
            } else {
                toast.error(data.message || 'Error al cargar resumen');
            }
        } catch (error) {
            toast.error('Error de conexión');
        } finally {
            setLoading(false);
        }
    };

    const handleVerDetalle = (metodo) => {
        setMetodoSeleccionado(metodo);
        setDetalleOpen(true);
    };

    if (loading) {
        return (
            <Modal isOpen={isOpen} onClose={onClose} title="Resumen de Cierre de Caja" size="md">
                <div className="text-center py-8">Cargando resumen...</div>
            </Modal>
        );
    }

    if (!resumen) {
        return null;
    }

    const totalIngresos = (resumen.ventas_por_metodo?.reduce((sum, m) => sum + parseFloat(m.total || 0), 0) || 0) + (parseFloat(resumen.ingresos_manuales || 0));
    const totalEgresos = parseFloat(resumen.egresos || 0);
    const totalTeorico = parseFloat(resumen.total_teorico || 0);

    return (
        <>
            <Modal isOpen={isOpen} onClose={onClose} title="Resumen de Cierre de Caja" size="md">
                <div className="space-y-6">
                        {/* Apertura */}
                        <div className="bg-blue-50 p-4 rounded-lg">
                            <p className="font-semibold text-gray-900 mb-2">Apertura</p>
                            <div className="flex justify-between">
                                <span>Saldo Inicial:</span>
                                <span className="font-mono font-semibold">
                                    S/. {parseFloat(resumen.apertura?.saldo_inicial || 0).toFixed(2)}
                                </span>
                            </div>
                            <div className="text-sm text-gray-600 mt-1">
                                Registrado por: {resumen.apertura?.tipo_apertura === 'monto_fijo' ? 'Monto Fijo' : 'Billetes'}
                            </div>
                        </div>

                        {/* Resumen de Ventas por Método */}
                        <div className="space-y-2">
                            <p className="font-semibold text-gray-900">Resumen de Ventas por Método</p>
                            <ResumenVentasPorMetodo
                                metodos={resumen.ventas_por_metodo || []}
                                onVerDetalle={handleVerDetalle}
                            />
                        </div>

                        {/* Otros Movimientos */}
                        <div className="bg-gray-50 p-4 rounded-lg space-y-2">
                            <p className="font-semibold text-gray-900 mb-2">Otros Movimientos</p>
                            <div className="flex justify-between text-sm">
                                <span>Ingresos Manuales:</span>
                                <span className="font-mono">S/. {parseFloat(resumen.ingresos_manuales || 0).toFixed(2)}</span>
                            </div>
                            <div className="flex justify-between text-sm">
                                <span>Egresos:</span>
                                <span className="font-mono">S/. {parseFloat(resumen.egresos || 0).toFixed(2)}</span>
                            </div>
                        </div>

                        {/* Totales */}
                        <div className="bg-green-50 p-4 rounded-lg space-y-2">
                            <p className="font-semibold text-gray-900 mb-2">Totales</p>
                            <div className="flex justify-between text-sm">
                                <span>Saldo Inicial:</span>
                                <span className="font-mono">S/. {parseFloat(resumen.apertura?.saldo_inicial || 0).toFixed(2)}</span>
                            </div>
                            <div className="flex justify-between text-sm">
                                <span>+ Ingresos:</span>
                                <span className="font-mono">S/. {totalIngresos.toFixed(2)}</span>
                            </div>
                            <div className="flex justify-between text-sm">
                                <span>- Egresos:</span>
                                <span className="font-mono">S/. {totalEgresos.toFixed(2)}</span>
                            </div>
                            <div className="border-t pt-2 flex justify-between font-bold">
                                <span>TOTAL TEÓRICO:</span>
                                <span className="font-mono">S/. {totalTeorico.toFixed(2)}</span>
                            </div>
                        </div>

                        {/* Botones */}
                        <div className="flex justify-end gap-2 pt-4 border-t">
                            <Button variant="outline" onClick={onClose}>
                                Cancelar
                            </Button>
                            <Button onClick={() => {
                                onClose();
                                onProceedCierre?.();
                            }}>
                                Proceder a Cierre
                            </Button>
                        </div>
                    </div>
                </Modal>

                {/* Modal de Detalle de Ventas */}
                <ModalDetalleVentas
                    isOpen={detalleOpen}
                    metodo={metodoSeleccionado}
                    ventas={metodoSeleccionado?.ventas || []}
                    total={metodoSeleccionado?.total || 0}
                    onClose={() => setDetalleOpen(false)}
                />
            </>
        );
    }
