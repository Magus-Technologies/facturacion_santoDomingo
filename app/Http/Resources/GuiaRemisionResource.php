<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class GuiaRemisionResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'id_empresa' => $this->id_empresa,
            'id_usuario' => $this->id_usuario,
            'id_venta' => $this->id_venta,
            'id_transportista' => $this->id_transportista,
            'serie' => $this->serie,
            'numero' => $this->numero,
            'numero_completo' => $this->numero_completo,
            'fecha_emision' => $this->fecha_emision,
            'destinatario_tipo_doc' => $this->destinatario_tipo_doc,
            'destinatario_documento' => $this->destinatario_documento,
            'destinatario_nombre' => $this->destinatario_nombre,
            'motivo_traslado' => $this->motivo_traslado,
            'descripcion_motivo' => $this->descripcion_motivo,
            'mod_transporte' => $this->mod_transporte,
            'fecha_traslado' => $this->fecha_traslado,
            'peso_total' => $this->peso_total,
            'und_peso_total' => $this->und_peso_total,
            'ubigeo_partida' => $this->ubigeo_partida,
            'dir_partida' => $this->dir_partida,
            'ubigeo_llegada' => $this->ubigeo_llegada,
            'dir_llegada' => $this->dir_llegada,
            'transportista_tipo_doc' => $this->transportista_tipo_doc,
            'transportista_documento' => $this->transportista_documento,
            'transportista_nombre' => $this->transportista_nombre,
            'transportista_nro_mtc' => $this->transportista_nro_mtc,
            'conductor_tipo_doc' => $this->conductor_tipo_doc,
            'conductor_documento' => $this->conductor_documento,
            'conductor_nombres' => $this->conductor_nombres,
            'conductor_apellidos' => $this->conductor_apellidos,
            'conductor_licencia' => $this->conductor_licencia,
            'vehiculo_placa' => $this->vehiculo_placa,
            'vehiculo_m1l' => $this->vehiculo_m1l,
            'observaciones' => $this->observaciones,
            'estado' => $this->estado,
            'nombre_xml' => $this->nombre_xml,
            'xml_url' => $this->xml_url,
            'cdr_url' => $this->cdr_url,
            'hash_cpe' => $this->hash_cpe,
            'codigo_sunat' => $this->codigo_sunat,
            'mensaje_sunat' => $this->mensaje_sunat,
            'ticket_sunat' => $this->ticket_sunat,
            'detalles' => GuiaRemisionDetalleResource::collection($this->whenLoaded('detalles')),
            'transportista' => new TransportistaResource($this->whenLoaded('transportista')),
            'venta' => new VentaResource($this->whenLoaded('venta')),
            'usuario' => new UserResource($this->whenLoaded('usuario')),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
