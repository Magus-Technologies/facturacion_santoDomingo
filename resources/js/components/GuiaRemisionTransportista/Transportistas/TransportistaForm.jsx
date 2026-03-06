import { useState, useEffect } from 'react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Checkbox } from '@/components/ui/checkbox';

export function TransportistaForm({ transportista, onSubmit, isLoading }) {
  const [formData, setFormData] = useState({
    tipo_documento: '6',
    numero_documento: '',
    razon_social: '',
    nombre_comercial: '',
    numero_mtc: '',
    telefono: '',
    email: '',
    direccion: '',
    estado: true,
  });

  const [errors, setErrors] = useState({});

  useEffect(() => {
    if (transportista) {
      setFormData(transportista);
    }
  }, [transportista]);

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value,
    }));
    if (errors[name]) {
      setErrors((prev) => ({ ...prev, [name]: '' }));
    }
  };

  const handleSelectChange = (name, value) => {
    setFormData((prev) => ({ ...prev, [name]: value }));
    if (errors[name]) {
      setErrors((prev) => ({ ...prev, [name]: '' }));
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(formData, setErrors);
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {/* Tipo de Documento */}
        <div className="space-y-2">
          <Label htmlFor="tipo_documento">Tipo de Documento *</Label>
          <Select value={formData.tipo_documento} onValueChange={(value) => handleSelectChange('tipo_documento', value)}>
            <SelectTrigger id="tipo_documento">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="1">DNI</SelectItem>
              <SelectItem value="6">RUC</SelectItem>
            </SelectContent>
          </Select>
          {errors.tipo_documento && <p className="text-sm text-red-500">{errors.tipo_documento}</p>}
        </div>

        {/* Número de Documento */}
        <div className="space-y-2">
          <Label htmlFor="numero_documento">Número de Documento *</Label>
          <Input
            id="numero_documento"
            name="numero_documento"
            value={formData.numero_documento}
            onChange={handleChange}
            placeholder="Ej: 20123456789"
            maxLength="15"
            aria-invalid={!!errors.numero_documento}
          />
          {errors.numero_documento && <p className="text-sm text-red-500">{errors.numero_documento}</p>}
        </div>

        {/* Razón Social */}
        <div className="space-y-2 md:col-span-2">
          <Label htmlFor="razon_social">Razón Social *</Label>
          <Input
            id="razon_social"
            name="razon_social"
            value={formData.razon_social}
            onChange={handleChange}
            placeholder="Ej: TRANSPORTES BETA SAC"
            aria-invalid={!!errors.razon_social}
          />
          {errors.razon_social && <p className="text-sm text-red-500">{errors.razon_social}</p>}
        </div>

        {/* Nombre Comercial */}
        <div className="space-y-2">
          <Label htmlFor="nombre_comercial">Nombre Comercial</Label>
          <Input
            id="nombre_comercial"
            name="nombre_comercial"
            value={formData.nombre_comercial}
            onChange={handleChange}
            placeholder="Ej: BETA"
          />
        </div>

        {/* Número MTC */}
        <div className="space-y-2">
          <Label htmlFor="numero_mtc">Nro. MTC</Label>
          <Input
            id="numero_mtc"
            name="numero_mtc"
            value={formData.numero_mtc}
            onChange={handleChange}
            placeholder="Ej: 123456"
            maxLength="20"
          />
        </div>

        {/* Teléfono */}
        <div className="space-y-2">
          <Label htmlFor="telefono">Teléfono</Label>
          <Input
            id="telefono"
            name="telefono"
            value={formData.telefono}
            onChange={handleChange}
            placeholder="Ej: +51987654321"
            maxLength="20"
          />
        </div>

        {/* Email */}
        <div className="space-y-2">
          <Label htmlFor="email">Email</Label>
          <Input
            id="email"
            name="email"
            type="email"
            value={formData.email}
            onChange={handleChange}
            placeholder="Ej: info@transportes.com"
          />
        </div>

        {/* Dirección */}
        <div className="space-y-2 md:col-span-2">
          <Label htmlFor="direccion">Dirección</Label>
          <Input
            id="direccion"
            name="direccion"
            value={formData.direccion}
            onChange={handleChange}
            placeholder="Ej: Av. Principal 123"
          />
        </div>

        {/* Estado */}
        <div className="flex items-center space-x-2">
          <Checkbox
            id="estado"
            name="estado"
            checked={formData.estado}
            onCheckedChange={(checked) => handleSelectChange('estado', checked)}
          />
          <Label htmlFor="estado" className="font-normal cursor-pointer">
            Activo
          </Label>
        </div>
      </div>

      {/* Botones */}
      <div className="flex gap-2 justify-end">
        <Button type="submit" disabled={isLoading}>
          {isLoading ? 'Guardando...' : 'Guardar'}
        </Button>
      </div>
    </form>
  );
}
