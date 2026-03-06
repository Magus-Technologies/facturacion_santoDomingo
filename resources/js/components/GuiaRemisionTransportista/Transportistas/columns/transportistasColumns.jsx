import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Trash2, Edit2 } from 'lucide-react';

export const transportistasColumns = (onEdit, onDelete) => [
  {
    accessorKey: 'numero_documento',
    header: 'Documento',
    cell: ({ row }) => {
      const tipo = row.original.tipo_documento === '6' ? 'RUC' : 'DNI';
      return (
        <div className="flex flex-col">
          <span className="font-medium">{row.original.numero_documento}</span>
          <span className="text-xs text-gray-500">{tipo}</span>
        </div>
      );
    },
  },
  {
    accessorKey: 'razon_social',
    header: 'Razón Social',
    cell: ({ row }) => (
      <div className="flex flex-col">
        <span className="font-medium">{row.original.razon_social}</span>
        {row.original.nombre_comercial && (
          <span className="text-xs text-gray-500">{row.original.nombre_comercial}</span>
        )}
      </div>
    ),
  },
  {
    accessorKey: 'numero_mtc',
    header: 'Nro. MTC',
    cell: ({ row }) => row.original.numero_mtc || '-',
  },
  {
    accessorKey: 'telefono',
    header: 'Teléfono',
    cell: ({ row }) => row.original.telefono || '-',
  },
  {
    accessorKey: 'email',
    header: 'Email',
    cell: ({ row }) => row.original.email || '-',
  },
  {
    accessorKey: 'estado',
    header: 'Estado',
    cell: ({ row }) => (
      <Badge variant={row.original.estado ? 'default' : 'secondary'}>
        {row.original.estado ? 'Activo' : 'Inactivo'}
      </Badge>
    ),
  },
  {
    id: 'acciones',
    header: 'Acciones',
    cell: ({ row }) => (
      <div className="flex gap-2">
        <Button
          variant="ghost"
          size="sm"
          onClick={() => onEdit(row.original)}
          aria-label={`Editar ${row.original.razon_social}`}
        >
          <Edit2 className="w-4 h-4" />
        </Button>
        <Button
          variant="ghost"
          size="sm"
          onClick={() => onDelete(row.original.id)}
          aria-label={`Eliminar ${row.original.razon_social}`}
        >
          <Trash2 className="w-4 h-4 text-red-500" />
        </Button>
      </div>
    ),
  },
];
