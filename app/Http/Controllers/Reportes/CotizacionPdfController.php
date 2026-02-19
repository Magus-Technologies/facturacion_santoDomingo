<?php

namespace App\Http\Controllers\Reportes;

use App\Http\Controllers\Controller;
use App\Models\Cotizacion;
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

        } catch (\Exception $e) {
            Log::error('Error Cotización Ticket: ' . $e->getMessage());
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

            // Renderizar vista Blade a HTML
            $html = view('reportes.cotizacion-a4', compact('cotizacion'))->render();

            // Crear PDF con mPDF
            $mpdf = new Mpdf([
                'mode'          => 'utf-8',
                'format'        => 'A4',
                'tempDir'       => storage_path('app/mpdf'),
                'margin_left'   => 15,
                'margin_right'  => 15,
                'margin_top'    => 15,
                'margin_bottom' => 15,
                'img_dpi'       => 96,
                'autoPadding'   => true,
            ]);

            $numero = str_pad($cotizacion->numero, 6, '0', STR_PAD_LEFT);
            $mpdf->shrink_tables_to_fit = 1;
            $mpdf->SetTitle("Cotización COT-{$numero}");
            $mpdf->WriteHTML($html);
            $mpdf->Output("Cotizacion-COT-{$numero}.pdf", 'I');

        } catch (\Exception $e) {
            Log::error('Error Cotización A4: ' . $e->getMessage(), [
                'file'  => $e->getFile(),
                'line'  => $e->getLine(),
                'trace' => $e->getTraceAsString(),
            ]);
            return response()->json([
                'success' => false,
                'error'   => $e->getMessage(),
                'trace'   => config('app.debug') ? $e->getTrace() : null,
            ], 500);
        }
    }
}
