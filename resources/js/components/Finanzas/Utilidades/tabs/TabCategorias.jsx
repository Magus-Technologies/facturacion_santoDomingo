import { useState, useMemo } from 'react';
import { X, LayoutGrid, List } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Card, CardContent } from '@/components/ui/card';

import {
    FilterBar,
    FilterChip,
    StatusBadge,
    ProgressBar,
    TableCard,
    TableHeader,
    useSort
} from '../components/SharedUI';
import { mono } from '../utils/formatters';

export function TabCategorias({ data }) {
    const cats = data?.margen_categorias ?? [];
    const [view, setView] = useState('table'); // 'grid' o 'table'
    const [chips, setChips] = useState({ alto: true, medio: true, bajo: true });

    // Para la vista de cards manual (el orden original)
    const [orden, setOrden] = useState('ingreso_total_desc');

    const toggle = (k) => setChips(p => ({ ...p, [k]: !p[k] }));
    const resetAll = () => {
        setChips({ alto: true, medio: true, bajo: true });
        setOrden('ingreso_total_desc');
    };

    const filtered = useMemo(() => {
        let d = [...cats];
        const any = Object.values(chips).some(Boolean);
        if (any) d = d.filter(r => {
            const m = parseFloat(r.margen);
            return (chips.alto && m >= 55) || (chips.medio && m >= 30 && m < 55) || (chips.bajo && m < 30);
        });
        return d;
    }, [cats, chips]);

    // Hook de ordenamiento para la tabla
    const { sorted, sort, onSort } = useSort(filtered, 'ingreso_total', 'desc');

    // Datos ordenados para la vista GRID (usa el select de orden)
    const gridSorted = useMemo(() => {
        const [key] = orden.split('_desc');
        return [...filtered].sort((a, b) => (b[key] ?? 0) - (a[key] ?? 0));
    }, [filtered, orden]);

    const totalIngresos = cats.reduce((s, c) => s + c.ingreso_total, 0);

    return (
        <div className="space-y-6">
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

                {view === 'grid' && (
                    <Select value={orden} onValueChange={setOrden}>
                        <SelectTrigger className="w-56">
                            <SelectValue placeholder="Ordenar por..." />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value="margen_desc">Margen ↓</SelectItem>
                            <SelectItem value="ingreso_total_desc">Ingresos ↓</SelectItem>
                            <SelectItem value="utilidad_total_desc">Utilidad ↓</SelectItem>
                        </SelectContent>
                    </Select>
                )}

                <div className="w-px h-6 bg-gray-200" />
                <FilterChip label="Alto ≥55%" variant="success" active={chips.alto} onClick={() => toggle('alto')} />
                <FilterChip label="Medio 30–55%" variant="warning" active={chips.medio} onClick={() => toggle('medio')} />
                <FilterChip label="Bajo <30%" variant="danger" active={chips.bajo} onClick={() => toggle('bajo')} />
                <Button variant="ghost" size="sm" onClick={resetAll} className="ml-auto">
                    <X className="h-4 w-4 mr-1" /> Limpiar
                </Button>
            </FilterBar>

            {view === 'grid' ? (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                    {gridSorted.map((cat, i) => (
                        <Card key={i} className="border-gray-200 hover:shadow-md transition-shadow">
                            <CardContent className="pt-6">
                                <div className="space-y-4">
                                    <div>
                                        <h3 className="font-semibold text-gray-900">{cat.categoria}</h3>
                                        <p className="text-xs text-gray-500 mt-1">{cat.num_productos} productos</p>
                                    </div>
                                    <div className="space-y-2">
                                        <div className="flex justify-between items-center">
                                            <span className="text-xs text-gray-600">Ventas</span>
                                            <span className="font-mono text-sm font-semibold text-gray-900">{mono(cat.ingreso_total)}</span>
                                        </div>
                                        <div className="flex justify-between items-center">
                                            <span className="text-xs text-gray-600">Costos</span>
                                            <span className="font-mono text-sm text-gray-600">{mono(cat.costo_total)}</span>
                                        </div>
                                        <div className="flex justify-between items-center">
                                            <span className="text-xs text-gray-600">Utilidad</span>
                                            <span className={`font-mono text-sm font-bold ${cat.utilidad_total >= 0 ? 'text-green-700' : 'text-red-700'}`}>
                                                {mono(cat.utilidad_total)}
                                            </span>
                                        </div>
                                    </div>
                                    <div className="pt-2 border-t border-gray-200">
                                        <div className="flex justify-between items-center mb-2">
                                            <span className="text-xs font-semibold text-gray-600">Margen</span>
                                            <StatusBadge value={cat.margen} />
                                        </div>
                                        <ProgressBar value={cat.ingreso_total} max={totalIngresos} color="bg-blue-500" />
                                    </div>
                                </div>
                            </CardContent>
                        </Card>
                    ))}
                </div>
            ) : (
                <TableCard title="Resumen por Categoría" count={sorted.length} total={cats.length}>
                    <div className="overflow-x-auto">
                        <table className="w-full">
                            <thead>
                                <tr>
                                    <TableHeader col="categoria" sort={sort} onSort={onSort}>Categoría</TableHeader>
                                    <TableHeader col="num_productos" sort={sort} onSort={onSort} right>Productos</TableHeader>
                                    <TableHeader col="ingreso_total" sort={sort} onSort={onSort} right>Ingresos</TableHeader>
                                    <TableHeader col="costos_total" sort={sort} onSort={onSort} right>Costos</TableHeader>
                                    <TableHeader col="utilidad_total" sort={sort} onSort={onSort} right>Utilidad</TableHeader>
                                    <TableHeader col="margen" sort={sort} onSort={onSort}>Margen</TableHeader>
                                    <TableHeader right>Participación</TableHeader>
                                </tr>
                            </thead>
                            <tbody>
                                {sorted.length === 0 && (
                                    <tr><td colSpan={7} className="text-center py-12 text-gray-500">Sin categorías disponibles</td></tr>
                                )}
                                {sorted.map((row, i) => (
                                    <tr key={i} className="border-t border-gray-100 hover:bg-gray-50 transition-colors">
                                        <td className="px-4 py-3 font-medium text-gray-900">{row.categoria}</td>
                                        <td className="px-4 py-3 text-right text-sm text-gray-600">{row.num_productos}</td>
                                        <td className="px-4 py-3 text-right font-mono text-sm text-gray-700">{mono(row.ingreso_total)}</td>
                                        <td className="px-4 py-3 text-right font-mono text-sm text-gray-600">{mono(row.costo_total)}</td>
                                        <td className={`px-4 py-3 text-right font-mono text-sm font-bold ${row.utilidad_total >= 0 ? 'text-green-700' : 'text-red-700'}`}>
                                            {mono(row.utilidad_total)}
                                        </td>
                                        <td className="px-4 py-3"><StatusBadge value={row.margen} /></td>
                                        <td className="px-4 py-3 w-40">
                                            <ProgressBar value={row.ingreso_total} max={totalIngresos} color="bg-blue-500" />
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </TableCard>
            )}
        </div>
    );
}
