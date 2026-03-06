import { useState, useEffect } from 'react';
import { toast } from '@/lib/sweetalert';
import { baseUrl } from '@/lib/baseUrl';

export const useDenominaciones = () => {
    const [denominaciones, setDenominaciones] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        fetchDenominaciones();
    }, []);

    const fetchDenominaciones = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl('/api/cajas/denominaciones'), {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' }
            });
            const data = await res.json();
            if (data.success) {
                setDenominaciones(data.data || []);
                setError(null);
            } else {
                setError(data.message || 'Error al cargar denominaciones');
            }
        } catch (err) {
            setError('Error de conexión');
            toast.error('Error al cargar denominaciones');
        } finally {
            setLoading(false);
        }
    };

    const calcularTotal = (denoms) => {
        return denoms.reduce((sum, d) => sum + (d.subtotal || 0), 0);
    };

    return {
        denominaciones,
        loading,
        error,
        fetchDenominaciones,
        calcularTotal,
    };
};
