import { useState } from 'react';
import { DataTable } from '@/components/ui/data-table';
import { Loader2, Plus, FileSpreadsheet } from 'lucide-react';
import { Button } from '@/components/ui/button';
import MainLayout from '@/components/Layout/MainLayout';
import { useGuiasRemisionTransportista } from './hooks/useGuiasRemisionTransportista';
import { getGuiaRemisionTransportistaColumns } from './columns/guiaRemisionTransportistaColumns';
import DetallesGuiaTransportistaModal from './DetallesGuiaTransportistaModal';
import api from '@/services/api';
import { toast } from '@/lib/sweetalert';

export default function GuiaRemisionTransportista() {
    const { guias, isLoading, error, refetch, enviandoId, enviarGuia, consultarTicket } =
        useGuiasRemisionTransportista();

    const [guiaSeleccionada, setGuiaSeleccionada] = useState(null);
    const [isModalOpen, setIsModalOpen] = useState(false);

    const handleView = async (guia) => {
        try {
            const response = await api.get(`/guias-remision-transportista/${guia.id}`);
            setGuiaSeleccionada(response.data);
            setIsModalOpen(true);
        } catch {
            toast.error('Error al cargar detalle');
        }
    };

    const handleVerPdf = (guia) => {
        window.open(`/reporteGR/a4.php?id=${guia.id}`, '_blank');
    };

    const handleVerXml = (guia) => {
        if (!guia.nombre_xml) return;
        const token = localStorage.getItem('auth_token');
        window.open(`/api/guias-remision-transportista/xml/${guia.nombre_xml}.xml?token=${token}`, '_blank');
    };

    const handleDescargarCdr = async (guia) => {
        try {
            const response = await api.get(`/guias-remision-transportista/${guia.id}/cdr`, {
                responseType: 'blob',
            });
            const url = URL.createObjectURL(response.data);
            const a = document.createElement('a');
            a.href = url;
            a.download = `R-${guia.serie}-${String(guia.numero).padStart(6, '0')}.zip`;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);
        } catch {
            toast.error('CDR no disponible');
        }
    };

    const handleExportar = async () => {
        try {
            const response = await api.get('/guias-remision-transportista/exportar-excel', {
                responseType: 'blob',
            });
            const url = URL.createObjectURL(response.data);
            const a = document.createElement('a');
            a.href = url;
            a.download = `guias-transportista-${new Date().toISOString().slice(0, 10)}.xlsx`;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);
        } catch {
            toast.error('Error al exportar');
        }
    };

    const handlers = {
        handleView,
        handleVerPdf,
        handleEnviar: enviarGuia,
        handleVerXml,
        handleConsultarTicket: consultarTicket,
        handleDescargarCdr,
    };

    const columns = getGuiaRemisionTransportistaColumns(handlers, enviandoId);

    return (
        <MainLayout>
            <div className="space-y-6">
                <div>
                    <h2 className="text-2xl font-bold tracking-tight">
                        Guías de Remisión Transportista
                    </h2>
                    <p className="text-muted-foreground">
                        Gestiona y emite tus guías de remisión electrónicas (transportista)
                    </p>
                </div>

                <div className="flex items-center justify-between flex-wrap gap-3">
                    <div className="flex items-center gap-2">
                        <Button
                            variant="outline"
                            size="sm"
                            className="gap-2"
                            onClick={handleExportar}
                        >
                            <FileSpreadsheet className="h-4 w-4" />
                            <span className="hidden sm:inline">Exportar</span>
                        </Button>
                    </div>
                    <Button
                        onClick={() => (window.location.href = '/guia-remision-transportista/add')}
                        className="gap-2 ml-auto"
                    >
                        <Plus className="h-5 w-5" />
                        Nueva Guía
                    </Button>
                </div>

                {isLoading ? (
                    <div className="flex items-center justify-center h-64">
                        <Loader2 className="h-8 w-8 animate-spin text-primary-600" />
                    </div>
                ) : error ? (
                    <div className="text-center text-red-600 p-8">
                        <p>Error al cargar las guías</p>
                        <Button onClick={refetch} variant="outline" className="mt-4">
                            Reintentar
                        </Button>
                    </div>
                ) : (
                    <DataTable
                        columns={columns}
                        data={guias}
                        searchable={true}
                        searchPlaceholder="Buscar por remitente, destinatario, placa..."
                        pagination={true}
                        pageSize={10}
                    />
                )}
            </div>

            <DetallesGuiaTransportistaModal
                guia={guiaSeleccionada}
                isOpen={isModalOpen}
                onClose={() => {
                    setIsModalOpen(false);
                    setGuiaSeleccionada(null);
                }}
                onDescargarCdr={handleDescargarCdr}
            />
        </MainLayout>
    );
}
