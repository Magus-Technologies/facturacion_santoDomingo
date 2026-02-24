<?php

namespace App\Http\Controllers;

use App\Models\MotivoNota;
use App\Models\NotaCredito;
use App\Models\Venta;
use App\Models\DocumentoEmpresa;
use App\Services\SunatService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class NotaCreditoController extends Controller
{
    public function __construct(private SunatService $sunatService) {}

    public function index(Request $request): JsonResponse
    {
        $idEmpresa = $request->user()->id_empresa;

        $notas = NotaCredito::with(['venta.cliente', 'motivo'])
            ->where('id_empresa', $idEmpresa)
            ->orderBy('id', 'desc')
            ->paginate(15);

        return response()->json($notas);
    }

    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'id_venta' => 'required|exists:ventas,id_venta',
            'motivo_id' => 'required|exists:motivo_nota,id',
            'descripcion_motivo' => 'nullable|string|max:255',
        ]);

        try {
            return DB::transaction(function () use ($request) {
                $venta = Venta::with(['empresa', 'cliente', 'tipoDocumento', 'productosVentas'])
                    ->findOrFail($request->id_venta);

                $empresa = $venta->empresa;
                $motivo = MotivoNota::findOrFail($request->motivo_id);

                $tipDocAfectado = $venta->tipoDocumento->cod_sunat;
                $serieNC = $tipDocAfectado === '01' ? 'FC01' : 'BC01';

                $ultimoNumero = NotaCredito::where('serie', $serieNC)
                    ->where('id_empresa', $empresa->id_empresa)
                    ->max('numero') ?? 0;

                $nota = NotaCredito::create([
                    'id_venta' => $venta->id_venta,
                    'motivo_id' => $motivo->id,
                    'serie' => $serieNC,
                    'numero' => $ultimoNumero + 1,
                    'tipo_doc_afectado' => $tipDocAfectado,
                    'serie_num_afectado' => $venta->serie . '-' . $venta->numero,
                    'descripcion_motivo' => $request->descripcion_motivo ?? $motivo->descripcion,
                    'monto_subtotal' => $venta->subtotal,
                    'monto_igv' => $venta->igv,
                    'monto_total' => $venta->total,
                    'moneda' => $venta->tipo_moneda ?? 'PEN',
                    'fecha_emision' => now()->toDateString(),
                    'estado' => 'pendiente',
                    'id_empresa' => $empresa->id_empresa,
                    'id_usuario' => $request->user()->id,
                ]);

                $resultado = $this->sunatService->generarNotaCreditoXml($nota);

                $nota->load(['venta.cliente', 'motivo']);

                return response()->json([
                    'success' => true,
                    'data' => $nota,
                    'xml' => $resultado,
                ], 201);
            });
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al crear nota de crédito: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function show(int $id): JsonResponse
    {
        $nota = NotaCredito::with(['venta.cliente', 'venta.productosVentas', 'motivo'])
            ->findOrFail($id);

        return response()->json(['success' => true, 'data' => $nota]);
    }

    public function enviar(int $id): JsonResponse
    {
        $nota = NotaCredito::with(['venta.empresa'])->findOrFail($id);

        if (!$nota->nombre_xml) {
            return response()->json([
                'success' => false,
                'message' => 'Primero debe generar el XML.',
            ], 422);
        }

        try {
            $resultado = $this->sunatService->enviarNotaCredito($nota);
            return response()->json($resultado);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al enviar NC a SUNAT: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function xml(int $id)
    {
        $nota = NotaCredito::findOrFail($id);

        if (!$nota->xml_url) {
            return response()->json([
                'success' => false,
                'message' => 'Esta nota de crédito no tiene XML generado.',
            ], 404);
        }

        $path = storage_path("app/{$nota->xml_url}");

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

    public function buscarVenta(Request $request): JsonResponse
    {
        $request->validate([
            'serie' => 'required|string|max:4',
            'numero' => 'required|string',
        ]);

        $user = $request->user();

        $venta = Venta::with(['cliente', 'tipoDocumento', 'productosVentas.producto'])
            ->where('id_empresa', $user->id_empresa)
            ->where('serie', strtoupper($request->serie))
            ->where('numero', (int) $request->numero)
            ->first();

        if (!$venta) {
            return response()->json([
                'success' => false,
                'message' => 'Venta no encontrada con esa serie y número.',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'venta' => $venta,
        ]);
    }

    public function motivos(): JsonResponse
    {
        $motivos = MotivoNota::where('tipo', 'NC')
            ->where('estado', true)
            ->get();

        return response()->json(['success' => true, 'data' => $motivos]);
    }
}
