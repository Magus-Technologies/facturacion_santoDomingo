import { useState, useEffect, useRef } from 'react';
import { baseUrl } from '@/lib/baseUrl';
import { Upload, Trash2, Eye, EyeOff } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Modal } from '@/components/ui/modal';
import { toast, confirmDelete } from '@/lib/sweetalert';
import MainLayout from '@/components/Layout/MainLayout';

export default function MarcasPage() {
    const [todas, setTodas] = useState([]);
    const [loading, setLoading] = useState(true);

    const [showEditar, setShowEditar] = useState(false);
    const [marcaEditar, setMarcaEditar] = useState(null);
    const [imagenFile, setImagenFile] = useState(null);
    const [preview, setPreview] = useState(null);
    const [saving, setSaving] = useState(false);
    const fileRef = useRef(null);

    useEffect(() => { fetchMarcas(); }, []);

    const fetchMarcas = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl('/api/marcas'), {
                headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' },
            });
            const data = await res.json();
            if (data.success) setTodas(data.data);
        } catch {
            toast.error('Error al cargar marcas');
        } finally {
            setLoading(false);
        }
    };

    const abrirEditar = (marca) => {
        setMarcaEditar(marca);
        setImagenFile(null);
        setPreview(marca.imagen_url || null);
        setShowEditar(true);
    };

    const handleFile = (e) => {
        const file = e.target.files[0];
        if (!file) return;
        setImagenFile(file);
        setPreview(URL.createObjectURL(file));
    };

    const handleGuardarImagen = async () => {
        if (!imagenFile) { toast.warning('Selecciona una imagen'); return; }
        setSaving(true);
        try {
            const token = localStorage.getItem('auth_token');
            const fd = new FormData();
            fd.append('imagen', imagenFile);
            fd.append('_method', 'PUT');
            const res = await fetch(baseUrl(`/api/marcas/${marcaEditar.cod_marca}`), {
                method: 'POST',
                headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' },
                body: fd,
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

    const handleEliminarImagen = (marca) => {
        confirmDelete({
            title: 'Eliminar imagen',
            message: `¿Eliminar la imagen de "${marca.nombre_marca}"?`,
            confirmText: 'Sí, eliminar',
            cancelText: 'Cancelar',
            onConfirm: async () => {
                const token = localStorage.getItem('auth_token');
                const res = await fetch(baseUrl(`/api/marcas/${marca.cod_marca}/imagen`), {
                    method: 'DELETE',
                    headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' },
                });
                const data = await res.json();
                if (data.success) { toast.success('Imagen eliminada'); fetchMarcas(); }
                else toast.error(data.message || 'Error');
            },
        });
    };

    const toggleVisibilidad = (marca) => {
        const ocultar = marca.estado === '1';
        confirmDelete({
            title: ocultar ? 'Ocultar del ecommerce' : 'Mostrar en ecommerce',
            message: ocultar
                ? `¿Ocultar "${marca.nombre_marca}" del ecommerce?`
                : `¿Mostrar "${marca.nombre_marca}" en el ecommerce?`,
            confirmText: ocultar ? 'Sí, ocultar' : 'Sí, mostrar',
            cancelText: 'Cancelar',
            onConfirm: async () => {
                const token = localStorage.getItem('auth_token');
                if (ocultar) {
                    const res = await fetch(baseUrl(`/api/marcas/${marca.cod_marca}`), {
                        method: 'DELETE',
                        headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' },
                    });
                    const data = await res.json();
                    if (data.success) { toast.success('Marca ocultada'); fetchMarcas(); }
                    else toast.error(data.message || 'Error');
                } else {
                    const fd = new FormData();
                    fd.append('estado', '1');
                    fd.append('_method', 'PUT');
                    const res = await fetch(baseUrl(`/api/marcas/${marca.cod_marca}`), {
                        method: 'POST',
                        headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' },
                        body: fd,
                    });
                    const data = await res.json();
                    if (data.success) { toast.success('Marca visible'); fetchMarcas(); }
                    else toast.error(data.message || 'Error');
                }
            },
        });
    };

    const visibles  = todas.filter(m => m.estado === '1');
    const ocultas   = todas.filter(m => m.estado !== '1');

    return (
        <MainLayout>
            <div className="mb-6">
                <h1 className="text-2xl font-bold text-gray-900">Marcas — Ecommerce</h1>
                <p className="text-sm text-gray-500 mt-1">
                    Gestiona la imagen y visibilidad de las marcas en el ecommerce.
                    Las marcas provienen del sistema de facturación.
                </p>
            </div>

            {/* Marcas visibles */}
            <MarcasList
                titulo={`Visibles en el ecommerce (${visibles.length})`}
                marcas={visibles}
                loading={loading}
                onEditarImagen={abrirEditar}
                onEliminarImagen={handleEliminarImagen}
                onToggle={toggleVisibilidad}
            />

            {/* Marcas ocultas */}
            {ocultas.length > 0 && (
                <div className="mt-6">
                    <MarcasList
                        titulo={`Ocultas (${ocultas.length})`}
                        marcas={ocultas}
                        loading={false}
                        onEditarImagen={abrirEditar}
                        onEliminarImagen={handleEliminarImagen}
                        onToggle={toggleVisibilidad}
                    />
                </div>
            )}

            {/* Modal editar imagen */}
            <Modal
                isOpen={showEditar}
                onClose={() => setShowEditar(false)}
                title={`Logo — ${marcaEditar?.nombre_marca}`}
                size="sm"
                footer={
                    <div className="flex gap-2 justify-end w-full">
                        <Button variant="outline" onClick={() => setShowEditar(false)} disabled={saving}>Cancelar</Button>
                        <Button onClick={handleGuardarImagen} disabled={!imagenFile || saving}>
                            {saving ? 'Guardando...' : 'Guardar'}
                        </Button>
                    </div>
                }
            >
                <div
                    className="border-2 border-dashed border-gray-200 rounded-lg p-6 text-center cursor-pointer hover:border-primary-400"
                    onClick={() => fileRef.current?.click()}
                >
                    {preview
                        ? <img src={preview} alt="preview" className="h-20 mx-auto object-contain" />
                        : <div className="text-gray-400 text-sm flex flex-col items-center gap-2">
                            <Upload className="h-6 w-6" />
                            <span>Haz clic para seleccionar imagen</span>
                          </div>
                    }
                </div>
                <input ref={fileRef} type="file" accept="image/*" className="hidden" onChange={handleFile} />
                <p className="text-xs text-gray-400 mt-2 text-center">Tamaño recomendado: 163 × 85 px</p>
            </Modal>
        </MainLayout>
    );
}

function MarcasList({ titulo, marcas, loading, onEditarImagen, onEliminarImagen, onToggle }) {
    return (
        <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
            <div className="px-4 py-3 border-b bg-gray-50/50">
                <h2 className="font-semibold text-gray-800 text-sm">{titulo}</h2>
            </div>
            {loading ? (
                <div className="p-8 text-center text-gray-400 text-sm">Cargando...</div>
            ) : marcas.length === 0 ? (
                <div className="p-8 text-center text-gray-400 text-sm">Sin marcas en esta sección.</div>
            ) : (
                <ul className="divide-y divide-gray-100">
                    {marcas.map(marca => (
                        <li key={marca.cod_marca} className="flex items-center gap-4 px-4 py-3">
                            {marca.imagen_url
                                ? <img src={marca.imagen_url} alt={marca.nombre_marca} className="h-10 w-24 object-contain shrink-0" />
                                : <div className="h-10 w-24 bg-gray-100 rounded flex items-center justify-center shrink-0">
                                    <span className="text-gray-300 text-xs">Sin logo</span>
                                  </div>
                            }
                            <div className="flex-1 min-w-0">
                                <p className="font-medium text-gray-900 text-sm truncate">{marca.nombre_marca}</p>
                                <p className="text-xs font-mono text-gray-400">{marca.cod_marca}</p>
                            </div>
                            <div className="flex gap-1 shrink-0">
                                <Button variant="ghost" size="sm" onClick={() => onEditarImagen(marca)} title="Subir / cambiar logo">
                                    <Upload className="h-4 w-4 text-gray-500" />
                                </Button>
                                {marca.imagen_url && (
                                    <Button variant="ghost" size="sm" onClick={() => onEliminarImagen(marca)} title="Eliminar imagen">
                                        <Trash2 className="h-4 w-4 text-red-400" />
                                    </Button>
                                )}
                                <Button variant="ghost" size="sm" onClick={() => onToggle(marca)}
                                    title={marca.estado === '1' ? 'Ocultar del ecommerce' : 'Mostrar en ecommerce'}>
                                    {marca.estado === '1'
                                        ? <EyeOff className="h-4 w-4 text-gray-400" />
                                        : <Eye className="h-4 w-4 text-green-500" />
                                    }
                                </Button>
                            </div>
                        </li>
                    ))}
                </ul>
            )}
        </div>
    );
}
