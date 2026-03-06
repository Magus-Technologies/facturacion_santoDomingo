<?php

namespace App\Services\Contracts;

use App\Models\Caja;
use App\Models\ArqueoDiario;
use App\Models\User;

interface CajaArqueoServiceInterface
{
    public function resumen(Caja $caja): array;
    public function crearArqueo(Caja $caja, User $usuarioAutorizador): ArqueoDiario;
}
