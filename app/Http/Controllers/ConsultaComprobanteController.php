<?php

namespace App\Http\Controllers;

use App\Models\Venta;
use App\Models\NotaCredito;
use App\Models\GuiaRemision;
use Illuminate\Http\Request;

class ConsultaComprobanteController extends Controller
{
    public function index()
    {
        return view('consulta.index');
    }

    public function consultar(Request $request)
    {
        $request->validate([
            'tipo_documento' => 'required|string|in:factura,boleta,nota_credito,guia_remision',
            'serie' => 'required|string|max:4',
            'numero' => 'required|integer|min:1',
            'ruc_emisor' => 'nullable|string|max:11',
        ]);

        $ruc = $request->ruc_emisor;
        $tipo = $request->tipo_documento;
        $serie = strtoupper($request->serie);
        $numero = (int) $request->numero;

        $resultado = null;

        if ($tipo === 'factura' || $tipo === 'boleta') {
            $tipoDocId = $tipo === 'boleta' ? 1 : 2;

            $query = Venta::with(['empresa', 'cliente', 'tipoDocumento'])
                ->where('id_tido', $tipoDocId)
                ->where('serie', $serie)
                ->where('numero', $numero);

            if ($ruc) {
                $query->whereHas('empresa', fn($q) => $q->where('ruc', $ruc));
            }

            $venta = $query->first();

            if ($venta) {
                $resultado = [
                    'tipo' => $tipo === 'boleta' ? 'Boleta de Venta' : 'Factura',
                    'serie_numero' => $venta->numero_completo,
                    'fecha_emision' => $venta->fecha_emision?->format('d/m/Y'),
                    'ruc_emisor' => $venta->empresa->ruc ?? '',
                    'razon_social_emisor' => $venta->empresa->razon_social ?? '',
                    'cliente' => $venta->cliente->datos ?? '',
                    'documento_cliente' => $venta->cliente->documento ?? '',
                    'total' => number_format($venta->total, 2),
                    'moneda' => $venta->tipo_moneda ?? 'PEN',
                    'estado' => $venta->estado,
                    'hash_cpe' => $venta->hash_cpe,
                    'pdf_url' => '/reporteNV/a4.php?id=' . $venta->id_venta,
                ];
            }
        } elseif ($tipo === 'nota_credito') {
            $query = NotaCredito::with('empresa')
                ->where('serie', $serie)
                ->where('numero', $numero);

            if ($ruc) {
                $query->whereHas('empresa', fn($q) => $q->where('ruc', $ruc));
            }

            $nc = $query->first();

            if ($nc) {
                $resultado = [
                    'tipo' => 'Nota de Crédito',
                    'serie_numero' => $nc->numero_completo,
                    'fecha_emision' => $nc->fecha_emision?->format('d/m/Y'),
                    'ruc_emisor' => $nc->empresa->ruc ?? '',
                    'razon_social_emisor' => $nc->empresa->razon_social ?? '',
                    'cliente' => '',
                    'documento_cliente' => '',
                    'total' => number_format($nc->monto_total, 2),
                    'moneda' => $nc->moneda ?? 'PEN',
                    'estado' => $nc->estado,
                    'hash_cpe' => $nc->hash_cpe,
                    'pdf_url' => null,
                ];
            }
        } elseif ($tipo === 'guia_remision') {
            $query = GuiaRemision::with('empresa')
                ->where('serie', $serie)
                ->where('numero', $numero);

            if ($ruc) {
                $query->whereHas('empresa', fn($q) => $q->where('ruc', $ruc));
            }

            $guia = $query->first();

            if ($guia) {
                $resultado = [
                    'tipo' => 'Guía de Remisión',
                    'serie_numero' => $guia->numero_completo,
                    'fecha_emision' => $guia->fecha_emision?->format('d/m/Y'),
                    'ruc_emisor' => $guia->empresa->ruc ?? '',
                    'razon_social_emisor' => $guia->empresa->razon_social ?? '',
                    'cliente' => $guia->destinatario_nombre,
                    'documento_cliente' => $guia->destinatario_documento,
                    'total' => null,
                    'moneda' => null,
                    'estado' => $guia->estado,
                    'hash_cpe' => $guia->hash_cpe,
                    'pdf_url' => '/reporteGR/a4.php?id=' . $guia->id,
                ];
            }
        }

        if (!$resultado) {
            return response()->json([
                'encontrado' => false,
                'mensaje' => 'Comprobante no encontrado. Verifique los datos ingresados.',
            ]);
        }

        return response()->json([
            'encontrado' => true,
            'comprobante' => $resultado,
        ]);
    }
}
