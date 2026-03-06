import { Modal, ModalForm, ModalField } from '@/components/ui/modal';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Loader2 } from 'lucide-react';
import { useMetodoPagoForm } from './hooks/useMetodoPagoForm';

const TIPOS = ['Efectivo', 'Tarjeta', 'Transferencia', 'Billetera', 'Cheque', 'Otro'];

export default function MetodoPagoModal({ isOpen, onClose, metodo, onSuccess }) {
    const { formData, bancos, cuentas, loading, errors, isEditing, handleChange, handleSubmit } =
        useMetodoPagoForm(metodo, isOpen, onClose, onSuccess);

    const handleSelectChange = (name) => (value) => handleChange({ target: { name, value } });

    return (
        <Modal isOpen={isOpen} onClose={onClose} title={isEditing ? 'Editar Método de Pago' : 'Nuevo Método de Pago'} size="md"
            footer={
                <>
                    <Button variant="outline" onClick={onClose} disabled={loading}>Cancelar</Button>
                    <Button onClick={handleSubmit} disabled={loading} className="gap-2 bg-primary-600 hover:bg-primary-700 text-white">
                        {loading && <Loader2 className="h-4 w-4 animate-spin" />}
                        {isEditing ? 'Actualizar' : 'Guardar'}
                    </Button>
                </>
            }
        >
            <ModalForm onSubmit={handleSubmit}>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <ModalField label="Nombre del Método" required error={errors.nombre?.[0]} className="md:col-span-2">
                        <Input variant="outlined" name="nombre" value={formData.nombre} onChange={handleChange}
                            placeholder="Ej: Yape, Plin, Efectivo, Tarjeta de Crédito" required />
                    </ModalField>
                    <ModalField label="Código Interno" required error={errors.codigo?.[0]}>
                        <Input variant="outlined" name="codigo" value={formData.codigo} onChange={handleChange}
                            placeholder="Ej: YAPE, PLIN, CASH, VISA" required />
                    </ModalField>
                    <ModalField label="Tipo" required error={errors.tipo?.[0]}>
                        <Select value={formData.tipo} onValueChange={handleSelectChange('tipo')}>
                            <SelectTrigger><SelectValue placeholder="Seleccionar tipo" /></SelectTrigger>
                            <SelectContent>
                                {TIPOS.map(t => <SelectItem key={t} value={t}>{t}</SelectItem>)}
                            </SelectContent>
                        </Select>
                    </ModalField>
                    <ModalField label="Número de Celular" error={errors.telefono?.[0]}>
                        <Input variant="outlined" name="telefono" value={formData.telefono || ''} onChange={handleChange}
                            placeholder="Ej: 987654321" type="tel" />
                    </ModalField>

                    {/* Destino del dinero */}
                    <div className="md:col-span-2">
                        <div className="flex items-center gap-2 mb-3">
                            <input type="checkbox" id="es_efectivo" name="es_efectivo"
                                checked={formData.es_efectivo} onChange={handleChange}
                                className="h-4 w-4 accent-primary-600" />
                            <label htmlFor="es_efectivo" className="text-sm font-medium text-gray-700">
                                Es pago en efectivo (el dinero queda en caja, no va a banco)
                            </label>
                        </div>
                    </div>

                    {!formData.es_efectivo && (
                        <>
                            <ModalField label="Banco" error={errors.id_banco?.[0]}>
                                <Select value={formData.id_banco ? String(formData.id_banco) : 'none'}
                                    onValueChange={(value) => handleSelectChange('id_banco')(value === 'none' ? '' : value)}>
                                    <SelectTrigger><SelectValue placeholder="Seleccionar banco..." /></SelectTrigger>
                                    <SelectContent>
                                        <SelectItem value="none">Sin banco</SelectItem>
                                        {bancos.map(b => <SelectItem key={b.id_banco} value={String(b.id_banco)}>{b.nombre}</SelectItem>)}
                                    </SelectContent>
                                </Select>
                            </ModalField>

                            <ModalField label="Cuenta Bancaria Destino" error={errors.id_cuenta?.[0]}>
                                <Select value={formData.id_cuenta ? String(formData.id_cuenta) : 'none'}
                                    onValueChange={(value) => handleSelectChange('id_cuenta')(value === 'none' ? '' : value)}
                                    disabled={!formData.id_banco}>
                                    <SelectTrigger>
                                        <SelectValue placeholder={formData.id_banco ? 'Seleccionar cuenta...' : 'Primero selecciona un banco'} />
                                    </SelectTrigger>
                                    <SelectContent>
                                        <SelectItem value="none">Sin cuenta específica</SelectItem>
                                        {cuentas.map(c => (
                                            <SelectItem key={c.id_cuenta} value={String(c.id_cuenta)}>
                                                {c.numero_cuenta} ({c.tipo_cuenta})
                                            </SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                                {formData.id_banco && cuentas.length === 0 && (
                                    <p className="text-xs text-amber-600 mt-1">No hay cuentas registradas para este banco</p>
                                )}
                            </ModalField>
                        </>
                    )}

                    <ModalField label="Descripción" error={errors.descripcion?.[0]} className="md:col-span-2">
                        <textarea name="descripcion" value={formData.descripcion} onChange={handleChange}
                            rows={2} placeholder="Descripción opcional..."
                            className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500 resize-none" />
                    </ModalField>
                    <div className="md:col-span-2 space-y-2">
                        <label className="text-sm font-medium text-gray-700">Requisitos</label>
                        <div className="flex flex-col gap-2">
                            {[
                                { name: 'requiere_referencia', label: 'Requiere número de referencia/operación' },
                                { name: 'requiere_comprobante', label: 'Requiere foto de comprobante' },
                                { name: 'activo', label: 'Método activo' },
                            ].map(({ name, label }) => (
                                <div key={name} className="flex items-center gap-2">
                                    <input type="checkbox" id={name} name={name} checked={formData[name]}
                                        onChange={handleChange} className="h-4 w-4 accent-primary-600" />
                                    <label htmlFor={name} className="text-sm text-gray-700">{label}</label>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>
            </ModalForm>
        </Modal>
    );
}
