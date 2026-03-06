import { useState } from "react";
import MainLayout from "../../Layout/MainLayout";
import { DataTable } from "@/components/ui/data-table";
import { Button } from "@/components/ui/button";
import { Loader2, Filter, X, ArrowLeft } from "lucide-react";
import { baseUrl } from "@/lib/baseUrl";
import { useMovimientosStock } from "./hooks/useMovimientosStock";
import { getMovimientosColumns } from "./columns/movimientosColumns";

export default function MovimientosStockList() {
    const { movimientos, loading, error, filtros, aplicarFiltros, limpiarFiltros, refetch } = useMovimientosStock();
    const [mostrarFiltros, setMostrarFiltros] = useState(false);

    const columns = getMovimientosColumns();

    const tienesFiltrosActivos = Object.values(filtros).some((v) => v !== "");

    return (
        <MainLayout>
            <div className="space-y-4">
                {/* Header */}
                <div className="flex items-center justify-between">
                    <div>
                        <div className="flex items-center gap-3">
                            <a href={baseUrl("/productos")} className="text-gray-500 hover:text-gray-700">
                                <ArrowLeft className="h-5 w-5" />
                            </a>
                            <div>
                                <h2 className="text-2xl font-bold tracking-tight">Historial de Movimientos</h2>
                                <p className="text-muted-foreground text-sm">
                                    Registro de entradas, salidas y ajustes de stock
                                </p>
                            </div>
                        </div>
                    </div>
                    <div className="flex items-center gap-2">
                        <Button
                            variant="outline"
                            size="sm"
                            onClick={() => setMostrarFiltros(!mostrarFiltros)}
                            className="gap-2"
                        >
                            <Filter className="h-4 w-4" />
                            Filtros
                            {tienesFiltrosActivos && (
                                <span className="h-2 w-2 rounded-full bg-blue-500" />
                            )}
                        </Button>
                    </div>
                </div>

                {/* Filtros */}
                {mostrarFiltros && (
                    <div className="bg-white border rounded-lg p-4 space-y-3">
                        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-3">
                            <div>
                                <label className="text-xs font-medium text-gray-600 mb-1 block">Tipo</label>
                                <select
                                    className="w-full border rounded-md px-2 py-1.5 text-sm"
                                    value={filtros.tipo_movimiento}
                                    onChange={(e) => aplicarFiltros({ tipo_movimiento: e.target.value })}
                                >
                                    <option value="">Todos</option>
                                    <option value="entrada">Entrada</option>
                                    <option value="salida">Salida</option>
                                    <option value="ajuste">Ajuste</option>
                                    <option value="devolucion">Devolución</option>
                                </select>
                            </div>
                            <div>
                                <label className="text-xs font-medium text-gray-600 mb-1 block">Origen</label>
                                <select
                                    className="w-full border rounded-md px-2 py-1.5 text-sm"
                                    value={filtros.tipo_documento}
                                    onChange={(e) => aplicarFiltros({ tipo_documento: e.target.value })}
                                >
                                    <option value="">Todos</option>
                                    <option value="venta">Venta</option>
                                    <option value="compra">Compra</option>
                                    <option value="anulacion_venta">Anulación Venta</option>
                                    <option value="anulacion_compra">Anulación Compra</option>
                                    <option value="descuento_almacen">Desc. Almacén Real</option>
                                </select>
                            </div>
                            <div>
                                <label className="text-xs font-medium text-gray-600 mb-1 block">Almacén</label>
                                <select
                                    className="w-full border rounded-md px-2 py-1.5 text-sm"
                                    value={filtros.id_almacen}
                                    onChange={(e) => aplicarFiltros({ id_almacen: e.target.value })}
                                >
                                    <option value="">Todos</option>
                                    <option value="1">Facturación</option>
                                    <option value="2">Almacén Real</option>
                                </select>
                            </div>
                            <div>
                                <label className="text-xs font-medium text-gray-600 mb-1 block">Desde</label>
                                <input
                                    type="date"
                                    className="w-full border rounded-md px-2 py-1.5 text-sm"
                                    value={filtros.fecha_desde}
                                    onChange={(e) => aplicarFiltros({ fecha_desde: e.target.value })}
                                />
                            </div>
                            <div>
                                <label className="text-xs font-medium text-gray-600 mb-1 block">Hasta</label>
                                <input
                                    type="date"
                                    className="w-full border rounded-md px-2 py-1.5 text-sm"
                                    value={filtros.fecha_hasta}
                                    onChange={(e) => aplicarFiltros({ fecha_hasta: e.target.value })}
                                />
                            </div>
                            <div className="flex items-end">
                                {tienesFiltrosActivos && (
                                    <Button
                                        variant="ghost"
                                        size="sm"
                                        onClick={limpiarFiltros}
                                        className="gap-1 text-gray-500"
                                    >
                                        <X className="h-4 w-4" />
                                        Limpiar
                                    </Button>
                                )}
                            </div>
                        </div>
                    </div>
                )}

                {/* Tabla */}
                {loading ? (
                    <div className="flex justify-center items-center py-20">
                        <Loader2 className="h-8 w-8 animate-spin text-primary" />
                    </div>
                ) : error ? (
                    <div className="text-center py-20">
                        <p className="text-red-500 mb-2">{error}</p>
                        <Button variant="outline" size="sm" onClick={refetch}>
                            Reintentar
                        </Button>
                    </div>
                ) : (
                    <DataTable
                        columns={columns}
                        data={movimientos}
                        searchable={true}
                        searchPlaceholder="Buscar por producto, código o documento..."
                        pagination={true}
                        pageSize={20}
                    />
                )}

                {/* Resumen */}
                {!loading && !error && (
                    <div className="text-xs text-gray-500 text-right">
                        {movimientos.length} movimiento{movimientos.length !== 1 ? "s" : ""} encontrado{movimientos.length !== 1 ? "s" : ""}
                    </div>
                )}
            </div>
        </MainLayout>
    );
}
