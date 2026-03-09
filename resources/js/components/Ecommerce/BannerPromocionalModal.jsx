import { useState, useEffect } from 'react';
import { baseUrl } from '@/lib/baseUrl';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { toast } from '@/lib/sweetalert';
import { X, Loader2 } from 'lucide-react';

export default function BannerModal({ isOpen, onClose, banner, onSuccess }) {
    const [formData, setFormData] = useState({
        imagen: '',
        url: '',
        estado: '1',
    });
    const [imageFile, setImageFile] = useState(null);
    const [imagePreview, setImagePreview] = useState(null);
    const [loading, setLoading] = useState(false);
    const [errors, setErrors] = useState({});

    useEffect(() => {
        if (banner) {
            setFormData({
                imagen: banner.imagen || '',
                url: banner.url || '',
                estado: banner.estado || '1',
            });
            setImagePreview(banner.imagen_url || banner.imagen || null);
        } else {
            setFormData({
                imagen: '',
                url: '',
                estado: '1',
            });
            setImagePreview(null);
        }
        setImageFile(null);
        setErrors({});
    }, [banner, isOpen]);

    const handleImageChange = (e) => {
        const file = e.target.files?.[0];
        if (file) {
            setImageFile(file);
            setFormData(prev => ({
                ...prev,
                imagen: file.name
            }));

            // Crear preview
            const reader = new FileReader();
            reader.onloadend = () => {
                setImagePreview(reader.result);
            };
            reader.readAsDataURL(file);
        }
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => ({
            ...prev,
            [name]: value
        }));
        if (errors[name]) {
            setErrors(prev => ({
                ...prev,
                [name]: null
            }));
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setErrors({});

        try {
            const token = localStorage.getItem('auth_token');
            const method = 'POST';

            // Usar endpoint de test público si es crear, protegido si es editar
            const url = banner
                ? baseUrl(`/api/banners-promocionales/${banner.id}`)
                : baseUrl('/api/public/banners-promocionales-test');

            // Crear FormData para enviar archivo
            const formDataToSend = new FormData();
            if (banner) {
                formDataToSend.append('_method', 'PUT');
            }
            formDataToSend.append('url', formData.url);
            formDataToSend.append('estado', formData.estado);

            // Si hay archivo nuevo, agregarlo
            if (imageFile) {
                formDataToSend.append('imagen', imageFile);
                console.log('Archivo agregado:', imageFile.name, imageFile.size, imageFile.type);
            } else {
                console.log('No hay archivo nuevo');
            }

            // Debug: log de FormData
            console.log('FormData entries:');
            for (let [key, value] of formDataToSend.entries()) {
                console.log(`  ${key}:`, value);
            }

            const headers = {
                'Accept': 'application/json'
            };

            // Solo agregar token si es editar
            if (banner && token) {
                headers['Authorization'] = `Bearer ${token}`;
            }

            const response = await fetch(url, {
                method,
                headers,
                body: formDataToSend,
            });

            const data = await response.json();

            if (data.success) {
                toast.success(banner ? 'Banner actualizado exitosamente' : 'Banner creado exitosamente');
                onSuccess(data.data);
                onClose();
            } else {
                if (data.errors) {
                    setErrors(data.errors);
                } else {
                    toast.error(data.message || 'Error al guardar banner');
                }
            }
        } catch (err) {
            toast.error('Error de conexión al servidor');
            console.error('Error:', err);
        } finally {
            setLoading(false);
        }
    };

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
            <div className="bg-white rounded-lg shadow-xl max-w-md w-full mx-4">
                {/* Header */}
                <div className="flex items-center justify-between p-6 border-b border-gray-200">
                    <h2 className="text-lg font-semibold text-gray-900">
                        {banner ? 'Editar Promoción' : 'Nueva Promoción'}
                    </h2>
                    <button
                        onClick={onClose}
                        className="text-gray-400 hover:text-gray-600"
                    >
                        <X className="h-5 w-5" />
                    </button>
                </div>

                {/* Form */}
                <form onSubmit={handleSubmit} className="p-6 space-y-4">
                    {/* Imagen */}
                    <div>
                        <Label htmlFor="imagen" className="text-sm font-medium text-gray-700">
                            Imagen de Promoción
                        </Label>

                        {/* Preview de imagen */}
                        {imagePreview && (
                            <div className="mb-3 relative">
                                <img
                                    src={imagePreview}
                                    alt="Preview"
                                    className="w-full h-40 object-cover rounded-lg border border-gray-300"
                                />
                                <button
                                    type="button"
                                    onClick={() => {
                                        setImageFile(null);
                                        setImagePreview(null);
                                        setFormData(prev => ({ ...prev, imagen: '' }));
                                    }}
                                    className="absolute top-2 right-2 bg-red-500 text-white rounded-full p-1 hover:bg-red-600"
                                >
                                    <X className="h-4 w-4" />
                                </button>
                            </div>
                        )}

                        <Input
                            id="imagen"
                            name="imagen"
                            type="file"
                            accept="image/*"
                            onChange={handleImageChange}
                            className={errors.imagen ? 'border-red-500' : ''}
                        />
                        <p className="text-xs text-gray-500 mt-1">
                            Formatos soportados: JPG, PNG, GIF, WebP
                        </p>
                        {errors.imagen && (
                            <p className="text-red-600 text-sm mt-1">
                                {Array.isArray(errors.imagen) ? errors.imagen[0] : errors.imagen}
                            </p>
                        )}
                    </div>

                    {/* URL */}
                    <div>
                        <Label htmlFor="url" className="text-sm font-medium text-gray-700">
                            URL de Destino
                        </Label>
                        <Input
                            id="url"
                            name="url"
                            type="text"
                            placeholder="ej: https://ejemplo.com"
                            value={formData.url}
                            onChange={handleChange}
                            className={errors.url ? 'border-red-500' : ''}
                        />
                        {errors.url && (
                            <p className="text-red-600 text-sm mt-1">
                                {Array.isArray(errors.url) ? errors.url[0] : errors.url}
                            </p>
                        )}
                    </div>

                    {/* Estado */}
                    <div>
                        <Label htmlFor="estado" className="text-sm font-medium text-gray-700">
                            Estado
                        </Label>
                        <select
                            id="estado"
                            name="estado"
                            value={formData.estado}
                            onChange={handleChange}
                            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                        >
                            <option value="1">Activo</option>
                            <option value="0">Inactivo</option>
                        </select>
                        {errors.estado && (
                            <p className="text-red-600 text-sm mt-1">
                                {Array.isArray(errors.estado) ? errors.estado[0] : errors.estado}
                            </p>
                        )}
                    </div>

                    {/* Buttons */}
                    <div className="flex gap-3 pt-4">
                        <Button
                            type="button"
                            variant="outline"
                            onClick={onClose}
                            disabled={loading}
                            className="flex-1"
                        >
                            Cancelar
                        </Button>
                        <Button
                            type="submit"
                            disabled={loading}
                            className="flex-1 gap-2"
                        >
                            {loading && <Loader2 className="h-4 w-4 animate-spin" />}
                            {banner ? 'Actualizar' : 'Crear'}
                        </Button>
                    </div>
                </form>
            </div>
        </div>
    );
}
