import { useState, useEffect } from 'react';
import { toast } from '@/lib/sweetalert';
import { baseUrl } from '@/lib/baseUrl';

const getAuthHeaders = () => {
    const token = localStorage.getItem('auth_token');
    return {
        Authorization: `Bearer ${token}`,
        Accept: 'application/json',
        'Content-Type': 'application/json',
    };
};

export const useNotasCredito = () => {
    const [notas, setNotas] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [motivos, setMotivos] = useState([]);

    useEffect(() => {
        fetchNotas();
        fetchMotivos();
    }, []);

    const fetchNotas = async () => {
        try {
            setLoading(true);
            setError(null);
            const res = await fetch(baseUrl('/api/notas-credito'), {
                headers: getAuthHeaders(),
            });
            const data = await res.json();
            setNotas(data.data || []);
        } catch (err) {
            setError('Error al cargar las notas de crédito');
            console.error('Error:', err);
        } finally {
            setLoading(false);
        }
    };

    const fetchMotivos = async () => {
        try {
            const res = await fetch(baseUrl('/api/notas-credito/motivos'), {
                headers: getAuthHeaders(),
            });
            const data = await res.json();
            if (data.success) {
                setMotivos(data.data);
            }
        } catch (err) {
            console.error('Error:', err);
        }
    };

    const crearNota = async (payload) => {
        try {
            const res = await fetch(baseUrl('/api/notas-credito'), {
                method: 'POST',
                headers: getAuthHeaders(),
                body: JSON.stringify(payload),
            });
            const data = await res.json();

            if (data.success) {
                toast.success('Nota de crédito creada y XML generado');
                fetchNotas();
                return data;
            } else {
                toast.error(data.message || 'Error al crear nota de crédito');
                return data;
            }
        } catch (err) {
            toast.error('Error de conexión');
            return { success: false, message: err.message };
        }
    };

    const enviarNota = async (id) => {
        try {
            const res = await fetch(baseUrl(`/api/notas-credito/${id}/enviar`), {
                method: 'POST',
                headers: getAuthHeaders(),
            });
            const data = await res.json();

            if (data.success) {
                toast.success(`Enviado a SUNAT: ${data.mensaje || 'Aceptado'}`);
                fetchNotas();
            } else {
                toast.error(data.message || 'Error al enviar a SUNAT');
            }

            return data;
        } catch (err) {
            toast.error('Error de conexión');
            return { success: false, message: err.message };
        }
    };

    const buscarVenta = async (serie, numero) => {
        try {
            const params = new URLSearchParams({ serie, numero });
            const res = await fetch(baseUrl(`/api/notas-credito/buscar-venta?${params}`), {
                headers: getAuthHeaders(),
            });
            const data = await res.json();

            if (data.success && data.venta) {
                return { success: true, venta: data.venta };
            }
            return { success: false, message: data.message || 'Venta no encontrada' };
        } catch {
            return { success: false, message: 'Error al buscar venta' };
        }
    };

    return {
        notas,
        loading,
        error,
        motivos,
        fetchNotas,
        crearNota,
        enviarNota,
        buscarVenta,
    };
};
