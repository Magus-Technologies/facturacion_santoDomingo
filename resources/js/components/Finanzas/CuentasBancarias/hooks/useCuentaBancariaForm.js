import { useState, useEffect } from 'react';
import { toast } from '@/lib/sweetalert';

const INITIAL = {
    id_banco: '',
    numero_cuenta: '',
    tipo_cuenta: 'Corriente',
    moneda: 'PEN',
    saldo_inicial: '',
    cci: '',
    alias: '',
    activa: true,
};

export const useCuentaBancariaForm = (cuenta, isOpen, onClose, onSuccess) => {
    const [formData, setFormData] = useState(INITIAL);
    const [bancos, setBancos] = useState([]);
    const [loading, setLoading] = useState(false);
    const [errors, setErrors] = useState({});
    const isEditing = !!cuenta;

    useEffect(() => {
        if (isOpen) {
            fetchBancos();
            if (cuenta) {
                setFormData({
                    id_banco: cuenta.id_banco ?? '',
                    numero_cuenta: cuenta.numero_cuenta ?? '',
                    tipo_cuenta: cuenta.tipo_cuenta ?? 'Corriente',
                    moneda: cuenta.moneda ?? 'PEN',
                    saldo_inicial: cuenta.saldo_inicial ?? '',
                    cci: cuenta.cci ?? '',
                    alias: cuenta.alias ?? '',
                    activa: cuenta.activa ?? true,
                });
            } else {
                setFormData(INITIAL);
            }
            setErrors({});
        }
    }, [isOpen, cuenta]);

    const fetchBancos = async () => {
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch('/api/bancos?solo_activos=true', {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
            });
            const data = await res.json();
            if (data.success) setBancos(data.data);
        } catch { /* silent */ }
    };

    const handleChange = (e) => {
        const { name, value, type, checked } = e.target;
        setFormData(prev => ({ ...prev, [name]: type === 'checkbox' ? checked : value }));
        if (errors[name]) setErrors(prev => ({ ...prev, [name]: null }));
    };

    const handleSelectChange = (field, value) => {
        setFormData(prev => ({ ...prev, [field]: value }));
        if (errors[field]) setErrors(prev => ({ ...prev, [field]: null }));
    };

    const handleSubmit = async (e) => {
        e?.preventDefault();
        setLoading(true);
        setErrors({});
        try {
            const token = localStorage.getItem('auth_token');
            const url = isEditing ? `/api/cuentas-bancarias/${cuenta.id_cuenta}` : '/api/cuentas-bancarias';
            const method = isEditing ? 'PUT' : 'POST';
            const res = await fetch(url, {
                method,
                headers: {
                    Authorization: `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    Accept: 'application/json',
                },
                body: JSON.stringify({
                    ...formData,
                    id_banco: formData.id_banco || null,
                    saldo_inicial: formData.saldo_inicial !== '' ? parseFloat(formData.saldo_inicial) : null,
                }),
            });
            const data = await res.json();
            if (data.success) {
                toast.success(isEditing ? 'Cuenta actualizada' : 'Cuenta creada');
                onSuccess();
                onClose();
            } else if (data.errors) {
                setErrors(data.errors);
            } else {
                toast.error(data.message || 'Error al guardar');
            }
        } catch {
            toast.error('Error de conexión al servidor');
        } finally {
            setLoading(false);
        }
    };

    return { formData, bancos, loading, errors, isEditing, handleChange, handleSelectChange, handleSubmit };
};
