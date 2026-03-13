<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MarcaResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'cod_marca'    => $this->cod_marca,
            'nombre_marca' => $this->nombre_marca,
            'descripcion'  => $this->descripcion,
            'imagen'       => $this->imagen,
            'imagen_url'   => $this->imagen_url,
            'estado'       => $this->estado,
        ];
    }
}
