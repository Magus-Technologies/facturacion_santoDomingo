import { useState, useCallback } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import api from '@/services/api';

export function useTransportistas(filters = {}) {
  const queryClient = useQueryClient();
  const [page, setPage] = useState(1);
  const [search, setSearch] = useState('');
  const [estado, setEstado] = useState(null);

  // Obtener transportistas
  const { data, isLoading, error } = useQuery({
    queryKey: ['transportistas', page, search, estado],
    queryFn: async () => {
      const response = await api.get('/transportistas', {
        params: {
          page,
          search,
          estado,
          per_page: 15,
        },
      });
      return response.data.data;
    },
  });

  // Crear transportista
  const createMutation = useMutation({
    mutationFn: (data) => api.post('/transportistas', data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['transportistas'] });
    },
  });

  // Actualizar transportista
  const updateMutation = useMutation({
    mutationFn: ({ id, data }) => api.put(`/transportistas/${id}`, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['transportistas'] });
    },
  });

  // Eliminar transportista
  const deleteMutation = useMutation({
    mutationFn: (id) => api.delete(`/transportistas/${id}`),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['transportistas'] });
    },
  });

  // Obtener transportistas activos
  const { data: activosData } = useQuery({
    queryKey: ['transportistas-activos'],
    queryFn: async () => {
      const response = await api.get('/transportistas/activos');
      return response.data.data;
    },
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
    transportistas: data?.data || [],
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
    activos: activosData || [],
  };
}
