import { useState, useEffect } from 'react';
import { Modal } from '@/components/ui/modal';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { Textarea } from '@/components/ui/textarea';
import ResumenVentasPorMetodo from '../components/ResumenVentasPorMetodo';
import ModalDetalleVentas from '../components/ModalDetalleVentas';
import { toast } from '@/lib/sweetalert';

export default function CajaValidacionModal({ isOpen, caja, onClose, onSuccess }) {
    const [resumen, setResumen] = useState(null);
    const [decision, setDecision] = useState('autorizar');
    const [observaciones, setObservaciones] = useState('');
    const [contrasena, setContrasena] = useState('');
    const [loading, setLoading] = useState(false);
    const [loadingResumen, setLoadingResumen] = useState(false);
    const [detalleOpen, setDetalleOpen] = useState(false);
    const [metodoSeleccionado, setMetodoSeleccionado] = useState(null);

    useEffect(() => {
        if (isOpen && caja) {
            fetchResumen();
        }
    }, [isOpen, caja]);

    const fetchResumen = async () => {
        try {
            setLoadingResumen(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch(`/api/cajas/${caja.id_caja}/resumen`, {
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
            setLoadingResumen(false);
        }
    };

    const handleVerDetalle = (metodo) => {
        setMetodoSeleccionado(metodo);
        setDetalleOpen(true);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        if (!contrasena) {
            toast.error('Ingrese su contraseña para confirmar');
            return;
        }

        setLoading(true);
        try {
            const token = localStorage.getItem('auth_token');
            const endpoint = decision === 'autorizar' 
                ? `/api/cajas/${caja.id_caja}/autorizar`
                : `/api/cajas/${caja.id_caja}/rechazar`;

            const res = await fetch(endpoint, {
                method: 'POST',
                headers: {
                    Authorization: `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    Accept: 'application/json'
                },
                body: JSON.stringify({
                    observaciones: observaciones,
                    contrasena: contrasena
                })
            });

            const data = await res.json();
            if (data.success) {
                const mensaje = decision === 'autorizar' 
                    ? 'Cierre autorizado correctamente'
                    : 'Cierre rechazado correctamente';
                toast.success(mensaje);
                handleReset();
                onSuccess?.();
            } else {
                toast.error(data.message || 'Error al procesar validación');
            }
        } catch (error) {
            toast.error('Error de conexión');
        } finally {
            setLoading(false);
        }
    };

    const handleReset = () => {
        setDecision('autorizar');
        setObservaciones('');
        setContrasena('');
        onClose();
    };

    if (loadingResumen) {
        return (
            <Modal isOpen={isOpen} onClose={onClose} title="Validación de Cierre de Caja" size="md">
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
    const diferencia = parseFloat(caja?.diferencia || 0);
    const tipoDiferencia = caja?.tipo_diferencia || 'exacto';
    const colorDiferencia = tipoDiferencia === 'exacto' ? 'text-green-600' : tipoDiferencia === 'sobrante' ? 'text-blue-600' : 'text-red-600';

    return (
        <>
            <Modal isOpen={isOpen} onClose={onClose} title="Validación de Cierre de Caja" size="md">
                <form onSubmit={handleSubmit} className="space-y-6">
                        {/* Información del Vendedor */}
                        <div className="bg-gray-50 p-4 rounded-lg space-y-2">
                            <p className="font-semibold text-gray-900">Información</p>
                            <div className="grid grid-cols-2 gap-4 text-sm">
                                <div>
                                    <span className="text-gray-600">Vendedor:</span>
                                    <p className="font-semibold">{caja?.usuarioApertura?.name || 'N/A'}</p>
                                </div>
                                <div>
                                    <span className="text-gray-600">Fecha:</span>
                                    <p className="font-semibold">{new Date(caja?.fecha_cierre).toLocaleDateString()}</p>
                                </div>
                                <div>
                                    <span className="text-gray-600">Hora Cierre:</span>
                                    <p className="font-semibold">{new Date(caja?.fecha_cierre).toLocaleTimeString()}</p>
                                </div>
                            </div>
                        </div>

                        {/* Resumen */}
                        <div className="bg-blue-50 p-4 rounded-lg space-y-2">
                            <p className="font-semibold text-gray-900 mb-2">Resumen</p>
                            <div className="flex justify-between text-sm">
                                <span>Saldo Inicial:</span>
                                <span className="font-mono">S/. {parseFloat(resumen.apertura?.saldo_inicial || 0).toFixed(2)}</span>
                            </div>
                            <div className="flex justify-between text-sm">
                                <span>Total Ventas:</span>
                                <span className="font-mono">S/. {(resumen.ventas_por_metodo?.reduce((sum, m) => sum + parseFloat(m.total || 0), 0) || 0).toFixed(2)}</span>
                            </div>
                            <div className="flex justify-between text-sm">
                                <span>Ingresos Manuales:</span>
                                <span className="font-mono">S/. {parseFloat(resumen.ingresos_manuales || 0).toFixed(2)}</span>
                            </div>
                            <div className="flex justify-between text-sm">
                                <span>Egresos:</span>
                                <span className="font-mono">S/. {parseFloat(resumen.egresos || 0).toFixed(2)}</span>
                            </div>
                            <div className="border-t pt-2 flex justify-between font-bold">
                                <span>TOTAL TEÓRICO:</span>
                                <span className="font-mono">S/. {totalTeorico.toFixed(2)}</span>
                            </div>
                            <div className="flex justify-between font-bold">
                                <span>TOTAL REAL:</span>
                                <span className="font-mono">S/. {parseFloat(caja?.saldo_final_real || 0).toFixed(2)}</span>
                            </div>
                            <div className="border-t pt-2 flex justify-between font-bold">
                                <span>DIFERENCIA:</span>
                                <span className={`font-mono ${colorDiferencia}`}>
                                    S/. {diferencia.toFixed(2)} ({tipoDiferencia.toUpperCase()})
                                </span>
                            </div>
                        </div>

                        {/* Detalle de Ventas */}
                        <div className="space-y-2">
                            <p className="font-semibold text-gray-900">Detalle de Ventas</p>
                            <ResumenVentasPorMetodo
                                metodos={resumen.ventas_por_metodo || []}
                                onVerDetalle={handleVerDetalle}
                            />
                        </div>

                        {/* Observaciones del Vendedor */}
                        {caja?.observaciones_cierre && (
                            <div className="bg-yellow-50 p-4 rounded-lg">
                                <p className="font-semibold text-gray-900 mb-2">Observaciones del Vendedor</p>
                                <p className="text-sm text-gray-700">{caja.observaciones_cierre}</p>
                            </div>
                        )}

                        {/* Decisión */}
                        <div className="space-y-3 border-t pt-4">
                            <Label className="text-base font-semibold">Decisión</Label>
                            <RadioGroup value={decision} onValueChange={setDecision}>
                                <div className="flex items-center space-x-2">
                                    <RadioGroupItem value="autorizar" id="autorizar" />
                                    <Label htmlFor="autorizar" className="font-normal cursor-pointer">
                                        Autorizar Cierre
                                    </Label>
                                </div>
                                <div className="flex items-center space-x-2">
                                    <RadioGroupItem value="rechazar" id="rechazar" />
                                    <Label htmlFor="rechazar" className="font-normal cursor-pointer">
                                        Rechazar Cierre
                                    </Label>
                                </div>
                            </RadioGroup>
                        </div>

                        {/* Observaciones */}
                        <div className="space-y-2">
                            <Label htmlFor="obs_validacion">Observaciones (opcional)</Label>
                            <Textarea
                                id="obs_validacion"
                                placeholder="Ingrese observaciones..."
                                value={observaciones}
                                onChange={(e) => setObservaciones(e.target.value)}
                                rows={3}
                            />
                        </div>

                        {/* Contraseña */}
                        <div className="space-y-2">
                            <Label htmlFor="password">Contraseña (requerida)</Label>
                            <Input
                                id="password"
                                type="password"
                                placeholder="Ingrese su contraseña"
                                value={contrasena}
                                onChange={(e) => setContrasena(e.target.value)}
                            />
                        </div>

                        {/* Botones */}
                        <div className="flex justify-end gap-2 pt-4 border-t">
                            <Button variant="outline" onClick={handleReset} disabled={loading}>
                                Cancelar
                            </Button>
                            <Button 
                                type="submit" 
                                disabled={loading}
                                variant={decision === 'autorizar' ? 'default' : 'destructive'}
                            >
                                {loading ? 'Procesando...' : (decision === 'autorizar' ? 'Autorizar' : 'Rechazar')}
                            </Button>
                        </div>
                    </form>
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
