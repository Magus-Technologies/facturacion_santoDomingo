import { useState, useEffect } from 'react';
import { toast, confirmDelete } from '@/lib/sweetalert';

export const useMetodosPago = () => {
    const [metodos, setMetodos] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [selectedMetodo, setSelectedMetodo] = useState(null);

    useEffect(() => { fetchMetodos(); }, []);

    const fetchMetodos = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const response = await fetch('/api/metodos-pago', {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
            });
            const data = await response.json();
            if (data.success) { setMetodos(data.data); setError(null); }
            else setError(data.message || 'Error al cargar métodos');
        } catch { setError('Error de conexión'); }
        finally { setLoading(false); }
    };

    const handleDelete = (metodo) => {
        confirmDelete({
            title: 'Eliminar Método de Pago',
            message: `¿Eliminar <strong>"${metodo.nombre}"</strong>?`,
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem('auth_token');
                    const response = await fetch(`/api/metodos-pago/${metodo.id_metodo_pago}`, {
                        method: 'DELETE',
                        headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
                    });
                    const data = await response.json();
                    if (data.success) { toast.success('Método eliminado'); fetchMetodos(); }
                    else toast.error(data.message || 'No se puede eliminar');
                } catch { toast.error('Error de conexión'); }
            },
        });
    };

    const handleEdit = (metodo) => { setSelectedMetodo(metodo); setIsModalOpen(true); };
    const handleCreate = () => { setSelectedMetodo(null); setIsModalOpen(true); };
    const handleModalClose = () => { setIsModalOpen(false); setSelectedMetodo(null); };
    const handleModalSuccess = () => fetchMetodos();

    return { metodos, loading, error, isModalOpen, selectedMetodo, fetchMetodos, handleDelete, handleEdit, handleCreate, handleModalClose, handleModalSuccess };
};
