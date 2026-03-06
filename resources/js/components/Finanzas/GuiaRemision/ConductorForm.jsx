import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';

export default function ConductorForm({ 
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
        {/* Tipo de Documento */}
        <div className="space-y-2">
          <Label htmlFor="conductor_tipo_doc">Tipo de Documento *</Label>
          <Select 
            value={data.conductor_tipo_doc || '1'} 
            onValueChange={(value) => handleChange('conductor_tipo_doc', value)}
            disabled={disabled}
          >
            <SelectTrigger id="conductor_tipo_doc">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="1">DNI</SelectItem>
              <SelectItem value="6">RUC</SelectItem>
            </SelectContent>
          </Select>
          {errors.conductor_tipo_doc && (
            <p className="text-xs text-red-600">{errors.conductor_tipo_doc}</p>
          )}
        </div>

        {/* Número de Documento */}
        <div className="space-y-2">
          <Label htmlFor="conductor_documento">Número de Documento *</Label>
          <Input
            id="conductor_documento"
            value={data.conductor_documento || ''}
            onChange={(e) => handleChange('conductor_documento', e.target.value.replace(/\D/g, ''))}
            placeholder="Ej: 12345678"
            maxLength="15"
            disabled={disabled}
            className={errors.conductor_documento ? 'border-red-500' : ''}
          />
          {errors.conductor_documento && (
            <p className="text-xs text-red-600">{errors.conductor_documento}</p>
          )}
        </div>

        {/* Nombres */}
        <div className="space-y-2">
          <Label htmlFor="conductor_nombres">Nombres *</Label>
          <Input
            id="conductor_nombres"
            value={data.conductor_nombres || ''}
            onChange={(e) => handleChange('conductor_nombres', e.target.value)}
            placeholder="Ej: Juan"
            disabled={disabled}
            className={errors.conductor_nombres ? 'border-red-500' : ''}
          />
          {errors.conductor_nombres && (
            <p className="text-xs text-red-600">{errors.conductor_nombres}</p>
          )}
        </div>

        {/* Apellidos */}
        <div className="space-y-2">
          <Label htmlFor="conductor_apellidos">Apellidos *</Label>
          <Input
            id="conductor_apellidos"
            value={data.conductor_apellidos || ''}
            onChange={(e) => handleChange('conductor_apellidos', e.target.value)}
            placeholder="Ej: Pérez García"
            disabled={disabled}
            className={errors.conductor_apellidos ? 'border-red-500' : ''}
          />
          {errors.conductor_apellidos && (
            <p className="text-xs text-red-600">{errors.conductor_apellidos}</p>
          )}
        </div>

        {/* Licencia */}
        <div className="space-y-2 md:col-span-2">
          <Label htmlFor="conductor_licencia">Número de Licencia *</Label>
          <Input
            id="conductor_licencia"
            value={data.conductor_licencia || ''}
            onChange={(e) => handleChange('conductor_licencia', e.target.value)}
            placeholder="Ej: B123456"
            disabled={disabled}
            className={errors.conductor_licencia ? 'border-red-500' : ''}
          />
          {errors.conductor_licencia && (
            <p className="text-xs text-red-600">{errors.conductor_licencia}</p>
          )}
        </div>
      </div>
    </div>
  );
}
