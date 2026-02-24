<?php

namespace App\Http\Controllers;

use App\Models\Venta;
use App\Services\SunatService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ComprobanteElectronicoController extends Controller
{
    public function __construct(private SunatService $sunatService) {}

    public function generarXml(int $ventaId): JsonResponse
    {
        $venta = Venta::with(['empresa', 'cliente', 'productosVentas', 'tipoDocumento'])
            ->findOrFail($ventaId);

        try {
            $resultado = $this->sunatService->generarXml($venta);

            if ($resultado['success']) {
                $venta->update([
                    'hash_cpe' => $resultado['hash'],
                    'xml_url' => $resultado['xml_url'],
                ]);
            }

            return response()->json($resultado);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al generar XML: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function enviar(int $ventaId): JsonResponse
    {
        $venta = Venta::with(['empresa', 'tipoDocumento'])->findOrFail($ventaId);

        if (!$venta->xml_url && !$venta->hash_cpe) {
            return response()->json([
                'success' => false,
                'message' => 'Primero debe generar el XML del comprobante.',
            ], 422);
        }

        try {
            $resultado = $this->sunatService->enviarComprobante($venta);
            return response()->json($resultado);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al enviar a SUNAT: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function xml(int $ventaId)
    {
        $venta = Venta::findOrFail($ventaId);

        if (!$venta->xml_url) {
            return response()->json([
                'success' => false,
                'message' => 'Esta venta no tiene XML generado.',
            ], 404);
        }

        $path = storage_path("app/{$venta->xml_url}");

        if (!file_exists($path)) {
            return response()->json([
                'success' => false,
                'message' => 'Archivo XML no encontrado en el servidor.',
            ], 404);
        }

        return response()->file($path, [
            'Content-Type' => 'application/xml',
        ]);
    }

    public function estado(int $ventaId): JsonResponse
    {
        $venta = Venta::with(['tipoDocumento'])
            ->select('id_venta', 'serie', 'numero', 'estado_sunat', 'hash_cpe', 'xml_url', 'cdr_url', 'codigo_sunat', 'mensaje_sunat', 'intentos')
            ->findOrFail($ventaId);

        return response()->json([
            'success' => true,
            'data' => [
                'id_venta' => $venta->id_venta,
                'numero_completo' => $venta->numero_completo,
                'estado_sunat' => $venta->estado_sunat,
                'hash_cpe' => $venta->hash_cpe,
                'xml_url' => $venta->xml_url,
                'cdr_url' => $venta->cdr_url,
                'codigo_sunat' => $venta->codigo_sunat,
                'mensaje_sunat' => $venta->mensaje_sunat,
                'intentos' => $venta->intentos,
            ],
        ]);
    }
}
