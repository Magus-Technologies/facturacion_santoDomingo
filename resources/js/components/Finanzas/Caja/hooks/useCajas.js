import { useState, useEffect } from 'react';
import { toast, confirmDelete } from '@/lib/sweetalert';

export const useCajas = () => {
    const [cajas, setCajas] = useState([]);
    const [cajaActiva, setCajaActiva] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    // Crear caja modal
    const [isCrearOpen, setIsCrearOpen] = useState(false);

    // Apertura modal (abrir una caja existente)
    const [isAperturaOpen, setIsAperturaOpen] = useState(false);

    // Cierre modal
    const [isCierreOpen, setIsCierreOpen] = useState(false);

    // Detalle modal
    const [isDetalleOpen, setIsDetalleOpen] = useState(false);

    const [selectedCaja, setSelectedCaja] = useState(null);

    useEffect(() => { fetchData(); }, []);

    const fetchData = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const headers = { Authorization: `Bearer ${token}`, Accept: 'application/json' };

            const [cajasRes, activaRes] = await Promise.all([
                fetch('/api/cajas', { headers }),
                fetch('/api/cajas/activa', { headers }),
            ]);

            const cajasData = await cajasRes.json();
            const activaData = await activaRes.json();

            if (cajasData.success) {
                const lista = cajasData.data?.data ?? cajasData.data;
                setCajas(lista);
                setError(null);
            } else {
                setError(cajasData.message || 'Error al cargar cajas');
            }

            if (activaData.success) setCajaActiva(activaData.data);
        } catch {
            setError('Error de conexión al servidor');
        } finally {
            setLoading(false);
        }
    };

    // --- Crear caja ---
    const handleNuevaCaja = () => setIsCrearOpen(true);
    const handleCrearClose = () => setIsCrearOpen(false);
    const handleCrearSuccess = () => fetchData();

    // --- Activar caja (sin formulario, saldo 0) ---
    const handleActivarCaja = (caja) => {
        confirmDelete({
            title: 'Habilitar Caja',
            message: `¿Deseas habilitar la caja <strong>${caja.nombre || '#' + caja.id_caja}</strong> para que pueda ser aperturada?`,
            confirmButtonText: 'Habilitar',
            confirmButtonColor: '#16a34a',
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem('auth_token');
                    const res = await fetch(`/api/cajas/${caja.id_caja}/activar`, {
                        method: 'POST',
                        headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
                    });
                    const data = await res.json();
                    if (data.success) { toast.success('Caja activada'); fetchData(); }
                    else toast.error(data.message || 'Error al activar');
                } catch { toast.error('Error de conexión'); }
            },
        });
    };

    // --- Abrir caja (apertura) ---
    const handleAbrirCaja = (caja) => {
        setSelectedCaja(caja);
        setIsAperturaOpen(true);
    };
    const handleAperturaClose = () => {
        setIsAperturaOpen(false);
        setSelectedCaja(null);
    };
    const handleAperturaSuccess = () => { fetchData(); setSelectedCaja(null); };

    // --- Cerrar caja ---
    const handleCerrar = (caja) => { setSelectedCaja(caja); setIsCierreOpen(true); };
    const handleCierreClose = () => { setIsCierreOpen(false); setSelectedCaja(null); };
    const handleCierreSuccess = () => { fetchData(); handleCierreClose(); };

    // --- Detalle ---
    const handleVerDetalle = (caja) => { setSelectedCaja(caja); setIsDetalleOpen(true); };
    const handleDetalleClose = () => { setIsDetalleOpen(false); setSelectedCaja(null); };

    // --- Autorizar / Rechazar ---
    const handleAutorizar = (caja) => {
        confirmDelete({
            title: 'Autorizar Cierre',
            message: `¿Autorizar el cierre de la caja <strong>${caja.nombre || '#' + caja.id_caja}</strong>?`,
            confirmButtonText: 'Autorizar',
            confirmButtonColor: '#16a34a',
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem('auth_token');
                    const res = await fetch(`/api/cajas/${caja.id_caja}/autorizar`, {
                        method: 'POST',
                        headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
                    });
                    const data = await res.json();
                    if (data.success) { toast.success('Cierre autorizado'); fetchData(); }
                    else toast.error(data.message || 'Error al autorizar');
                } catch { toast.error('Error de conexión'); }
            },
        });
    };

    const handleRechazar = (caja) => {
        confirmDelete({
            title: 'Rechazar Cierre',
            message: `¿Rechazar el cierre de <strong>${caja.nombre || '#' + caja.id_caja}</strong>? La caja volverá a estado <b>Abierta</b>.`,
            confirmButtonText: 'Rechazar',
            confirmButtonColor: '#dc2626',
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem('auth_token');
                    const res = await fetch(`/api/cajas/${caja.id_caja}/rechazar`, {
                        method: 'POST',
                        headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' },
                    });
                    const data = await res.json();
                    if (data.success) { toast.success('Cierre rechazado'); fetchData(); }
                    else toast.error(data.message || 'Error al rechazar');
                } catch { toast.error('Error de conexión'); }
            },
        });
    };

    return {
        cajas, cajaActiva, loading, error,
        isCrearOpen, isAperturaOpen, isCierreOpen, isDetalleOpen, selectedCaja,
        fetchData,
        handleNuevaCaja, handleCrearClose, handleCrearSuccess,
        handleActivarCaja,
        handleAbrirCaja, handleAperturaClose, handleAperturaSuccess,
        handleCerrar, handleCierreClose, handleCierreSuccess,
        handleVerDetalle, handleDetalleClose,
        handleAutorizar, handleRechazar,
    };
};
