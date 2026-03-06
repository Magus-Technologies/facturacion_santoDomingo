import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

export default function VehiculoForm({ 
  data, 
  onChange, 
  errors = {},
  disabled = false 
}) {
  const handleChange = (field, value) => {
    onChange({
      ...data,
      [field]: value,
    });
  };

  return (
    <div className="space-y-4">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {/* Placa */}
        <div className="space-y-2">
          <Label htmlFor="vehiculo_placa">Placa *</Label>
          <Input
            id="vehiculo_placa"
            value={data.vehiculo_placa || ''}
            onChange={(e) => handleChange('vehiculo_placa', e.target.value.toUpperCase())}
            placeholder="Ej: ABC-1234"
            maxLength="10"
            disabled={disabled}
            className={errors.vehiculo_placa ? 'border-red-500' : ''}
          />
          {errors.vehiculo_placa && (
            <p className="text-xs text-red-600">{errors.vehiculo_placa}</p>
          )}
        </div>

        {/* M1L (Marca, Modelo, Línea) */}
        <div className="space-y-2">
          <Label htmlFor="vehiculo_m1l">Marca/Modelo/Línea *</Label>
          <Input
            id="vehiculo_m1l"
            value={data.vehiculo_m1l || ''}
            onChange={(e) => handleChange('vehiculo_m1l', e.target.value)}
            placeholder="Ej: VOLVO FH16"
            disabled={disabled}
            className={errors.vehiculo_m1l ? 'border-red-500' : ''}
          />
          {errors.vehiculo_m1l && (
            <p className="text-xs text-red-600">{errors.vehiculo_m1l}</p>
          )}
        </div>
      </div>
    </div>
  );
}
