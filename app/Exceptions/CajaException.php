<?php

namespace App\Exceptions;

use RuntimeException;

/**
 * Excepción base del dominio Caja.
 * Todas las excepciones de caja heredan de esta.
 */
abstract class CajaException extends RuntimeException
{
    abstract public function httpStatus(): int;
    abstract public function jsonMessage(): string;
}
