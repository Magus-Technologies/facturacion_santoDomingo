import { useState, useEffect } from 'react';
import { Modal } from '@/components/ui/modal';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Loader2 } from 'lucide-react';
import { toast } from '@/lib/sweetalert';
import { baseUrl } from '@/lib/baseUrl';

export default function CajaCrearModal({ isOpen, onClose, onSuccess }) {
    const [form, setForm] = useState({ nombre: '', descripcion: '', id_responsable: '' });
    const [metodosSeleccionados, setMetodosSeleccionados] = useState([]);
    const [usuarios, setUsuarios] = useState([]);
    const [metodos, setMetodos] = useState([]);
    const [errors, setErrors] = useState({});
    const [saving, setSaving] = useState(false);
    const [loadingMetodos, setLoadingMetodos] = useState(false);

    useEffect(() => {
        if (isOpen) {
            fetchUsuarios();
            fetchMetodos();
        }
    }, [isOpen]);

    const fetchUsuarios = async () => {
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl('/api/users'), {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
            });
            const data = await res.json();
            if (data.data) setUsuarios(data.data.data ?? data.data);
        } catch { /* silencioso */ }
    };

    const fetchMetodos = async () => {
        setLoadingMetodos(true);
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl('/api/metodos-pago'), {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
            });
            const data = await res.json();
            if (data.success) {
                const lista = Array.isArray(data.data) ? data.data : (data.data?.data ?? []);
                setMetodos(lista.filter(m => m.activo));
            }
        } catch { /* silencioso */ }
        finally { setLoadingMetodos(false); }
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setForm(prev => ({ ...prev, [name]: value }));
        if (errors[name]) setErrors(prev => ({ ...prev, [name]: null }));
    };

    const toggleMetodo = (id) => {
        setMetodosSeleccionados(prev =>
            prev.includes(id) ? prev.filter(m => m !== id) : [...prev, id]
        );
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (metodosSeleccionados.length === 0) {
            toast.warning('Debes asignar al menos un método de pago a la caja');
            return;
        }
        setSaving(true);
        setErrors({});
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl('/api/cajas'), {
                method: 'POST',
                headers: {
                    Authorization: `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    Accept: 'application/json',
                },
                body: JSON.stringify({
                    nombre: form.nombre,
                    descripcion: form.descripcion || null,
                    id_responsable: parseInt(form.id_responsable),
                    metodos_pago: metodosSeleccionados,
                }),
            });
            const data = await res.json();
            if (data.success) {
                toast.success('Caja creada exitosamente');
                setForm({ nombre: '', descripcion: '', id_responsable: '' });
                setMetodosSeleccionados([]);
                onSuccess();
                onClose();
            } else if (data.errors) {
                setErrors(data.errors);
            } else {
                toast.error(data.message || 'Error al crear la caja');
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
            title="Crear Nueva Caja"
            size="md"
            footer={
                <>
                    <Button variant="outline" onClick={onClose} disabled={saving}>Cancelar</Button>
                    <Button onClick={handleSubmit} disabled={saving} className="gap-2 bg-primary-600 hover:bg-primary-700 text-white">
                        {saving && <Loader2 className="h-4 w-4 animate-spin" />}
                        Crear Caja
                    </Button>
                </>
            }
        >
            <form onSubmit={handleSubmit} className="space-y-4">
                {/* Nombre */}
                <div>
                    <Label htmlFor="nombre">Nombre de la Caja <span className="text-red-500">*</span></Label>
                    <Input
                        id="nombre"
                        name="nombre"
                        value={form.nombre}
                        onChange={handleChange}
                        placeholder="Ej: Caja Principal, Caja 1"
                        className={errors.nombre ? 'border-red-500' : ''}
                    />
                    {errors.nombre && <p className="text-red-500 text-xs mt-1">{errors.nombre[0]}</p>}
                </div>

                {/* Responsable */}
                <div>
                    <Label htmlFor="id_responsable">Responsable <span className="text-red-500">*</span></Label>
                    <select
                        id="id_responsable"
                        name="id_responsable"
                        value={form.id_responsable}
                        onChange={handleChange}
                        className={`w-full rounded-md border px-3 py-2 text-sm bg-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring ${errors.id_responsable ? 'border-red-500' : 'border-input'}`}
                    >
                        <option value="">Seleccionar responsable...</option>
                        {usuarios.map(u => (
                            <option key={u.id} value={u.id}>{u.name}</option>
                        ))}
                    </select>
                    {errors.id_responsable && <p className="text-red-500 text-xs mt-1">{errors.id_responsable[0]}</p>}
                    <p className="text-xs text-gray-500 mt-1">Usuario que cuadra y cierra esta caja al final del día</p>
                </div>

                {/* Descripción */}
                <div>
                    <Label htmlFor="descripcion">Descripción</Label>
                    <textarea
                        id="descripcion"
                        name="descripcion"
                        rows={2}
                        value={form.descripcion}
                        onChange={handleChange}
                        placeholder="Descripción opcional..."
                        className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring resize-none"
                    />
                </div>

                {/* Métodos de pago */}
                <div>
                    <Label>Métodos de Pago Aceptados <span className="text-red-500">*</span></Label>
                    <p className="text-xs text-gray-500 mb-2">Para el arqueo y cierre de caja</p>

                    {loadingMetodos ? (
                        <div className="flex items-center gap-2 text-sm text-gray-500 py-2">
                            <Loader2 className="h-4 w-4 animate-spin" /> Cargando...
                        </div>
                    ) : metodos.length === 0 ? (
                        <p className="text-sm text-amber-600 bg-amber-50 border border-amber-200 rounded px-3 py-2">
                            No hay métodos configurados. Crea uno en Finanzas → Métodos de Pago.
                        </p>
                    ) : (
                        <div className="border border-input rounded-md divide-y max-h-48 overflow-y-auto">
                            {metodos.map(m => (
                                <label key={m.id_metodo_pago} className="flex items-center gap-3 px-3 py-2 cursor-pointer hover:bg-gray-50">
                                    <input
                                        type="checkbox"
                                        checked={metodosSeleccionados.includes(m.id_metodo_pago)}
                                        onChange={() => toggleMetodo(m.id_metodo_pago)}
                                        className="h-4 w-4 rounded border-gray-300 text-primary-600"
                                    />
                                    <span className="text-sm flex-1">{m.nombre}</span>
                                    <span className="text-xs text-gray-400">{m.es_efectivo ? 'Efectivo' : 'Digital'}</span>
                                </label>
                            ))}
                        </div>
                    )}
                </div>
            </form>
        </Modal>
    );
}

