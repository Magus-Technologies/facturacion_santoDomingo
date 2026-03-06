---
name: nuevo-modulo
description: Crea un módulo frontend completo (page, table, columns, hooks, form) siguiendo exactamente los patrones del sistema Santo Domingo. Usar cuando el usuario pida crear un nuevo módulo, pantalla, sección o CRUD en el frontend.
argument-hint: <NombreModulo> [descripción opcional]
---

# Skill: Crear Nuevo Módulo Frontend

Crea un módulo frontend completo para **$ARGUMENTS** siguiendo los patrones exactos del sistema.

## ARQUITECTURA OBLIGATORIA

```
resources/js/components/$NombreModulo/
├── $NombreModuloPage.jsx          # Lista principal (MainLayout + Card)
├── $NombreModuloTable.jsx         # Tabla con filtros, modal, alertDialog
├── $NombreModuloAddPage.jsx       # Página de creación (ruta separada)
├── $NombreModuloForm.jsx          # Formulario reutilizable
├── columns/
│   └── $nombreModuloColumns.jsx   # Definición de columnas TanStack
├── hooks/
│   └── use$NombreModulo.js        # useQuery + useMutation (TanStack Query)
└── modals/
    └── $NombreModuloModal.jsx     # Modal de ver/editar (opcional)
```

## PASOS A SEGUIR

### 1. LEER EL CONTEXTO
Antes de generar código, leer como referencia:
- `resources/js/components/Finanzas/Transportistas/` — módulo más reciente y completo
- `resources/js/components/ui/` — primitivas UI disponibles
- `resources/js/lib/sweetalert.js` — helpers de toast/confirm

### 2. HOOK (`hooks/use$NombreModulo.js`)

**OBLIGATORIO**: Usar TanStack Query (`@tanstack/react-query`) + `api` de axios. NO usar `useState`/`useEffect` para fetching.

```javascript
import { useState, useCallback } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import api from '@/services/api';

export function use$NombreModulo() {
  const queryClient = useQueryClient();
  const [page, setPage] = useState(1);
  const [search, setSearch] = useState('');
  const [estado, setEstado] = useState(null);

  const { data, isLoading, error } = useQuery({
    queryKey: ['$nombreModulo', page, search, estado],
    queryFn: async () => {
      const response = await api.get('/$nombre-ruta', {
        params: { page, search, estado, per_page: 15 },
      });
      return response.data.data; // data.data = paginación Laravel
    },
  });

  const createMutation = useMutation({
    mutationFn: (data) => api.post('/$nombre-ruta', data),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ['$nombreModulo'] }),
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }) => api.put(`/$nombre-ruta/${id}`, data),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ['$nombreModulo'] }),
  });

  const deleteMutation = useMutation({
    mutationFn: (id) => api.delete(`/$nombre-ruta/${id}`),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ['$nombreModulo'] }),
  });

  const handleSearch = useCallback((value) => {
    setSearch(value);
    setPage(1);
  }, []);

  const handleEstadoFilter = useCallback((value) => {
    setEstado(value);
    setPage(1);
  }, []);

  return {
    items: data?.data || [],
    pagination: {
      current_page: data?.current_page,
      last_page: data?.last_page,
      per_page: data?.per_page,
      total: data?.total,
    },
    isLoading,
    error,
    page,
    setPage,
    search,
    handleSearch,
    estado,
    handleEstadoFilter,
    create: createMutation.mutate,
    isCreating: createMutation.isPending,
    update: updateMutation.mutate,
    isUpdating: updateMutation.isPending,
    delete: deleteMutation.mutate,
    isDeleting: deleteMutation.isPending,
  };
}
```

### 3. COLUMNS (`columns/$nombreModuloColumns.jsx`)

Botones directos (no DropdownMenu) para acciones simples:

```javascript
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Edit2, Trash2 } from 'lucide-react';

export const $nombreModuloColumns = (onEdit, onDelete) => [
  {
    accessorKey: 'nombre',
    header: 'Nombre',
    cell: ({ row }) => (
      <div className="flex flex-col">
        <span className="font-medium">{row.original.nombre}</span>
        {row.original.descripcion && (
          <span className="text-xs text-gray-500">{row.original.descripcion}</span>
        )}
      </div>
    ),
  },
  // ... columnas de negocio
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
        <Button variant="ghost" size="sm" onClick={() => onEdit(row.original)}>
          <Edit2 className="w-4 h-4" />
        </Button>
        <Button variant="ghost" size="sm" onClick={() => onDelete(row.original.id)}>
          <Trash2 className="w-4 h-4 text-red-500" />
        </Button>
      </div>
    ),
  },
];
```

### 4. TABLE (`$NombreModuloTable.jsx`)

Componente de tabla con filtros, AlertDialog de confirmación y modal de edición:

```javascript
import { useState } from 'react';
import DataTable from '@/components/Dashboard/components/DataTable';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Plus, Loader2 } from 'lucide-react';
import { $nombreModuloColumns } from './columns/$nombreModuloColumns';
import { $NombreModuloModal } from './modals/$NombreModuloModal';
import {
  AlertDialog, AlertDialogAction, AlertDialogCancel,
  AlertDialogContent, AlertDialogDescription,
  AlertDialogHeader, AlertDialogTitle,
} from '@/components/ui/alert-dialog';
import { useToast } from '@/hooks/use-toast';

export function $NombreModuloTable({
  items, isLoading, pagination, page, setPage,
  search, handleSearch, estado, handleEstadoFilter,
  onEdit, onDelete, isDeleting,
}) {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selected, setSelected] = useState(null);
  const [deleteId, setDeleteId] = useState(null);
  const { toast } = useToast();

  const handleOpenModal = (item = null) => {
    setSelected(item);
    setIsModalOpen(true);
  };

  const handleDeleteConfirm = () => {
    if (!deleteId) return;
    onDelete(deleteId, {
      onSuccess: () => {
        toast({ title: 'Éxito', description: '$NombreModulo eliminado correctamente' });
        setDeleteId(null);
      },
      onError: (error) => {
        toast({
          title: 'Error',
          description: error.response?.data?.message || 'Error al eliminar',
          variant: 'destructive',
        });
      },
    });
  };

  const columns = $nombreModuloColumns(handleOpenModal, (id) => setDeleteId(id));

  return (
    <div className="space-y-4">
      {/* Filtros */}
      <div className="flex flex-col md:flex-row gap-4">
        <Input
          placeholder="Buscar..."
          value={search}
          onChange={(e) => handleSearch(e.target.value)}
          className="flex-1"
        />
        <Select
          value={estado === null ? 'all' : estado.toString()}
          onValueChange={(v) => handleEstadoFilter(v === 'all' ? null : v === 'true')}
        >
          <SelectTrigger className="w-full md:w-48">
            <SelectValue placeholder="Filtrar por estado" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="all">Todos</SelectItem>
            <SelectItem value="true">Activos</SelectItem>
            <SelectItem value="false">Inactivos</SelectItem>
          </SelectContent>
        </Select>
        <Button onClick={() => window.location.href = '/$nombre-ruta/add'} className="gap-2">
          <Plus className="w-4 h-4" />
          Nuevo $NombreModulo
        </Button>
      </div>

      {/* Tabla */}
      {isLoading ? (
        <div className="flex items-center justify-center py-8">
          <Loader2 className="w-6 h-6 animate-spin" />
        </div>
      ) : (
        <DataTable
          columns={columns}
          data={items}
          pagination={pagination}
          onPageChange={setPage}
          currentPage={page}
        />
      )}

      {/* Modal editar */}
      <$NombreModuloModal
        isOpen={isModalOpen}
        onClose={() => { setIsModalOpen(false); setSelected(null); }}
        item={selected}
        onSubmit={onEdit}
      />

      {/* Confirmar eliminación */}
      <AlertDialog open={!!deleteId} onOpenChange={(open) => !open && setDeleteId(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>¿Eliminar $nombreModulo?</AlertDialogTitle>
            <AlertDialogDescription>
              Esta acción no se puede deshacer.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <div className="flex gap-2 justify-end">
            <AlertDialogCancel>Cancelar</AlertDialogCancel>
            <AlertDialogAction onClick={handleDeleteConfirm} disabled={isDeleting}>
              {isDeleting ? 'Eliminando...' : 'Eliminar'}
            </AlertDialogAction>
          </div>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
```

### 5. PAGE (`$NombreModuloPage.jsx`)

```javascript
import { use$NombreModulo } from './hooks/use$NombreModulo';
import { $NombreModuloTable } from './$NombreModuloTable';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { AlertCircle } from 'lucide-react';
import MainLayout from '@/components/Layout/MainLayout';

export function $NombreModuloPage() {
  const {
    items, pagination, isLoading, error,
    page, setPage, search, handleSearch,
    estado, handleEstadoFilter,
    update, isUpdating, delete: deleteItem, isDeleting,
  } = use$NombreModulo();

  const handleEdit = ({ id, data }, callbacks) => {
    update({ id, data }, { onSuccess: callbacks.onSuccess, onError: callbacks.onError });
  };

  const handleDelete = (id, callbacks) => {
    deleteItem(id, { onSuccess: callbacks.onSuccess, onError: callbacks.onError });
  };

  return (
    <MainLayout>
      <div className="space-y-6">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">$NombreModulo</h1>
          <p className="text-gray-600 mt-2">Gestiona los registros de $nombreModulo</p>
        </div>

        {error && (
          <div className="bg-red-50 border border-red-200 rounded-lg p-4 flex items-center gap-3">
            <AlertCircle className="h-4 w-4 text-red-600 shrink-0" />
            <p className="text-sm text-red-700">Error al cargar datos. Intenta de nuevo.</p>
          </div>
        )}

        <Card>
          <CardHeader>
            <CardTitle>Listado de $NombreModulo</CardTitle>
          </CardHeader>
          <CardContent>
            <$NombreModuloTable
              items={items}
              isLoading={isLoading}
              pagination={pagination}
              page={page}
              setPage={setPage}
              search={search}
              handleSearch={handleSearch}
              estado={estado}
              handleEstadoFilter={handleEstadoFilter}
              onEdit={handleEdit}
              onDelete={handleDelete}
              isDeleting={isDeleting}
            />
          </CardContent>
        </Card>
      </div>
    </MainLayout>
  );
}

export default $NombreModuloPage;
```

### 6. ADD PAGE (`$NombreModuloAddPage.jsx`)

Para formularios de creación con ruta propia:

```javascript
import { useState } from 'react';
import MainLayout from '@/components/Layout/MainLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { ArrowLeft } from 'lucide-react';
import { $NombreModuloForm } from './$NombreModuloForm';
import api from '@/services/api';
import { toast } from '@/lib/sweetalert';

export function $NombreModuloAddPage() {
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (data, setErrors) => {
    setIsLoading(true);
    try {
      await api.post('/$nombre-ruta', data);
      toast.success('$NombreModulo creado correctamente');
      window.location.href = '/facturacion/$nombre-ruta';
    } catch (error) {
      if (error.response?.status === 422) {
        setErrors(error.response.data.errors || {});
      } else {
        toast.error(error.response?.data?.message || 'Error al crear');
      }
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <MainLayout>
      <div className="mb-6">
        <nav className="text-sm text-gray-500 mb-2">
          <a href="/facturacion/$nombre-ruta" className="hover:text-primary-600">$NombreModulo</a>
          <span className="mx-2">/</span>
          <span className="text-gray-900">Nuevo</span>
        </nav>
        <div className="flex items-center justify-between">
          <h1 className="text-2xl font-bold text-gray-900">Nuevo $NombreModulo</h1>
          <Button variant="outline" onClick={() => window.location.href = '/facturacion/$nombre-ruta'}>
            <ArrowLeft className="h-4 w-4 mr-2" />
            Regresar
          </Button>
        </div>
      </div>
      <div className="max-w-2xl">
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Datos del $NombreModulo</CardTitle>
          </CardHeader>
          <CardContent>
            <$NombreModuloForm onSubmit={handleSubmit} isLoading={isLoading} />
          </CardContent>
        </Card>
      </div>
    </MainLayout>
  );
}
```

### 7. REGISTRAR EN `app.jsx`

Agregar **import directo** (NO lazy) al inicio del archivo y al objeto `components`:

```javascript
// Import al inicio
import { $NombreModuloPage } from './components/$NombreModulo/$NombreModuloPage';
import { $NombreModuloAddPage } from './components/$NombreModulo/$NombreModuloAddPage';

// En el objeto components
const components = {
  // ... existentes ...
  $NombreModuloPage,
  $NombreModuloAddPage,
};
```

### 8. VISTAS BLADE

`resources/views/facturacion/$nombre-modulo/index.blade.php`:
```blade
@extends('layouts.app')
@section('content')
<div data-react-component="$NombreModuloPage"></div>
@endsection
```

`resources/views/facturacion/$nombre-modulo/add.blade.php`:
```blade
@extends('layouts.app')
@section('content')
<div data-react-component="$NombreModuloAddPage"></div>
@endsection
```

## REGLAS OBLIGATORIAS

1. **TanStack Query SIEMPRE** — Nunca usar `useState`/`useEffect` para fetching. Usar `useQuery`/`useMutation`
2. **`api` service** — Usar `import api from '@/services/api'`. El token se adjunta automáticamente vía interceptor
3. **Toast en pages/forms**: `import { toast } from '@/lib/sweetalert'` para acciones (crear/guardar)
4. **Toast en tables**: `useToast` de `@/hooks/use-toast` para callbacks de mutaciones
5. **Layout**: Todas las pages envuelven con `<MainLayout>`
6. **DataTable**: `@/components/Dashboard/components/DataTable` con paginación server-side
7. **Colores**: Botón primario sin clase explícita (usa default de `Button`). Rojo destructivo con `text-red-500` en iconos Trash
8. **Imports en app.jsx**: Directos (no lazy). Exports nombrados (`export function`) en Pages
9. **Paginación**: Siempre server-side con `page`, `search`, `estado`, `per_page` params
10. **AlertDialog**: Para confirmación de eliminación, no `window.confirm`
11. **Errores 422**: Capturar `error.response.data.errors` y pasarlos al form con `setErrors`
