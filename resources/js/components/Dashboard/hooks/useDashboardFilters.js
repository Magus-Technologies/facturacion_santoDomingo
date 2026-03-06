import { useState, useEffect } from 'react';
import { toast } from '@/lib/sweetalert';

export const useDashboardFilters = () => {
    const [filters, setFilters] = useState({
        fecha_inicio: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        fecha_fin: new Date().toISOString().split('T')[0],
        empresa_id: null,
        periodo: '7dias'
    });

    const [stats, setStats] = useState(null);
    const [ventasPorDia, setVentasPorDia] = useState([]);
    const [metodosPago, setMetodosPago] = useState([]);
    const [ingresosEgresos, setIngresosEgresos] = useState([]);
    const [topProductos, setTopProductos] = useState([]);
    const [topCategorias, setTopCategorias] = useState([]);
    const [topMarcas, setTopMarcas] = useState([]);
    const [topFechas, setTopFechas] = useState([]);
    const [ultimasTransacciones, setUltimasTransacciones] = useState([]);
    const [cajasPendientes, setCajasPendientes] = useState([]);

    // Nuevos estados
    const [rentabilidad, setRentabilidad] = useState([]);
    const [rentabilidadResumen, setRentabilidadResumen] = useState(null);
    const [topClientes, setTopClientes] = useState([]);
    const [ventasPorHora, setVentasPorHora] = useState([]);
    const [vendedores, setVendedores] = useState([]);
    const [stockBajo, setStockBajo] = useState([]);
    const [stockBajoTotal, setStockBajoTotal] = useState(0);

    const [loading, setLoading] = useState(false);

    const fetchDashboardData = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const params = new URLSearchParams({
                fecha_inicio: filters.fecha_inicio,
                fecha_fin: filters.fecha_fin,
                ...(filters.empresa_id && { empresa_id: filters.empresa_id })
            });

            const [
                statsRes, ventasRes, metodosRes, ingresosRes, productosRes,
                transRes, cajasRes, categoriasRes, marcasRes, fechasRes,
                rentabilidadRes, clientesRes, horaRes, vendedoresRes, stockRes
            ] = await Promise.all([
                fetch(`/api/dashboard/stats?${params}`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/ventas-por-dia?${params}`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/metodos-pago?${params}`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/ingresos-egresos?${params}`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/top-productos?${params}&limit=10`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/ultimas-transacciones?limit=10`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/cajas-pendientes`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/top-categorias?${params}&limit=10`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/top-marcas?${params}&limit=10`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/top-fechas?${params}&limit=10`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/rentabilidad?${params}&limit=15`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/top-clientes?${params}&limit=10`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/ventas-por-hora?${params}`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/vendedores?${params}`, { headers: { Authorization: `Bearer ${token}` } }),
                fetch(`/api/dashboard/stock-bajo`, { headers: { Authorization: `Bearer ${token}` } }),
            ]);

            const [
                statsData, ventasData, metodosData, ingresosData, productosData,
                transData, cajasData, categoriasData, marcasData, fechasData,
                rentabilidadData, clientesData, horaData, vendedoresData, stockData
            ] = await Promise.all([
                statsRes.json(), ventasRes.json(), metodosRes.json(), ingresosRes.json(), productosRes.json(),
                transRes.json(), cajasRes.json(), categoriasRes.json(), marcasRes.json(), fechasRes.json(),
                rentabilidadRes.json(), clientesRes.json(), horaRes.json(), vendedoresRes.json(), stockRes.json(),
            ]);

            if (statsData.success) setStats(statsData.data);
            if (ventasData.success) setVentasPorDia(ventasData.data);
            if (metodosData.success) setMetodosPago(metodosData.data);
            if (ingresosData.success) setIngresosEgresos(ingresosData.data);
            if (productosData.success) setTopProductos(productosData.data);
            if (transData.success) setUltimasTransacciones(transData.data);
            if (cajasData.success) setCajasPendientes(cajasData.data);
            if (categoriasData.success) setTopCategorias(categoriasData.data);
            if (marcasData.success) setTopMarcas(marcasData.data);
            if (fechasData.success) setTopFechas(fechasData.data);

            // Nuevos endpoints
            if (rentabilidadData.success) {
                setRentabilidad(rentabilidadData.data);
                setRentabilidadResumen(rentabilidadData.resumen);
            }
            if (clientesData.success) setTopClientes(clientesData.data);
            if (horaData.success) setVentasPorHora(horaData.data);
            if (vendedoresData.success) setVendedores(vendedoresData.data);
            if (stockData.success) {
                setStockBajo(stockData.data);
                setStockBajoTotal(stockData.total ?? 0);
            }
        } catch (error) {
            toast.error('Error al cargar datos del dashboard');
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchDashboardData();
    }, [filters]);

    const setPeriodo = (periodo) => {
        const hoy = new Date();
        let inicio;

        switch (periodo) {
            case 'hoy':
                inicio = new Date(hoy);
                break;
            case '7dias':
                inicio = new Date(hoy.getTime() - 7 * 24 * 60 * 60 * 1000);
                break;
            case '30dias':
                inicio = new Date(hoy.getTime() - 30 * 24 * 60 * 60 * 1000);
                break;
            case '90dias':
                inicio = new Date(hoy.getTime() - 90 * 24 * 60 * 60 * 1000);
                break;
            default:
                return;
        }

        setFilters(prev => ({
            ...prev,
            periodo,
            fecha_inicio: inicio.toISOString().split('T')[0],
            fecha_fin: hoy.toISOString().split('T')[0]
        }));
    };

    return {
        filters,
        setFilters,
        setPeriodo,
        stats,
        ventasPorDia,
        metodosPago,
        ingresosEgresos,
        topProductos,
        topCategorias,
        topMarcas,
        topFechas,
        ultimasTransacciones,
        cajasPendientes,
        // Nuevos
        rentabilidad,
        rentabilidadResumen,
        topClientes,
        ventasPorHora,
        vendedores,
        stockBajo,
        stockBajoTotal,
        loading
    };
};
