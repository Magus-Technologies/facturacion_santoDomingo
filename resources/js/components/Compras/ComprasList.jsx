import { useState } from "react";
import {
    Plus,
    FileText,
    Loader2,
    FileSpreadsheet,
    FileText as FilePdf,
} from "lucide-react";
import MainLayout from "../Layout/MainLayout";
import { Button } from "../ui/button";
import { DataTable } from "../ui/data-table";
import { useCompras } from "./hooks/useCompras";
import { getComprasColumns } from "./columns/comprasColumns";
import CompraDetallesModal from "./CompraDetallesModal";

export default function ComprasList() {
    const [viewCompraId, setViewCompraId] = useState(null);
    const [isDetallesOpen, setIsDetallesOpen] = useState(false);
    const { compras, loading, handleAnular } = useCompras();

    const handleView = (id) => {
        setViewCompraId(id);
        setIsDetallesOpen(true);
    };

    const handleExport = (tipo) => {
        const url = `/compras/descargar-${tipo}`;
        window.open(url, "_blank");
    };

    // Generar columnas con los handlers
    const columns = getComprasColumns({ handleAnular, handleView });

    // Estado de carga
    if (loading) {
        return (
            <MainLayout>
                <div className="flex items-center justify-center h-screen">
                    <div className="text-center">
                        <Loader2 className="animate-spin h-12 w-12 text-primary-600 mx-auto" />
                        <p className="mt-4 text-gray-600 italic">
                            Cargando compras...
                        </p>
                    </div>
                </div>
            </MainLayout>
        );
    }

    // Vista principal
    return (
        <MainLayout>
            <div className="mb-6">
                <div className="flex items-center justify-between">
                    <div>
                        <h1 className="text-2xl font-bold text-gray-900">
                            Compras
                        </h1>
                        <p className="text-sm text-gray-600 mt-1">
                            Gestiona las órdenes de compra a proveedores
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
                        <Button
                            onClick={() =>
                                (window.location.href = "/compras/nueva")
                            }
                            className="gap-2"
                        >
                            <Plus className="h-4 w-4" />
                            Nueva Compra
                        </Button>
                    </div>
                </div>
            </div>

            <DataTable
                columns={columns}
                data={compras}
                searchable={true}
                searchPlaceholder="Buscar por documento, proveedor..."
                pagination={true}
                pageSize={10}
            />

            {/* Modal de Detalles de Compra */}
            <CompraDetallesModal
                isOpen={isDetallesOpen}
                onClose={() => setIsDetallesOpen(false)}
                compraId={viewCompraId}
            />
        </MainLayout>
    );
}
