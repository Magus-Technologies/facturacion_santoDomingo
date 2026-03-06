import { useState, useEffect } from 'react';
import { toast } from '@/lib/sweetalert';

const initialState = {
    nombre: '', codigo: '', descripcion: '', tipo: 'Otro',
    id_banco: '', id_cuenta: '', es_efectivo: false,
    requiere_referencia: false, requiere_comprobante: false, activo: true,
};

export const useMetodoPagoForm = (metodo, isOpen, onClose, onSuccess) => {
    const isEditing = !!metodo;
    const [formData, setFormData] = useState(initialState);
    const [bancos, setBancos] = useState([]);
    const [cuentas, setCuentas] = useState([]);
    const [loading, setLoading] = useState(false);
    const [errors, setErrors] = useState({});

    useEffect(() => {
        if (isOpen) {
            const data = metodo ? {
                nombre: metodo.nombre || '',
                codigo: metodo.codigo || '',
                descripcion: metodo.descripcion || '',
                tipo: metodo.tipo || 'Otro',
                id_banco: metodo.id_banco ? String(metodo.id_banco) : '',
                id_cuenta: metodo.id_cuenta ? String(metodo.id_cuenta) : '',
                es_efectivo: metodo.es_efectivo ?? false,
                requiere_referencia: metodo.requiere_referencia ?? false,
                requiere_comprobante: metodo.requiere_comprobante ?? false,
                activo: metodo.activo ?? true,
            } : initialState;
            setFormData(data);
            setErrors({});
            fetchBancos();
            // Si ya tiene banco, cargar sus cuentas
            if (metodo?.id_banco) fetchCuentasByBanco(metodo.id_banco);
        }
    }, [metodo, isOpen]);

    const fetchBancos = async () => {
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch('/api/bancos?solo_activos=1', {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
            });
            const data = await res.json();
            if (data.success) setBancos(data.data);
        } catch { /* silencioso */ }
    };

    const fetchCuentasByBanco = async (idBanco) => {
        try {
            const token = localStorage.getItem('auth_token');
            const res = await fetch(`/api/cuentas-bancarias?id_banco=${idBanco}`, {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
            });
            const data = await res.json();
            if (data.success) setCuentas(data.data?.data ?? data.data ?? []);
        } catch { setCuentas([]); }
    };

    const handleChange = (e) => {
        const { name, value, type, checked } = e.target;
        setFormData(prev => {
            const updated = { ...prev, [name]: type === 'checkbox' ? checked : value };
            // Si marca efectivo, limpiar banco y cuenta
            if (name === 'es_efectivo' && checked) {
                updated.id_banco = '';
                updated.id_cuenta = '';
                setCuentas([]);
            }
            // Si cambia banco, limpiar cuenta y cargar nuevas
            if (name === 'id_banco') {
                updated.id_cuenta = '';
                if (value) fetchCuentasByBanco(value);
                else setCuentas([]);
            }
            return updated;
        });
        setErrors(prev => { const n = { ...prev }; delete n[name]; return n; });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setErrors({});
        try {
            const token = localStorage.getItem('auth_token');
            const url = isEditing ? `/api/metodos-pago/${metodo.id_metodo_pago}` : '/api/metodos-pago';
            const body = {
                ...formData,
                id_banco: formData.es_efectivo ? null : (formData.id_banco || null),
                id_cuenta: formData.es_efectivo ? null : (formData.id_cuenta || null),
            };
            const response = await fetch(url, {
                method: isEditing ? 'PUT' : 'POST',
                headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json', Accept: 'application/json' },
                body: JSON.stringify(body),
            });
            const data = await response.json();
            if (data.success) {
                onClose(); onSuccess?.();
                setTimeout(() => toast.success(isEditing ? 'Método actualizado' : 'Método creado'), 300);
            } else if (data.errors) {
                setErrors(data.errors); toast.error('Corrige los errores');
            } else toast.error(data.message || 'Error al guardar');
        } catch { toast.error('Error de conexión'); }
        finally { setLoading(false); }
    };

    return { formData, bancos, cuentas, loading, errors, isEditing, handleChange, handleSubmit };
};
