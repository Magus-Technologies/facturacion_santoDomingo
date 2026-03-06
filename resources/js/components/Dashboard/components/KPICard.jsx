import { TrendingUp, TrendingDown } from 'lucide-react';

export default function KPICard({ title, value, change, icon: Icon, color = 'primary' }) {
    const isPositive = change >= 0;

    return (
        <div className="bg-white rounded-2xl border border-gray-100 p-6 shadow-sm hover:shadow-lg hover:shadow-red-100/50 transition-all duration-300 group">
            <div className="flex items-start justify-between">
                <div className="flex-1">
                    <p className="text-sm font-medium text-gray-500 tracking-wide uppercase">{title}</p>
                    <p className="text-2xl font-bold text-gray-900 mt-2">{value}</p>
                    {change !== undefined && (
                        <div className="flex items-center gap-1.5 mt-3">
                            {isPositive ? (
                                <div className="flex items-center gap-1 px-2 py-0.5 rounded-full bg-green-50">
                                    <TrendingUp className="h-3.5 w-3.5 text-green-600" />
                                    <span className="text-xs font-semibold text-green-600">
                                        +{change}%
                                    </span>
                                </div>
                            ) : (
                                <div className="flex items-center gap-1 px-2 py-0.5 rounded-full bg-red-50">
                                    <TrendingDown className="h-3.5 w-3.5 text-red-600" />
                                    <span className="text-xs font-semibold text-red-600">
                                        {change}%
                                    </span>
                                </div>
                            )}
                            <span className="text-xs text-gray-400">vs periodo anterior</span>
                        </div>
                    )}
                </div>
                {Icon && (
                    <div className="p-3 rounded-xl bg-gradient-to-br from-red-500 to-red-600 text-white shadow-md shadow-red-200 group-hover:shadow-lg group-hover:shadow-red-300 transition-all duration-300">
                        <Icon className="h-5 w-5" />
                    </div>
                )}
            </div>
            {/* Bottom accent line */}
            <div className="mt-4 h-1 w-full bg-gradient-to-r from-red-500 via-red-400 to-red-200 rounded-full opacity-30 group-hover:opacity-60 transition-opacity duration-300" />
        </div>
    );
}
