import { useState, useEffect, useCallback } from "react";

const getAuthHeaders = () => ({
    Authorization: `Bearer ${localStorage.getItem("auth_token")}`,
    Accept: "application/json",
});

export const useMovimientosStock = () => {
    const [movimientos, setMovimientos] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [filtros, setFiltros] = useState({
        tipo_movimiento: "",
        tipo_documento: "",
        id_almacen: "",
        fecha_desde: "",
        fecha_hasta: "",
        search: "",
    });

    const fetchMovimientos = useCallback(async (filtrosActuales = filtros) => {
        try {
            setLoading(true);
            setError(null);

            const params = new URLSearchParams();
            Object.entries(filtrosActuales).forEach(([key, value]) => {
                if (value) params.append(key, value);
            });

            const res = await fetch(`/api/movimientos-stock?${params}`, {
                headers: getAuthHeaders(),
            });
            const data = await res.json();

            if (data.success) {
                setMovimientos(data.data || []);
            } else {
                setError(data.message || "Error al cargar movimientos");
            }
        } catch (err) {
            setError("Error de conexión");
            console.error("Error:", err);
        } finally {
            setLoading(false);
        }
    }, [filtros]);

    useEffect(() => {
        fetchMovimientos();
    }, []);

    const aplicarFiltros = (nuevosFiltros) => {
        const filtrosActualizados = { ...filtros, ...nuevosFiltros };
        setFiltros(filtrosActualizados);
        fetchMovimientos(filtrosActualizados);
    };

    const limpiarFiltros = () => {
        const filtrosLimpios = {
            tipo_movimiento: "",
            tipo_documento: "",
            id_almacen: "",
            fecha_desde: "",
            fecha_hasta: "",
            search: "",
        };
        setFiltros(filtrosLimpios);
        fetchMovimientos(filtrosLimpios);
    };

    return {
        movimientos,
        loading,
        error,
        filtros,
        aplicarFiltros,
        limpiarFiltros,
        refetch: () => fetchMovimientos(filtros),
    };
};
