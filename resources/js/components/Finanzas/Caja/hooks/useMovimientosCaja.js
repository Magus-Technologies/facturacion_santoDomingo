import { useState, useEffect } from 'react';
import { toast } from '@/lib/sweetalert';
import { baseUrl } from '@/lib/baseUrl';

export const useMovimientosCaja = (cajaId) => {
    const [movimientos, setMovimientos] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        if (cajaId) {
            fetchMovimientos();
        }
    }, [cajaId]);

    const fetchMovimientos = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl(`/api/cajas/${cajaId}/movimientos`), {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' }
            });
            const data = await res.json();
            if (data.success) {
                setMovimientos(data.data || []);
                setError(null);
            } else {
                setError(data.message || 'Error al cargar movimientos');
            }
        } catch (err) {
            setError('Error de conexión');
            toast.error('Error al cargar movimientos');
        } finally {
            setLoading(false);
        }
    };

    const registrarMovimiento = async (tipo, monto, concepto) => {
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl(`/api/cajas/${cajaId}/movimientos`), {
                method: 'POST',
                headers: {
                    Authorization: `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    Accept: 'application/json'
                },
                body: JSON.stringify({
                    tipo,
                    monto,
                    concepto
                })
            });
            const data = await res.json();
            if (data.success) {
                toast.success('Movimiento registrado');
                fetchMovimientos();
                return true;
            } else {
                toast.error(data.message || 'Error al registrar movimiento');
                return false;
            }
        } catch (err) {
            toast.error('Error de conexión');
            return false;
        }
    };

    const eliminarMovimiento = async (movimientoId) => {
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl(`/api/movimientos-caja/${movimientoId}`), {
                method: 'DELETE',
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: 'application/json'
                }
            });
            const data = await res.json();
            if (data.success) {
                toast.success('Movimiento eliminado');
                fetchMovimientos();
                return true;
            } else {
                toast.error(data.message || 'Error al eliminar movimiento');
                return false;
            }
        } catch (err) {
            toast.error('Error de conexión');
            return false;
        }
    };

    return {
        movimientos,
        loading,
        error,
        fetchMovimientos,
        registrarMovimiento,
        eliminarMovimiento,
    };
};
