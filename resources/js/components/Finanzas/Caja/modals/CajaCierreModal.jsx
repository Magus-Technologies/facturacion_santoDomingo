import { useState, useEffect } from 'react';
import { Modal } from '@/components/ui/modal';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group';
import { Textarea } from '@/components/ui/textarea';
import DenominacionesTable from '../components/DenominacionesTable';
import { toast } from '@/lib/sweetalert';

export default function CajaCierreModal({ isOpen, caja, onClose, onSuccess }) {
    const [tipoCierre, setTipoCierre] = useState('monto_fijo');
    const [montoFijo, setMontoFijo] = useState('');
    const [denominaciones, setDenominaciones] = useState([]);
    const [observaciones, setObservaciones] = useState('');
    const [loading, setLoading] = useState(false);
    const [loadingDenom, setLoadingDenom] = useState(true);

    useEffect(() => {
        if (isOpen) {
            fetchDenominaciones();
        }
    }, [isOpen]);

    const fetchDenominaciones = async () => {
        try {
            setLoadingDenom(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch('/api/cajas/denominaciones', {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' }
            });
            const data = await res.json();
            if (data.success) {
                const denoms = data.data.map(d => ({
                    ...d,
                    cantidad: 0,
                    subtotal: 0
                }));
                setDenominaciones(denoms);
            }
        } catch (error) {
            toast.error('Error al cargar denominaciones');
        } finally {
            setLoadingDenom(false);
        }
    };

    const calcularDiferencia = () => {
        const totalReal = tipoCierre === 'monto_fijo' 
            ? parseFloat(montoFijo) || 0
            : denominaciones.reduce((sum, d) => sum + (d.subtotal || 0), 0);
        
        const totalTeorico = caja?.saldo_final_teorico || 0;
        return totalReal - totalTeorico;
    };

    const obtenerTipoDiferencia = () => {
        const diff = calcularDiferencia();
        if (diff === 0) return 'exacto';
        if (diff > 0) return 'sobrante';
        return 'faltante';
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        
        if (tipoCierre === 'monto_fijo') {
            if (!montoFijo || parseFloat(montoFijo) < 0) {
                toast.error('Ingrese un monto válido');
                return;
            }
        } else {
            const total = denominaciones.reduce((sum, d) => sum + (d.subtotal || 0), 0);
            if (total <= 0) {
                toast.error('Ingrese al menos una denominación');
                return;
            }
        }

        setLoading(true);
        try {
            const token = localStorage.getItem('auth_token');
            const totalReal = tipoCierre === 'monto_fijo' 
                ? parseFloat(montoFijo)
                : denominaciones.reduce((sum, d) => sum + (d.subtotal || 0), 0);

            const payload = {
                tipo_cierre: tipoCierre,
                saldo_final_real: totalReal,
                observaciones_cierre: observaciones,
            };

            if (tipoCierre === 'billetes') {
                payload.denominaciones = denominaciones.filter(d => d.cantidad > 0).map(d => ({
                    id_denominacion: d.id_denominacion,
                    cantidad: d.cantidad
                }));
            }

            const res = await fetch(`/api/cajas/${caja.id_caja}/cierre`, {
                method: 'PUT',
                headers: {
                    Authorization: `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    Accept: 'application/json'
                },
                body: JSON.stringify(payload)
            });

            const data = await res.json();
            if (data.success) {
                toast.success('Caja cerrada correctamente');
                handleReset();
                onSuccess?.();
            } else {
                toast.error(data.message || 'Error al cerrar caja');
            }
        } catch (error) {
            toast.error('Error de conexión');
        } finally {
            setLoading(false);
        }
    };

    const handleReset = () => {
        setTipoCierre('monto_fijo');
        setMontoFijo('');
        setObservaciones('');
        setDenominaciones(denominaciones.map(d => ({ ...d, cantidad: 0, subtotal: 0 })));
        onClose();
    };

    const diferencia = calcularDiferencia();
    const tipoDiferencia = obtenerTipoDiferencia();
    const colorDiferencia = tipoDiferencia === 'exacto' ? 'text-green-600' : tipoDiferencia === 'sobrante' ? 'text-blue-600' : 'text-red-600';

    return (
        <Modal isOpen={isOpen} onClose={onClose} title="Cierre de Caja" size="md">
            <form onSubmit={handleSubmit} className="space-y-6">
                    {/* Tipo de Cierre */}
                    <div className="space-y-3">
                        <Label className="text-base font-semibold">Saldo Final</Label>
                        <RadioGroup value={tipoCierre} onValueChange={setTipoCierre}>
                            <div className="flex items-center space-x-2">
                                <RadioGroupItem value="monto_fijo" id="cierre_monto_fijo" />
                                <Label htmlFor="cierre_monto_fijo" className="font-normal cursor-pointer">
                                    Monto Fijo
                                </Label>
                            </div>
                            <div className="flex items-center space-x-2">
                                <RadioGroupItem value="billetes" id="cierre_billetes" />
                                <Label htmlFor="cierre_billetes" className="font-normal cursor-pointer">
                                    Por Billetes
                                </Label>
                            </div>
                        </RadioGroup>
                    </div>

                    {/* Monto Fijo */}
                    {tipoCierre === 'monto_fijo' && (
                        <div className="space-y-2">
                            <Label htmlFor="monto_cierre">Total Contado</Label>
                            <Input
                                id="monto_cierre"
                                type="number"
                                step="0.01"
                                min="0"
                                placeholder="0.00"
                                value={montoFijo}
                                onChange={(e) => setMontoFijo(e.target.value)}
                                className="font-mono"
                            />
                        </div>
                    )}

                    {/* Por Billetes */}
                    {tipoCierre === 'billetes' && (
                        <div className="space-y-2">
                            <Label>Denominaciones</Label>
                            {loadingDenom ? (
                                <div className="text-center py-4 text-gray-500">Cargando denominaciones...</div>
                            ) : (
                                <DenominacionesTable
                                    denominaciones={denominaciones}
                                    onChange={setDenominaciones}
                                />
                            )}
                        </div>
                    )}

                    {/* Cálculo de Diferencia */}
                    <div className="bg-gray-50 p-4 rounded-lg space-y-2">
                        <p className="font-semibold text-gray-900">Cálculo de Diferencia</p>
                        <div className="flex justify-between text-sm">
                            <span>Total Teórico:</span>
                            <span className="font-mono">S/. {parseFloat(caja?.saldo_final_teorico || 0).toFixed(2)}</span>
                        </div>
                        <div className="flex justify-between text-sm">
                            <span>Total Real (Contado):</span>
                            <span className="font-mono">
                                S/. {(tipoCierre === 'monto_fijo' 
                                    ? parseFloat(montoFijo || 0).toFixed(2)
                                    : denominaciones.reduce((sum, d) => sum + (d.subtotal || 0), 0).toFixed(2))}
                            </span>
                        </div>
                        <div className="border-t pt-2 flex justify-between font-bold">
                            <span>Diferencia:</span>
                            <span className={`font-mono ${colorDiferencia}`}>
                                S/. {diferencia.toFixed(2)} ({tipoDiferencia.toUpperCase()})
                            </span>
                        </div>
                    </div>

                    {/* Observaciones */}
                    <div className="space-y-2">
                        <Label htmlFor="obs_cierre">Observaciones (opcional)</Label>
                        <Textarea
                            id="obs_cierre"
                            placeholder="Ingrese observaciones..."
                            value={observaciones}
                            onChange={(e) => setObservaciones(e.target.value)}
                            rows={3}
                        />
                    </div>

                    {/* Botones */}
                    <div className="flex justify-end gap-2 pt-4 border-t">
                        <Button variant="outline" onClick={handleReset} disabled={loading}>
                            Cancelar
                        </Button>
                        <Button type="submit" disabled={loading}>
                            {loading ? 'Cerrando...' : 'Cerrar Caja'}
                        </Button>
                    </div>
                </form>
            </Modal>
        );
    }
