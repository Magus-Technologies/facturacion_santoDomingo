import {
    FileBadge,
    CheckCircle,
    Clock,
    XCircle,
    Send,
    Eye,
    FileCode,
    Printer,
    MoreHorizontal,
    Loader2,
    Search,
} from "lucide-react";
import { Button } from "../../ui/button";
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuTrigger,
} from "../../ui/dropdown-menu";

const estadoBadge = {
    pendiente: { color: "bg-amber-100 text-amber-700", text: "Pendiente" },
    enviado: { color: "bg-blue-100 text-blue-700", text: "Enviado" },
    aceptado: { color: "bg-green-100 text-green-700", text: "Aceptado" },
    rechazado: { color: "bg-red-100 text-red-700", text: "Rechazado" },
};

const estadoIconos = {
    Pendiente: <Clock className="h-3 w-3" />,
    Enviado: <Send className="h-3 w-3" />,
    Aceptado: <CheckCircle className="h-3 w-3" />,
    Rechazado: <XCircle className="h-3 w-3" />,
};

export const getGuiaRemisionColumns = (handlers, enviandoId = null) => [
    {
        accessorKey: "serie",
        header: "Documento",
        cell: ({ row }) => (
            <div className="flex items-center gap-2">
                <div className="p-1.5 rounded-md text-blue-600">
                    <FileBadge className="h-4 w-4" />
                </div>
                <span className="font-mono text-sm font-medium text-gray-600">
                    {row.original.serie}-
                    {String(row.original.numero).padStart(6, "0")}
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
        accessorKey: "destinatario_nombre",
        header: "Destinatario",
        cell: ({ row }) => (
            <div>
                <p className="text-xs text-gray-500">
                    {row.original.destinatario_documento}
                </p>
                <p className="font-medium text-gray-900 text-sm">
                    {row.original.destinatario_nombre}
                </p>
            </div>
        ),
    },
    {
        accessorKey: "ruta",
        header: "Ruta",
        cell: ({ row }) => (
            <div className="max-w-[200px]">
                <p className="text-[10px] text-gray-500 truncate">
                    De: {row.original.dir_partida}
                </p>
                <p className="text-[10px] text-gray-500 truncate">
                    A: {row.original.dir_llegada}
                </p>
            </div>
        ),
    },
    {
        accessorKey: "estado",
        header: "Estado",
        cell: ({ row }) => {
            const badge = estadoBadge[row.original.estado] || estadoBadge.pendiente;
            return (
                <span
                    className={`inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium ${badge.color}`}
                >
                    {estadoIconos[badge.text]}
                    {badge.text}
                </span>
            );
        },
    },
    {
        id: "actions",
        header: () => <span className="hidden md:inline">Acciones</span>,
        cell: ({ row }) => {
            const guia = row.original;
            const puedeEnviar = guia.estado === "pendiente" && guia.nombre_xml;
            const puedeConsultar = guia.estado === "enviado" && guia.ticket_sunat;
            const isEnviando = enviandoId === guia.id;

            return (
                <div className="flex items-center gap-1 justify-end md:justify-start">
                    {isEnviando ? (
                        <div className="flex items-center gap-2 text-blue-600 px-2">
                            <Loader2 className="h-4 w-4 animate-spin" />
                            <span className="text-xs font-medium hidden md:inline">
                                Procesando...
                            </span>
                        </div>
                    ) : (
                        <>
                            {/* Escritorio */}
                            <div className="hidden md:flex items-center gap-1">
                                {handlers.handleVerPdf && (
                                    <Button
                                        variant="ghost"
                                        size="sm"
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handlers.handleVerPdf(guia);
                                        }}
                                        title="Ver PDF"
                                        className="text-gray-600 hover:text-gray-700 hover:bg-gray-50"
                                    >
                                        <Printer className="h-4 w-4" />
                                    </Button>
                                )}
                                {handlers.handleView && (
                                    <Button
                                        variant="ghost"
                                        size="sm"
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handlers.handleView(guia);
                                        }}
                                        title="Ver detalle"
                                    >
                                        <Eye className="h-4 w-4 text-blue-600" />
                                    </Button>
                                )}
                                {guia.nombre_xml && handlers.handleVerXml && (
                                    <Button
                                        variant="ghost"
                                        size="sm"
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handlers.handleVerXml(guia);
                                        }}
                                        title="Ver XML"
                                        className="text-emerald-600 hover:text-emerald-700 hover:bg-emerald-50"
                                    >
                                        <FileCode className="h-4 w-4" />
                                    </Button>
                                )}
                                {puedeEnviar && handlers.handleEnviar && (
                                    <Button
                                        variant="ghost"
                                        size="sm"
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handlers.handleEnviar(guia);
                                        }}
                                        title="Enviar a SUNAT"
                                        className="text-orange-600 hover:text-orange-700 hover:bg-orange-50"
                                    >
                                        <Send className="h-4 w-4" />
                                    </Button>
                                )}
                                {puedeConsultar && handlers.handleConsultarTicket && (
                                    <Button
                                        variant="ghost"
                                        size="sm"
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            handlers.handleConsultarTicket(guia);
                                        }}
                                        title="Consultar ticket"
                                        className="text-purple-600 hover:text-purple-700 hover:bg-purple-50"
                                    >
                                        <Search className="h-4 w-4" />
                                    </Button>
                                )}
                            </div>
                            {/* Móvil */}
                            <div className="md:hidden">
                                <DropdownMenu>
                                    <DropdownMenuTrigger asChild>
                                        <Button variant="ghost" className="h-8 w-8 p-0">
                                            <MoreHorizontal className="h-4 w-4" />
                                        </Button>
                                    </DropdownMenuTrigger>
                                    <DropdownMenuContent align="end" className="w-48">
                                        {handlers.handleVerPdf && (
                                            <DropdownMenuItem
                                                onClick={(e) => {
                                                    e.stopPropagation();
                                                    handlers.handleVerPdf(guia);
                                                }}
                                            >
                                                <Printer className="mr-2 h-4 w-4 text-gray-600" />
                                                Ver PDF
                                            </DropdownMenuItem>
                                        )}
                                        {handlers.handleView && (
                                            <DropdownMenuItem
                                                onClick={(e) => {
                                                    e.stopPropagation();
                                                    handlers.handleView(guia);
                                                }}
                                            >
                                                <Eye className="mr-2 h-4 w-4 text-blue-600" />
                                                Ver detalle
                                            </DropdownMenuItem>
                                        )}
                                        {guia.nombre_xml && handlers.handleVerXml && (
                                            <DropdownMenuItem
                                                onClick={(e) => {
                                                    e.stopPropagation();
                                                    handlers.handleVerXml(guia);
                                                }}
                                            >
                                                <FileCode className="mr-2 h-4 w-4 text-emerald-600" />
                                                Ver XML
                                            </DropdownMenuItem>
                                        )}
                                        {puedeEnviar && handlers.handleEnviar && (
                                            <DropdownMenuItem
                                                onClick={(e) => {
                                                    e.stopPropagation();
                                                    handlers.handleEnviar(guia);
                                                }}
                                            >
                                                <Send className="mr-2 h-4 w-4 text-orange-600" />
                                                Enviar a SUNAT
                                            </DropdownMenuItem>
                                        )}
                                        {puedeConsultar && handlers.handleConsultarTicket && (
                                            <DropdownMenuItem
                                                onClick={(e) => {
                                                    e.stopPropagation();
                                                    handlers.handleConsultarTicket(guia);
                                                }}
                                            >
                                                <Search className="mr-2 h-4 w-4 text-purple-600" />
                                                Consultar ticket
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
