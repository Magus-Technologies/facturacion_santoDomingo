import { useState, useEffect, useCallback } from 'react';
import { toast } from '@/lib/sweetalert';
import { consultarDocumento } from '@/services/apisPeru';
import { consultarUbigeo } from '../utils/clienteHelpers';

/**
 * Custom hook para manejar la lógica del formulario de cliente
 */
export const useClienteForm = (cliente, isOpen, onClose, onSuccess) => {
    const isEditing = !!cliente;
    const [loading, setLoading] = useState(false);
    const [errors, setErrors] = useState({});
    const [consultando, setConsultando] = useState(false);

    const [formData, setFormData] = useState({
        documento: '',
        datos: '',
        direccion: '',
        direccion2: '',
        telefono: '',
        telefono2: '',
        email: '',
        foto: null,
        ubigeo: '',
        departamento: '',
        provincia: '',
        distrito: '',
    });

    // Cargar datos del cliente solo cuando se abre el modal
    useEffect(() => {
        if (isOpen) {
            if (cliente) {
                setFormData({
                    documento: cliente.documento || '',
                    datos: cliente.datos || '',
                    direccion: cliente.direccion || '',
                    direccion2: cliente.direccion2 || '',
                    telefono: cliente.telefono || '',
                    telefono2: cliente.telefono2 || '',
                    email: cliente.email || '',
                    foto: null,
                    ubigeo: cliente.ubigeo || '',
                    departamento: cliente.departamento || '',
                    provincia: cliente.provincia || '',
                    distrito: cliente.distrito || '',
                });
            } else {
                // Resetear formulario si es nuevo
                setFormData({
                    documento: '',
                    datos: '',
                    direccion: '',
                    direccion2: '',
                    telefono: '',
                    telefono2: '',
                    email: '',
                    foto: null,
                    ubigeo: '',
                    departamento: '',
                    provincia: '',
                    distrito: '',
                });
            }
            setErrors({});
        }
    }, [cliente, isOpen]);

    /**
     * Maneja los cambios en los campos del formulario
     */
    const handleChange = useCallback((e) => {
        const { name, value } = e.target;
        
        // Si es un archivo, guardarlo directamente
        if (value instanceof File) {
            console.log('Guardando archivo:', name, value.name);
            setFormData((prev) => ({ ...prev, [name]: value }));
        } else {
            setFormData((prev) => ({ ...prev, [name]: value }));
        }
        
        // Limpiar error del campo al escribir
        setErrors((prev) => {
            if (prev[name]) {
                const newErrors = { ...prev };
                delete newErrors[name];
                return newErrors;
            }
            return prev;
        });

        // Auto-consultar cuando el documento tenga 8 u 11 dígitos
        if (name === 'documento') {
            const docLimpio = value.replace(/\D/g, ''); // Solo números
            if (docLimpio.length === 8 || docLimpio.length === 11) {
                handleConsultarDocumento(docLimpio);
            }
        }
    }, []);

    /**
     * Consulta los datos del documento (DNI o RUC) en APIs externas
     */
    const handleConsultarDocumento = useCallback(async (documento = null) => {
        const doc = documento || formData.documento.trim();

        if (!doc) {
            toast.warning('Ingrese un número de documento');
            return;
        }

        if (doc.length !== 8 && doc.length !== 11) {
            return; // No mostrar error, solo no consultar
        }

        setConsultando(true);

        try {
            const result = await consultarDocumento(doc);

            if (result.success) {
                const data = result.data;

                // Si es DNI (8 dígitos)
                if (doc.length === 8) {
                    setFormData((prev) => ({
                        ...prev,
                        datos: data.nombreCompleto,
                    }));
                }
                // Si es RUC (11 dígitos)
                else if (doc.length === 11) {
                    // Obtener nombres de ubicación si viene ubigeo
                    let ubicacionData = {
                        departamento: '',
                        provincia: '',
                        distrito: '',
                    };

                    if (data.ubigeo && data.ubigeo.length === 6) {
                        ubicacionData = await consultarUbigeo(data.ubigeo);
                    }

                    setFormData((prev) => ({
                        ...prev,
                        datos: data.razonSocial,
                        direccion: data.direccion || prev.direccion,
                        ubigeo: data.ubigeo || prev.ubigeo,
                        departamento: ubicacionData.departamento,
                        provincia: ubicacionData.provincia,
                        distrito: ubicacionData.distrito,
                    }));
                }
            } else {
                // No mostrar error en auto-consulta, solo en búsqueda manual
                if (documento === null) {
                    toast.error(result.message || 'No se encontró el documento');
                }
            }
        } catch (error) {
            console.error('Error al consultar documento:', error);
        } finally {
            setConsultando(false);
        }
    }, [formData.documento]);

    /**
     * Envía el formulario para crear o actualizar el cliente
     */
    const handleSubmit = useCallback(async (e) => {
        e.preventDefault();
        setLoading(true);
        setErrors({});

        try {
            const token = localStorage.getItem('auth_token');
            const user = JSON.parse(localStorage.getItem('user') || '{}');

            // Crear FormData para enviar archivo
            const formDataToSend = new FormData();
            
            // Agregar campos de texto
            formDataToSend.append('documento', formData.documento);
            formDataToSend.append('datos', formData.datos);
            formDataToSend.append('direccion', formData.direccion);
            formDataToSend.append('direccion2', formData.direccion2);
            formDataToSend.append('telefono', formData.telefono);
            formDataToSend.append('telefono2', formData.telefono2);
            formDataToSend.append('email', formData.email);
            formDataToSend.append('ubigeo', formData.ubigeo);
            formDataToSend.append('departamento', formData.departamento);
            formDataToSend.append('provincia', formData.provincia);
            formDataToSend.append('distrito', formData.distrito);
            formDataToSend.append('id_empresa', user.id_empresa || 1);

            // Para PUT, agregar _method
            if (isEditing) {
                formDataToSend.append('_method', 'PUT');
            }

            // Agregar foto si existe
            if (formData.foto instanceof File) {
                console.log('Agregando foto al FormData:', formData.foto.name);
                formDataToSend.append('foto', formData.foto);
            } else {
                console.log('No hay foto para enviar. formData.foto:', formData.foto);
            }

            const url = isEditing
                ? `/api/clientes/${cliente.id_cliente}`
                : '/api/clientes';

            // Usar POST para ambos casos (POST para crear, POST con _method=PUT para actualizar)
            const method = 'POST';

            console.log('Enviando formulario:', { url, method, tieneArchivo: formData.foto instanceof File });

            const response = await fetch(url, {
                method,
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: 'application/json',
                },
                body: formDataToSend,
            });

            const data = await response.json();

            if (data.success) {
                // Cerrar modal y recargar datos
                onClose();
                onSuccess?.();

                // Mostrar alerta después de cerrar modal
                setTimeout(() => {
                    toast.success(
                        isEditing
                            ? 'Cliente actualizado exitosamente'
                            : 'Cliente creado exitosamente'
                    );
                }, 300);
            } else {
                // Manejar errores de validación
                if (data.errors) {
                    setErrors(data.errors);
                    toast.error('Por favor corrige los errores en el formulario');
                } else {
                    toast.error(data.message || 'Error al guardar cliente');
                }
            }
        } catch (err) {
            console.error('Error:', err);
            toast.error('Error de conexión al servidor');
        } finally {
            setLoading(false);
        }
    }, [formData, isEditing, cliente, onClose, onSuccess]);

    return {
        formData,
        loading,
        errors,
        consultando,
        isEditing,
        handleChange,
        handleConsultarDocumento,
        handleSubmit,
    };
};
