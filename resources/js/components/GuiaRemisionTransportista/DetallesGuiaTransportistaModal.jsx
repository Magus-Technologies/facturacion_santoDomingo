import { Modal } from '@/components/ui/modal';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent } from '@/components/ui/card';
import { DataTable } from '@/components/ui/data-table';
import {
    FileText, User, Calendar, Truck, MapPin, ArrowRight,
    Package, Printer, FileDown, CheckCircle2, XCircle,
    Clock, Send, Shield, UserCheck,
} from 'lucide-react';
import { Button } from '@/components/ui/button';
import { baseUrl } from '@/lib/baseUrl';

const estadoConfig = {
    pendiente: { text: 'Pendiente', variant: 'secondary',    icon: <Clock className="h-3 w-3" /> },
    enviado:   { text: 'Enviado',   variant: 'default',      icon: <Send className="h-3 w-3" /> },
    aceptado:  { text: 'Aceptado',  variant: 'success',      icon: <CheckCircle2 className="h-3 w-3" /> },
    rechazado: { text: 'Rechazado', variant: 'destructive',  icon: <XCircle className="h-3 w-3" /> },
};

const detalleColumns = [
    {
        accessorKey: 'item',
        header: '#',
        cell: ({ row }) => <span className="text-gray-400 font-medium">{row.index + 1}</span>,
    },
    {
        accessorKey: 'codigo',
        header: 'Código',
        cell: ({ row }) => (
            <span className="font-mono text-xs text-gray-600">{row.original.codigo || '---'}</span>
        ),
    },
    {
        accessorKey: 'descripcion',
        header: 'Descripción',
        cell: ({ row }) => (
            <span className="font-medium text-gray-900 text-sm">{row.original.descripcion}</span>
        ),
    },
    {
        accessorKey: 'cantidad',
        header: 'Cantidad',
        cell: ({ row }) => (
            <span className="font-semibold text-gray-700">
                {Number(row.original.cantidad).toLocaleString()}
            </span>
        ),
    },
    {
        accessorKey: 'unidad',
        header: 'Unidad',
        cell: ({ row }) => (
            <span className="text-xs text-gray-500">{row.original.unidad || 'NIU'}</span>
        ),
    },
];

export default function DetallesGuiaTransportistaModal({ guia, isOpen, onClose, onDescargarCdr }) {
    if (!guia) return null;

    const estado   = estadoConfig[guia.estado] || estadoConfig.pendiente;
    const documento = `${guia.serie}-${String(guia.numero).padStart(6, '0')}`;

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            title={
                <div className="flex items-center gap-2">
                    <FileText className="h-5 w-5 text-primary-600" />
                    <span>Detalle — Guía de Remisión Transportista</span>
                </div>
            }
            size="lg"
            closeOnOverlayClick={true}
            footer={
                <div className="flex w-full items-center justify-between">
                    <div className="flex gap-2">
                        <Button
                            variant="outline"
                            size="sm"
                            className="gap-2"
                            onClick={() => window.open(baseUrl(`/reporteGR/a4.php?id=${guia.id}`), '_blank')}
                        >
                            <Printer className="h-4 w-4" />
                            Ver PDF
                        </Button>
                        {guia.estado === 'aceptado' && guia.cdr_url && (
                            <Button
                                variant="outline"
                                size="sm"
                                className="gap-2 text-green-600 hover:text-green-700"
                                onClick={() => onDescargarCdr?.(guia)}
                            >
                                <FileDown className="h-4 w-4" />
                                Descargar CDR
                            </Button>
                        )}
                    </div>
                    <Button onClick={onClose} variant="secondary" size="sm">
                        Cerrar
                    </Button>
                </div>
            }
        >
            <div className="space-y-6">
                {/* Cabecera */}
                <div className="flex flex-wrap items-center justify-between gap-4 pb-4 border-b border-gray-100">
                    <div>
                        <h3 className="text-lg font-bold text-gray-900">{documento}</h3>
                        <p className="text-sm text-gray-500">Guía de Remisión Transportista · Serie V001</p>
                    </div>
                    <Badge
                        variant={estado.variant}
                        className="flex items-center gap-1 px-3 py-1 rounded-full font-medium"
                    >
                        {estado.icon}
                        {estado.text}
                    </Badge>
                </div>

                {/* Cards info */}
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <Card className="border-none shadow-sm bg-gray-50/50">
                        <CardContent className="p-4 flex items-center gap-4">
                            <div className="h-10 w-10 rounded-xl bg-orange-50 flex items-center justify-center text-orange-600">
                                <User className="h-5 w-5" />
                            </div>
                            <div className="overflow-hidden">
                                <p className="text-[10px] font-bold text-gray-400 uppercase tracking-wider">Remitente</p>
                                <p className="font-semibold text-gray-900 truncate text-sm">{guia.remitente_nombre || '-'}</p>
                                <p className="text-[10px] text-gray-500 font-mono">{guia.remitente_documento}</p>
                            </div>
                        </CardContent>
                    </Card>

                    <Card className="border-none shadow-sm bg-gray-50/50">
                        <CardContent className="p-4 flex items-center gap-4">
                            <div className="h-10 w-10 rounded-xl bg-blue-50 flex items-center justify-center text-blue-600">
                                <User className="h-5 w-5" />
                            </div>
                            <div className="overflow-hidden">
                                <p className="text-[10px] font-bold text-gray-400 uppercase tracking-wider">Destinatario</p>
                                <p className="font-semibold text-gray-900 truncate text-sm">{guia.destinatario_nombre}</p>
                                <p className="text-[10px] text-gray-500 font-mono">{guia.destinatario_documento}</p>
                            </div>
                        </CardContent>
                    </Card>

                    <Card className="border-none shadow-sm bg-gray-50/50">
                        <CardContent className="p-4 flex items-center gap-4">
                            <div className="h-10 w-10 rounded-xl bg-purple-50 flex items-center justify-center text-purple-600">
                                <Calendar className="h-5 w-5" />
                            </div>
                            <div>
                                <p className="text-[10px] font-bold text-gray-400 uppercase tracking-wider">Fechas</p>
                                <p className="font-semibold text-gray-900 text-sm">
                                    Emisión: {guia.fecha_emision ? new Date(guia.fecha_emision).toLocaleDateString('es-PE') : '-'}
                                </p>
                                <p className="text-xs text-gray-500">
                                    Traslado: {guia.fecha_traslado ? new Date(guia.fecha_traslado).toLocaleDateString('es-PE') : '-'}
                                </p>
                            </div>
                        </CardContent>
                    </Card>
                </div>

                {/* Ruta */}
                <Card className="border-none shadow-sm bg-gray-50/50">
                    <CardContent className="p-4">
                        <h4 className="text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-3 flex items-center gap-2">
                            <MapPin className="h-3.5 w-3.5" />
                            Ruta de Traslado
                        </h4>
                        <div className="flex flex-col md:flex-row items-start md:items-center gap-3">
                            <div className="flex-1 bg-white p-3 rounded-lg border border-gray-100">
                                <p className="text-[10px] text-gray-400 font-bold uppercase">Partida</p>
                                <p className="text-sm font-medium text-gray-900">{guia.dir_partida || '-'}</p>
                                {guia.ubigeo_partida && (
                                    <p className="text-[10px] text-gray-500 font-mono">Ubigeo: {guia.ubigeo_partida}</p>
                                )}
                            </div>
                            <ArrowRight className="h-5 w-5 text-gray-400 hidden md:block flex-shrink-0" />
                            <div className="flex-1 bg-white p-3 rounded-lg border border-gray-100">
                                <p className="text-[10px] text-gray-400 font-bold uppercase">Llegada</p>
                                <p className="text-sm font-medium text-gray-900">{guia.dir_llegada || '-'}</p>
                                {guia.ubigeo_llegada && (
                                    <p className="text-[10px] text-gray-500 font-mono">Ubigeo: {guia.ubigeo_llegada}</p>
                                )}
                            </div>
                        </div>
                        <div className="mt-3 flex gap-4 text-sm text-gray-600">
                            <span>
                                <span className="font-medium">Motivo:</span> {guia.motivo_traslado}
                                {guia.descripcion_motivo && ` — ${guia.descripcion_motivo}`}
                            </span>
                            <span>
                                <span className="font-medium">Peso:</span> {guia.peso_total} {guia.und_peso_total || 'KGM'}
                            </span>
                        </div>
                    </CardContent>
                </Card>

                {/* Conductor y Vehículo */}
                <Card className="border-none shadow-sm bg-gray-50/50">
                    <CardContent className="p-4">
                        <h4 className="text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-3 flex items-center gap-2">
                            <Truck className="h-3.5 w-3.5" />
                            Conductor / Vehículo
                        </h4>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                            {guia.conductor_documento && (
                                <div className="bg-white p-3 rounded-lg border border-gray-100">
                                    <p className="text-[10px] text-gray-400 font-bold uppercase mb-1 flex items-center gap-1">
                                        <UserCheck className="h-3 w-3" /> Conductor
                                    </p>
                                    <p className="text-sm font-medium text-gray-900">
                                        {guia.conductor_nombres} {guia.conductor_apellidos}
                                    </p>
                                    <p className="text-[10px] text-gray-500">Doc: {guia.conductor_documento}</p>
                                    <p className="text-[10px] text-gray-500">Licencia: {guia.conductor_licencia || '-'}</p>
                                </div>
                            )}
                            {guia.vehiculo_placa && (
                                <div className="bg-white p-3 rounded-lg border border-gray-100">
                                    <p className="text-[10px] text-gray-400 font-bold uppercase mb-1 flex items-center gap-1">
                                        <Truck className="h-3 w-3" /> Vehículo
                                    </p>
                                    <p className="text-sm font-medium text-gray-900">
                                        Placa: <span className="font-mono">{guia.vehiculo_placa}</span>
                                    </p>
                                    {guia.vehiculo_placa_secundaria && (
                                        <p className="text-[10px] text-gray-500">
                                            Placa secundaria: <span className="font-mono">{guia.vehiculo_placa_secundaria}</span>
                                        </p>
                                    )}
                                </div>
                            )}
                        </div>
                    </CardContent>
                </Card>

                {/* Items */}
                <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
                    <div className="px-4 py-3 border-b bg-gray-50/30 flex items-center justify-between">
                        <h4 className="font-bold text-gray-900 text-sm flex items-center gap-2">
                            <Package className="h-4 w-4 text-primary-600" />
                            Mercadería
                        </h4>
                        <Badge variant="outline" className="bg-white text-[10px]">
                            {guia.detalles?.length || 0} ítems
                        </Badge>
                    </div>
                    <DataTable columns={detalleColumns} data={guia.detalles || []} pagination={false} />
                </div>

                {/* SUNAT */}
                {(guia.ticket_sunat || guia.codigo_sunat || guia.mensaje_sunat) && (
                    <Card className="border-none shadow-sm bg-gray-50/50">
                        <CardContent className="p-4">
                            <h4 className="text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-3 flex items-center gap-2">
                                <Shield className="h-3.5 w-3.5" />
                                Respuesta SUNAT
                            </h4>
                            <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                                {guia.ticket_sunat && (
                                    <div>
                                        <p className="text-[10px] text-gray-400">Ticket</p>
                                        <p className="text-sm font-mono text-gray-700">{guia.ticket_sunat}</p>
                                    </div>
                                )}
                                {guia.codigo_sunat && (
                                    <div>
                                        <p className="text-[10px] text-gray-400">Código</p>
                                        <p className="text-sm font-mono text-gray-700">{guia.codigo_sunat}</p>
                                    </div>
                                )}
                                {guia.mensaje_sunat && (
                                    <div className="md:col-span-2">
                                        <p className="text-[10px] text-gray-400">Mensaje</p>
                                        <p className="text-sm text-gray-700">{guia.mensaje_sunat}</p>
                                    </div>
                                )}
                            </div>
                        </CardContent>
                    </Card>
                )}
            </div>
        </Modal>
    );
}
