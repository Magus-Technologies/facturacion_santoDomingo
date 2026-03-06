<?php

namespace App\Services\Contracts;

use App\Models\Caja;
use App\Models\User;

interface CajaSesionServiceInterface
{
    public function abrir(Caja $caja, array $datos, User $usuario): Caja;
    public function cerrar(Caja $caja, array $datos, User $usuario): Caja;
    public function autorizarCierre(Caja $caja, User $usuario): Caja;
    public function rechazarCierre(Caja $caja, User $usuario): Caja;
}
