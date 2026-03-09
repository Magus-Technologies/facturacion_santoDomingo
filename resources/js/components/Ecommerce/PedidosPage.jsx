import { useState, useEffect } from 'react';
import { baseUrl } from '@/lib/baseUrl';
import { Eye, Trash2 } from 'lucide-react';

export default function PedidosPage() {
    const [pedidos, setPedidos] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchPedidos();
    }, []);

    const fetchPedidos = async () => {
        try {
            setLoading(false);
            setPedidos([
                { id: 1, numero: 'PED-001', cliente: 'Juan Pérez', total: 'S/. 250.00', estado: 'Pendiente', fecha: '2026-03-08' },
                { id: 2, numero: 'PED-002', cliente: 'María García', total: 'S/. 450.50', estado: 'Completado', fecha: '2026-03-07' },
                { id: 3, numero: 'PED-003', cliente: 'Carlos López', total: 'S/. 180.00', estado: 'Cancelado', fecha: '2026-03-06' },
            ]);
        } catch (err) {
            console.error('Error:', err);
            setLoading(false);
        }
    };

    const getEstadoColor = (estado) => {
        switch (estado) {
            case 'Pendiente':
                return 'bg-yellow-100 text-yellow-800';
            case 'Completado':
                return 'bg-green-100 text-green-800';
            case 'Cancelado':
                return 'bg-red-100 text-red-800';
            default:
                return 'bg-gray-100 text-gray-800';
        }
    };

    return (
        <div className="space-y-6">
            <h1 className="text-3xl font-bold text-gray-900">Gestión de Pedidos</h1>

            {loading ? (
                <div className="text-center py-8">Cargando...</div>
            ) : (
                <div className="bg-white rounded-lg shadow overflow-hidden">
                    <table className="w-full">
                        <thead className="bg-gray-50 border-b">
                            <tr>
                                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-900">Número</th>
                                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-900">Cliente</th>
                                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-900">Total</th>
                                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-900">Estado</th>
                                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-900">Fecha</th>
                                <th className="px-6 py-3 text-left text-sm font-semibold text-gray-900">Acciones</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y">
                            {pedidos.map((pedido) => (
                                <tr key={pedido.id} className="hover:bg-gray-50">
                                    <td className="px-6 py-4 text-sm text-gray-900">{pedido.numero}</td>
                                    <td className="px-6 py-4 text-sm text-gray-900">{pedido.cliente}</td>
                                    <td className="px-6 py-4 text-sm text-gray-900">{pedido.total}</td>
                                    <td className="px-6 py-4 text-sm">
                                        <span className={`px-3 py-1 rounded-full text-xs font-semibold ${getEstadoColor(pedido.estado)}`}>
                                            {pedido.estado}
                                        </span>
                                    </td>
                                    <td className="px-6 py-4 text-sm text-gray-900">{pedido.fecha}</td>
                                    <td className="px-6 py-4 text-sm flex gap-2">
                                        <button className="text-blue-600 hover:text-blue-900">
                                            <Eye className="w-4 h-4" />
                                        </button>
                                        <button className="text-red-600 hover:text-red-900">
                                            <Trash2 className="w-4 h-4" />
                                        </button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}
        </div>
    );
}
