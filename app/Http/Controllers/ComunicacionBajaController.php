<?php

namespace App\Http\Controllers;

use App\Models\Empresa;
use App\Models\Venta;
use App\Services\SunatService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ComunicacionBajaController extends Controller
{
    public function __construct(private SunatService $sunatService) {}

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'documentos' => 'required|array|min:1',
            'documentos.*.id_venta' => 'required|integer|exists:ventas,id_venta',
            'documentos.*.motivo' => 'required|string|max:200',
        ]);

        $empresa = Empresa::findOrFail($request->user()->id_empresa);

        $ventas = Venta::with(['tipoDocumento'])
            ->whereIn('id_venta', collect($request->documentos)->pluck('id_venta'))
            ->where('id_empresa', $empresa->id_empresa)
            ->get()
            ->keyBy('id_venta');

        if ($ventas->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'No se encontraron documentos válidos.',
            ], 422);
        }

        $errores = [];
        $documentosBaja = [];
        $motivosMap = collect($request->documentos)->keyBy('id_venta');

        foreach ($ventas as $venta) {
            $codSunat = $venta->tipoDocumento->cod_sunat ?? '';

            if (!in_array($codSunat, ['01', '07', '08'])) {
                $errores[] = "{$venta->numero_completo}: Solo facturas (01), notas de crédito (07) y notas de débito (08) pueden darse de baja. Las boletas usan Resumen Diario.";
                continue;
            }

            if ($venta->estado_sunat != '1') {
                $errores[] = "{$venta->numero_completo}: El documento debe estar aceptado por SUNAT (estado_sunat=1).";
                continue;
            }

            $fechaEmision = $venta->fecha_emision;
            if ($fechaEmision && $fechaEmision->diffInDays(now()) > 7) {
                $errores[] = "{$venta->numero_completo}: El plazo máximo para comunicación de baja es 7 días desde la emisión.";
                continue;
            }

            $documentosBaja[] = [
                'tipo_doc' => $codSunat,
                'serie' => $venta->serie,
                'correlativo' => (string) $venta->numero,
                'motivo' => $motivosMap[$venta->id_venta]['motivo'],
            ];
        }

        if (!empty($errores) && empty($documentosBaja)) {
            return response()->json([
                'success' => false,
                'message' => 'Ningún documento pasó la validación.',
                'errores' => $errores,
            ], 422);
        }

        try {
            $resultado = $this->sunatService->comunicacionBaja($empresa, $documentosBaja);

            if ($resultado['success']) {
                foreach ($ventas as $venta) {
                    $codSunat = $venta->tipoDocumento->cod_sunat ?? '';
                    if (in_array($codSunat, ['01', '07', '08']) && $venta->estado_sunat == '1') {
                        $venta->update([
                            'estado_sunat' => '3',
                            'mensaje_sunat' => 'Comunicación de baja enviada. Ticket: ' . ($resultado['ticket'] ?? ''),
                        ]);
                    }
                }
            }

            if (!empty($errores)) {
                $resultado['advertencias'] = $errores;
            }

            return response()->json($resultado);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al enviar comunicación de baja: ' . $e->getMessage(),
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
