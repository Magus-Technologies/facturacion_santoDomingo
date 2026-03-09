import { useState, useEffect } from 'react';
import { baseUrl } from '@/lib/baseUrl';
import { Plus, Edit2, Trash2, Loader2 } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { DataTable } from '@/components/ui/data-table';
import { toast } from '@/lib/sweetalert';
import { confirmDelete } from '@/lib/sweetalert';
import GrupoSeleccionModal from './GrupoSeleccionModal';

export default function GrupoSeleccionPage() {
    const [banners, setBanners] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [selectedBanner, setSelectedBanner] = useState(null);

    useEffect(() => {
        fetchBanners();
    }, []);

    const fetchBanners = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const response = await fetch(baseUrl('/api/grupo-seleccion'), {
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Accept': 'application/json'
                }
            });
            const data = await response.json();
            if (data.success) {
                setBanners(data.data);
            } else {
                setError(data.message || 'Error al cargar promociones');
            }
        } catch (err) {
            setError('Error de conexión al servidor');
            console.error('Error:', err);
        } finally {
            setLoading(false);
        }
    };

    const handleDelete = async (banner) => {
        confirmDelete({
            title: 'Eliminar Tarjeta',
            message: `¿Estás seguro de eliminar esta tarjeta de selección?`,
            confirmText: 'Sí, eliminar',
            cancelText: 'Cancelar',
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem('auth_token');
                    const response = await fetch(
                        baseUrl(`/api/grupo-seleccion/${banner.id_seleccion}`),
                        {
                            method: 'DELETE',
                            headers: {
                                'Authorization': `Bearer ${token}`,
                                'Accept': 'application/json',
                            },
                        }
                    );
                    const data = await response.json();
                    if (data.success) {
                        toast.success('Tarjeta eliminada exitosamente');
                        fetchBanners();
                    } else {
                        toast.error(data.message || 'Error al eliminar la tarjeta');
                    }
                } catch (err) {
                    toast.error('Error de conexión al servidor');
                    console.error('Error:', err);
                }
            },
        });
    };

    const handleEdit = (banner) => {
        setSelectedBanner(banner);
        setIsModalOpen(true);
    };

    const handleCreate = () => {
        setSelectedBanner(null);
        setIsModalOpen(true);
    };

    const handleModalClose = () => {
        setIsModalOpen(false);
        setSelectedBanner(null);
    };

    const handleModalSuccess = (bannerActualizado) => {
        if (selectedBanner) {
            setBanners(prev =>
                prev.map(b => b.id_seleccion === bannerActualizado.id_seleccion ? bannerActualizado : b)
            );
        } else {
            setBanners(prev => [bannerActualizado, ...prev]);
        }
    };

    const columns = [
        {
            accessorKey: 'id_seleccion',
            header: 'ID',
            cell: ({ row }) => (
                <span className="font-mono text-sm text-gray-600">
                    {row.getValue('id_seleccion')}
                </span>
            ),
        },
        {
            accessorKey: 'imagen',
            header: 'Imagen',
            cell: ({ row }) => {
                const img = row.getValue('imagen');
                return (
                    <span className="text-sm text-gray-600 truncate max-w-[100px] inline-block">
                        {img}
                    </span>
                );
            },
        },
        {
            accessorKey: 'nombre_cate',
            header: 'Nombre',
            cell: ({ row }) => (
                <span className="text-sm font-semibold text-gray-900">
                    {row.getValue('nombre_cate')}
                </span>
            ),
        },
        {
            accessorKey: 'codi_categoria',
            header: 'Categoría ID',
            cell: ({ row }) => (
                <span className="text-sm text-gray-600">
                    {row.getValue('codi_categoria')}
                </span>
            ),
        },
        {
            accessorKey: 'estado',
            header: 'Estado',
            cell: ({ row }) => {
                const estado = row.getValue('estado');
                return (
                    <span className={`px-3 py-1 rounded-full text-xs font-semibold ${estado === '1'
                        ? 'bg-green-100 text-green-800'
                        : 'bg-red-100 text-red-800'
                        }`}>
                        {estado === '1' ? 'Activo' : 'Inactivo'}
                    </span>
                );
            },
        },
        {
            id: 'actions',
            header: 'Acciones',
            enableSorting: false,
            cell: ({ row }) => {
                const banner = row.original;
                return (
                    <div className="flex items-center gap-2">
                        <Button
                            variant="ghost"
                            size="sm"
                            onClick={() => handleEdit(banner)}
                            className="text-accent-600 hover:text-accent-700 hover:bg-accent-50"
                        >
                            <Edit2 className="h-4 w-4" />
                        </Button>
                        <Button
                            variant="ghost"
                            size="sm"
                            onClick={() => handleDelete(banner)}
                            className="text-red-600 hover:text-red-700 hover:bg-red-50"
                        >
                            <Trash2 className="h-4 w-4" />
                        </Button>
                    </div>
                );
            },
        },
    ];

    if (loading) {
        return (
            <div className="flex items-center justify-center min-h-96">
                <div className="text-center">
                    <Loader2 className="h-12 w-12 animate-spin text-primary-600 mx-auto mb-4" />
                    <p className="text-gray-600">Cargando promociones...</p>
                </div>
            </div>
        );
    }

    if (error) {
        return (
            <div className="flex items-center justify-center min-h-96">
                <div className="text-center">
                    <div className="bg-red-100 text-red-700 px-6 py-4 rounded-lg">
                        <p className="font-semibold">Error</p>
                        <p className="text-sm mt-1">{error}</p>
                    </div>
                    <Button onClick={fetchBanners} className="mt-4">
                        Reintentar
                    </Button>
                </div>
            </div>
        );
    }

    return (
        <div className="space-y-6">
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
                <div>
                    <h1 className="text-2xl font-bold tracking-tight text-gray-900">
                        Nuestra Selección
                    </h1>
                    <p className="text-sm text-gray-500 mt-1">
                        Gestiona las tarjetas del carrusel "Nuestra Selección"
                    </p>
                </div>
                <Button
                    onClick={handleCreate}
                    className="w-full sm:w-auto bg-accent-600 hover:bg-accent-700 text-white"
                >
                    <Plus className="h-4 w-4 mr-2" />
                    Nueva Tarjeta
                </Button>
            </div>

            <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                <div className="p-1">
                    <DataTable
                        columns={columns}
                        data={banners}
                        searchKey="nombre_cate"
                        searchPlaceholder="Buscar tarjetas..."
                    />
                </div>
            </div>

            <GrupoSeleccionModal // Changed from BannerPromocionalModal
                isOpen={isModalOpen}
                onClose={handleModalClose}
                onSuccess={handleModalSuccess}
                banner={selectedBanner}
            />
        </div>
    );
}
