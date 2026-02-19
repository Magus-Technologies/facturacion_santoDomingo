<?php

namespace App\Http\Controllers\Exports;

use App\Http\Controllers\Controller;
use App\Models\Compra;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Style\Border;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use Mpdf\Mpdf;

class CompraExportController extends Controller
{
    /**
     * Exportar lista de compras a Excel
     */
    public function exportExcel(Request $request)
    {
        try {
            $user = Auth::user();
            if (!$user) {
                return response()->json(['success' => false, 'message' => 'Sesión expirada. Por favor, vuelva a iniciar sesión.'], 401);
            }

            $compras = Compra::with('proveedor')
                ->where('id_empresa', $user->id_empresa)
                ->orderBy('fecha_emision', 'desc')
                ->get();

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();

            // Título
            $sheet->setCellValue('A1', 'HISTORIAL DE COMPRAS');
            $sheet->mergeCells('A1:G1');
            $sheet->getStyle('A1')->applyFromArray([
                'font' => ['bold' => true, 'size' => 14, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => '10B981']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ]);

            $sheet->setCellValue('A2', 'Generado: ' . date('d/m/Y H:i:s'));
            $sheet->mergeCells('A2:G2');
            $sheet->getStyle('A2')->applyFromArray([
                'font' => ['italic' => true, 'size' => 10],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ]);

            // Encabezados
            $headers = ['Fecha', 'Documento', 'Proveedor', 'RUC', 'Moneda', 'Total', 'Estado'];
            $col = 'A';
            foreach ($headers as $header) {
                $sheet->setCellValue($col . '4', $header);
                $col++;
            }

            $sheet->getStyle('A4:G4')->applyFromArray([
                'font' => ['bold' => true, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => '90BFEB']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
                'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN]],
            ]);

            // Datos
            $row = 5;
            foreach ($compras as $c) {
                $sheet->setCellValue('A' . $row, $c->fecha_emision->format('d/m/Y'));
                $sheet->setCellValue('B' . $row, $c->serie . '-' . str_pad($c->numero, 8, '0', STR_PAD_LEFT));
                $sheet->setCellValue('C' . $row, $c->proveedor->razon_social ?? 'N/A');
                $sheet->setCellValue('D' . $row, $c->proveedor->ruc ?? 'N/A');
                $sheet->setCellValue('E' . $row, $c->moneda);
                $sheet->setCellValue('F' . $row, $c->total);
                $sheet->setCellValue('G' . $row, $c->estado == '1' ? 'ACTIVO' : 'ANULADO');
                
                $sheet->getStyle('A' . $row . ':G' . $row)->applyFromArray([
                    'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN, 'color' => ['rgb' => 'CCCCCC']]],
                ]);
                $row++;
            }

            foreach (range('A', 'G') as $col) {
                $sheet->getColumnDimension($col)->setAutoSize(true);
            }

            $writer = new Xlsx($spreadsheet);
            $filename = 'compras-' . date('Y-m-d-His') . '.xlsx';

            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            header('Content-Disposition: attachment;filename="' . $filename . '"');
            header('Cache-Control: max-age=0');
            $writer->save('php://output');
            exit;

        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }

    /**
     * Exportar lista de compras a PDF (Reporte general)
     */
    public function exportPdf(Request $request)
    {
        try {
            $user = Auth::user();
            if (!$user) {
                return response()->json(['success' => false, 'message' => 'Sesión expirada.'], 401);
            }

            $compras = Compra::with('proveedor')
                ->where('id_empresa', $user->id_empresa)
                ->orderBy('fecha_emision', 'desc')
                ->get();

            $html = view("reportes.compras-lista", compact("compras"))->render();

            $mpdf = new Mpdf([
                "mode" => "utf-8",
                "format" => "A4",
                "tempDir" => storage_path("app/mpdf"),
                "margin_left" => 10,
                "margin_right" => 10,
                "margin_top" => 10,
                "margin_bottom" => 10,
            ]);

            $mpdf->SetTitle("Reporte General de Compras");
            $mpdf->WriteHTML($html);
            $mpdf->Output("Compras-" . date('Ymd') . ".pdf", "I");

        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }
}
