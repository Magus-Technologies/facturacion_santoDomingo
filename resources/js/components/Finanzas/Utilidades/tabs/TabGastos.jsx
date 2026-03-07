import { useState, useMemo } from 'react';
import { TrendingDown, AlertCircle, TrendingUp, Wallet, Search, X, LayoutGrid, List } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Card, CardContent } from '@/components/ui/card';

import {
    FilterBar,
    ProgressBar,
    TableCard,
    TableHeader,
    useSort
} from '../components/SharedUI';
import { KpiStrip } from '../components/KpiCard';
import { fmt, pct, mono } from '../utils/formatters';

export function TabGastos({ data, kpis }) {
    const gastos = data?.gastos_detalle ?? [];
    const [view, setView] = useState('table'); // 'grid' o 'table'
    const [search, setSearch] = useState('');
    const [orden, setOrden] = useState('total_desc');

    const resetAll = () => {
        setSearch('');
        setOrden('total_desc');
    };

    const filtered = useMemo(() => {
        let d = [...gastos];
        if (search) d = d.filter(r => (r.concepto ?? '').toLowerCase().includes(search.toLowerCase()));
        return d;
    }, [gastos, search]);

    // Hook de ordenamiento para la tabla
    const { sorted, sort, onSort } = useSort(filtered, 'total', 'desc');

    // Datos ordenados para la vista GRID (usa el select de orden)
    const gridSorted = useMemo(() => {
        return [...filtered].sort((a, b) => orden === 'total_desc' ? b.total - a.total : a.total - b.total);
    }, [filtered, orden]);

    const totalGastos = kpis?.gastos ?? 0;
    const ratioPct = (kpis?.ingresos ?? 0) > 0 ? (totalGastos / kpis.ingresos) * 100 : 0;
    const eficiencia = totalGastos > 0 ? ((kpis?.ingresos ?? 0) / totalGastos).toFixed(1) + 'x' : '∞';

    return (
        <div className="space-y-6">
            <KpiStrip items={[
                { label: 'Total Gastos', value: fmt(totalGastos), color: 'text-red-700', icon: TrendingDown },
                { label: '% sobre Ventas', value: pct(ratioPct), color: 'text-amber-700', icon: AlertCircle },
                { label: 'Ratio Eficiencia', value: eficiencia, color: 'text-green-700', icon: TrendingUp },
                { label: 'Conceptos', value: String(gastos.length), color: 'text-gray-900', icon: Wallet },
            ]} />

            <FilterBar>
                <div className="flex bg-gray-100 p-1 rounded-lg mr-2">
                    <button
                        onClick={() => setView('table')}
                        className={`p-2 rounded-md transition-all ${view === 'table' ? 'bg-white shadow-sm text-primary-600' : 'text-gray-500 hover:text-gray-700'}`}
                        title="Vista Tabla"
                    >
                        <List className="h-4 w-4" />
                    </button>
                    <button
                        onClick={() => setView('grid')}
                        className={`p-2 rounded-md transition-all ${view === 'grid' ? 'bg-white shadow-sm text-primary-600' : 'text-gray-500 hover:text-gray-700'}`}
                        title="Vista Cuadrícula"
                    >
                        <LayoutGrid className="h-4 w-4" />
                    </button>
                </div>

                <div className="relative flex-1 max-w-xs">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                    <Input
                        placeholder="Buscar concepto..."
                        value={search}
                        onChange={(e) => setSearch(e.target.value)}
                        className="pl-10"
                    />
                </div>

                {view === 'grid' && (
                    <Select value={orden} onValueChange={setOrden}>
                        <SelectTrigger className="w-40">
                            <SelectValue placeholder="Ordenar..." />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value="total_desc">Monto ↓</SelectItem>
                            <SelectItem value="total_asc">Monto ↑</SelectItem>
                        </SelectContent>
                    </Select>
                )}

                <Button variant="ghost" size="sm" onClick={resetAll} className="ml-auto">
                    <X className="h-4 w-4 mr-1" /> Limpiar
                </Button>
            </FilterBar>

            {view === 'grid' ? (
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    {gridSorted.map((g, i) => {
                        const impacto = (kpis?.ingresos ?? 0) > 0 ? (g.total / kpis.ingresos) * 100 : 0;
                        return (
                            <Card key={i} className={`border-l-4 ${impacto > 3 ? 'border-l-red-500' : impacto > 1 ? 'border-l-amber-500' : 'border-l-gray-300'} border-gray-200`}>
                                <CardContent className="pt-6">
                                    <div className="space-y-4">
                                        <div>
                                            <h3 className="font-semibold text-gray-900">{g.concepto || 'Sin concepto'}</h3>
                                            <p className="text-xs text-gray-500 mt-1">{g.num_movimientos} movimientos</p>
                                        </div>
                                        <div className="space-y-2">
                                            <div className="flex justify-between items-center">
                                                <span className="text-xs text-gray-600">Monto</span>
                                                <span className="font-mono text-sm font-bold text-red-700">{mono(g.total)}</span>
                                            </div>
                                            <div className="flex justify-between items-center">
                                                <span className="text-xs text-gray-600">% del total</span>
                                                <span className="font-mono text-sm text-gray-700">{pct(g.porcentaje)}</span>
                                            </div>
                                            <div className="flex justify-between items-center">
                                                <span className="text-xs text-gray-600">Impacto</span>
                                                <span className={`font-mono text-sm font-semibold ${impacto > 3 ? 'text-red-700' : impacto > 1 ? 'text-amber-700' : 'text-gray-600'}`}>
                                                    -{pct(impacto)} pp
                                                </span>
                                            </div>
                                        </div>
                                        <div className="pt-2 border-t border-gray-200">
                                            <ProgressBar value={g.porcentaje} max={100} color={impacto > 3 ? 'bg-red-500' : impacto > 1 ? 'bg-amber-500' : 'bg-gray-400'} />
                                        </div>
                                    </div>
                                </CardContent>
                            </Card>
                        );
                    })}
                </div>
            ) : (
                <TableCard title="Detalle de Gastos Operativos" count={sorted.length} total={gastos.length}>
                    <div className="overflow-x-auto">
                        <table className="w-full">
                            <thead>
                                <tr>
                                    <TableHeader col="concepto" sort={sort} onSort={onSort}>Concepto / Gasto</TableHeader>
                                    <TableHeader col="num_movimientos" sort={sort} onSort={onSort} right>Movimientos</TableHeader>
                                    <TableHeader col="total" sort={sort} onSort={onSort} right>Monto Total</TableHeader>
                                    <TableHeader col="porcentaje" sort={sort} onSort={onSort} right>% del Total</TableHeader>
                                    <TableHeader right>Impacto Ventas</TableHeader>
                                </tr>
                            </thead>
                            <tbody>
                                {sorted.length === 0 && (
                                    <tr><td colSpan={5} className="text-center py-12 text-gray-500">Sin gastos registrados</td></tr>
                                )}
                                {sorted.map((g, i) => {
                                    const impacto = (kpis?.ingresos ?? 0) > 0 ? (g.total / kpis.ingresos) * 100 : 0;
                                    return (
                                        <tr key={i} className="border-t border-gray-100 hover:bg-gray-50 transition-colors">
                                            <td className="px-4 py-3 font-medium text-gray-900">{g.concepto || 'Sin concepto'}</td>
                                            <td className="px-4 py-3 text-right text-sm text-gray-600">{g.num_movimientos}</td>
                                            <td className="px-4 py-3 text-right font-mono text-sm font-bold text-red-700">{mono(g.total)}</td>
                                            <td className="px-4 py-3 text-right font-mono text-sm text-gray-700">{pct(g.porcentaje)}</td>
                                            <td className="px-4 py-3 w-48">
                                                <div className="flex items-center gap-2 justify-end">
                                                    <span className={`text-xs font-semibold ${impacto > 3 ? 'text-red-700' : impacto > 1 ? 'text-amber-700' : 'text-gray-600'}`}>
                                                        -{pct(impacto)}
                                                    </span>
                                                    <div className="w-24 h-1.5 bg-gray-100 rounded-full overflow-hidden">
                                                        <div
                                                            className={`h-full rounded-full ${impacto > 3 ? 'bg-red-500' : impacto > 1 ? 'bg-amber-500' : 'bg-gray-400'}`}
                                                            style={{ width: `${Math.min(impacto * 10, 100)}%` }}
                                                        />
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    );
                                })}
                            </tbody>
                        </table>
                    </div>
                </TableCard>
            )}
        </div>
    );
}
