import { useState } from 'react';
import DataTable from '@/components/Dashboard/components/DataTable';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Plus, Loader2 } from 'lucide-react';
import { transportistasColumns } from './columns/transportistasColumns';
import { TransportistaModal } from './modals/TransportistaModal';
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogHeader,
  AlertDialogTitle,
} from '@/components/ui/alert-dialog';
import { useToast } from '@/hooks/use-toast';

export function TransportistasTable({
  transportistas,
  isLoading,
  pagination,
  page,
  setPage,
  search,
  handleSearch,
  estado,
  handleEstadoFilter,
  onEdit,
  onDelete,
  isDeleting,
}) {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedTransportista, setSelectedTransportista] = useState(null);
  const [deleteId, setDeleteId] = useState(null);
  const { toast } = useToast();

  const handleOpenModal = (transportista = null) => {
    setSelectedTransportista(transportista);
    setIsModalOpen(true);
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
    setSelectedTransportista(null);
  };

  const handleDeleteConfirm = () => {
    if (deleteId) {
      onDelete(deleteId, {
        onSuccess: () => {
          toast({
            title: 'Éxito',
            description: 'Transportista eliminado correctamente',
          });
          setDeleteId(null);
        },
        onError: (error) => {
          toast({
            title: 'Error',
            description: error.response?.data?.message || 'Error al eliminar transportista',
            variant: 'destructive',
          });
        },
      });
    }
  };

  const columns = transportistasColumns(
    handleOpenModal,
    (id) => setDeleteId(id)
  );

  return (
    <div className="space-y-4">
      {/* Filtros */}
      <div className="flex flex-col md:flex-row gap-4">
        <Input
          placeholder="Buscar por documento o razón social..."
          value={search}
          onChange={(e) => handleSearch(e.target.value)}
          className="flex-1"
        />
        <Select value={estado === null ? 'all' : estado.toString()} onValueChange={(value) => handleEstadoFilter(value === 'all' ? null : value === 'true')}>
          <SelectTrigger className="w-full md:w-48">
            <SelectValue placeholder="Filtrar por estado" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">Todos</SelectItem>
            <SelectItem value="true">Activos</SelectItem>
            <SelectItem value="false">Inactivos</SelectItem>
          </SelectContent>
        </Select>
        <Button onClick={() => handleOpenModal()} className="gap-2">
          <Plus className="w-4 h-4" />
          Nuevo Transportista
        </Button>
      </div>

      {/* Tabla */}
      {isLoading ? (
        <div className="flex items-center justify-center py-8">
          <Loader2 className="w-6 h-6 animate-spin" />
        </div>
      ) : (
        <DataTable
          columns={columns}
          data={transportistas}
          pagination={pagination}
          onPageChange={setPage}
          currentPage={page}
        />
      )}

      {/* Modal */}
      <TransportistaModal
        isOpen={isModalOpen}
        onClose={handleCloseModal}
        transportista={selectedTransportista}
        onSubmit={onEdit}
        isLoading={false}
      />

      {/* Alert Dialog para eliminar */}
      <AlertDialog open={!!deleteId} onOpenChange={(open) => !open && setDeleteId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>¿Eliminar transportista?</AlertDialogTitle>
            <AlertDialogDescription>
              Esta acción no se puede deshacer. El transportista será eliminado permanentemente.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <div className="flex gap-2 justify-end">
            <AlertDialogCancel>Cancelar</AlertDialogCancel>
            <AlertDialogAction onClick={handleDeleteConfirm} disabled={isDeleting}>
              {isDeleting ? 'Eliminando...' : 'Eliminar'}
            </AlertDialogAction>
          </div>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
