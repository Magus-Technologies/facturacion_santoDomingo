<?php

namespace App\Exceptions;

class CajaNoEncontradaException extends CajaException
{
    public function httpStatus(): int    { return 404; }
    public function jsonMessage(): string { return 'Caja no encontrada.'; }
}
