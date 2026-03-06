import { useState, useEffect } from 'react';
import { toast } from '@/lib/sweetalert';
import { confirmDelete } from '@/lib/sweetalert';
import { baseUrl } from '@/lib/baseUrl';

export const useBancos = () => {
    const [bancos, setBancos] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [selectedBanco, setSelectedBanco] = useState(null);

    useEffect(() => { fetchBancos(); }, []);

    const fetchBancos = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const response = await fetch(baseUrl('/api/bancos'), {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
            });
            const data = await response.json();
            if (data.success) { setBancos(data.data); setError(null); }
            else setError(data.message || 'Error al cargar bancos');
        } catch (err) {
            setError('Error de conexión al servidor');
        } finally {
            setLoading(false);
        }
    };

    const handleDelete = (banco) => {
        confirmDelete({
            title: 'Eliminar Banco',
            message: `¿Estás seguro de eliminar <strong>"${banco.nombre}"</strong>?`,
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem('auth_token');
                    const response = await fetch(baseUrl(`/api/bancos/${banco.id_banco}`), {
                        method: 'DELETE',
                        headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
                    });
                    const data = await response.json();
                    if (data.success) { toast.success('Banco eliminado'); fetchBancos(); }
                    else toast.error(data.message || 'Error al eliminar');
                } catch { toast.error('Error de conexión'); }
            },
        });
    };

    const handleEdit = (banco) => { setSelectedBanco(banco); setIsModalOpen(true); };
    const handleCreate = () => { setSelectedBanco(null); setIsModalOpen(true); };
    const handleModalClose = () => { setIsModalOpen(false); setSelectedBanco(null); };
    const handleModalSuccess = () => fetchBancos();

    return { bancos, loading, error, isModalOpen, selectedBanco, fetchBancos, handleDelete, handleEdit, handleCreate, handleModalClose, handleModalSuccess };
};
