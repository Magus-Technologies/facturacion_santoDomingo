import { useState, useEffect } from 'react';
import { toast, confirmDelete } from '@/lib/sweetalert';
import { getClienteInfoMessage } from '../utils/clienteHelpers';

/**
 * Custom hook para manejar la lógica de la lista de clientes
 */
export const useClientes = () => {
    const [clientes, setClientes] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [selectedCliente, setSelectedCliente] = useState(null);

    useEffect(() => {
        fetchClientes();
    }, []);

    /**
     * Obtiene la lista de clientes desde la API
     */
    const fetchClientes = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');

            const response = await fetch('/api/clientes', {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: 'application/json',
                },
            });

            const data = await response.json();

            if (data.success) {
                setClientes(data.data);
                setError(null);
            } else {
                setError(data.message || 'Error al cargar clientes');
            }
        } catch (err) {
            setError('Error de conexión al servidor');
            console.error('Error:', err);
        } finally {
            setLoading(false);
        }
    };

    /**
     * Elimina un cliente con confirmación
     */
    const handleDelete = async (cliente) => {
        confirmDelete({
            title: 'Eliminar Cliente',
            message: `¿Estás seguro de eliminar al cliente <strong>"${cliente.datos}"</strong>?`,
            confirmText: 'Sí, eliminar',
            cancelText: 'Cancelar',
            onConfirm: async () => {
                try {
                    const token = localStorage.getItem('auth_token');

                    const response = await fetch(
                        `/api/clientes/${cliente.id_cliente}`,
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
                        toast.success('Cliente eliminado exitosamente');
                        fetchClientes();
                    } else {
                        toast.error(data.message || 'Error al eliminar cliente');
                    }
                } catch (err) {
                    toast.error('Error de conexión al servidor');
                    console.error('Error:', err);
                }
            },
        });
    };

    /**
     * Abre el modal para editar un cliente
     */
    const handleEdit = (cliente) => {
        setSelectedCliente(cliente);
        setIsModalOpen(true);
    };

    /**
     * Abre el modal para crear un nuevo cliente
     */
    const handleCreate = () => {
        setSelectedCliente(null);
        setIsModalOpen(true);
    };

    /**
     * Cierra el modal
     */
    const handleModalClose = () => {
        setIsModalOpen(false);
        setSelectedCliente(null);
    };

    /**
     * Callback cuando se guarda exitosamente un cliente
     */
    const handleModalSuccess = () => {
        fetchClientes();
    };

    /**
     * Muestra la información del cliente en un modal
     */
    const handleView = (cliente) => {
        // Crear un modal simple con la información del cliente
        const modal = document.createElement('div');
        modal.className = 'fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4';
        modal.onclick = (e) => {
            if (e.target === modal) {
                modal.remove();
            }
        };

        const content = document.createElement('div');
        content.className = 'bg-white rounded-2xl shadow-2xl max-w-md w-full overflow-hidden';
        content.onclick = (e) => e.stopPropagation();

        // Header
        const header = document.createElement('div');
        header.className = 'flex items-center justify-between p-4 border-b border-gray-100';
        header.innerHTML = `
            <h3 class="font-semibold text-gray-900">Perfil del Cliente</h3>
            <button class="p-1 hover:bg-gray-100 rounded-lg transition-colors" onclick="this.closest('.fixed').remove()">
                <svg class="w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </button>
        `;

        // Body
        const body = document.createElement('div');
        body.className = 'p-4 space-y-4';

        // Foto
        if (cliente.foto_url) {
            const fotoDiv = document.createElement('div');
            fotoDiv.innerHTML = `<img src="${cliente.foto_url}" alt="${cliente.datos}" class="w-full h-48 object-cover rounded-lg" />`;
            body.appendChild(fotoDiv);
        }

        // Información
        const info = document.createElement('div');
        info.className = 'space-y-3';
        info.innerHTML = `
            <div>
                <p class="text-xs text-gray-500 font-medium">NOMBRE</p>
                <p class="text-sm font-semibold text-gray-900">${cliente.datos}</p>
            </div>
            <div>
                <p class="text-xs text-gray-500 font-medium">DOCUMENTO</p>
                <p class="text-sm font-mono text-gray-900">${cliente.documento}</p>
            </div>
            ${cliente.email ? `
            <div>
                <p class="text-xs text-gray-500 font-medium">EMAIL</p>
                <p class="text-sm text-gray-900">${cliente.email}</p>
            </div>
            ` : ''}
            ${cliente.telefono ? `
            <div>
                <p class="text-xs text-gray-500 font-medium">TELÉFONO</p>
                <p class="text-sm text-gray-900">${cliente.telefono}</p>
            </div>
            ` : ''}
            ${cliente.direccion ? `
            <div>
                <p class="text-xs text-gray-500 font-medium">DIRECCIÓN</p>
                <p class="text-sm text-gray-900">${cliente.direccion}</p>
            </div>
            ` : ''}
            ${cliente.total_venta ? `
            <div>
                <p class="text-xs text-gray-500 font-medium">TOTAL VENTAS</p>
                <p class="text-sm font-semibold text-green-700">S/. ${parseFloat(cliente.total_venta).toLocaleString('es-PE', { minimumFractionDigits: 2 })}</p>
            </div>
            ` : ''}
        `;
        body.appendChild(info);

        content.appendChild(header);
        content.appendChild(body);
        modal.appendChild(content);
        document.body.appendChild(modal);
    };

    return {
        clientes,
        loading,
        error,
        isModalOpen,
        selectedCliente,
        fetchClientes,
        handleDelete,
        handleEdit,
        handleCreate,
        handleModalClose,
        handleModalSuccess,
        handleView,
    };
};
