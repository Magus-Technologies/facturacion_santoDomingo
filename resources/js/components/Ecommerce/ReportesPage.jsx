import { BarChart3, TrendingUp, Users, ShoppingCart } from 'lucide-react';

export default function ReportesPage() {
    const stats = [
        { label: 'Ventas Totales', value: 'S/. 45,230', icon: TrendingUp, color: 'bg-green-500' },
        { label: 'Clientes', value: '1,234', icon: Users, color: 'bg-blue-500' },
        { label: 'Pedidos', value: '567', icon: ShoppingCart, color: 'bg-orange-500' },
        { label: 'Productos', value: '892', icon: BarChart3, color: 'bg-purple-500' },
    ];

    return (
        <div className="space-y-6">
            <h1 className="text-3xl font-bold text-gray-900">Reportes de Ventas</h1>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                {stats.map((stat, idx) => {
                    const Icon = stat.icon;
                    return (
                        <div key={idx} className="bg-white rounded-lg shadow p-6">
                            <div className="flex items-center justify-between">
                                <div>
                                    <p className="text-gray-600 text-sm">{stat.label}</p>
                                    <p className="text-2xl font-bold text-gray-900 mt-2">{stat.value}</p>
                                </div>
                                <div className={`${stat.color} p-3 rounded-lg`}>
                                    <Icon className="w-6 h-6 text-white" />
                                </div>
                            </div>
                        </div>
                    );
                })}
            </div>

            <div className="bg-white rounded-lg shadow p-6">
                <h2 className="text-xl font-semibold text-gray-900 mb-4">Gráfico de Ventas</h2>
                <div className="h-64 bg-gray-100 rounded flex items-center justify-center text-gray-500">
                    Gráfico de ventas (próximamente)
                </div>
            </div>
        </div>
    );
}
