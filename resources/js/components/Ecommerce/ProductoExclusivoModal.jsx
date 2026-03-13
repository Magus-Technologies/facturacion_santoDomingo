import { useState, useEffect } from 'react';
import { baseUrl } from '@/lib/baseUrl';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { toast } from '@/lib/sweetalert';
import { X, Loader2, Search } from 'lucide-react';

export default function ProductoExclusivoModal({ isOpen, onClose, item, onSuccess, defaultTab = 'nuevos_ingresos' }) {
    const [formData, setFormData] = useState({
        tab_name: defaultTab,
        producto_id: '',
        orden: 0,
        estado: '1',
    });
    const [imageFile, setImageFile] = useState(null);
    const [imagePreview, setImagePreview] = useState(null);
    const [search, setSearch] = useState('');
    const [products, setProducts] = useState([]);
    const [selectedProduct, setSelectedProduct] = useState(null);
    const [searching, setSearching] = useState(false);
    const [loading, setLoading] = useState(false);
    const [errors, setErrors] = useState({});

    useEffect(() => {
        if (item) {
            setFormData({
                tab_name: item.tab_name || defaultTab,
                producto_id: item.producto_id || '',
                orden: item.orden || 0,
                estado: item.estado || '1',
            });
            setSelectedProduct(item.producto);
            setSearch(item.producto?.nombre || '');

            if (item.imagen_url) {
                setImagePreview(item.imagen_url);
            } else if (item.imagen) {
                setImagePreview(baseUrl(`/storage/${item.imagen}`));
            } else {
                setImagePreview(null);
            }
        } else {
            setFormData({
                tab_name: defaultTab,
                producto_id: '',
                orden: 0,
                estado: '1',
            });
            setSelectedProduct(null);
            setSearch('');
            setImagePreview(null);
        }
        setImageFile(null);
        setErrors({});
    }, [item, isOpen, defaultTab]);

    const handleImageChange = (e) => {
        const file = e.target.files?.[0];
        if (file) {
            setImageFile(file);
            const reader = new FileReader();
            reader.onloadend = () => {
                setImagePreview(reader.result);
            };
            reader.readAsDataURL(file);
        }
    };

    const handleSearch = async (val) => {
        setSearch(val);
        if (val.length < 3) {
            setProducts([]);
            return;
        }

        try {
            setSearching(true);
            const token = localStorage.getItem('auth_token');
            const response = await fetch(baseUrl(`/api/productos?search=${val}`), {
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Accept': 'application/json'
                }
            });
            const data = await response.json();
            if (data.success) {
                setProducts(data.data.data || data.data);
            }
        } catch (error) {
            console.error('Error buscando productos:', error);
        } finally {
            setSearching(false);
        }
    };

    const selectProduct = (prod) => {
        setSelectedProduct(prod);
        setFormData(prev => ({ ...prev, producto_id: prod.id_producto }));
        setSearch(prod.nombre);
        setProducts([]);
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prev => ({ ...prev, [name]: value }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!formData.producto_id) {
            toast.error('Debes seleccionar un producto');
            return;
        }

        setLoading(true);
        setErrors({});

        try {
            const token = localStorage.getItem('auth_token');
            const url = item
                ? baseUrl(`/api/productos-exclusivos/${item.id_exclusivo}`)
                : baseUrl('/api/productos-exclusivos');

            const fData = new FormData();
            if (item) fData.append('_method', 'PUT');
            fData.append('tab_name', formData.tab_name);
            fData.append('producto_id', formData.producto_id);
            fData.append('orden', formData.orden);
            fData.append('estado', formData.estado);
            if (imageFile) fData.append('imagen', imageFile);

            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Accept': 'application/json'
                },
                body: fData,
            });

            const data = await response.json();

            if (data.success) {
                toast.success(item ? 'Actualizado correctamente' : 'Agregado correctamente');
                onSuccess(data.data);
                onClose();
            } else {
                if (data.errors) {
                    setErrors(data.errors);
                } else {
                    toast.error(data.message || 'Error al guardar');
                }
            }
        } catch (err) {
            toast.error('Error de conexión');
        } finally {
            setLoading(false);
        }
    };

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
            <div className="bg-white rounded-lg shadow-xl max-w-lg w-full overflow-hidden">
                <div className="flex items-center justify-between p-4 border-b">
                    <h2 className="text-lg font-semibold">
                        {item ? 'Editar Producto Exclusivo' : 'Agregar Producto Exclusivo'}
                    </h2>
                    <button onClick={onClose} className="text-gray-400 hover:text-gray-600">
                        <X className="h-5 w-5" />
                    </button>
                </div>

                <form onSubmit={handleSubmit} className="p-4 space-y-4">
                    {/* Imagen Personalizada */}
                    <div>
                        <Label>Imagen Exclusiva (Opcional)</Label>
                        {imagePreview && (
                            <div className="mb-2 relative w-32 h-32 mx-auto">
                                <img src={imagePreview} className="w-full h-full object-cover rounded border" />
                                <button
                                    type="button"
                                    onClick={() => { setImageFile(null); setImagePreview(null); }}
                                    className="absolute -top-2 -right-2 bg-red-500 text-white rounded-full p-1 hover:bg-red-600"
                                >
                                    <X className="h-3 w-3" />
                                </button>
                            </div>
                        )}
                        <Input type="file" accept="image/*" onChange={handleImageChange} className="mt-1" />
                        <p className="text-[10px] text-gray-500 mt-1">Si no subes una imagen, se usará la del producto por defecto.</p>
                        {errors.imagen && <p className="text-red-500 text-xs mt-1">{errors.imagen[0]}</p>}
                    </div>

                    {/* Buscador de Producto */}
                    <div className="relative">
                        <Label>Buscar Producto</Label>
                        <div className="relative mt-1">
                            <Input
                                type="text"
                                value={search}
                                onChange={(e) => handleSearch(e.target.value)}
                                placeholder="Escribe nombre o código..."
                                className={errors.producto_id ? 'border-red-500 pr-10' : 'pr-10'}
                                disabled={!!selectedProduct && !!item}
                            />
                            <div className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400">
                                {searching ? <Loader2 className="h-4 w-4 animate-spin" /> : <Search className="h-4 w-4" />}
                            </div>
                        </div>

                        {/* Dropdown de resultados */}
                        {products.length > 0 && (
                            <div className="absolute z-10 w-full mt-1 bg-white border rounded-md shadow-lg max-h-60 overflow-auto">
                                {products.map(prod => (
                                    <button
                                        key={prod.id_producto}
                                        type="button"
                                        onClick={() => selectProduct(prod)}
                                        className="w-full text-left px-4 py-2 hover:bg-gray-100 text-sm border-b last:border-0"
                                    >
                                        <div className="font-medium">{prod.nombre}</div>
                                        <div className="text-xs text-gray-500">{prod.codigo} - S/ {prod.precio}</div>
                                    </button>
                                ))}
                            </div>
                        )}

                        {selectedProduct && (
                            <div className="mt-2 p-2 bg-accent-50 rounded-md border border-accent-200 flex items-center justify-between">
                                <div className="text-sm">
                                    <span className="font-semibold text-accent-700">Seleccionado:</span> {selectedProduct.nombre}
                                </div>
                                {!item && (
                                    <button
                                        type="button"
                                        onClick={() => {
                                            setSelectedProduct(null);
                                            setFormData(prev => ({ ...prev, producto_id: '' }));
                                            setSearch('');
                                        }}
                                        className="text-red-500 hover:text-red-700"
                                    >
                                        <X className="h-4 w-4" />
                                    </button>
                                )}
                            </div>
                        )}
                        {errors.producto_id && <p className="text-red-500 text-xs mt-1">{errors.producto_id[0]}</p>}
                    </div>

                    {/* Tab Selection */}
                    <div>
                        <Label>Pestaña / Grupo</Label>
                        <select
                            name="tab_name"
                            value={formData.tab_name}
                            onChange={handleChange}
                            className="w-full mt-1 px-3 py-2 border rounded-md focus:ring-2 focus:ring-primary-500"
                        >
                            <option value="nuevos_ingresos">Nuevos Ingresos</option>
                            <option value="mas_vendidos">Los más Vendidos</option>
                            <option value="ofertas_especiales">Ofertas Especiales</option>
                            <option value="productos_en_remate">Productos En Remate</option>
                            <option value="productos_de_tendencia">Productos de Tendencia</option>
                        </select>
                    </div>

                    <div className="grid grid-cols-2 gap-4">
                        <div>
                            <Label>Orden</Label>
                            <Input
                                type="number"
                                name="orden"
                                value={formData.orden}
                                onChange={handleChange}
                            />
                        </div>
                        <div>
                            <Label>Estado</Label>
                            <select
                                name="estado"
                                value={formData.estado}
                                onChange={handleChange}
                                className="w-full mt-1 px-3 py-2 border rounded-md focus:ring-2 focus:ring-primary-500"
                            >
                                <option value="1">Activo</option>
                                <option value="0">Inactivo</option>
                            </select>
                        </div>
                    </div>

                    <div className="flex gap-3 pt-4">
                        <Button type="button" variant="outline" onClick={onClose} disabled={loading} className="flex-1">
                            Cancelar
                        </Button>
                        <Button type="submit" disabled={loading} className="flex-1 gap-2">
                            {loading && <Loader2 className="h-4 w-4 animate-spin" />}
                            {item ? 'Actualizar' : 'Guardar'}
                        </Button>
                    </div>
                </form>
            </div>
        </div>
    );
}
