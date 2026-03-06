import { useState, useEffect } from 'react';
import { toast } from '@/lib/sweetalert';
import { baseUrl } from '@/lib/baseUrl';

export const useCuentasPorCobrar = () => {
    const [cuotas, setCuotas] = useState([]);
    const [resumen, setResumen] = useState({});
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        cargarCuotas();
    }, []);

    const cargarCuotas = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('auth_token');
            const response = await fetch(baseUrl('/api/cuentas-por-cobrar'), {
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Accept': 'application/json'
                }
            });
            const data = await response.json();
            if (data.success) {
                setCuotas(data.data || []);
                setResumen(data.resumen || {});
            }
        } catch (error) {
            console.error('Error:', error);
            toast.error('Error al cargar cuentas por cobrar');
        } finally {
            setLoading(false);
        }
    };

    const registrarPago = async (id, pagoData) => {
        try {
            const token = localStorage.getItem('auth_token');
            const response = await fetch(baseUrl(`/api/cuentas-por-cobrar/${id}/pagar`), {
                method: 'POST',
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(pagoData)
            });
            const data = await response.json();
            if (data.success) {
                toast.success(data.message);
                cargarCuotas();
                return true;
            } else {
                toast.error(data.message || 'Error al registrar pago');
                return false;
            }
        } catch (error) {
            console.error('Error:', error);
            toast.error('Error al registrar pago');
            return false;
        }
    };

    return { cuotas, resumen, loading, registrarPago };
};
