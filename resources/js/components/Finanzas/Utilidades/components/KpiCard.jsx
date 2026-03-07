import { ArrowUpRight, ArrowDownRight } from 'lucide-react';
import { Card, CardContent } from '@/components/ui/card';

// Formateadores locales requeridos temporalmente si no se pasan calculados
const pct = (n) => `${parseFloat(n ?? 0).toFixed(1)}%`;

export function KpiCard({ label, value, trend, trendValue, icon: Icon, color = 'text-gray-900' }) {
    const isTrendPositive = trend >= 0;
    return (
        <Card className="border-gray-200">
            <CardContent className="pt-6">
                <div className="flex items-start justify-between">
                    <div className="flex-1">
                        <p className="text-xs font-semibold uppercase tracking-wider text-gray-600 mb-2">{label}</p>
                        <p className={`text-2xl font-bold ${color}`}>{value}</p>
                        {trendValue !== undefined && (
                            <div className={`flex items-center gap-1 mt-2 text-xs font-medium ${isTrendPositive ? 'text-green-700' : 'text-red-700'}`}>
                                {isTrendPositive ? <ArrowUpRight className="h-3 w-3" /> : <ArrowDownRight className="h-3 w-3" />}
                                {pct(Math.abs(trend))} vs anterior
                            </div>
                        )}
                    </div>
                    {Icon && (
                        <div className={`p-3 rounded-lg ${color === 'text-green-700' ? 'bg-green-100' : color === 'text-red-700' ? 'bg-red-100' : color === 'text-blue-700' ? 'bg-blue-100' : 'bg-gray-100'}`}>
                            <Icon className={`h-6 w-6 ${color}`} />
                        </div>
                    )}
                </div>
            </CardContent>
        </Card>
    );
}

export function KpiStrip({ items }) {
    return (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
            {items.map((item, i) => (
                <KpiCard key={i} {...item} />
            ))}
        </div>
    );
}
