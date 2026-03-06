import { useTransportistas } from './hooks/useTransportistas';
import { TransportistasTable } from './TransportistasTable';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { AlertCircle } from 'lucide-react';
import MainLayout from '@/components/Layout/MainLayout';

export function TransportistasPage() {
  const {
    transportistas,
    pagination,
    isLoading,
    error,
    page,
    setPage,
    search,
    handleSearch,
    estado,
    handleEstadoFilter,
    create,
    isCreating,
    update,
    isUpdating,
    delete: deleteTransportista,
    isDeleting,
  } = useTransportistas();

  const handleSubmit = ({ id, data }, callbacks) => {
    if (id) {
      update({ id, data }, {
        onSuccess: callbacks.onSuccess,
        onError: callbacks.onError,
      });
    } else {
      create(data, {
        onSuccess: callbacks.onSuccess,
        onError: callbacks.onError,
      });
    }
  };

  const handleDelete = (id, callbacks) => {
    deleteTransportista(id, {
      onSuccess: callbacks.onSuccess,
      onError: callbacks.onError,
    });
  };

  return (
    <MainLayout>
      <div className="space-y-6">
        {/* Header */}
        <div>
          <h1 className="text-3xl font-bold tracking-tight">Transportistas</h1>
          <p className="text-gray-600 mt-2">
            Gestiona los transportistas disponibles para las guías de remisión
          </p>
        </div>

        {/* Error Alert */}
        {error && (
          <div className="bg-red-50 border border-red-200 rounded-lg p-4 flex items-center gap-3">
            <AlertCircle className="h-4 w-4 text-red-600 shrink-0" />
            <p className="text-sm text-red-700">Error al cargar transportistas. Por favor, intenta de nuevo.</p>
          </div>
        )}

        {/* Card Principal */}
        <Card>
          <CardHeader>
            <CardTitle>Listado de Transportistas</CardTitle>
          </CardHeader>
          <CardContent>
            <TransportistasTable
              transportistas={transportistas}
              isLoading={isLoading}
              pagination={pagination}
              page={page}
              setPage={setPage}
              search={search}
              handleSearch={handleSearch}
              estado={estado}
              handleEstadoFilter={handleEstadoFilter}
              onEdit={handleSubmit}
              onDelete={handleDelete}
              isDeleting={isDeleting}
            />
          </CardContent>
        </Card>
      </div>
    </MainLayout>
  );
}

export default TransportistasPage;
