import { useState, useMemo } from 'react';
import { Receipt, TrendingUp, AlertCircle, Wallet, Search, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';

import {
    FilterBar,
    FilterChip,
    TableCard,
    TableHeader,
    StatusBadge,
    useSort
} from '../components/SharedUI';
import { KpiStrip } from '../components/KpiCard';
import { fmt, mono } from '../utils/formatters';

export function TabVentas({ data, kpis }) {
    const items = data?.utilidad_ventas ?? [];
    const [search, setSearch] = useState('');
    const [chips, setChips] = useState({ gan: true, per: true });

    const toggle = (k) => setChips(p => ({ ...p, [k]: !p[k] }));
    const resetAll = () => {
        setSearch('');
        setChips({ gan: true, per: true });
    };

    const totalVentas = items.length;
    const ticketProm = totalVentas > 0 ? (kpis?.ingresos ?? 0) / totalVentas : 0;
    const diasNeg = items.filter(r => r.utilidad < 0).length;

    const filtered = useMemo(() => {
        let d = [...items];
        if (search) {
            const lc = search.toLowerCase();
            d = d.filter(r =>
                r.comprobante?.toLowerCase().includes(lc) ||
                r.cliente?.toLowerCase().includes(lc)
            );
        }
        const any = Object.values(chips).some(Boolean);
        if (any) d = d.filter(r => (chips.gan && r.utilidad >= 0) || (chips.per && r.utilidad < 0));
        return d;
    }, [items, search, chips]);

    const { sorted, sort, onSort } = useSort(filtered, 'fecha_emision', 'desc');

    return (
        <div className="space-y-6">
            <KpiStrip items={[
                { label: 'Ticket Promedio', value: fmt(ticketProm), color: 'text-green-700', icon: TrendingUp },
                { label: 'Comprobantes Emitidos', value: totalVentas.toLocaleString(), color: 'text-blue-700', icon: Receipt },
                { label: 'Ingresos Totales', value: fmt(kpis?.ingresos), color: 'text-gray-900', icon: Wallet },
                { label: 'Ventas a pérdida', value: String(diasNeg), color: diasNeg > 0 ? 'text-red-700' : 'text-green-700', icon: AlertCircle },
            ]} />

            <FilterBar>
                <div className="relative flex-1 max-w-xs">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                    <Input
                        placeholder="Buscar comprobante o cliente..."
                        value={search}
                        onChange={(e) => setSearch(e.target.value)}
                        className="pl-10"
                    />
                </div>
                <div className="w-px h-6 bg-gray-200" />
                <FilterChip label="Ganadora" variant="success" active={chips.gan} onClick={() => toggle('gan')} />
                <FilterChip label="A pérdida" variant="danger" active={chips.per} onClick={() => toggle('per')} />
                <Button variant="ghost" size="sm" onClick={resetAll} className="ml-auto">
                    <X className="h-4 w-4 mr-1" /> Limpiar
                </Button>
            </FilterBar>

            <TableCard title="Utilidad por Venta Individual" count={sorted.length} total={items.length}>
                <div className="overflow-x-auto">
                    <table className="w-full">
                        <thead>
                            <tr>
                                <TableHeader col="comprobante" sort={sort} onSort={onSort}>Comprobante</TableHeader>
                                <TableHeader col="fecha_emision" sort={sort} onSort={onSort}>Fecha Emisión</TableHeader>
                                <TableHeader col="cliente" sort={sort} onSort={onSort}>Cliente</TableHeader>
                                <TableHeader col="ingresos" sort={sort} onSort={onSort} right>Venta Bruta</TableHeader>
                                <TableHeader col="costos" sort={sort} onSort={onSort} right>Costo</TableHeader>
                                <TableHeader col="utilidad" sort={sort} onSort={onSort} right>Utilidad</TableHeader>
                                <TableHeader>Margen</TableHeader>
                                <TableHeader right>Tendencia</TableHeader>
                            </tr>
                        </thead>
                        <tbody>
                            {sorted.length === 0 && <tr><td colSpan={8} className="text-center py-12 text-gray-500">Sin comprobantes reportados</td></tr>}
                            {sorted.map((row, i) => {
                                const mg = row.ingresos > 0 ? (row.utilidad / row.ingresos) * 100 : 0;
                                const trDate = new Date(row.fecha_emision).toLocaleDateString();
                                return (
                                    <tr key={i} className={`border-t border-gray-100 hover:bg-gray-50 transition-colors ${row.utilidad < 0 ? 'bg-red-50' : ''}`}>
                                        <td className="px-4 py-3 font-medium text-gray-900">{row.comprobante}</td>
                                        <td className="px-4 py-3 text-sm text-gray-600">{trDate}</td>
                                        <td className="px-4 py-3 text-sm text-gray-700 truncate max-w-[200px]" title={row.cliente}>{row.cliente}</td>
                                        <td className="px-4 py-3 text-right font-mono text-sm text-gray-700">{mono(row.ingresos)}</td>
                                        <td className="px-4 py-3 text-right font-mono text-sm text-gray-600">{mono(row.costos)}</td>
                                        <td className={`px-4 py-3 text-right font-mono text-sm font-bold ${row.utilidad >= 0 ? 'text-green-700' : 'text-red-700'}`}>{mono(row.utilidad)}</td>
                                        <td className="px-4 py-3"><StatusBadge value={mg} /></td>
                                        <td className={`px-4 py-3 text-right text-lg font-bold ${row.utilidad >= 0 ? 'text-green-600' : 'text-red-600'}`}>{row.utilidad >= 0 ? '↑' : '↓'}</td>
                                    </tr>
                                );
                            })}
                        </tbody>
                    </table>
                </div>
            </TableCard>
        </div>
    );
}
