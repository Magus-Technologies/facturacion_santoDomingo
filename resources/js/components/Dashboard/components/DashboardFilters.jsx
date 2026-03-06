import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

export default function DashboardFilters({ filters, setFilters, setPeriodo, loading }) {
    return (
        <div className="bg-white rounded-2xl border border-gray-100 p-4 shadow-sm">
            <div className="flex flex-col md:flex-row md:items-end gap-4">
                <div className="flex items-end gap-3 flex-1">
                    <div className="flex-1 max-w-[200px]">
                        <Label htmlFor="fecha_inicio" className="text-xs font-medium text-gray-500">Fecha Inicio</Label>
                        <Input
                            id="fecha_inicio"
                            type="date"
                            value={filters.fecha_inicio}
                            onChange={(e) => setFilters(prev => ({ ...prev, fecha_inicio: e.target.value }))}
                            disabled={loading}
                            className="mt-1 h-9"
                        />
                    </div>
                    <div className="flex-1 max-w-[200px]">
                        <Label htmlFor="fecha_fin" className="text-xs font-medium text-gray-500">Fecha Fin</Label>
                        <Input
                            id="fecha_fin"
                            type="date"
                            value={filters.fecha_fin}
                            onChange={(e) => setFilters(prev => ({ ...prev, fecha_fin: e.target.value }))}
                            disabled={loading}
                            className="mt-1 h-9"
                        />
                    </div>
                </div>
                <div className="flex flex-wrap gap-1.5">
                    <Button
                        variant={filters.periodo === 'hoy' ? 'default' : 'outline'}
                        size="sm"
                        onClick={() => setPeriodo('hoy')}
                        disabled={loading}
                        className="h-9"
                    >
                        Hoy
                    </Button>
                    <Button
                        variant={filters.periodo === '7dias' ? 'default' : 'outline'}
                        size="sm"
                        onClick={() => setPeriodo('7dias')}
                        disabled={loading}
                        className="h-9"
                    >
                        7 Días
                    </Button>
                    <Button
                        variant={filters.periodo === '30dias' ? 'default' : 'outline'}
                        size="sm"
                        onClick={() => setPeriodo('30dias')}
                        disabled={loading}
                        className="h-9"
                    >
                        30 Días
                    </Button>
                    <Button
                        variant={filters.periodo === '90dias' ? 'default' : 'outline'}
                        size="sm"
                        onClick={() => setPeriodo('90dias')}
                        disabled={loading}
                        className="h-9"
                    >
                        90 Días
                    </Button>
                </div>
            </div>
        </div>
    );
}
