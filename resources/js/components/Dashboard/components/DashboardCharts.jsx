import { LineChart, Line, BarChart, Bar, PieChart, Pie, Cell, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

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
            <p className={chartSubtitleStyle}>Evolución de ventas diarias</p>
            <ResponsiveContainer width="100%" height={300}>
                <LineChart data={data}>
                    <defs>
                        <linearGradient id="ventasGrad" x1="0" y1="0" x2="0" y2="1">
                            <stop offset="0%" stopColor="#c7161d" stopOpacity={0.15} />
                            <stop offset="100%" stopColor="#c7161d" stopOpacity={0} />
                        </linearGradient>
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" vertical={false} />
                    <XAxis dataKey="fecha" tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <YAxis tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <Tooltip content={<CustomTooltip />} />
                    <Line type="monotone" dataKey="total" stroke="#c7161d" strokeWidth={3} dot={{ fill: '#c7161d', r: 4, strokeWidth: 2, stroke: '#fff' }} activeDot={{ r: 6, fill: '#c7161d', stroke: '#fff', strokeWidth: 3 }} name="Ventas" />
                </LineChart>
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
            <p className={chartSubtitleStyle}>Comparativa de flujo de caja</p>
            <ResponsiveContainer width="100%" height={300}>
                <BarChart data={data} barGap={4}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" vertical={false} />
                    <XAxis dataKey="fecha" tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <YAxis tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <Tooltip content={<CustomTooltip />} />
                    <Legend iconType="circle" />
                    <Bar dataKey="ingresos" fill="#c7161d" name="Ingresos" radius={[6, 6, 0, 0]} />
                    <Bar dataKey="egresos" fill="#fca5a5" name="Egresos" radius={[6, 6, 0, 0]} />
                </BarChart>
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
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Top Clientes</h3>
            <p className={chartSubtitleStyle}>Clientes con mayor monto de compras</p>
            <ResponsiveContainer width="100%" height={300}>
                <BarChart data={data} layout="vertical" barSize={20}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" horizontal={false} />
                    <XAxis type="number" tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <YAxis dataKey="nombre" type="category" width={140} tick={{ fill: '#4b5563', fontSize: 11 }} axisLine={false} tickLine={false} />
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

export function VentasPorHoraChart({ data }) {
    // Solo mostrar horas con actividad o rango laboral (6–22)
    const dataFiltrada = data.filter(d => d.hora >= 6 && d.hora <= 22);
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Ventas por Hora del Día</h3>
            <p className={chartSubtitleStyle}>Distribución de transacciones por franja horaria</p>
            <ResponsiveContainer width="100%" height={280}>
                <BarChart data={dataFiltrada} barSize={24}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" vertical={false} />
                    <XAxis dataKey="hora_label" tick={{ fill: '#9ca3af', fontSize: 11 }} axisLine={false} tickLine={false} />
                    <YAxis tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <Tooltip content={<CustomTooltip prefix="" />} />
                    <Bar dataKey="total_ventas" name="Transacciones" radius={[6, 6, 0, 0]}>
                        {dataFiltrada.map((entry, index) => (
                            <Cell key={`cell-${index}`} fill={entry.total_ventas === Math.max(...dataFiltrada.map(d => d.total_ventas)) ? '#c7161d' : '#fca5a5'} />
                        ))}
                    </Bar>
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
}

export function VendedoresChart({ data }) {
    return (
        <div className={chartCardStyle}>
            <h3 className={chartTitleStyle}>Rendimiento por Vendedor</h3>
            <p className={chartSubtitleStyle}>Monto total vendido por cada vendedor</p>
            <ResponsiveContainer width="100%" height={300}>
                <BarChart data={data} layout="vertical" barSize={22}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#f3f4f6" horizontal={false} />
                    <XAxis type="number" tick={{ fill: '#9ca3af', fontSize: 12 }} axisLine={false} tickLine={false} />
                    <YAxis dataKey="vendedor" type="category" width={130} tick={{ fill: '#4b5563', fontSize: 11 }} axisLine={false} tickLine={false} />
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
