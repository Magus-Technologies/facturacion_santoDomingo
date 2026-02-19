import { useState, useEffect } from 'react';
import { toast, confirmDelete } from '@/lib/sweetalert';

/**
 * Custom hook para manejar la lógica de la lista de cotizaciones
 */
export const useCotizaciones = () => {
    const [cotizaciones, setCotizaciones] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        fetchCotizaciones();
    }, []);

    /**
     * Obtiene la lista de cotizaciones desde la API
     */
    const fetchCotizaciones = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');

            const response = await fetch('/api/cotizaciones', {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: 'application/json',
                },
            });

            const data = await response.json();

            if (data.success) {
                setCotizaciones(data.data);
                setError(null);
            } else {
                setError(data.message || 'Error al cargar cotizaciones');
            }
        } catch (err) {
            setError('Error de conexión al servidor');
            console.error('Error:', err);
        } finally {
            setLoading(false);
        }
    };

    /**
     * Elimina una cotización con confirmación
     */
    const handleDelete = async (cotizacion) => {
        confirmDelete({
            title: 'Eliminar Cotización',
            message: `¿Estás seguro de eliminar la cotización <strong>N° ${cotizacion.numero}</strong>?`,
            confirmText: 'Sí, eliminar',
            cancelText: 'Cancelar',
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem('auth_token');

                    const response = await fetch(
                        `/api/cotizaciones/${cotizacion.id}`,
                        {
                            method: 'DELETE',
                            headers: {
                                Authorization: `Bearer ${token}`,
                                Accept: 'application/json',
                            },
                        }
                    );

                    const data = await response.json();

                    if (data.success) {
                        toast.success('Cotización eliminada exitosamente');
                        fetchCotizaciones();
                    } else {
                        toast.error(data.message || 'Error al eliminar cotización');
                    }
                } catch (err) {
                    toast.error('Error de conexión al servidor');
                    console.error('Error:', err);
                }
            },
        });
    };

    /**
     * Navega a la vista de edición
     */
    const handleEdit = (cotizacion) => {
        window.location.href = `/cotizaciones/editar/${cotizacion.id}`;
    };

    /**
     * Navega a la vista de detalle
     */
    const handleView = (cotizacion) => {
        window.location.href = `/cotizaciones/ver/${cotizacion.id}`;
    };

    /**
     * Navega a la creación de nueva cotización
     */
    const handleCreate = () => {
        window.location.href = '/cotizaciones/nueva';
    };

    /**
     * Convierte una cotización en una venta electrónica (boleta/factura)
     * Lógica: RUC (11 dígitos) → Factura | DNI (8 dígitos) → Boleta
     */
    const handleConvertir = async (cotizacion) => {
        try {
            const token = localStorage.getItem('auth_token');

            // Cargar detalles completos de la cotización
            const response = await fetch(`/api/cotizaciones/${cotizacion.id}`, {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: 'application/json',
                },
            });

            const data = await response.json();

            if (!data.success) {
                toast.error('Error al cargar los detalles de la cotización');
                return;
            }

            const cot = data.data;

            // Determinar tipo de comprobante según el documento del cliente
            // La API devuelve cot.cliente como objeto anidado (relación Eloquent)
            const clienteObj = cot.cliente || {};
            const doc = (clienteObj.documento || '').trim();
            const tipoVenta = doc.length === 11 ? 'factura' : 'boleta';

            // Guardar borrador en sessionStorage para que VentaForm lo lea
            sessionStorage.setItem('cotizacion_draft', JSON.stringify({
                cotizacion_id: cot.id,
                cotizacion_numero: cot.numero,
                cliente: {
                    id_cliente: clienteObj.id_cliente,
                    datos:      clienteObj.datos      || '',
                    documento:  clienteObj.documento  || '',
                    direccion:  clienteObj.direccion  || cot.direccion || '',
                },
                productos: (cot.detalles || []).map(d => ({
                    id_producto:    d.id_producto,
                    codigo:         d.codigo        || d.producto?.codigo || '',
                    descripcion:    d.nombre        || d.producto?.nombre || '',
                    cantidad:       parseFloat(d.cantidad)      || 1,
                    precio:         parseFloat(d.precio_unitario) || 0,
                    precioVenta:    parseFloat(d.precio_especial ?? d.precio_unitario) || 0,
                    precio_mostrado: parseFloat(d.precio_especial ?? d.precio_unitario) || 0,
                    tipo_precio:    'precio',
                    moneda:         cot.moneda || 'PEN',
                })),
                moneda:      cot.moneda      || 'PEN',
                aplicar_igv: cot.aplicar_igv ?? true,
            }));

            // Navegar al formulario de nueva venta con el tipo correspondiente
            window.location.href = `/ventas/productos?tipo=${tipoVenta}`;

        } catch (err) {
            toast.error('Error de conexión al servidor');
            console.error('Error handleConvertir:', err);
        }
    };

    /**
     * Abre el modal de impresión para la cotización dada
     */
    const handlePrint = (cotizacion, callback) => {
        if (typeof callback === 'function') callback(cotizacion);
    };

    return {
        cotizaciones,
        loading,
        error,
        fetchCotizaciones,
        handleDelete,
        handleEdit,
        handleView,
        handleCreate,
        handlePrint,
        handleConvertir,
    };
};
