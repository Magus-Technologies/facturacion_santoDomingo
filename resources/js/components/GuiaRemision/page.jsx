import { DataTable } from "@/components/ui/data-table";
import {
    Loader2,
    Plus,
    FileSpreadsheet,
} from "lucide-react";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import MainLayout from "../Layout/MainLayout";
import { useGuiasRemision } from "./hooks/useGuiasRemision";
import { getGuiaRemisionColumns } from "./columns/guiaRemisionColumns";

export default function GuiaRemisionPage() {
    const {
        guias,
        loading,
        error,
        fetchGuias,
        enviarGuia,
        consultarTicket,
    } = useGuiasRemision();

    const [enviandoId, setEnviandoId] = useState(null);

    const handleVerXml = async (guia) => {
        if (!guia.nombre_xml) return;
        const token = localStorage.getItem("auth_token");
        try {
            const res = await fetch(`/api/guias-remision/${guia.id}/xml`, {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/xml",
                },
            });

            if (!res.ok) {
                const { toast } = await import("@/lib/sweetalert");
                toast.error("XML no encontrado");
                return;
            }

            const xmlText = await res.text();
            const blob = new Blob([xmlText], { type: "application/xml" });
            const url = URL.createObjectURL(blob);
            window.open(url, "_blank");
        } catch {
            const { toast } = await import("@/lib/sweetalert");
            toast.error("Error al obtener el XML");
        }
    };

    const handleEnviar = async (guia) => {
        setEnviandoId(guia.id);
        await enviarGuia(guia.id);
        setEnviandoId(null);
    };

    const handleConsultarTicket = async (guia) => {
        setEnviandoId(guia.id);
        await consultarTicket(guia.id);
        setEnviandoId(null);
    };

    const handleVerPdf = (guia) => {
        window.open(`/reporteGR/a4.php?id=${guia.id}`, "_blank");
    };

    const handlers = {
        handleView: (guia) => {
            // TODO: Implementar modal de detalle
        },
        handleVerPdf,
        handleEnviar,
        handleVerXml,
        handleConsultarTicket,
    };

    const columns = getGuiaRemisionColumns(handlers, enviandoId);

    return (
        <MainLayout>
            <div className="space-y-6">
                <div>
                    <h2 className="text-2xl font-bold tracking-tight">
                        Guías de Remisión
                    </h2>
                    <p className="text-muted-foreground">
                        Gestiona y emite tus guías de remisión electrónicas
                    </p>
                </div>

                <div className="flex items-center justify-between flex-wrap gap-3">
                    <div className="flex items-center gap-2">
                        <Button
                            variant="outline"
                            size="sm"
                            className="gap-2"
                        >
                            <FileSpreadsheet className="h-4 w-4" />
                            <span className="hidden sm:inline">Exportar</span>
                        </Button>
                    </div>
                    <Button
                        onClick={() =>
                            (window.location.href = "/guia-remision/add")
                        }
                        className="gap-2 ml-auto"
                    >
                        <Plus className="h-5 w-5" />
                        Nueva Guía
                    </Button>
                </div>

                {loading ? (
                    <div className="flex items-center justify-center h-64">
                        <Loader2 className="h-8 w-8 animate-spin text-primary-600" />
                    </div>
                ) : error ? (
                    <div className="text-center text-red-600 p-8">
                        <p>{error}</p>
                        <Button
                            onClick={fetchGuias}
                            variant="outline"
                            className="mt-4"
                        >
                            Reintentar
                        </Button>
                    </div>
                ) : (
                    <DataTable
                        columns={columns}
                        data={guias}
                        searchable={true}
                        searchPlaceholder="Buscar por destinatario, documento..."
                        pagination={true}
                        pageSize={10}
                    />
                )}
            </div>
        </MainLayout>
    );
}
