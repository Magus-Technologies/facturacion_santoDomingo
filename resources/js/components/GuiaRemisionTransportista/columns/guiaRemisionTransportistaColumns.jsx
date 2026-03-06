import {
    FileBadge,
    CheckCircle,
    Clock,
    XCircle,
    Send,
    Eye,
    FileCode,
    FileDown,
    Printer,
    MoreHorizontal,
    Loader2,
    Search,
} from 'lucide-react';
import { Button } from '@/components/ui/button';
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';

const estadoBadge = {
    pendiente: { color: 'bg-amber-100 text-amber-700', text: 'Pendiente' },
    enviado:   { color: 'bg-blue-100 text-blue-700',   text: 'Enviado'   },
    aceptado:  { color: 'bg-green-100 text-green-700', text: 'Aceptado'  },
    rechazado: { color: 'bg-red-100 text-red-700',     text: 'Rechazado' },
};

const estadoIconos = {
    Pendiente: <Clock className="h-3 w-3" />,
    Enviado:   <Send className="h-3 w-3" />,
    Aceptado:  <CheckCircle className="h-3 w-3" />,
    Rechazado: <XCircle className="h-3 w-3" />,
};

export const getGuiaRemisionTransportistaColumns = (handlers, enviandoId = null) => [
    {
        accessorKey: 'serie',
        header: 'Documento',
        cell: ({ row }) => (
            <div className="flex items-center gap-2">
                <div className="p-1.5 rounded-md text-orange-600">
                    <FileBadge className="h-4 w-4" />
                </div>
                <span className="font-mono text-sm font-medium text-gray-600">
                    {row.original.serie}-{String(row.original.numero).padStart(6, '0')}
                </span>
            </div>
        ),
    },
    {
        accessorKey: 'fecha_emision',
        header: 'Fecha',
        cell: ({ row }) => {
            const fecha = row.original.fecha_emision;
            if (!fecha) return '-';
            return (
                <span className="text-sm text-gray-600">
                    {new Date(fecha).toLocaleDateString('es-PE', {
                        day: '2-digit', month: '2-digit', year: 'numeric',
                    })}
                </span>
            );
        },
    },
    {
        accessorKey: 'remitente_nombre',
        header: 'Remitente',
        cell: ({ row }) => (
            <div>
                <p className="text-xs text-gray-500">{row.original.remitente_documento}</p>
                <p className="font-medium text-gray-900 text-sm">{row.original.remitente_nombre || '-'}</p>
            </div>
        ),
    },
    {
        accessorKey: 'destinatario_nombre',
        header: 'Destinatario',
        cell: ({ row }) => (
            <div>
                <p className="text-xs text-gray-500">{row.original.destinatario_documento}</p>
                <p className="font-medium text-gray-900 text-sm">{row.original.destinatario_nombre}</p>
            </div>
        ),
    },
    {
        accessorKey: 'vehiculo_placa',
        header: 'Placa / Conductor',
        cell: ({ row }) => (
            <div>
                <p className="font-mono text-sm font-semibold text-gray-800">{row.original.vehiculo_placa || '-'}</p>
                {row.original.conductor_nombres && (
                    <p className="text-xs text-gray-500">
                        {row.original.conductor_nombres} {row.original.conductor_apellidos}
                    </p>
                )}
            </div>
        ),
    },
    {
        accessorKey: 'estado',
        header: 'Estado',
        cell: ({ row }) => {
            const badge = estadoBadge[row.original.estado] || estadoBadge.pendiente;
            return (
                <span className={`inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium ${badge.color}`}>
                    {estadoIconos[badge.text]}
                    {badge.text}
                </span>
            );
        },
    },
    {
        id: 'actions',
        header: '',
        size: 50,
        cell: ({ row }) => {
            const guia = row.original;
            const puedeEnviar    = guia.estado === 'pendiente' && guia.nombre_xml;
            const puedeConsultar = guia.estado === 'enviado' && guia.ticket_sunat;
            const puedeCdr       = guia.estado === 'aceptado' && guia.cdr_url;
            const isEnviando     = enviandoId === guia.id;

            if (isEnviando) {
                return (
                    <div className="flex items-center justify-end gap-2 text-orange-600 px-2">
                        <Loader2 className="h-4 w-4 animate-spin" />
                        <span className="text-xs font-medium">Procesando...</span>
                    </div>
                );
            }

            return (
                <div className="flex justify-end">
                    <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                            <Button variant="ghost" className="h-8 w-8 p-0">
                                <MoreHorizontal className="h-4 w-4" />
                            </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end" className="w-52">
                            {handlers.handleView && (
                                <DropdownMenuItem onClick={() => handlers.handleView(guia)}>
                                    <Eye className="mr-2 h-4 w-4 text-blue-600" />
                                    Ver detalle
                                </DropdownMenuItem>
                            )}
                            {handlers.handleVerPdf && (
                                <DropdownMenuItem onClick={() => handlers.handleVerPdf(guia)}>
                                    <Printer className="mr-2 h-4 w-4 text-gray-600" />
                                    Ver PDF
                                </DropdownMenuItem>
                            )}
                            {guia.nombre_xml && handlers.handleVerXml && (
                                <DropdownMenuItem onClick={() => handlers.handleVerXml(guia)}>
                                    <FileCode className="mr-2 h-4 w-4 text-emerald-600" />
                                    Ver XML
                                </DropdownMenuItem>
                            )}
                            {puedeCdr && handlers.handleDescargarCdr && (
                                <DropdownMenuItem onClick={() => handlers.handleDescargarCdr(guia)}>
                                    <FileDown className="mr-2 h-4 w-4 text-green-600" />
                                    Descargar CDR
                                </DropdownMenuItem>
                            )}
                            {puedeEnviar && handlers.handleEnviar && (
                                <DropdownMenuItem
                                    onClick={() => handlers.handleEnviar(guia)}
                                    className="text-orange-600 focus:bg-orange-50 focus:text-orange-700"
                                >
                                    <Send className="mr-2 h-4 w-4" />
                                    Enviar a SUNAT
                                </DropdownMenuItem>
                            )}
                            {puedeConsultar && handlers.handleConsultarTicket && (
                                <DropdownMenuItem
                                    onClick={() => handlers.handleConsultarTicket(guia)}
                                    className="text-purple-600 focus:bg-purple-50 focus:text-purple-700"
                                >
                                    <Search className="mr-2 h-4 w-4" />
                                    Consultar ticket
                                </DropdownMenuItem>
                            )}
                        </DropdownMenuContent>
                    </DropdownMenu>
                </div>
            );
        },
    },
];
