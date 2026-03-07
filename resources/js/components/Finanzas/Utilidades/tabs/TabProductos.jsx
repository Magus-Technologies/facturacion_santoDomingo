import { useState, useMemo } from 'react';
import { Package, Receipt, TrendingUp, TrendingDown, Search, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';

import {
    FilterBar,
    FilterChip,
    TableCard,
    TableHeader,
    TableFooter,
    StatusBadge,
    ProgressBar,
    useSort
} from '../components/SharedUI';
import { KpiStrip } from '../components/KpiCard';
import { fmt, mono, pct } from '../utils/formatters';

export function TabProductos({ data, kpis }) {
    const rows = data?.rentabilidad_productos ?? [];
    const categorias = [...new Set(rows.map(r => r.categoria))].filter(Boolean);
    const [search, setSearch] = useState('');
    const [cat, setCat] = useState('all');
    const [chips, setChips] = useState({ alto: true, medio: true, bajo: true });

    const toggle = (k) => setChips(p => ({ ...p, [k]: !p[k] }));
    const resetAll = () => {
        setSearch('');
        setCat('all');
        setChips({ alto: true, medio: true, bajo: true });
    };

    const filtered = useMemo(() => {
        let d = [...rows];
        if (search) d = d.filter(r => r.producto.toLowerCase().includes(search.toLowerCase()));
        if (cat !== 'all') d = d.filter(r => r.categoria === cat);
        const any = Object.values(chips).some(Boolean);
        if (any) d = d.filter(r => {
            const m = parseFloat(r.margen);
            return (chips.alto && m >= 55) || (chips.medio && m >= 30 && m < 55) || (chips.bajo && m < 30);
        });
        return d;
    }, [rows, search, cat, chips]);

    const { sorted, sort, onSort } = useSort(filtered, 'utilidad_total', 'desc');
    const mejor = [...rows].sort((a, b) => b.margen - a.margen)[0];
    const peor = [...rows].sort((a, b) => a.margen - b.margen)[0];

    return (
        <div className="space-y-6">
            <KpiStrip items={[
                { label: 'Utilidad Neta', value: fmt(kpis?.utilidad), color: (kpis?.utilidad ?? 0) >= 0 ? 'text-green-700' : 'text-red-700', trend: kpis?.cambio_utilidad, icon: TrendingUp },
                { label: 'Ingresos', value: fmt(kpis?.ingresos), color: 'text-blue-700', trend: kpis?.cambio_ingresos, icon: Receipt },
                { label: 'Costo Total', value: fmt(kpis?.costo), color: 'text-gray-700', icon: Package },
                { label: 'Margen Promedio', value: pct(kpis?.margen), color: 'text-gray-900', icon: TrendingUp },
            ]} />

            <FilterBar>
                <div className="relative flex-1 max-w-xs">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                    <Input
                        placeholder="Buscar producto..."
                        value={search}
                        onChange={(e) => setSearch(e.target.value)}
                        className="pl-10"
                    />
                </div>
                <Select value={cat} onValueChange={setCat}>
                    <SelectTrigger className="w-48">
                        <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                        <SelectItem value="all">Todas las categorías</SelectItem>
                        {categorias.map(c => (
                            <SelectItem key={c} value={c}>{c}</SelectItem>
                        ))}
                    </SelectContent>
                </Select>
                <div className="w-px h-6 bg-gray-200" />
                <FilterChip label="Alto ≥55%" variant="success" active={chips.alto} onClick={() => toggle('alto')} />
                <FilterChip label="Medio 30–55%" variant="warning" active={chips.medio} onClick={() => toggle('medio')} />
                <FilterChip label="Bajo <30%" variant="danger" active={chips.bajo} onClick={() => toggle('bajo')} />
                <Button variant="ghost" size="sm" onClick={resetAll} className="ml-auto">
                    <X className="h-4 w-4 mr-1" /> Limpiar
                </Button>
            </FilterBar>

            <TableCard title="Rentabilidad por Producto" count={sorted.length} total={rows.length}>
                <div className="overflow-x-auto">
                    <table className="w-full">
                        <thead>
                            <tr>
                                <TableHeader col="producto" sort={sort} onSort={onSort}>Producto</TableHeader>
                                <TableHeader col="precio_venta" sort={sort} onSort={onSort} right>Precio</TableHeader>
                                <TableHeader col="costo_unitario" sort={sort} onSort={onSort} right>Costo</TableHeader>
                                <TableHeader col="unidades" sort={sort} onSort={onSort} right>Uds.</TableHeader>
                                <TableHeader col="ingreso_total" sort={sort} onSort={onSort} right>Ingresos</TableHeader>
                                <TableHeader col="utilidad_total" sort={sort} onSort={onSort} right>Utilidad</TableHeader>
                                <TableHeader col="margen" sort={sort} onSort={onSort}>Margen</TableHeader>
                                <TableHeader right>Participación</TableHeader>
                            </tr>
                        </thead>
                        <tbody>
                            {sorted.length === 0 && (
                                <tr><td colSpan={8} className="text-center py-12 text-gray-500">Sin resultados</td></tr>
                            )}
                            {sorted.map((row, i) => (
                                <tr key={i} className="border-t border-gray-100 hover:bg-gray-50 transition-colors">
                                    <td className="px-4 py-3">
                                        <div className="font-medium text-gray-900">{row.producto}</div>
                                        <div className="text-xs text-gray-500">{row.categoria}</div>
                                    </td>
                                    <td className="px-4 py-3 text-right font-mono text-sm text-gray-700">{mono(row.precio_venta)}</td>
                                    <td className="px-4 py-3 text-right font-mono text-sm text-gray-600">{mono(row.costo_unitario)}</td>
                                    <td className="px-4 py-3 text-right font-mono text-sm text-gray-700">{parseInt(row.unidades).toLocaleString()}</td>
                                    <td className="px-4 py-3 text-right font-mono text-sm text-gray-700">{mono(row.ingreso_total)}</td>
                                    <td className={`px-4 py-3 text-right font-mono text-sm font-bold ${row.utilidad_total >= 0 ? 'text-green-700' : 'text-red-700'}`}>
                                        {mono(row.utilidad_total)}
                                    </td>
                                    <td className="px-4 py-3"><StatusBadge value={row.margen} /></td>
                                    <td className="px-4 py-3 w-40">
                                        <ProgressBar value={row.ingreso_total} max={Math.max(...rows.map(r => r.ingreso_total), 1)} color="bg-blue-500" />
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
                {mejor && (
                    <TableFooter items={[
                        { label: 'Mayor margen', value: mejor.producto, color: 'text-green-700' },
                        { label: 'Margen crítico', value: peor?.producto ?? '—', color: 'text-red-700' },
                    ]} />
                )}
            </TableCard>
        </div>
    );
}
