<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TransportistaResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'id_empresa' => $this->id_empresa,
            'tipo_documento' => $this->tipo_documento,
            'numero_documento' => $this->numero_documento,
            'razon_social' => $this->razon_social,
            'nombre_comercial' => $this->nombre_comercial,
            'numero_mtc' => $this->numero_mtc,
            'telefono' => $this->telefono,
            'email' => $this->email,
            'direccion' => $this->direccion,
            'estado' => $this->estado,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
