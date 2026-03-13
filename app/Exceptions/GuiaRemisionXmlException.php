<?php

namespace App\Exceptions;

class GuiaRemisionXmlException extends GuiaRemisionException
{
    public function __construct(string $message = 'Error al generar XML', \Throwable $previous = null)
    {
        parent::__construct($message, 500, $previous);
    }
}
