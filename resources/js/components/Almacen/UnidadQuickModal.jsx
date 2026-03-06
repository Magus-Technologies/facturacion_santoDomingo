import { useState } from "react";
import { Modal } from "../ui/modal";
import { Input } from "../ui/input";
import { Button } from "../ui/button";
import { toast } from "@/lib/sweetalert";
import { Loader2 } from "lucide-react";
import { baseUrl } from "@/lib/baseUrl";

export default function UnidadQuickModal({ isOpen, onClose, onSuccess }) {
    const [loading, setLoading] = useState(false);
    const [nombre, setNombre] = useState("");
    const [codigo, setCodigo] = useState("");

    const handleSubmit = async (e) => {
        e.preventDefault();
        
        if (!nombre.trim()) {
            toast.warning("Ingrese el nombre de la unidad");
            return;
        }

        setLoading(true);

        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch(baseUrl("/api/unidades"), {
                method: "POST",
                headers: {
                    Authorization: `Bearer ${token}`,
                    "Content-Type": "application/json",
                    Accept: "application/json",
                },
                body: JSON.stringify({ nombre: nombre.trim(), codigo: codigo.trim().toUpperCase() || null }),
            });

            const data = await response.json();

            if (data.success) {
                toast.success("Unidad creada exitosamente");
                setNombre("");
                setCodigo("");
                onSuccess?.(data.data);
                onClose();
            } else if (data.errors?.nombre) {
                toast.error(`La unidad "${nombre.trim()}" ya existe`);
            } else {
                toast.error(data.message || "Error al crear unidad");
            }
        } catch (err) {
            console.error("Error:", err);
            toast.error("Error de conexión al servidor");
        } finally {
            setLoading(false);
        }
    };

    const handleClose = () => {
        setNombre("");
        setCodigo("");
        onClose();
    };

    return (
        <Modal
            isOpen={isOpen}
            onClose={handleClose}
            title="Nueva Unidad de Medida"
            size="sm"
            footer={
                <>
                    <Button
                        variant="outline"
                        onClick={handleClose}
                        disabled={loading}
                        size="sm"
                    >
                        Cancelar
                    </Button>
                    <Button
                        onClick={handleSubmit}
                        disabled={loading}
                        size="sm"
                        className="gap-2"
                    >
                        {loading && <Loader2 className="h-4 w-4 animate-spin" />}
                        Guardar
                    </Button>
                </>
            }
        >
            <form onSubmit={handleSubmit} className="space-y-4 p-1">
                <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                        Nombre de la Unidad <span className="text-red-500">*</span>
                    </label>
                    <Input
                        variant="outlined"
                        value={nombre}
                        onChange={(e) => setNombre(e.target.value)}
                        placeholder="Ej: Unidad, Caja, Kilogramo, etc."
                        required
                        autoFocus
                    />
                </div>
                <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                        Código SUNAT
                    </label>
                    <p className="text-xs text-gray-500 mb-2">
                        Catálogo N°84: NIU=Unidad, KGM=Kg, LTR=Litro, ZZ=Servicio, GRM=Gramo, BX=Caja
                    </p>
                    <Input
                        variant="outlined"
                        value={codigo}
                        onChange={(e) => setCodigo(e.target.value.toUpperCase())}
                        placeholder="Ej: NIU, KGM, LTR"
                        maxLength={5}
                    />
                </div>
            </form>
        </Modal>
    );
}
