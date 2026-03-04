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
import { useCuentasPorCobrar } from "./hooks/useCuentasPorCobrar";
import { getCuentasCobrarColumns } from "./columns/cuentasCobrarColumns";
import PagarCuotaModal from "./PagarCuotaModal";

const estadoFilters = [
    { key: "todos", label: "Todos", color: "bg-gray-100 text-gray-700", activeColor: "bg-gray-600 text-white" },
    { key: "P", label: "Pendientes", color: "bg-yellow-50 text-yellow-700", activeColor: "bg-yellow-500 text-white" },
    { key: "V", label: "Vencidos", color: "bg-red-50 text-red-700", activeColor: "bg-red-600 text-white" },
    { key: "C", label: "Pagados", color: "bg-green-50 text-green-700", activeColor: "bg-green-600 text-white" },
];

export default function CuentasPorCobrarList() {
    const { cuotas, resumen, loading, registrarPago } = useCuentasPorCobrar();
    const [cuotaSeleccionada, setCuotaSeleccionada] = useState(null);
    const [isPagarOpen, setIsPagarOpen] = useState(false);
    const [filtroEstado, setFiltroEstado] = useState("todos");

    const handlePagar = (cuota) => {
        setCuotaSeleccionada(cuota);
        setIsPagarOpen(true);
    };

    const handleExport = (tipo) => {
        const params = new URLSearchParams();
        if (filtroEstado !== 'todos') params.append('estado', filtroEstado);
        const queryStr = params.toString() ? `?${params}` : '';

        if (tipo === 'excel') {
            const token = localStorage.getItem('auth_token');
            window.open(`/api/cuentas-por-cobrar/exportar-excel${queryStr}&token=${token}`, '_blank');
        } else {
            window.open(`/cuentas-por-cobrar/descargar-pdf${queryStr}`, '_blank');
        }
    };

    const columns = getCuentasCobrarColumns({ handlePagar });

    const cuotasFiltradas = filtroEstado === "todos"
        ? cuotas
        : cuotas.filter(c => c.estado === filtroEstado);

    const conteos = {
        todos: cuotas.length,
        P: cuotas.filter(c => c.estado === 'P').length,
        V: cuotas.filter(c => c.estado === 'V').length,
        C: cuotas.filter(c => c.estado === 'C').length,
    };

    if (loading) {
        return (
            <MainLayout>
                <div className="flex items-center justify-center h-screen">
                    <div className="text-center">
                        <Loader2 className="animate-spin h-12 w-12 text-primary-600 mx-auto" />
                        <p className="mt-4 text-gray-600 italic">Cargando cuentas por cobrar...</p>
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
                        <h1 className="text-xl sm:text-2xl font-bold text-gray-900">Cuentas por Cobrar</h1>
                        <p className="text-xs sm:text-sm text-gray-600 mt-1">Cuotas pendientes de cobro de ventas a crédito</p>
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
                                <p className="text-[10px] sm:text-xs text-green-600 font-medium">Cobrado este Mes</p>
                                <p className="text-base sm:text-xl font-bold text-green-800 truncate">S/ {resumen.total_cobrado_mes || '0.00'}</p>
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
                    searchPlaceholder="Buscar por documento, cliente..."
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
