<?php

namespace App\Exceptions;

class CajaEstadoInvalidoException extends CajaException
{
    public function __construct(private readonly string $detalle = '')
    {
        parent::__construct($detalle);
    }

    public function httpStatus(): int    { return 422; }
    public function jsonMessage(): string { return $this->detalle ?: 'Estado de caja no válido para esta operación.'; }
}
