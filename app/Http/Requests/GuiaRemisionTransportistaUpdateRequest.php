<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class GuiaRemisionTransportistaUpdateRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            // Remitente
            'remitente_tipo_doc'       => 'sometimes|in:1,6',
            'remitente_documento'      => 'sometimes|string|max:15',
            'remitente_nombre'         => 'sometimes|string|max:255',
            'remitente_direccion'      => 'sometimes|string|max:500',
            'remitente_ubigeo'         => 'nullable|string|max:6',
            'remitente_cod_establecimiento' => 'nullable|string|max:4',
            // Destinatario
            'destinatario_tipo_doc'    => 'sometimes|in:1,4,6',
            'destinatario_documento'   => 'sometimes|string|max:15',
            'destinatario_nombre'      => 'sometimes|string|max:255',
            'destinatario_cod_establecimiento' => 'nullable|string|max:4',
            // Pagador del Flete
            'pagador_tipo_doc'         => 'sometimes|in:1,6',
            'pagador_documento'        => 'sometimes|string|digits_between:8,11',
            'pagador_razon_social'     => 'sometimes|string|max:255',
            // Traslado
            'motivo_traslado'          => 'sometimes|string|max:2',
            'descripcion_motivo'       => 'nullable|string|max:255',
            'fecha_traslado'           => 'sometimes|date',
            'ubigeo_partida'           => 'nullable|string|max:6',
            'dir_partida'              => 'sometimes|string|max:500',
            'ubigeo_llegada'           => 'nullable|string|max:6',
            'dir_llegada'              => 'sometimes|string|max:500',
            'peso_total'               => 'sometimes|numeric|min:0.001',
            'und_peso_total'           => 'nullable|string|max:3',
            // Conductor
            'conductor_tipo_doc'       => 'sometimes|string|max:1',
            'conductor_documento'      => 'sometimes|string|max:15',
            'conductor_nombres'        => 'sometimes|string|max:255',
            'conductor_apellidos'      => 'sometimes|string|max:255',
            'conductor_licencia'       => 'sometimes|string|max:20',
            // Vehículo
            'vehiculo_placa'           => 'sometimes|string|max:10',
            'vehiculo_placa_secundaria'=> 'nullable|string|max:20',
            'vehiculo_marca'           => 'nullable|string|max:50',
            'vehiculo_configuracion'   => 'nullable|string|max:10',
            'vehiculo_habilitacion'    => 'nullable|string|max:50',
            'numero_registro_mtc'      => 'sometimes|string|max:50',
            'emisor_autorizacion'      => 'sometimes|in:MTC,Municipalidad,Otro',
            // Documentos Relacionados
            'doc_relacionado_tipo'     => 'nullable|string|max:2',
            'doc_relacionado_serie'    => 'nullable|string|max:4',
            'doc_relacionado_numero'   => 'nullable|string|max:20',
            'doc_relacionado_emisor_ruc'=> 'nullable|string|max:11',
            // Mercancía Especial
            'mercancia_iqbf'           => 'nullable|boolean',
            'mercancia_peligrosa'      => 'nullable|boolean',
            'codigo_onu'               => 'required_if:mercancia_peligrosa,true|nullable|digits:4',
            'mercancia_voluminosa'     => 'nullable|boolean',
            // Observaciones
            'observaciones'            => 'nullable|string',
        ];
    }
}
