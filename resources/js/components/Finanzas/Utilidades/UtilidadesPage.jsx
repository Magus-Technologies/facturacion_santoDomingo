import { useState, useMemo } from 'react';
import {
    Package, Receipt, FolderOpen, User,
    CalendarDays, Wallet, TrendingDown,
    RefreshCw, Download, Loader2, Search, X,
} from 'lucide-react';
import MainLayout from '@/components/Layout/MainLayout';
import { useUtilidades } from './hooks/useUtilidades';

// ─── Formateadores ────────────────────────────────────────────────────────────
const fmt  = (n) => 'S/ ' + parseFloat(n ?? 0).toLocaleString('es-PE', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
const pct  = (n) => `${parseFloat(n ?? 0).toFixed(1)}%`;
const mono = (n) => parseFloat(n ?? 0).toLocaleString('es-PE', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

// ─── Franja de KPIs ──────────────────────────────────────────────────────────
function KpiStrip({ items }) {
    return (
        <div className="flex items-stretch border border-gray-200 rounded-lg bg-white divide-x divide-gray-200 mb-5">
            {items.map((k, i) => (
                <div key={i} className="flex-1 px-5 py-4 min-w-0">
                    <div className="text-[10px] font-mono uppercase tracking-widest text-gray-400 mb-1 truncate">{k.label}</div>
                    <div className={`text-xl font-bold leading-none ${k.color ?? 'text-gray-900'}`}>{k.value}</div>
                    {k.sub && <div className="text-[11px] text-gray-400 mt-1">{k.sub}</div>}
                </div>
            ))}
        </div>
    );
}

// ─── Pill de margen ───────────────────────────────────────────────────────────
function Pill({ value }) {
    const v = parseFloat(value ?? 0);
    const cls = v >= 55 ? 'bg-green-50 text-green-700 border-green-200'
              : v >= 30 ? 'bg-amber-50 text-amber-700 border-amber-200'
              : 'bg-red-50 text-red-600 border-red-200';
    return (
        <span className={`inline-flex items-center px-2 py-0.5 rounded border font-mono text-[11px] ${cls}`}>
            {pct(v)}
        </span>
    );
}

// ─── Barra de distribución ────────────────────────────────────────────────────
function MiniBar({ value, max, color = 'bg-gray-400' }) {
    const p = max > 0 ? Math.min((value / max) * 100, 100) : 0;
    return (
        <div className="flex items-center gap-2">
            <div className="flex-1 h-1 bg-gray-100 rounded-full overflow-hidden min-w-[48px]">
                <div className={`h-full rounded-full ${color}`} style={{ width: `${p}%` }} />
            </div>
            <span className="font-mono text-[10px] text-gray-400 w-8 text-right">{Math.round(p)}%</span>
        </div>
    );
}

// ─── Filtros inline ───────────────────────────────────────────────────────────
function FilterRow({ children }) {
    return (
        <div className="flex flex-wrap items-center gap-2 mb-4 pb-4 border-b border-gray-100">
            {children}
        </div>
    );
}

function FSearch({ placeholder, value, onChange }) {
    return (
        <div className="relative">
            <Search className="absolute left-2.5 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-gray-400" />
            <input
                type="text"
                className="pl-8 pr-3 py-1.5 text-sm border border-gray-200 rounded bg-white focus:outline-none focus:border-gray-400 w-48"
                placeholder={placeholder}
                value={value}
                onChange={e => onChange(e.target.value)}
            />
        </div>
    );
}

function FSelect({ value, onChange, options }) {
    return (
        <select
            value={value}
            onChange={e => onChange(e.target.value)}
            className="px-2.5 py-1.5 text-sm border border-gray-200 rounded bg-white text-gray-700 focus:outline-none focus:border-gray-400"
        >
            {options.map(o => <option key={o.value} value={o.value}>{o.label}</option>)}
        </select>
    );
}

function FChip({ label, active, color, onClick }) {
    const on = {
        green: 'border-green-400 text-green-700 bg-green-50',
        red:   'border-red-400 text-red-600 bg-red-50',
        amber: 'border-amber-400 text-amber-700 bg-amber-50',
    };
    return (
        <button
            onClick={onClick}
            className={`px-2.5 py-1 text-xs font-medium border rounded transition-all ${active ? (on[color] ?? on.green) : 'border-gray-200 text-gray-400 bg-white'}`}
        >
            {label}
        </button>
    );
}

function FReset({ onClick }) {
    return (
        <button onClick={onClick} className="ml-auto flex items-center gap-1 text-xs text-gray-400 hover:text-red-500 transition-colors">
            <X className="h-3 w-3" /> Limpiar
        </button>
    );
}

// ─── Cabecera de tabla sortable ───────────────────────────────────────────────
function Th({ children, col, sort, onSort, right = false }) {
    const isSorted = col && sort?.key === col;
    return (
        <th
            onClick={col && onSort ? () => onSort(col) : undefined}
            className={`px-3 py-2 font-mono text-[9px] tracking-[.12em] uppercase text-gray-400 bg-gray-50 border-b border-gray-200 whitespace-nowrap
                ${right ? 'text-right' : 'text-left'}
                ${col && onSort ? 'cursor-pointer hover:text-gray-600' : ''}`}
        >
            {children}{isSorted && <span className="ml-1">{sort.dir === 'asc' ? '▲' : '▼'}</span>}
        </th>
    );
}

// ─── Hook de sort ─────────────────────────────────────────────────────────────
function useSort(data, defaultKey = '', defaultDir = 'desc') {
    const [sort, setSort] = useState({ key: defaultKey, dir: defaultDir });
    const onSort = (key) => setSort(prev => ({ key, dir: prev.key === key && prev.dir === 'desc' ? 'asc' : 'desc' }));
    const sorted = useMemo(() => {
        if (!data?.length) return [];
        return [...data].sort((a, b) => {
            const av = a[sort.key] ?? 0, bv = b[sort.key] ?? 0;
            const cmp = typeof av === 'string' ? av.localeCompare(bv) : av - bv;
            return sort.dir === 'asc' ? cmp : -cmp;
        });
    }, [data, sort.key, sort.dir]);
    return { sorted, sort, onSort };
}

// ─── Tabla wrapper ────────────────────────────────────────────────────────────
function TableCard({ title, count, total, children }) {
    return (
        <div className="border border-gray-200 rounded-lg overflow-hidden bg-white">
            {title && (
                <div className="flex items-center justify-between px-4 py-2.5 bg-gray-50 border-b border-gray-200">
                    <span className="text-sm font-semibold text-gray-700">{title}</span>
                    {count !== undefined && (
                        <span className="font-mono text-[10px] text-gray-400">{count} de {total}</span>
                    )}
                </div>
            )}
            {children}
        </div>
    );
}

// ─── Resumen al pie de tabla ──────────────────────────────────────────────────
function TableFootNote({ items }) {
    if (!items?.length) return null;
    return (
        <div className="flex items-center gap-6 px-4 py-2.5 border-t border-gray-100 bg-gray-50 flex-wrap">
            {items.map((it, i) => (
                <div key={i} className="flex items-center gap-2">
                    <span className="text-[10px] font-mono uppercase text-gray-400">{it.label}:</span>
                    <span className={`text-[11px] font-semibold ${it.color ?? 'text-gray-700'}`}>{it.value}</span>
                </div>
            ))}
        </div>
    );
}

// ════════════════════════════════════════════════════════
// TAB 1 — POR PRODUCTO
// ════════════════════════════════════════════════════════
function TabProductos({ data, kpis }) {
    const rows       = data?.rentabilidad_productos ?? [];
    const categorias = [...new Set(rows.map(r => r.categoria))].filter(Boolean);
    const [search, setSearch] = useState('');
    const [cat,    setCat]    = useState('');
    const [chips,  setChips]  = useState({ alto: true, medio: true, bajo: true });
    const toggle   = (k) => setChips(p => ({ ...p, [k]: !p[k] }));
    const resetAll = () => { setSearch(''); setCat(''); setChips({ alto: true, medio: true, bajo: true }); };

    const filtered = useMemo(() => {
        let d = [...rows];
        if (search) d = d.filter(r => r.producto.toLowerCase().includes(search.toLowerCase()));
        if (cat)    d = d.filter(r => r.categoria === cat);
        const any = Object.values(chips).some(Boolean);
        if (any) d = d.filter(r => {
            const m = parseFloat(r.margen);
            return (chips.alto && m >= 55) || (chips.medio && m >= 30 && m < 55) || (chips.bajo && m < 30);
        });
        return d;
    }, [rows, search, cat, chips]);

    const { sorted, sort, onSort } = useSort(filtered, 'utilidad_total', 'desc');
    const mejor  = [...rows].sort((a, b) => b.margen - a.margen)[0];
    const peor   = [...rows].sort((a, b) => a.margen - b.margen)[0];
    const volumen = [...rows].sort((a, b) => b.unidades - a.unidades)[0];

    return (
        <div className="p-5">
            <KpiStrip items={[
                { label: 'Utilidad Neta',   value: fmt(kpis?.utilidad), color: (kpis?.utilidad ?? 0) >= 0 ? 'text-green-700' : 'text-red-600', sub: `${(kpis?.cambio_utilidad ?? 0) >= 0 ? '▲' : '▼'} ${pct(Math.abs(kpis?.cambio_utilidad))} vs anterior` },
                { label: 'Ingresos Totales', value: fmt(kpis?.ingresos), color: 'text-blue-700', sub: `${(kpis?.cambio_ingresos ?? 0) >= 0 ? '▲' : '▼'} ${pct(Math.abs(kpis?.cambio_ingresos))} vs anterior` },
                { label: 'Costo Total',     value: fmt(kpis?.costo),    color: 'text-gray-700', sub: 'costos de productos' },
                { label: 'Margen Promedio', value: pct(kpis?.margen),   color: 'text-gray-900', sub: 'del período' },
            ]} />

            <FilterRow>
                <FSearch placeholder="Buscar producto..." value={search} onChange={setSearch} />
                <FSelect value={cat} onChange={setCat} options={[
                    { value: '', label: 'Categoría: Todas' },
                    ...categorias.map(c => ({ value: c, label: c })),
                ]} />
                <span className="w-px h-4 bg-gray-200" />
                <FChip label="Alto ≥55%"    color="green" active={chips.alto}  onClick={() => toggle('alto')} />
                <FChip label="Medio 30–55%" color="amber" active={chips.medio} onClick={() => toggle('medio')} />
                <FChip label="Bajo <30%"    color="red"   active={chips.bajo}  onClick={() => toggle('bajo')} />
                <FReset onClick={resetAll} />
            </FilterRow>

            <TableCard title="Rentabilidad por Producto" count={sorted.length} total={rows.length}>
                <div className="overflow-x-auto">
                    <table className="w-full border-collapse text-sm">
                        <thead>
                            <tr>
                                <Th col="producto"       sort={sort} onSort={onSort}>Producto</Th>
                                <Th col="precio_venta"   sort={sort} onSort={onSort} right>Precio</Th>
                                <Th col="costo_unitario" sort={sort} onSort={onSort} right>Costo</Th>
                                <Th col="unidades"       sort={sort} onSort={onSort} right>Uds.</Th>
                                <Th col="ingreso_total"  sort={sort} onSort={onSort} right>Ingresos</Th>
                                <Th col="utilidad_total" sort={sort} onSort={onSort} right>Utilidad</Th>
                                <Th col="margen"         sort={sort} onSort={onSort}>Margen</Th>
                                <Th right>Participación</Th>
                            </tr>
                        </thead>
                        <tbody>
                            {sorted.length === 0 && (
                                <tr><td colSpan={8} className="text-center py-8 text-gray-400 text-sm">Sin resultados</td></tr>
                            )}
                            {sorted.map((row, i) => (
                                <tr key={i} className="border-t border-gray-100 hover:bg-gray-50 transition-colors">
                                    <td className="px-3 py-2">
                                        <div className="font-medium text-gray-900">{row.producto}</div>
                                        <div className="font-mono text-[10px] text-gray-400">{row.categoria}</div>
                                    </td>
                                    <td className="px-3 py-2 text-right font-mono text-xs text-gray-600">{mono(row.precio_venta)}</td>
                                    <td className="px-3 py-2 text-right font-mono text-xs text-gray-400">{mono(row.costo_unitario)}</td>
                                    <td className="px-3 py-2 text-right font-mono text-xs text-gray-600">{parseInt(row.unidades).toLocaleString()}</td>
                                    <td className="px-3 py-2 text-right font-mono text-xs text-gray-700">{mono(row.ingreso_total)}</td>
                                    <td className={`px-3 py-2 text-right font-mono text-xs font-semibold ${row.utilidad_total >= 0 ? 'text-green-700' : 'text-red-600'}`}>
                                        {mono(row.utilidad_total)}
                                    </td>
                                    <td className="px-3 py-2"><Pill value={row.margen} /></td>
                                    <td className="px-3 py-2 w-32">
                                        <MiniBar value={row.ingreso_total} max={Math.max(...rows.map(r => r.ingreso_total), 1)} color="bg-blue-400" />
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
                {mejor && (
                    <TableFootNote items={[
                        { label: 'Mayor margen', value: mejor.producto, color: 'text-green-700' },
                        { label: 'Margen crítico', value: peor?.producto ?? '—', color: 'text-red-600' },
                        { label: 'Mayor volumen', value: volumen?.producto ?? '—', color: 'text-blue-700' },
                    ]} />
                )}
            </TableCard>
        </div>
    );
}

// ════════════════════════════════════════════════════════
// TAB 2 — POR VENTA
// ════════════════════════════════════════════════════════
function TabVentas({ data, kpis }) {
    const items = data?.utilidad_tiempo ?? [];
    const [search, setSearch] = useState('');
    const [chips,  setChips]  = useState({ gan: true, per: true });
    const toggle   = (k) => setChips(p => ({ ...p, [k]: !p[k] }));
    const resetAll = () => { setSearch(''); setChips({ gan: true, per: true }); };

    const totalVentas = items.reduce((s, r) => s + r.num_ventas, 0);
    const ticketProm  = totalVentas > 0 ? (kpis?.ingresos ?? 0) / totalVentas : 0;
    const diasNeg     = items.filter(r => r.utilidad < 0).length;

    const filtered = useMemo(() => {
        let d = [...items];
        if (search) d = d.filter(r => r.periodo.includes(search));
        const any = Object.values(chips).some(Boolean);
        if (any) d = d.filter(r => (chips.gan && r.utilidad >= 0) || (chips.per && r.utilidad < 0));
        return d;
    }, [items, search, chips]);

    const { sorted, sort, onSort } = useSort(filtered, 'utilidad', 'desc');

    return (
        <div className="p-5">
            <KpiStrip items={[
                { label: 'Ticket Promedio',    value: fmt(ticketProm),             color: 'text-green-700',  sub: 'por comprobante' },
                { label: 'Comprobantes',       value: totalVentas.toLocaleString(), color: 'text-blue-700',  sub: 'del período' },
                { label: 'Ingresos Totales',   value: fmt(kpis?.ingresos),         color: 'text-gray-900',   sub: 'ventas del período' },
                { label: 'Períodos a pérdida', value: String(diasNeg),             color: diasNeg > 0 ? 'text-red-600' : 'text-green-700', sub: diasNeg > 0 ? 'requieren revisión' : 'todos positivos' },
            ]} />

            <FilterRow>
                <FSearch placeholder="Buscar período..." value={search} onChange={setSearch} />
                <span className="w-px h-4 bg-gray-200" />
                <FChip label="Ganadora"  color="green" active={chips.gan} onClick={() => toggle('gan')} />
                <FChip label="A pérdida" color="red"   active={chips.per} onClick={() => toggle('per')} />
                <FReset onClick={resetAll} />
            </FilterRow>

            <TableCard title="Utilidad por Período" count={sorted.length} total={items.length}>
                <div className="overflow-x-auto">
                    <table className="w-full border-collapse text-sm">
                        <thead>
                            <tr>
                                <Th col="periodo"    sort={sort} onSort={onSort}>Período</Th>
                                <Th col="num_ventas" sort={sort} onSort={onSort} right>Comprobantes</Th>
                                <Th col="ingresos"   sort={sort} onSort={onSort} right>Ventas</Th>
                                <Th col="costos"     sort={sort} onSort={onSort} right>Costos</Th>
                                <Th col="utilidad"   sort={sort} onSort={onSort} right>Utilidad</Th>
                                <Th>Margen</Th>
                                <Th right>Tendencia</Th>
                            </tr>
                        </thead>
                        <tbody>
                            {sorted.length === 0 && <tr><td colSpan={7} className="text-center py-8 text-gray-400">Sin datos</td></tr>}
                            {sorted.map((row, i) => {
                                const mg = row.ingresos > 0 ? (row.utilidad / row.ingresos) * 100 : 0;
                                return (
                                    <tr key={i} className={`border-t border-gray-100 hover:bg-gray-50 transition-colors ${row.utilidad < 0 ? 'bg-red-50/40' : ''}`}>
                                        <td className="px-3 py-2 font-medium text-gray-900">{row.periodo}</td>
                                        <td className="px-3 py-2 text-right font-mono text-xs text-gray-600">{row.num_ventas}</td>
                                        <td className="px-3 py-2 text-right font-mono text-xs text-gray-700">{mono(row.ingresos)}</td>
                                        <td className="px-3 py-2 text-right font-mono text-xs text-gray-400">{mono(row.costos)}</td>
                                        <td className={`px-3 py-2 text-right font-mono text-xs font-semibold ${row.utilidad >= 0 ? 'text-green-700' : 'text-red-600'}`}>{mono(row.utilidad)}</td>
                                        <td className="px-3 py-2"><Pill value={mg} /></td>
                                        <td className={`px-3 py-2 text-right font-mono text-xs font-bold ${row.utilidad >= 0 ? 'text-green-600' : 'text-red-500'}`}>{row.utilidad >= 0 ? '↑' : '↓'}</td>
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

// ════════════════════════════════════════════════════════
// TAB 3 — POR CATEGORÍA
// ════════════════════════════════════════════════════════
function TabCategorias({ data }) {
    const cats = data?.margen_categorias ?? [];
    const [chips, setChips] = useState({ alto: true, medio: true, bajo: true });
    const [orden, setOrden] = useState('margen_desc');
    const toggle   = (k) => setChips(p => ({ ...p, [k]: !p[k] }));
    const resetAll = () => { setChips({ alto: true, medio: true, bajo: true }); setOrden('margen_desc'); };

    const filtered = useMemo(() => {
        let d = [...cats];
        const any = Object.values(chips).some(Boolean);
        if (any) d = d.filter(r => {
            const m = parseFloat(r.margen);
            return (chips.alto && m >= 55) || (chips.medio && m >= 30 && m < 55) || (chips.bajo && m < 30);
        });
        const [key] = orden.split('_desc');
        return d.sort((a, b) => (b[key] ?? 0) - (a[key] ?? 0));
    }, [cats, chips, orden]);

    const totalIngresos = cats.reduce((s, c) => s + c.ingreso_total, 0);

    return (
        <div className="p-5">
            <FilterRow>
                <FSelect value={orden} onChange={setOrden} options={[
                    { value: 'margen_desc',         label: 'Ordenar: Margen ↓' },
                    { value: 'ingreso_total_desc',  label: 'Ingresos ↓' },
                    { value: 'utilidad_total_desc', label: 'Utilidad ↓' },
                ]} />
                <span className="w-px h-4 bg-gray-200" />
                <FChip label="Alto ≥55%"    color="green" active={chips.alto}  onClick={() => toggle('alto')} />
                <FChip label="Medio 30–55%" color="amber" active={chips.medio} onClick={() => toggle('medio')} />
                <FChip label="Bajo <30%"    color="red"   active={chips.bajo}  onClick={() => toggle('bajo')} />
                <FReset onClick={resetAll} />
            </FilterRow>

            <TableCard title="Rentabilidad por Categoría">
                <div className="overflow-x-auto">
                    <table className="w-full border-collapse text-sm">
                        <thead>
                            <tr>
                                <Th>Categoría</Th>
                                <Th right>Productos</Th>
                                <Th right>Ventas Totales</Th>
                                <Th right>Costos</Th>
                                <Th right>Utilidad</Th>
                                <Th>Margen</Th>
                                <Th>Participación</Th>
                            </tr>
                        </thead>
                        <tbody>
                            {filtered.length === 0 && <tr><td colSpan={7} className="text-center py-8 text-gray-400">Sin datos</td></tr>}
                            {filtered.map((cat, i) => (
                                <tr key={i} className="border-t border-gray-100 hover:bg-gray-50 transition-colors">
                                    <td className="px-3 py-2 font-medium text-gray-900">{cat.categoria}</td>
                                    <td className="px-3 py-2 text-right font-mono text-xs text-gray-400">{cat.num_productos}</td>
                                    <td className="px-3 py-2 text-right font-mono text-xs text-gray-700">{mono(cat.ingreso_total)}</td>
                                    <td className="px-3 py-2 text-right font-mono text-xs text-gray-400">{mono(cat.costo_total)}</td>
                                    <td className={`px-3 py-2 text-right font-mono text-xs font-semibold ${cat.utilidad_total >= 0 ? 'text-green-700' : 'text-red-600'}`}>{mono(cat.utilidad_total)}</td>
                                    <td className="px-3 py-2"><Pill value={cat.margen} /></td>
                                    <td className="px-3 py-2 w-36">
                                        <MiniBar value={cat.ingreso_total} max={totalIngresos} color="bg-blue-400" />
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </TableCard>
        </div>
    );
}

// ════════════════════════════════════════════════════════
// TAB 4 — POR VENDEDOR
// ════════════════════════════════════════════════════════
function TabVendedores({ data }) {
    const rows = data?.margen_vendedores ?? [];
    const [search, setSearch] = useState('');
    const [chips,  setChips]  = useState({ ok: true, neg: true });
    const toggle   = (k) => setChips(p => ({ ...p, [k]: !p[k] }));
    const resetAll = () => { setSearch(''); setChips({ ok: true, neg: true }); };

    const filtered = useMemo(() => {
        let d = [...rows];
        if (search) d = d.filter(r => r.vendedor.toLowerCase().includes(search.toLowerCase()));
        const any = Object.values(chips).some(Boolean);
        if (any) d = d.filter(r => (chips.ok && r.utilidad >= 0) || (chips.neg && r.utilidad < 0));
        return d;
    }, [rows, search, chips]);

    const { sorted, sort, onSort } = useSort(filtered, 'utilidad', 'desc');
    const mejor     = [...rows].sort((a, b) => b.margen - a.margen)[0];
    const mayorUtil = [...rows].sort((a, b) => b.utilidad - a.utilidad)[0];
    const totalDesc = rows.reduce((s, v) => s + v.descuentos, 0);
    const negCount  = rows.filter(v => v.utilidad < 0).length;

    return (
        <div className="p-5">
            <KpiStrip items={[
                { label: 'Mejor margen',     value: mejor?.vendedor ?? '—',     color: 'text-green-700',  sub: mejor ? pct(mejor.margen) : '' },
                { label: 'Mayor utilidad',   value: mayorUtil?.vendedor ?? '—', color: 'text-blue-700',   sub: mayorUtil ? fmt(mayorUtil.utilidad) : '' },
                { label: 'Total descuentos', value: fmt(totalDesc),             color: 'text-amber-700',  sub: 'impacto en margen' },
                { label: 'A pérdida',        value: String(negCount),           color: negCount > 0 ? 'text-red-600' : 'text-green-700', sub: negCount > 0 ? 'requieren coaching' : 'todos rentables' },
            ]} />

            <FilterRow>
                <FSearch placeholder="Buscar vendedor..." value={search} onChange={setSearch} />
                <span className="w-px h-4 bg-gray-200" />
                <FChip label="Rentable"  color="green" active={chips.ok}  onClick={() => toggle('ok')} />
                <FChip label="A pérdida" color="red"   active={chips.neg} onClick={() => toggle('neg')} />
                <FReset onClick={resetAll} />
            </FilterRow>

            <TableCard title="Margen por Vendedor — post-descuento" count={sorted.length} total={rows.length}>
                <div className="overflow-x-auto">
                    <table className="w-full border-collapse text-sm">
                        <thead>
                            <tr>
                                <Th col="vendedor"    sort={sort} onSort={onSort}>Vendedor</Th>
                                <Th col="num_ventas"  sort={sort} onSort={onSort} right>Ventas</Th>
                                <Th col="ingresos"    sort={sort} onSort={onSort} right>Ingresos</Th>
                                <Th col="costos"      sort={sort} onSort={onSort} right>Costos</Th>
                                <Th col="descuentos"  sort={sort} onSort={onSort} right>Descuentos</Th>
                                <Th col="utilidad"    sort={sort} onSort={onSort} right>Utilidad Neta</Th>
                                <Th col="margen"      sort={sort} onSort={onSort}>Margen</Th>
                                <Th col="ticket_prom" sort={sort} onSort={onSort} right>Ticket Prom.</Th>
                            </tr>
                        </thead>
                        <tbody>
                            {sorted.length === 0 && <tr><td colSpan={8} className="text-center py-8 text-gray-400">Sin datos</td></tr>}
                            {sorted.map((v, i) => (
                                <tr key={i} className={`border-t border-gray-100 hover:bg-gray-50 transition-colors ${v.utilidad < 0 ? 'bg-red-50/40' : ''}`}>
                                    <td className="px-3 py-2 font-medium text-gray-900">{v.vendedor}</td>
                                    <td className="px-3 py-2 text-right font-mono text-xs text-gray-600">{v.num_ventas}</td>
                                    <td className="px-3 py-2 text-right font-mono text-xs text-gray-700">{mono(v.ingresos)}</td>
                                    <td className="px-3 py-2 text-right font-mono text-xs text-gray-400">{mono(v.costos)}</td>
                                    <td className="px-3 py-2 text-right font-mono text-xs text-amber-600">{v.descuentos > 0 ? `-${mono(v.descuentos)}` : '—'}</td>
                                    <td className={`px-3 py-2 text-right font-mono text-xs font-semibold ${v.utilidad >= 0 ? 'text-green-700' : 'text-red-600'}`}>{mono(v.utilidad)}</td>
                                    <td className="px-3 py-2"><Pill value={v.margen} /></td>
                                    <td className="px-3 py-2 text-right font-mono text-xs text-gray-600">{mono(v.ticket_prom)}</td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
                {mejor && (
                    <TableFootNote items={[
                        { label: 'Mejor margen',   value: `${mejor.vendedor} (${pct(mejor.margen)})`,         color: 'text-green-700' },
                        { label: 'Mayor utilidad', value: `${mayorUtil?.vendedor ?? '—'} (${fmt(mayorUtil?.utilidad)})`, color: 'text-blue-700' },
                        { label: 'Desc. totales',  value: fmt(totalDesc),                                      color: 'text-amber-700' },
                    ]} />
                )}
            </TableCard>
        </div>
    );
}

// ════════════════════════════════════════════════════════
// TAB 5 — DIARIA / MENSUAL
// ════════════════════════════════════════════════════════
function TabTiempo({ data, kpis }) {
    const items = data?.utilidad_tiempo ?? [];
    const acumulado = items.reduce((s, r) => s + r.utilidad, 0);
    const acumPct   = (kpis?.ingresos ?? 0) > 0 ? (acumulado / kpis.ingresos) * 100 : 0;

    return (
        <div className="p-5">
            <KpiStrip items={[
                { label: 'Ventas brutas',     value: fmt(kpis?.ingresos), color: 'text-gray-900' },
                { label: 'Costo productos',   value: fmt(kpis?.costo),    color: 'text-red-600'  },
                { label: 'Gastos operativos', value: fmt(kpis?.gastos),   color: 'text-amber-700'},
                { label: 'Utilidad neta',     value: fmt(acumulado),      color: acumulado >= 0 ? 'text-green-700' : 'text-red-600', sub: `${pct(acumPct)} sobre ventas` },
            ]} />

            <TableCard title="Comparativa por Período">
                <div className="overflow-x-auto">
                    <table className="w-full border-collapse text-sm">
                        <thead>
                            <tr>
                                <Th>Período</Th>
                                <Th right>Comprobantes</Th>
                                <Th right>Ventas</Th>
                                <Th right>Costos</Th>
                                <Th right>Utilidad</Th>
                                <Th>Margen</Th>
                                <Th right>Tendencia</Th>
                            </tr>
                        </thead>
                        <tbody>
                            {items.length === 0 && <tr><td colSpan={7} className="text-center py-8 text-gray-400">Sin datos para el período seleccionado</td></tr>}
                            {items.map((row, i) => {
                                const prev  = items[i - 1];
                                const trend = !prev ? null : row.utilidad > prev.utilidad ? '↑' : row.utilidad < prev.utilidad ? '↓' : '=';
                                const mg    = row.ingresos > 0 ? (row.utilidad / row.ingresos) * 100 : 0;
                                const isLast = i === items.length - 1;
                                return (
                                    <tr key={i} className={`border-t border-gray-100 hover:bg-gray-50 transition-colors ${isLast ? 'bg-blue-50/30' : ''}`}>
                                        <td className="px-3 py-2 font-medium text-gray-900">
                                            {row.periodo}
                                            {isLast && <span className="ml-2 px-1.5 py-0.5 bg-blue-100 text-blue-700 font-mono text-[9px] rounded">ACTUAL</span>}
                                        </td>
                                        <td className="px-3 py-2 text-right font-mono text-xs text-gray-500">{row.num_ventas}</td>
                                        <td className="px-3 py-2 text-right font-mono text-xs text-gray-700">{mono(row.ingresos)}</td>
                                        <td className="px-3 py-2 text-right font-mono text-xs text-gray-400">{mono(row.costos)}</td>
                                        <td className={`px-3 py-2 text-right font-mono text-xs font-semibold ${row.utilidad >= 0 ? 'text-green-700' : 'text-red-600'}`}>{mono(row.utilidad)}</td>
                                        <td className="px-3 py-2"><Pill value={mg} /></td>
                                        <td className={`px-3 py-2 text-right font-mono text-sm font-bold ${!trend ? 'text-gray-300' : trend === '↑' ? 'text-green-600' : trend === '↓' ? 'text-red-500' : 'text-gray-300'}`}>{trend ?? '—'}</td>
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

// ════════════════════════════════════════════════════════
// TAB 6 — COSTOS Y GASTOS
// ════════════════════════════════════════════════════════
function TabGastos({ data, kpis }) {
    const gastos  = data?.gastos_detalle ?? [];
    const [search, setSearch] = useState('');
    const [orden,  setOrden]  = useState('total_desc');
    const resetAll = () => { setSearch(''); setOrden('total_desc'); };

    const filtered = useMemo(() => {
        let d = [...gastos];
        if (search) d = d.filter(r => (r.concepto ?? '').toLowerCase().includes(search.toLowerCase()));
        return d.sort((a, b) => orden === 'total_desc' ? b.total - a.total : a.total - b.total);
    }, [gastos, search, orden]);

    const { sorted, sort, onSort } = useSort(filtered, 'total', 'desc');
    const totalGastos = kpis?.gastos ?? 0;
    const ratioPct    = (kpis?.ingresos ?? 0) > 0 ? (totalGastos / kpis.ingresos) * 100 : 0;
    const eficiencia  = totalGastos > 0 ? ((kpis?.ingresos ?? 0) / totalGastos).toFixed(1) + 'x' : '∞';
    const mayorGasto  = gastos[0];
    const menorImp    = [...gastos].sort((a, b) => a.total - b.total)[0];

    return (
        <div className="p-5">
            <KpiStrip items={[
                { label: 'Total Gastos',     value: fmt(totalGastos), color: 'text-red-600',   sub: 'egresos del período' },
                { label: '% sobre Ventas',   value: pct(ratioPct),    color: 'text-amber-700', sub: ratioPct < 20 ? 'eficiente' : 'elevado' },
                { label: 'Ratio Eficiencia', value: eficiencia,       color: 'text-green-700', sub: 'ventas por S/ 1 de gasto' },
                { label: 'Conceptos',        value: String(gastos.length), color: 'text-gray-900', sub: 'categorías de egreso' },
            ]} />

            <FilterRow>
                <FSearch placeholder="Buscar concepto..." value={search} onChange={setSearch} />
                <FSelect value={orden} onChange={setOrden} options={[
                    { value: 'total_desc', label: 'Monto ↓' },
                    { value: 'total_asc',  label: 'Monto ↑' },
                ]} />
                <FReset onClick={resetAll} />
            </FilterRow>

            <TableCard title="Desglose de Gastos Operativos" count={sorted.length} total={gastos.length}>
                <div className="overflow-x-auto">
                    <table className="w-full border-collapse text-sm">
                        <thead>
                            <tr>
                                <Th col="concepto"        sort={sort} onSort={onSort}>Concepto</Th>
                                <Th col="num_movimientos" sort={sort} onSort={onSort} right>Mov.</Th>
                                <Th col="total"           sort={sort} onSort={onSort} right>Monto</Th>
                                <Th col="porcentaje"      sort={sort} onSort={onSort} right>% del total</Th>
                                <Th right>Impacto</Th>
                                <Th>Distribución</Th>
                            </tr>
                        </thead>
                        <tbody>
                            {sorted.length === 0 && <tr><td colSpan={6} className="text-center py-8 text-gray-400">Sin egresos en este período</td></tr>}
                            {sorted.map((g, i) => {
                                const impacto = (kpis?.ingresos ?? 0) > 0 ? (g.total / kpis.ingresos) * 100 : 0;
                                return (
                                    <tr key={i} className="border-t border-gray-100 hover:bg-gray-50 transition-colors">
                                        <td className="px-3 py-2 font-medium text-gray-900">{g.concepto || 'Sin concepto'}</td>
                                        <td className="px-3 py-2 text-right font-mono text-xs text-gray-400">{g.num_movimientos}</td>
                                        <td className="px-3 py-2 text-right font-mono text-xs font-semibold text-red-600">{mono(g.total)}</td>
                                        <td className="px-3 py-2 text-right font-mono text-xs text-gray-600">{pct(g.porcentaje)}</td>
                                        <td className={`px-3 py-2 text-right font-mono text-xs ${impacto > 3 ? 'text-red-600' : impacto > 1 ? 'text-amber-600' : 'text-gray-400'}`}>
                                            -{pct(impacto)} pp
                                        </td>
                                        <td className="px-3 py-2 w-36">
                                            <MiniBar value={g.porcentaje} max={100} color={impacto > 3 ? 'bg-red-400' : impacto > 1 ? 'bg-amber-400' : 'bg-gray-300'} />
                                        </td>
                                    </tr>
                                );
                            })}
                        </tbody>
                    </table>
                </div>
                {mayorGasto && (
                    <TableFootNote items={[
                        { label: 'Mayor gasto',  value: `${mayorGasto?.concepto} (${fmt(mayorGasto?.total)})`, color: 'text-red-600' },
                        { label: 'Menor impacto', value: menorImp?.concepto ?? '—', color: 'text-gray-600' },
                        { label: 'Eficiencia',   value: `${eficiencia} en ventas por S/ 1 gastado`,           color: 'text-green-700' },
                    ]} />
                )}
            </TableCard>
        </div>
    );
}

// ════════════════════════════════════════════════════════
// TABS
// ════════════════════════════════════════════════════════
const TABS = [
    { id: 'productos',  label: 'Por Producto',    icon: Package },
    { id: 'ventas',     label: 'Por Venta',        icon: Receipt },
    { id: 'categorias', label: 'Por Categoría',    icon: FolderOpen },
    { id: 'vendedores', label: 'Por Vendedor',     icon: User },
    { id: 'tiempo',     label: 'Diaria / Mensual', icon: CalendarDays },
    { id: 'gastos',     label: 'Costos y Gastos',  icon: Wallet },
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
            <div className="flex items-center justify-between px-6 py-3 bg-white border-b border-gray-200 flex-wrap gap-3">
                <div>
                    <h1 className="text-base font-semibold text-gray-900">Análisis de Utilidades</h1>
                    <p className="text-[11px] text-gray-400 font-mono">Business Intelligence · Rentabilidad</p>
                </div>
                <div className="flex items-center gap-2">
                    <div className="flex border border-gray-200 rounded overflow-hidden">
                        {PERIODOS.map(p => (
                            <button
                                key={p.id}
                                onClick={() => cambiarPeriodo(p.id)}
                                className={`px-3 py-1.5 font-mono text-[11px] font-semibold border-r border-gray-200 last:border-r-0 transition-colors ${
                                    periodo === p.id ? 'bg-primary-600 text-white' : 'bg-white text-gray-500 hover:bg-gray-50'
                                }`}
                            >
                                {p.label}
                            </button>
                        ))}
                    </div>
                    <button
                        onClick={() => refetch(periodo)}
                        disabled={loading}
                        className="flex items-center gap-1.5 px-3 py-1.5 text-xs border border-gray-200 rounded bg-white text-gray-600 hover:bg-gray-50 transition-colors disabled:opacity-50"
                    >
                        <RefreshCw className={`h-3.5 w-3.5 ${loading ? 'animate-spin' : ''}`} />
                        Actualizar
                    </button>
                    <button className="flex items-center gap-1.5 px-3 py-1.5 text-xs border border-gray-200 rounded bg-white text-gray-600 hover:bg-gray-50 transition-colors">
                        <Download className="h-3.5 w-3.5" />
                        Exportar
                    </button>
                </div>
            </div>

            {error && (
                <div className="mx-5 mt-4 p-3 bg-red-50 border border-red-200 rounded text-sm text-red-600 flex items-center gap-2">
                    <TrendingDown className="h-4 w-4 flex-shrink-0" /> {error}
                </div>
            )}

            {loading && !data && (
                <div className="flex items-center justify-center min-h-[400px]">
                    <Loader2 className="h-8 w-8 animate-spin text-gray-400" />
                </div>
            )}

            {data && (
                <>
                    {/* ── TABS ── */}
                    <div className="flex bg-white border-b border-gray-200 overflow-x-auto">
                        {TABS.map(tab => {
                            const Icon = tab.icon;
                            const active = tabActiva === tab.id;
                            return (
                                <button
                                    key={tab.id}
                                    onClick={() => setTabActiva(tab.id)}
                                    className={`flex items-center gap-2 px-4 py-3 text-[13px] font-medium whitespace-nowrap border-b-2 transition-colors
                                        ${active
                                            ? 'border-primary-600 text-primary-700 bg-white'
                                            : 'border-transparent text-gray-500 hover:text-gray-700 hover:bg-gray-50'
                                        }`}
                                >
                                    <Icon className="h-3.5 w-3.5" />
                                    {tab.label}
                                </button>
                            );
                        })}
                    </div>

                    {/* ── CONTENIDO ── */}
                    <div className={`bg-gray-50 min-h-screen transition-opacity ${loading ? 'opacity-60 pointer-events-none' : ''}`}>
                        {tabActiva === 'productos'  && <TabProductos  data={data} kpis={data.kpis} />}
                        {tabActiva === 'ventas'     && <TabVentas     data={data} kpis={data.kpis} />}
                        {tabActiva === 'categorias' && <TabCategorias data={data} />}
                        {tabActiva === 'vendedores' && <TabVendedores data={data} />}
                        {tabActiva === 'tiempo'     && <TabTiempo     data={data} kpis={data.kpis} />}
                        {tabActiva === 'gastos'     && <TabGastos     data={data} kpis={data.kpis} />}
                    </div>
                </>
            )}
        </MainLayout>
    );
}
