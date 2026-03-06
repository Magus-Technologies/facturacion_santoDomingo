import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { TransportistaForm } from '../TransportistaForm';
import { useToast } from '@/hooks/use-toast';

export function TransportistaModal({ isOpen, onClose, transportista, onSubmit, isLoading }) {
  const { toast } = useToast();

  const handleSubmit = (formData, setErrors) => {
    onSubmit(
      { id: transportista?.id, data: formData },
      {
        onSuccess: () => {
          toast({
            title: 'Éxito',
            description: transportista
              ? 'Transportista actualizado correctamente'
              : 'Transportista creado correctamente',
          });
          onClose();
        },
        onError: (error) => {
          const errorData = error.response?.data?.errors || {};
          setErrors(errorData);
          toast({
            title: 'Error',
            description: error.response?.data?.message || 'Error al guardar transportista',
            variant: 'destructive',
          });
        },
      }
    );
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-2xl">
        <DialogHeader>
          <DialogTitle>
            {transportista ? 'Editar Transportista' : 'Nuevo Transportista'}
          </DialogTitle>
        </DialogHeader>
        <TransportistaForm
          transportista={transportista}
          onSubmit={handleSubmit}
          isLoading={isLoading}
        />
      </DialogContent>
    </Dialog>
  );
}
