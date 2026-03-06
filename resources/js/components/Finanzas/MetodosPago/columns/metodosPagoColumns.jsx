import { Edit, Trash2, CreditCard, Banknote, Wallet, ArrowLeftRight, FileCheck } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';

const TIPO_ICONS = {
    Efectivo: <Banknote className="h-3.5 w-3.5" />,
    Tarjeta: <CreditCard className="h-3.5 w-3.5" />,
    Billetera: <Wallet className="h-3.5 w-3.5" />,
    Transferencia: <ArrowLeftRight className="h-3.5 w-3.5" />,
    Cheque: <FileCheck className="h-3.5 w-3.5" />,
};

export const getMetodosPagoColumns = ({ handleEdit, handleDelete }) => [
    {
        accessorKey: 'nombre',
        header: 'Método',
        cell: ({ row }) => (
            <p className="font-semibold text-gray-900">{row.original.nombre}</p>
        ),
    },
    {
        accessorKey: 'codigo',
        header: 'Código',
        cell: ({ row }) => (
            <span className="font-mono text-sm text-gray-600">{row.original.codigo}</span>
        ),
    },
    {
        accessorKey: 'tipo',
        header: 'Tipo',
        cell: ({ row }) => (
            <div className="flex items-center gap-1.5 text-sm text-gray-700">
                {TIPO_ICONS[row.original.tipo] || null}
                {row.original.tipo}
            </div>
        ),
    },
    {
        accessorKey: 'id_banco',
        header: 'Banco',
        cell: ({ row }) => row.original.banco
            ? <span className="text-sm text-gray-700">{row.original.banco.nombre}</span>
            : <span className="text-gray-400">—</span>,
    },
    {
        accessorKey: 'requiere_referencia',
        header: 'Requiere Referencia',
        cell: ({ row }) => (
            <Badge variant={row.original.requiere_referencia ? 'success' : 'outline'}>
                {row.original.requiere_referencia ? 'Sí' : 'No'}
            </Badge>
        ),
    },
    {
        accessorKey: 'requiere_comprobante',
        header: 'Requiere Comprobante',
        cell: ({ row }) => (
            <Badge variant={row.original.requiere_comprobante ? 'success' : 'outline'}>
                {row.original.requiere_comprobante ? 'Sí' : 'No'}
            </Badge>
        ),
    },
    {
        accessorKey: 'activo',
        header: 'Estado',
        cell: ({ row }) => (
            <Badge variant={row.original.activo ? 'success' : 'danger'}>
                {row.original.activo ? 'Activo' : 'Inactivo'}
            </Badge>
        ),
    },
    {
        id: 'acciones',
        header: 'Acciones',
        enableSorting: false,
        cell: ({ row }) => (
            <div className="flex items-center gap-2">
                <Button variant="ghost" size="sm" onClick={() => handleEdit(row.original)} title="Editar">
                    <Edit className="h-4 w-4 text-primary-600" />
                </Button>
                <Button variant="ghost" size="sm" onClick={() => handleDelete(row.original)}
                    className="text-red-600 hover:text-red-700 hover:bg-red-50" title="Eliminar">
                    <Trash2 className="h-4 w-4" />
                </Button>
            </div>
        ),
    },
];
