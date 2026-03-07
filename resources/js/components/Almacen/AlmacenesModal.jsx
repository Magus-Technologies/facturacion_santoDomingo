import { useState, useEffect } from "react";
import { Modal } from "../ui/modal";
import { Input } from "../ui/input";
import { Button } from "../ui/button";
import { toast, confirmDelete } from "@/lib/sweetalert";
import { baseUrl } from "@/lib/baseUrl";
import { Loader2, Plus, Edit, Trash2, Warehouse, Crown } from "lucide-react";

export default function AlmacenesModal({ isOpen, onClose, onSuccess }) {
    const [almacenes, setAlmacenes] = useState([]);
    const [loading, setLoading] = useState(false);
    const [saving, setSaving] = useState(false);
    const [editando, setEditando] = useState(null);
    const [nombre, setNombre] = useState("");
    const [descripcion, setDescripcion] = useState("");
    const [mostrarForm, setMostrarForm] = useState(false);

    useEffect(() => {
        if (isOpen) {
            fetchAlmacenes();
            resetForm();
        }
    }, [isOpen]);

    const fetchAlmacenes = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem("auth_token");
            const res = await fetch(baseUrl("/api/almacenes"), {
                headers: { Authorization: `Bearer ${token}`, Accept: "application/json" },
            });
            const data = await res.json();
            if (data.success) setAlmacenes(data.data);
        } catch {
            toast.error("Error al cargar almacenes");
        } finally {
            setLoading(false);
        }
    };

    const resetForm = () => {
        setNombre("");
        setDescripcion("");
        setEditando(null);
        setMostrarForm(false);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!nombre.trim()) {
            toast.warning("Ingrese el nombre del almacén");
            return;
        }

        setSaving(true);
        try {
            const token = localStorage.getItem("auth_token");
            const url = editando
                ? baseUrl(`/api/almacenes/${editando.id}`)
                : baseUrl("/api/almacenes");

            const res = await fetch(url, {
                method: editando ? "PUT" : "POST",
                headers: {
                    Authorization: `Bearer ${token}`,
                    "Content-Type": "application/json",
                    Accept: "application/json",
                },
                body: JSON.stringify({ nombre: nombre.trim(), descripcion: descripcion.trim() }),
            });

            const data = await res.json();
            if (data.success) {
                toast.success(data.message);
                fetchAlmacenes();
                resetForm();
                onSuccess?.();
            } else {
                toast.error(data.message || "Error al guardar");
            }
        } catch {
            toast.error("Error de conexión");
        } finally {
            setSaving(false);
        }
    };

    const handleEdit = (alm) => {
        setEditando(alm);
        setNombre(alm.nombre);
        setDescripcion(alm.descripcion || "");
        setMostrarForm(true);
    };

    const handleDelete = (alm) => {
        confirmDelete({
            title: "Eliminar Almacén",
            message: `¿Estás seguro de eliminar el almacén <strong>"${alm.nombre}"</strong>?`,
            confirmText: "Sí, eliminar",
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem("auth_token");
                    const res = await fetch(baseUrl(`/api/almacenes/${alm.id}`), {
                        method: "DELETE",
                        headers: { Authorization: `Bearer ${token}`, Accept: "application/json" },
                    });
                    const data = await res.json();
                    if (data.success) {
                        toast.success(data.message);
                        fetchAlmacenes();
                        onSuccess?.();
                    } else {
                        toast.error(data.message);
                    }
                } catch {
                    toast.error("Error de conexión");
                }
            },
        });
    };

    const principal = almacenes.find((a) => a.es_principal);
    const hijos = almacenes.filter((a) => !a.es_principal);

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            title={
                <div className="flex items-center gap-2">
                    <Warehouse className="h-5 w-5" />
                    Gestionar Almacenes
                </div>
            }
            size="md"
            footer={
                <Button variant="outline" onClick={onClose}>Cerrar</Button>
            }
        >
            <div className="space-y-4">
                {/* Lista de almacenes */}
                {loading ? (
                    <div className="flex justify-center py-8">
                        <Loader2 className="h-6 w-6 animate-spin text-primary-600" />
                    </div>
                ) : (
                    <div className="space-y-2">
                        {/* Principal */}
                        {principal && (
                            <div className="flex items-center justify-between p-3 rounded-lg bg-primary-50 border border-primary-200">
                                <div className="flex items-center gap-3">
                                    <Crown className="h-4 w-4 text-primary-600" />
                                    <div>
                                        <p className="font-semibold text-gray-900">{principal.nombre}</p>
                                        {principal.descripcion && (
                                            <p className="text-xs text-gray-500">{principal.descripcion}</p>
                                        )}
                                    </div>
                                    <span className="text-[10px] font-semibold px-2 py-0.5 rounded-full bg-primary-100 text-primary-700 uppercase">
                                        Principal
                                    </span>
                                </div>
                                <Button
                                    variant="ghost"
                                    size="sm"
                                    onClick={() => handleEdit(principal)}
                                >
                                    <Edit className="h-4 w-4 text-gray-500" />
                                </Button>
                            </div>
                        )}

                        {/* Hijos */}
                        {hijos.map((alm) => (
                            <div key={alm.id} className="flex items-center justify-between p-3 rounded-lg bg-gray-50 border border-gray-200">
                                <div className="flex items-center gap-3">
                                    <Warehouse className="h-4 w-4 text-gray-400" />
                                    <div>
                                        <p className="font-medium text-gray-900">{alm.nombre}</p>
                                        {alm.descripcion && (
                                            <p className="text-xs text-gray-500">{alm.descripcion}</p>
                                        )}
                                    </div>
                                    {alm.padre && (
                                        <span className="text-[10px] text-gray-400">
                                            hijo de {alm.padre.nombre}
                                        </span>
                                    )}
                                </div>
                                <div className="flex items-center gap-1">
                                    <Button variant="ghost" size="sm" onClick={() => handleEdit(alm)}>
                                        <Edit className="h-4 w-4 text-gray-500" />
                                    </Button>
                                    <Button variant="ghost" size="sm" onClick={() => handleDelete(alm)} className="text-red-500 hover:text-red-700 hover:bg-red-50">
                                        <Trash2 className="h-4 w-4" />
                                    </Button>
                                </div>
                            </div>
                        ))}

                        {hijos.length === 0 && (
                            <p className="text-sm text-gray-400 text-center py-2">
                                No hay almacenes hijos creados
                            </p>
                        )}
                    </div>
                )}

                {/* Formulario crear/editar */}
                {mostrarForm ? (
                    <form onSubmit={handleSubmit} className="border rounded-lg p-4 space-y-3 bg-white">
                        <p className="text-sm font-semibold text-gray-700">
                            {editando ? `Editar: ${editando.nombre}` : "Nuevo Almacén (hijo)"}
                        </p>
                        <div>
                            <label className="block text-xs font-medium text-gray-600 mb-1">Nombre *</label>
                            <Input
                                variant="outlined"
                                value={nombre}
                                onChange={(e) => setNombre(e.target.value)}
                                placeholder="Ej: Depósito, Sucursal Norte..."
                                required
                                autoFocus
                            />
                        </div>
                        <div>
                            <label className="block text-xs font-medium text-gray-600 mb-1">Descripción</label>
                            <Input
                                variant="outlined"
                                value={descripcion}
                                onChange={(e) => setDescripcion(e.target.value)}
                                placeholder="Descripción opcional"
                            />
                        </div>
                        <div className="flex gap-2 justify-end">
                            <Button type="button" variant="outline" size="sm" onClick={resetForm} disabled={saving}>
                                Cancelar
                            </Button>
                            <Button type="submit" size="sm" disabled={saving} className="gap-2">
                                {saving && <Loader2 className="h-4 w-4 animate-spin" />}
                                {editando ? "Actualizar" : "Crear"}
                            </Button>
                        </div>
                    </form>
                ) : (
                    <Button
                        variant="outline"
                        className="w-full gap-2"
                        onClick={() => setMostrarForm(true)}
                    >
                        <Plus className="h-4 w-4" />
                        Agregar Almacén
                    </Button>
                )}
            </div>
        </Modal>
    );
}
