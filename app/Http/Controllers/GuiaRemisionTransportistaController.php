<?php

namespace App\Http\Controllers;

use App\Exceptions\GuiaRemisionException;
use App\Http\Requests\GuiaRemisionTransportistaStoreRequest;
use App\Http\Requests\GuiaRemisionTransportistaUpdateRequest;
use App\Http\Resources\GuiaRemisionResource;
use App\Models\GuiaRemision;
use App\Services\GuiaRemisionTransportistaService;
use App\Services\SunatService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class GuiaRemisionTransportistaController extends Controller
{
    public function __construct(
        private GuiaRemisionTransportistaService $guiaService,
        private SunatService $sunatService
    ) {}

    /**
     * GET /api/v1/guias-remision
     * Lista todas las guías de remisión de la empresa
     */
    public function index(Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa ?? 1;

        $guias = GuiaRemision::where('id_empresa', $idEmpresa)
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
     * GET /api/v1/guias-remision/{id}
     * Obtiene una guía de remisión específica
     */
    public function show(int $id, Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa ?? 1;

        $guia = GuiaRemision::where('id_empresa', $idEmpresa)
            ->with(['detalles', 'transportista'])
            ->findOrFail($id);

        return response()->json([
            'success' => true,
            'data' => new GuiaRemisionResource($guia),
        ]);
    }

    /**
     * POST /api/v1/guias-remision
     * Crea una nueva guía de remisión
     */
    public function store(GuiaRemisionTransportistaStoreRequest $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa ?? 1;

        $guia = $this->guiaService->crear($request, $idEmpresa);

        return response()->json([
            'success' => true,
            'data' => new GuiaRemisionResource($guia),
            'message' => 'Guía de remisión creada exitosamente',
        ], 201);
    }

    /**
     * PUT /api/v1/guias-remision/{id}
     * Actualiza una guía de remisión
     */
    public function update(int $id, GuiaRemisionTransportistaUpdateRequest $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa ?? 1;

        $guia = GuiaRemision::where('id_empresa', $idEmpresa)->findOrFail($id);

        $guia = $this->guiaService->actualizar($guia, $request);

        return response()->json([
            'success' => true,
            'data' => new GuiaRemisionResource($guia),
            'message' => 'Guía de remisión actualizada exitosamente',
        ]);
    }

    /**
     * POST /api/v1/guias-remision-transportista/{id}/generar-xml
     * Genera el XML de la guía de remisión manualmente
     */
    public function generarXml(int $id, Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa ?? 1;

        $guia = GuiaRemision::where('id_empresa', $idEmpresa)->findOrFail($id);

        if ($guia->estado !== 'pendiente') {
            throw new GuiaRemisionException('Solo se puede generar XML de guías en estado pendiente.', 400);
        }

        try {
            $this->sunatService->generarGuiaRemisionTransportistaXml($guia);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al generar XML: ' . $e->getMessage(),
            ], 500);
        }

        $guia->refresh();

        return response()->json([
            'success' => true,
            'data' => new GuiaRemisionResource($guia),
            'message' => 'XML generado correctamente',
        ]);
    }

    /**
     * POST /api/v1/guias-remision/{id}/enviar
     * Envía la guía de remisión a SUNAT
     */
    public function enviar(int $id, Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa ?? 1;

        $guia = GuiaRemision::where('id_empresa', $idEmpresa)->findOrFail($id);

        if ($guia->estado !== 'pendiente') {
            throw new GuiaRemisionException('Solo se pueden enviar guías en estado pendiente.', 400);
        }

        $this->sunatService->enviarGuiaRemisionTransportista($guia);

        $guia->refresh();

        return response()->json([
            'success' => true,
            'data' => new GuiaRemisionResource($guia),
            'message' => 'Guía enviada a SUNAT',
        ]);
    }

    /**
     * POST /api/v1/guias-remision/{id}/consultar-ticket
     * Consulta el ticket de una guía enviada a SUNAT
     */
    public function consultarTicket(int $id, Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa ?? 1;

        $guia = GuiaRemision::where('id_empresa', $idEmpresa)->findOrFail($id);

        if (!$guia->ticket_sunat) {
            throw new GuiaRemisionException('La guía no tiene ticket SUNAT.', 400);
        }

        $this->sunatService->consultarTicketGuiaRemisionTransportista($guia);

        $guia->refresh();

        return response()->json([
            'success' => true,
            'data' => new GuiaRemisionResource($guia),
            'message' => 'Ticket consultado',
        ]);
    }

    /**
     * GET /api/v1/guias-remision/proximo-numero
     * Obtiene el próximo número de serie para una guía
     */
    public function proximoNumero(Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa ?? 1;

        $ultimoNumero = GuiaRemision::where('serie', 'V001')
            ->where('id_empresa', $idEmpresa)
            ->max('numero') ?? 0;

        $proximoNumero = $ultimoNumero + 1;

        return response()->json([
            'success' => true,
            'data' => [
                'serie' => 'V001',
                'numero' => $proximoNumero,
                'numero_completo' => 'V001-' . str_pad($proximoNumero, 8, '0', STR_PAD_LEFT),
            ],
        ]);
    }

    /**
     * GET /api/v1/guias-remision/motivos
     * Obtiene los motivos de traslado disponibles
     */
    public function motivos(): JsonResponse
    {
        $motivos = [
            '01' => 'Venta',
            '02' => 'Compra',
            '03' => 'Traslado entre almacenes',
            '04' => 'Traslado por devolución',
            '05' => 'Garantía',
            '06' => 'Compra con transporte pagado por cuenta del vendedor',
            '07' => 'Traslado entre puntos de venta',
            '08' => 'Devolución de bienes',
            '09' => 'Traslado de bienes por encargo',
            '10' => 'Otros',
        ];

        return response()->json([
            'success' => true,
            'data' => $motivos,
        ]);
    }

    /**
     * GET /api/v1/guias-remision/{id}/cdr
     * Descarga el CDR de una guía
     */
    public function cdr(int $id, Request $request)
    {
        $idEmpresa = $request->user()->id_empresa ?? 1;

        $guia = GuiaRemision::where('id_empresa', $idEmpresa)->findOrFail($id);

        if (!$guia->cdr_url) {
            throw new GuiaRemisionException('La guía no tiene CDR disponible.', 404);
        }

        return response()->download(storage_path('app/' . $guia->cdr_url));
    }

    /**
     * GET /api/v1/guias-remision/{nombre}/xml
     * Descarga el XML de una guía
     */
    public function xml(string $nombre)
    {
        $rutaXml = storage_path('app/guias-remision/' . $nombre . '.xml');

        if (!file_exists($rutaXml)) {
            throw new GuiaRemisionException('Archivo XML no encontrado.', 404);
        }

        return response()->download($rutaXml, $nombre . '.xml', [
            'Content-Type' => 'application/xml',
        ]);
    }
}
