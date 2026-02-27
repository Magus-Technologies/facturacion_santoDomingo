import { useState } from "react";
import { Button } from "@/components/ui/button";
import { toast } from "@/lib/sweetalert";
import {
    Plus,
    FileSpreadsheet,
    Minus,
    ArrowLeftRight,
    History,
    Ruler,
    FolderOpen,
    Loader2,
} from "lucide-react";
import UnidadesModal from "../UnidadesModal";
import CategoriasModal from "../CategoriasModal";
import ImportarExcelModal from "./ImportarExcelModal";
import { PermissionGuard } from "@/components/auth/PermissionGuard";

export default function ProductosActionButtons({ onNuevoProducto, onRefresh, almacenActivo, busqueda }) {
    const [isUnidadesModalOpen, setIsUnidadesModalOpen] = useState(false);
    const [isCategoriasModalOpen, setIsCategoriasModalOpen] = useState(false);
    const [isImportarExcelModalOpen, setIsImportarExcelModalOpen] = useState(false);
    const [loadingExcel, setLoadingExcel] = useState(false);

    const handleExcelBusqueda = () => {
        setLoadingExcel(true);
        
        const token = localStorage.getItem("auth_token");
        const url = `/api/productos/descargar-excel?almacen=${almacenActivo}&texto=${encodeURIComponent(busqueda || '')}`;
        
        // Agregar headers de autenticación
        fetch(url, {
            headers: {
                Authorization: `Bearer ${token}`,
            },
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Error al descargar el archivo');
            }
            return response.blob();
        })
        .then(blob => {
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = `productos-almacen-${almacenActivo}-${new Date().toISOString().slice(0,10)}.xlsx`;
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(url);
            document.body.removeChild(a);
            
            toast.success("Excel descargado exitosamente");
        })
        .catch(error => {
            console.error("Error:", error);
            toast.error("Error al descargar Excel");
        })
        .finally(() => {
            setLoadingExcel(false);
        });
    };

    const handleAumentarStock = () => {
        toast.info("Función en desarrollo");
    };

    const handleDisminuirStock = () => {
        toast.info("Función en desarrollo");
    };

    const handleTraslado = () => {
        toast.info("Función en desarrollo");
    };

    const handleHistorial = () => {
        toast.info("Función en desarrollo");
    };

    return (
        <>
            <div className="flex items-center justify-between flex-wrap gap-3">
                {/* Botones de operaciones */}
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
                    <PermissionGuard permission="productos.edit">
                        <Button
                            variant="outline"
                            size="sm"
                            className="gap-2"
                            onClick={handleAumentarStock}
                        >
                            <Plus className="h-4 w-4" />
                            <span className="hidden sm:inline">Aumentar Stock</span>
                        </Button>
                    </PermissionGuard>
                    <PermissionGuard permission="productos.edit">
                        <Button
                            variant="outline"
                            size="sm"
                            className="gap-2"
                            onClick={handleDisminuirStock}
                        >
                            <Minus className="h-4 w-4" />
                            <span className="hidden sm:inline">Disminuir Stock</span>
                        </Button>
                    </PermissionGuard>
                    <PermissionGuard permission="productos.edit">
                        <Button
                            variant="outline"
                            size="sm"
                            className="gap-2"
                            onClick={handleTraslado}
                        >
                            <ArrowLeftRight className="h-4 w-4" />
                            <span className="hidden sm:inline">Traslado</span>
                        </Button>
                    </PermissionGuard>
                    <Button
                        variant="outline"
                        size="sm"
                        className="gap-2"
                        onClick={handleHistorial}
                    >
                        <History className="h-4 w-4" />
                        <span className="hidden sm:inline">Historial</span>
                    </Button>
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
                </div>
                
                {/* Botón Nuevo Producto */}
                <PermissionGuard permission="productos.create">
                    <Button
                        onClick={onNuevoProducto}
                        className="gap-2"
                    >
                        <Plus className="h-5 w-5" />
                        Nuevo Producto
                    </Button>
                </PermissionGuard>
            </div>

            {/* Modales */}
            <UnidadesModal
                isOpen={isUnidadesModalOpen}
                onClose={() => setIsUnidadesModalOpen(false)}
            />
            <CategoriasModal
                isOpen={isCategoriasModalOpen}
                onClose={() => setIsCategoriasModalOpen(false)}
            />
            <ImportarExcelModal
                isOpen={isImportarExcelModalOpen}
                onClose={() => setIsImportarExcelModalOpen(false)}
                onSuccess={onRefresh}
                almacen={almacenActivo}
            />
        </>
    );
}
