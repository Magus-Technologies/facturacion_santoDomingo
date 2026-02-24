import {
    Eye,
    Trash2,
    Printer,
    FileBadge,
    CheckCircle,
    XCircle,
    Clock,
    MoreHorizontal,
    FileCode,
    Send,
    Truck,
} from "lucide-react";
import { useState, useRef, useEffect, useCallback } from "react";
import { createPortal } from "react-dom";
import { Button } from "../../../ui/button";
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuTrigger,
} from "../../../ui/dropdown-menu";
import {
    formatMonto,
    getEstadoBadge,
    getSunatBadge,
} from "../utils/ventaHelpers";

/**
 * Componente para mostrar el documento con opciones de impresión
 */
const DocumentCell = ({ venta }) => {
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
        const url =
            formato === "a4"
                ? `/reporteNV/a4.php?id=${venta.id_venta}`
                : `/reporteNV/ticket.php?id=${venta.id_venta}`;
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
                    {venta.tipo_documento?.abreviatura || "DOC"} {venta.serie}-
                    {String(venta.numero).padStart(6, "0")}
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
 * Definición de columnas para la tabla de ventas
 * @param {Object} handlers - Objeto con funciones: { handleView, handlePrint, handleAnular }
 * @param {boolean} ocultarSunat - Si es true, oculta la columna de estado SUNAT (para notas de venta)
 */
export const getVentasColumns = (handlers, ocultarSunat = false) => {
    const columnas = [
        {
            accessorKey: "serie",
            header: "Documento",
            cell: ({ row }) => <DocumentCell venta={row.original} />,
        },
        {
            accessorKey: "fecha_emision",
            header: "Fecha V.",
            cell: ({ row }) => {
                const fecha = row.getValue("fecha_emision");
                if (!fecha) return "-";
                const dateObj = new Date(fecha);
                return (
                    <span className="text-sm text-gray-600">
                        {dateObj.toLocaleDateString("es-PE", {
                            day: "2-digit",
                            month: "2-digit",
                            year: "numeric",
                        })}
                    </span>
                );
            },
        },
        {
            accessorKey: "cliente",
            header: "Cliente",
            cell: ({ row }) => {
                const cliente = row.getValue("cliente");
                return (
                    <div>
                        <p className="text-xs text-gray-500">
                            {cliente?.documento || "N/A"}
                        </p>
                        <p className="font-medium text-gray-900 text-sm">
                            {cliente?.datos || "Sin datos"}
                        </p>
                    </div>
                );
            },
        },
        {
            accessorKey: "subtotal",
            header: "Sub. Total",
            cell: ({ row }) => (
                <span className="text-sm text-gray-600">
                    {formatMonto(
                        row.getValue("subtotal"),
                        row.original.tipo_moneda,
                    )}
                </span>
            ),
        },
        {
            accessorKey: "igv",
            header: "IGV",
            cell: ({ row }) => (
                <span className="text-sm text-gray-600">
                    {formatMonto(row.getValue("igv"), row.original.tipo_moneda)}
                </span>
            ),
        },
        {
            accessorKey: "total",
            header: "Total",
            cell: ({ row }) => (
                <span className="text-sm font-semibold text-gray-900">
                    {formatMonto(
                        row.getValue("total"),
                        row.original.tipo_moneda,
                    )}
                </span>
            ),
        },
        ...(!ocultarSunat
            ? [
                  {
                      accessorKey: "estado_sunat",
                      header: "Sunat",
                      cell: ({ row }) => {
                          const badge = getSunatBadge(
                              row.getValue("estado_sunat"),
                          );
                          const iconos = {
                              Enviado: <CheckCircle className="h-3 w-3" />,
                              Pendiente: <Clock className="h-3 w-3" />,
                          };
                          return (
                              <span
                                  className={`inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium ${badge.color}`}
                              >
                                  {iconos[badge.text]}
                                  {badge.text}
                              </span>
                          );
                      },
                  },
              ]
            : []),
        {
            accessorKey: "estado",
            header: "Estado",
            cell: ({ row }) => {
                const badge = getEstadoBadge(row.getValue("estado"));
                const iconos = {
                    Activa: <CheckCircle className="h-3 w-3" />,
                    Anulada: <XCircle className="h-3 w-3" />,
                    Pendiente: <Clock className="h-3 w-3" />,
                };
                return (
                    <span
                        className={`inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium ${badge.color}`}
                    >
                        {iconos[badge.text]}
                        {badge.text}
                    </span>
                );
            },
        },
        {
            id: "actions",
            header: () => <span className="hidden md:inline">Acciones</span>,
            cell: ({ row }) => {
                const venta = row.original;
                const estaAnulada =
                    venta.estado === "2" || venta.estado === "A";

                return (
                    <div className="flex items-center gap-1 justify-end md:justify-start">
                        {/* Escritorio */}
                        <div className="hidden md:flex items-center gap-1">
                            <Button
                                variant="ghost"
                                size="sm"
                                onClick={(e) => {
                                    e.stopPropagation();
                                    handlers.handleView(venta);
                                }}
                                title="Ver detalle"
                            >
                                <Eye className="h-4 w-4 text-blue-600" />
                            </Button>
                            <Button
                                variant="ghost"
                                size="sm"
                                onClick={(e) => {
                                    e.stopPropagation();
                                    handlers.handlePrint(venta);
                                }}
                                title="Imprimir PDF"
                            >
                                <Printer className="h-4 w-4 text-gray-600" />
                            </Button>
                            {!estaAnulada && !ocultarSunat && handlers.handleGenerarYEnviar && (
                                <Button
                                    variant="ghost"
                                    size="sm"
                                    onClick={(e) => {
                                        e.stopPropagation();
                                        handlers.handleGenerarYEnviar(venta);
                                    }}
                                    title="Generar XML y enviar a SUNAT"
                                    className="text-orange-600 hover:text-orange-700 hover:bg-orange-50"
                                >
                                    <Send className="h-4 w-4" />
                                </Button>
                            )}
                            {!ocultarSunat && venta.estado_sunat === "1" && handlers.handleVerXml && (
                                <Button
                                    variant="ghost"
                                    size="sm"
                                    onClick={(e) => {
                                        e.stopPropagation();
                                        handlers.handleVerXml(venta);
                                    }}
                                    title="Ver XML"
                                    className="text-emerald-600 hover:text-emerald-700 hover:bg-emerald-50"
                                >
                                    <FileCode className="h-4 w-4" />
                                </Button>
                            )}
                            {!estaAnulada && !ocultarSunat && handlers.handleGenerarGuia && (
                                <Button
                                    variant="ghost"
                                    size="sm"
                                    onClick={(e) => {
                                        e.stopPropagation();
                                        handlers.handleGenerarGuia(venta);
                                    }}
                                    title="Generar Guía de Remisión"
                                    className="text-purple-600 hover:text-purple-700 hover:bg-purple-50"
                                >
                                    <Truck className="h-4 w-4" />
                                </Button>
                            )}
                            {!estaAnulada && (
                                <Button
                                    variant="ghost"
                                    size="sm"
                                    onClick={(e) => {
                                        e.stopPropagation();
                                        handlers.handleAnular(venta);
                                    }}
                                    title="Anular venta"
                                    className="text-red-600 hover:text-red-700 hover:bg-red-50"
                                >
                                    <Trash2 className="h-4 w-4" />
                                </Button>
                            )}
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
                                            handlers.handleView(venta);
                                        }}
                                    >
                                        <Eye className="mr-2 h-4 w-4 text-blue-600" />
                                        Ver detalle
                                    </DropdownMenuItem>
                                    <DropdownMenuItem
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handlers.handlePrint(venta);
                                        }}
                                    >
                                        <Printer className="mr-2 h-4 w-4 text-gray-600" />
                                        Imprimir PDF
                                    </DropdownMenuItem>
                                    {!estaAnulada && !ocultarSunat && handlers.handleGenerarYEnviar && (
                                        <DropdownMenuItem
                                            onClick={(e) => {
                                                e.stopPropagation();
                                                handlers.handleGenerarYEnviar(venta);
                                            }}
                                            className="text-orange-600 focus:bg-orange-50 focus:text-orange-700"
                                        >
                                            <Send className="mr-2 h-4 w-4" />
                                            Enviar a SUNAT
                                        </DropdownMenuItem>
                                    )}
                                    {!ocultarSunat && venta.estado_sunat === "1" && handlers.handleVerXml && (
                                        <DropdownMenuItem
                                            onClick={(e) => {
                                                e.stopPropagation();
                                                handlers.handleVerXml(venta);
                                            }}
                                            className="text-emerald-600 focus:bg-emerald-50 focus:text-emerald-700"
                                        >
                                            <FileCode className="mr-2 h-4 w-4" />
                                            Ver XML
                                        </DropdownMenuItem>
                                    )}
                                    {!estaAnulada && !ocultarSunat && handlers.handleGenerarGuia && (
                                        <DropdownMenuItem
                                            onClick={(e) => {
                                                e.stopPropagation();
                                                handlers.handleGenerarGuia(venta);
                                            }}
                                            className="text-purple-600 focus:bg-purple-50 focus:text-purple-700"
                                        >
                                            <Truck className="mr-2 h-4 w-4" />
                                            Guía de Remisión
                                        </DropdownMenuItem>
                                    )}
                                    {!estaAnulada && (
                                        <DropdownMenuItem
                                            onClick={(e) => {
                                                e.stopPropagation();
                                                handlers.handleAnular(venta);
                                            }}
                                            className="text-red-600 focus:bg-red-50 focus:text-red-700"
                                        >
                                            <Trash2 className="mr-2 h-4 w-4" />
                                            Anular venta
                                        </DropdownMenuItem>
                                    )}
                                </DropdownMenuContent>
                            </DropdownMenu>
                        </div>
                    </div>
                );
            },
        },
    ];

    return columnas;
};
