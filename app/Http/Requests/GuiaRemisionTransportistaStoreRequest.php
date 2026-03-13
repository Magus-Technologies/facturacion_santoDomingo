<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class GuiaRemisionTransportistaStoreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            // Remitente
            'remitente_tipo_doc'       => 'required|in:1,6',
            'remitente_documento'      => 'required|string|max:15',
            'remitente_nombre'         => 'required|string|max:255',
            'remitente_direccion'      => 'required|string|max:500',
            'remitente_ubigeo'         => 'nullable|string|max:6',
            'remitente_cod_establecimiento' => 'nullable|string|max:4',
            // Destinatario
            'destinatario_tipo_doc'    => 'required|in:1,4,6',
            'destinatario_documento'   => 'required|string|max:15',
            'destinatario_nombre'      => 'required|string|max:255',
            'destinatario_cod_establecimiento' => 'nullable|string|max:4',
            // Pagador del Flete
            'pagador_tipo_doc'         => 'required|in:1,6',
            'pagador_documento'        => 'required|string|digits_between:8,11',
            'pagador_razon_social'     => 'required|string|max:255',
            // Traslado
            'motivo_traslado'          => 'required|string|max:2',
            'descripcion_motivo'       => 'nullable|string|max:255',
            'fecha_traslado'           => 'required|date',
            'ubigeo_partida'           => 'nullable|string|max:6',
            'dir_partida'              => 'required|string|max:500',
            'ubigeo_llegada'           => 'nullable|string|max:6',
            'dir_llegada'              => 'required|string|max:500',
            'peso_total'               => 'required|numeric|min:0.001',
            'und_peso_total'           => 'nullable|string|max:3',
            // Conductor
            'conductor_tipo_doc'       => 'required|string|max:1',
            'conductor_documento'      => 'required|string|max:15',
            'conductor_nombres'        => 'required|string|max:255',
            'conductor_apellidos'      => 'required|string|max:255',
            'conductor_licencia'       => 'required|string|max:20',
            // Vehículo
            'vehiculo_placa'           => 'required|string|max:10',
            'vehiculo_placa_secundaria'=> 'nullable|string|max:20',
            'vehiculo_marca'           => 'nullable|string|max:50',
            'vehiculo_configuracion'   => 'nullable|string|max:10',
            'vehiculo_habilitacion'    => 'nullable|string|max:50',
            'numero_registro_mtc'      => 'required|string|max:50',
            'emisor_autorizacion'      => 'required|in:MTC,Municipalidad,Otro',
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
            // Detalles
            'detalles'                 => 'required|array|min:1',
            'detalles.*.descripcion'   => 'required|string',
            'detalles.*.cantidad'      => 'required|numeric|min:0.001',
            'detalles.*.unidad'        => 'nullable|string|max:5',
            'detalles.*.codigo'        => 'nullable|string|max:30',
            // Observaciones
            'observaciones'            => 'nullable|string',
        ];
    }
}
