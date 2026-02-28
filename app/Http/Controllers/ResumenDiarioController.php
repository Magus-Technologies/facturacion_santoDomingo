<?php

namespace App\Http\Controllers;

use App\Models\Empresa;
use App\Models\Venta;
use App\Services\SunatService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ResumenDiarioController extends Controller
{
    public function __construct(private SunatService $sunatService) {}

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'ids' => 'required|array|min:1',
            'ids.*' => 'integer|exists:ventas,id_venta',
            'fecha_resumen' => 'required|date_format:Y-m-d',
        ]);

        $empresa = Empresa::findOrFail($request->user()->id_empresa);

        $ventas = Venta::with(['tipoDocumento', 'cliente'])
            ->whereIn('id_venta', $request->ids)
            ->where('id_empresa', $empresa->id_empresa)
            ->get();

        if ($ventas->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'No se encontraron ventas válidas.',
            ], 422);
        }

        $errores = [];
        $boletasValidas = [];

        foreach ($ventas as $venta) {
            $codSunat = $venta->tipoDocumento->cod_sunat ?? '';

            if ($codSunat !== '03') {
                $errores[] = "{$venta->numero_completo}: Solo boletas (03) se envían por Resumen Diario.";
                continue;
            }

            $fechaEmision = $venta->fecha_emision;
            if ($fechaEmision && $fechaEmision->diffInDays(now()) > 7) {
                $errores[] = "{$venta->numero_completo}: El plazo máximo para envío por Resumen Diario es 7 días desde la emisión.";
                continue;
            }

            $boletasValidas[] = $venta;
        }

        if (empty($boletasValidas)) {
            return response()->json([
                'success' => false,
                'message' => 'Ninguna boleta pasó la validación.',
                'errores' => $errores,
            ], 422);
        }

        try {
            $resultado = $this->sunatService->resumenDiario(
                $empresa,
                $boletasValidas,
                $request->fecha_resumen,
            );

            if ($resultado['success']) {
                foreach ($boletasValidas as $venta) {
                    $venta->update([
                        'estado_sunat' => '3',
                        'mensaje_sunat' => 'Resumen diario enviado. Ticket: ' . ($resultado['ticket'] ?? ''),
                    ]);
                }
            }

            if (!empty($errores)) {
                $resultado['advertencias'] = $errores;
            }

            return response()->json($resultado);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al enviar resumen diario: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function anular(Request $request): JsonResponse
    {
        $request->validate([
            'ids' => 'required|array|min:1',
            'ids.*' => 'integer|exists:ventas,id_venta',
            'fecha_resumen' => 'required|date_format:Y-m-d',
        ]);

        $empresa = Empresa::findOrFail($request->user()->id_empresa);

        $ventas = Venta::with(['tipoDocumento', 'cliente'])
            ->whereIn('id_venta', $request->ids)
            ->where('id_empresa', $empresa->id_empresa)
            ->get();

        if ($ventas->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'No se encontraron ventas válidas.',
            ], 422);
        }

        $errores = [];
        $boletasValidas = [];

        foreach ($ventas as $venta) {
            $codSunat = $venta->tipoDocumento->cod_sunat ?? '';

            if ($codSunat !== '03') {
                $errores[] = "{$venta->numero_completo}: Solo boletas (03) se anulan por Resumen Diario.";
                continue;
            }

            if ($venta->estado_sunat != '1') {
                $errores[] = "{$venta->numero_completo}: La boleta debe estar aceptada por SUNAT (estado_sunat=1) para poder anularla.";
                continue;
            }

            $boletasValidas[] = $venta;
        }

        if (empty($boletasValidas)) {
            return response()->json([
                'success' => false,
                'message' => 'Ninguna boleta pasó la validación para anulación.',
                'errores' => $errores,
            ], 422);
        }

        try {
            $resultado = $this->sunatService->resumenDiarioBaja(
                $empresa,
                $boletasValidas,
                $request->fecha_resumen,
            );

            if ($resultado['success']) {
                foreach ($boletasValidas as $venta) {
                    $venta->update([
                        'estado_sunat' => '3',
                        'mensaje_sunat' => 'Anulación por resumen diario enviada. Ticket: ' . ($resultado['ticket'] ?? ''),
                    ]);
                }
            }

            if (!empty($errores)) {
                $resultado['advertencias'] = $errores;
            }

            return response()->json($resultado);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al enviar anulación por resumen diario: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function consultarTicket(Request $request): JsonResponse
    {
        $request->validate([
            'ticket' => 'required|string',
        ]);

        $empresa = Empresa::findOrFail($request->user()->id_empresa);

        try {
            $resultado = $this->sunatService->consultarTicket($empresa, $request->ticket);
            return response()->json($resultado);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al consultar ticket: ' . $e->getMessage(),
            ], 500);
        }
    }
}
