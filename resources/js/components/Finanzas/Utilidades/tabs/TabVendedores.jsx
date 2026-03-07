import { useState, useMemo } from 'react';
import { User, TrendingUp, TrendingDown, AlertCircle, Search, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';

import {
    FilterBar,
    FilterChip,
    TableCard,
    TableHeader,
    TableFooter,
    StatusBadge,
    useSort
} from '../components/SharedUI';
import { KpiStrip } from '../components/KpiCard';
import { fmt, pct, mono } from '../utils/formatters';

export function TabVendedores({ data }) {
    const rows = data?.margen_vendedores ?? [];
    const [search, setSearch] = useState('');
    const [chips, setChips] = useState({ ok: true, neg: true });

    const toggle = (k) => setChips(p => ({ ...p, [k]: !p[k] }));
    const resetAll = () => {
        setSearch('');
        setChips({ ok: true, neg: true });
    };

    const filtered = useMemo(() => {
        let d = [...rows];
        if (search) d = d.filter(r => r.vendedor.toLowerCase().includes(search.toLowerCase()));
        const any = Object.values(chips).some(Boolean);
        if (any) d = d.filter(r => (chips.ok && r.utilidad >= 0) || (chips.neg && r.utilidad < 0));
        return d;
    }, [rows, search, chips]);

    const { sorted, sort, onSort } = useSort(filtered, 'utilidad', 'desc');
    const mejor = [...rows].sort((a, b) => b.margen - a.margen)[0];
    const mayorUtil = [...rows].sort((a, b) => b.utilidad - a.utilidad)[0];
    const totalDesc = rows.reduce((s, v) => s + v.descuentos, 0);
    const negCount = rows.filter(v => v.utilidad < 0).length;

    return (
        <div className="space-y-6">
            <KpiStrip items={[
                { label: 'Mejor margen', value: mejor?.vendedor ?? '—', color: 'text-green-700', icon: TrendingUp },
                { label: 'Mayor utilidad', value: mayorUtil?.vendedor ?? '—', color: 'text-blue-700', icon: User },
                { label: 'Total descuentos', value: fmt(totalDesc), color: 'text-amber-700', icon: TrendingDown },
                { label: 'A pérdida', value: String(negCount), color: negCount > 0 ? 'text-red-700' : 'text-green-700', icon: AlertCircle },
            ]} />

            <FilterBar>
                <div className="relative flex-1 max-w-xs">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                    <Input
                        placeholder="Buscar vendedor..."
                        value={search}
                        onChange={(e) => setSearch(e.target.value)}
                        className="pl-10"
                    />
                </div>
                <div className="w-px h-6 bg-gray-200" />
                <FilterChip label="Rentable" variant="success" active={chips.ok} onClick={() => toggle('ok')} />
                <FilterChip label="A pérdida" variant="danger" active={chips.neg} onClick={() => toggle('neg')} />
                <Button variant="ghost" size="sm" onClick={resetAll} className="ml-auto">
                    <X className="h-4 w-4 mr-1" /> Limpiar
                </Button>
            </FilterBar>

            <TableCard title="Margen por Vendedor" count={sorted.length} total={rows.length}>
                <div className="overflow-x-auto">
                    <table className="w-full">
                        <thead>
                            <tr>
                                <TableHeader col="vendedor" sort={sort} onSort={onSort}>Vendedor</TableHeader>
                                <TableHeader col="num_ventas" sort={sort} onSort={onSort} right>Ventas</TableHeader>
                                <TableHeader col="ingresos" sort={sort} onSort={onSort} right>Ingresos</TableHeader>
                                <TableHeader col="costos" sort={sort} onSort={onSort} right>Costos</TableHeader>
                                <TableHeader col="descuentos" sort={sort} onSort={onSort} right>Descuentos</TableHeader>
                                <TableHeader col="utilidad" sort={sort} onSort={onSort} right>Utilidad Neta</TableHeader>
                                <TableHeader col="margen" sort={sort} onSort={onSort}>Margen</TableHeader>
                                <TableHeader col="ticket_prom" sort={sort} onSort={onSort} right>Ticket Prom.</TableHeader>
                            </tr>
                        </thead>
                        <tbody>
                            {sorted.length === 0 && <tr><td colSpan={8} className="text-center py-12 text-gray-500">Sin datos</td></tr>}
                            {sorted.map((v, i) => (
                                <tr key={i} className={`border-t border-gray-100 hover:bg-gray-50 transition-colors ${v.utilidad < 0 ? 'bg-red-50' : ''}`}>
                                    <td className="px-4 py-3 font-medium text-gray-900">{v.vendedor}</td>
                                    <td className="px-4 py-3 text-right font-mono text-sm text-gray-700">{v.num_ventas}</td>
                                    <td className="px-4 py-3 text-right font-mono text-sm text-gray-700">{mono(v.ingresos)}</td>
                                    <td className="px-4 py-3 text-right font-mono text-sm text-gray-600">{mono(v.costos)}</td>
                                    <td className="px-4 py-3 text-right font-mono text-sm text-amber-700">{v.descuentos > 0 ? `-${mono(v.descuentos)}` : '—'}</td>
                                    <td className={`px-4 py-3 text-right font-mono text-sm font-bold ${v.utilidad >= 0 ? 'text-green-700' : 'text-red-700'}`}>{mono(v.utilidad)}</td>
                                    <td className="px-4 py-3"><StatusBadge value={v.margen} /></td>
                                    <td className="px-4 py-3 text-right font-mono text-sm text-gray-700">{mono(v.ticket_prom)}</td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
                {mejor && (
                    <TableFooter items={[
                        { label: 'Mejor margen', value: `${mejor.vendedor} (${pct(mejor.margen)})`, color: 'text-green-700' },
                        { label: 'Mayor utilidad', value: `${mayorUtil?.vendedor ?? '—'} (${fmt(mayorUtil?.utilidad)})`, color: 'text-blue-700' },
                        { label: 'Desc. totales', value: fmt(totalDesc), color: 'text-amber-700' },
                    ]} />
                )}
            </TableCard>
        </div>
    );
}
