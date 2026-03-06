<?php

namespace App\Services;

use App\Services\Contracts\CajaServiceInterface;
use App\Enums\CajaEstadoEnum;
use App\Models\Caja;
use App\Models\AuditoriaCaja;
use App\Models\User;
use Illuminate\Pagination\LengthAwarePaginator;

class CajaService implements CajaServiceInterface
{
    /**
     * Listar cajas de la empresa con relaciones necesarias.
     */
    public function listar(int $empresaId): LengthAwarePaginator
    {
        return Caja::where('id_empresa', $empresaId)
            ->with(['responsable', 'usuarioApertura', 'usuarioCierre', 'metodosPago.cuentaBancaria.banco'])
            ->orderBy('created_at', 'desc')
            ->paginate(15);
    }

    /**
     * Crear una nueva caja (entidad, sin apertura).
     */
    public function crear(array $datos, int $empresaId, User $usuario): Caja
    {
        $caja = Caja::create([
            'id_empresa'     => $empresaId,
            'nombre'         => $datos['nombre'],
            'descripcion'    => $datos['descripcion'] ?? null,
            'id_responsable' => $datos['id_responsable'],
            'estado'         => CajaEstadoEnum::Inactiva->value,
        ]);

        if (!empty($datos['metodos_pago'])) {
            $caja->metodosPago()->sync($datos['metodos_pago']);
        }

        AuditoriaCaja::create([
            'id_caja'    => $caja->id_caja,
            'id_usuario' => $usuario->id,
            'accion'     => 'Creación',
            'detalles'   => "Caja '{$caja->nombre}' creada. Responsable ID: {$datos['id_responsable']}. Métodos: " . count($datos['metodos_pago'] ?? []),
            'ip_address' => request()->ip(),
            'user_agent' => request()->userAgent(),
        ]);

        return $caja->load('responsable', 'metodosPago.cuentaBancaria.banco');
    }

    /**
     * Obtener una caja por ID validando que pertenezca a la empresa.
     */
    public function obtener(int $cajaId, int $empresaId): ?Caja
    {
        return Caja::where('id_empresa', $empresaId)
            ->with(['responsable', 'usuarioApertura', 'usuarioCierre', 'aperturaBilletes.denominacion', 'metodosPago'])
            ->find($cajaId);
    }
}
