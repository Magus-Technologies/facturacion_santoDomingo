<?php

namespace App\Services\Contracts;

use App\Models\Caja;
use App\Models\User;
use Illuminate\Pagination\LengthAwarePaginator;

interface CajaServiceInterface
{
    public function listar(int $empresaId): LengthAwarePaginator;
    public function crear(array $datos, int $empresaId, User $usuario): Caja;
    public function obtener(int $cajaId, int $empresaId): ?Caja;
}
