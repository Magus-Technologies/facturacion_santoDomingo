import { useState } from 'react';
import { Modal } from '@/components/ui/modal';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Loader2 } from 'lucide-react';
import { toast } from '@/lib/sweetalert';
import { baseUrl } from '@/lib/baseUrl';

export default function CajaAperturaModal({ isOpen, onClose, onSuccess, caja }) {
    const [form, setForm] = useState({ saldo_inicial: '', observaciones: '' });
    const [errors, setErrors] = useState({});
    const [saving, setSaving] = useState(false);

    const handleChange = (e) => {
        const { name, value } = e.target;
        setForm(prev => ({ ...prev, [name]: value }));
        if (errors[name]) setErrors(prev => ({ ...prev, [name]: null }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!caja) return;
        setSaving(true);
        setErrors({});
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl(`/api/cajas/${caja.id_caja}/abrir`), {
                method: 'POST',
                headers: {
                    Authorization: `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    Accept: 'application/json',
                },
                body: JSON.stringify({
                    saldo_inicial: parseFloat(form.saldo_inicial) || 0,
                    tipo_apertura: 'monto_fijo',
                }),
            });
            const data = await res.json();
            if (data.success) {
                toast.success('Caja abierta exitosamente');
                setForm({ saldo_inicial: '', observaciones: '' });
                onSuccess();
                onClose();
            } else if (data.errors) {
                setErrors(data.errors);
            } else {
                toast.error(data.message || 'Error al abrir la caja');
            }
        } catch {
            toast.error('Error de conexión al servidor');
        } finally {
            setSaving(false);
        }
    };

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            title={`Apertura de Caja${caja ? ` — ${caja.nombre}` : ''}`}
            size="sm"
            footer={
                <>
                    <Button variant="outline" onClick={onClose} disabled={saving}>Cancelar</Button>
                    <Button onClick={handleSubmit} disabled={saving} className="gap-2 bg-primary-600 hover:bg-primary-700 text-white">
                        {saving && <Loader2 className="h-4 w-4 animate-spin" />}
                        Abrir Caja
                    </Button>
                </>
            }
        >
            <form onSubmit={handleSubmit} className="space-y-4">
                {caja?.responsable && (
                    <div className="bg-blue-50 border border-blue-200 rounded-md p-3 text-sm text-blue-800">
                        <span className="font-medium">Responsable:</span> {caja.responsable.name}
                    </div>
                )}
                <div>
                    <Label htmlFor="saldo_inicial">Saldo Inicial (S/) <span className="text-red-500">*</span></Label>
                    <Input
                        id="saldo_inicial"
                        name="saldo_inicial"
                        type="number"
                        step="0.01"
                        min="0"
                        value={form.saldo_inicial}
                        onChange={handleChange}
                        placeholder="0.00"
                        className={errors.saldo_inicial ? 'border-red-500' : ''}
                    />
                    {errors.saldo_inicial && <p className="text-red-500 text-xs mt-1">{errors.saldo_inicial[0]}</p>}
                </div>
                <div>
                    <Label htmlFor="observaciones">Observaciones</Label>
                    <textarea
                        id="observaciones"
                        name="observaciones"
                        rows={2}
                        value={form.observaciones}
                        onChange={handleChange}
                        placeholder="Observaciones opcionales..."
                        className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring resize-none"
                    />
                </div>
            </form>
        </Modal>
    );
}
