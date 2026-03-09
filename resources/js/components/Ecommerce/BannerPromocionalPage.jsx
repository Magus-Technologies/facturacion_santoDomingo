import { useState, useEffect } from 'react';
import { baseUrl } from '@/lib/baseUrl';
import { Plus, Edit2, Trash2, Loader2 } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { DataTable } from '@/components/ui/data-table';
import { toast } from '@/lib/sweetalert';
import { confirmDelete } from '@/lib/sweetalert';
import BannerPromocionalModal from './BannerPromocionalModal';

export default function BannerPromocionalPage() {
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
            const response = await fetch(baseUrl('/api/banners-promocionales'), {
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
            title: 'Eliminar Promoción',
            message: `¿Estás seguro de eliminar esta promoción?`,
            confirmText: 'Sí, eliminar',
            cancelText: 'Cancelar',
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem('auth_token');
                    const response = await fetch(
                        baseUrl(`/api/banners-promocionales/${banner.id}`),
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
                        toast.success('Promoción eliminada exitosamente');
                        fetchBanners();
                    } else {
                        toast.error(data.message || 'Error al eliminar promoción');
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
                prev.map(b => b.id === bannerActualizado.id ? bannerActualizado : b)
            );
        } else {
            setBanners(prev => [bannerActualizado, ...prev]);
        }
    };

    const columns = [
        {
            accessorKey: 'id',
            header: 'ID',
            cell: ({ row }) => (
                <span className="font-mono text-sm text-gray-600">
                    {row.getValue('id')}
                </span>
            ),
        },
        {
            accessorKey: 'imagen',
            header: 'Imagen',
            cell: ({ row }) => (
                <span className="text-sm text-gray-600">
                    {row.getValue('imagen')}
                </span>
            ),
        },
        {
            accessorKey: 'url',
            header: 'URL',
            cell: ({ row }) => (
                <span className="text-sm text-gray-600 truncate max-w-xs">
                    {row.getValue('url')}
                </span>
            ),
        },
        {
            accessorKey: 'estado',
            header: 'Estado',
            cell: ({ row }) => {
                const estado = row.getValue('estado');
                return (
                    <span className={`px-3 py-1 rounded-full text-xs font-semibold ${
                        estado === '1' 
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
            <div className="flex items-center justify-between">
                <div>
                    <h1 className="text-2xl font-bold text-gray-900">
                        Promociones
                    </h1>
                    <p className="text-gray-600 mt-1">
                        Gestiona los banners promocionales que aparecen en el ecommerce
                    </p>
                </div>
                <Button onClick={handleCreate} className="gap-2">
                    <Plus className="h-4 w-4" />
                    Nueva Promoción
                </Button>
            </div>

            <DataTable
                columns={columns}
                data={banners}
                searchable={true}
                searchPlaceholder="Buscar promociones..."
                pagination={true}
                pageSize={10}
            />

            <BannerPromocionalModal
                isOpen={isModalOpen}
                onClose={handleModalClose}
                banner={selectedBanner}
                onSuccess={handleModalSuccess}
            />
        </div>
    );
}
