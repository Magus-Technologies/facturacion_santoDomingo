import { useSunatStore } from '@/stores/useSunatStore';
import { toast } from '@/lib/sweetalert';

export const useSunat = (fetchVentas) => {
    const { generarXml, enviarSunat, loading } = useSunatStore();

    const handleGenerarXml = async (venta) => {
        const resultado = await generarXml(venta.id_venta);

        if (resultado.success) {
            toast.success(`XML generado: ${resultado.nombre_archivo}`);
            if (fetchVentas) fetchVentas();
        } else {
            toast.error(resultado.message || 'Error al generar XML');
        }

        return resultado;
    };

    const handleEnviarSunat = async (venta) => {
        const resultado = await enviarSunat(venta.id_venta);

        if (resultado.success) {
            toast.success(`Enviado a SUNAT: ${resultado.mensaje || 'Aceptado'}`);
            if (fetchVentas) fetchVentas();
        } else {
            toast.error(resultado.message || 'Error al enviar a SUNAT');
        }

        return resultado;
    };

    const handleGenerarYEnviar = async (venta) => {
        const xmlResult = await generarXml(venta.id_venta);
        if (!xmlResult.success) {
            toast.error(xmlResult.message || 'Error al generar XML');
            return xmlResult;
        }

        const envioResult = await enviarSunat(venta.id_venta);
        if (envioResult.success) {
            toast.success(`Enviado a SUNAT: ${envioResult.mensaje || 'Aceptado'}`);
            if (fetchVentas) fetchVentas();
        } else {
            toast.error(envioResult.message || 'Error al enviar a SUNAT');
        }

        return envioResult;
    };

    return {
        handleGenerarXml,
        handleEnviarSunat,
        handleGenerarYEnviar,
        sunatLoading: loading,
    };
};
