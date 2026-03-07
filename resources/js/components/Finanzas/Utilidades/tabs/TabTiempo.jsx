import { Wallet, Package, TrendingDown, TrendingUp } from 'lucide-react';
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card';

import { TableCard, TableHeader, StatusBadge, ProgressBar, useSort } from '../components/SharedUI';
import { KpiStrip } from '../components/KpiCard';
import { fmt, mono } from '../utils/formatters';

export function TabTiempo({ data, kpis }) {
    const items = data?.utilidad_tiempo ?? [];
    const { sorted, sort, onSort } = useSort(items, 'periodo', 'desc');
    const acumulado = items.reduce((s, r) => s + r.utilidad, 0);

    return (
        <div className="space-y-6">
            <KpiStrip items={[
                { label: 'Ventas brutas', value: fmt(kpis?.ingresos), color: 'text-gray-900', icon: Wallet },
                { label: 'Costo productos', value: fmt(kpis?.costo), color: 'text-red-700', icon: Package },
                { label: 'Gastos operativos', value: fmt(kpis?.gastos), color: 'text-amber-700', icon: TrendingDown },
                { label: 'Utilidad acumulada', value: fmt(acumulado), color: acumulado >= 0 ? 'text-green-700' : 'text-red-700', icon: TrendingUp },
            ]} />

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                {/* ── VISUAL: EVOLUCIÓN ── */}
                <Card className="border-gray-200 h-fit">
                    <CardHeader>
                        <CardTitle>Evolución Visual de Utilidades</CardTitle>
                    </CardHeader>
                    <CardContent>
                        <div className="space-y-4">
                            {items.map((item, i) => (
                                <div key={i} className="flex items-center gap-4">
                                    <div className="w-32">
                                        <p className="text-sm font-medium text-gray-900">{item.periodo}</p>
                                    </div>
                                    <div className="flex-1">
                                        <ProgressBar
                                            value={Math.max(item.utilidad, 0)}
                                            max={Math.max(...items.map(it => Math.max(it.utilidad, 0)), 1)}
                                            color={item.utilidad >= 0 ? 'bg-green-500' : 'bg-red-500'}
                                        />
                                    </div>
                                    <div className="w-24 text-right">
                                        <p className={`text-sm font-bold ${item.utilidad >= 0 ? 'text-green-700' : 'text-red-700'}`}>
                                            {fmt(item.utilidad)}
                                        </p>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </CardContent>
                </Card>

                {/* ── TABLA: DETALLE POR PERIODO ── */}
                <TableCard title="Desglose por Periodo" count={sorted.length} total={items.length}>
                    <div className="overflow-x-auto">
                        <table className="w-full">
                            <thead>
                                <tr>
                                    <TableHeader col="periodo" sort={sort} onSort={onSort}>Periodo</TableHeader>
                                    <TableHeader col="num_ventas" sort={sort} onSort={onSort} right>Ventas</TableHeader>
                                    <TableHeader col="ingresos" sort={sort} onSort={onSort} right>Ingresos</TableHeader>
                                    <TableHeader col="costos" sort={sort} onSort={onSort} right>Costos</TableHeader>
                                    <TableHeader col="utilidad" sort={sort} onSort={onSort} right>Utilidad</TableHeader>
                                    <TableHeader right>Margen</TableHeader>
                                </tr>
                            </thead>
                            <tbody>
                                {sorted.length === 0 && (
                                    <tr><td colSpan={6} className="text-center py-12 text-gray-500">Sin datos en este rango</td></tr>
                                )}
                                {sorted.map((row, i) => {
                                    const mg = row.ingresos > 0 ? (row.utilidad / row.ingresos) * 100 : 0;
                                    return (
                                        <tr key={i} className="border-t border-gray-100 hover:bg-gray-50 transition-colors">
                                            <td className="px-4 py-3 font-medium text-gray-900">{row.periodo}</td>
                                            <td className="px-4 py-3 text-right text-sm text-gray-600">{row.num_ventas}</td>
                                            <td className="px-4 py-3 text-right font-mono text-sm text-gray-700">{mono(row.ingresos)}</td>
                                            <td className="px-4 py-3 text-right font-mono text-sm text-gray-600">{mono(row.costos)}</td>
                                            <td className={`px-4 py-3 text-right font-mono text-sm font-bold ${row.utilidad >= 0 ? 'text-green-700' : 'text-red-700'}`}>
                                                {mono(row.utilidad)}
                                            </td>
                                            <td className="px-4 py-3"><StatusBadge value={mg} /></td>
                                        </tr>
                                    );
                                })}
                            </tbody>
                        </table>
                    </div>
                </TableCard>
            </div>
        </div>
    );
}
