import { Building2, Plus, Loader2 } from 'lucide-react';
import { DataTable } from '@/components/ui/data-table';
import { Button } from '@/components/ui/button';
import MainLayout from '@/components/Layout/MainLayout';
import { useCuentasBancarias } from './hooks/useCuentasBancarias';
import { getCuentasColumns } from './columns/cuentasColumns';
import CuentaBancariaModal from './CuentaBancariaModal';
import CuentaBancariaDetalle from './CuentaBancariaDetalle';

export default function CuentasBancariasList() {
    const {
        cuentas, loading, error,
        isModalOpen, selectedCuenta,
        isDetalleOpen, cuentaDetalle,
        fetchCuentas, handleDelete, handleEdit, handleCreate, handleModalClose, handleModalSuccess,
        handleVerDetalle, handleDetalleClose,
    } = useCuentasBancarias();

    const columns = getCuentasColumns({ handleEdit, handleDelete, handleVerDetalle });

    if (loading) return (
        <MainLayout>
            <div className="flex items-center justify-center min-h-[400px]">
                <div className="text-center">
                    <Loader2 className="h-10 w-10 animate-spin text-primary-600 mx-auto mb-3" />
                    <p className="text-gray-500">Cargando cuentas bancarias...</p>
                </div>
            </div>
        </MainLayout>
    );

    if (error) return (
        <MainLayout>
            <div className="flex items-center justify-center min-h-[400px]">
                <div className="text-center">
                    <p className="text-red-600 font-medium">{error}</p>
                    <Button onClick={fetchCuentas} className="mt-3">Reintentar</Button>
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
                            <Building2 className="h-6 w-6 text-primary-600" /> Cuentas Bancarias
                        </h1>
                        <p className="text-gray-500 mt-1">Gestiona las cuentas bancarias de la empresa</p>
                    </div>
                    <Button onClick={handleCreate} className="gap-2 bg-primary-600 hover:bg-primary-700 text-white">
                        <Plus className="h-4 w-4" /> Nueva Cuenta
                    </Button>
                </div>

                <DataTable
                    columns={columns}
                    data={cuentas}
                    searchable
                    searchPlaceholder="Buscar por banco, número o alias..."
                    pagination
                    pageSize={10}
                />

                <CuentaBancariaModal
                    isOpen={isModalOpen}
                    onClose={handleModalClose}
                    cuenta={selectedCuenta}
                    onSuccess={handleModalSuccess}
                />

                <CuentaBancariaDetalle
                    isOpen={isDetalleOpen}
                    onClose={handleDetalleClose}
                    cuenta={cuentaDetalle}
                />
            </div>
        </MainLayout>
    );
}
