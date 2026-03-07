import { useState } from "react";
import { Button } from "@/components/ui/button";
import { toast } from "@/lib/sweetalert";
import { baseUrl } from "@/lib/baseUrl";
import {
    Plus,
    FileSpreadsheet,
    History,
    Ruler,
    FolderOpen,
    Loader2,
    Warehouse,
} from "lucide-react";
import UnidadesModal from "../UnidadesModal";
import CategoriasModal from "../CategoriasModal";
import ImportarExcelModal from "./ImportarExcelModal";
import AlmacenesModal from "./AlmacenesModal";
import { PermissionGuard } from "@/components/auth/PermissionGuard";

export default function ProductosActionButtons({ onNuevoProducto, onRefresh, almacenActivo, almacenNombre, busqueda, onAlmacenesChange }) {
    const [isUnidadesModalOpen, setIsUnidadesModalOpen] = useState(false);
    const [isCategoriasModalOpen, setIsCategoriasModalOpen] = useState(false);
    const [isImportarExcelModalOpen, setIsImportarExcelModalOpen] = useState(false);
    const [isAlmacenesModalOpen, setIsAlmacenesModalOpen] = useState(false);
    const [loadingExcel, setLoadingExcel] = useState(false);

    const handleExcelBusqueda = () => {
        setLoadingExcel(true);

        const token = localStorage.getItem("auth_token");
        const url = baseUrl(`/api/productos/descargar-excel?almacen=${almacenActivo}&texto=${encodeURIComponent(busqueda || '')}`);

        fetch(url, {
            headers: { Authorization: `Bearer ${token}` },
        })
        .then(response => {
            if (!response.ok) throw new Error('Error al descargar el archivo');
            return response.blob();
        })
        .then(blob => {
            const blobUrl = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = blobUrl;
            a.download = `productos-almacen-${almacenActivo}-${new Date().toISOString().slice(0,10)}.xlsx`;
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(blobUrl);
            document.body.removeChild(a);
            toast.success("Excel descargado exitosamente");
        })
        .catch(() => toast.error("Error al descargar Excel"))
        .finally(() => setLoadingExcel(false));
    };

    return (
        <>
            <div className="flex items-center justify-between flex-wrap gap-3">
                <div className="flex items-center gap-2 flex-wrap">
                    <Button
                        variant="outline"
                        size="sm"
                        className="gap-2"
                        onClick={handleExcelBusqueda}
                        disabled={loadingExcel}
                    >
                        {loadingExcel ? (
                            <Loader2 className="h-4 w-4 animate-spin" />
                        ) : (
                            <FileSpreadsheet className="h-4 w-4" />
                        )}
                        <span className="hidden sm:inline">Descargar Excel</span>
                    </Button>
                    <PermissionGuard permission="productos.create">
                        <Button
                            variant="outline"
                            size="sm"
                            className="gap-2"
                            onClick={() => setIsImportarExcelModalOpen(true)}
                        >
                            <FileSpreadsheet className="h-4 w-4" />
                            <span className="hidden sm:inline">Importar Excel</span>
                        </Button>
                    </PermissionGuard>
                    <a href={baseUrl("/historial-movimientos")}>
                        <Button variant="outline" size="sm" className="gap-2">
                            <History className="h-4 w-4" />
                            <span className="hidden sm:inline">Historial</span>
                        </Button>
                    </a>
                    <Button
                        variant="outline"
                        size="sm"
                        className="gap-2"
                        onClick={() => setIsUnidadesModalOpen(true)}
                    >
                        <Ruler className="h-4 w-4" />
                        <span className="hidden sm:inline">Unidades</span>
                    </Button>
                    <Button
                        variant="outline"
                        size="sm"
                        className="gap-2"
                        onClick={() => setIsCategoriasModalOpen(true)}
                    >
                        <FolderOpen className="h-4 w-4" />
                        <span className="hidden sm:inline">Categorías</span>
                    </Button>
                    <PermissionGuard permission="productos.create">
                        <Button
                            variant="outline"
                            size="sm"
                            className="gap-2"
                            onClick={() => setIsAlmacenesModalOpen(true)}
                        >
                            <Warehouse className="h-4 w-4" />
                            <span className="hidden sm:inline">Almacenes</span>
                        </Button>
                    </PermissionGuard>
                </div>

                <PermissionGuard permission="productos.create">
                    <Button onClick={onNuevoProducto} className="gap-2">
                        <Plus className="h-5 w-5" />
                        Nuevo Producto
                    </Button>
                </PermissionGuard>
            </div>

            <UnidadesModal isOpen={isUnidadesModalOpen} onClose={() => setIsUnidadesModalOpen(false)} />
            <CategoriasModal isOpen={isCategoriasModalOpen} onClose={() => setIsCategoriasModalOpen(false)} />
            <ImportarExcelModal
                isOpen={isImportarExcelModalOpen}
                onClose={() => setIsImportarExcelModalOpen(false)}
                onSuccess={onRefresh}
                almacen={almacenActivo}
                almacenNombre={almacenNombre}
            />
            <AlmacenesModal
                isOpen={isAlmacenesModalOpen}
                onClose={() => setIsAlmacenesModalOpen(false)}
                onSuccess={onAlmacenesChange}
            />
        </>
    );
}
