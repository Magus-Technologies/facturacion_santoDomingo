import {
    FileBadge,
    CheckCircle,
    Clock,
    XCircle,
    Send,
    Eye,
    FileCode,
    FileDown,
    MoreHorizontal,
    Loader2,
} from "lucide-react";
import { Button } from "../../ui/button";
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuTrigger,
} from "../../ui/dropdown-menu";
import { getEstadoNotaBadge } from "@/constants/sunat";

const formatMonto = (monto, moneda) => {
    const simbolo = moneda === "USD" ? "$" : "S/";
    return `${simbolo} ${parseFloat(monto || 0).toFixed(2)}`;
};

export const getNotaCreditoColumns = (handlers, enviandoId = null) => [
    {
        accessorKey: "serie",
        header: "Documento",
        cell: ({ row }) => (
            <div className="flex flex-col">
                <div className="flex items-center gap-2">
                    <div className="p-1.5 rounded-md text-red-600">
                        <FileBadge className="h-4 w-4" />
                    </div>
                    <span className="font-mono text-sm font-medium text-gray-600">
                        {row.original.serie}-
                        {String(row.original.numero).padStart(6, "0")}
                    </span>
                </div>
                <span className="text-[10px] text-gray-400 ml-9 italic">
                    Ref: {row.original.serie_num_afectado}
                </span>
            </div>
        ),
    },
    {
        accessorKey: "fecha_emision",
        header: "Fecha",
        cell: ({ row }) => {
            const fecha = row.original.fecha_emision;
            if (!fecha) return "-";
            return (
                <span className="text-sm text-gray-600">
                    {new Date(fecha).toLocaleDateString("es-PE", {
                        day: "2-digit",
                        month: "2-digit",
                        year: "numeric",
                    })}
                </span>
            );
        },
    },
    {
        accessorKey: "venta",
        header: "Cliente",
        cell: ({ row }) => {
            const cliente = row.original.venta?.cliente;
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
        accessorKey: "motivo",
        header: "Motivo",
        cell: ({ row }) => (
            <div>
                <span className="inline-flex items-center px-2 py-0.5 rounded-md bg-gray-100 text-xs font-medium text-gray-700">
                    {row.original.motivo?.codigo_sunat}
                </span>
                <p className="text-xs text-gray-500 mt-0.5">
                    {row.original.descripcion_motivo ||
                        row.original.motivo?.descripcion}
                </p>
            </div>
        ),
    },
    {
        accessorKey: "monto_total",
        header: "Total",
        cell: ({ row }) => (
            <span className="text-sm font-semibold text-gray-900">
                {formatMonto(row.original.monto_total, row.original.moneda)}
            </span>
        ),
    },
    {
        accessorKey: "estado",
        header: "Estado",
        cell: ({ row }) => {
            const badge = getEstadoNotaBadge(row.original.estado);
            const iconos = {
                Aceptado: <CheckCircle className="h-3 w-3" />,
                Pendiente: <Clock className="h-3 w-3" />,
                Enviado: <CheckCircle className="h-3 w-3" />,
                Rechazado: <XCircle className="h-3 w-3" />,
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
            const nota = row.original;
            const puedeEnviar =
                nota.estado === "pendiente" && nota.nombre_xml;
            const isEnviando = enviandoId === nota.id;

            return (
                <div className="flex items-center gap-1 justify-end md:justify-start">
                    {/* Loader cuando se está enviando */}
                    {isEnviando ? (
                        <div className="flex items-center gap-2 text-orange-600 px-2">
                            <Loader2 className="h-4 w-4 animate-spin" />
                            <span className="text-xs font-medium hidden md:inline">Enviando...</span>
                        </div>
                    ) : (
                        <>
                            {/* Escritorio */}
                            <div className="hidden md:flex items-center gap-1">
                                {handlers.handleView && (
                                    <Button
                                        variant="ghost"
                                        size="sm"
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handlers.handleView(nota);
                                        }}
                                        title="Ver detalle"
                                    >
                                        <Eye className="h-4 w-4 text-blue-600" />
                                    </Button>
                                )}
                                {nota.nombre_xml && handlers.handleVerXml && (
                                    <Button
                                        variant="ghost"
                                        size="sm"
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handlers.handleVerXml(nota);
                                        }}
                                        title="Ver XML"
                                        className="text-emerald-600 hover:text-emerald-700 hover:bg-emerald-50"
                                    >
                                        <FileCode className="h-4 w-4" />
                                    </Button>
                                )}
                                {nota.cdr_url && handlers.handleDescargarCdr && (
                                    <Button
                                        variant="ghost"
                                        size="sm"
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handlers.handleDescargarCdr(nota);
                                        }}
                                        title="Descargar CDR"
                                        className="text-teal-600 hover:text-teal-700 hover:bg-teal-50"
                                    >
                                        <FileDown className="h-4 w-4" />
                                    </Button>
                                )}
                                {puedeEnviar && handlers.handleEnviar && (
                                    <Button
                                        variant="ghost"
                                        size="sm"
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handlers.handleEnviar(nota);
                                        }}
                                        title="Enviar a SUNAT"
                                        className="text-orange-600 hover:text-orange-700 hover:bg-orange-50"
                                    >
                                        <Send className="h-4 w-4" />
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
                                        {handlers.handleView && (
                                            <DropdownMenuItem
                                                onClick={(e) => {
                                                    e.stopPropagation();
                                                    handlers.handleView(nota);
                                                }}
                                            >
                                                <Eye className="mr-2 h-4 w-4 text-blue-600" />
                                                Ver detalle
                                            </DropdownMenuItem>
                                        )}
                                        {nota.nombre_xml && handlers.handleVerXml && (
                                            <DropdownMenuItem
                                                onClick={(e) => {
                                                    e.stopPropagation();
                                                    handlers.handleVerXml(nota);
                                                }}
                                                className="text-emerald-600 focus:bg-emerald-50 focus:text-emerald-700"
                                            >
                                                <FileCode className="mr-2 h-4 w-4" />
                                                Ver XML
                                            </DropdownMenuItem>
                                        )}
                                        {nota.cdr_url && handlers.handleDescargarCdr && (
                                            <DropdownMenuItem
                                                onClick={(e) => {
                                                    e.stopPropagation();
                                                    handlers.handleDescargarCdr(nota);
                                                }}
                                                className="text-teal-600 focus:bg-teal-50 focus:text-teal-700"
                                            >
                                                <FileDown className="mr-2 h-4 w-4" />
                                                Descargar CDR
                                            </DropdownMenuItem>
                                        )}
                                        {puedeEnviar && handlers.handleEnviar && (
                                            <DropdownMenuItem
                                                onClick={(e) => {
                                                    e.stopPropagation();
                                                    handlers.handleEnviar(nota);
                                                }}
                                                className="text-orange-600 focus:bg-orange-50 focus:text-orange-700"
                                            >
                                                <Send className="mr-2 h-4 w-4" />
                                                Enviar a SUNAT
                                            </DropdownMenuItem>
                                        )}
                                    </DropdownMenuContent>
                                </DropdownMenu>
                            </div>
                        </>
                    )}
                </div>
            );
        },
    },
];
