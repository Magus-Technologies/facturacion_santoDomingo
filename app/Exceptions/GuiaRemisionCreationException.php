<?php

namespace App\Exceptions;

class GuiaRemisionCreationException extends GuiaRemisionException
{
    public function __construct(string $message = 'Error al crear la guía de remisión', \Throwable $previous = null)
    {
        parent::__construct($message, 500, $previous);
    }
}
