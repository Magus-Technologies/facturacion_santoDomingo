<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OfertaResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'id_producto' => $this->id_producto,
            'id_empresa' => $this->id_empresa,
            'tipo' => $this->tipo,
            'valor' => $this->valor,
            'precio_final' => $this->precio_final,
            'fecha_inicio' => $this->fecha_inicio,
            'fecha_fin' => $this->fecha_fin,
            'estado' => $this->estado,
            'descripcion' => $this->descripcion,
            'vigente' => $this->isVigente(),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }

    private function isVigente(): bool
    {
        return $this->estado === '1'
            && $this->fecha_inicio <= now()
            && (is_null($this->fecha_fin) || $this->fecha_fin >= now());
    }
}
