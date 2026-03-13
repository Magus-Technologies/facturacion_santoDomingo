import { useState, useEffect } from 'react';
import { baseUrl } from '@/lib/baseUrl';
import { Plus, Edit2, Trash2, ChevronRight } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { DataTable } from '@/components/ui/data-table';
import { toast, confirmDelete } from '@/lib/sweetalert';
import NavMenuModal from './NavMenuModal';
import MainLayout from '@/components/Layout/MainLayout';

export default function NavMenuPage() {
    const [items, setItems] = useState([]);
    const [loading, setLoading] = useState(true);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [selectedItem, setSelectedItem] = useState(null);
    const [parentId, setParentId] = useState(null); // Para agregar subitems

    useEffect(() => { fetchItems(); }, []);

    const fetchItems = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl('/api/nav-menu'), {
                headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' }
            });
            const data = await res.json();
            if (data.success) setItems(data.data);
        } catch {
            toast.error('Error al cargar el menú');
        } finally {
            setLoading(false);
        }
    };

    const handleDelete = async (item) => {
        confirmDelete({
            title: 'Eliminar ítem',
            message: `¿Eliminar "${item.label}"? También se eliminarán sus subitems.`,
            confirmText: 'Sí, eliminar',
            cancelText: 'Cancelar',
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem('auth_token');
                    const res = await fetch(baseUrl(`/api/nav-menu/${item.id}`), {
                        method: 'DELETE',
                        headers: { 'Authorization': `Bearer ${token}` }
                    });
                    const data = await res.json();
                    if (data.success) {
                        toast.success('Ítem eliminado');
                        fetchItems();
                    } else {
                        toast.error(data.message || 'Error al eliminar');
                    }
                } catch {
                    toast.error('Error de conexión');
                }
            }
        });
    };

    const handleToggleEstado = async (item) => {
        try {
            const token = localStorage.getItem('auth_token');
            const nuevoEstado = item.estado === '1' ? '0' : '1';
            const res = await fetch(baseUrl(`/api/nav-menu/${item.id}`), {
                method: 'PUT',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                },
                body: JSON.stringify({ estado: nuevoEstado }),
            });
            const data = await res.json();
            if (data.success) {
                toast.success(nuevoEstado === '1' ? 'Ítem activado' : 'Ítem desactivado');
                fetchItems();
            }
        } catch {
            toast.error('Error al cambiar estado');
        }
    };

    const columns = [
        {
            accessorKey: 'orden',
            header: '#',
            cell: ({ row }) => <span className="text-gray-400 text-sm">{row.original.orden}</span>,
        },
        {
            accessorKey: 'label',
            header: 'Etiqueta',
            cell: ({ row }) => (
                <span className="font-medium text-gray-900">{row.original.label}</span>
            ),
        },
        {
            accessorKey: 'url',
            header: 'URL',
            cell: ({ row }) => (
                <span className="text-xs font-mono text-blue-600">{row.original.url || '#'}</span>
            ),
        },
        {
            accessorKey: 'target',
            header: 'Target',
            cell: ({ row }) => (
                <span className="text-xs text-gray-500">{row.original.target}</span>
            ),
        },
        {
            accessorKey: 'estado',
            header: 'Estado',
            cell: ({ row }) => (
                <button
                    onClick={() => handleToggleEstado(row.original)}
                    className={`px-2 py-0.5 rounded-full text-xs font-medium ${
                        row.original.estado === '1'
                            ? 'bg-green-100 text-green-700'
                            : 'bg-red-100 text-red-500'
                    }`}
                >
                    {row.original.estado === '1' ? 'Activo' : 'Inactivo'}
                </button>
            ),
        },
        {
            accessorKey: 'hijos',
            header: 'Subitems',
            cell: ({ row }) => (
                <span className="text-gray-500 text-sm">{row.original.hijos?.length || 0}</span>
            ),
        },
        {
            id: 'acciones',
            header: 'Acciones',
            cell: ({ row }) => (
                <div className="flex gap-1">
                    <Button
                        variant="ghost"
                        size="sm"
                        title="Agregar subitem"
                        onClick={() => { setParentId(row.original.id); setSelectedItem(null); setIsModalOpen(true); }}
                    >
                        <ChevronRight className="h-4 w-4 text-blue-500" />
                    </Button>
                    <Button
                        variant="ghost"
                        size="sm"
                        onClick={() => { setSelectedItem(row.original); setParentId(null); setIsModalOpen(true); }}
                    >
                        <Edit2 className="h-4 w-4 text-gray-500" />
                    </Button>
                    <Button
                        variant="ghost"
                        size="sm"
                        onClick={() => handleDelete(row.original)}
                    >
                        <Trash2 className="h-4 w-4 text-red-500" />
                    </Button>
                </div>
            ),
        },
    ];

    // Aplanar items y subitems para la tabla con indentación visual
    const flatItems = items.flatMap(item => [
        item,
        ...(item.hijos || []).map(h => ({ ...h, _isChild: true })),
    ]);

    const columnsWithIndent = columns.map(col =>
        col.accessorKey === 'label'
            ? {
                ...col,
                cell: ({ row }) => (
                    <span className={`font-medium ${row.original._isChild ? 'pl-6 text-gray-600 text-sm' : 'text-gray-900'}`}>
                        {row.original._isChild && <span className="text-gray-300 mr-1">└</span>}
                        {row.original.label}
                    </span>
                ),
            }
            : col
    );

    return (
        <MainLayout>
            <div className="mb-6 flex items-center justify-between">
                <div>
                    <h1 className="text-2xl font-bold text-gray-900">Navegación del Ecommerce</h1>
                    <p className="text-sm text-gray-500 mt-1">Gestiona los ítems del menú de navegación</p>
                </div>
                <Button onClick={() => { setSelectedItem(null); setParentId(null); setIsModalOpen(true); }} className="gap-2">
                    <Plus className="h-4 w-4" />
                    Nuevo ítem
                </Button>
            </div>

            <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                <DataTable
                    columns={columnsWithIndent}
                    data={flatItems}
                    loading={loading}
                    pagination={false}
                />
            </div>

            <NavMenuModal
                isOpen={isModalOpen}
                item={selectedItem}
                parentId={parentId}
                allItems={items}
                onClose={() => { setIsModalOpen(false); setSelectedItem(null); setParentId(null); }}
                onSaved={() => { setIsModalOpen(false); setSelectedItem(null); setParentId(null); fetchItems(); }}
            />
        </MainLayout>
    );
}
