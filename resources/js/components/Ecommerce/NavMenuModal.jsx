import { useState, useEffect } from 'react';
import { baseUrl } from '@/lib/baseUrl';
import { toast } from '@/lib/sweetalert';
import { Modal } from '@/components/ui/modal';
import { Button } from '@/components/ui/button';

export default function NavMenuModal({ isOpen, item, parentId, allItems, onClose, onSaved }) {
    const isEditing = !!item;

    const [form, setForm] = useState({
        label: '',
        url: '#',
        parent_id: '',
        orden: 0,
        estado: '1',
        target: '_self',
    });
    const [saving, setSaving] = useState(false);

    useEffect(() => {
        if (isOpen) {
            if (isEditing) {
                setForm({
                    label:     item.label,
                    url:       item.url || '#',
                    parent_id: item.parent_id ?? '',
                    orden:     item.orden ?? 0,
                    estado:    item.estado,
                    target:    item.target || '_self',
                });
            } else {
                setForm({
                    label: '',
                    url: '#',
                    parent_id: parentId ?? '',
                    orden: 0,
                    estado: '1',
                    target: '_self',
                });
            }
        }
    }, [isOpen, item, parentId]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        setSaving(true);
        try {
            const token = localStorage.getItem('auth_token');
            const payload = {
                ...form,
                parent_id: form.parent_id === '' ? null : Number(form.parent_id),
                orden: Number(form.orden),
            };
            const url = isEditing
                ? baseUrl(`/api/nav-menu/${item.id}`)
                : baseUrl('/api/nav-menu');
            const res = await fetch(url, {
                method: isEditing ? 'PUT' : 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                },
                body: JSON.stringify(payload),
            });
            const data = await res.json();
            if (data.success) {
                toast.success(isEditing ? 'Ítem actualizado' : 'Ítem creado');
                onSaved();
            } else {
                toast.error(data.message || 'Error al guardar');
            }
        } catch {
            toast.error('Error de conexión');
        } finally {
            setSaving(false);
        }
    };

    const topLevelItems = allItems?.filter(i => !i.parent_id && i.id !== item?.id) || [];

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            title={isEditing ? 'Editar ítem de menú' : parentId ? 'Nuevo subitem' : 'Nuevo ítem de menú'}
            size="sm"
            footer={
                <div className="flex gap-2 justify-end w-full">
                    <Button variant="outline" onClick={onClose} disabled={saving}>Cancelar</Button>
                    <Button onClick={handleSubmit} disabled={saving}>
                        {saving ? 'Guardando...' : isEditing ? 'Actualizar' : 'Crear'}
                    </Button>
                </div>
            }
        >
            <form onSubmit={handleSubmit} className="space-y-4">
                <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Etiqueta *</label>
                    <input
                        className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                        value={form.label}
                        onChange={e => setForm(p => ({ ...p, label: e.target.value }))}
                        placeholder="Ej: Inicio, Productos..."
                        required
                    />
                </div>
                <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">URL</label>
                    <input
                        className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm font-mono focus:outline-none focus:ring-2 focus:ring-primary-500"
                        value={form.url}
                        onChange={e => setForm(p => ({ ...p, url: e.target.value }))}
                        placeholder="Ej: index.php, shop-list-prod.php, #"
                    />
                </div>
                <div className="grid grid-cols-2 gap-3">
                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-1">Orden</label>
                        <input
                            type="number"
                            className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                            value={form.orden}
                            onChange={e => setForm(p => ({ ...p, orden: e.target.value }))}
                            min={0}
                        />
                    </div>
                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-1">Target</label>
                        <select
                            className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                            value={form.target}
                            onChange={e => setForm(p => ({ ...p, target: e.target.value }))}
                        >
                            <option value="_self">Misma pestaña</option>
                            <option value="_blank">Nueva pestaña</option>
                        </select>
                    </div>
                </div>
                {!parentId && (
                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-1">Ítem padre (opcional)</label>
                        <select
                            className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                            value={form.parent_id}
                            onChange={e => setForm(p => ({ ...p, parent_id: e.target.value }))}
                        >
                            <option value="">— Ninguno (ítem principal) —</option>
                            {topLevelItems.map(i => (
                                <option key={i.id} value={i.id}>{i.label}</option>
                            ))}
                        </select>
                    </div>
                )}
                <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Estado</label>
                    <select
                        className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                        value={form.estado}
                        onChange={e => setForm(p => ({ ...p, estado: e.target.value }))}
                    >
                        <option value="1">Activo</option>
                        <option value="0">Inactivo</option>
                    </select>
                </div>
            </form>
        </Modal>
    );
}
