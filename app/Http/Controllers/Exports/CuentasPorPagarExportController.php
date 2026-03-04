<?php

namespace App\Http\Controllers\Exports;

use App\Http\Controllers\Controller;
use App\Models\DiaCompra;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Style\Border;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use Mpdf\Mpdf;

class CuentasPorPagarExportController extends Controller
{
    private function getCuotas(Request $request)
    {
        $user = Auth::user();
        $query = DiaCompra::with(['compra.proveedor'])
            ->whereHas('compra', function ($q) use ($user) {
                $q->where('id_empresa', $user->id_empresa)->where('estado', '1');
            });

        if ($request->filled('estado')) {
            $estado = $request->estado;
            if ($estado === '1') $query->pendientes();
            elseif ($estado === '0') $query->pagadas();
            elseif ($estado === 'V') $query->vencidas();
        }
        if ($request->filled('fecha_desde')) $query->where('fecha', '>=', $request->fecha_desde);
        if ($request->filled('fecha_hasta')) $query->where('fecha', '<=', $request->fecha_hasta);
        if ($request->filled('proveedor')) {
            $proveedor = $request->proveedor;
            $query->whereHas('compra.proveedor', function ($q) use ($proveedor) {
                $q->where('razon_social', 'like', "%{$proveedor}%")->orWhere('ruc', 'like', "%{$proveedor}%");
            });
        }

        return $query->orderBy('fecha', 'asc')->get();
    }

    public function exportExcel(Request $request)
    {
        try {
            $user = Auth::user();
            if (!$user) return response()->json(['success' => false, 'message' => 'Sesión expirada.'], 401);

            $cuotas = $this->getCuotas($request);
            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();

            $sheet->setCellValue('A1', 'CUENTAS POR PAGAR');
            $sheet->mergeCells('A1:F1');
            $sheet->getStyle('A1')->applyFromArray([
                'font' => ['bold' => true, 'size' => 14, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => 'C7161D']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ]);

            $sheet->setCellValue('A2', 'Generado: ' . date('d/m/Y H:i:s'));
            $sheet->mergeCells('A2:F2');
            $sheet->getStyle('A2')->applyFromArray([
                'font' => ['italic' => true, 'size' => 10],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
            ]);

            $headers = ['Documento', 'Proveedor', 'F. Vencimiento', 'Monto', 'Estado', 'F. Pago'];
            $col = 'A';
            foreach ($headers as $header) {
                $sheet->setCellValue($col . '4', $header);
                $col++;
            }

            $sheet->getStyle('A4:F4')->applyFromArray([
                'font' => ['bold' => true, 'color' => ['rgb' => 'FFFFFF']],
                'fill' => ['fillType' => Fill::FILL_SOLID, 'startColor' => ['rgb' => '90BFEB']],
                'alignment' => ['horizontal' => Alignment::HORIZONTAL_CENTER],
                'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN]],
            ]);

            $row = 5;
            foreach ($cuotas as $c) {
                $compra = $c->compra;
                $esVencido = $c->estado === '1' && $c->fecha->lt(now());
                $estadoLabel = $c->estado === '0' ? 'PAGADO' : ($esVencido ? 'VENCIDO' : 'PENDIENTE');

                $sheet->setCellValue('A' . $row, $compra->serie . '-' . str_pad($compra->numero, 8, '0', STR_PAD_LEFT));
                $sheet->setCellValue('B' . $row, $compra->proveedor->razon_social ?? 'N/A');
                $sheet->setCellValue('C' . $row, $c->fecha->format('d/m/Y'));
                $sheet->setCellValue('D' . $row, $c->monto);
                $sheet->setCellValue('E' . $row, $estadoLabel);
                $sheet->setCellValue('F' . $row, $c->fecha_pago ? $c->fecha_pago->format('d/m/Y') : '—');

                $sheet->getStyle('A' . $row . ':F' . $row)->applyFromArray([
                    'borders' => ['allBorders' => ['borderStyle' => Border::BORDER_THIN, 'color' => ['rgb' => 'CCCCCC']]],
                ]);
                $row++;
            }

            foreach (range('A', 'F') as $col) {
                $sheet->getColumnDimension($col)->setAutoSize(true);
            }

            $writer = new Xlsx($spreadsheet);
            $filename = 'cuentas-por-pagar-' . date('Y-m-d-His') . '.xlsx';

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
            $html = view('reportes.cuentas-pagar-lista', compact('cuotas'))->render();

            $mpdf = new Mpdf([
                'mode' => 'utf-8',
                'format' => 'A4',
                'tempDir' => storage_path('app/mpdf'),
                'margin_left' => 10,
                'margin_right' => 10,
                'margin_top' => 10,
                'margin_bottom' => 10,
            ]);

            $mpdf->SetTitle('Cuentas por Pagar');
            $mpdf->WriteHTML($html);
            $mpdf->Output('CuentasPorPagar-' . date('Ymd') . '.pdf', 'I');
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 500);
        }
    }
}
