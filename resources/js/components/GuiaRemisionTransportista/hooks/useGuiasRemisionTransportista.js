import { useState } from 'react';
import { useQuery, useQueryClient } from '@tanstack/react-query';
import api from '@/services/api';
import { toast } from '@/lib/sweetalert';

export function useGuiasRemisionTransportista() {
    const queryClient = useQueryClient();
    const [enviandoId, setEnviandoId] = useState(null);

    const { data, isLoading, error, refetch } = useQuery({
        queryKey: ['guias-remision-transportista'],
        queryFn: async () => {
            const response = await api.get('/guias-remision-transportista');
            return response.data;
        },
    });

    const enviarGuia = async (id) => {
        setEnviandoId(id);
        try {
            const response = await api.post(`/guias-remision-transportista/${id}/enviar`);
            const result = response.data;
            if (result.success) {
                toast.success(result.message || 'Guía enviada a SUNAT');
                queryClient.invalidateQueries({ queryKey: ['guias-remision-transportista'] });
            } else {
                toast.error(result.message || 'Error al enviar a SUNAT');
            }
            return result;
        } catch (err) {
            toast.error(err.response?.data?.message || 'Error de conexión');
            return { success: false };
        } finally {
            setEnviandoId(null);
        }
    };

    const consultarTicket = async (id) => {
        setEnviandoId(id);
        try {
            const response = await api.get(`/guias-remision-transportista/${id}/ticket`);
            const result = response.data;
            if (result.success && !result.en_proceso) {
                toast.success(result.mensaje || 'Guía aceptada por SUNAT');
                queryClient.invalidateQueries({ queryKey: ['guias-remision-transportista'] });
            } else if (result.en_proceso) {
                toast.info('En proceso. Intente en unos segundos.');
            } else {
                toast.error(result.message || 'Error al consultar ticket');
            }
            return result;
        } catch (err) {
            toast.error(err.response?.data?.message || 'Error de conexión');
            return { success: false };
        } finally {
            setEnviandoId(null);
        }
    };

    return {
        guias: data?.data || [],
        isLoading,
        error,
        refetch,
        enviandoId,
        enviarGuia,
        consultarTicket,
    };
}
