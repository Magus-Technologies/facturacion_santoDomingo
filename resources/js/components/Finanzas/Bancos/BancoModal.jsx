import { Modal, ModalForm, ModalField } from '@/components/ui/modal';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';
import { Loader2 } from 'lucide-react';
import { useBancoForm } from './hooks/useBancoForm';

export default function BancoModal({ isOpen, onClose, banco, onSuccess }) {
    const { formData, loading, errors, isEditing, handleChange, handleSubmit } =
        useBancoForm(banco, isOpen, onClose, onSuccess);

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            title={isEditing ? 'Editar Banco' : 'Nuevo Banco'}
            size="md"
            footer={
                <>
                    <Button variant="outline" onClick={onClose} disabled={loading}>Cancelar</Button>
                    <Button onClick={handleSubmit} disabled={loading} className="gap-2">
                        {loading && <Loader2 className="h-4 w-4 animate-spin" />}
                        {isEditing ? 'Actualizar' : 'Guardar'}
                    </Button>
                </>
            }
        >
            <ModalForm onSubmit={handleSubmit}>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <ModalField label="Nombre" required error={errors.nombre?.[0]} className="md:col-span-2">
                        <Input variant="outlined" name="nombre" value={formData.nombre}
                            onChange={handleChange} placeholder="Ej: Banco de Crédito del Perú" required />
                    </ModalField>
                    <ModalField label="Código SUNAT" error={errors.codigo_sunat?.[0]}>
                        <Input variant="outlined" name="codigo_sunat" value={formData.codigo_sunat}
                            onChange={handleChange} placeholder="Ej: 002" />
                    </ModalField>
                    <ModalField label="Código SWIFT" error={errors.codigo_swift?.[0]}>
                        <Input variant="outlined" name="codigo_swift" value={formData.codigo_swift}
                            onChange={handleChange} placeholder="Ej: BCPLPEPL" />
                    </ModalField>
                    <ModalField label="Teléfono" error={errors.telefono?.[0]}>
                        <Input variant="outlined" name="telefono" value={formData.telefono}
                            onChange={handleChange} placeholder="Ej: 01-311-9898" />
                    </ModalField>
                    <ModalField label="Email" error={errors.email?.[0]}>
                        <Input variant="outlined" type="email" name="email" value={formData.email}
                            onChange={handleChange} placeholder="contacto@banco.com" />
                    </ModalField>
                    <ModalField label="Sitio Web" error={errors.website?.[0]} className="md:col-span-2">
                        <Input variant="outlined" name="website" value={formData.website}
                            onChange={handleChange} placeholder="https://www.banco.com.pe" />
                    </ModalField>
                    <div className="md:col-span-2 flex items-center gap-2">
                        <input type="checkbox" id="activo" name="activo" checked={formData.activo}
                            onChange={handleChange} className="h-4 w-4 accent-primary-600" />
                        <label htmlFor="activo" className="text-sm text-gray-700">Banco activo</label>
                    </div>
                </div>
            </ModalForm>
        </Modal>
    );
}
