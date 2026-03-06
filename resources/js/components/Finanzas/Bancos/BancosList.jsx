import { Landmark, Plus, Loader2 } from 'lucide-react';
import { DataTable } from '@/components/ui/data-table';
import { Button } from '@/components/ui/button';
import MainLayout from '@/components/Layout/MainLayout';
import { useBancos } from './hooks/useBancos';
import { getBancosColumns } from './columns/bancosColumns';
import BancoModal from './BancoModal';

export default function BancosList() {
    const { bancos, loading, error, isModalOpen, selectedBanco, fetchBancos, handleDelete, handleEdit, handleCreate, handleModalClose, handleModalSuccess } = useBancos();

    const columns = getBancosColumns({ handleEdit, handleDelete });

    if (loading) return (
        <MainLayout>
            <div className="flex items-center justify-center min-h-[400px]">
                <div className="text-center">
                    <Loader2 className="h-10 w-10 animate-spin text-primary-600 mx-auto mb-3" />
                    <p className="text-gray-500">Cargando bancos...</p>
                </div>
            </div>
        </MainLayout>
    );

    if (error) return (
        <MainLayout>
            <div className="flex items-center justify-center min-h-[400px]">
                <div className="text-center">
                    <p className="text-red-600 font-medium">{error}</p>
                    <Button onClick={fetchBancos} className="mt-3">Reintentar</Button>
                </div>
            </div>
        </MainLayout>
    );

    return (
        <MainLayout>
            <div className="space-y-6">
                <div className="flex items-center justify-between">
                    <div>
                        <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
                            <Landmark className="h-6 w-6 text-primary-600" /> Bancos
                        </h1>
                        <p className="text-gray-500 mt-1">Gestiona los bancos del sistema</p>
                    </div>
                    <Button onClick={handleCreate} className="gap-2 bg-primary-600 hover:bg-primary-700 text-white">
                        <Plus className="h-4 w-4" /> Nuevo Banco
                    </Button>
                </div>

                <DataTable
                    columns={columns}
                    data={bancos}
                    searchable
                    searchPlaceholder="Buscar por nombre o código..."
                    pagination
                    pageSize={10}
                />

                <BancoModal
                    isOpen={isModalOpen}
                    onClose={handleModalClose}
                    banco={selectedBanco}
                    onSuccess={handleModalSuccess}
                />
            </div>
        </MainLayout>
    );
}
