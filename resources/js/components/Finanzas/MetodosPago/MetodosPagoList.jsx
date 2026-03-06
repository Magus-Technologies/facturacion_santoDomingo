import { CreditCard, Plus, Loader2 } from 'lucide-react';
import { DataTable } from '@/components/ui/data-table';
import { Button } from '@/components/ui/button';
import MainLayout from '@/components/Layout/MainLayout';
import { useMetodosPago } from './hooks/useMetodosPago';
import { getMetodosPagoColumns } from './columns/metodosPagoColumns';
import MetodoPagoModal from './MetodoPagoModal';

export default function MetodosPagoList() {
    const { metodos, loading, error, isModalOpen, selectedMetodo, fetchMetodos, handleDelete, handleEdit, handleCreate, handleModalClose, handleModalSuccess } = useMetodosPago();

    const columns = getMetodosPagoColumns({ handleEdit, handleDelete });

    if (loading) return (
        <MainLayout>
            <div className="flex items-center justify-center min-h-[400px]">
                <Loader2 className="h-10 w-10 animate-spin text-primary-600" />
            </div>
        </MainLayout>
    );

    if (error) return (
        <MainLayout>
            <div className="flex items-center justify-center min-h-[400px]">
                <div className="text-center">
                    <p className="text-red-600">{error}</p>
                    <Button onClick={fetchMetodos} className="mt-3">Reintentar</Button>
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
                            <CreditCard className="h-6 w-6 text-primary-600" /> Métodos de Pago
                        </h1>
                        <p className="text-gray-500 mt-1">Gestiona los métodos de pago disponibles</p>
                    </div>
                    <Button onClick={handleCreate} className="gap-2 bg-primary-600 hover:bg-primary-700 text-white">
                        <Plus className="h-4 w-4" /> Nuevo Método
                    </Button>
                </div>

                <DataTable columns={columns} data={metodos} searchable searchPlaceholder="Buscar por nombre o código..." pagination pageSize={10} />

                <MetodoPagoModal isOpen={isModalOpen} onClose={handleModalClose} metodo={selectedMetodo} onSuccess={handleModalSuccess} />
            </div>
        </MainLayout>
    );
}
