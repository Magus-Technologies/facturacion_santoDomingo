import { useState, useEffect } from 'react';
import { DataTable } from '@/components/ui/data-table';
import MainLayout from '@/components/Layout/MainLayout';
import { toast } from '@/lib/sweetalert';
import { baseUrl } from '@/lib/baseUrl';

export default function ArqueosHistoricoList() {
    const [arqueos, setArqueos] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        fetchArqueos();
    }, []);

    const fetchArqueos = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch(baseUrl('/api/arqueos-diarios'), {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' }
            });
            const data = await res.json();
            if (data.success) {
                setArqueos(data.data || []);
                setError(null);
            } else {
                setError(data.message || 'Error al cargar arqueos');
            }
        } catch (err) {
            setError('Error de conexión');
            toast.error('Error al cargar arqueos');
        } finally {
            setLoading(false);
        }
    };

    const columns = [
        {
            accessorKey: 'fecha_arqueo',
            header: 'Fecha',
            cell: ({ row }) => new Date(row.original.fecha_arqueo).toLocaleDateString(),
        },
        {
            accessorKey: 'usuarioApertura.name',
            header: 'Vendedor',
            cell: ({ row }) => row.original.usuarioApertura?.name || 'N/A',
        },
        {
            accessorKey: 'saldo_inicial',
            header: 'Apertura',
            cell: ({ row }) => (
                <span className="font-mono">S/. {parseFloat(row.original.saldo_inicial || 0).toFixed(2)}</span>
            ),
        },
        {
            accessorKey: 'saldo_final_real',
            header: 'Cierre',
            cell: ({ row }) => (
                <span className="font-mono">S/. {parseFloat(row.original.saldo_final_real || 0).toFixed(2)}</span>
            ),
        },
        {
            accessorKey: 'diferencia',
            header: 'Diferencia',
            cell: ({ row }) => {
                const diff = parseFloat(row.original.diferencia || 0);
                const tipo = row.original.tipo_diferencia || 'exacto';
                const color = tipo === 'exacto' ? 'text-green-600' : tipo === 'sobrante' ? 'text-blue-600' : 'text-red-600';
                const icon = tipo === 'exacto' ? '✓' : tipo === 'sobrante' ? '↑' : '↓';
                
                return (
                    <span className={`font-mono ${color}`}>
                        {icon} S/. {diff.toFixed(2)}
                    </span>
                );
            },
        },
    ];

    return (
        <MainLayout>
            <div className="space-y-6">
                {/* Encabezado */}
                <div>
                    <h1 className="text-3xl font-bold text-gray-900">Histórico de Arqueos</h1>
                    <p className="text-gray-600 mt-1">Registro de cajas cerradas y validadas</p>
                </div>

                {/* Tabla */}
                {error && (
                    <div className="bg-red-50 border border-red-200 rounded-lg p-4 text-red-700">
                        {error}
                    </div>
                )}

                <div className="bg-white rounded-lg shadow">
                    <DataTable
                        columns={columns}
                        data={arqueos}
                        loading={loading}
                        pageSize={10}
                    />
                </div>
            </div>
        </MainLayout>
    );
}
