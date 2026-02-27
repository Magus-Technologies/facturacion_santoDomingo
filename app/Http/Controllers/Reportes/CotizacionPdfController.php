<?php

namespace App\Http\Controllers\Reportes;

use App\Http\Controllers\Controller;
use App\Models\Cotizacion;
use App\Models\PlantillaImpresion;
use Mpdf\Mpdf;
use Illuminate\Support\Facades\Log;

class CotizacionPdfController extends Controller
{
    /**
     * Generar PDF en formato Ticket 80mm
     */
    public function generarTicket($id)
    {
        try {
            $cotizacion = Cotizacion::with([
                'cliente',
                'usuario',
                'detalles',
            ])->findOrFail($id);

            $empresa = \App\Models\Empresa::find($cotizacion->id_empresa);
            $cotizacion->empresa = $empresa;

            $html = view('reportes.cotizacion-ticket', compact('cotizacion'))->render();

            $mpdf = new Mpdf([
                'mode'          => 'utf-8',
                'format'        => [80, 297], // Ancho 80mm
                'tempDir'       => storage_path('app/mpdf'),
                'margin_left'   => 5,
                'margin_right'  => 5,
                'margin_top'    => 5,
                'margin_bottom' => 5,
            ]);

            $numero = str_pad($cotizacion->numero, 6, '0', STR_PAD_LEFT);
            $mpdf->SetTitle("Cotización COT-{$numero}");
            $mpdf->WriteHTML($html);
            $mpdf->Output("Cotizacion-COT-{$numero}-ticket.pdf", 'I');

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->view('errors.pdf-no-encontrado', [], 404);
        } catch (\Exception $e) {
            Log::error('Error Cotización A4: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'error'   => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Generar PDF en formato A4
     */
    public function generarA4($id)
    {
        try {
            $cotizacion = Cotizacion::with([
                'cliente',
                'usuario',
                'detalles',
            ])->findOrFail($id);

            // Obtener empresa desde el usuario
            $empresa = \App\Models\Empresa::find($cotizacion->id_empresa);
            $cotizacion->empresa = $empresa;

            // Cargar plantilla de impresión
            $plantilla = $empresa
                ? PlantillaImpresion::obtenerPara($empresa->id_empresa)
                : null;

            // Renderizar vista Blade a HTML
            $html = view('reportes.cotizacion-a4', compact('cotizacion', 'plantilla'))->render();

            // Crear PDF con mPDF
            $mpdf = new Mpdf([
                'mode'          => 'utf-8',
                'format'        => 'A4',
                'tempDir'       => storage_path('app/mpdf'),
                'margin_left'   => 13,
                'margin_right'  => 13,
                'margin_top'    => 14,
                'margin_bottom' => 14,
                'img_dpi'       => 96,
                'autoPadding'   => true,
            ]);

            $numero = str_pad($cotizacion->numero, 6, '0', STR_PAD_LEFT);
            $mpdf->shrink_tables_to_fit = 1;
            $mpdf->SetTitle("Cotización COT-{$numero}");
            $mpdf->WriteHTML($html);
            $mpdf->Output("Cotizacion-COT-{$numero}.pdf", 'I');

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->view('errors.pdf-no-encontrado', [], 404);
        } catch (\Exception $e) {
            Log::error('Error Cotización A4: ' . $e->getMessage(), [
                'file'  => $e->getFile(),
                'line'  => $e->getLine(),
                'trace' => $e->getTraceAsString(),
            ]);
            $mensaje = mb_convert_encoding($e->getMessage(), 'UTF-8', 'UTF-8');
            return response()->json([
                'success' => false,
                'error'   => $mensaje,
                'trace'   => config('app.debug') ? $e->getTrace() : null,
            ], 500);
        }
    }
}
