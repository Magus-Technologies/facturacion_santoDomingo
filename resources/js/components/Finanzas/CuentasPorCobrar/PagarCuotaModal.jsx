import { useState, useEffect } from "react";
import { Modal, ModalField } from "@/components/ui/modal";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Loader2 } from "lucide-react";

export default function PagarCuotaModal({ isOpen, onClose, cuota, onPagar }) {
    const [formData, setFormData] = useState({
        monto_pagado: '',
        fecha_pago: new Date().toISOString().split('T')[0],
        observaciones: '',
    });
    const [saving, setSaving] = useState(false);

    useEffect(() => {
        if (cuota && isOpen) {
            setFormData({
                monto_pagado: cuota.saldo || '',
                fecha_pago: new Date().toISOString().split('T')[0],
                observaciones: '',
            });
        }
    }, [cuota, isOpen]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!formData.monto_pagado || parseFloat(formData.monto_pagado) <= 0) return;

        setSaving(true);
        const success = await onPagar(cuota.id_dia_venta, {
            monto_pagado: parseFloat(formData.monto_pagado),
            fecha_pago: formData.fecha_pago,
            observaciones: formData.observaciones,
        });
        setSaving(false);
        if (success) onClose();
    };

    if (!cuota) return null;

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            title="Registrar Cobro"
            size="sm"
            footer={
                <>
                    <Button variant="outline" onClick={onClose} disabled={saving}>
                        Cancelar
                    </Button>
                    <Button onClick={handleSubmit} disabled={saving}>
                        {saving && <Loader2 className="h-4 w-4 mr-2 animate-spin" />}
                        Registrar Cobro
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
                        <span className="text-gray-600">Cliente:</span>
                        <span className="font-medium truncate ml-2">{cuota.cliente}</span>
                    </div>
                    <div className="flex justify-between text-sm">
                        <span className="text-gray-600">Cuota N°:</span>
                        <span className="font-medium">{cuota.numero_cuota}</span>
                    </div>
                    <div className="flex justify-between text-sm">
                        <span className="text-gray-600">Monto cuota:</span>
                        <span className="font-medium">S/ {parseFloat(cuota.monto_cuota).toFixed(2)}</span>
                    </div>
                    <div className="flex justify-between text-sm font-bold text-primary-700">
                        <span>Saldo pendiente:</span>
                        <span>S/ {parseFloat(cuota.saldo).toFixed(2)}</span>
                    </div>
                </div>

                <ModalField label="Monto a cobrar" required>
                    <Input
                        type="number"
                        step="0.01"
                        min="0.01"
                        max={cuota.saldo}
                        value={formData.monto_pagado}
                        onChange={(e) => setFormData({ ...formData, monto_pagado: e.target.value })}
                    />
                </ModalField>

                <ModalField label="Fecha de pago" required>
                    <Input
                        type="date"
                        value={formData.fecha_pago}
                        onChange={(e) => setFormData({ ...formData, fecha_pago: e.target.value })}
                    />
                </ModalField>

                <ModalField label="Observaciones">
                    <textarea
                        className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-primary-500"
                        rows={3}
                        value={formData.observaciones}
                        onChange={(e) => setFormData({ ...formData, observaciones: e.target.value })}
                        placeholder="Observaciones del pago..."
                    />
                </ModalField>
            </div>
        </Modal>
    );
}
