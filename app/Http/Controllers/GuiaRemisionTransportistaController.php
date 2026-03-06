<?php

namespace App\Http\Controllers;

use App\Models\Empresa;
use App\Models\GuiaRemision;
use App\Models\GuiaRemisionDetalle;
use App\Models\MotivoTraslado;
use App\Services\SunatService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class GuiaRemisionTransportistaController extends Controller
{
    private const SERIE = 'V001';
    private const TIPO_DOC = '31';

    public function __construct(private SunatService $sunatService) {}

    public function index(Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa;

        $guias = GuiaRemision::with(['detalles'])
            ->where('id_empresa', $idEmpresa)
            ->where('serie', self::SERIE)
            ->orderBy('id', 'desc')
            ->paginate(15);

        return response()->json($guias);
    }

    public function show(int $id, Request $request): JsonResponse
    {
        $guia = GuiaRemision::with(['detalles', 'empresa'])
            ->where('id_empresa', $request->user()->id_empresa)
            ->where('serie', self::SERIE)
            ->findOrFail($id);

        return response()->json($guia);
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            // Remitente (quien envía la mercadería)
            'remitente_tipo_doc'       => 'required|in:1,6',
            'remitente_documento'      => 'required|string|max:15',
            'remitente_nombre'         => 'required|string|max:255',
            'remitente_direccion'      => 'required|string|max:500',
            'remitente_ubigeo'         => 'nullable|string|max:6',
            // Destinatario (quien recibe la mercadería)
            'destinatario_tipo_doc'    => 'required|in:1,4,6',
            'destinatario_documento'   => 'required|string|max:15',
            'destinatario_nombre'      => 'required|string|max:255',
            // Traslado
            'motivo_traslado'          => 'required|string|max:2',
            'descripcion_motivo'       => 'nullable|string|max:255',
            'fecha_traslado'           => 'required|date',
            'ubigeo_partida'           => 'nullable|string|max:6',
            'dir_partida'              => 'required|string|max:500',
            'ubigeo_llegada'           => 'nullable|string|max:6',
            'dir_llegada'              => 'required|string|max:500',
            'peso_total'               => 'required|numeric|min:0.001',
            'und_peso_total'           => 'nullable|string|max:3',
            // Conductor (siempre requerido en GR Transportista)
            'conductor_tipo_doc'       => 'required|string|max:1',
            'conductor_documento'      => 'required|string|max:15',
            'conductor_nombres'        => 'required|string|max:255',
            'conductor_apellidos'      => 'required|string|max:255',
            'conductor_licencia'       => 'required|string|max:20',
            // Vehículo
            'vehiculo_placa'           => 'required|string|max:10',
            'vehiculo_placa_secundaria'=> 'nullable|string|max:20',
            // Mercadería
            'detalles'                 => 'required|array|min:1',
            'detalles.*.descripcion'   => 'required|string',
            'detalles.*.cantidad'      => 'required|numeric|min:0.001',
            'detalles.*.unidad'        => 'nullable|string|max:5',
            'detalles.*.codigo'        => 'nullable|string|max:30',
            // Observaciones
            'observaciones'            => 'nullable|string',
        ]);

        try {
            return DB::transaction(function () use ($request) {
                $idEmpresa = $request->user()->id_empresa;
                $empresa = Empresa::findOrFail($idEmpresa);

                $ultimoNumero = GuiaRemision::where('serie', self::SERIE)
                    ->where('id_empresa', $idEmpresa)
                    ->max('numero') ?? 0;

                $numeroBase = DB::table('documentos_empresas')
                    ->where('id_empresa', $idEmpresa)
                    ->where('serie', self::SERIE)
                    ->value('numero') ?? 0;

                $ultimoNumero = max($ultimoNumero, $numeroBase);

                DB::table('documentos_empresas')
                    ->where('id_empresa', $idEmpresa)
                    ->where('serie', self::SERIE)
                    ->update(['numero' => $ultimoNumero + 1]);

                $guia = GuiaRemision::create([
                    'id_empresa'               => $idEmpresa,
                    'id_usuario'               => $request->user()->id,
                    'serie'                    => self::SERIE,
                    'numero'                   => $ultimoNumero + 1,
                    'fecha_emision'            => now()->toDateString(),
                    // Remitente
                    'remitente_tipo_doc'       => $request->remitente_tipo_doc,
                    'remitente_documento'      => $request->remitente_documento,
                    'remitente_nombre'         => $request->remitente_nombre,
                    'remitente_direccion'      => $request->remitente_direccion,
                    'remitente_ubigeo'         => $request->remitente_ubigeo,
                    // Destinatario
                    'destinatario_tipo_doc'    => $request->destinatario_tipo_doc,
                    'destinatario_documento'   => $request->destinatario_documento,
                    'destinatario_nombre'      => $request->destinatario_nombre,
                    // Traslado
                    'motivo_traslado'          => $request->motivo_traslado,
                    'descripcion_motivo'       => $request->descripcion_motivo,
                    'mod_transporte'           => '02', // Transportista siempre es transporte privado
                    'fecha_traslado'           => $request->fecha_traslado,
                    'peso_total'               => $request->peso_total,
                    'und_peso_total'           => $request->und_peso_total ?? 'KGM',
                    'ubigeo_partida'           => $request->ubigeo_partida ?: ($empresa->ubigeo ?: '150101'),
                    'dir_partida'              => $request->dir_partida,
                    'ubigeo_llegada'           => $request->ubigeo_llegada ?: '150101',
                    'dir_llegada'              => $request->dir_llegada,
                    // Conductor
                    'conductor_tipo_doc'       => $request->conductor_tipo_doc,
                    'conductor_documento'      => $request->conductor_documento,
                    'conductor_nombres'        => $request->conductor_nombres,
                    'conductor_apellidos'      => $request->conductor_apellidos,
                    'conductor_licencia'       => $request->conductor_licencia,
                    // Vehículo
                    'vehiculo_placa'           => $request->vehiculo_placa,
                    'vehiculo_placa_secundaria'=> $request->vehiculo_placa_secundaria,
                    'vehiculo_m1l'             => false,
                    // Extras
                    'observaciones'            => $request->observaciones,
                    'estado'                   => 'pendiente',
                ]);

                foreach ($request->detalles as $detalle) {
                    GuiaRemisionDetalle::create([
                        'id_guia'      => $guia->id,
                        'id_producto'  => $detalle['id_producto'] ?? null,
                        'codigo'       => $detalle['codigo'] ?? null,
                        'descripcion'  => $detalle['descripcion'],
                        'cantidad'     => $detalle['cantidad'],
                        'unidad'       => $detalle['unidad'] ?? 'NIU',
                    ]);
                }

                $resultado = $this->sunatService->generarGuiaRemisionTransportistaXml($guia);

                $guia->load(['detalles']);

                return response()->json([
                    'success' => true,
                    'data'    => $guia,
                    'xml'     => $resultado,
                ], 201);
            });
        } catch (\Exception $e) {
            Log::error('SUNAT - Error al crear guía de remisión transportista', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Error al crear la guía: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function enviar(int $id, Request $request): JsonResponse
    {
        $guia = GuiaRemision::where('id_empresa', $request->user()->id_empresa)
            ->where('serie', self::SERIE)
            ->findOrFail($id);

        if (!$guia->nombre_xml) {
            return response()->json([
                'success' => false,
                'message' => 'La guía no tiene XML generado.',
            ], 400);
        }

        try {
            $resultado = $this->sunatService->enviarGuiaRemision($guia);
            return response()->json($resultado);
        } catch (\Exception $e) {
            Log::error('SUNAT - Error al enviar guía de remisión transportista', [
                'guia_id' => $id,
                'serie'   => $guia->serie . '-' . $guia->numero,
                'error'   => $e->getMessage(),
                'trace'   => $e->getTraceAsString(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Error al enviar: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function consultarTicket(int $id, Request $request): JsonResponse
    {
        $guia = GuiaRemision::where('id_empresa', $request->user()->id_empresa)
            ->where('serie', self::SERIE)
            ->findOrFail($id);

        try {
            $resultado = $this->sunatService->consultarTicketGuia($guia);
            return response()->json($resultado);
        } catch (\Exception $e) {
            Log::error('SUNAT - Error al consultar ticket guía transportista', [
                'guia_id' => $id,
                'error'   => $e->getMessage(),
                'trace'   => $e->getTraceAsString(),
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Error al consultar: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function proximoNumero(Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa;

        $ultimoNumero = GuiaRemision::where('serie', self::SERIE)
            ->where('id_empresa', $idEmpresa)
            ->max('numero') ?? 0;

        $numeroBase = DB::table('documentos_empresas')
            ->where('id_empresa', $idEmpresa)
            ->where('serie', self::SERIE)
            ->value('numero') ?? 0;

        $proximoNumero = max($ultimoNumero, $numeroBase) + 1;

        return response()->json([
            'success'         => true,
            'numero'          => $proximoNumero,
            'numero_completo' => self::SERIE . '-' . str_pad($proximoNumero, 8, '0', STR_PAD_LEFT),
        ]);
    }

    public function motivos(): JsonResponse
    {
        $motivos = MotivoTraslado::where('estado', true)
            ->orderBy('codigo')
            ->get();

        return response()->json($motivos);
    }

    public function cdr(int $id, Request $request)
    {
        $guia = GuiaRemision::where('id_empresa', $request->user()->id_empresa)
            ->where('serie', self::SERIE)
            ->findOrFail($id);

        if (!$guia->cdr_url) {
            return response()->json(['message' => 'CDR no disponible'], 404);
        }

        $cdrPath = storage_path("app/{$guia->cdr_url}");
        if (!file_exists($cdrPath)) {
            return response()->json(['message' => 'Archivo CDR no encontrado'], 404);
        }

        $filename = "R-{$guia->serie}-{$guia->numero}.zip";

        return response()->download($cdrPath, $filename);
    }

    public function xml(string $nombre)
    {
        $nombreXml = preg_replace('/\.xml$/i', '', $nombre);

        $guia = GuiaRemision::where('nombre_xml', $nombreXml)
            ->where('serie', self::SERIE)
            ->first();

        if (!$guia || !$guia->xml_url) {
            return response()->json(['message' => 'XML no encontrado'], 404);
        }

        $xmlPath = storage_path("app/{$guia->xml_url}");
        if (!file_exists($xmlPath)) {
            return response()->json(['message' => 'Archivo XML no encontrado'], 404);
        }

        return response()->file($xmlPath, [
            'Content-Type'        => 'application/xml',
            'Content-Disposition' => "inline; filename=\"{$nombreXml}.xml\"",
        ]);
    }
}
