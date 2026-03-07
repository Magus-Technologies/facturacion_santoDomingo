import { useState, useMemo } from 'react';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

const pct = (n) => `${parseFloat(n ?? 0).toFixed(1)}%`;

// ─── Status Badge Refactorizado (Alineado con frontend-design-patterns)
export function StatusBadge({ value }) {
    const v = parseFloat(value ?? 0);
    if (v >= 55) return <Badge variant="success" className="bg-green-100 text-green-800">{pct(v)}</Badge>;
    if (v >= 30) return <Badge variant="warning" className="bg-amber-100 text-amber-800">{pct(v)}</Badge>;
    return <Badge variant="danger" className="bg-red-100 text-red-700">{pct(v)}</Badge>;
}

// ─── Progress Bar
export function ProgressBar({ value, max, color = 'bg-gray-400' }) {
    const p = max > 0 ? Math.min((value / max) * 100, 100) : 0;
    return (
        <div className="flex items-center gap-3">
            <div className="flex-1 h-2 bg-gray-100 rounded-full overflow-hidden min-w-[60px]">
                <div className={`h-full rounded-full ${color}`} style={{ width: `${p}%` }} />
            </div>
            <span className="font-mono text-sm text-gray-600 w-10 text-right">{Math.round(p)}%</span>
        </div>
    );
}

// ─── Filter Bar Contenedor
export function FilterBar({ children }) {
    return (
        <div className="flex flex-wrap items-center gap-3 mb-6 pb-4 border-b border-gray-200">
            {children}
        </div>
    );
}

// ─── Filter Chip Alineado al sistema
export function FilterChip({ label, active, variant = 'default', onClick }) {
    const variants = {
        success: active ? 'bg-green-100 text-green-800 border-green-300' : 'bg-white text-gray-600 border-gray-200 hover:bg-gray-50',
        warning: active ? 'bg-amber-100 text-amber-800 border-amber-300' : 'bg-white text-gray-600 border-gray-200 hover:bg-gray-50',
        danger: active ? 'bg-red-100 text-red-700 border-red-300' : 'bg-white text-gray-600 border-gray-200 hover:bg-gray-50',
    };
    return (
        <button
            onClick={onClick}
            className={`px-4 py-2 text-sm font-medium border rounded-lg transition-all ${variants[variant]}`}
        >
            {label}
        </button>
    );
}

// ─── Table Header Sortable
export function TableHeader({ children, col, sort, onSort, right = false }) {
    const isSorted = col && sort?.key === col;
    return (
        <th
            onClick={col && onSort ? () => onSort(col) : undefined}
            className={`px-4 py-3 font-semibold text-xs uppercase tracking-wider text-gray-600 bg-gray-50 border-b border-gray-200 whitespace-nowrap
                ${right ? 'text-right' : 'text-left'}
                ${col && onSort ? 'cursor-pointer hover:bg-gray-100' : ''}`}
        >
            <div className={`flex items-center gap-2 ${right ? 'justify-end' : 'justify-start'}`}>
                {children}
                {isSorted && <span className="text-xs">{sort.dir === 'asc' ? '↑' : '↓'}</span>}
            </div>
        </th>
    );
}

// ─── Filtered Table Card Contenedor
export function TableCard({ title, count, total, children }) {
    return (
        <Card className="border-gray-200">
            {title && (
                <CardHeader className="border-b border-gray-200">
                    <div className="flex items-center justify-between">
                        <CardTitle>{title}</CardTitle>
                        {count !== undefined && (
                            <span className="text-sm text-gray-600">{count} de {total}</span>
                        )}
                    </div>
                </CardHeader>
            )}
            <CardContent className="p-0">
                {children}
            </CardContent>
        </Card>
    );
}

// ─── Summary Footer Table
export function TableFooter({ items }) {
    if (!items?.length) return null;
    return (
        <div className="flex items-center gap-8 px-6 py-4 border-t border-gray-200 bg-gray-50 flex-wrap">
            {items.map((it, i) => (
                <div key={i} className="flex items-center gap-3">
                    <span className="text-xs font-semibold uppercase text-gray-600">{it.label}</span>
                    <span className={`text-sm font-bold ${it.color ?? 'text-gray-900'}`}>{it.value}</span>
                </div>
            ))}
        </div>
    );
}

// ─── Hook Utils (Sort)
export function useSort(data, defaultKey = '', defaultDir = 'desc') {
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
