import { useState, useEffect, useCallback } from "react";
import { Modal, ModalForm, ModalField } from "../ui/modal";
import { Input } from "../ui/input";
import { Button } from "../ui/button";
import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from "../ui/select";
import { toast } from "@/lib/sweetalert";
import { Loader2, Image as ImageIcon, Plus, Trash2 } from "lucide-react";
import CategoriaQuickModal from "./CategoriaQuickModal";
import UnidadQuickModal from "./UnidadQuickModal";
import MarcaQuickModal from "./MarcaQuickModal";
import { baseUrl } from "@/lib/baseUrl";

export default function ProductoModal({
    isOpen,
    onClose,
    producto,
    almacen,
    esPrincipal,
    almacenes = [],
    onSuccess,
}) {
    const isEditing = !!producto;
    const [loading, setLoading] = useState(false);
    const [errors, setErrors] = useState({});
    const [categorias, setCategorias] = useState([]);
    const [marcas, setMarcas] = useState([]);
    const [unidades, setUnidades] = useState([]);
    const [imagePreview, setImagePreview] = useState(null);
    const [isAutoCode, setIsAutoCode] = useState(true);
    const [replicarHijos, setReplicarHijos] = useState(false);
    const [showCategoriaModal, setShowCategoriaModal] = useState(false);
    const [showUnidadModal, setShowUnidadModal] = useState(false);
    const [showMarcaModal, setShowMarcaModal] = useState(false);
    const [activeTab, setActiveTab] = useState("general");
    const [ofertas, setOfertas] = useState([]);
    const [ofertaForm, setOfertaForm] = useState({
        tipo: "porcentaje",
        valor: "0.00",
        fecha_inicio: new Date().toISOString().split("T")[0],
        fecha_fin: "",
        descripcion: "",
    });

    const tieneHijos = almacenes.some((a) => !a.es_principal);

    const [formData, setFormData] = useState({
        nombre: "",
        codigo: "",
        detalle: "",
        categoria_id: "",
        marca_id: "",
        precio: "0.00",
        costo: "0.00",
        cantidad: "0",
        unidad_id: "",
        almacen: almacen || "1",
        moneda: "PEN",
        codsunat: "51121703",
        iscbp: "0",
        precio_mayor: "0.00",
        precio_menor: "0.00",
        usar_multiprecio: "0",
        imagen: null,
    });

    useEffect(() => {
        if (isOpen) {
            fetchCategorias();
            fetchMarcas();
            fetchUnidades();

            if (producto) {
                setFormData({
                    nombre: producto.nombre || "",
                    codigo: producto.codigo || "",
                    detalle: producto.descripcion || "",
                    categoria_id: producto.categoria_id
                        ? producto.categoria_id.toString()
                        : "",
                    marca_id: producto.marca_id || "",
                    precio: producto.precio || "0.00",
                    costo: producto.costo || "0.00",
                    cantidad: producto.cantidad || "0",
                    unidad_id: producto.unidad_id
                        ? producto.unidad_id.toString()
                        : "",
                    almacen: producto.almacen
                        ? producto.almacen.toString()
                        : almacen
                          ? almacen.toString()
                          : "1",
                    moneda: producto.moneda || "PEN",
                    codsunat: producto.codsunat || "51121703",
                    iscbp: producto.iscbp || "0",
                    precio_mayor: producto.precio_mayor || "0.00",
                    precio_menor: producto.precio_menor || "0.00",
                    usar_multiprecio: producto.usar_multiprecio || "0",
                    imagen: null,
                });

                if (producto.imagen) {
                    setImagePreview(`/storage/${producto.imagen}`);
                } else {
                    setImagePreview(null);
                }

                setIsAutoCode(!producto.codigo);
                fetchOfertas(producto.id_producto);
            } else {
                setFormData({
                    nombre: "",
                    codigo: "",
                    detalle: "",
                    categoria_id: "",
                    marca_id: "",
                    precio: "0.00",
                    costo: "0.00",
                    cantidad: "0",
                    unidad_id: "",
                    almacen: almacen || "1",
                    moneda: "PEN",
                    codsunat: "51121703",
                    iscbp: "0",
                    precio_mayor: "0.00",
                    precio_menor: "0.00",
                    usar_multiprecio: "0",
                    imagen: null,
                });
                setImagePreview(null);
                setIsAutoCode(true);
                setOfertas([]);
            }
            setErrors({});
            setActiveTab("general");
        }
    }, [producto, isOpen, almacen]);

    const fetchCategorias = async () => {
        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch(baseUrl("/api/categorias"), {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                },
            });
            const data = await response.json();
            if (data.success) {
                setCategorias(data.data);
            }
        } catch (error) {
            console.error("Error al cargar categorías:", error);
        }
    };

    const fetchMarcas = async () => {
        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch(baseUrl("/api/marcas"), {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                },
            });
            const data = await response.json();
            if (data.success) {
                setMarcas(data.data);
            }
        } catch (error) {
            console.error("Error al cargar marcas:", error);
        }
    };

    const fetchUnidades = async () => {
        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch(baseUrl("/api/unidades"), {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                },
            });
            const data = await response.json();
            if (data.success) {
                setUnidades(data.data);
            }
        } catch (error) {
            console.error("Error al cargar unidades:", error);
        }
    };

    const fetchOfertas = async (productoId) => {
        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch(
                baseUrl(`/api/productos/${productoId}/ofertas`),
                {
                    headers: {
                        Authorization: `Bearer ${token}`,
                        Accept: "application/json",
                    },
                }
            );
            const data = await response.json();
            if (data.success) {
                setOfertas(data.data || []);
            }
        } catch (error) {
            console.error("Error al cargar ofertas:", error);
        }
    };

    const handleChange = useCallback((e) => {
        const { name, value } = e.target;
        setFormData((prev) => ({ ...prev, [name]: value }));
        setErrors((prev) => {
            if (prev[name]) {
                const newErrors = { ...prev };
                delete newErrors[name];
                return newErrors;
            }
            return prev;
        });
    }, []);

    const handleImageChange = useCallback((e) => {
        const file = e.target.files[0];
        if (file) {
            setFormData((prev) => ({ ...prev, imagen: file }));

            const reader = new FileReader();
            reader.onloadend = () => {
                setImagePreview(reader.result);
            };
            reader.readAsDataURL(file);
        }
    }, []);

    const handleOfertaChange = (e) => {
        const { name, value } = e.target;
        setOfertaForm((prev) => ({ ...prev, [name]: value }));
    };

    const handleAgregarOferta = async () => {
        if (!producto) {
            toast.error("Guarda el producto primero");
            return;
        }

        try {
            const token = localStorage.getItem("auth_token");
            const empresaActiva = JSON.parse(
                localStorage.getItem("empresa_activa") || "{}"
            );

            const payload = {
                id_producto: producto.id_producto,
                id_empresa: empresaActiva.id_empresa || 1,
                tipo: ofertaForm.tipo,
                valor: parseFloat(ofertaForm.valor),
                fecha_inicio: ofertaForm.fecha_inicio,
                fecha_fin: ofertaForm.fecha_fin || null,
                estado: "1",
                descripcion: ofertaForm.descripcion,
            };

            const response = await fetch(baseUrl("/api/ofertas"), {
                method: "POST",
                headers: {
                    Authorization: `Bearer ${token}`,
                    "Content-Type": "application/json",
                    Accept: "application/json",
                },
                body: JSON.stringify(payload),
            });

            const data = await response.json();

            if (data.success) {
                setOfertas([...ofertas, data.data]);
                setOfertaForm({
                    tipo: "porcentaje",
                    valor: "0.00",
                    fecha_inicio: new Date().toISOString().split("T")[0],
                    fecha_fin: "",
                    descripcion: "",
                });
                toast.success("Oferta agregada");
            } else {
                toast.error(data.message || "Error al agregar oferta");
            }
        } catch (err) {
            console.error("Error:", err);
            toast.error("Error de conexión");
        }
    };

    const handleEliminarOferta = async (ofertaId) => {
        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch(baseUrl(`/api/ofertas/${ofertaId}`), {
                method: "DELETE",
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                },
            });

            const data = await response.json();

            if (data.success) {
                setOfertas(ofertas.filter((o) => o.id !== ofertaId));
                toast.success("Oferta eliminada");
            } else {
                toast.error(data.message || "Error al eliminar oferta");
            }
        } catch (err) {
            console.error("Error:", err);
            toast.error("Error de conexión");
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setErrors({});

        try {
            const token = localStorage.getItem("auth_token");
            const empresaActiva = JSON.parse(localStorage.getItem("empresa_activa") || "{}");
            const url = isEditing
                ? baseUrl(`/api/productos/${producto.id_producto}`)
                : baseUrl("/api/productos");

            const formDataToSend = new FormData();

            formDataToSend.append("nombre", formData.nombre);
            formDataToSend.append("codigo", isAutoCode ? "" : formData.codigo);
            formDataToSend.append("descripcion", formData.detalle);
            formDataToSend.append("precio", formData.precio);
            formDataToSend.append("costo", formData.costo);
            formDataToSend.append("cantidad", formData.cantidad);
            formDataToSend.append("almacen", formData.almacen);
            formDataToSend.append("moneda", formData.moneda);
            formDataToSend.append("codsunat", formData.codsunat);
            formDataToSend.append("iscbp", formData.iscbp);
            formDataToSend.append("precio_mayor", formData.precio_mayor);
            formDataToSend.append("precio_menor", formData.precio_menor);
            formDataToSend.append("usar_multiprecio", formData.usar_multiprecio);

            if (formData.categoria_id) {
                formDataToSend.append("categoria_id", formData.categoria_id);
            }
            if (formData.marca_id) {
                formDataToSend.append("marca_id", formData.marca_id);
            }
            if (formData.unidad_id) {
                formDataToSend.append("unidad_id", formData.unidad_id);
            }

            if (formData.imagen) {
                formDataToSend.append("imagen", formData.imagen);
            }

            if (!isEditing && replicarHijos && esPrincipal) {
                formDataToSend.append("replicar_hijos", "true");
            }

            if (isEditing) {
                formDataToSend.append("_method", "PUT");
            }

            const response = await fetch(url, {
                method: "POST",
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                    ...(empresaActiva.id_empresa && { 'X-Empresa-Activa': empresaActiva.id_empresa }),
                },
                body: formDataToSend,
            });

            const data = await response.json();

            if (data.success) {
                onClose();
                onSuccess?.(data.data);

                setTimeout(() => {
                    toast.success(
                        isEditing
                            ? "Producto actualizado exitosamente"
                            : "Producto creado exitosamente",
                    );
                }, 300);
            } else {
                if (data.errors) {
                    setErrors(data.errors);
                    toast.error("Por favor corrige los errores en el formulario");
                } else {
                    toast.error(data.message || "Error al guardar producto");
                }
            }
        } catch (err) {
            console.error("Error:", err);
            toast.error("Error de conexión al servidor");
        } finally {
            setLoading(false);
        }
    };

    const simboloMoneda = formData.moneda === "USD" ? "$" : "S/";

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            title={isEditing ? "Editar Producto" : "Nuevo Producto"}
            size="xl"
            footer={
                <>
                    <Button
                        variant="outline"
                        onClick={onClose}
                        disabled={loading}
                    >
                        Cancelar
                    </Button>
                    <Button
                        onClick={handleSubmit}
                        disabled={loading}
                        className="gap-2"
                    >
                        {loading && (
                            <Loader2 className="h-4 w-4 animate-spin" />
                        )}
                        {isEditing ? "Actualizar" : "Guardar"}
                    </Button>
                </>
            }
        >
            {/* Tabs */}
            <div className="flex gap-2 border-b mb-4 px-6 pt-4">
                <button
                    onClick={() => setActiveTab("general")}
                    className={`px-4 py-2 font-medium text-sm transition-colors ${
                        activeTab === "general"
                            ? "border-b-2 border-primary-600 text-primary-600"
                            : "text-gray-600 hover:text-gray-900"
                    }`}
                >
                    General
                </button>
                {isEditing && (
                    <button
                        onClick={() => setActiveTab("ofertas")}
                        className={`px-4 py-2 font-medium text-sm transition-colors ${
                            activeTab === "ofertas"
                                ? "border-b-2 border-primary-600 text-primary-600"
                                : "text-gray-600 hover:text-gray-900"
                        }`}
                    >
                        Ofertas
                    </button>
                )}
            </div>

            <ModalForm
                onSubmit={handleSubmit}
                className="max-h-[75vh] overflow-y-auto px-6"
            >
                {/* TAB: GENERAL */}
                {activeTab === "general" && (
                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 pb-4">
                        {/* COLUMNA 1 */}
                        <div className="space-y-4">
                            <ModalField
                                label="Cod. Producto:"
                                required={!isAutoCode}
                                error={!isAutoCode ? errors.codigo?.[0] : null}
                            >
                                <div className="space-y-2">
                                    <Input
                                        variant="outlined"
                                        name="codigo"
                                        value={isAutoCode ? "" : formData.codigo}
                                        onChange={handleChange}
                                        placeholder={isAutoCode ? "Generado automáticamente" : "Código"}
                                        required={!isAutoCode}
                                        disabled={isAutoCode}
                                        className={isAutoCode ? "bg-gray-100 text-gray-500 italic" : ""}
                                    />
                                    <label className="flex items-center gap-1.5 text-[11px] font-medium text-gray-500 cursor-pointer pl-1">
                                        <input
                                            type="checkbox"
                                            checked={isAutoCode}
                                            onChange={(e) => setIsAutoCode(e.target.checked)}
                                            className="rounded border-gray-300 text-primary-600 focus:ring-primary-500 h-3.5 w-3.5"
                                        />
                                        Automático
                                    </label>
                                </div>
                            </ModalField>

                            <ModalField label="Producto:" required error={errors.nombre?.[0]}>
                                <Input
                                    variant="outlined"
                                    name="nombre"
                                    value={formData.nombre}
                                    onChange={handleChange}
                                    placeholder="Nombre del producto"
                                    required
                                />
                            </ModalField>

                            <ModalField label="Descripción (opcional)" error={errors.detalle?.[0]}>
                                <textarea
                                    name="detalle"
                                    value={formData.detalle}
                                    onChange={handleChange}
                                    placeholder="Descripción detallada"
                                    className="w-full px-3 py-2 border border-gray-200 rounded-lg focus:outline-none focus:ring-1 focus:ring-primary-500 focus:border-primary-500 text-sm hover:border-gray-300 transition-colors"
                                    rows="3"
                                />
                            </ModalField>

                            <div className="grid grid-cols-3 gap-4">
                                <ModalField label="Categoría" required error={errors.categoria_id?.[0]}>
                                    <div className="flex gap-2">
                                        <Select
                                            key={`cat-${categorias.length}-${formData.categoria_id}`}
                                            value={formData.categoria_id ? String(formData.categoria_id) : undefined}
                                            onValueChange={(value) =>
                                                setFormData((prev) => ({ ...prev, categoria_id: value }))
                                            }
                                        >
                                            <SelectTrigger className="flex-1">
                                                <SelectValue placeholder="Seleccione" />
                 
                                            </SelectTrigger>
                                            <SelectContent>
                                                {categorias.map((cat) => (
                                                    <SelectItem key={cat.id} value={cat.id.toString()}>
                                                        {cat.nombre}
                                                    </SelectItem>
                                                ))}
                                            </SelectContent>
                                        </Select>
                                        <Button
                                            type="button"
                                            variant="outline"
                                            size="icon"
                                            onClick={() => setShowCategoriaModal(true)}
                                            className="shrink-0"
                                            title="Nueva categoría"
                                        >
                                            <Plus className="h-4 w-4" />
                                        </Button>
                                    </div>
                                </ModalField>

                                <ModalField label="Marca" error={errors.marca_id?.[0]}>
                                    <div className="flex gap-2">
                                        <Select
                                            key={`marca-${marcas.length}-${formData.marca_id}`}
                                            value={formData.marca_id || "sin-marca"}
                                            onValueChange={(value) =>
                                                setFormData((prev) => ({
                                                    ...prev,
                                                    marca_id: value === "sin-marca" ? "" : value,
                                                }))
                                            }
                                        >
                                            <SelectTrigger className="flex-1">
                                                <SelectValue placeholder="Seleccione" />
                                            </SelectTrigger>
                                            <SelectContent>
                                                <SelectItem value="sin-marca">Sin marca</SelectItem>
                                                {marcas.map((marca) => (
                                                    <SelectItem key={marca.cod_marca} value={marca.cod_marca}>
                                                        {marca.nombre_marca}
                                                    </SelectItem>
                                                ))}
                                            </SelectContent>
                                        </Select>
                                        <Button
                                            type="button"
                                            variant="outline"
                                            size="icon"
                                            onClick={() => setShowMarcaModal(true)}
                                            className="shrink-0"
                                            title="Nueva marca"
                                        >
                                            <Plus className="h-4 w-4" />
                                        </Button>
                                    </div>
                                </ModalField>

                                <ModalField label="Unidad de Medida" required error={errors.unidad_id?.[0]}>
                                    <div className="flex gap-2">
                                        <Select
                                            key={`uni-${unidades.length}-${formData.unidad_id}`}
                                            value={formData.unidad_id ? String(formData.unidad_id) : undefined}
                                            onValueChange={(value) =>
                                                setFormData((prev) => ({ ...prev, unidad_id: value }))
                                            }
                                        >
                                            <SelectTrigger className="flex-1">
                                                <SelectValue placeholder="Seleccione" />
                                            </SelectTrigger>
                                            <SelectContent>
                                                {unidades.map((unidad) => (
                                                    <SelectItem key={unidad.id} value={unidad.id.toString()}>
                                                        {unidad.nombre}
                                                    </SelectItem>
                                                ))}
                                            </SelectContent>
                                        </Select>
                                        <Button
                                            type="button"
                                            variant="outline"
                                            size="icon"
                                            onClick={() => setShowUnidadModal(true)}
                                            className="shrink-0"
                                            title="Nueva unidad"
                                        >
                                            <Plus className="h-4 w-4" />
                                        </Button>
                                    </div>
                                </ModalField>
                            </div>

                            <ModalField label="Imagen del Producto" error={errors.imagen?.[0]}>
                                <div className="space-y-3">
                                    <input
                                        type="file"
                                        onChange={handleImageChange}
                                        className="w-full px-2 py-1.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-1 focus:ring-primary-500 focus:border-primary-500 text-xs file:mr-2 file:py-1 file:px-3 file:rounded file:border-0 file:text-xs file:bg-gray-100 file:text-gray-700 hover:file:bg-primary-100 hover:file:text-primary-700 transition-colors cursor-pointer"
                                        accept="image/png, image/jpeg"
                                    />
                                    {imagePreview ? (
                                        <div className="flex justify-center p-2 border border-dashed rounded-lg bg-gray-50/50">
                                            <img
                                                src={imagePreview}
                                                alt="Vista previa"
                                                className="max-h-32 object-contain rounded-md shadow-sm"
                                            />
                                        </div>
                                    ) : (
                                        <div className="flex flex-col items-center justify-center p-4 border border-dashed rounded-lg bg-gray-50/50 text-gray-400">
                                            <ImageIcon className="h-8 w-8 mb-1 opacity-20" />
                                            <span className="text-[10px]">Sin imagen seleccionada</span>
                                        </div>
                                    )}
                                </div>
                            </ModalField>

                            {!isEditing && esPrincipal && tieneHijos && (
                                <label className="flex items-start gap-2.5 cursor-pointer p-3 rounded-lg border border-blue-100 bg-blue-50/50 hover:bg-blue-50 transition-colors">
                                    <input
                                        type="checkbox"
                                        checked={replicarHijos}
                                        onChange={(e) => setReplicarHijos(e.target.checked)}
                                        className="mt-0.5 rounded border-gray-300 text-primary-600 focus:ring-primary-500 h-4 w-4"
                                    />
                                    <div>
                                        <span className="text-sm font-medium text-gray-700 block">Replicar a almacenes hijos</span>
                                        <span className="text-xs text-gray-500">Crea este producto en todos los almacenes hijos (si no existe)</span>
                                    </div>
                                </label>
                            )}
                        </div>

                        {/* COLUMNA 2 */}
                        <div className="space-y-4">
                            <div className="grid grid-cols-2 gap-4">
                                <ModalField label={`Precio (${simboloMoneda})`} required error={errors.precio?.[0]}>
                                    <Input
                                        variant="outlined"
                                        type="number"
                                        step="0.01"
                                        name="precio"
                                        value={formData.precio}
                                        onChange={handleChange}
                                        placeholder="0.00"
                                        required
                                    />
                                </ModalField>

                                <ModalField label={`Costo (${simboloMoneda})`} required error={errors.costo?.[0]}>
                                    <Input
                                        variant="outlined"
                                        type="number"
                                        step="0.01"
                                        name="costo"
                                        value={formData.costo}
                                        onChange={handleChange}
                                        placeholder="0.00"
                                        required
                                    />
                                </ModalField>
                            </div>

                            <div className="grid grid-cols-2 gap-4">
                                <ModalField label="Stock Inicial" required error={errors.cantidad?.[0]}>
                                    <Input
                                        variant="outlined"
                                        type="number"
                                        name="cantidad"
                                        value={formData.cantidad}
                                        onChange={handleChange}
                                        placeholder="0"
                                        required
                                    />
                                </ModalField>

                                <ModalField label="Moneda" required error={errors.moneda?.[0]}>
                                    <Select
                                        value={formData.moneda}
                                        onValueChange={(value) =>
                                            setFormData((prev) => ({ ...prev, moneda: value }))
                                        }
                                    >
                                        <SelectTrigger>
                                            <SelectValue placeholder="Seleccione" />
                                        </SelectTrigger>
                                        <SelectContent>
                                            <SelectItem value="PEN">Soles (S/)</SelectItem>
                                            <SelectItem value="USD">Dólares ($)</SelectItem>
                                        </SelectContent>
                                    </Select>
                                </ModalField>
                            </div>

                            <div className="pt-2">
                                <details className="group border rounded-lg bg-gray-50/30 overflow-hidden">
                                    <summary className="cursor-pointer text-xs font-semibold text-gray-700 hover:text-primary-600 transition-colors p-3 bg-gray-50 select-none">
                                        + Precios adicionales (opcional)
                                    </summary>
                                    <div className="grid grid-cols-2 gap-4 p-4 animate-in fade-in slide-in-from-top-1">
                                        <ModalField label={`Precio Distribuidor (${simboloMoneda})`} error={errors.precio_mayor?.[0]}>
                                            <Input
                                                variant="outlined"
                                                type="number"
                                                step="0.01"
                                                name="precio_mayor"
                                                value={formData.precio_mayor}
                                                onChange={handleChange}
                                                placeholder="0.00"
                                            />
                                        </ModalField>

                                        <ModalField label={`Precio Mayorista (${simboloMoneda})`} error={errors.precio_menor?.[0]}>
                                            <Input
                                                variant="outlined"
                                                type="number"
                                                step="0.01"
                                                name="precio_menor"
                                                value={formData.precio_menor}
                                                onChange={handleChange}
                                                placeholder="0.00"
                                            />
                                        </ModalField>
                                    </div>
                                </details>
                            </div>
                        </div>
                    </div>
                )}

                {/* TAB: OFERTAS */}
                {activeTab === "ofertas" && isEditing && (
                    <div className="space-y-4 pb-4">
                        <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
                            <h3 className="font-semibold text-sm text-blue-900 mb-4">Agregar Nueva Oferta</h3>
                            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <ModalField label="Tipo de Descuento" required>
                                    <Select value={ofertaForm.tipo} onValueChange={(value) => setOfertaForm((prev) => ({ ...prev, tipo: value }))}>
                                        <SelectTrigger>
                                            <SelectValue placeholder="Seleccione" />
                                        </SelectTrigger>
                                        <SelectContent>
                                            <SelectItem value="porcentaje">Porcentaje (%)</SelectItem>
                                            <SelectItem value="monto">Monto (S/)</SelectItem>
                                        </SelectContent>
                                    </Select>
                                </ModalField>

                                <ModalField label={ofertaForm.tipo === "porcentaje" ? "Descuento (%)" : "Descuento (S/)"} required>
                                    <Input
                                        variant="outlined"
                                        type="number"
                                        step="0.01"
                                        name="valor"
                                        value={ofertaForm.valor}
                                        onChange={handleOfertaChange}
                                        placeholder="0.00"
                                    />
                                </ModalField>

                                <ModalField label="Fecha Inicio" required>
                                    <Input
                                        variant="outlined"
                                        type="date"
                                        name="fecha_inicio"
                                        value={ofertaForm.fecha_inicio}
                                        onChange={handleOfertaChange}
                                    />
                                </ModalField>

                                <ModalField label="Fecha Fin (opcional)">
                                    <Input
                                        variant="outlined"
                                        type="date"
                                        name="fecha_fin"
                                        value={ofertaForm.fecha_fin}
                                        onChange={handleOfertaChange}
                                    />
                                </ModalField>

                                <ModalField label="Descripción (opcional)" className="md:col-span-2">
                                    <textarea
                                        name="descripcion"
                                        value={ofertaForm.descripcion}
                                        onChange={handleOfertaChange}
                                        placeholder="Ej: Oferta especial de verano"
                                        className="w-full px-3 py-2 border border-gray-200 rounded-lg focus:outline-none focus:ring-1 focus:ring-primary-500 focus:border-primary-500 text-sm hover:border-gray-300 transition-colors"
                                        rows="2"
                                    />
                                </ModalField>
                            </div>

                            <Button
                                type="button"
                                onClick={handleAgregarOferta}
                                className="mt-4 w-full"
                            >
                                <Plus className="h-4 w-4 mr-2" />
                                Agregar Oferta
                            </Button>
                        </div>

                        {ofertas.length > 0 && (
                            <div className="space-y-2">
                                <h3 className="font-semibold text-sm text-gray-900">Ofertas Activas</h3>
                                {ofertas.map((oferta) => (
                                    <div key={oferta.id} className="flex items-center justify-between p-3 border rounded-lg bg-gray-50 hover:bg-gray-100 transition-colors">
                                        <div className="flex-1">
                                            <p className="text-sm font-medium text-gray-900">
                                                {oferta.tipo === "porcentaje" ? `${oferta.valor}%` : `S/ ${oferta.valor}`}
                                            </p>
                                            <p className="text-xs text-gray-500">{oferta.descripcion || "Sin descripción"}</p>
                                            <p className="text-xs text-gray-400">
                                                {new Date(oferta.fecha_inicio).toLocaleDateString()} 
                                                {oferta.fecha_fin ? ` - ${new Date(oferta.fecha_fin).toLocaleDateString()}` : " - Sin fecha fin"}
                                            </p>
                                        </div>
                                        <Button
                                            type="button"
                                            variant="ghost"
                                            size="icon"
                                            onClick={() => handleEliminarOferta(oferta.id)}
                                            className="text-red-600 hover:text-red-700 hover:bg-red-50"
                                        >
                                            <Trash2 className="h-4 w-4" />
                                        </Button>
                                    </div>
                                ))}
                            </div>
                        )}

                        {ofertas.length === 0 && (
                            <div className="text-center py-8 text-gray-500">
                                <p className="text-sm">No hay ofertas creadas aún</p>
                            </div>
                        )}
                    </div>
                )}
            </ModalForm>

            {/* Modales rápidos */}
            <CategoriaQuickModal
                isOpen={showCategoriaModal}
                onClose={() => setShowCategoriaModal(false)}
                onSuccess={(nuevaCategoria) => {
                    fetchCategorias();
                    setFormData((prev) => ({
                        ...prev,
                        categoria_id: nuevaCategoria.id.toString(),
                    }));
                }}
            />

            <UnidadQuickModal
                isOpen={showUnidadModal}
                onClose={() => setShowUnidadModal(false)}
                onSuccess={(nuevaUnidad) => {
                    fetchUnidades();
                    setFormData((prev) => ({
                        ...prev,
                        unidad_id: nuevaUnidad.id.toString(),
                    }));
                }}
            />

            <MarcaQuickModal
                isOpen={showMarcaModal}
                onClose={() => setShowMarcaModal(false)}
                onSuccess={() => {
                    fetchMarcas();
                }}
            />
        </Modal>
    );
}
