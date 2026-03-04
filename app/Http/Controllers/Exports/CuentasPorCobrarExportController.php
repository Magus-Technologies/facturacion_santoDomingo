<?php

namespace App\Http\Controllers\Exports;

use App\Http\Controllers\Controller;
use App\Models\DiaVenta;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Style\Border;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use Mpdf\Mpdf;

class CuentasPorCobrarExportController extends Controller
{
    private function getCuotas(Request $request)
    {
        $user = Auth::user();
        $query = DiaVenta::with(['venta.cliente'])
            ->whereHas('venta', function ($q) use ($user) {
                $q->where('id_empresa', $user->id_empresa)->where('estado', '1');
            });

        if ($request->filled('estado')) {
            $estado = $request->estado;
            if ($estado === 'P') $query->pendientes();
            elseif ($estado === 'C') $query->canceladas();
            elseif ($estado === 'V') $query->vencidas();
        }
        if ($request->filled('fecha_desde')) $query->where('fecha_vencimiento', '>=', $request->fecha_desde);
        if ($request->filled('fecha_hasta')) $query->where('fecha_vencimiento', '<=', $request->fecha_hasta);
        if ($request->filled('cliente')) {
            $cliente = $request->cliente;
            $query->whereHas('venta.cliente', function ($q) use ($cliente) {
                $q->where('datos', 'like', "%{$cliente}%")->orWhere('documento', 'like', "%{$cliente}%");
            });
        }

        return $query->orderBy('fecha_vencimiento', 'asc')->get();
    }

    public function exportExcel(Request $request)
    {
        try {
            $user = Auth::user();
            if (!$user) return response()->json(['success' => false, 'message' => 'Sesión expirada.'], 401);

            $cuotas = $this->getCuotas($request);
            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();

            $sheet->setCellValue('A1', 'CUENTAS POR COBRAR');
            $sheet->mergeCells('A1:H1');
            $sheet->getStyle('A1')->applyFromArray([
                'font' => ['bold' => true, 'size' => 14, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => 'C7161D']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ]);

            $sheet->setCellValue('A2', 'Generado: ' . date('d/m/Y H:i:s'));
            $sheet->mergeCells('A2:H2');
            $sheet->getStyle('A2')->applyFromArray([
                'font' => ['italic' => true, 'size' => 10],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ]);

            $headers = ['Documento', 'Cliente', 'N° Cuota', 'F. Vencimiento', 'Monto', 'Pagado', 'Saldo', 'Estado'];
            $col = 'A';
            foreach ($headers as $header) {
                $sheet->setCellValue($col . '4', $header);
                $col++;
            }

            $sheet->getStyle('A4:H4')->applyFromArray([
                'font' => ['bold' => true, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => '90BFEB']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
                'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN]],
            ]);

            $row = 5;
            $estadoMap = ['P' => 'PENDIENTE', 'V' => 'VENCIDO', 'C' => 'PAGADO'];
            foreach ($cuotas as $c) {
                $venta = $c->venta;
                $sheet->setCellValue('A' . $row, $venta->serie . '-' . str_pad($venta->numero, 8, '0', STR_PAD_LEFT));
                $sheet->setCellValue('B' . $row, $venta->cliente->datos ?? 'N/A');
                $sheet->setCellValue('C' . $row, $c->numero_cuota);
                $sheet->setCellValue('D' . $row, $c->fecha_vencimiento->format('d/m/Y'));
                $sheet->setCellValue('E' . $row, $c->monto_cuota);
                $sheet->setCellValue('F' . $row, $c->monto_pagado);
                $sheet->setCellValue('G' . $row, $c->saldo);
                $sheet->setCellValue('H' . $row, $estadoMap[$c->estado] ?? $c->estado);

                $sheet->getStyle('A' . $row . ':H' . $row)->applyFromArray([
                    'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN, 'color' => ['rgb' => 'CCCCCC']]],
                ]);
                $row++;
            }

            foreach (range('A', 'H') as $col) {
                $sheet->getColumnDimension($col)->setAutoSize(true);
            }

            $writer = new Xlsx($spreadsheet);
            $filename = 'cuentas-por-cobrar-' . date('Y-m-d-His') . '.xlsx';

            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            header('Content-Disposition: attachment;filename="' . $filename . '"');
            header('Cache-Control: max-age=0');
            $writer->save('php://output');
            exit;
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }

    public function exportPdf(Request $request)
    {
        try {
            $user = Auth::user();
            if (!$user) return response()->json(['success' => false, 'message' => 'Sesión expirada.'], 401);

            $cuotas = $this->getCuotas($request);
            $html = view('reportes.cuentas-cobrar-lista', compact('cuotas'))->render();

            $mpdf = new Mpdf([
                'mode' => 'utf-8',
                'format' => 'A4',
                'tempDir' => storage_path('app/mpdf'),
                'margin_left' => 10,
                'margin_right' => 10,
                'margin_top' => 10,
                'margin_bottom' => 10,
            ]);

            $mpdf->SetTitle('Cuentas por Cobrar');
            $mpdf->WriteHTML($html);
            $mpdf->Output('CuentasPorCobrar-' . date('Ymd') . '.pdf', 'I');
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }
}
