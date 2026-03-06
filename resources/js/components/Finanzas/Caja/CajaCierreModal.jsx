import { useState } from 'react';
import { Modal } from '@/components/ui/modal';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Loader2 } from 'lucide-react';
import { toast } from '@/lib/sweetalert';

export default function CajaCierreModal({ isOpen, onClose, caja, onSuccess }) {
    const [form, setForm] = useState({ saldo_final_real: '', observaciones_cierre: '' });
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
            const res = await fetch(`/api/cajas/${caja.id_caja}/cierre`, {
                method: 'PUT',
                headers: {
                    Authorization: `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    Accept: 'application/json',
                },
                body: JSON.stringify({
                    saldo_final_real: parseFloat(form.saldo_final_real) || 0,
                    observaciones_cierre: form.observaciones_cierre || null,
                }),
            });
            const data = await res.json();
            if (data.success) {
                toast.success('Caja cerrada. Pendiente de autorización.');
                setForm({ saldo_final_real: '', observaciones_cierre: '' });
                onSuccess();
            } else if (data.errors) {
                setErrors(data.errors);
            } else {
                toast.error(data.message || 'Error al cerrar la caja');
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
            title="Cierre de Caja"
            size="sm"
            footer={
                <>
                    <Button variant="outline" onClick={onClose} disabled={saving}>Cancelar</Button>
                    <Button onClick={handleSubmit} disabled={saving} className="gap-2 bg-orange-600 hover:bg-orange-700 text-white">
                        {saving && <Loader2 className="h-4 w-4 animate-spin" />}
                        Cerrar Caja
                    </Button>
                </>
            }
        >
            <form onSubmit={handleSubmit} className="space-y-4">
                {caja && (
                    <p className="text-sm text-gray-500 -mt-2">
                        Saldo inicial: <span className="font-medium">S/ {parseFloat(caja.saldo_inicial).toFixed(2)}</span>
                    </p>
                )}
                <div>
                    <Label htmlFor="saldo_final_real">Saldo Final Real (S/) <span className="text-red-500">*</span></Label>
                    <Input
                        id="saldo_final_real"
                        name="saldo_final_real"
                        type="number"
                        step="0.01"
                        min="0"
                        value={form.saldo_final_real}
                        onChange={handleChange}
                        placeholder="0.00"
                        className={errors.saldo_final_real ? 'border-red-500' : ''}
                        required
                    />
                    {errors.saldo_final_real && <p className="text-red-500 text-xs mt-1">{errors.saldo_final_real[0]}</p>}
                </div>
                <div>
                    <Label htmlFor="observaciones_cierre">Observaciones de Cierre</Label>
                    <textarea
                        id="observaciones_cierre"
                        name="observaciones_cierre"
                        rows={3}
                        value={form.observaciones_cierre}
                        onChange={handleChange}
                        placeholder="Observaciones opcionales..."
                        className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring resize-none"
                    />
                </div>
            </form>
        </Modal>
    );
}
