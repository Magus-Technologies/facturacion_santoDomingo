<?php

namespace App\Services;

use App\Services\Contracts\CajaArqueoServiceInterface;
use App\Models\Caja;
use App\Models\ArqueoDiario;
use App\Models\Venta;
use App\Models\User;

class CajaArqueoService implements CajaArqueoServiceInterface
{
    /**
     * Resumen de movimientos agrupados por método de pago.
     */
    public function resumen(Caja $caja): array
    {
        $ingresos = $caja->movimientos()->where('tipo', 'Ingreso')->get();
        $egresos  = $caja->movimientos()->where('tipo', 'Egreso')->sum('monto');

        $ventasPorMetodo = [];
        $totalIngresos   = 0;

        foreach ($ingresos as $mov) {
            $nombreMetodo = 'Manual';
            $idMetodo     = null;

            if ($mov->referencia_tipo === 'venta') {
                $venta = Venta::find($mov->referencia_id);
                if ($venta) {
                    $metodo       = $venta->metodoPago;
                    $nombreMetodo = $metodo?->nombre ?? 'Desconocido';
                    $idMetodo     = $metodo?->id_metodo_pago;
                }
            }

            if (!isset($ventasPorMetodo[$nombreMetodo])) {
                $ventasPorMetodo[$nombreMetodo] = [
                    'id_metodo_pago'  => $idMetodo,
                    'nombre'          => $nombreMetodo,
                    'total'           => 0,
                    'cantidad_ventas' => 0,
                ];
            }

            $ventasPorMetodo[$nombreMetodo]['total']           += $mov->monto;
            $ventasPorMetodo[$nombreMetodo]['cantidad_ventas'] += 1;
            $totalIngresos                                     += $mov->monto;
        }

        return [
            'saldo_inicial'      => $caja->saldo_inicial,
            'ventas_por_metodo'  => array_values($ventasPorMetodo),
            'total_ingresos'     => $totalIngresos,
            'total_egresos'      => $egresos,
            'total_teorico'      => $caja->saldo_inicial + $totalIngresos - $egresos,
        ];
    }

    /**
     * Crear el arqueo diario al autorizar cierre.
     */
    public function crearArqueo(Caja $caja, User $usuarioAutorizador): ArqueoDiario
    {
        $totalVentas          = $caja->movimientos()->where('tipo', 'Ingreso')->where('referencia_tipo', 'venta')->sum('monto');
        $totalIngresosManual  = $caja->movimientos()->where('tipo', 'Ingreso')->where('referencia_tipo', '!=', 'venta')->sum('monto');
        $totalEgresos         = $caja->movimientos()->where('tipo', 'Egreso')->sum('monto');
        $ventasPorMetodo      = $this->agruparVentasPorMetodo($caja);

        return ArqueoDiario::create([
            'id_caja'                => $caja->id_caja,
            'id_empresa'             => $caja->id_empresa,
            'fecha_arqueo'           => $caja->fecha_cierre->toDateString(),
            'usuario_cierre'         => $caja->id_usuario_cierre,
            'usuario_validacion'     => $usuarioAutorizador->id,
            'saldo_inicial'          => $caja->saldo_inicial,
            'total_ventas'           => $totalVentas,
            'total_ingresos_manuales' => $totalIngresosManual,
            'total_egresos'          => $totalEgresos,
            'total_teorico'          => $caja->total_teorico,
            'total_real'             => $caja->total_real,
            'diferencia'             => $caja->diferencia,
            'tipo_diferencia'        => $caja->tipo_diferencia,
            'ventas_por_metodo'      => json_encode($ventasPorMetodo),
            'estado'                 => 'cerrada',
            'fecha_cierre'           => $caja->fecha_cierre,
            'fecha_validacion'       => now(),
        ]);
    }

    // ─── Privados ─────────────────────────────────────────────────────────────

    private function agruparVentasPorMetodo(Caja $caja): array
    {
        $movimientos     = $caja->movimientos()->where('tipo', 'Ingreso')->where('referencia_tipo', 'venta')->get();
        $ventasPorMetodo = [];

        foreach ($movimientos as $mov) {
            $venta = Venta::find($mov->referencia_id);
            if (!$venta) continue;

            $metodo       = $venta->metodoPago;
            $nombreMetodo = $metodo?->nombre ?? 'Desconocido';

            if (!isset($ventasPorMetodo[$nombreMetodo])) {
                $ventasPorMetodo[$nombreMetodo] = [
                    'id_metodo_pago' => $metodo?->id_metodo_pago,
                    'nombre'         => $nombreMetodo,
                    'total'          => 0,
                    'cantidad'       => 0,
                ];
            }

            $ventasPorMetodo[$nombreMetodo]['total']    += $mov->monto;
            $ventasPorMetodo[$nombreMetodo]['cantidad'] += 1;
        }

        return array_values($ventasPorMetodo);
    }
}
