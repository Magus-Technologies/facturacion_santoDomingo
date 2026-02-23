import { useState, useEffect } from "react";
import { DataTable } from "@/components/ui/data-table";
import { Button } from "@/components/ui/button";
import { toast, confirmDelete } from "@/lib/sweetalert";
import ProveedorModal from "./ProveedorModal";
import ProveedorDetallesModal from "./ProveedorDetallesModal";
import {
    Eye,
    Edit,
    Trash2,
    UserPlus,
    Phone,
    MapPin,
    Building2,
    Loader2,
    FileSpreadsheet,
    FileText as FilePdf,
    MoreHorizontal,
} from "lucide-react";
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import MainLayout from "../Layout/MainLayout";

export default function ProveedoresList() {
    const [proveedores, setProveedores] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [isDetallesOpen, setIsDetallesOpen] = useState(false);
    const [selectedProveedor, setSelectedProveedor] = useState(null);
    const [viewProveedorId, setViewProveedorId] = useState(null);

    useEffect(() => {
        fetchProveedores();
    }, []);

    const fetchProveedores = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem("auth_token");

            const response = await fetch("/api/proveedores", {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                },
            });

            const data = await response.json();

            if (data.success) {
                setProveedores(data.data);
            } else {
                setError(data.message || "Error al cargar proveedores");
            }
        } catch (err) {
            setError("Error de conexión al servidor");
            console.error("Error:", err);
        } finally {
            setLoading(false);
        }
    };

    const handleExport = (tipo) => {
        const url = `/proveedores/descargar-${tipo}`;
        window.open(url, "_blank");
    };

    const handleDelete = async (proveedor) => {
        confirmDelete({
            title: "Eliminar Proveedor",
            message: `¿Estás seguro de eliminar al proveedor <strong>"${proveedor.razon_social}"</strong>?`,
            confirmText: "Sí, eliminar",
            cancelText: "Cancelar",
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem("auth_token");

                    const response = await fetch(
                        `/api/proveedores/${proveedor.proveedor_id}`,
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
                        toast.success("Proveedor eliminado exitosamente");
                        fetchProveedores();
                    } else {
                        toast.error(
                            data.message || "Error al eliminar proveedor",
                        );
                    }
                } catch (err) {
                    toast.error("Error de conexión al servidor");
                    console.error("Error:", err);
                }
            },
        });
    };

    const handleEdit = (proveedor) => {
        setSelectedProveedor(proveedor);
        setIsModalOpen(true);
    };

    const handleCreate = () => {
        setSelectedProveedor(null);
        setIsModalOpen(true);
    };

    const handleModalClose = () => {
        setIsModalOpen(false);
        setSelectedProveedor(null);
    };

    const handleModalSuccess = () => {
        fetchProveedores();
    };

    const handleView = (proveedor) => {
        setViewProveedorId(proveedor.proveedor_id);
        setIsDetallesOpen(true);
    };

    const columns = [
        {
            accessorKey: "proveedor_id",
            header: "ID",
            cell: ({ row }) => (
                <span className="font-mono text-gray-600">
                    #{row.getValue("proveedor_id")}
                </span>
            ),
        },
        {
            accessorKey: "ruc",
            header: "RUC",
            cell: ({ row }) => {
                const ruc = row.getValue("ruc");
                return (
                    <div className="flex items-center gap-2">
                        <Building2 className="h-4 w-4 text-primary-600" />
                        <span className="font-mono font-medium">{ruc}</span>
                    </div>
                );
            },
        },
        {
            accessorKey: "razon_social",
            header: "Razón Social",
            cell: ({ row }) => (
                <div>
                    <p className="font-medium text-gray-900">
                        {row.getValue("razon_social")}
                    </p>
                    {row.original.email && (
                        <p className="text-sm text-gray-500">
                            {row.original.email}
                        </p>
                    )}
                </div>
            ),
        },
        {
            accessorKey: "telefono",
            header: "Contacto",
            cell: ({ row }) => {
                const telefono = row.getValue("telefono");
                const direccion = row.original.direccion;
                return (
                    <div className="space-y-1">
                        {telefono && (
                            <div className="flex items-center gap-2 text-sm text-gray-600">
                                <Phone className="h-3 w-3 text-gray-400" />
                                <span>{telefono}</span>
                            </div>
                        )}
                        {direccion && (
                            <div className="flex items-center gap-2 text-sm text-gray-500">
                                <MapPin className="h-3 w-3 text-gray-400" />
                                <span className="truncate max-w-[200px]">
                                    {direccion}
                                </span>
                            </div>
                        )}
                    </div>
                );
            },
        },
        {
            accessorKey: "ubicacion",
            header: "Ubicación",
            cell: ({ row }) => {
                const ubicacion = [
                    row.original.distrito,
                    row.original.provincia,
                    row.original.departamento,
                ]
                    .filter(Boolean)
                    .join(", ");

                return ubicacion ? (
                    <div className="flex items-center gap-2 text-sm text-gray-600">
                        <MapPin className="h-3 w-3 text-gray-400" />
                        <span className="truncate max-w-[200px]">
                            {ubicacion}
                        </span>
                    </div>
                ) : (
                    <span className="text-gray-400 text-sm">No registrada</span>
                );
            },
        },
        {
            id: "actions",
            header: () => <span className="hidden md:inline">Acciones</span>,
            enableSorting: false,
            cell: ({ row }) => {
                const proveedor = row.original;
                return (
                    <div className="flex items-center gap-1 justify-end md:justify-start">
                        {/* PC */}
                        <div className="hidden md:flex items-center gap-1">
                            <Button
                                variant="ghost"
                                size="sm"
                                onClick={(e) => {
                                    e.stopPropagation();
                                    handleView(proveedor);
                                }}
                                title="Ver detalles"
                            >
                                <Eye className="h-4 w-4 text-primary-600" />
                            </Button>
                            <Button
                                variant="ghost"
                                size="sm"
                                onClick={(e) => {
                                    e.stopPropagation();
                                    handleEdit(proveedor);
                                }}
                                title="Editar proveedor"
                            >
                                <Edit className="h-4 w-4 text-accent-600" />
                            </Button>
                            <Button
                                variant="ghost"
                                size="sm"
                                onClick={(e) => {
                                    e.stopPropagation();
                                    handleDelete(proveedor);
                                }}
                                title="Eliminar proveedor"
                                className="text-red-600 hover:text-red-700 hover:bg-red-50"
                            >
                                <Trash2 className="h-4 w-4" />
                            </Button>
                        </div>
                        {/* Móvil */}
                        <div className="md:hidden">
                            <DropdownMenu>
                                <DropdownMenuTrigger asChild>
                                    <Button
                                        variant="ghost"
                                        className="h-8 w-8 p-0"
                                    >
                                        <span className="sr-only">
                                            Abrir menú
                                        </span>
                                        <MoreHorizontal className="h-4 w-4" />
                                    </Button>
                                </DropdownMenuTrigger>
                                <DropdownMenuContent
                                    align="end"
                                    className="w-48"
                                >
                                    <DropdownMenuItem
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handleView(proveedor);
                                        }}
                                    >
                                        <Eye className="mr-2 h-4 w-4 text-primary-600" />
                                        Ver detalles
                                    </DropdownMenuItem>
                                    <DropdownMenuItem
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handleEdit(proveedor);
                                        }}
                                    >
                                        <Edit className="mr-2 h-4 w-4 text-accent-600" />
                                        Editar proveedor
                                    </DropdownMenuItem>
                                    <DropdownMenuItem
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handleDelete(proveedor);
                                        }}
                                        className="text-red-600 focus:bg-red-50 focus:text-red-700"
                                    >
                                        <Trash2 className="mr-2 h-4 w-4" />
                                        Eliminar proveedor
                                    </DropdownMenuItem>
                                </DropdownMenuContent>
                            </DropdownMenu>
                        </div>
                    </div>
                );
            },
        },
    ];

    if (loading) {
        return (
            <MainLayout>
                <div className="flex items-center justify-center min-h-[400px]">
                    <div className="text-center">
                        <Loader2 className="h-12 w-12 animate-spin text-primary-600 mx-auto mb-4" />
                        <p className="text-gray-600">Cargando proveedores...</p>
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
                        <Button onClick={fetchProveedores} className="mt-4">
                            Reintentar
                        </Button>
                    </div>
                </div>
            </MainLayout>
        );
    }

    return (
        <MainLayout>
            <div className="space-y-6">
                <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <div>
                        <h1 className="text-2xl font-bold text-gray-900">
                            Proveedores
                        </h1>
                        <p className="text-gray-600 mt-1">
                            Gestiona tu cartera de proveedores
                        </p>
                    </div>
                    <div className="flex flex-wrap items-center gap-2">
                        <Button
                            variant="outline"
                            className="gap-2 border-green-200 text-green-700 hover:bg-green-50"
                            onClick={() => handleExport("excel")}
                        >
                            <FileSpreadsheet className="h-4 w-4" />
                            Excel
                        </Button>
                        <Button
                            variant="outline"
                            className="gap-2 border-red-200 text-red-700 hover:bg-red-50"
                            onClick={() => handleExport("pdf")}
                        >
                            <FilePdf className="h-4 w-4" />
                            PDF
                        </Button>
                        <Button onClick={handleCreate} className="gap-2">
                            <UserPlus className="h-5 w-5" />
                            Nuevo Proveedor
                        </Button>
                    </div>
                </div>

                <DataTable
                    columns={columns}
                    data={proveedores}
                    searchable={true}
                    searchPlaceholder="Buscar por RUC, razón social, email..."
                    pagination={true}
                    pageSize={10}
                />

                {/* Modal de Crear/Editar Proveedor */}
                <ProveedorModal
                    isOpen={isModalOpen}
                    onClose={handleModalClose}
                    proveedor={selectedProveedor}
                    onSuccess={handleModalSuccess}
                />

                {/* Modal de Detalles del Proveedor */}
                <ProveedorDetallesModal
                    isOpen={isDetallesOpen}
                    onClose={() => setIsDetallesOpen(false)}
                    proveedorId={viewProveedorId}
                />
            </div>
        </MainLayout>
    );
}
