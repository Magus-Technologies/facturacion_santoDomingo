<?php

namespace App\Http\Controllers\Exports;

use App\Http\Controllers\Controller;
use App\Models\GuiaRemision;
use Illuminate\Http\Request;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Style\Border;
use PhpOffice\PhpSpreadsheet\Style\Alignment;

class GuiaRemisionExportController extends Controller
{
    public function descargarExcel(Request $request)
    {
        try {
            $user = $request->user();

            $guias = GuiaRemision::where('id_empresa', $user->id_empresa)
                ->orderBy('fecha_emision', 'desc')
                ->orderBy('id', 'desc')
                ->get();

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();

            // Titulo
            $sheet->setCellValue('A1', 'REPORTE DE GUIAS DE REMISION');
            $sheet->mergeCells('A1:K1');
            $sheet->getStyle('A1')->applyFromArray([
                'font' => ['bold' => true, 'size' => 14, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => '3B82F6']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ]);

            // Fecha generacion
            $sheet->setCellValue('A2', 'Generado: ' . date('d/m/Y H:i:s'));
            $sheet->mergeCells('A2:K2');
            $sheet->getStyle('A2')->applyFromArray([
                'font' => ['italic' => true, 'size' => 10],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ]);

            $headerRow = 4;

            // Encabezados
            $headers = [
                'Serie-Numero',
                'Fecha Emision',
                'Destinatario',
                'Documento',
                'Partida',
                'Llegada',
                'Motivo',
                'Transporte',
                'Peso',
                'Estado',
                'Ticket SUNAT',
            ];

            $col = 'A';
            foreach ($headers as $header) {
                $sheet->setCellValue($col . $headerRow, $header);
                $col++;
            }

            $sheet->getStyle('A' . $headerRow . ':K' . $headerRow)->applyFromArray([
                'font' => ['bold' => true, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => '90BFEB']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
                'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN]],
            ]);

            // Datos
            $row = $headerRow + 1;
            $modTransporteMap = ['01' => 'Publico', '02' => 'Privado'];

            foreach ($guias as $guia) {
                $documento = $guia->serie . '-' . str_pad($guia->numero, 6, '0', STR_PAD_LEFT);
                $transporte = $modTransporteMap[$guia->mod_transporte] ?? $guia->mod_transporte;

                $sheet->setCellValue('A' . $row, $documento);
                $sheet->setCellValue('B' . $row, $guia->fecha_emision ? $guia->fecha_emision->format('d/m/Y') : '');
                $sheet->setCellValue('C' . $row, $guia->destinatario_nombre);
                $sheet->setCellValue('D' . $row, $guia->destinatario_documento);
                $sheet->setCellValue('E' . $row, $guia->dir_partida);
                $sheet->setCellValue('F' . $row, $guia->dir_llegada);
                $sheet->setCellValue('G' . $row, $guia->descripcion_motivo ?: $guia->motivo_traslado);
                $sheet->setCellValue('H' . $row, $transporte);
                $sheet->setCellValue('I' . $row, $guia->peso_total . ' ' . ($guia->und_peso_total ?: 'KGM'));
                $sheet->setCellValue('J' . $row, ucfirst($guia->estado));
                $sheet->setCellValue('K' . $row, $guia->ticket_sunat ?: '');

                $sheet->getStyle('A' . $row . ':K' . $row)->applyFromArray([
                    'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN, 'color' => ['rgb' => 'CCCCCC']]],
                ]);

                if ($row % 2 == 0) {
                    $sheet->getStyle('A' . $row . ':K' . $row)->applyFromArray([
                        'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => 'F9FAFB']],
                    ]);
                }

                $row++;
            }

            // Ancho de columnas
            $sheet->getColumnDimension('A')->setWidth(18);
            $sheet->getColumnDimension('B')->setWidth(15);
            $sheet->getColumnDimension('C')->setWidth(35);
            $sheet->getColumnDimension('D')->setWidth(15);
            $sheet->getColumnDimension('E')->setWidth(30);
            $sheet->getColumnDimension('F')->setWidth(30);
            $sheet->getColumnDimension('G')->setWidth(20);
            $sheet->getColumnDimension('H')->setWidth(12);
            $sheet->getColumnDimension('I')->setWidth(15);
            $sheet->getColumnDimension('J')->setWidth(12);
            $sheet->getColumnDimension('K')->setWidth(20);

            // Crear archivo
            $writer = new Xlsx($spreadsheet);
            $filename = 'guias-remision-' . date('Y-m-d-His') . '.xlsx';

            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            header('Content-Disposition: attachment;filename="' . $filename . '"');
            header('Cache-Control: max-age=0');
            header('Cache-Control: max-age=1');
            header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
            header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT');
            header('Cache-Control: cache, must-revalidate');
            header('Pragma: public');

            $writer->save('php://output');
            exit;
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al generar Excel: ' . $e->getMessage(),
            ], 500);
        }
    }
}
