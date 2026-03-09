import { useState, useEffect } from 'react';
import { baseUrl } from '@/lib/baseUrl';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { toast } from '@/lib/sweetalert';
import { X, Loader2 } from 'lucide-react';

export default function GrupoSeleccionModal({ isOpen, onClose, banner, onSuccess }) {
    const [formData, setFormData] = useState({
        imagen: '',
        nombre_cate: '',
        codi_categoria: '',
        estado: '1',
    });
    const [imageFile, setImageFile] = useState(null);
    const [imagePreview, setImagePreview] = useState(null);
    const [loading, setLoading] = useState(false);
    const [categoriasBD, setCategoriasBD] = useState([]);
    const [errors, setErrors] = useState({});

    // Cargar categorias desde la API existente
    const fetchCategoriasBD = async () => {
        try {
            const token = localStorage.getItem('auth_token');
            const response = await fetch(baseUrl('/api/categorias'), {
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Accept': 'application/json'
                }
            });
            const data = await response.json();
            if (data.success && data.data) {
                setCategoriasBD(data.data.data || data.data); // Puede venir paginado o en un array directo
            } else if (Array.isArray(data)) {
                setCategoriasBD(data); // Fallback por si retorna un array directo
            }
        } catch (error) {
            console.error('Error cargando categorias:', error);
        }
    };

    useEffect(() => {
        if (isOpen) {
            fetchCategoriasBD();
        }
        if (banner) {
            setFormData({
                imagen: banner.imagen || '',
                nombre_cate: banner.nombre_cate || '',
                codi_categoria: banner.codi_categoria || '',
                estado: banner.estado || '1',
            });

            // Usar imagen_url absoluto si existe, sino construir el asset real (evitar doble slash)
            if (banner.imagen_url) {
                setImagePreview(banner.imagen_url);
            } else if (banner.imagen && banner.imagen.startsWith('http')) {
                setImagePreview(banner.imagen);
            } else if (banner.imagen) {
                setImagePreview(baseUrl(`/storage/${banner.imagen}`));
            } else {
                setImagePreview(null);
            }
        } else {
            setFormData({
                imagen: '',
                nombre_cate: '',
                codi_categoria: '',
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
                ? baseUrl(`/api/grupo-seleccion/${banner.id_seleccion}`)
                : baseUrl('/api/grupo-seleccion');

            // Crear FormData para enviar archivo
            const formDataToSend = new FormData();
            if (banner) {
                formDataToSend.append('_method', 'PUT');
            }
            formDataToSend.append('nombre_cate', formData.nombre_cate);
            formDataToSend.append('codi_categoria', formData.codi_categoria);
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
                toast.success(banner ? 'Tarjeta actualizada exitosamente' : 'Tarjeta creada exitosamente');
                onSuccess(data.data);
                onClose();
            } else {
                if (data.errors) {
                    setErrors(data.errors);
                } else {
                    toast.error(data.message || 'Error al guardar tarjeta');
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
                        {banner ? 'Editar Tarjeta de Selección' : 'Nueva Tarjeta de Selección'}
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
                            Imagen de Tarjeta
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

                    {/* Nombre Categoria */}
                    <div>
                        <Label htmlFor="nombre_cate" className="text-sm font-medium text-gray-700">
                            Nombre de la Colección
                        </Label>
                        <Input
                            id="nombre_cate"
                            name="nombre_cate"
                            type="text"
                            placeholder="ej: Vinos Premium"
                            value={formData.nombre_cate}
                            onChange={handleChange}
                            className={errors.nombre_cate ? 'border-red-500' : ''}
                        />
                        {errors.nombre_cate && (
                            <p className="text-red-600 text-sm mt-1">
                                {Array.isArray(errors.nombre_cate) ? errors.nombre_cate[0] : errors.nombre_cate}
                            </p>
                        )}
                    </div>

                    {/* Codi Categoria */}
                    <div>
                        <Label htmlFor="codi_categoria" className="text-sm font-medium text-gray-700">
                            ID/Código de Categoría en BD
                        </Label>
                        <select
                            id="codi_categoria"
                            name="codi_categoria"
                            value={formData.codi_categoria}
                            onChange={handleChange}
                            className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 ${errors.codi_categoria ? 'border-red-500' : 'border-gray-300'}`}
                        >
                            <option value="">-- Seleccionar Categoría --</option>
                            {categoriasBD.map(cat => (
                                <option key={cat.id || cat.id_categoria} value={cat.codi_categoria || cat.id || cat.id_categoria}>
                                    {cat.nombre_cate || cat.nombre || cat.descripcion} (ID: {cat.codi_categoria || cat.id || cat.id_categoria})
                                </option>
                            ))}
                        </select>
                        <p className="text-xs text-gray-500 mt-1">
                            Elige la categoría a la cual se debe redirigir cuando el usuario le dé clic a "Explorar Colección".
                        </p>
                        {errors.codi_categoria && (
                            <p className="text-red-600 text-sm mt-1">
                                {Array.isArray(errors.codi_categoria) ? errors.codi_categoria[0] : errors.codi_categoria}
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
