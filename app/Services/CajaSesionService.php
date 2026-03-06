<?php

namespace App\Services;

use App\Services\Contracts\CajaSesionServiceInterface;
use App\Enums\CajaEstadoEnum;
use App\Models\Caja;
use App\Models\AuditoriaCaja;
use App\Models\MovimientoCaja;
use App\Models\User;

class CajaSesionService implements CajaSesionServiceInterface
{
    /**
     * Depositar dinero a un vendedor (apertura de caja = depósito de efectivo).
     */
    public function abrir(Caja $caja, array $datos, User $usuario): Caja
    {
        if ($caja->estado !== CajaEstadoEnum::Activa->value) {
            throw new \Exception('Solo se puede depositar dinero en una caja activa.');
        }

        $monto = $datos['saldo_inicial'] ?? 0;

        // Actualizar saldo inicial de la caja
        $caja->update([
            'saldo_inicial' => $monto,
            'id_usuario'    => $usuario->id,
            'fecha_apertura' => now(),
        ]);

        // Registrar movimiento de depósito
        MovimientoCaja::create([
            'id_caja'      => $caja->id_caja,
            'id_empresa'   => $caja->id_empresa,
            'id_usuario'   => $usuario->id,
            'tipo'         => 'Ingreso',
            'concepto'     => 'Depósito de efectivo',
            'monto'        => $monto,
            'descripcion'  => $datos['observaciones'] ?? 'Depósito para vendedor',
        ]);

        AuditoriaCaja::create([
            'id_caja'    => $caja->id_caja,
            'id_usuario' => $usuario->id,
            'accion'     => 'Depósito',
            'detalles'   => "Depósito de {$monto} para vendedor",
            'ip_address' => request()->ip(),
            'user_agent' => request()->userAgent(),
        ]);

        return $caja;
    }

    /**
     * Cerrar caja (no se usa en esta lógica simplificada).
     */
    public function cerrar(Caja $caja, array $datos, User $usuario): Caja
    {
        throw new \Exception('Operación no disponible en esta versión.');
    }

    /**
     * Autorizar cierre (no se usa).
     */
    public function autorizarCierre(Caja $caja, User $usuario): Caja
    {
        throw new \Exception('Operación no disponible en esta versión.');
    }

    /**
     * Rechazar cierre (no se usa).
     */
    public function rechazarCierre(Caja $caja, User $usuario): Caja
    {
        throw new \Exception('Operación no disponible en esta versión.');
    }
}
