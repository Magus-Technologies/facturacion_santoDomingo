<?php

namespace App\Exceptions;

class CajaYaAbiertaException extends CajaException
{
    public function httpStatus(): int    { return 422; }
    public function jsonMessage(): string { return 'Ya existe una caja abierta en esta empresa.'; }
}
