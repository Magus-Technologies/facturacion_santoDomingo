import { useState } from "react";
import {
    Loader2,
    FileSpreadsheet,
    FileText as FilePdf,
    DollarSign,
    AlertTriangle,
    Clock,
    CheckCircle,
} from "lucide-react";
import MainLayout from "../../Layout/MainLayout";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/ui/data-table";
import { useCuentasPorPagar } from "./hooks/useCuentasPorPagar";
import { getCuentasPagarColumns } from "./columns/cuentasPagarColumns";
import PagarCuotaModal from "./PagarCuotaModal";

const estadoFilters = [
    { key: "todos", label: "Todos", color: "bg-gray-100 text-gray-700", activeColor: "bg-gray-600 text-white" },
    { key: "pendiente", label: "Pendientes", color: "bg-yellow-50 text-yellow-700", activeColor: "bg-yellow-500 text-white" },
    { key: "vencido", label: "Vencidos", color: "bg-red-50 text-red-700", activeColor: "bg-red-600 text-white" },
    { key: "pagado", label: "Pagados", color: "bg-green-50 text-green-700", activeColor: "bg-green-600 text-white" },
];

export default function CuentasPorPagarList() {
    const { cuotas, resumen, loading, registrarPago } = useCuentasPorPagar();
    const [cuotaSeleccionada, setCuotaSeleccionada] = useState(null);
    const [isPagarOpen, setIsPagarOpen] = useState(false);
    const [filtroEstado, setFiltroEstado] = useState("todos");

    const handlePagar = (cuota) => {
        setCuotaSeleccionada(cuota);
        setIsPagarOpen(true);
    };

    const handleExport = (tipo) => {
        const params = new URLSearchParams();
        if (filtroEstado !== 'todos') {
            if (filtroEstado === 'pendiente') params.append('estado', '1');
            else if (filtroEstado === 'vencido') params.append('estado', 'V');
            else if (filtroEstado === 'pagado') params.append('estado', '0');
        }
        const queryStr = params.toString() ? `?${params}` : '';

        if (tipo === 'excel') {
            const token = localStorage.getItem('auth_token');
            window.open(`/api/cuentas-por-pagar/exportar-excel${queryStr}&token=${token}`, '_blank');
        } else {
            window.open(`/cuentas-por-pagar/descargar-pdf${queryStr}`, '_blank');
        }
    };

    const columns = getCuentasPagarColumns({ handlePagar });

    const now = new Date();
    now.setHours(0, 0, 0, 0);

    const cuotasFiltradas = (() => {
        if (filtroEstado === "todos") return cuotas;
        if (filtroEstado === "pendiente") return cuotas.filter(c => c.estado === '1' && (!c.fecha_vencimiento || new Date(c.fecha_vencimiento) >= now));
        if (filtroEstado === "vencido") return cuotas.filter(c => c.estado === '1' && c.fecha_vencimiento && new Date(c.fecha_vencimiento) < now);
        if (filtroEstado === "pagado") return cuotas.filter(c => c.estado === '0');
        return cuotas;
    })();

    const conteos = {
        todos: cuotas.length,
        pendiente: cuotas.filter(c => c.estado === '1' && (!c.fecha_vencimiento || new Date(c.fecha_vencimiento) >= now)).length,
        vencido: cuotas.filter(c => c.estado === '1' && c.fecha_vencimiento && new Date(c.fecha_vencimiento) < now).length,
        pagado: cuotas.filter(c => c.estado === '0').length,
    };

    if (loading) {
        return (
            <MainLayout>
                <div className="flex items-center justify-center h-screen">
                    <div className="text-center">
                        <Loader2 className="animate-spin h-12 w-12 text-primary-600 mx-auto" />
                        <p className="mt-4 text-gray-600 italic">Cargando cuentas por pagar...</p>
                    </div>
                </div>
            </MainLayout>
        );
    }

    return (
        <MainLayout>
            <div className="space-y-4 sm:space-y-6">
                {/* Header */}
                <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                    <div>
                        <h1 className="text-xl sm:text-2xl font-bold text-gray-900">Cuentas por Pagar</h1>
                        <p className="text-xs sm:text-sm text-gray-600 mt-1">Cuotas pendientes de pago a proveedores</p>
                    </div>
                    <div className="flex items-center gap-2">
                        <Button
                            variant="outline"
                            size="sm"
                            className="gap-2 border-green-200 text-green-700 hover:bg-green-50"
                            onClick={() => handleExport("excel")}
                        >
                            <FileSpreadsheet className="h-4 w-4" />
                            <span className="hidden sm:inline">Excel</span>
                        </Button>
                        <Button
                            variant="outline"
                            size="sm"
                            className="gap-2 border-red-200 text-red-700 hover:bg-red-50"
                            onClick={() => handleExport("pdf")}
                        >
                            <FilePdf className="h-4 w-4" />
                            <span className="hidden sm:inline">PDF</span>
                        </Button>
                    </div>
                </div>

                {/* Cards Resumen */}
                <div className="grid grid-cols-2 lg:grid-cols-4 gap-3 sm:gap-4">
                    <div className="bg-orange-50 border border-orange-200 rounded-xl p-3 sm:p-4">
                        <div className="flex items-center gap-2 sm:gap-3">
                            <div className="p-1.5 sm:p-2 bg-orange-100 rounded-lg">
                                <DollarSign className="h-4 w-4 sm:h-5 sm:w-5 text-orange-600" />
                            </div>
                            <div className="min-w-0">
                                <p className="text-[10px] sm:text-xs text-orange-600 font-medium">Total Pendiente</p>
                                <p className="text-base sm:text-xl font-bold text-orange-800 truncate">S/ {resumen.total_pendiente || '0.00'}</p>
                            </div>
                        </div>
                    </div>
                    <div className="bg-red-50 border border-red-200 rounded-xl p-3 sm:p-4">
                        <div className="flex items-center gap-2 sm:gap-3">
                            <div className="p-1.5 sm:p-2 bg-red-100 rounded-lg">
                                <AlertTriangle className="h-4 w-4 sm:h-5 sm:w-5 text-red-600" />
                            </div>
                            <div className="min-w-0">
                                <p className="text-[10px] sm:text-xs text-red-600 font-medium">Total Vencido</p>
                                <p className="text-base sm:text-xl font-bold text-red-800 truncate">S/ {resumen.total_vencido || '0.00'}</p>
                            </div>
                        </div>
                    </div>
                    <div className="bg-yellow-50 border border-yellow-200 rounded-xl p-3 sm:p-4">
                        <div className="flex items-center gap-2 sm:gap-3">
                            <div className="p-1.5 sm:p-2 bg-yellow-100 rounded-lg">
                                <Clock className="h-4 w-4 sm:h-5 sm:w-5 text-yellow-600" />
                            </div>
                            <div className="min-w-0">
                                <p className="text-[10px] sm:text-xs text-yellow-600 font-medium">Próximas a Vencer</p>
                                <p className="text-base sm:text-xl font-bold text-yellow-800">{resumen.proximas_vencer || 0}</p>
                            </div>
                        </div>
                    </div>
                    <div className="bg-green-50 border border-green-200 rounded-xl p-3 sm:p-4">
                        <div className="flex items-center gap-2 sm:gap-3">
                            <div className="p-1.5 sm:p-2 bg-green-100 rounded-lg">
                                <CheckCircle className="h-4 w-4 sm:h-5 sm:w-5 text-green-600" />
                            </div>
                            <div className="min-w-0">
                                <p className="text-[10px] sm:text-xs text-green-600 font-medium">Pagado este Mes</p>
                                <p className="text-base sm:text-xl font-bold text-green-800 truncate">S/ {resumen.total_pagado_mes || '0.00'}</p>
                            </div>
                        </div>
                    </div>
                </div>

                {/* Filtros estado - pill buttons */}
                <div className="flex flex-wrap gap-2">
                    {estadoFilters.map(({ key, label, color, activeColor }) => (
                        <button
                            key={key}
                            onClick={() => setFiltroEstado(key)}
                            className={`px-3 py-1.5 rounded-full text-xs sm:text-sm font-medium transition-colors ${
                                filtroEstado === key ? activeColor : color
                            }`}
                        >
                            {label}
                            <span className="ml-1.5 text-xs opacity-75">
                                {conteos[key]}
                            </span>
                        </button>
                    ))}
                </div>

                <DataTable
                    columns={columns}
                    data={cuotasFiltradas}
                    searchable={true}
                    searchPlaceholder="Buscar por documento, proveedor..."
                    pagination={true}
                    pageSize={15}
                />

                <PagarCuotaModal
                    isOpen={isPagarOpen}
                    onClose={() => setIsPagarOpen(false)}
                    cuota={cuotaSeleccionada}
                    onPagar={registrarPago}
                />
            </div>
        </MainLayout>
    );
}
