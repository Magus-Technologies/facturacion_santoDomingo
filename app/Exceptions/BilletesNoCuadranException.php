<?php

namespace App\Exceptions;

class BilletesNoCuadranException extends CajaException
{
    public function __construct(private readonly float $totalBilletes, private readonly float $saldoInicial)
    {
        parent::__construct("Billetes: {$totalBilletes}, Saldo: {$saldoInicial}");
    }

    public function httpStatus(): int { return 422; }

    public function jsonMessage(): string
    {
        return "La suma de billetes ({$this->totalBilletes}) no coincide con el saldo inicial ({$this->saldoInicial}).";
    }
}
