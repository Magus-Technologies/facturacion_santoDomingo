import { BarChart, Bar, PieChart, Pie, Cell, AreaChart, Area, RadarChart, Radar, PolarGrid, PolarAngleAxis, PolarRadiusAxis, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

// Monochromatic red palette from Santo Domingo brand
const RED_PALETTE = ['#c7161d', '#e63946', '#f07167', '#f4845f', '#f8961e', '#f9c74f'];
const RED_GRADIENT = ['#c7161d', '#d42a32', '#e13e47', '#ee525c', '#f87171', '#fca5a5'];

const chartCardStyle = "bg-white rounded-2xl border border-gray-100 p-6 shadow-sm";
const chartTitleStyle = "text-lg font-bold text-gray-900 mb-1";
const chartSubtitleStyle = "text-sm text-gray-400 mb-4";

const CustomTooltip = ({ active, payload, label, prefix = "S/." }) => {
    if (!active || !payload?.length) return null;
    return (
        <div className="bg-white rounded-xl shadow-xl border border-gray-100 p-3 min-w-[160px]">
            <p className="text-xs text-gray-400 font-medium mb-1.5">{label}</p>
            {payload.map((entry, index) => (
                <div key={index} className="flex items-center justify-between gap-4">
                    <div className="flex items-center gap-2">
                        <div className="w-2.5 h-2.5 rounded-full" style={{ backgroundColor: entry.color }} />
                        <span className="text-xs text-gray-600">{entry.name}</span>
                    </div>
                    <span className="text-sm font-bold text-gray-900">
                        {prefix} {typeof entry.value === 'number' ? entry.value.toLocaleString('es-PE', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) : entry.value}
                    </span>
                </div>
            ))}
        </div>
    );
};

export function VentasPorDiaChart({ data }) {
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Ventas por Día</h3>
            <p className={chartSubtitleStyle}>Período actual vs período anterior</p>
            <ResponsiveContainer width="100%" height={300}>
                <AreaChart data={data}>
                    <defs>
                        <linearGradient id="gradActual" x1="0" y1="0" x2="0" y2="1">
                            <stop offset="0%" stopColor="#c7161d" stopOpacity={0.25} />
                            <stop offset="100%" stopColor="#c7161d" stopOpacity={0.02} />
                        </linearGradient>
                        <linearGradient id="gradAnterior" x1="0" y1="0" x2="0" y2="1">
                            <stop offset="0%" stopColor="#9ca3af" stopOpacity={0.2} />
                            <stop offset="100%" stopColor="#9ca3af" stopOpacity={0.02} />
                        </linearGradient>
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" vertical={false} />
                    <XAxis dataKey="fecha" tick={{ fill: '#9ca3af', fontSize: 11 }} axisLine={false} tickLine={false} />
                    <YAxis tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <Tooltip content={<CustomTooltip />} />
                    <Legend iconType="circle" />
                    <Area type="monotone" dataKey="total_anterior" name="Período anterior" stroke="#9ca3af" strokeWidth={1.5} strokeDasharray="5 3" fill="url(#gradAnterior)" dot={false} activeDot={{ r: 4, fill: '#9ca3af', stroke: '#fff', strokeWidth: 2 }} />
                    <Area type="monotone" dataKey="total" name="Período actual" stroke="#c7161d" strokeWidth={2.5} fill="url(#gradActual)" dot={false} activeDot={{ r: 6, fill: '#c7161d', stroke: '#fff', strokeWidth: 3 }} />
                </AreaChart>
            </ResponsiveContainer>
        </div>
    );
}

export function MetodosPagoChart({ data }) {
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Métodos de Pago</h3>
            <p className={chartSubtitleStyle}>Distribución por método de pago</p>
            <ResponsiveContainer width="100%" height={300}>
                <PieChart>
                    <Pie
                        data={data}
                        cx="50%"
                        cy="50%"
                        innerRadius={55}
                        outerRadius={95}
                        fill="#c7161d"
                        dataKey="total"
                        paddingAngle={3}
                        label={({ nombre, percent }) => `${nombre} ${(percent * 100).toFixed(0)}%`}
                    >
                        {data.map((entry, index) => (
                            <Cell key={`cell-${index}`} fill={RED_PALETTE[index % RED_PALETTE.length]} stroke="none" />
                        ))}
                    </Pie>
                    <Tooltip content={<CustomTooltip />} />
                </PieChart>
            </ResponsiveContainer>
        </div>
    );
}

export function IngresosEgresosChart({ data }) {
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Ingresos vs Egresos</h3>
            <p className={chartSubtitleStyle}>Flujo de caja acumulado por período</p>
            <ResponsiveContainer width="100%" height={300}>
                <AreaChart data={data}>
                    <defs>
                        <linearGradient id="gradIngresos" x1="0" y1="0" x2="0" y2="1">
                            <stop offset="0%" stopColor="#c7161d" stopOpacity={0.25} />
                            <stop offset="100%" stopColor="#c7161d" stopOpacity={0.02} />
                        </linearGradient>
                        <linearGradient id="gradEgresos" x1="0" y1="0" x2="0" y2="1">
                            <stop offset="0%" stopColor="#fca5a5" stopOpacity={0.35} />
                            <stop offset="100%" stopColor="#fca5a5" stopOpacity={0.02} />
                        </linearGradient>
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" vertical={false} />
                    <XAxis dataKey="fecha" tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <YAxis tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <Tooltip content={<CustomTooltip />} />
                    <Legend iconType="circle" />
                    <Area type="monotone" dataKey="ingresos" name="Ingresos" stroke="#c7161d" strokeWidth={2.5} fill="url(#gradIngresos)" dot={false} activeDot={{ r: 5, fill: '#c7161d', stroke: '#fff', strokeWidth: 2 }} />
                    <Area type="monotone" dataKey="egresos" name="Egresos" stroke="#f07167" strokeWidth={2} fill="url(#gradEgresos)" dot={false} activeDot={{ r: 5, fill: '#f07167', stroke: '#fff', strokeWidth: 2 }} />
                </AreaChart>
            </ResponsiveContainer>
        </div>
    );
}

export function TopProductosChart({ data }) {
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Top Productos</h3>
            <p className={chartSubtitleStyle}>Productos más vendidos por cantidad</p>
            <ResponsiveContainer width="100%" height={300}>
                <BarChart data={data} layout="vertical" barSize={20}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" horizontal={false} />
                    <XAxis type="number" tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <YAxis dataKey="nombre" type="category" width={130} tick={{ fill: '#4b5563', fontSize: 11 }} axisLine={false} tickLine={false} />
                    <Tooltip content={<CustomTooltip prefix="" />} />
                    <Bar dataKey="cantidad" name="Unidades" radius={[0, 6, 6, 0]}>
                        {data.map((entry, index) => (
                            <Cell key={`cell-${index}`} fill={RED_GRADIENT[index % RED_GRADIENT.length]} />
                        ))}
                    </Bar>
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
}

export function TopCategoriasChart({ data }) {
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Ventas por Categoría</h3>
            <p className={chartSubtitleStyle}>Monto total vendido por categoría</p>
            <ResponsiveContainer width="100%" height={300}>
                <BarChart data={data} layout="vertical" barSize={20}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" horizontal={false} />
                    <XAxis type="number" tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <YAxis dataKey="categoria" type="category" width={130} tick={{ fill: '#4b5563', fontSize: 11 }} axisLine={false} tickLine={false} />
                    <Tooltip content={<CustomTooltip />} />
                    <Bar dataKey="monto_total" name="Monto Total" radius={[0, 6, 6, 0]}>
                        {data.map((entry, index) => (
                            <Cell key={`cell-${index}`} fill={RED_GRADIENT[index % RED_GRADIENT.length]} />
                        ))}
                    </Bar>
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
}

export function TopMarcasChart({ data }) {
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Rendimiento por Marca</h3>
            <p className={chartSubtitleStyle}>Ingresos y unidades vendidas por marca</p>
            {data.length === 0 ? (
                <div className="flex items-center justify-center h-[450px] text-gray-400">
                    <p>No hay datos de marcas para este período</p>
                </div>
            ) : (
                <ResponsiveContainer width="100%" height={450}>
                    <PieChart>
                        <Pie
                            data={data}
                            cx="50%"
                            cy="50%"
                            innerRadius={55}
                            outerRadius={95}
                            fill="#c7161d"
                            dataKey="monto_total"
                            nameKey="categoria"
                            paddingAngle={3}
                            label={({ categoria, percent }) => `${categoria} ${(percent * 100).toFixed(0)}%`}
                        >
                            {data.map((entry, index) => (
                                <Cell key={`cell-${index}`} fill={RED_PALETTE[index % RED_PALETTE.length]} stroke="none" />
                            ))}
                        </Pie>
                        <Tooltip content={<CustomTooltip />} />
                    </PieChart>
                </ResponsiveContainer>
            )}
        </div>
    );
}

export function TopFechasChart({ data }) {
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Fechas con Mayor Venta</h3>
            <p className={chartSubtitleStyle}>Top días con mayor volumen de ventas</p>
            <ResponsiveContainer width="100%" height={300}>
                <BarChart data={data} barSize={28}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" vertical={false} />
                    <XAxis dataKey="fecha" tick={{ fill: '#9ca3af', fontSize: 11 }} axisLine={false} tickLine={false} />
                    <YAxis tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <Tooltip content={<CustomTooltip />} />
                    <Bar dataKey="monto_total" name="Monto Total" radius={[6, 6, 0, 0]}>
                        {data.map((entry, index) => (
                            <Cell key={`cell-${index}`} fill={RED_GRADIENT[index % RED_GRADIENT.length]} />
                        ))}
                    </Bar>
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
}

export function RentabilidadChart({ data }) {
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Margen de Ganancia por Producto</h3>
            <p className={chartSubtitleStyle}>Top productos por % de margen sobre ventas</p>
            <ResponsiveContainer width="100%" height={350}>
                <BarChart data={data} layout="vertical" barSize={18}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" horizontal={false} />
                    <XAxis type="number" unit="%" tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <YAxis dataKey="nombre" type="category" width={140} tick={{ fill: '#4b5563', fontSize: 11 }} axisLine={false} tickLine={false} />
                    <Tooltip content={<CustomTooltip prefix="" />} formatter={(v) => [`${v}%`, 'Margen']} />
                    <Bar dataKey="margen_porcentaje" name="Margen %" radius={[0, 6, 6, 0]}>
                        {data.map((entry, index) => (
                            <Cell key={`cell-${index}`} fill={entry.margen_porcentaje >= 30 ? '#16a34a' : entry.margen_porcentaje >= 15 ? '#f59e0b' : '#dc2626'} />
                        ))}
                    </Bar>
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
}

export function GananciaVsIngresoChart({ data }) {
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Ingreso vs Ganancia</h3>
            <p className={chartSubtitleStyle}>Comparativa por producto (top rentables)</p>
            <ResponsiveContainer width="100%" height={350}>
                <BarChart data={data} layout="vertical" barGap={3} barSize={10}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" horizontal={false} />
                    <XAxis type="number" tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <YAxis dataKey="nombre" type="category" width={140} tick={{ fill: '#4b5563', fontSize: 11 }} axisLine={false} tickLine={false} />
                    <Tooltip content={<CustomTooltip />} />
                    <Legend iconType="circle" />
                    <Bar dataKey="ingresos" name="Ingresos" fill="#c7161d" radius={[0, 6, 6, 0]} />
                    <Bar dataKey="ganancia" name="Ganancia" fill="#16a34a" radius={[0, 6, 6, 0]} />
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
}

export function TopClientesChart({ data }) {
    const top5 = data.slice(0, 5);
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Concentración de Clientes</h3>
            <p className={chartSubtitleStyle}>Share de ventas por cliente (top 5)</p>
            {top5.length === 0 ? (
                <div className="flex items-center justify-center h-[450px] text-gray-400">
                    <p>No hay datos de clientes para este período</p>
                </div>
            ) : (
                <ResponsiveContainer width="100%" height={450}>
                    <PieChart>
                        <Pie
                            data={top5}
                            cx="50%"
                            cy="50%"
                            innerRadius={55}
                            outerRadius={95}
                            fill="#c7161d"
                            dataKey="monto_total"
                            nameKey="nombre"
                            paddingAngle={3}
                            label={({ nombre, percent }) => `${nombre} ${(percent * 100).toFixed(0)}%`}
                        >
                            {top5.map((entry, index) => (
                                <Cell key={`cell-${index}`} fill={RED_PALETTE[index % RED_PALETTE.length]} stroke="none" />
                            ))}
                        </Pie>
                        <Tooltip content={<CustomTooltip />} />
                    </PieChart>
                </ResponsiveContainer>
            )}
        </div>
    );
}

export function VentasPorHoraChart({ data }) {
    const dataFiltrada = data.filter(d => d.hora >= 6 && d.hora <= 22);
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Ventas por Hora del Día</h3>
            <p className={chartSubtitleStyle}>Curva de actividad comercial por franja horaria</p>
            <ResponsiveContainer width="100%" height={280}>
                <AreaChart data={dataFiltrada}>
                    <defs>
                        <linearGradient id="gradHora" x1="0" y1="0" x2="0" y2="1">
                            <stop offset="0%" stopColor="#c7161d" stopOpacity={0.3} />
                            <stop offset="100%" stopColor="#c7161d" stopOpacity={0.02} />
                        </linearGradient>
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" vertical={false} />
                    <XAxis dataKey="hora_label" tick={{ fill: '#9ca3af', fontSize: 11 }} axisLine={false} tickLine={false} />
                    <YAxis tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <Tooltip content={<CustomTooltip prefix="" />} />
                    <Area type="monotone" dataKey="total_ventas" name="Transacciones" stroke="#c7161d" strokeWidth={2.5} fill="url(#gradHora)" dot={{ fill: '#c7161d', r: 3, stroke: '#fff', strokeWidth: 2 }} activeDot={{ r: 6, fill: '#c7161d', stroke: '#fff', strokeWidth: 2 }} />
                </AreaChart>
            </ResponsiveContainer>
        </div>
    );
}

export function VendedoresChart({ data }) {
    // Normalizar valores para radar (0–100 relativo al máximo)
    const maxMonto = Math.max(...data.map(d => d.monto_total || 0), 1);
    const maxTickets = Math.max(...data.map(d => d.total_ventas || 0), 1);
    const maxPromedio = Math.max(...data.map(d => d.ticket_promedio || 0), 1);
    const radarData = [
        { metric: 'Monto', ...Object.fromEntries(data.map(d => [d.vendedor, Math.round((d.monto_total / maxMonto) * 100)])) },
        { metric: 'Tickets', ...Object.fromEntries(data.map(d => [d.vendedor, Math.round(((d.total_ventas || 0) / maxTickets) * 100)])) },
        { metric: 'Promedio', ...Object.fromEntries(data.map(d => [d.vendedor, Math.round(((d.ticket_promedio || 0) / maxPromedio) * 100)])) },
    ];
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Rendimiento por Vendedor</h3>
            <p className={chartSubtitleStyle}>Comparativa multidimensional (monto, tickets, ticket promedio)</p>
            <ResponsiveContainer width="100%" height={320}>
                <RadarChart data={radarData} cx="50%" cy="50%" outerRadius={100}>
                    <PolarGrid stroke="#f3f4f6" />
                    <PolarAngleAxis dataKey="metric" tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <PolarRadiusAxis angle={90} domain={[0, 100]} tick={false} axisLine={false} />
                    {data.slice(0, 4).map((vendedor, index) => (
                        <Radar
                            key={vendedor.vendedor}
                            name={vendedor.vendedor}
                            dataKey={vendedor.vendedor}
                            stroke={RED_PALETTE[index % RED_PALETTE.length]}
                            fill={RED_PALETTE[index % RED_PALETTE.length]}
                            fillOpacity={0.15}
                            strokeWidth={2}
                        />
                    ))}
                    <Legend iconType="circle" iconSize={8} />
                    <Tooltip formatter={(v, name) => [`${v}`, name]} />
                </RadarChart>
            </ResponsiveContainer>
        </div>
    );
}
