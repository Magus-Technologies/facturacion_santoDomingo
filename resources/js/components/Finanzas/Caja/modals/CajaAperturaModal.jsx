import { useState, useEffect } from 'react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { X } from 'lucide-react';
import DenominacionesTable from '../components/DenominacionesTable';
import { toast } from '@/lib/sweetalert';

export default function CajaAperturaModal({ isOpen, onClose, onSuccess, caja }) {
    const [cajaSeleccionada, setCajaSeleccionada] = useState(null);
    const [cajasInactivas, setCajasInactivas] = useState([]);
    const [tipoApertura, setTipoApertura] = useState('monto_fijo');
    const [montoFijo, setMontoFijo] = useState('');
    const [denominaciones, setDenominaciones] = useState([]);
    const [observaciones, setObservaciones] = useState('');
    const [loading, setLoading] = useState(false);
    const [loadingDenom, setLoadingDenom] = useState(true);
    const [loadingCajas, setLoadingCajas] = useState(false);

    const cajaActual = caja ?? cajaSeleccionada;

    useEffect(() => {
        if (isOpen) {
            fetchDenominaciones();
            if (!caja) fetchCajasInactivas();
            document.body.style.overflow = 'hidden';
        } else {
            document.body.style.overflow = 'unset';
            setCajaSeleccionada(null);
        }
        return () => { document.body.style.overflow = 'unset'; };
    }, [isOpen, caja]);

    const fetchCajasInactivas = async () => {
        try {
            setLoadingCajas(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch('/api/cajas', {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' }
            });
            const data = await res.json();
            if (data.success) {
                const lista = data.data?.data ?? data.data ?? [];
                // Mostrar todas las cajas (sin filtrar por estado)
                setCajasInactivas(lista);
            }
        } catch {
            toast.error('Error al cargar cajas disponibles');
        } finally {
            setLoadingCajas(false);
        }
    };

    const fetchDenominaciones = async () => {
        try {
            setLoadingDenom(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch('/api/cajas/denominaciones', {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' }
            });
            const data = await res.json();
            if (data.success) {
                setDenominaciones(data.data.map(d => ({ ...d, cantidad: 0, subtotal: 0 })));
            }
        } catch {
            toast.error('Error al cargar denominaciones');
        } finally {
            setLoadingDenom(false);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        if (!cajaActual?.id_caja) {
            toast.error('Selecciona una caja para aperturar');
            return;
        }

        if (tipoApertura === 'monto_fijo') {
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
            const payload = {
                tipo_apertura: tipoApertura,
                saldo_inicial: tipoApertura === 'monto_fijo'
                    ? parseFloat(montoFijo)
                    : denominaciones.reduce((sum, d) => sum + (d.subtotal || 0), 0),
                observaciones,
            };

            if (tipoApertura === 'billetes') {
                payload.denominaciones = denominaciones
                    .filter(d => d.cantidad > 0)
                    .map(d => ({ id_denominacion: d.id_denominacion, cantidad: d.cantidad }));
            }

            const res = await fetch(`/api/cajas/${cajaActual.id_caja}/abrir`, {
                method: 'POST',
                headers: {
                    Authorization: `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    Accept: 'application/json',
                },
                body: JSON.stringify(payload),
            });

            const data = await res.json();
            if (data.success) {
                toast.success('Caja aperturada correctamente');
                handleReset();
                onSuccess?.();
            } else {
                toast.error(data.message || 'Error al aperturar caja');
            }
        } catch {
            toast.error('Error de conexión');
        } finally {
            setLoading(false);
        }
    };

    const handleReset = () => {
        setTipoApertura('monto_fijo');
        setMontoFijo('');
        setObservaciones('');
        setDenominaciones(prev => prev.map(d => ({ ...d, cantidad: 0, subtotal: 0 })));
        setCajaSeleccionada(null);
        onClose();
    };

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
            <div className="bg-white rounded-lg shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
                {/* Header */}
                <div className="flex items-center justify-between p-6 border-b border-gray-200 sticky top-0 bg-white">
                    <h2 className="text-xl font-semibold text-gray-900">
                        Apertura de Caja{cajaActual?.nombre ? ` — ${cajaActual.nombre}` : ''}
                    </h2>
                    <button onClick={handleReset} className="text-gray-400 hover:text-gray-600 p-1 hover:bg-gray-100 rounded-lg transition-colors">
                        <X className="h-5 w-5" />
                    </button>
                </div>

                <form onSubmit={handleSubmit} className="p-6 space-y-6">
                    {/* Selector de caja (solo si no viene preseleccionada) */}
                    {!caja && (
                        <div className="space-y-2">
                            <Label htmlFor="caja_select">Caja a aperturar <span className="text-red-500">*</span></Label>
                            {loadingCajas ? (
                                <p className="text-sm text-gray-500">Cargando cajas...</p>
                            ) : cajasInactivas.length === 0 ? (
                                <p className="text-sm text-amber-600 bg-amber-50 border border-amber-200 rounded-md px-3 py-2">
                                    No hay cajas disponibles.
                                </p>
                            ) : (
                                <select
                                    id="caja_select"
                                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
                                    value={cajaSeleccionada?.id_caja ?? ''}
                                    onChange={(e) => {
                                        const id = parseInt(e.target.value);
                                        setCajaSeleccionada(cajasInactivas.find(c => c.id_caja === id) ?? null);
                                    }}
                                >
                                    <option value="">— Selecciona una caja —</option>
                                    {cajasInactivas.map(c => (
                                        <option key={c.id_caja} value={c.id_caja}>
                                            {c.nombre}{c.responsable ? ` (${c.responsable.name})` : ''}
                                        </option>
                                    ))}
                                </select>
                            )}
                        </div>
                    )}

                    {/* Info responsable */}
                    {cajaActual?.responsable && (
                        <div className="bg-blue-50 border border-blue-200 rounded-md px-3 py-2 text-sm text-blue-800">
                            <span className="font-medium">Responsable:</span> {cajaActual.responsable.name}
                        </div>
                    )}

                    {/* Tipo de Apertura */}
                    <div className="space-y-3">
                        <Label className="text-base font-semibold">Saldo Inicial</Label>
                        <div className="flex gap-6">
                            <label className="flex items-center gap-2 cursor-pointer">
                                <input
                                    type="radio"
                                    name="tipoApertura"
                                    value="monto_fijo"
                                    checked={tipoApertura === 'monto_fijo'}
                                    onChange={(e) => setTipoApertura(e.target.value)}
                                    className="w-4 h-4"
                                />
                                <span className="text-sm">Monto Fijo</span>
                            </label>
                            <label className="flex items-center gap-2 cursor-pointer">
                                <input
                                    type="radio"
                                    name="tipoApertura"
                                    value="billetes"
                                    checked={tipoApertura === 'billetes'}
                                    onChange={(e) => setTipoApertura(e.target.value)}
                                    className="w-4 h-4"
                                />
                                <span className="text-sm">Por Billetes</span>
                            </label>
                        </div>
                    </div>

                    {/* Monto Fijo */}
                    {tipoApertura === 'monto_fijo' && (
                        <div className="space-y-2">
                            <Label htmlFor="monto">Ingrese el saldo inicial</Label>
                            <Input
                                id="monto"
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
                    {tipoApertura === 'billetes' && (
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

                    {/* Observaciones */}
                    <div className="space-y-2">
                        <Label htmlFor="obs">Observaciones (opcional)</Label>
                        <Textarea
                            id="obs"
                            placeholder="Ingrese observaciones..."
                            value={observaciones}
                            onChange={(e) => setObservaciones(e.target.value)}
                            rows={3}
                        />
                    </div>

                    {/* Botones */}
                    <div className="flex justify-end gap-2 pt-4 border-t">
                        <Button type="button" variant="outline" onClick={handleReset} disabled={loading}>
                            Cancelar
                        </Button>
                        <Button
                            type="submit"
                            disabled={loading || (!caja && !cajaSeleccionada)}
                            className="bg-primary-600 hover:bg-primary-700 text-white"
                        >
                            {loading ? 'Aperturando...' : 'Aperturar Caja'}
                        </Button>
                    </div>
                </form>
            </div>
        </div>
    );
}
