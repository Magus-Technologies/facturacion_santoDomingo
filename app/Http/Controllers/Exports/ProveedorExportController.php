<?php

namespace App\Http\Controllers\Exports;

use App\Http\Controllers\Controller;
use App\Models\Proveedor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Style\Border;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use Mpdf\Mpdf;

class ProveedorExportController extends Controller
{
    /**
     * Exportar lista de proveedores a Excel
     */
    public function exportExcel(Request $request)
    {
        try {
            $user = Auth::user();
            if (!$user) {
                return response()->json(['success' => false, 'message' => 'Sesión expirada.'], 401);
            }

            $proveedores = Proveedor::where('id_empresa', $user->id_empresa)
                ->orderBy('razon_social')
                ->get();

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();

            // Título
            $sheet->setCellValue('A1', 'CARTERA DE PROVEEDORES');
            $sheet->mergeCells('A1:G1');
            $sheet->getStyle('A1')->applyFromArray([
                'font' => ['bold' => true, 'size' => 14, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => 'F97316']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ]);

            $sheet->setCellValue('A2', 'Generado: ' . date('d/m/Y H:i:s'));
            $sheet->mergeCells('A2:G2');
            $sheet->getStyle('A2')->applyFromArray([
                'font' => ['italic' => true, 'size' => 10],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ]);

            // Encabezados
            $headers = ['RUC', 'Razón Social', 'Email', 'Teléfono', 'Dirección', 'Distrito', 'Departamento'];
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
            foreach ($proveedores as $p) {
                $sheet->setCellValue('A' . $row, $p->ruc);
                $sheet->setCellValue('B' . $row, $p->razon_social);
                $sheet->setCellValue('C' . $row, $p->email);
                $sheet->setCellValue('D' . $row, $p->telefono);
                $sheet->setCellValue('E' . $row, $p->direccion);
                $sheet->setCellValue('F' . $row, $p->distrito);
                $sheet->setCellValue('G' . $row, $p->departamento);
                
                $sheet->getStyle('A' . $row . ':G' . $row)->applyFromArray([
                    'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN, 'color' => ['rgb' => 'CCCCCC']]],
                ]);
                $row++;
            }

            foreach (range('A', 'G') as $col) {
                $sheet->getColumnDimension($col)->setAutoSize(true);
            }

            $writer = new Xlsx($spreadsheet);
            $filename = 'proveedores-' . date('Y-m-d-His') . '.xlsx';

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
     * Exportar lista de proveedores a PDF
     */
    public function exportPdf(Request $request)
    {
        try {
            $user = Auth::user();
            if (!$user) {
                return response()->json(['success' => false, 'message' => 'Sesión expirada.'], 401);
            }

            $proveedores = Proveedor::where('id_empresa', $user->id_empresa)
                ->orderBy('razon_social')
                ->get();

            $html = view("reportes.proveedores-lista", compact("proveedores"))->render();

            $mpdf = new Mpdf([
                "mode" => "utf-8",
                "format" => "A4-L", // Apaisado
                "tempDir" => storage_path("app/mpdf"),
                "margin_left" => 10,
                "margin_right" => 10,
                "margin_top" => 10,
                "margin_bottom" => 10,
            ]);

            $mpdf->SetTitle("Cartera de Proveedores");
            $mpdf->WriteHTML($html);
            $mpdf->Output("Proveedores-" . date('Ymd') . ".pdf", "I");

        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }
}
