import { useState, useEffect } from "react";
import { Modal, ModalField } from "@/components/ui/modal";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Loader2 } from "lucide-react";

export default function PagarCuotaModal({ isOpen, onClose, cuota, onPagar }) {
    const [fechaPago, setFechaPago] = useState(new Date().toISOString().split('T')[0]);
    const [saving, setSaving] = useState(false);

    useEffect(() => {
        if (isOpen) {
            setFechaPago(new Date().toISOString().split('T')[0]);
        }
    }, [isOpen]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!fechaPago) return;

        setSaving(true);
        const success = await onPagar(cuota.dias_compra_id, {
            fecha_pago: fechaPago,
        });
        setSaving(false);
        if (success) onClose();
    };

    if (!cuota) return null;

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            title="Registrar Pago"
            size="sm"
            footer={
                <>
                    <Button variant="outline" onClick={onClose} disabled={saving}>
                        Cancelar
                    </Button>
                    <Button onClick={handleSubmit} disabled={saving}>
                        {saving && <Loader2 className="h-4 w-4 mr-2 animate-spin" />}
                        Registrar Pago
                    </Button>
                </>
            }
        >
            <div className="space-y-4">
                <div className="bg-gray-50 rounded-lg p-4 space-y-2">
                    <div className="flex justify-between text-sm">
                        <span className="text-gray-600">Documento:</span>
                        <span className="font-medium">{cuota.documento}</span>
                    </div>
                    <div className="flex justify-between text-sm">
                        <span className="text-gray-600">Proveedor:</span>
                        <span className="font-medium truncate ml-2">{cuota.proveedor}</span>
                    </div>
                    <div className="flex justify-between text-sm">
                        <span className="text-gray-600">F. Vencimiento:</span>
                        <span className="font-medium">
                            {cuota.fecha_vencimiento ? cuota.fecha_vencimiento.split('-').reverse().join('/') : '—'}
                        </span>
                    </div>
                    <div className="flex justify-between text-sm font-bold text-primary-700">
                        <span>Monto:</span>
                        <span>S/ {parseFloat(cuota.monto).toFixed(2)}</span>
                    </div>
                </div>

                <ModalField label="Fecha de pago" required>
                    <Input
                        type="date"
                        value={fechaPago}
                        onChange={(e) => setFechaPago(e.target.value)}
                    />
                </ModalField>
            </div>
        </Modal>
    );
}
