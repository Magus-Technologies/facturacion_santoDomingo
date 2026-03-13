<?php

namespace App\Exceptions;

use Exception;
use Throwable;

class GuiaRemisionException extends Exception
{
    public function render()
    {
        return response()->json([
            'success' => false,
            'message' => $this->message,
        ], $this->code ?: 400);
    }

    public static function fromThrowable(Throwable $e, string $message = null, int $code = 500): self
    {
        return new self($message ?? $e->getMessage(), $code);
    }
}

