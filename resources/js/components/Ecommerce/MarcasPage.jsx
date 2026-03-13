import { useState, useEffect, useRef } from 'react';
import { baseUrl } from '@/lib/baseUrl';
import { Plus, Edit2, Trash2, Upload } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Modal } from '@/components/ui/modal';
import { toast, confirmDelete } from '@/lib/sweetalert';
import MainLayout from '@/components/Layout/MainLayout';

export default function MarcasPage() {
    const [todas, setTodas] = useState([]);
    const [loading, setLoading] = useState(true);

    // Modal agregar
    const [showAgregar, setShowAgregar] = useState(false);
    const [seleccionada, setSeleccionada] = useState('');
    const [imagenFile, setImagenFile] = useState(null);
    const [preview, setPreview] = useState(null);
    const fileRefAgregar = useRef(null);

    // Modal editar imagen
    const [showEditar, setShowEditar] = useState(false);
    const [marcaEditar, setMarcaEditar] = useState(null);
    const [imagenEditFile, setImagenEditFile] = useState(null);
    const [previewEdit, setPreviewEdit] = useState(null);
    const fileRefEditar = useRef(null);

    const [saving, setSaving] = useState(false);

    useEffect(() => { fetchMarcas(); }, []);

    const fetchMarcas = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl('/api/marcas'), {
                headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' }
            });
            const data = await res.json();
            if (data.success) setTodas(data.data);
        } catch {
            toast.error('Error al cargar marcas');
        } finally {
            setLoading(false);
        }
    };

    const activas   = todas.filter(m => m.estado === '1');
    const inactivas = todas.filter(m => m.estado !== '1');

    // ── Agregar al carousel ──────────────────────────────────────────────────
    const abrirAgregar = () => {
        setSeleccionada('');
        setImagenFile(null);
        setPreview(null);
        setShowAgregar(true);
    };

    const handleFileAgregar = (e) => {
        const file = e.target.files[0];
        if (!file) return;
        setImagenFile(file);
        setPreview(URL.createObjectURL(file));
    };

    const handleAgregar = async () => {
        if (!seleccionada) { toast.warning('Selecciona una marca'); return; }
        setSaving(true);
        try {
            const token = localStorage.getItem('auth_token');
            const formData = new FormData();
            formData.append('estado', '1');
            formData.append('_method', 'PUT');
            if (imagenFile) formData.append('imagen', imagenFile);
            const res = await fetch(baseUrl(`/api/marcas/${seleccionada}`), {
                method: 'POST',
                headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' },
                body: formData,
            });
            const data = await res.json();
            if (data.success) {
                toast.success('Marca agregada al carousel');
                setShowAgregar(false);
                fetchMarcas();
            } else {
                toast.error(data.message || 'Error');
            }
        } catch {
            toast.error('Error de conexión');
        } finally {
            setSaving(false);
        }
    };

    // ── Editar imagen ────────────────────────────────────────────────────────
    const abrirEditar = (marca) => {
        setMarcaEditar(marca);
        setImagenEditFile(null);
        setPreviewEdit(marca.imagen_url || null);
        setShowEditar(true);
    };

    const handleFileEditar = (e) => {
        const file = e.target.files[0];
        if (!file) return;
        setImagenEditFile(file);
        setPreviewEdit(URL.createObjectURL(file));
    };

    const handleEditar = async () => {
        if (!imagenEditFile) { toast.warning('Selecciona una imagen'); return; }
        setSaving(true);
        try {
            const token = localStorage.getItem('auth_token');
            const formData = new FormData();
            formData.append('_method', 'PUT');
            formData.append('imagen', imagenEditFile);
            const res = await fetch(baseUrl(`/api/marcas/${marcaEditar.cod_marca}`), {
                method: 'POST',
                headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' },
                body: formData,
            });
            const data = await res.json();
            if (data.success) {
                toast.success('Imagen actualizada');
                setShowEditar(false);
                fetchMarcas();
            } else {
                toast.error(data.message || 'Error');
            }
        } catch {
            toast.error('Error de conexión');
        } finally {
            setSaving(false);
        }
    };

    // ── Quitar del carousel ──────────────────────────────────────────────────
    const handleQuitar = (marca) => {
        confirmDelete({
            title: 'Quitar marca',
            message: `¿Quitar "${marca.nombre_marca}" del carousel?`,
            confirmText: 'Sí, quitar',
            cancelText: 'Cancelar',
            onConfirm: async () => {
                const token = localStorage.getItem('auth_token');
                const formData = new FormData();
                formData.append('estado', '0');
                formData.append('_method', 'PUT');
                const res = await fetch(baseUrl(`/api/marcas/${marca.cod_marca}`), {
                    method: 'POST',
                    headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' },
                    body: formData,
                });
                const data = await res.json();
                if (data.success) { toast.success('Marca quitada'); fetchMarcas(); }
                else toast.error(data.message || 'Error');
            },
        });
    };

    return (
        <MainLayout>
            <div className="mb-6 flex items-center justify-between">
                <div>
                    <h1 className="text-2xl font-bold text-gray-900">Nuestras Marcas — Carousel</h1>
                    <p className="text-sm text-gray-500 mt-1">Gestiona qué marcas aparecen en el carousel del ecommerce</p>
                </div>
                <Button onClick={abrirAgregar} className="gap-2">
                    <Plus className="h-4 w-4" />
                    Agregar marca
                </Button>
            </div>

            {/* Lista activas */}
            <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                <div className="px-4 py-3 border-b bg-gray-50/50">
                    <h2 className="font-semibold text-gray-800 text-sm">
                        Marcas visibles en el carousel ({activas.length})
                    </h2>
                </div>
                {loading ? (
                    <div className="p-8 text-center text-gray-400 text-sm">Cargando...</div>
                ) : activas.length === 0 ? (
                    <div className="p-8 text-center text-gray-400 text-sm">
                        No hay marcas. Usa "Agregar marca".
                    </div>
                ) : (
                    <ul className="divide-y divide-gray-100">
                        {activas.map(marca => (
                            <li key={marca.cod_marca} className="flex items-center gap-4 px-4 py-3">
                                {marca.imagen_url
                                    ? <img src={marca.imagen_url} alt={marca.nombre_marca} className="h-10 w-20 object-contain shrink-0" />
                                    : <div className="h-10 w-20 bg-gray-100 rounded flex items-center justify-center shrink-0">
                                        <span className="text-gray-300 text-xs">Sin logo</span>
                                      </div>
                                }
                                <div className="flex-1">
                                    <p className="font-medium text-gray-900 text-sm">{marca.nombre_marca}</p>
                                    <p className="text-xs font-mono text-gray-400">{marca.cod_marca}</p>
                                </div>
                                <div className="flex gap-1">
                                    <Button variant="ghost" size="sm" onClick={() => abrirEditar(marca)} title="Editar imagen">
                                        <Edit2 className="h-4 w-4 text-gray-500" />
                                    </Button>
                                    <Button variant="ghost" size="sm" onClick={() => handleQuitar(marca)} title="Quitar del carousel">
                                        <Trash2 className="h-4 w-4 text-red-400" />
                                    </Button>
                                </div>
                            </li>
                        ))}
                    </ul>
                )}
            </div>

            {/* Modal Agregar */}
            <Modal
                isOpen={showAgregar}
                onClose={() => setShowAgregar(false)}
                title="Agregar marca al carousel"
                size="sm"
                footer={
                    <div className="flex gap-2 justify-end w-full">
                        <Button variant="outline" onClick={() => setShowAgregar(false)} disabled={saving}>Cancelar</Button>
                        <Button onClick={handleAgregar} disabled={!seleccionada || saving}>
                            {saving ? 'Agregando...' : 'Agregar'}
                        </Button>
                    </div>
                }
            >
                <div className="space-y-4">
                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-1">Marca *</label>
                        <select
                            className="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                            value={seleccionada}
                            onChange={e => setSeleccionada(e.target.value)}
                        >
                            <option value="">— Seleccionar —</option>
                            {inactivas.map(m => (
                                <option key={m.cod_marca} value={m.cod_marca}>
                                    {m.nombre_marca} ({m.cod_marca})
                                </option>
                            ))}
                        </select>
                    </div>
                    <div>
                        <label className="block text-sm font-medium text-gray-700 mb-1">Logo (opcional)</label>
                        <div
                            className="border-2 border-dashed border-gray-200 rounded-lg p-4 text-center cursor-pointer hover:border-primary-400"
                            onClick={() => fileRefAgregar.current?.click()}
                        >
                            {preview
                                ? <img src={preview} alt="preview" className="h-14 mx-auto object-contain" />
                                : <div className="text-gray-400 text-sm flex flex-col items-center gap-1">
                                    <Upload className="h-5 w-5" />
                                    <span>Subir logo</span>
                                  </div>
                            }
                        </div>
                        <input ref={fileRefAgregar} type="file" accept="image/*" className="hidden" onChange={handleFileAgregar} />
                    </div>
                </div>
            </Modal>

            {/* Modal Editar imagen */}
            <Modal
                isOpen={showEditar}
                onClose={() => setShowEditar(false)}
                title={`Editar logo — ${marcaEditar?.nombre_marca}`}
                size="sm"
                footer={
                    <div className="flex gap-2 justify-end w-full">
                        <Button variant="outline" onClick={() => setShowEditar(false)} disabled={saving}>Cancelar</Button>
                        <Button onClick={handleEditar} disabled={!imagenEditFile || saving}>
                            {saving ? 'Guardando...' : 'Guardar'}
                        </Button>
                    </div>
                }
            >
                <div
                    className="border-2 border-dashed border-gray-200 rounded-lg p-6 text-center cursor-pointer hover:border-primary-400"
                    onClick={() => fileRefEditar.current?.click()}
                >
                    {previewEdit
                        ? <img src={previewEdit} alt="preview" className="h-20 mx-auto object-contain" />
                        : <div className="text-gray-400 text-sm flex flex-col items-center gap-2">
                            <Upload className="h-6 w-6" />
                            <span>Haz clic para seleccionar imagen</span>
                          </div>
                    }
                </div>
                <input ref={fileRefEditar} type="file" accept="image/*" className="hidden" onChange={handleFileEditar} />
            </Modal>
        </MainLayout>
    );
}
