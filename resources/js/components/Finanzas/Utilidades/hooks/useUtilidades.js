import { useState, useEffect, useCallback } from 'react';

const PERIODOS = [
    { id: 'hoy',    label: 'HOY' },
    { id: 'semana', label: 'SEMANA' },
    { id: 'mes',    label: 'MES' },
    { id: 'año',    label: 'AÑO' },
];

export function useUtilidades() {
    const [periodo, setPeriodo]   = useState('mes');
    const [data, setData]         = useState(null);
    const [loading, setLoading]   = useState(true);
    const [error, setError]       = useState(null);

    const fetchData = useCallback(async (p = periodo) => {
        try {
            setLoading(true);
            setError(null);
            const token   = localStorage.getItem('auth_token');
            const headers = { Authorization: `Bearer ${token}`, Accept: 'application/json' };
            const res     = await fetch(`/api/finanzas/utilidades?periodo=${p}`, { headers });
            const json    = await res.json();
            if (json.success) {
                setData(json.data);
            } else {
                setError(json.message || 'Error al cargar datos');
            }
        } catch (e) {
            setError('Error de conexión');
        } finally {
            setLoading(false);
        }
    }, [periodo]);

    useEffect(() => { fetchData(periodo); }, [periodo]);

    const cambiarPeriodo = (p) => setPeriodo(p);

    return { data, loading, error, periodo, cambiarPeriodo, PERIODOS, refetch: fetchData };
}
