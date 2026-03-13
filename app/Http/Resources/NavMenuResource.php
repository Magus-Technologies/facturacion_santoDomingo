<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class NavMenuResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'        => $this->id,
            'label'     => $this->label,
            'url'       => $this->url,
            'parent_id' => $this->parent_id,
            'orden'     => $this->orden,
            'estado'    => $this->estado,
            'target'    => $this->target,
            'hijos'     => NavMenuResource::collection($this->whenLoaded('hijos')),
        ];
    }
}
