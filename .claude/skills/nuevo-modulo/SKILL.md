---
name: nuevo-modulo
description: Crea un módulo frontend completo (page, columns, hooks, form) siguiendo exactamente los patrones del sistema Santo Domingo. Usar cuando el usuario pida crear un nuevo módulo, pantalla, sección o CRUD en el frontend.
argument-hint: <NombreModulo> [descripción opcional]
allowed-tools: Read, Glob, Grep, Write, Edit, Bash
---

# Skill: Crear Nuevo Módulo Frontend

Crea un módulo frontend completo para **$ARGUMENTS** siguiendo los patrones exactos del sistema.

## ARQUITECTURA OBLIGATORIA

La estructura de carpetas es siempre:
```
resources/js/components/$NombreModulo/
├── $NombreModuloPage.jsx          # Lista con DataTable
├── $NombreModuloForm.jsx          # Formulario crear/editar
├── $NombreModuloModal.jsx         # Modal de detalle (si aplica)
├── columns/
│   └── $nombreModuloColumns.jsx   # Definición de columnas TanStack
└── hooks/
    ├── use$NombreModulo.js        # Lógica lista + acciones
    └── use$NombreModuloForm.js    # Lógica formulario + submit
```

## PASOS A SEGUIR

### 1. LEER EL CONTEXTO
Antes de generar código, leer:
- `resources/js/components/ui/` - primitivas disponibles
- `resources/css/app.css` - colores del sistema (primary-600 = rojo #c7161d, accent-300 = crema)
- Un módulo similar existente para referencia de patrones (ej. Ventas, Clientes, Productos)

### 2. HOOK DE LISTA (`use$NombreModulo.js`)
```javascript
import { useState, useEffect } from 'react';
import { toast } from 'react-hot-toast';

export const use$NombreModulo = () => {
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchItems = async () => {
    try {
      setLoading(true);
      const token = localStorage.getItem('auth_token');
      const response = await fetch('/api/$nombre-ruta', {
        headers: {
          Authorization: `Bearer ${token}`,
          Accept: 'application/json',
        },
      });
      const data = await response.json();
      if (data.success) setItems(data.data);
      else setError(data.message);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { fetchItems(); }, []);

  const handleDelete = async (id) => {
    if (!confirm('¿Estás seguro de eliminar este registro?')) return;
    const token = localStorage.getItem('auth_token');
    const response = await fetch(`/api/$nombre-ruta/${id}`, {
      method: 'DELETE',
      headers: { Authorization: `Bearer ${token}` },
    });
    const data = await response.json();
    if (data.success) {
      toast.success(data.message || 'Eliminado correctamente');
      fetchItems();
    } else {
      toast.error(data.message || 'Error al eliminar');
    }
  };

  return { items, loading, error, fetchItems, handleDelete };
};
```

### 3. COLUMNS (`$nombreModuloColumns.jsx`)
```javascript
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import { MoreHorizontal, Eye, Pencil, Trash2 } from 'lucide-react';

export const get$NombreModuloColumns = ({ handleView, handleEdit, handleDelete }) => [
  {
    accessorKey: 'id_$nombre',
    header: 'ID',
    size: 60,
  },
  // ... columnas de negocio aquí
  {
    id: 'acciones',
    header: 'Acciones',
    size: 80,
    enableSorting: false,
    cell: ({ row }) => (
      <DropdownMenu>
        <DropdownMenuTrigger asChild>
          <Button variant="ghost" size="icon">
            <MoreHorizontal className="h-4 w-4" />
          </Button>
        </DropdownMenuTrigger>
        <DropdownMenuContent align="end">
          <DropdownMenuItem onClick={() => handleView(row.original)}>
            <Eye className="mr-2 h-4 w-4" /> Ver detalle
          </DropdownMenuItem>
          <DropdownMenuItem onClick={() => handleEdit(row.original)}>
            <Pencil className="mr-2 h-4 w-4" /> Editar
          </DropdownMenuItem>
          <DropdownMenuItem
            className="text-red-600"
            onClick={() => handleDelete(row.original.id_$nombre)}
          >
            <Trash2 className="mr-2 h-4 w-4" /> Eliminar
          </DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>
    ),
  },
];
```

### 4. PAGE (`$NombreModuloPage.jsx`)
```javascript
import { useState } from 'react';
import { DataTable } from '@/components/ui/data-table';
import { Button } from '@/components/ui/button';
import { Plus } from 'lucide-react';
import { use$NombreModulo } from './hooks/use$NombreModulo';
import { get$NombreModuloColumns } from './columns/$nombreModuloColumns';
import $NombreModuloModal from './$NombreModuloModal';

const $NombreModuloPage = () => {
  const { items, loading, fetchItems, handleDelete } = use$NombreModulo();
  const [selected, setSelected] = useState(null);
  const [isModalOpen, setIsModalOpen] = useState(false);

  const handleView = (item) => {
    setSelected(item);
    setIsModalOpen(true);
  };

  const handleEdit = (item) => {
    window.location.href = `/$nombre-ruta/${item.id_$nombre}/editar`;
  };

  const columns = get$NombreModuloColumns({ handleView, handleEdit, handleDelete });

  return (
    <div className="space-y-4">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">$NombreModulo</h1>
          <p className="text-sm text-gray-500">Gestión de $nombre</p>
        </div>
        <Button
          onClick={() => window.location.href = '/$nombre-ruta/nuevo'}
          className="bg-primary-600 hover:bg-primary-700 text-white"
        >
          <Plus className="mr-2 h-4 w-4" />
          Nuevo $NombreModulo
        </Button>
      </div>

      {/* Tabla */}
      <DataTable
        columns={columns}
        data={items}
        loading={loading}
        searchable
        pagination
      />

      {/* Modal detalle */}
      {selected && (
        <$NombreModuloModal
          item={selected}
          isOpen={isModalOpen}
          onClose={() => { setIsModalOpen(false); setSelected(null); }}
        />
      )}
    </div>
  );
};

export default $NombreModuloPage;
```

### 5. REGISTRAR EN `app.jsx`
Agregar el componente al registro en `resources/js/app.jsx`:
```javascript
'$NombreModuloPage': lazy(() => import('./components/$NombreModulo/$NombreModuloPage')),
'$NombreModuloForm': lazy(() => import('./components/$NombreModulo/$NombreModuloForm')),
```

### 6. VISTA BLADE
Crear en `resources/views/$nombre-modulo/index.blade.php`:
```blade
@extends('layouts.app')
@section('content')
<div data-react-component="$NombreModuloPage"></div>
@endsection
```

## REGLAS DE DISEÑO OBLIGATORIAS

1. **Colores**: Usar SIEMPRE `bg-primary-600` (rojo) para botones principales, nunca `bg-blue-*` ni `bg-indigo-*`
2. **Botón primario**: `className="bg-primary-600 hover:bg-primary-700 text-white"`
3. **Badge de estado activo**: `<Badge variant="success">Activo</Badge>`
4. **Badge de estado inactivo**: `<Badge variant="danger">Inactivo</Badge>`
5. **Imports de UI**: Siempre desde `@/components/ui/...`
6. **Auth token**: Siempre `localStorage.getItem('auth_token')` + header `Authorization: Bearer`
7. **Respuestas API**: Siempre verificar `data.success` antes de usar datos
8. **Toast**: `toast.success()` / `toast.error()` de `react-hot-toast`
9. **Iconos**: Siempre de `lucide-react`
10. **No usar**: axios, react-query, SWR, ni otras librerías de fetching
