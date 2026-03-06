<?php

namespace App\Services;

use App\Services\Contracts\CajaSesionServiceInterface;
use App\Enums\CajaEstadoEnum;
use App\Enums\TipoAperturaEnum;
use App\Exceptions\BilletesNoCuadranException;
use App\Exceptions\CajaEstadoInvalidoException;
use App\Models\Caja;
use App\Models\AuditoriaCaja;
use App\Models\AperturaCajaBillete;
use App\Models\CierreCajaBillete;
use App\Models\DenominacionBillete;
use App\Models\User;

class CajaSesionService implements CajaSesionServiceInterface
{
    /**
     * Abrir una caja existente (crear sesión del día).
     */
    public function abrir(Caja $caja, array $datos, User $usuario): Caja
    {
        if ($caja->estado !== CajaEstadoEnum::Inactiva->value) {
            throw new CajaEstadoInvalidoException('Solo se puede abrir una caja en estado Inactiva.');
        }

        $caja->update([
            'id_usuario'    => $usuario->id,
            'fecha_apertura' => now(),
            'saldo_inicial'  => $datos['saldo_inicial'],
            'tipo_apertura'  => $datos['tipo_apertura'],
            'estado'         => CajaEstadoEnum::Abierta->value,
        ]);

        if ($datos['tipo_apertura'] === TipoAperturaEnum::Billetes->value && !empty($datos['billetes'])) {
            $this->registrarBilletesApertura($caja, $datos['billetes'], $datos['saldo_inicial']);
        }

        AuditoriaCaja::create([
            'id_caja'    => $caja->id_caja,
            'id_usuario' => $usuario->id,
            'accion'     => 'Apertura',
            'detalles'   => "Saldo inicial: {$datos['saldo_inicial']} ({$datos['tipo_apertura']})",
            'ip_address' => request()->ip(),
            'user_agent' => request()->userAgent(),
        ]);

        return $caja->load('aperturaBilletes.denominacion');
    }

    /**
     * Cerrar una caja abierta (pendiente de autorización).
     */
    public function cerrar(Caja $caja, array $datos, User $usuario): Caja
    {
        if ($caja->estado !== CajaEstadoEnum::Abierta->value) {
            throw new CajaEstadoInvalidoException('La caja no está abierta.');
        }

        $saldoTeorico  = $caja->calcularSaldoTeorico();
        $saldoFinalReal = $datos['saldo_final_real'];

        if ($datos['tipo_cierre'] === TipoAperturaEnum::Billetes->value && !empty($datos['billetes'])) {
            $saldoFinalReal = $this->registrarBilletesCierre($caja, $datos['billetes']);
        }

        $diferencia     = $saldoFinalReal - $saldoTeorico;
        $tipoDiferencia = abs($diferencia) < 0.01 ? 'exacto' : ($diferencia > 0 ? 'sobrante' : 'faltante');

        $caja->update([
            'id_usuario_cierre'    => $usuario->id,
            'fecha_cierre'         => now(),
            'total_teorico'        => $saldoTeorico,
            'total_real'           => $saldoFinalReal,
            'diferencia'           => $diferencia,
            'tipo_cierre'          => $datos['tipo_cierre'],
            'tipo_diferencia'      => $tipoDiferencia,
            'observaciones_cierre' => $datos['observaciones'] ?? null,
            'estado'               => CajaEstadoEnum::PendienteAutorizacion->value,
        ]);

        AuditoriaCaja::create([
            'id_caja'    => $caja->id_caja,
            'id_usuario' => $usuario->id,
            'accion'     => 'Cierre',
            'detalles'   => "Teórico: {$saldoTeorico}, Real: {$saldoFinalReal}, Diferencia: {$diferencia} ({$tipoDiferencia})",
            'ip_address' => request()->ip(),
            'user_agent' => request()->userAgent(),
        ]);

        return $caja->load('cierreBilletes.denominacion');
    }

    /**
     * Autorizar el cierre de una caja.
     */
    public function autorizarCierre(Caja $caja, User $usuario): Caja
    {
        if ($caja->estado !== CajaEstadoEnum::PendienteAutorizacion->value) {
            throw new CajaEstadoInvalidoException('La caja no está pendiente de autorización.');
        }

        $caja->update([
            'id_usuario_validacion'     => $usuario->id,
            'fecha_autorizacion_cierre' => now(),
            'estado'                    => CajaEstadoEnum::Cerrada->value,
        ]);

        AuditoriaCaja::create([
            'id_caja'    => $caja->id_caja,
            'id_usuario' => $usuario->id,
            'accion'     => 'Autorización Cierre',
            'detalles'   => 'Cierre autorizado.',
            'ip_address' => request()->ip(),
            'user_agent' => request()->userAgent(),
        ]);

        return $caja;
    }

    /**
     * Rechazar el cierre — vuelve a estado Abierta.
     */
    public function rechazarCierre(Caja $caja, User $usuario): Caja
    {
        if ($caja->estado !== CajaEstadoEnum::PendienteAutorizacion->value) {
            throw new CajaEstadoInvalidoException('La caja no está pendiente de autorización.');
        }

        $caja->update([
            'estado'               => CajaEstadoEnum::Abierta->value,
            'id_usuario_cierre'    => null,
            'fecha_cierre'         => null,
            'total_teorico'        => null,
            'total_real'           => null,
            'diferencia'           => null,
            'tipo_cierre'          => null,
            'tipo_diferencia'      => null,
            'observaciones_cierre' => null,
        ]);

        AuditoriaCaja::create([
            'id_caja'    => $caja->id_caja,
            'id_usuario' => $usuario->id,
            'accion'     => 'Rechazo Cierre',
            'detalles'   => 'Cierre rechazado. Caja reabierta.',
            'ip_address' => request()->ip(),
            'user_agent' => request()->userAgent(),
        ]);

        return $caja;
    }

    // ─── Privados ─────────────────────────────────────────────────────────────

    private function registrarBilletesApertura(Caja $caja, array $billetes, float $saldoInicial): void
    {
        $total = 0;

        foreach ($billetes as $billete) {
            $denominacion = DenominacionBillete::findOrFail($billete['id_denominacion']);
            $subtotal     = $billete['cantidad'] * $denominacion->valor;

            AperturaCajaBillete::create([
                'id_caja'          => $caja->id_caja,
                'id_denominacion'  => $billete['id_denominacion'],
                'cantidad'         => $billete['cantidad'],
                'subtotal'         => $subtotal,
            ]);

            $total += $subtotal;
        }

        if (abs($total - $saldoInicial) > 0.01) {
            $caja->update(['estado' => CajaEstadoEnum::Inactiva->value, 'id_usuario' => null, 'fecha_apertura' => null]);
            $caja->aperturaBilletes()->delete();
            throw new BilletesNoCuadranException($total, $saldoInicial);
        }
    }

    private function registrarBilletesCierre(Caja $caja, array $billetes): float
    {
        $total = 0;

        foreach ($billetes as $billete) {
            $denominacion = DenominacionBillete::findOrFail($billete['id_denominacion']);
            $subtotal     = $billete['cantidad'] * $denominacion->valor;

            CierreCajaBillete::create([
                'id_caja'         => $caja->id_caja,
                'id_denominacion' => $billete['id_denominacion'],
                'cantidad'        => $billete['cantidad'],
                'subtotal'        => $subtotal,
            ]);

            $total += $subtotal;
        }

        return $total;
    }
}
