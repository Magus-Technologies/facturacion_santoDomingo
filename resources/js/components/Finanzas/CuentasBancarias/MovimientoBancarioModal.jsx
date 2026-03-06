import { useState } from 'react';
import { Modal } from '@/components/ui/modal';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Loader2 } from 'lucide-react';
import { toast } from '@/lib/sweetalert';
import { baseUrl } from '@/lib/baseUrl';

const TIPOS = ['Deposito', 'Retiro', 'Transferencia Entrada', 'Transferencia Salida', 'Pago', 'Interes', 'Comision', 'Otro'];

export default function MovimientoBancarioModal({ isOpen, onClose, cuentaId, moneda = 'PEN', onSuccess }) {
    const [form, setForm] = useState({ tipo: 'Deposito', concepto: '', monto: '', fecha_movimiento: new Date().toISOString().split('T')[0], numero_operacion: '', descripcion: '' });
    const [errors, setErrors] = useState({});
    const [saving, setSaving] = useState(false);

    const symbol = moneda === 'USD' ? '$' : moneda === 'EUR' ? '€' : 'S/';

    const handleChange = (e) => {
        const { name, value } = e.target;
        setForm(prev => ({ ...prev, [name]: value }));
        if (errors[name]) setErrors(prev => ({ ...prev, [name]: null }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setSaving(true);
        setErrors({});
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl(`/api/cuentas-bancarias/${cuentaId}/movimientos`), {
                method: 'POST',
                headers: {
                    Authorization: `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    Accept: 'application/json',
                },
                body: JSON.stringify({
                    tipo: form.tipo,
                    concepto: form.concepto,
                    monto: parseFloat(form.monto) || 0,
                    fecha_movimiento: form.fecha_movimiento,
                    numero_operacion: form.numero_operacion || null,
                    descripcion: form.descripcion || null,
                }),
            });
            const data = await res.json();
            if (data.success) {
                toast.success('Movimiento registrado');
                setForm({ tipo: 'Deposito', concepto: '', monto: '', fecha_movimiento: new Date().toISOString().split('T')[0], numero_operacion: '', descripcion: '' });
                onSuccess();
            } else if (data.errors) {
                setErrors(data.errors);
            } else {
                toast.error(data.message || 'Error al registrar');
            }
        } catch {
            toast.error('Error de conexión');
        } finally {
            setSaving(false);
        }
    };

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            title="Registrar Movimiento Bancario"
            size="sm"
            footer={
                <>
                    <Button variant="outline" onClick={onClose} disabled={saving}>Cancelar</Button>
                    <Button onClick={handleSubmit} disabled={saving} className="gap-2 bg-primary-600 hover:bg-primary-700 text-white">
                        {saving && <Loader2 className="h-4 w-4 animate-spin" />}
                        Registrar
                    </Button>
                </>
            }
        >
            <form onSubmit={handleSubmit} className="space-y-4">
                <div>
                    <Label>Tipo <span className="text-red-500">*</span></Label>
                    <Select value={form.tipo} onValueChange={(v) => setForm(p => ({ ...p, tipo: v }))}>
                        <SelectTrigger><SelectValue /></SelectTrigger>
                        <SelectContent>
                            {TIPOS.map(t => <SelectItem key={t} value={t}>{t}</SelectItem>)}
                        </SelectContent>
                    </Select>
                </div>
                <div>
                    <Label htmlFor="concepto">Concepto <span className="text-red-500">*</span></Label>
                    <Input id="concepto" name="concepto" value={form.concepto} onChange={handleChange}
                        placeholder="Descripción del movimiento" className={errors.concepto ? 'border-red-500' : ''} required />
                    {errors.concepto && <p className="text-red-500 text-xs mt-1">{errors.concepto[0]}</p>}
                </div>
                <div>
                    <Label htmlFor="monto">Monto ({symbol}) <span className="text-red-500">*</span></Label>
                    <Input id="monto" name="monto" type="number" step="0.01" min="0.01"
                        value={form.monto} onChange={handleChange} placeholder="0.00"
                        className={errors.monto ? 'border-red-500' : ''} required />
                    {errors.monto && <p className="text-red-500 text-xs mt-1">{errors.monto[0]}</p>}
                </div>
                <div>
                    <Label htmlFor="fecha_movimiento">Fecha <span className="text-red-500">*</span></Label>
                    <Input id="fecha_movimiento" name="fecha_movimiento" type="date"
                        value={form.fecha_movimiento} onChange={handleChange} required />
                </div>
                <div>
                    <Label htmlFor="numero_operacion">N° Operación / Referencia</Label>
                    <Input id="numero_operacion" name="numero_operacion"
                        value={form.numero_operacion} onChange={handleChange} placeholder="Opcional" />
                </div>
                <div>
                    <Label htmlFor="descripcion">Descripción adicional</Label>
                    <textarea id="descripcion" name="descripcion" rows={2}
                        value={form.descripcion} onChange={handleChange}
                        placeholder="Detalle adicional..."
                        className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring resize-none" />
                </div>
            </form>
        </Modal>
    );
}
