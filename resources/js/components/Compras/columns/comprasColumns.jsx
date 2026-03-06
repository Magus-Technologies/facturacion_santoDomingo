import {
    Eye,
    Edit,
    Trash2,
    Printer,
    FileBadge,
    MoreHorizontal,
} from "lucide-react";
import { useState, useRef, useEffect, useCallback } from "react";
import { createPortal } from "react-dom";
import { Button } from "../../ui/button";
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuTrigger,
} from "../../ui/dropdown-menu";
import {
    formatDocumentoCompra,
    formatMonto,
    getTipoPagoLabel,
    getTipoPagoColor,
    getEstadoLabel,
    getEstadoColor,
} from "../utils/compraHelpers";
import { PermissionGuard } from "@/components/auth/PermissionGuard";
import { baseUrl } from "@/lib/baseUrl";

/**
 * Componente para mostrar el documento con opciones de impresión
 */
const DocumentCell = ({ compra }) => {
    const [isOpen, setIsOpen] = useState(false);
    const triggerRef = useRef(null);
    const dropdownRef = useRef(null);
    const [pos, setPos] = useState({ top: 0, left: 0 });

    const updatePosition = useCallback(() => {
        if (triggerRef.current) {
            const rect = triggerRef.current.getBoundingClientRect();
            setPos({ top: rect.bottom + 4, left: rect.left });
        }
    }, []);

    useEffect(() => {
        const handleClickOutside = (event) => {
            if (
                triggerRef.current &&
                !triggerRef.current.contains(event.target) &&
                dropdownRef.current &&
                !dropdownRef.current.contains(event.target)
            ) {
                setIsOpen(false);
            }
        };
        document.addEventListener("mousedown", handleClickOutside);
        return () =>
            document.removeEventListener("mousedown", handleClickOutside);
    }, []);

    const handleToggle = () => {
        if (!isOpen) updatePosition();
        setIsOpen(!isOpen);
    };

    const handlePrint = (formato) => {
        const token = localStorage.getItem("auth_token");
        const url =
            formato === "a4"
                ? baseUrl(`/reporteOC/a4.php?id=${compra.id_compra}&token=${token}`)
                : baseUrl(`/reporteOC/ticket.php?id=${compra.id_compra}&token=${token}`);
        window.open(url, "_blank");
        setIsOpen(false);
    };

    return (
        <div ref={triggerRef}>
            <div
                className="flex items-center gap-2 cursor-pointer group"
                onClick={handleToggle}
            >
                <div className="p-1.5 rounded-md text-primary-600 group-hover:bg-primary-50 transition-colors">
                    <FileBadge className="h-4 w-4" />
                </div>
                <span className="font-mono text-sm font-medium text-gray-600 group-hover:text-primary-600 transition-all italic underline underline-offset-4 decoration-primary-200/50">
                    {formatDocumentoCompra(compra)}
                </span>
            </div>

            {isOpen && createPortal(
                <div
                    ref={dropdownRef}
                    className="fixed w-48 bg-white rounded-xl shadow-xl border border-gray-100 py-2 z-[9999] animate-in fade-in zoom-in duration-200 origin-top-left"
                    style={{ top: pos.top, left: pos.left }}
                >
                    <div className="px-3 py-1.5 text-[10px] uppercase tracking-wider font-bold text-gray-400">
                        Opciones de Impresión
                    </div>
                    <button
                        className="w-full flex items-center gap-3 px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-50 hover:text-primary-600 transition-all group/item text-left"
                        onClick={() => handlePrint("a4")}
                    >
                        <div className="w-8 h-8 rounded-lg bg-red-50 text-red-600 flex items-center justify-center group-hover/item:scale-110 transition-transform">
                            <span className="font-bold text-[10px]">A4</span>
                        </div>
                        <div>
                            <div className="font-medium">Formato A4</div>
                            <div className="text-[10px] text-gray-400">
                                Documento estándar
                            </div>
                        </div>
                    </button>
                    <button
                        className="w-full flex items-center gap-3 px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-50 hover:text-primary-600 transition-all group/item text-left"
                        onClick={() => handlePrint("ticket")}
                    >
                        <div className="w-8 h-8 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center group-hover/item:scale-110 transition-transform">
                            <Printer className="h-4 w-4" />
                        </div>
                        <div>
                            <div className="font-medium">Formato Voucher</div>
                            <div className="text-[10px] text-gray-400">
                                Ticket de 80mm
                            </div>
                        </div>
                    </button>
                </div>,
                document.body
            )}
        </div>
    );
};

/**
 * Definición de columnas para la tabla de compras
 * @param {Object} handlers - Objeto con funciones: { handleAnular }
 */
export const getComprasColumns = (handlers) => [
    {
        accessorKey: "documento",
        header: "Documento",
        cell: ({ row }) => <DocumentCell compra={row.original} />,
    },
    {
        accessorKey: "fecha_emision",
        header: "F. Emisión",
        cell: ({ row }) => {
            const f = row.original.fecha_emision;
            if (!f) return "-";
            const [y, m, d] = f.split("-");
            return <span className="text-sm">{`${d}/${m}/${y}`}</span>;
        },
    },
    {
        accessorKey: "fecha_vencimiento",
        header: "F. Vencimiento",
        cell: ({ row }) => {
            const f = row.original.fecha_vencimiento;
            if (!f) return <span className="text-sm">-</span>;
            const [y, m, d] = f.split("-");
            return <span className="text-sm">{`${d}/${m}/${y}`}</span>;
        },
    },
    {
        accessorKey: "proveedor.razon_social",
        header: "Proveedor",
        cell: ({ row }) => (
            <div>
                <div className="font-medium text-sm">
                    {row.original.proveedor.razon_social}
                </div>
                <div className="text-xs text-gray-500">
                    RUC: {row.original.proveedor.ruc}
                </div>
            </div>
        ),
    },
    {
        accessorKey: "tipo_pago",
        header: "Tipo Pago",
        cell: ({ row }) => {
            const label = getTipoPagoLabel(row.original.id_tipo_pago);
            const color = getTipoPagoColor(row.original.id_tipo_pago);
            return (
                <span
                    className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${color}`}
                >
                    {label}
                </span>
            );
        },
    },
    {
        accessorKey: "total",
        header: "Total",
        cell: ({ row }) => (
            <span className="font-semibold text-sm">
                {formatMonto(row.original.total, row.original.moneda)}
            </span>
        ),
    },
    {
        accessorKey: "estado",
        header: "Estado",
        cell: ({ row }) => {
            const label = getEstadoLabel(row.original.estado);
            const color = getEstadoColor(row.original.estado);
            return (
                <span
                    className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${color}`}
                >
                    {label}
                </span>
            );
        },
    },
    {
        accessorKey: "usuario",
        header: "Usuario",
        cell: ({ row }) => (
            <span className="text-sm text-gray-600">
                {row.original.usuario}
            </span>
        ),
    },
    {
        id: "acciones",
        header: "",
        size: 50,
        cell: ({ row }) => {
            const compra = row.original;
            return (
                <div className="flex justify-end">
                    <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                            <Button variant="ghost" className="h-8 w-8 p-0">
                                <MoreHorizontal className="h-4 w-4" />
                            </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end" className="w-52">
                            <DropdownMenuItem onClick={() => handlers.handleView(compra.id_compra)}>
                                <Eye className="mr-2 h-4 w-4 text-blue-600" />
                                Ver detalle
                            </DropdownMenuItem>
                            <DropdownMenuItem onClick={() => { const token = localStorage.getItem("auth_token"); window.open(baseUrl(`/reporteOC/a4.php?id=${compra.id_compra}&token=${token}`), "_blank"); }}>
                                <Printer className="mr-2 h-4 w-4 text-gray-600" />
                                Imprimir A4
                            </DropdownMenuItem>
                            {compra.estado === "1" && (
                                <>
                                    <PermissionGuard permission="compras.edit">
                                        <DropdownMenuItem onClick={() => (window.location.href = baseUrl(`/compras/editar/${compra.id_compra}`))}>
                                            <Edit className="mr-2 h-4 w-4 text-yellow-600" />
                                            Editar
                                        </DropdownMenuItem>
                                    </PermissionGuard>
                                    <PermissionGuard permission="compras.delete">
                                        <DropdownMenuItem
                                            onClick={() => handlers.handleAnular(compra.id_compra)}
                                            className="text-red-600 focus:bg-red-50 focus:text-red-700"
                                        >
                                            <Trash2 className="mr-2 h-4 w-4" />
                                            Anular
                                        </DropdownMenuItem>
                                    </PermissionGuard>
                                </>
                            )}
                        </DropdownMenuContent>
                    </DropdownMenu>
                </div>
            );
        },
    },
];
