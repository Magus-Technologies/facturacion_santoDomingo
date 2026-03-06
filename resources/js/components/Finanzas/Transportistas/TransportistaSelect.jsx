import { useTransportistas } from './hooks/useTransportistas';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Label } from '@/components/ui/label';
import { Loader2 } from 'lucide-react';

export function TransportistaSelect({ value, onChange, label = 'Transportista', required = false }) {
  const { activos, isLoading } = useTransportistas();

  return (
    <div className="space-y-2">
      <Label htmlFor="transportista">
        {label}
        {required && <span className="text-red-500 ml-1">*</span>}
      </Label>
      <Select value={value?.toString() || ''} onValueChange={(val) => onChange(val ? parseInt(val) : null)}>
        <SelectTrigger id="transportista" disabled={isLoading}>
          {isLoading ? (
            <div className="flex items-center gap-2">
              <Loader2 className="w-4 h-4 animate-spin" />
              <span>Cargando...</span>
            </div>
          ) : (
            <SelectValue placeholder="Selecciona un transportista" />
          )}
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="">Sin transportista</SelectItem>
          {activos.map((transportista) => (
            <SelectItem key={transportista.id} value={transportista.id.toString()}>
              <div className="flex flex-col">
                <span>{transportista.razon_social}</span>
                <span className="text-xs text-gray-500">{transportista.numero_documento}</span>
              </div>
            </SelectItem>
          ))}
        </SelectContent>
      </Select>
    </div>
  );
}
