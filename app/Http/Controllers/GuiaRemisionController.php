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

class GuiaRemisionController extends Controller
{
    public function __construct(private SunatService $sunatService) {}

    public function index(Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa;

        $guias = GuiaRemision::with(['venta.cliente', 'detalles'])
            ->where('id_empresa', $idEmpresa)
            ->orderBy('id', 'desc')
            ->paginate(15);

        return response()->json($guias);
    }

    public function show(int $id, Request $request): JsonResponse
    {
        $guia = GuiaRemision::with(['venta.cliente', 'detalles', 'empresa'])
            ->where('id_empresa', $request->user()->id_empresa)
            ->findOrFail($id);

        return response()->json($guia);
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'id_venta' => 'nullable|exists:ventas,id_venta',
            'destinatario_tipo_doc' => 'required|in:1,6',
            'destinatario_documento' => 'required|string|max:15',
            'destinatario_nombre' => 'required|string|max:255',
            'destinatario_direccion' => 'nullable|string|max:500',
            'destinatario_ubigeo' => 'nullable|string|max:6',
            'motivo_traslado' => 'required|string|max:2',
            'descripcion_motivo' => 'nullable|string|max:255',
            'mod_transporte' => 'required|in:01,02',
            'fecha_traslado' => 'required|date',
            'peso_total' => 'required|numeric|min:0.001',
            'und_peso_total' => 'nullable|string|max:3',
            'transportista_tipo_doc' => 'nullable|string|max:1',
            'transportista_documento' => 'nullable|string|max:15',
            'transportista_nombre' => 'nullable|string|max:255',
            'transportista_nro_mtc' => 'nullable|string|max:20',
            'conductor_tipo_doc' => 'nullable|string|max:1',
            'conductor_documento' => 'nullable|string|max:15',
            'conductor_nombres' => 'nullable|string|max:255',
            'conductor_apellidos' => 'nullable|string|max:255',
            'conductor_licencia' => 'nullable|string|max:20',
            'vehiculo_placa' => 'nullable|string|max:10',
            'observaciones' => 'nullable|string',
            'detalles' => 'required|array|min:1',
            'detalles.*.descripcion' => 'required|string',
            'detalles.*.cantidad' => 'required|numeric|min:0.001',
            'detalles.*.unidad' => 'nullable|string|max:5',
            'detalles.*.codigo' => 'nullable|string|max:30',
            'detalles.*.id_producto' => 'nullable|integer',
        ]);

        try {
            return DB::transaction(function () use ($request) {
                $idEmpresa = $request->user()->id_empresa;
                $empresa = Empresa::findOrFail($idEmpresa);

                $ultimoNumero = GuiaRemision::where('serie', 'T001')
                    ->where('id_empresa', $idEmpresa)
                    ->max('numero') ?? 0;

                // Partida = dirección de la empresa
                $ubigeoPartida = $empresa->ubigeo ?: '150101';
                $dirPartida = $empresa->direccion ?: '';

                // Llegada = dirección del destinatario
                $ubigeoLlegada = $request->destinatario_ubigeo ?: '150101';
                $dirLlegada = $request->destinatario_direccion ?: '';

                $guia = GuiaRemision::create([
                    'id_empresa' => $idEmpresa,
                    'id_usuario' => $request->user()->id,
                    'id_venta' => $request->id_venta,
                    'serie' => 'T001',
                    'numero' => $ultimoNumero + 1,
                    'fecha_emision' => now()->toDateString(),
                    'destinatario_tipo_doc' => $request->destinatario_tipo_doc,
                    'destinatario_documento' => $request->destinatario_documento,
                    'destinatario_nombre' => $request->destinatario_nombre,
                    'motivo_traslado' => $request->motivo_traslado,
                    'descripcion_motivo' => $request->descripcion_motivo,
                    'mod_transporte' => $request->mod_transporte,
                    'fecha_traslado' => $request->fecha_traslado,
                    'peso_total' => $request->peso_total,
                    'und_peso_total' => $request->und_peso_total ?? 'KGM',
                    'ubigeo_partida' => $ubigeoPartida,
                    'dir_partida' => $dirPartida,
                    'ubigeo_llegada' => $ubigeoLlegada,
                    'dir_llegada' => $dirLlegada,
                    'transportista_tipo_doc' => $request->transportista_tipo_doc,
                    'transportista_documento' => $request->transportista_documento,
                    'transportista_nombre' => $request->transportista_nombre,
                    'transportista_nro_mtc' => $request->transportista_nro_mtc,
                    'conductor_tipo_doc' => $request->conductor_tipo_doc,
                    'conductor_documento' => $request->conductor_documento,
                    'conductor_nombres' => $request->conductor_nombres,
                    'conductor_apellidos' => $request->conductor_apellidos,
                    'conductor_licencia' => $request->conductor_licencia,
                    'vehiculo_placa' => $request->vehiculo_placa,
                    'observaciones' => $request->observaciones,
                    'estado' => 'pendiente',
                ]);

                foreach ($request->detalles as $detalle) {
                    GuiaRemisionDetalle::create([
                        'id_guia' => $guia->id,
                        'id_producto' => $detalle['id_producto'] ?? null,
                        'codigo' => $detalle['codigo'] ?? null,
                        'descripcion' => $detalle['descripcion'],
                        'cantidad' => $detalle['cantidad'],
                        'unidad' => $detalle['unidad'] ?? 'NIU',
                    ]);
                }

                $resultado = $this->sunatService->generarGuiaRemisionXml($guia);

                $guia->load(['detalles']);

                return response()->json([
                    'success' => true,
                    'data' => $guia,
                    'xml' => $resultado,
                ], 201);
            });
        } catch (\Exception $e) {
            Log::error('SUNAT - Error al crear guía de remisión', [
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
            Log::error('SUNAT - Error al enviar guía de remisión', [
                'guia_id' => $id,
                'serie' => $guia->serie . '-' . $guia->numero,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
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
            ->findOrFail($id);

        try {
            $resultado = $this->sunatService->consultarTicketGuia($guia);
            return response()->json($resultado);
        } catch (\Exception $e) {
            Log::error('SUNAT - Error al consultar ticket guía', [
                'guia_id' => $id,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ]);
            return response()->json([
                'success' => false,
                'message' => 'Error al consultar: ' . $e->getMessage(),
            ], 500);
        }
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

        $guia = GuiaRemision::where('nombre_xml', $nombreXml)->first();

        if (!$guia || !$guia->xml_url) {
            return response()->json(['message' => 'XML no encontrado'], 404);
        }

        $xmlPath = storage_path("app/{$guia->xml_url}");
        if (!file_exists($xmlPath)) {
            return response()->json(['message' => 'Archivo XML no encontrado'], 404);
        }

        return response()->file($xmlPath, [
            'Content-Type' => 'application/xml',
            'Content-Disposition' => "inline; filename=\"{$nombreXml}.xml\"",
        ]);
    }

    public function empresaActiva(Request $request): JsonResponse
    {
        $empresa = Empresa::find($request->user()->id_empresa);

        return response()->json([
            'success' => true,
            'data' => [
                'razon_social' => $empresa->razon_social ?? '',
                'ruc' => $empresa->ruc ?? '',
                'direccion' => $empresa->direccion ?? '',
                'ubigeo' => $empresa->ubigeo ?? '',
                'departamento' => $empresa->departamento ?? '',
                'provincia' => $empresa->provincia ?? '',
                'distrito' => $empresa->distrito ?? '',
            ],
        ]);
    }

    public function ubigeos(Request $request): JsonResponse
    {
        $search = $request->get('q', '');

        $query = DB::table('ubigeo_inei');

        if ($search) {
            $query->where('nombre', 'like', "%{$search}%")
                ->orWhere('id_ubigeo', 'like', "%{$search}%");
        }

        $ubigeos = $query->limit(20)->get();

        return response()->json($ubigeos);
    }
}
