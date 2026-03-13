import { useState, useEffect, useRef } from 'react';
import { baseUrl } from '@/lib/baseUrl';
import { toast } from '@/lib/sweetalert';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Upload, X, Image as ImageIcon, Save } from 'lucide-react';

export default function FooterConfigPage() {
    const [loading, setLoading] = useState(true);
    const [saving, setSaving] = useState(false);

    const [formData, setFormData] = useState({
        slogan: '',
        subtitulo: '',
        boton_texto: '',
    });

    const [imagenFile, setImagenFile] = useState(null);
    const [imagenPreview, setImagenPreview] = useState(null);
    const [removeImagen, setRemoveImagen] = useState(false);
    const fileRef = useRef(null);

    useEffect(() => { fetchConfig(); }, []);

    const fetchConfig = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl('/api/footer-config'), {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
            });
            const data = await res.json();
            if (data.success) {
                const d = data.data;
                setFormData({
                    slogan: d.slogan || '',
                    subtitulo: d.subtitulo || '',
                    boton_texto: d.boton_texto || '',
                });
                setImagenPreview(d.imagen_url || null);
            }
        } catch {
            toast.error('Error al cargar configuración del footer');
        } finally {
            setLoading(false);
        }
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => ({ ...prev, [name]: value }));
    };

    const handleImagenChange = (e) => {
        const file = e.target.files[0];
        if (!file) return;
        const validTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif', 'image/webp'];
        if (!validTypes.includes(file.type)) {
            toast.error('Formato no válido. Use: JPG, PNG, GIF o WebP');
            return;
        }
        if (file.size > 2 * 1024 * 1024) {
            toast.error('El archivo es muy grande. Máximo 2MB');
            return;
        }
        setImagenFile(file);
        setRemoveImagen(false);
        const reader = new FileReader();
        reader.onloadend = () => setImagenPreview(reader.result);
        reader.readAsDataURL(file);
    };

    const handleRemoveImagen = () => {
        setImagenFile(null);
        setImagenPreview(null);
        setRemoveImagen(true);
        if (fileRef.current) fileRef.current.value = '';
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setSaving(true);
        try {
            const token = localStorage.getItem('auth_token');
            const fd = new FormData();
            fd.append('slogan', formData.slogan);
            fd.append('subtitulo', formData.subtitulo);
            fd.append('boton_texto', formData.boton_texto);
            if (imagenFile) fd.append('imagen', imagenFile);
            if (removeImagen) fd.append('remove_imagen', 'true');

            const res = await fetch(baseUrl('/api/footer-config'), {
                method: 'POST',
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
                body: fd,
            });
            const data = await res.json();
            if (data.success) {
                toast.success('Footer actualizado exitosamente');
                setImagenFile(null);
                setRemoveImagen(false);
                if (data.data.imagen_url) setImagenPreview(data.data.imagen_url);
            } else {
                toast.error(data.message || 'Error al guardar');
            }
        } catch {
            toast.error('Error de conexión');
        } finally {
            setSaving(false);
        }
    };

    if (loading) {
        return (
            <div className="flex items-center justify-center h-40">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-accent-600"></div>
            </div>
        );
    }

    return (
        <div className="max-w-2xl mx-auto">
            <div className="mb-6">
                <h2 className="text-lg font-semibold text-gray-800">Configuración del Banner Newsletter</h2>
                <p className="text-sm text-gray-500 mt-1">
                    Edita el contenido del banner rojo de suscripción que aparece antes del footer.
                </p>
            </div>

            {/* Vista previa */}
            <div className="mb-6 rounded-lg overflow-hidden bg-red-800 text-white p-6 flex gap-4 items-center">
                {imagenPreview && (
                    <img src={imagenPreview} alt="preview" className="w-24 h-24 object-cover rounded" />
                )}
                <div className="flex-1">
                    <p className="font-bold text-lg">
                        Somos [Empresa] {formData.slogan || <span className="opacity-50">slogan aquí</span>}
                    </p>
                    <p className="text-sm mt-1 opacity-80">{formData.subtitulo || 'Subtítulo aquí'}</p>
                    <div className="mt-3 flex gap-2 items-center">
                        <div className="bg-white rounded-full px-3 py-1 text-gray-400 text-sm w-40">Ingresa tu Email</div>
                        <div className="bg-gray-900 rounded-full px-4 py-1 text-sm">{formData.boton_texto || 'Suscríbete'}</div>
                    </div>
                </div>
            </div>

            <form onSubmit={handleSubmit} className="space-y-5 bg-white rounded-xl border border-gray-200 p-6">

                {/* Slogan */}
                <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                        Slogan <span className="text-gray-400 font-normal">(aparece después de "Somos [nombre empresa]")</span>
                    </label>
                    <Input
                        variant="outlined"
                        name="slogan"
                        value={formData.slogan}
                        onChange={handleChange}
                        placeholder="VIÑASANTODOMINGO | Somos tu mejor opción en Vino y Pisco"
                    />
                </div>

                {/* Subtítulo */}
                <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Subtítulo</label>
                    <Input
                        variant="outlined"
                        name="subtitulo"
                        value={formData.subtitulo}
                        onChange={handleChange}
                        placeholder="Recibe las mejores Ofertas SUSCRÍBETE"
                    />
                </div>

                {/* Texto del botón */}
                <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Texto del botón</label>
                    <Input
                        variant="outlined"
                        name="boton_texto"
                        value={formData.boton_texto}
                        onChange={handleChange}
                        placeholder="Suscríbete"
                    />
                </div>

                {/* Imagen decorativa */}
                <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">Imagen decorativa</label>
                    <div className="flex items-start gap-4">
                        <div className="relative">
                            <div className="w-28 h-28 border-2 border-dashed border-gray-300 rounded-lg flex items-center justify-center bg-gray-50 overflow-hidden">
                                {imagenPreview ? (
                                    <img src={imagenPreview} alt="preview" className="w-full h-full object-cover" />
                                ) : (
                                    <div className="text-center text-gray-400">
                                        <ImageIcon className="w-8 h-8 mx-auto mb-1" />
                                        <span className="text-xs">Sin imagen</span>
                                    </div>
                                )}
                            </div>
                            {imagenPreview && (
                                <button
                                    type="button"
                                    onClick={handleRemoveImagen}
                                    className="absolute -top-2 -right-2 bg-red-500 text-white rounded-full p-1 hover:bg-red-600 transition-colors"
                                >
                                    <X className="w-3 h-3" />
                                </button>
                            )}
                        </div>
                        <div className="flex-1">
                            <input
                                ref={fileRef}
                                type="file"
                                accept="image/jpeg,image/png,image/jpg,image/gif,image/webp"
                                onChange={handleImagenChange}
                                className="hidden"
                                id="footer-imagen-input"
                            />
                            <label
                                htmlFor="footer-imagen-input"
                                className="inline-flex items-center gap-2 px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-700 rounded-lg cursor-pointer transition-colors border border-gray-300 text-sm"
                            >
                                <Upload className="w-4 h-4" />
                                Seleccionar imagen
                            </label>
                            <p className="text-xs text-gray-400 mt-1">JPG, PNG, WebP. Máx 2MB.</p>
                        </div>
                    </div>
                </div>

                <div className="flex justify-end pt-2">
                    <Button type="submit" disabled={saving} className="gap-2">
                        {saving ? (
                            <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                        ) : (
                            <Save className="w-4 h-4" />
                        )}
                        Guardar cambios
                    </Button>
                </div>
            </form>
        </div>
    );
}
