import { useState, useEffect } from "react";
import { DataTable } from "@/components/ui/data-table";
import { Button } from "@/components/ui/button";
import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from "@/components/ui/select";
import { toast, confirmDelete } from "@/lib/sweetalert";
import { baseUrl } from "@/lib/baseUrl";
import ProductoModal from "./ProductoModal";
import ProductosActionButtons from "./ProductosActionButtons";
import {
    Edit,
    Trash2,
    Package,
    Loader2,
    Tag,
    Image as ImageIcon,
    MoreHorizontal,
    Zap,
    Gavel,
} from "lucide-react";
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import MainLayout from "../Layout/MainLayout";
import { PermissionGuard } from "@/components/auth/PermissionGuard";

export default function ProductosList() {
    const [productos, setProductos] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [selectedProducto, setSelectedProducto] = useState(null);
    const [busqueda, setBusqueda] = useState("");
    const [filtroStock, setFiltroStock] = useState("todos");
    const [remateModalOpen, setRemateModalOpen] = useState(false);
    const [productoRemate, setProductoRemate] = useState(null);
    const [precioRemateInput, setPrecioRemateInput] = useState("");
    const [savingRemate, setSavingRemate] = useState(false);

    // Almacenes dinámicos
    const [almacenes, setAlmacenes] = useState([]);
    const [almacenActivo, setAlmacenActivo] = useState(null);
    const [loadingAlmacenes, setLoadingAlmacenes] = useState(true);

    useEffect(() => {
        fetchAlmacenes();
    }, []);

    useEffect(() => {
        if (almacenActivo) {
            fetchProductos();
        }
    }, [almacenActivo]);

    const fetchAlmacenes = async () => {
        try {
            setLoadingAlmacenes(true);
            const token = localStorage.getItem("auth_token");
            const response = await fetch(baseUrl("/api/almacenes"), {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                },
            });
            const data = await response.json();
            if (data.success && data.data.length > 0) {
                setAlmacenes(data.data);
                const principal = data.data.find((a) => a.es_principal);
                setAlmacenActivo(String(principal?.id || data.data[0].id));
            }
        } catch (err) {
            console.error("Error al cargar almacenes:", err);
        } finally {
            setLoadingAlmacenes(false);
        }
    };

    const fetchProductos = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem("auth_token");

            const response = await fetch(
                baseUrl(`/api/productos?almacen=${almacenActivo}`),
                {
                    headers: {
                        Authorization: `Bearer ${token}`,
                        Accept: "application/json",
                    },
                },
            );

            const data = await response.json();

            if (data.success) {
                setProductos(data.data);
            } else {
                setError(data.message || "Error al cargar productos");
            }
        } catch (err) {
            setError("Error de conexión al servidor");
            console.error("Error:", err);
        } finally {
            setLoading(false);
        }
    };

    const handleDelete = async (producto) => {
        confirmDelete({
            title: "Eliminar Producto",
            message: `¿Estás seguro de eliminar el producto <strong>"${producto.nombre}"</strong>?`,
            confirmText: "Sí, eliminar",
            cancelText: "Cancelar",
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem("auth_token");
                    const response = await fetch(
                        baseUrl(`/api/productos/${producto.id_producto}`),
                        {
                            method: "DELETE",
                            headers: {
                                Authorization: `Bearer ${token}`,
                                Accept: "application/json",
                            },
                        },
                    );
                    const data = await response.json();
                    if (data.success) {
                        toast.success("Producto eliminado exitosamente");
                        fetchProductos();
                    } else {
                        toast.error(data.message || "Error al eliminar producto");
                    }
                } catch (err) {
                    toast.error("Error de conexión al servidor");
                }
            },
        });
    };

    const handleEdit = (producto) => {
        setSelectedProducto(producto);
        setIsModalOpen(true);
    };

    const handleCreate = () => {
        setSelectedProducto(null);
        setIsModalOpen(true);
    };

    const handleModalClose = () => {
        setIsModalOpen(false);
        setSelectedProducto(null);
    };

    const handlePonerEnRemate = (producto) => {
        setProductoRemate(producto);
        setPrecioRemateInput(parseFloat(producto?.costo || 0).toFixed(2));
        setRemateModalOpen(true);
    };

    const handleConfirmarRemate = async () => {
        if (!productoRemate) return;
        setSavingRemate(true);
        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch(baseUrl("/api/productos-en-remate"), {
                method: "POST",
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    producto_id: productoRemate.id_producto,
                    precio_remate: parseFloat(precioRemateInput) || null,
                }),
            });
            const data = await response.json();
            if (data.success) {
                toast.success("Producto agregado a remate exitosamente");
                setRemateModalOpen(false);
                setProductoRemate(null);
                setPrecioRemateInput("");
            } else {
                toast.error(data.message || "Error al poner en remate");
            }
        } catch {
            toast.error("Error de conexión al servidor");
        } finally {
            setSavingRemate(false);
        }
    };

    const handleModalSuccess = (productoActualizado) => {
        if (productoActualizado) {
            if (selectedProducto) {
                setProductos((prev) =>
                    prev.map((p) =>
                        p.id_producto === productoActualizado.id_producto
                            ? productoActualizado
                            : p,
                    ),
                );
            } else {
                setProductos((prev) => [productoActualizado, ...prev]);
            }
        } else {
            fetchProductos();
        }
    };

    const almacenInfo = almacenes.find((a) => String(a.id) === almacenActivo);
    const esPrincipal = almacenInfo?.es_principal || false;

    const columns = [
        {
            id: "imagen",
            header: "Imagen",
            cell: ({ row }) => (
                <div className="flex items-center justify-center">
                    {row.original.imagen ? (
                        <img 
                            src={baseUrl(`/storage/${row.original.imagen}`)} 
                            alt={row.original.nombre} 
                            className="h-10 w-10 object-contain rounded-md border border-gray-200"
                        />
                    ) : (
                        <div className="h-10 w-10 bg-gray-100 rounded-md flex items-center justify-center">
                            <ImageIcon className="h-5 w-5 text-gray-400" />
                        </div>
                    )}
                </div>
            ),
        },
        {
            accessorKey: "codigo",
            header: "Código",
            cell: ({ row }) => (
                <div className="flex items-center gap-2">
                    <Tag className="h-4 w-4 text-primary-600" />
                    <span className="font-mono font-medium text-sm">
                        {row.getValue("codigo") || "N/A"}
                    </span>
                </div>
            ),
        },
        {
            accessorKey: "nombre",
            header: "Producto",
            cell: ({ row }) => (
                <div>
                    <p className="font-medium text-gray-900">{row.getValue("nombre")}</p>
                    {row.original.categoria?.nombre && (
                        <p className="text-xs text-gray-500">{row.original.categoria.nombre}</p>
                    )}
                </div>
            ),
        },
        {
            id: "unidad",
            header: "Unidad",
            cell: ({ row }) => (
                <span className="text-sm text-gray-600">{row.original.unidad?.nombre || "N/A"}</span>
            ),
        },
        {
            id: "categoria",
            header: "Categoría",
            cell: ({ row }) => (
                <span className="text-sm text-gray-600">{row.original.categoria?.nombre || "N/A"}</span>
            ),
        },
        {
            id: "marca",
            header: "Marca",
            cell: ({ row }) => {
                const marca = row.original.marca;
                const nombreMarca = marca?.nombre_marca || marca?.nombre || "N/A";
                return <span className="text-sm text-gray-600">{nombreMarca}</span>;
            },
        },
        {
            id: "ofertas",
            header: "Ofertas",
            cell: ({ row }) => {
                const ofertasVigentes = row.original.ofertas?.filter(o => o.estado === '1') || [];
                return (
                    <div className="flex items-center gap-1">
                        {ofertasVigentes.length > 0 ? (
                            <>
                                <Zap className="h-4 w-4 text-yellow-500" />
                                <span className="text-sm font-semibold text-yellow-600">{ofertasVigentes.length}</span>
                            </>
                        ) : (
                            <>
                                <Zap className="h-4 w-4 text-gray-300" />
                                <span className="text-sm text-gray-400">0</span>
                            </>
                        )}
                    </div>
                );
            },
        },
        {
            accessorKey: "cantidad",
            header: "Stock",
            cell: ({ row }) => {
                const cantidad = parseInt(row.getValue("cantidad") || 0);
                const stockMinimo = parseInt(row.original.stock_minimo || 0);
                let colorClass = "text-green-700 bg-green-50";
                if (cantidad === 0) colorClass = "text-red-700 bg-red-50";
                else if (cantidad <= stockMinimo) colorClass = "text-yellow-700 bg-yellow-50";
                return (
                    <span className={`px-2 py-1 rounded-md font-semibold text-sm ${colorClass}`}>
                        {cantidad}
                    </span>
                );
            },
        },
        {
            accessorKey: "precio",
            header: "Precio",
            cell: ({ row }) => {
                const precio = parseFloat(row.original.precio || 0);
                const moneda = row.original.moneda === "USD" ? "$" : "S/";
                return <span className="font-semibold text-gray-900">{moneda} {precio.toFixed(2)}</span>;
            },
        },
        {
            accessorKey: "costo",
            header: "Costo",
            cell: ({ row }) => {
                const costo = parseFloat(row.getValue("costo") || 0);
                const moneda = row.original.moneda === "USD" ? "$" : "S/";
                return <span className="text-sm text-gray-600">{moneda} {costo.toFixed(2)}</span>;
            },
        },
        {
            id: "actions",
            header: () => <span className="hidden md:inline">Acciones</span>,
            enableSorting: false,
            cell: ({ row }) => {
                const producto = row.original;
                return (
                    <div className="flex items-center gap-1 justify-end md:justify-start">
                        <div className="hidden md:flex items-center gap-1">
                            <PermissionGuard permission="productos.edit">
                                <Button variant="ghost" size="sm" onClick={(e) => { e.stopPropagation(); handleEdit(producto); }} title="Editar producto">
                                    <Edit className="h-4 w-4 text-accent-600" />
                                </Button>
                            </PermissionGuard>
                            <PermissionGuard permission="productos.edit">
                                <Button variant="ghost" size="sm" onClick={(e) => { e.stopPropagation(); handlePonerEnRemate(producto); }} title="Poner en remate" className="text-orange-600 hover:text-orange-700 hover:bg-orange-50">
                                    <Gavel className="h-4 w-4" />
                                </Button>
                            </PermissionGuard>
                            <PermissionGuard permission="productos.delete">
                                <Button variant="ghost" size="sm" onClick={(e) => { e.stopPropagation(); handleDelete(producto); }} title="Eliminar producto" className="text-red-600 hover:text-red-700 hover:bg-red-50">
                                    <Trash2 className="h-4 w-4" />
                                </Button>
                            </PermissionGuard>
                        </div>
                        <div className="md:hidden">
                            <DropdownMenu>
                                <DropdownMenuTrigger asChild>
                                    <Button variant="ghost" className="h-8 w-8 p-0">
                                        <MoreHorizontal className="h-4 w-4" />
                                    </Button>
                                </DropdownMenuTrigger>
                                <DropdownMenuContent align="end" className="w-48">
                                    <PermissionGuard permission="productos.edit">
                                        <DropdownMenuItem onClick={(e) => { e.stopPropagation(); handleEdit(producto); }}>
                                            <Edit className="mr-2 h-4 w-4 text-accent-600" />
                                            Editar producto
                                        </DropdownMenuItem>
                                    </PermissionGuard>
                                    <PermissionGuard permission="productos.edit">
                                        <DropdownMenuItem onClick={(e) => { e.stopPropagation(); handlePonerEnRemate(producto); }} className="text-orange-600 focus:bg-orange-50 focus:text-orange-700">
                                            <Gavel className="mr-2 h-4 w-4" />
                                            Poner en remate
                                        </DropdownMenuItem>
                                    </PermissionGuard>
                                    <PermissionGuard permission="productos.delete">
                                        <DropdownMenuItem onClick={(e) => { e.stopPropagation(); handleDelete(producto); }} className="text-red-600 focus:bg-red-50 focus:text-red-700">
                                            <Trash2 className="mr-2 h-4 w-4" />
                                            Eliminar producto
                                        </DropdownMenuItem>
                                    </PermissionGuard>
                                </DropdownMenuContent>
                            </DropdownMenu>
                        </div>
                    </div>
                );
            },
        },
    ];

    if (loadingAlmacenes || (loading && !productos.length)) {
        return (
            <MainLayout>
                <div className="flex items-center justify-center min-h-[400px]">
                    <div className="text-center">
                        <Loader2 className="h-12 w-12 animate-spin text-primary-600 mx-auto mb-4" />
                        <p className="text-gray-600">Cargando...</p>
                    </div>
                </div>
            </MainLayout>
        );
    }

    if (error) {
        return (
            <MainLayout>
                <div className="flex items-center justify-center min-h-[400px]">
                    <div className="text-center">
                        <div className="bg-red-100 text-red-700 px-6 py-4 rounded-lg">
                            <p className="font-semibold">Error</p>
                            <p className="text-sm mt-1">{error}</p>
                        </div>
                        <Button onClick={fetchProductos} className="mt-4">Reintentar</Button>
                    </div>
                </div>
            </MainLayout>
        );
    }

    const productosFiltrados = productos.filter((p) => {
        const cantidad = parseFloat(p.cantidad ?? 0);
        const stockMin = parseFloat(p.stock_minimo ?? 0);
        if (filtroStock === "con_stock") return cantidad > 0;
        if (filtroStock === "sin_stock") return cantidad <= 0;
        if (filtroStock === "stock_bajo") return cantidad > 0 && cantidad <= stockMin;
        return true;
    });

    const conteos = {
        todos: productos.length,
        con_stock: productos.filter((p) => parseFloat(p.cantidad ?? 0) > 0).length,
        sin_stock: productos.filter((p) => parseFloat(p.cantidad ?? 0) <= 0).length,
        stock_bajo: productos.filter((p) => {
            const c = parseFloat(p.cantidad ?? 0);
            return c > 0 && c <= parseFloat(p.stock_minimo ?? 0);
        }).length,
    };

    return (
        <MainLayout>
            <div className="space-y-6">
                {/* Header con selector de almacén */}
                <div className="flex items-center justify-between flex-wrap gap-4">
                    <div>
                        <h1 className="text-2xl font-bold text-gray-900">
                            Productos{almacenInfo ? ` - ${almacenInfo.nombre}` : ""}
                        </h1>
                        <p className="text-gray-600 mt-1">Gestiona tu inventario de productos</p>
                    </div>

                    {almacenes.length > 0 && (
                        <div className="flex items-center gap-2">
                            <Package className="h-4 w-4 text-gray-500" />
                            <Select value={almacenActivo} onValueChange={setAlmacenActivo}>
                                <SelectTrigger className="w-[200px]">
                                    <SelectValue placeholder="Seleccionar almacén" />
                                </SelectTrigger>
                                <SelectContent>
                                    {almacenes.map((alm) => (
                                        <SelectItem key={alm.id} value={String(alm.id)}>
                                            {alm.nombre}{alm.es_principal ? " (Principal)" : ""}
                                        </SelectItem>
                                    ))}
                                </SelectContent>
                            </Select>
                        </div>
                    )}
                </div>

                <ProductosActionButtons
                    onNuevoProducto={handleCreate}
                    onRefresh={fetchProductos}
                    almacenActivo={almacenActivo}
                    almacenNombre={almacenInfo?.nombre || ""}
                    busqueda={busqueda}
                    esPrincipal={esPrincipal}
                    almacenes={almacenes}
                    onAlmacenesChange={fetchAlmacenes}
                />

                {/* Filtros de stock */}
                <div className="flex flex-wrap gap-2">
                    {[
                        { key: "todos", label: "Todos", color: "bg-gray-100 text-gray-700 hover:bg-gray-200", activeColor: "bg-gray-500 text-white" },
                        { key: "con_stock", label: "Con stock", color: "bg-green-50 text-green-700 hover:bg-green-100", activeColor: "bg-green-600 text-white" },
                        { key: "sin_stock", label: "Sin stock", color: "bg-red-50 text-red-700 hover:bg-red-100", activeColor: "bg-red-600 text-white" },
                        { key: "stock_bajo", label: "Stock bajo", color: "bg-yellow-50 text-yellow-700 hover:bg-yellow-100", activeColor: "bg-yellow-500 text-white" },
                    ].map(({ key, label, color, activeColor }) => (
                        <button
                            key={key}
                            onClick={() => setFiltroStock(key)}
                            className={`px-3 py-1.5 rounded-full text-sm font-medium transition-colors ${filtroStock === key ? activeColor : color}`}
                        >
                            {label}
                            <span className={`ml-1.5 text-xs px-1.5 py-0.5 rounded-full ${filtroStock === key ? "bg-white/20" : "bg-black/10"}`}>
                                {conteos[key]}
                            </span>
                        </button>
                    ))}
                </div>

                <DataTable
                    columns={columns}
                    data={productosFiltrados}
                    searchable={true}
                    searchPlaceholder="Buscar por código, nombre, código de barras..."
                    pagination={true}
                    pageSize={10}
                    gridView={true}
                    onSearchChange={setBusqueda}
                    renderGridCard={(producto) => (
                        <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden hover:shadow-lg hover:border-primary-600 transition-all duration-300 group h-full flex flex-col">
                            <div className="relative h-48 bg-gray-50 flex items-center justify-center overflow-hidden shrink-0">
                                {producto.imagen ? (
                                    <img src={baseUrl(`/storage/${producto.imagen}`)} alt={producto.nombre} className="w-full h-full object-contain group-hover:scale-105 transition-transform duration-300" />
                                ) : (
                                    <div className="flex flex-col items-center justify-center text-gray-400">
                                        <ImageIcon className="h-16 w-16 mb-2 opacity-50" />
                                        <span className="text-sm">Sin imagen</span>
                                    </div>
                                )}
                            </div>
                            <div className="p-4 flex flex-col flex-1">
                                <div className="flex items-center gap-2 mb-2">
                                    <Tag className="h-3.5 w-3.5 text-primary-600 shrink-0" />
                                    <span className="text-sm font-mono text-gray-600 truncate">{producto.codigo || "N/A"}</span>
                                </div>
                                <h3 className="font-semibold text-gray-900 mb-1 line-clamp-2 h-12 overflow-hidden">{producto.nombre}</h3>
                                <div className="h-5 mb-3">
                                    {producto.categoria?.nombre && <p className="text-xs text-gray-500 truncate">{producto.categoria.nombre}</p>}
                                </div>
                                <div className="flex items-center justify-between mb-3">
                                    <span className="text-xs bg-gray-100 text-gray-700 px-2 py-1 rounded-md font-medium">{producto.unidad?.nombre || "N/A"}</span>
                                    <span className={`text-sm font-semibold px-2 py-1 rounded-md ${parseInt(producto.cantidad || 0) === 0 ? "text-red-700 bg-red-50" : parseInt(producto.cantidad || 0) <= parseInt(producto.stock_minimo || 0) ? "text-yellow-700 bg-yellow-50" : "text-green-700 bg-green-50"}`}>
                                        Stock: {producto.cantidad || 0}
                                    </span>
                                </div>
                                <div className="text-xl font-bold text-primary-600 mb-4">
                                    {producto.moneda === "USD" ? "$" : "S/"} {parseFloat(producto.precio || 0).toFixed(2)}
                                </div>
                                <div className="flex gap-2 mt-auto">
                                    <PermissionGuard permission="productos.edit">
                                        <Button variant="default" size="sm" onClick={() => handleEdit(producto)} className="flex-1 gap-2">
                                            <Edit className="h-4 w-4" />Editar
                                        </Button>
                                    </PermissionGuard>
                                    <PermissionGuard permission="productos.delete">
                                        <Button variant="outline" size="sm" onClick={() => handleDelete(producto)} className="text-red-600 hover:text-red-700 hover:bg-red-50 border-red-200">
                                            <Trash2 className="h-4 w-4" />
                                        </Button>
                                    </PermissionGuard>
                                </div>
                            </div>
                        </div>
                    )}
                />

                <ProductoModal
                    isOpen={isModalOpen}
                    onClose={handleModalClose}
                    producto={selectedProducto}
                    almacen={almacenActivo}
                    esPrincipal={esPrincipal}
                    almacenes={almacenes}
                    onSuccess={handleModalSuccess}
                />

                {/* Modal: Poner en Remate */}
                {remateModalOpen && (
                    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50">
                        <div className="bg-white rounded-xl shadow-xl p-6 w-full max-w-sm mx-4">
                            <div className="flex items-center gap-3 mb-4">
                                <div className="bg-orange-100 p-2 rounded-full">
                                    <Gavel className="h-5 w-5 text-orange-600" />
                                </div>
                                <h2 className="text-lg font-semibold text-gray-900">Poner en Remate</h2>
                            </div>
                            <p className="text-gray-600 text-sm mb-1">¿Deseas agregar este producto a la lista de remate?</p>
                            <p className="font-semibold text-gray-900 mb-1">{productoRemate?.nombre}</p>
                            <div className="flex gap-4 text-xs text-gray-500 mb-4">
                                <span>Precio: <strong>{productoRemate?.moneda === "USD" ? "$" : "S/"} {parseFloat(productoRemate?.precio || 0).toFixed(2)}</strong></span>
                                <span>Costo: <strong>{productoRemate?.moneda === "USD" ? "$" : "S/"} {parseFloat(productoRemate?.costo || 0).toFixed(2)}</strong></span>
                            </div>
                            <div className="mb-4">
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                    Precio de Remate ({productoRemate?.moneda === "USD" ? "USD" : "S/"})
                                </label>
                                <input
                                    type="number"
                                    min="0"
                                    step="0.01"
                                    value={precioRemateInput}
                                    onChange={(e) => setPrecioRemateInput(e.target.value)}
                                    className="w-full border border-gray-300 rounded-md px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-orange-400"
                                    placeholder="Ej: 18.00"
                                />
                                <p className="text-xs text-orange-600 mt-1">Se recomienda igual o menor al costo.</p>
                            </div>
                            <div className="flex gap-3 justify-end">
                                <Button variant="outline" onClick={() => { setRemateModalOpen(false); setProductoRemate(null); setPrecioRemateInput(""); }} disabled={savingRemate}>
                                    Cancelar
                                </Button>
                                <Button onClick={handleConfirmarRemate} disabled={savingRemate} className="bg-orange-600 hover:bg-orange-700 text-white gap-2">
                                    {savingRemate ? <Loader2 className="h-4 w-4 animate-spin" /> : <Gavel className="h-4 w-4" />}
                                    Confirmar
                                </Button>
                            </div>
                        </div>
                    </div>
                )}
            </div>
        </MainLayout>
    );
}
