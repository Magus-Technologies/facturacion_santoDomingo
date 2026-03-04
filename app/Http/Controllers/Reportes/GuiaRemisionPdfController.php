<?php

namespace App\Http\Controllers\Reportes;

use App\Helpers\QrHelper;
use App\Http\Controllers\Controller;
use App\Models\GuiaRemision;
use App\Models\PlantillaImpresion;
use Mpdf\Mpdf;

class GuiaRemisionPdfController extends Controller
{
    public function generarA4($id)
    {
        try {
            $guia = GuiaRemision::with([
                'empresa',
                'venta.tipoDocumento',
                'detalles.producto.unidad',
            ])->findOrFail($id);

            // Generar QR
            $qrString = QrHelper::buildQrStringGuia($guia);
            $qrBase64 = QrHelper::generarQrBase64($qrString);
            $consultaUrl = config('app.consulta_url');

            // Cargar plantilla de impresión
            $plantilla = $guia->empresa
                ? PlantillaImpresion::obtenerPara($guia->empresa->id_empresa)
                : null;

            // Renderizar vista Blade a HTML
            $html = view('reportes.guia-remision-a4', compact('guia', 'qrBase64', 'consultaUrl', 'plantilla'))->render();

            // Crear PDF con mPDF
            $mpdf = new Mpdf([
                'mode' => 'utf-8',
                'format' => 'A4',
                'tempDir' => storage_path('app/mpdf'),
                'margin_left' => 15,
                'margin_right' => 15,
                'margin_top' => 15,
                'margin_bottom' => 15,
                'img_dpi' => 96,
                'autoPadding' => true,
            ]);

            $mpdf->shrink_tables_to_fit = 1;
            $serie = $guia->serie . '-' . str_pad($guia->numero, 8, '0', STR_PAD_LEFT);
            $mpdf->SetTitle("GUIA DE REMISION - {$serie}");
            $mpdf->WriteHTML($html);
            $mpdf->Output("GuiaRemision-{$serie}.pdf", 'I');
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->view('errors.pdf-no-encontrado', [], 404);
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('Error Guia A4: ' . $e->getMessage(), [
                'file' => $e->getFile(),
                'line' => $e->getLine(),
                'trace' => $e->getTraceAsString(),
            ]);
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
                'trace' => config('app.debug') ? $e->getTrace() : null,
            ], 500);
        }
    }
}
