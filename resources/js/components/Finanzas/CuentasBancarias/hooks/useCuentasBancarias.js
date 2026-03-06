import { useState, useEffect } from 'react';
import { toast, confirmDelete } from '@/lib/sweetalert';
import { baseUrl } from '@/lib/baseUrl';

export const useCuentasBancarias = () => {
    const [cuentas, setCuentas] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [selectedCuenta, setSelectedCuenta] = useState(null);
    const [isDetalleOpen, setIsDetalleOpen] = useState(false);
    const [cuentaDetalle, setCuentaDetalle] = useState(null);

    useEffect(() => { fetchCuentas(); }, []);

    const fetchCuentas = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl('/api/cuentas-bancarias'), {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
            });
            const data = await res.json();
            if (data.success) { setCuentas(data.data); setError(null); }
            else setError(data.message || 'Error al cargar cuentas');
        } catch {
            setError('Error de conexión al servidor');
        } finally {
            setLoading(false);
        }
    };

    const handleDelete = (cuenta) => {
        confirmDelete({
            title: 'Eliminar Cuenta Bancaria',
            message: `¿Estás seguro de eliminar la cuenta <strong>${cuenta.numero_cuenta}</strong>?`,
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem('auth_token');
                    const res = await fetch(baseUrl(`/api/cuentas-bancarias/${cuenta.id_cuenta}`), {
                        method: 'DELETE',
                        headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
                    });
                    const data = await res.json();
                    if (data.success) { toast.success('Cuenta eliminada'); fetchCuentas(); }
                    else toast.error(data.message || 'Error al eliminar');
                } catch { toast.error('Error de conexión'); }
            },
        });
    };

    const handleEdit = (cuenta) => { setSelectedCuenta(cuenta); setIsModalOpen(true); };
    const handleCreate = () => { setSelectedCuenta(null); setIsModalOpen(true); };
    const handleModalClose = () => { setIsModalOpen(false); setSelectedCuenta(null); };
    const handleModalSuccess = () => fetchCuentas();

    const handleVerDetalle = (cuenta) => { setCuentaDetalle(cuenta); setIsDetalleOpen(true); };
    const handleDetalleClose = () => { setIsDetalleOpen(false); setCuentaDetalle(null); };

    return {
        cuentas, loading, error,
        isModalOpen, selectedCuenta,
        isDetalleOpen, cuentaDetalle,
        fetchCuentas, handleDelete, handleEdit, handleCreate, handleModalClose, handleModalSuccess,
        handleVerDetalle, handleDetalleClose,
    };
};
