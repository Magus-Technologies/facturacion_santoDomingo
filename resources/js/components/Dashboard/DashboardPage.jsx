import { useState } from 'react';
import { DollarSign, ShoppingCart, TrendingUp, Users, Package, Tag, Layers, CalendarDays, BarChart2, UserCheck, AlertTriangle } from 'lucide-react';
import { useDashboardFilters } from './hooks/useDashboardFilters';
import DashboardFilters from './components/DashboardFilters';
import KPICard from './components/KPICard';
import DataTable from './components/DataTable';
import {
    VentasPorDiaChart,
    MetodosPagoChart,
    IngresosEgresosChart,
    TopProductosChart,
    TopCategoriasChart,
    TopMarcasChart,
    TopFechasChart,
    RentabilidadChart,
    GananciaVsIngresoChart,
    TopClientesChart,
    VentasPorHoraChart,
    VendedoresChart,
} from './components/DashboardCharts';

const TABS = [
    { id: 'resumen', label: 'Resumen', icon: TrendingUp },
    { id: 'rentabilidad', label: 'Rentabilidad', icon: BarChart2 },
    { id: 'clientes', label: 'Clientes & Equipo', icon: UserCheck },
    { id: 'productos', label: 'Productos', icon: Package },
    { id: 'inventario', label: 'Inventario', icon: AlertTriangle },
];

export default function DashboardPage() {
    const [activeTab, setActiveTab] = useState('resumen');

    const {
        filters,
        setFilters,
        setPeriodo,
        stats,
        ventasPorDia,
        metodosPago,
        ingresosEgresos,
        topProductos,
        topCategorias,
        topMarcas,
        topFechas,
        ultimasTransacciones,
        cajasPendientes,
        rentabilidad,
        rentabilidadResumen,
        topClientes,
        ventasPorHora,
        vendedores,
        stockBajo,
        stockBajoTotal,
        loading
    } = useDashboardFilters();

    const transaccionesColumns = [
        {
            accessorKey: 'fecha',
            header: 'Fecha',
            cell: ({ row }) => new Date(row.original.fecha).toLocaleDateString()
        },
        {
            accessorKey: 'cliente',
            header: 'Cliente'
        },
        {
            accessorKey: 'monto',
            header: 'Monto',
            cell: ({ row }) => `S/. ${parseFloat(row.original.monto).toFixed(2)}`
        },
        {
            accessorKey: 'metodo',
            header: 'Método'
        },
        {
            accessorKey: 'estado',
            header: 'Estado',
            cell: ({ row }) => (
                <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold ${row.original.estado === 'completada'
                    ? 'bg-green-50 text-green-700 ring-1 ring-green-200'
                    : 'bg-yellow-50 text-yellow-700 ring-1 ring-yellow-200'
                    }`}>
                    {row.original.estado}
                </span>
            )
        }
    ];

    const cajasPendientesColumns = [
        {
            accessorKey: 'vendedor',
            header: 'Vendedor'
        },
        {
            accessorKey: 'apertura',
            header: 'Apertura',
            cell: ({ row }) => `S/. ${parseFloat(row.original.apertura).toFixed(2)}`
        },
        {
            accessorKey: 'cierre',
            header: 'Cierre',
            cell: ({ row }) => `S/. ${parseFloat(row.original.cierre).toFixed(2)}`
        },
        {
            accessorKey: 'diferencia',
            header: 'Diferencia',
            cell: ({ row }) => {
                const diff = parseFloat(row.original.diferencia);
                return (
                    <span className={`font-semibold ${diff === 0 ? 'text-green-600' : diff > 0 ? 'text-blue-600' : 'text-red-600'}`}>
                        S/. {diff.toFixed(2)}
                    </span>
                );
            }
        }
    ];

    const productosTableColumns = [
        {
            accessorKey: 'nombre',
            header: 'Producto',
            cell: ({ row }) => (
                <div className="flex items-center gap-2">
                    <div className="w-8 h-8 rounded-lg bg-gradient-to-br from-red-500 to-red-600 flex items-center justify-center text-white text-xs font-bold shadow-sm">
                        {(row.index + 1)}
                    </div>
                    <span className="font-medium text-gray-900 truncate max-w-[200px]">{row.original.nombre}</span>
                </div>
            )
        },
        {
            accessorKey: 'cantidad',
            header: 'Unidades Vendidas',
            cell: ({ row }) => (
                <span className="font-semibold text-red-700">{row.original.cantidad}</span>
            )
        }
    ];

    const categoriasTableColumns = [
        {
            accessorKey: 'categoria',
            header: 'Categoría',
            cell: ({ row }) => (
                <div className="flex items-center gap-2">
                    <div className="w-8 h-8 rounded-lg bg-gradient-to-br from-red-500 to-red-600 flex items-center justify-center text-white text-xs font-bold shadow-sm">
                        {(row.index + 1)}
                    </div>
                    <span className="font-medium text-gray-900">{row.original.categoria}</span>
                </div>
            )
        },
        {
            accessorKey: 'cantidad_total',
            header: 'Uds. Vendidas',
            cell: ({ row }) => <span className="font-semibold">{row.original.cantidad_total}</span>
        },
        {
            accessorKey: 'total_ventas',
            header: 'N° Ventas',
            cell: ({ row }) => <span className="font-semibold">{row.original.total_ventas}</span>
        },
        {
            accessorKey: 'monto_total',
            header: 'Monto Total',
            cell: ({ row }) => <span className="font-bold text-red-700">S/. {parseFloat(row.original.monto_total).toLocaleString('es-PE', { minimumFractionDigits: 2 })}</span>
        }
    ];

    const fechasTableColumns = [
        {
            accessorKey: 'fecha',
            header: 'Fecha',
            cell: ({ row }) => {
                const date = new Date(row.original.fecha + 'T00:00:00');
                return (
                    <div className="flex items-center gap-2">
                        <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-red-500 to-red-600 flex flex-col items-center justify-center text-white shadow-sm leading-none">
                            <span className="text-[10px] font-medium uppercase">{date.toLocaleDateString('es-PE', { month: 'short' })}</span>
                            <span className="text-sm font-bold">{date.getDate()}</span>
                        </div>
                        <span className="font-medium text-gray-900">{date.toLocaleDateString('es-PE', { weekday: 'long' })}</span>
                    </div>
                );
            }
        },
        {
            accessorKey: 'total_ventas',
            header: 'N° Transacciones',
            cell: ({ row }) => <span className="font-semibold">{row.original.total_ventas}</span>
        },
        {
            accessorKey: 'monto_total',
            header: 'Monto Total',
            cell: ({ row }) => <span className="font-bold text-red-700">S/. {parseFloat(row.original.monto_total).toLocaleString('es-PE', { minimumFractionDigits: 2 })}</span>
        }
    ];

    // Columns for new tabs
    const rentabilidadColumns = [
        {
            accessorKey: 'nombre',
            header: 'Producto',
            cell: ({ row }) => (
                <div className="flex items-center gap-2">
                    <div className="w-7 h-7 rounded-lg bg-gradient-to-br from-red-500 to-red-600 flex items-center justify-center text-white text-xs font-bold shadow-sm">
                        {row.index + 1}
                    </div>
                    <span className="font-medium text-gray-900 truncate max-w-[180px]">{row.original.nombre}</span>
                </div>
            )
        },
        {
            accessorKey: 'ingresos',
            header: 'Ingresos',
            cell: ({ row }) => <span className="font-semibold">S/. {parseFloat(row.original.ingresos).toLocaleString('es-PE', { minimumFractionDigits: 2 })}</span>
        },
        {
            accessorKey: 'costo_total',
            header: 'Costo',
            cell: ({ row }) => <span className="text-gray-600">S/. {parseFloat(row.original.costo_total).toLocaleString('es-PE', { minimumFractionDigits: 2 })}</span>
        },
        {
            accessorKey: 'ganancia',
            header: 'Ganancia',
            cell: ({ row }) => <span className="font-bold text-green-700">S/. {parseFloat(row.original.ganancia).toLocaleString('es-PE', { minimumFractionDigits: 2 })}</span>
        },
        {
            accessorKey: 'margen_porcentaje',
            header: 'Margen %',
            cell: ({ row }) => {
                const m = parseFloat(row.original.margen_porcentaje);
                return (
                    <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-bold ${m >= 30 ? 'bg-green-50 text-green-700 ring-1 ring-green-200' : m >= 15 ? 'bg-yellow-50 text-yellow-700 ring-1 ring-yellow-200' : 'bg-red-50 text-red-700 ring-1 ring-red-200'}`}>
                        {m.toFixed(1)}%
                    </span>
                );
            }
        },
    ];

    const clientesColumns = [
        {
            accessorKey: 'nombre',
            header: 'Cliente',
            cell: ({ row }) => (
                <div className="flex items-center gap-2">
                    <div className="w-9 h-9 rounded-full bg-gradient-to-br from-red-500 to-red-600 flex items-center justify-center text-white text-sm font-bold shadow-sm">
                        {(row.original.nombre || 'N')[0].toUpperCase()}
                    </div>
                    <div>
                        <p className="font-semibold text-gray-900 truncate max-w-[180px]">{row.original.nombre}</p>
                        <p className="text-xs text-gray-400">{row.original.documento}</p>
                    </div>
                </div>
            )
        },
        {
            accessorKey: 'total_compras',
            header: 'Compras',
            cell: ({ row }) => <span className="font-semibold text-center">{row.original.total_compras}</span>
        },
        {
            accessorKey: 'ticket_promedio',
            header: 'Ticket Prom.',
            cell: ({ row }) => <span className="text-gray-600">S/. {parseFloat(row.original.ticket_promedio).toFixed(2)}</span>
        },
        {
            accessorKey: 'monto_total',
            header: 'Total Comprado',
            cell: ({ row }) => <span className="font-bold text-red-700">S/. {parseFloat(row.original.monto_total).toLocaleString('es-PE', { minimumFractionDigits: 2 })}</span>
        },
    ];

    const vendedoresColumns = [
        {
            accessorKey: 'vendedor',
            header: 'Vendedor',
            cell: ({ row }) => (
                <div className="flex items-center gap-2">
                    <div className="w-9 h-9 rounded-full bg-gradient-to-br from-red-500 to-red-600 flex items-center justify-center text-white text-sm font-bold shadow-sm">
                        {(row.original.vendedor || 'V')[0].toUpperCase()}
                    </div>
                    <span className="font-semibold text-gray-900">{row.original.vendedor}</span>
                </div>
            )
        },
        {
            accessorKey: 'total_ventas',
            header: 'N° Ventas',
            cell: ({ row }) => <span className="font-semibold">{row.original.total_ventas}</span>
        },
        {
            accessorKey: 'ticket_promedio',
            header: 'Ticket Prom.',
            cell: ({ row }) => <span className="text-gray-600">S/. {parseFloat(row.original.ticket_promedio).toFixed(2)}</span>
        },
        {
            accessorKey: 'monto_total',
            header: 'Total Vendido',
            cell: ({ row }) => <span className="font-bold text-red-700">S/. {parseFloat(row.original.monto_total).toLocaleString('es-PE', { minimumFractionDigits: 2 })}</span>
        },
    ];

    const stockBajoColumns = [
        {
            accessorKey: 'nombre',
            header: 'Producto',
            cell: ({ row }) => (
                <div className="flex items-center gap-2">
                    {row.original.urgente
                        ? <span className="w-2.5 h-2.5 rounded-full bg-red-500 animate-pulse flex-shrink-0" />
                        : <span className="w-2.5 h-2.5 rounded-full bg-yellow-400 flex-shrink-0" />
                    }
                    <span className="font-medium text-gray-900 truncate max-w-[200px]">{row.original.nombre}</span>
                </div>
            )
        },
        { accessorKey: 'codigo', header: 'Código' },
        {
            accessorKey: 'cantidad',
            header: 'Stock Actual',
            cell: ({ row }) => (
                <span className={`font-bold ${row.original.urgente ? 'text-red-600' : 'text-yellow-600'}`}>
                    {row.original.cantidad}
                </span>
            )
        },
        {
            accessorKey: 'stock_minimo',
            header: 'Stock Mínimo',
            cell: ({ row }) => <span className="text-gray-500">{row.original.stock_minimo}</span>
        },
        {
            accessorKey: 'diferencia',
            header: 'Diferencia',
            cell: ({ row }) => (
                <span className={`font-semibold ${row.original.diferencia < 0 ? 'text-red-600' : 'text-yellow-600'}`}>
                    {row.original.diferencia}
                </span>
            )
        },
    ];

    const renderTabContent = () => {
        switch (activeTab) {
            case 'resumen':
                return (
                    <>
                        {/* KPIs */}
                        {stats && (
                            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                                <KPICard
                                    title="Ventas Totales"
                                    value={`S/. ${(parseFloat(stats.ventas_totales) || 0).toFixed(2)}`}
                                    change={stats.ventas_cambio || 0}
                                    icon={DollarSign}
                                />
                                <KPICard
                                    title="Ingresos Netos"
                                    value={`S/. ${(parseFloat(stats.ingresos_netos) || 0).toFixed(2)}`}
                                    change={stats.ingresos_cambio || 0}
                                    icon={TrendingUp}
                                />
                                <KPICard
                                    title="Ticket Promedio"
                                    value={`S/. ${(parseFloat(stats.ticket_promedio) || 0).toFixed(2)}`}
                                    change={stats.ticket_cambio || 0}
                                    icon={ShoppingCart}
                                />
                                <KPICard
                                    title="Transacciones"
                                    value={parseInt(stats.total_transacciones) || 0}
                                    change={stats.transacciones_cambio || 0}
                                    icon={Users}
                                />
                            </div>
                        )}

                        {/* Charts */}
                        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                            {ventasPorDia.length > 0 && <VentasPorDiaChart data={ventasPorDia} />}
                            {metodosPago.length > 0 && <MetodosPagoChart data={metodosPago} />}
                            {ingresosEgresos.length > 0 && <IngresosEgresosChart data={ingresosEgresos} />}
                            {topProductos.length > 0 && <TopProductosChart data={topProductos} />}
                        </div>

                        {/* Tables */}
                        <div className="space-y-6">
                            {ultimasTransacciones.length > 0 && (
                                <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
                                    <div className="p-6 border-b border-gray-100">
                                        <h3 className="text-lg font-bold text-gray-900">Últimas Transacciones</h3>
                                        <p className="text-sm text-gray-400 mt-0.5">Movimientos recientes del sistema</p>
                                    </div>
                                    <DataTable
                                        columns={transaccionesColumns}
                                        data={ultimasTransacciones}
                                        pageSize={5}
                                    />
                                </div>
                            )}

                            {cajasPendientes.length > 0 && (
                                <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
                                    <div className="p-6 border-b border-gray-100">
                                        <h3 className="text-lg font-bold text-gray-900">Cajas Pendientes de Validación</h3>
                                        <p className="text-sm text-gray-400 mt-0.5">Requieren revisión del administrador</p>
                                    </div>
                                    <DataTable
                                        columns={cajasPendientesColumns}
                                        data={cajasPendientes}
                                        pageSize={5}
                                    />
                                </div>
                            )}
                        </div>
                    </>
                );

            case 'rentabilidad':
                return (
                    <div className="space-y-6">
                        {/* KPIs de Rentabilidad */}
                        {rentabilidadResumen && (
                            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <KPICard
                                    title="Total Ingresos (Periodo)"
                                    value={`S/. ${(rentabilidadResumen.total_ingresos || 0).toLocaleString('es-PE', { minimumFractionDigits: 2 })}`}
                                    icon={DollarSign}
                                />
                                <KPICard
                                    title="Ganancia Bruta"
                                    value={`S/. ${(rentabilidadResumen.total_ganancia || 0).toLocaleString('es-PE', { minimumFractionDigits: 2 })}`}
                                    icon={TrendingUp}
                                />
                                <div className="bg-white rounded-2xl border border-gray-100 p-6 shadow-sm hover:shadow-lg hover:shadow-green-100/50 transition-all duration-300 group">
                                    <div className="flex items-start justify-between">
                                        <div>
                                            <p className="text-sm font-medium text-gray-500 uppercase tracking-wide">Margen General</p>
                                            <p className={`text-3xl font-extrabold mt-2 ${rentabilidadResumen.margen_general >= 30 ? 'text-green-600' : rentabilidadResumen.margen_general >= 15 ? 'text-yellow-600' : 'text-red-600'}`}>
                                                {(rentabilidadResumen.margen_general || 0).toFixed(1)}%
                                            </p>
                                            <p className="text-xs text-gray-400 mt-1">
                                                {rentabilidadResumen.margen_general >= 30 ? '✅ Excelente' : rentabilidadResumen.margen_general >= 15 ? '⚠️ Aceptable' : '🔴 Bajo — revisar costos'}
                                            </p>
                                        </div>
                                        <div className="p-3 rounded-xl bg-gradient-to-br from-green-500 to-green-600 text-white shadow-md">
                                            <BarChart2 className="h-5 w-5" />
                                        </div>
                                    </div>
                                    <div className="mt-4 h-1 w-full bg-gradient-to-r from-green-500 via-green-400 to-green-200 rounded-full opacity-40 group-hover:opacity-70 transition-opacity duration-300" />
                                </div>
                            </div>
                        )}

                        {/* Charts */}
                        {rentabilidad.length > 0 && (
                            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                <RentabilidadChart data={rentabilidad} />
                                <GananciaVsIngresoChart data={rentabilidad.slice(0, 10)} />
                            </div>
                        )}

                        {/* Tabla de Rentabilidad */}
                        {rentabilidad.length > 0 && (
                            <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
                                <div className="p-6 border-b border-gray-100">
                                    <h3 className="text-lg font-bold text-gray-900">Detalle de Rentabilidad por Producto</h3>
                                    <p className="text-sm text-gray-400 mt-0.5">
                                        🟢 Margen ≥30% &nbsp;|&nbsp; 🟡 Margen 15–30% &nbsp;|&nbsp; 🔴 Margen &lt;15%
                                    </p>
                                </div>
                                <DataTable columns={rentabilidadColumns} data={rentabilidad} pageSize={10} />
                            </div>
                        )}

                        {rentabilidad.length === 0 && (
                            <div className="flex flex-col items-center justify-center py-16 text-gray-400">
                                <BarChart2 className="h-12 w-12 mb-3 opacity-30" />
                                <p className="font-medium">No hay datos de rentabilidad para este período</p>
                                <p className="text-sm mt-1">Asegúrate de que los productos tengan costo registrado</p>
                            </div>
                        )}
                    </div>
                );

            case 'clientes':
                return (
                    <div className="space-y-6">
                        {topClientes.length > 0 ? (
                            <>
                                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                                    <KPICard
                                        title="Clientes Únicos (Periodo)"
                                        value={topClientes.length}
                                        icon={UserCheck}
                                    />
                                    <KPICard
                                        title="Mayor Comprador"
                                        value={topClientes[0]?.nombre?.split(' ')[0] ?? '-'}
                                        icon={Users}
                                    />
                                    <KPICard
                                        title="Compra Máxima (Cliente #1)"
                                        value={`S/. ${(topClientes[0]?.monto_total || 0).toLocaleString('es-PE', { minimumFractionDigits: 2 })}`}
                                        icon={DollarSign}
                                    />
                                </div>

                                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                    <TopClientesChart data={topClientes} />
                                    {/* Ranking visual */}
                                    <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-6">
                                        <h3 className="text-lg font-bold text-gray-900 mb-1">Ranking de Clientes</h3>
                                        <p className="text-sm text-gray-400 mb-4">Top clientes por monto acumulado</p>
                                        <div className="space-y-3">
                                            {topClientes.slice(0, 8).map((c, i) => {
                                                const maxMonto = topClientes[0]?.monto_total || 1;
                                                const pct = ((c.monto_total / maxMonto) * 100).toFixed(0);
                                                return (
                                                    <div key={i} className="space-y-1">
                                                        <div className="flex items-center justify-between">
                                                            <div className="flex items-center gap-2">
                                                                <span className="w-5 h-5 rounded-full bg-gradient-to-br from-red-500 to-red-600 text-white text-[10px] font-bold flex items-center justify-center">{i + 1}</span>
                                                                <span className="text-sm font-medium text-gray-700 truncate max-w-[160px]">{c.nombre}</span>
                                                            </div>
                                                            <span className="text-sm font-bold text-red-700">S/. {parseFloat(c.monto_total).toLocaleString('es-PE', { minimumFractionDigits: 2 })}</span>
                                                        </div>
                                                        <div className="w-full h-1.5 bg-gray-100 rounded-full overflow-hidden">
                                                            <div className="h-full rounded-full bg-gradient-to-r from-red-600 to-red-400 transition-all duration-500" style={{ width: `${pct}%` }} />
                                                        </div>
                                                    </div>
                                                );
                                            })}
                                        </div>
                                    </div>
                                </div>

                                <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
                                    <div className="p-6 border-b border-gray-100">
                                        <h3 className="text-lg font-bold text-gray-900">Detalle de Clientes</h3>
                                        <p className="text-sm text-gray-400 mt-0.5">Historial de compras por cliente en el período</p>
                                    </div>
                                    <DataTable columns={clientesColumns} data={topClientes} pageSize={10} />
                                </div>
                            </>
                        ) : (
                            <div className="flex flex-col items-center justify-center py-12 text-gray-400">
                                <UserCheck className="h-10 w-10 mb-2 opacity-30" />
                                <p className="text-sm font-medium">No hay datos de clientes para este período</p>
                            </div>
                        )}

                        {/* Equipo de Vendedores */}
                        {vendedores.length > 0 && (
                            <div className="pt-6 border-t border-gray-100 space-y-4">
                                <h2 className="text-sm font-bold text-gray-700 flex items-center gap-2">
                                    <Users className="h-4 w-4 text-red-600" /> Rendimiento del Equipo
                                </h2>
                                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                    <VendedoresChart data={vendedores} />
                                    {ventasPorHora.length > 0 && <VentasPorHoraChart data={ventasPorHora} />}
                                </div>
                                <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
                                    <div className="p-4 border-b border-gray-100">
                                        <h3 className="text-sm font-bold text-gray-900">Rendimiento por Vendedor</h3>
                                        <p className="text-xs text-gray-400 mt-0.5">Métricas individuales en el período</p>
                                    </div>
                                    <DataTable columns={vendedoresColumns} data={vendedores} pageSize={10} />
                                </div>
                            </div>
                        )}
                    </div>
                );

            case 'productos':
                return (
                    <div className="space-y-8">
                        {/* Top Productos */}
                        {topProductos.length > 0 && (
                            <div className="space-y-4">
                                <h2 className="text-sm font-bold text-gray-700 flex items-center gap-2">
                                    <Package className="h-4 w-4 text-red-600" /> Top Productos
                                </h2>
                                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                    <TopProductosChart data={topProductos} />
                                    <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
                                        <div className="p-4 border-b border-gray-100">
                                            <h3 className="text-sm font-bold text-gray-900">Ranking de Productos</h3>
                                        </div>
                                        <DataTable columns={productosTableColumns} data={topProductos} pageSize={8} />
                                    </div>
                                </div>
                            </div>
                        )}

                        {/* Categorías */}
                        {topCategorias.length > 0 && (
                            <div className="space-y-4 pt-4 border-t border-gray-100">
                                <h2 className="text-sm font-bold text-gray-700 flex items-center gap-2">
                                    <Layers className="h-4 w-4 text-red-600" /> Categorías
                                </h2>
                                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                    <TopCategoriasChart data={topCategorias} />
                                    <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
                                        <div className="p-4 border-b border-gray-100">
                                            <h3 className="text-sm font-bold text-gray-900">Detalle por Categoría</h3>
                                        </div>
                                        <DataTable columns={categoriasTableColumns} data={topCategorias} pageSize={8} />
                                    </div>
                                </div>
                            </div>
                        )}

                        {/* Marcas */}
                        {topMarcas.length > 0 && (
                            <div className="space-y-4 pt-4 border-t border-gray-100">
                                <h2 className="text-sm font-bold text-gray-700 flex items-center gap-2">
                                    <Tag className="h-4 w-4 text-red-600" /> Marcas
                                </h2>
                                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                    <TopMarcasChart data={topMarcas} />
                                    <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
                                        <div className="p-4 border-b border-gray-100">
                                            <h3 className="text-sm font-bold text-gray-900">Detalle por Marca</h3>
                                        </div>
                                        <DataTable columns={categoriasTableColumns} data={topMarcas} pageSize={8} />
                                    </div>
                                </div>
                            </div>
                        )}

                        {/* Mejores Días */}
                        {topFechas.length > 0 && (
                            <div className="space-y-4 pt-4 border-t border-gray-100">
                                <h2 className="text-sm font-bold text-gray-700 flex items-center gap-2">
                                    <CalendarDays className="h-4 w-4 text-red-600" /> Mejores Días
                                </h2>
                                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                    <TopFechasChart data={topFechas} />
                                    <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
                                        <div className="p-4 border-b border-gray-100">
                                            <h3 className="text-sm font-bold text-gray-900">Días con Mayor Facturación</h3>
                                        </div>
                                        <DataTable columns={fechasTableColumns} data={topFechas} pageSize={8} />
                                    </div>
                                </div>
                            </div>
                        )}

                        {topProductos.length === 0 && topCategorias.length === 0 && (
                            <div className="flex flex-col items-center justify-center py-12 text-gray-400">
                                <Package className="h-10 w-10 mb-2 opacity-30" />
                                <p className="text-sm font-medium">No hay datos de productos para este período</p>
                            </div>
                        )}
                    </div>
                );

            case 'inventario':
                return (
                    <div className="space-y-6">
                        {stockBajo.length > 0 ? (
                            <>
                                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                                    <KPICard title="Total con Stock Bajo" value={stockBajoTotal} icon={AlertTriangle} />
                                    <KPICard title="Urgentes (Stock = 0)" value={stockBajo.filter(p => p.urgente).length} icon={AlertTriangle} />
                                    <KPICard title="Advertencia" value={stockBajo.filter(p => !p.urgente).length} icon={Package} />
                                </div>
                                <div className="bg-white rounded-2xl border border-red-100 shadow-sm overflow-hidden">
                                    <div className="p-4 border-b border-red-100 bg-red-50/40 flex items-center gap-3">
                                        <AlertTriangle className="h-4 w-4 text-red-600" />
                                        <div>
                                            <h3 className="text-sm font-bold text-gray-900">Productos con Stock Bajo</h3>
                                            <p className="text-xs text-red-500">{stockBajo.filter(p => p.urgente).length} urgentes · {stockBajo.length} total</p>
                                        </div>
                                    </div>
                                    <DataTable columns={stockBajoColumns} data={stockBajo} pageSize={15} />
                                </div>
                            </>
                        ) : (
                            <div className="flex flex-col items-center justify-center py-16 text-gray-400">
                                <Package className="h-12 w-12 mb-3 opacity-30" />
                                <p className="font-medium">Todos los productos tienen stock suficiente</p>
                                <p className="text-sm mt-1">No hay alertas de inventario pendientes</p>
                            </div>
                        )}
                    </div>
                );

            default:
                return null;
        }
    };

    return (
        <div className="space-y-6">
            {/* Header */}
            <div>
                <h1 className="text-3xl font-extrabold text-gray-900 tracking-tight">Dashboard</h1>
                <p className="text-gray-400 mt-1">Resumen ejecutivo de tu negocio</p>
            </div>

            {/* Filtros */}
            <DashboardFilters
                filters={filters}
                setFilters={setFilters}
                setPeriodo={setPeriodo}
                loading={loading}
            />

            {/* Tabs Navigation */}
            <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-1.5">
                <nav className="flex gap-1 overflow-x-auto" aria-label="Dashboard tabs">
                    {TABS.map((tab) => {
                        const isActive = activeTab === tab.id;
                        const TabIcon = tab.icon;
                        return (
                            <button
                                key={tab.id}
                                onClick={() => setActiveTab(tab.id)}
                                className={`
                                    flex items-center gap-2 px-4 py-2.5 rounded-xl text-sm font-semibold
                                    whitespace-nowrap transition-all duration-200 ease-out
                                    ${isActive
                                        ? 'bg-gradient-to-r from-red-600 to-red-500 text-white shadow-md shadow-red-200'
                                        : 'text-gray-500 hover:text-red-600 hover:bg-red-50/50'
                                    }
                                `}
                            >
                                <TabIcon className="h-4 w-4" />
                                {tab.label}
                                {/* Badge para stock bajo en tab Vendedores */}
                                {tab.id === 'inventario' && stockBajoTotal > 0 && (
                                    <span className={`px-1.5 py-0.5 rounded-full text-[10px] font-bold ${isActive ? 'bg-white/30 text-white' : 'bg-red-500 text-white'}`}>
                                        {stockBajoTotal}
                                    </span>
                                )}
                            </button>
                        );
                    })}
                </nav>
            </div>

            {/* Loading Indicator */}
            {loading && (
                <div className="flex justify-center py-12">
                    <div className="flex items-center gap-3">
                        <div className="w-6 h-6 border-3 border-red-200 border-t-red-600 rounded-full animate-spin" />
                        <span className="text-sm text-gray-400 font-medium">Cargando datos...</span>
                    </div>
                </div>
            )}

            {/* Tab Content */}
            {!loading && (
                <div className="space-y-6">
                    {renderTabContent()}
                </div>
            )}
        </div>
    );
}
