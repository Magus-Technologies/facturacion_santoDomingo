import { useState, useEffect } from 'react';
import { toast } from '@/lib/sweetalert';

const initialState = {
    nombre: '', codigo_sunat: '', codigo_swift: '',
    telefono: '', email: '', website: '', activo: true,
};

export const useBancoForm = (banco, isOpen, onClose, onSuccess) => {
    const isEditing = !!banco;
    const [formData, setFormData] = useState(initialState);
    const [loading, setLoading] = useState(false);
    const [errors, setErrors] = useState({});

    useEffect(() => {
        if (isOpen) {
            setFormData(banco ? {
                nombre: banco.nombre || '',
                codigo_sunat: banco.codigo_sunat || '',
                codigo_swift: banco.codigo_swift || '',
                telefono: banco.telefono || '',
                email: banco.email || '',
                website: banco.website || '',
                activo: banco.activo ?? true,
            } : initialState);
            setErrors({});
        }
    }, [banco, isOpen]);

    const handleChange = (e) => {
        const { name, value, type, checked } = e.target;
        setFormData(prev => ({ ...prev, [name]: type === 'checkbox' ? checked : value }));
        setErrors(prev => { const n = { ...prev }; delete n[name]; return n; });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setErrors({});
        try {
            const token = localStorage.getItem('auth_token');
            const url = isEditing ? `/api/bancos/${banco.id_banco}` : '/api/bancos';
            const response = await fetch(url, {
                method: isEditing ? 'PUT' : 'POST',
                headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json', Accept: 'application/json' },
                body: JSON.stringify(formData),
            });
            const data = await response.json();
            if (data.success) {
                onClose();
                onSuccess?.();
                setTimeout(() => toast.success(isEditing ? 'Banco actualizado' : 'Banco creado'), 300);
            } else if (data.errors) {
                setErrors(data.errors);
                toast.error('Corrige los errores del formulario');
            } else {
                toast.error(data.message || 'Error al guardar');
            }
        } catch { toast.error('Error de conexión'); }
        finally { setLoading(false); }
    };

    return { formData, loading, errors, isEditing, handleChange, handleSubmit };
};
