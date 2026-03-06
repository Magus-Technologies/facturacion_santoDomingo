<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CajaResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id_caja'        => $this->id_caja,
            'nombre'         => $this->nombre,
            'descripcion'    => $this->descripcion,
            'estado'         => $this->estado,
            'saldo_inicial'  => $this->saldo_inicial,
            'tipo_apertura'  => $this->tipo_apertura,
            'fecha_apertura' => $this->fecha_apertura?->toDateTimeString(),
            'fecha_cierre'   => $this->fecha_cierre?->toDateTimeString(),

            'responsable' => $this->whenLoaded('responsable', fn() => [
                'id'   => $this->responsable->id,
                'name' => $this->responsable->name,
            ]),

            'usuario_apertura' => $this->whenLoaded('usuarioApertura', fn() => [
                'id'   => $this->usuarioApertura->id,
                'name' => $this->usuarioApertura->name,
            ]),

            'usuario_cierre' => $this->whenLoaded('usuarioCierre', fn() => [
                'id'   => $this->usuarioCierre->id,
                'name' => $this->usuarioCierre->name,
            ]),

            'metodos_pago' => $this->whenLoaded('metodosPago', fn() =>
                $this->metodosPago->map(fn($m) => [
                    'id_metodo_pago' => $m->id_metodo_pago,
                    'nombre'         => $m->nombre,
                    'es_efectivo'    => $m->es_efectivo,
                    'cuenta_bancaria' => $m->cuentaBancaria ? [
                        'numero_cuenta' => $m->cuentaBancaria->numero_cuenta,
                        'banco'         => $m->cuentaBancaria->banco?->nombre,
                    ] : null,
                ])
            ),

            'resumen_cierre' => $this->when(
                !is_null($this->total_real),
                fn() => [
                    'total_teorico'  => $this->total_teorico,
                    'total_real'     => $this->total_real,
                    'diferencia'     => $this->diferencia,
                    'tipo_diferencia' => $this->tipo_diferencia,
                ]
            ),

            'created_at' => $this->created_at?->toDateTimeString(),
        ];
    }
}
