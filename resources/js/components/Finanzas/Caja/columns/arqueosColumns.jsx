import { Eye } from 'lucide-react';
import { Button } from '@/components/ui/button';

export const getArqueosColumns = ({ handleVerDetalle }) => [
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
    {
        id: 'acciones',
        header: 'Acciones',
        enableSorting: false,
        cell: ({ row }) => (
            <Button
                variant="ghost"
                size="sm"
                onClick={() => handleVerDetalle(row.original)}
                title="Ver detalle"
                className="hover:bg-blue-50"
            >
                <Eye className="h-4 w-4 text-primary-600" />
            </Button>
        ),
    },
];
