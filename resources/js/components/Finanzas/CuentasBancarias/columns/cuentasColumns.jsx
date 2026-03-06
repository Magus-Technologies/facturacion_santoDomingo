import { Button } from '@/components/ui/button';
import { Edit2, Trash2, Eye } from 'lucide-react';

const fmt = (val) => val != null ? `S/ ${parseFloat(val).toFixed(2)}` : '—';

const tipoBadge = (tipo) => {
    const colors = {
        'Corriente': 'bg-blue-100 text-blue-700',
        'Ahorros': 'bg-green-100 text-green-700',
        'Plazo Fijo': 'bg-purple-100 text-purple-700',
        'Recaudadora': 'bg-orange-100 text-orange-700',
        'CTS': 'bg-pink-100 text-pink-700',
    };
    return (
        <span className={`inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium ${colors[tipo] ?? 'bg-gray-100 text-gray-600'}`}>
            {tipo}
        </span>
    );
};

export const getCuentasColumns = ({ handleEdit, handleDelete, handleVerDetalle }) => [
    {
        accessorKey: 'banco',
        header: 'Banco',
        cell: ({ row }) => row.original.banco?.nombre ?? '—',
    },
    {
        accessorKey: 'numero_cuenta',
        header: 'N° Cuenta',
        cell: ({ row }) => <span className="font-mono text-sm">{row.original.numero_cuenta}</span>,
    },
    {
        accessorKey: 'tipo_cuenta',
        header: 'Tipo',
        cell: ({ row }) => tipoBadge(row.original.tipo_cuenta),
    },
    {
        accessorKey: 'moneda',
        header: 'Moneda',
        cell: ({ row }) => <span className="text-sm font-medium">{row.original.moneda}</span>,
    },
    {
        accessorKey: 'saldo_actual',
        header: 'Saldo Actual',
        cell: ({ row }) => <span className="font-semibold text-gray-800">{fmt(row.original.saldo_actual)}</span>,
    },
    {
        accessorKey: 'activa',
        header: 'Estado',
        cell: ({ row }) => row.original.activa
            ? <span className="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-700">Activa</span>
            : <span className="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-600">Inactiva</span>,
    },
    {
        id: 'acciones',
        header: 'Acciones',
        cell: ({ row }) => {
            const cuenta = row.original;
            return (
                <div className="flex items-center gap-1">
                    <Button
                        variant="ghost" size="sm"
                        onClick={() => handleVerDetalle(cuenta)}
                        title="Ver movimientos"
                        className="text-blue-600 hover:text-blue-700 hover:bg-blue-50"
                    >
                        <Eye className="h-4 w-4" />
                    </Button>
                    <Button
                        variant="ghost" size="sm"
                        onClick={() => handleEdit(cuenta)}
                        title="Editar"
                        className="text-primary-600 hover:text-primary-700 hover:bg-primary-50"
                    >
                        <Edit2 className="h-4 w-4" />
                    </Button>
                    <Button
                        variant="ghost" size="sm"
                        onClick={() => handleDelete(cuenta)}
                        title="Eliminar"
                        className="text-red-500 hover:text-red-700 hover:bg-red-50"
                    >
                        <Trash2 className="h-4 w-4" />
                    </Button>
                </div>
            );
        },
    },
];
