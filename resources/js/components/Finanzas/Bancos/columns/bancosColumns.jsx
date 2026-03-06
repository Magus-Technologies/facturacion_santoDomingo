import { Edit, Trash2, Globe, Phone, Mail } from 'lucide-react';
import { Button } from '@/components/ui/button';

export const getBancosColumns = ({ handleEdit, handleDelete }) => [
    {
        accessorKey: 'nombre',
        header: 'Nombre',
        cell: ({ row }) => (
            <p className="font-semibold text-gray-900">{row.original.nombre}</p>
        ),
    },
    {
        accessorKey: 'codigo_sunat',
        header: 'Código SUNAT',
        cell: ({ row }) => row.original.codigo_sunat
            ? <span className="text-sm text-gray-700">{row.original.codigo_sunat}</span>
            : <span className="text-gray-400">—</span>,
    },
    {
        accessorKey: 'codigo_swift',
        header: 'Código SWIFT',
        cell: ({ row }) => row.original.codigo_swift
            ? <span className="font-mono text-sm text-gray-700">{row.original.codigo_swift}</span>
            : <span className="text-gray-400">—</span>,
    },
    {
        accessorKey: 'telefono',
        header: 'Teléfono',
        cell: ({ row }) => row.original.telefono
            ? <div className="flex items-center gap-2"><Phone className="h-4 w-4 text-blue-600" /><span>{row.original.telefono}</span></div>
            : <span className="text-gray-400">—</span>,
    },
    {
        accessorKey: 'email',
        header: 'Email',
        cell: ({ row }) => row.original.email
            ? <div className="flex items-center gap-2"><Mail className="h-4 w-4 text-green-600" /><span className="truncate max-w-xs">{row.original.email}</span></div>
            : <span className="text-gray-400">—</span>,
    },
    {
        accessorKey: 'website',
        header: 'Website',
        cell: ({ row }) => row.original.website
            ? <div className="flex items-center gap-2"><Globe className="h-4 w-4 text-orange-600" /><span className="truncate max-w-xs">{row.original.website}</span></div>
            : <span className="text-gray-400">—</span>,
    },
    {
        id: 'acciones',
        header: 'Acciones',
        enableSorting: false,
        cell: ({ row }) => (
            <div className="flex items-center gap-2">
                <Button variant="ghost" size="sm" onClick={() => handleEdit(row.original)} title="Editar" className="hover:bg-blue-50">
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
