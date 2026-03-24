<?php

namespace App\Http\Controllers;

use App\Exceptions\GuiaRemisionException;
use App\Http\Resources\GuiaRemisionResource;
use App\Models\GuiaRemision;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class GuiaRemisionRemitenteController extends Controller
{
    /**
     * GET /api/v1/guias-remision-remitente
     * Lista todas las guías de remisión remitente (T001) de la empresa
     */
    public function index(Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa ?? 1;

        $guias = GuiaRemision::where('id_empresa', $idEmpresa)
            ->where('serie', 'T001')
            ->with(['detalles', 'transportista'])
            ->paginate(15);

        return response()->json([
            'success' => true,
            'data' => GuiaRemisionResource::collection($guias),
            'pagination' => [
                'total' => $guias->total(),
                'per_page' => $guias->perPage(),
                'current_page' => $guias->currentPage(),
                'last_page' => $guias->lastPage(),
            ],
        ]);
    }

    /**
     * GET /api/v1/guias-remision-remitente/{id}
     * Obtiene una guía de remisión remitente específica
     */
    public function show(int $id, Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa ?? 1;

        $guia = GuiaRemision::where('id_empresa', $idEmpresa)
            ->where('serie', 'T001')
            ->with(['detalles', 'transportista'])
            ->findOrFail($id);

        return response()->json([
            'success' => true,
            'data' => new GuiaRemisionResource($guia),
        ]);
    }

    /**
     * GET /api/v1/guias-remision-remitente/proximo-numero
     * Obtiene el próximo número de serie para una guía remitente
     */
    public function proximoNumero(Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa ?? 1;

        $ultimoNumero = GuiaRemision::where('serie', 'T001')
            ->where('id_empresa', $idEmpresa)
            ->max('numero') ?? 0;

        $proximoNumero = $ultimoNumero + 1;

        return response()->json([
            'success' => true,
            'data' => [
                'serie' => 'T001',
                'numero' => $proximoNumero,
                'numero_completo' => 'T001-' . str_pad($proximoNumero, 8, '0', STR_PAD_LEFT),
            ],
        ]);
    }
}
