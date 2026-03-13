<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class GuiaRemisionDetalleResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'id_guia' => $this->id_guia,
            'id_producto' => $this->id_producto,
            'codigo' => $this->codigo,
            'descripcion' => $this->descripcion,
            'cantidad' => $this->cantidad,
            'unidad' => $this->unidad,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
