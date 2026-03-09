import { useState, useEffect } from 'react';
import { baseUrl } from '@/lib/baseUrl';
import { Plus, Edit2, Trash2, Loader2, Package } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { DataTable } from '@/components/ui/data-table';
import { toast } from '@/lib/sweetalert';
import { confirmDelete } from '@/lib/sweetalert';
import ProductoExclusivoModal from './ProductoExclusivoModal';
import MainLayout from "../Layout/MainLayout";

export default function ProductosExclusivosPage() {
    const [activeTab, setActiveTab] = useState('nuevos_ingresos');
    const [items, setItems] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [selectedItem, setSelectedItem] = useState(null);

    const tabs = [
        { id: 'nuevos_ingresos', label: 'Nuevos Ingresos' },
        { id: 'mas_vendidos', label: 'Los más Vendidos' },
        { id: 'ofertas_especiales', label: 'Ofertas Especiales' }
    ];

    useEffect(() => {
        fetchItems();
    }, [activeTab]);

    const fetchItems = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const response = await fetch(baseUrl(`/api/productos-exclusivos?tab=${activeTab}`), {
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Accept': 'application/json'
                }
            });
            const data = await response.json();
            if (data.success) {
                setItems(data.data);
            } else {
                setError(data.message || 'Error al cargar productos');
            }
        } catch (err) {
            setError('Error de conexión');
        } finally {
            setLoading(false);
        }
    };

    const handleDelete = (item) => {
        confirmDelete({
            title: '¿Eliminar de destacados?',
            message: `El producto "${item.producto.nombre}" dejará de aparecer en esta pestaña.`,
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem('auth_token');
                    const response = await fetch(baseUrl(`/api/productos-exclusivos/${item.id_exclusivo}`), {
                        method: 'DELETE',
                        headers: {
                            'Authorization': `Bearer ${token}`,
                            'Accept': 'application/json'
                        }
                    });
                    const data = await response.json();
                    if (data.success) {
                        toast.success('Eliminado correctamente');
                        fetchItems();
                    }
                } catch (err) {
                    toast.error('Error al eliminar');
                }
            }
        });
    };

    const handleEdit = (item) => {
        setSelectedItem(item);
        setIsModalOpen(true);
    };

    const handleCreate = () => {
        setSelectedItem(null);
        setIsModalOpen(true);
    };

    const columns = [
        {
            accessorKey: 'orden',
            header: 'Orden',
            cell: ({ row }) => <span className="font-mono text-xs">{row.getValue('orden')}</span>,
        },
        {
            accessorKey: 'imagen',
            header: 'Imagen',
            cell: ({ row }) => {
                const img = row.getValue('imagen');
                const url = row.original.imagen_url || (img ? baseUrl(`/storage/${img}`) : null);
                return url ? (
                    <img src={url} alt="Prod" className="h-10 w-10 object-cover rounded border" />
                ) : (
                    <div className="h-10 w-10 bg-gray-100 rounded border flex items-center justify-center text-[10px] text-gray-400">Sin img</div>
                );
            }
        },
        {
            id: 'producto_info',
            header: 'Producto',
            cell: ({ row }) => {
                const prod = row.original.producto;
                return (
                    <div className="flex flex-col">
                        <span className="font-semibold text-gray-900">{prod.nombre}</span>
                        <span className="text-xs text-gray-500">{prod.codigo}</span>
                    </div>
                );
            }
        },
        {
            id: 'precio',
            header: 'Precio',
            cell: ({ row }) => <span className="text-sm">S/ {row.original.producto.precio}</span>,
        },
        {
            accessorKey: 'estado',
            header: 'Estado',
            cell: ({ row }) => (
                <span className={`px-2 py-0.5 rounded-full text-[10px] font-bold ${row.getValue('estado') === '1' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'
                    }`}>
                    {row.getValue('estado') === '1' ? 'ACTIVO' : 'INACTIVO'}
                </span>
            ),
        },
        {
            id: 'actions',
            header: 'Acciones',
            cell: ({ row }) => (
                <div className="flex items-center gap-1">
                    <Button variant="ghost" size="sm" onClick={() => handleEdit(row.original)} className="h-8 w-8 p-0 text-blue-600">
                        <Edit2 className="h-4 w-4" />
                    </Button>
                    <Button variant="ghost" size="sm" onClick={() => handleDelete(row.original)} className="h-8 w-8 p-0 text-red-600">
                        <Trash2 className="h-4 w-4" />
                    </Button>
                </div>
            )
        }
    ];

    return (
        <MainLayout>
            <div className="space-y-4">
                <div className="flex justify-between items-center">
                    <div>
                        <h1 className="text-xl font-bold text-gray-900">Productos Exclusivos</h1>
                        <p className="text-sm text-gray-500">Maneja qué productos aparecen en las pestañas del home.</p>
                    </div>
                    <Button onClick={handleCreate} className="bg-accent-600 hover:bg-accent-700 text-white">
                        <Plus className="h-4 w-4 mr-2" />
                        Asignar Producto
                    </Button>
                </div>

                {/* Sub-tabs internal for exclusive types */}
                <div className="bg-gray-100 p-1 rounded-lg flex w-fit">
                    {tabs.map(tab => (
                        <button
                            key={tab.id}
                            onClick={() => setActiveTab(tab.id)}
                            className={`px-4 py-2 text-sm rounded-md transition-all ${activeTab === tab.id
                                ? 'bg-white text-gray-900 shadow-sm font-semibold'
                                : 'text-gray-500 hover:text-gray-700'
                                }`}
                        >
                            {tab.label}
                        </button>
                    ))}
                </div>

                <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                    {loading ? (
                        <div className="p-20 flex flex-col items-center justify-center">
                            <Loader2 className="h-8 w-8 animate-spin text-primary-600 mb-2" />
                            <p className="text-sm text-gray-500">Cargando productos...</p>
                        </div>
                    ) : error ? (
                        <div className="p-10 text-center text-red-500">{error}</div>
                    ) : (
                        <DataTable
                            columns={columns}
                            data={items}
                            searchKey="producto_nombre" // Note: we'll need a flat structure or specific search logic in DataTable
                            searchPlaceholder="Filtrar productos..."
                        />
                    )}
                </div>

                <ProductoExclusivoModal
                    isOpen={isModalOpen}
                    onClose={() => setIsModalOpen(false)}
                    onSuccess={fetchItems}
                    item={selectedItem}
                    defaultTab={activeTab}
                />
            </div>
        </MainLayout>
    );
}
