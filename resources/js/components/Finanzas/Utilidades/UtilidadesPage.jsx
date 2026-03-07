import { useState } from 'react';
import { RefreshCw, Download, Loader2, AlertCircle, Package, Receipt, FolderOpen, User, CalendarDays, Wallet } from 'lucide-react';

import MainLayout from '@/components/Layout/MainLayout';
import { Button } from '@/components/ui/button';

import { useUtilidades } from './hooks/useUtilidades';
import { baseUrl } from '@/lib/baseUrl';
import { TabProductos } from './tabs/TabProductos';
import { TabVentas } from './tabs/TabVentas';
import { TabCategorias } from './tabs/TabCategorias';
import { TabVendedores } from './tabs/TabVendedores';
import { TabTiempo } from './tabs/TabTiempo';
import { TabGastos } from './tabs/TabGastos';

// ════════════════════════════════════════════════════════
// TABS CONFIG
// ════════════════════════════════════════════════════════
const TABS = [
    { id: 'productos', label: 'Por Producto', icon: Package },
    { id: 'ventas', label: 'Por Venta', icon: Receipt },
    { id: 'categorias', label: 'Por Categoría', icon: FolderOpen },
    { id: 'vendedores', label: 'Por Vendedor', icon: User },
    { id: 'tiempo', label: 'Diaria / Mensual', icon: CalendarDays },
    { id: 'gastos', label: 'Costos y Gastos', icon: Wallet },
];

// ════════════════════════════════════════════════════════
// MAIN PAGE
// ════════════════════════════════════════════════════════
export default function UtilidadesPage() {
    const { data, loading, error, periodo, cambiarPeriodo, PERIODOS, refetch } = useUtilidades();
    const [tabActiva, setTabActiva] = useState('productos');

    return (
        <MainLayout>
            {/* ── HEADER ── */}
            <div className="sticky top-0 z-40 bg-white border-b border-gray-200">
                <div className="flex items-center justify-between px-8 py-6 flex-wrap gap-4">
                    <div>
                        <h1 className="text-3xl font-bold text-gray-900">Análisis de Utilidades</h1>
                        <p className="text-sm text-gray-600 mt-1">Business Intelligence · Rentabilidad y Márgenes</p>
                    </div>
                    <div className="flex items-center gap-3">
                        <div className="flex border border-gray-300 rounded-lg overflow-hidden bg-white">
                            {PERIODOS.map(p => (
                                <button
                                    key={p.id}
                                    onClick={() => cambiarPeriodo(p.id)}
                                    className={`px-4 py-2 text-sm font-semibold border-r border-gray-300 last:border-r-0 transition-all ${periodo === p.id
                                        ? 'bg-primary-600 text-white'
                                        : 'bg-white text-gray-700 hover:bg-gray-50'
                                        }`}
                                >
                                    {p.label}
                                </button>
                            ))}
                        </div>
                        <Button
                            variant="outline"
                            size="sm"
                            onClick={() => refetch(periodo)}
                            disabled={loading}
                        >
                            <RefreshCw className={`h-4 w-4 mr-2 ${loading ? 'animate-spin' : ''}`} />
                            Actualizar
                        </Button>
                        <Button
                            variant="outline"
                            size="sm"
                            onClick={async () => {
                                try {
                                    const params = new URLSearchParams({ periodo, tab: tabActiva });
                                    const url = baseUrl(`/api/finanzas/utilidades/exportar?${params.toString()}`);

                                    const response = await fetch(url, {
                                        headers: {
                                            'Authorization': `Bearer ${localStorage.getItem('auth_token')}`,
                                            'Accept': 'application/json'
                                        }
                                    });

                                    // Validar si es JSON (error)
                                    const contentType = response.headers.get('content-type');
                                    if (contentType && contentType.includes('application/json')) {
                                        const errorData = await response.json();
                                        throw new Error(errorData.message || 'Error en el servidor');
                                    }

                                    if (!response.ok) throw new Error('Servidor retornó ' + response.status);

                                    const blob = await response.blob();
                                    const blobUrl = window.URL.createObjectURL(blob);
                                    const link = document.createElement('a');
                                    link.href = blobUrl;

                                    const disposition = response.headers.get('Content-Disposition');
                                    let filename = `Reporte_Utilidades_${new Date().toISOString().slice(0, 10)}.xlsx`;
                                    if (disposition && disposition.indexOf('attachment') !== -1) {
                                        const filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                                        const matches = filenameRegex.exec(disposition);
                                        if (matches != null && matches[1]) {
                                            filename = matches[1].replace(/['"]/g, '');
                                        }
                                    }

                                    link.setAttribute('download', filename);
                                    document.body.appendChild(link);
                                    link.click();
                                    link.parentNode.removeChild(link);
                                    window.URL.revokeObjectURL(blobUrl);
                                } catch (err) {
                                    alert('Error al descargar: ' + err.message);
                                }
                            }}
                            disabled={loading}
                        >
                            <Download className="h-4 w-4 mr-2" />
                            Exportar
                        </Button>
                    </div>
                </div>

                {/* ── TABS ── */}
                <div className="flex border-t border-gray-200 overflow-x-auto bg-gray-50">
                    {TABS.map(tab => {
                        const Icon = tab.icon;
                        const active = tabActiva === tab.id;
                        return (
                            <button
                                key={tab.id}
                                onClick={() => setTabActiva(tab.id)}
                                className={`flex items-center gap-2 px-6 py-4 text-sm font-semibold whitespace-nowrap border-b-2 transition-all ${active
                                    ? 'border-primary-600 text-primary-700 bg-white'
                                    : 'border-transparent text-gray-600 hover:text-gray-900 hover:bg-white'
                                    }`}
                            >
                                <Icon className="h-4 w-4" />
                                {tab.label}
                            </button>
                        );
                    })}
                </div>
            </div>

            {/* ── ERROR STATE ── */}
            {
                error && (
                    <div className="mx-8 mt-6 p-4 bg-red-50 border border-red-200 rounded-lg text-sm text-red-700 flex items-center gap-3">
                        <AlertCircle className="h-5 w-5 flex-shrink-0" />
                        {error}
                    </div>
                )
            }

            {/* ── LOADING STATE ── */}
            {
                loading && !data && (
                    <div className="flex items-center justify-center min-h-[600px]">
                        <Loader2 className="h-8 w-8 animate-spin text-gray-400" />
                    </div>
                )
            }

            {/* ── CONTENT ── */}
            {
                data && (
                    <div className={`px-8 py-8 bg-gray-50 min-h-screen transition-opacity ${loading ? 'opacity-60 pointer-events-none' : ''}`}>
                        {tabActiva === 'productos' && <TabProductos data={data} kpis={data.kpis} />}
                        {tabActiva === 'ventas' && <TabVentas data={data} kpis={data.kpis} />}
                        {tabActiva === 'categorias' && <TabCategorias data={data} />}
                        {tabActiva === 'vendedores' && <TabVendedores data={data} />}
                        {tabActiva === 'tiempo' && <TabTiempo data={data} kpis={data.kpis} />}
                        {tabActiva === 'gastos' && <TabGastos data={data} kpis={data.kpis} />}
                    </div>
                )
            }
        </MainLayout >
    );
}
