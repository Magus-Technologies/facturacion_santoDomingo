import { useState } from "react";
import { Modal, ModalForm, ModalField } from "../ui/modal";
import { Input } from "../ui/input";
import { Button } from "../ui/button";
import { toast } from "@/lib/sweetalert";
import { Loader2 } from "lucide-react";
import { baseUrl } from "@/lib/baseUrl";

export default function MarcaQuickModal({ isOpen, onClose, onSuccess }) {
    const [loading, setLoading] = useState(false);
    const [errors, setErrors] = useState({});
    const [formData, setFormData] = useState({
        nombre_marca: "",
        descripcion: "",
    });

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData((prev) => ({ ...prev, [name]: value }));
        if (errors[name]) {
            setErrors((prev) => {
                const newErrors = { ...prev };
                delete newErrors[name];
                return newErrors;
            });
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setErrors({});

        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch(baseUrl("/api/marcas"), {
                method: "POST",
                headers: {
                    Authorization: `Bearer ${token}`,
                    "Content-Type": "application/json",
                    Accept: "application/json",
                },
                body: JSON.stringify(formData),
            });

            const data = await response.json();

            if (data.success) {
                toast.success("Marca creada exitosamente");
                setFormData({ nombre_marca: "", descripcion: "" });
                onClose();
                onSuccess?.();
            } else {
                if (data.errors) {
                    setErrors(data.errors);
                } else {
                    toast.error(data.message || "Error al crear marca");
                }
            }
        } catch (err) {
            console.error("Error:", err);
            toast.error("Error de conexión al servidor");
        } finally {
            setLoading(false);
        }
    };

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            title="Nueva Marca"
            size="sm"
            footer={
                <>
                    <Button
                        variant="outline"
                        onClick={onClose}
                        disabled={loading}
                    >
                        Cancelar
                    </Button>
                    <Button onClick={handleSubmit} disabled={loading} className="gap-2">
                        {loading && <Loader2 className="h-4 w-4 animate-spin" />}
                        Crear
                    </Button>
                </>
            }
        >
            <ModalForm onSubmit={handleSubmit}>
                <ModalField
                    label="Nombre de Marca:"
                    required
                    error={errors.nombre_marca?.[0]}
                >
                    <Input
                        variant="outlined"
                        name="nombre_marca"
                        value={formData.nombre_marca}
                        onChange={handleChange}
                        placeholder="Nombre de la marca"
                        required
                    />
                </ModalField>

                <ModalField
                    label="Descripción (opcional)"
                    error={errors.descripcion?.[0]}
                >
                    <textarea
                        name="descripcion"
                        value={formData.descripcion}
                        onChange={handleChange}
                        placeholder="Descripción de la marca"
                        className="w-full px-3 py-2 border border-gray-200 rounded-lg focus:outline-none focus:ring-1 focus:ring-primary-500 focus:border-primary-500 text-sm hover:border-gray-300 transition-colors"
                        rows="3"
                    />
                </ModalField>
            </ModalForm>
        </Modal>
    );
}
