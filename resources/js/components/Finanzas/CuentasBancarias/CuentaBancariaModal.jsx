import { Modal, ModalForm, ModalField } from '@/components/ui/modal';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Loader2 } from 'lucide-react';
import { useCuentaBancariaForm } from './hooks/useCuentaBancariaForm';

const TIPOS_CUENTA = ['Corriente', 'Ahorros', 'Plazo Fijo', 'Recaudadora', 'CTS'];
const MONEDAS = [{ value: 'PEN', label: 'PEN - Soles' }, { value: 'USD', label: 'USD - Dólares' }, { value: 'EUR', label: 'EUR - Euros' }];

export default function CuentaBancariaModal({ isOpen, onClose, cuenta, onSuccess }) {
    const { formData, bancos, loading, errors, isEditing, handleChange, handleSelectChange, handleSubmit } =
        useCuentaBancariaForm(cuenta, isOpen, onClose, onSuccess);

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            title={isEditing ? 'Editar Cuenta Bancaria' : 'Nueva Cuenta Bancaria'}
            size="md"
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
                    <ModalField label="Banco" required error={errors.id_banco?.[0]} className="md:col-span-2">
                        <Select value={formData.id_banco ? String(formData.id_banco) : 'none'} onValueChange={(v) => handleSelectChange('id_banco', v === 'none' ? '' : v)}>
                            <SelectTrigger><SelectValue placeholder="Seleccionar banco" /></SelectTrigger>
                            <SelectContent>
                                <SelectItem value="none">Sin banco</SelectItem>
                                {bancos.map(b => <SelectItem key={b.id_banco} value={String(b.id_banco)}>{b.nombre}</SelectItem>)}
                            </SelectContent>
                        </Select>
                    </ModalField>
                    <ModalField label="Número de Cuenta" required error={errors.numero_cuenta?.[0]} className="md:col-span-2">
                        <Input variant="outlined" name="numero_cuenta" value={formData.numero_cuenta}
                            onChange={handleChange} placeholder="Ej: 193-123456789-0-12" required />
                    </ModalField>
                    <ModalField label="Titular" required error={errors.titular?.[0]} className="md:col-span-2">
                        <Input variant="outlined" name="titular" value={formData.titular}
                            onChange={handleChange} placeholder="Nombre del titular" required />
                    </ModalField>
                    <ModalField label="Tipo de Cuenta" required error={errors.tipo_cuenta?.[0]}>
                        <Select value={formData.tipo_cuenta} onValueChange={(v) => handleSelectChange('tipo_cuenta', v)}>
                            <SelectTrigger><SelectValue placeholder="Seleccionar tipo" /></SelectTrigger>
                            <SelectContent>
                                {TIPOS_CUENTA.map(t => <SelectItem key={t} value={t}>{t}</SelectItem>)}
                            </SelectContent>
                        </Select>
                    </ModalField>
                    <ModalField label="Moneda" required error={errors.moneda?.[0]}>
                        <Select value={formData.moneda} onValueChange={(v) => handleSelectChange('moneda', v)}>
                            <SelectTrigger><SelectValue placeholder="Seleccionar moneda" /></SelectTrigger>
                            <SelectContent>
                                {MONEDAS.map(m => <SelectItem key={m.value} value={m.value}>{m.label}</SelectItem>)}
                            </SelectContent>
                        </Select>
                    </ModalField>
                    {!isEditing && (
                        <ModalField label="Saldo Inicial" required error={errors.saldo_actual?.[0]}>
                            <Input variant="outlined" name="saldo_actual" type="number" step="0.01" min="0"
                                value={formData.saldo_actual} onChange={handleChange} placeholder="0.00" required />
                        </ModalField>
                    )}
                    <ModalField label="CCI" error={errors.cci?.[0]} className={!isEditing ? '' : 'md:col-span-1'}>
                        <Input variant="outlined" name="cci" value={formData.cci}
                            onChange={handleChange} placeholder="Código de Cuenta Interbancario (17 dígitos)" />
                    </ModalField>
                    <ModalField label="Alias" error={errors.alias?.[0]} className="md:col-span-2">
                        <Input variant="outlined" name="alias" value={formData.alias}
                            onChange={handleChange} placeholder="Ej: Cuenta principal BCP" />
                    </ModalField>
                    <div className="md:col-span-2 flex items-center gap-2">
                        <input type="checkbox" id="activa" name="activa" checked={formData.activa}
                            onChange={handleChange} className="h-4 w-4 accent-primary-600" />
                        <label htmlFor="activa" className="text-sm text-gray-700">Cuenta activa</label>
                    </div>
                </div>
            </ModalForm>
        </Modal>
    );
}
