<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cuentas por Pagar</title>
    <style>
        body { font-family: 'Helvetica', sans-serif; color: #333; font-size: 10px; }
        .header { text-align: center; margin-bottom: 20px; border-bottom: 2px solid #c7161d; padding-bottom: 10px; }
        .title { font-size: 18px; font-weight: bold; color: #c7161d; text-transform: uppercase; }
        .info { margin-bottom: 15px; font-style: italic; color: #666; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th { background-color: #90BFEB; color: white; padding: 8px; text-align: center; border: 1px solid #ddd; text-transform: uppercase; font-size: 9px; }
        td { padding: 6px 8px; border: 1px solid #ddd; }
        tr:nth-child(even) { background-color: #f9fafb; }
        .text-right { text-align: right; }
        .text-center { text-align: center; }
        .font-bold { font-weight: bold; }
        .status-pending { color: #d97706; font-weight: bold; }
        .status-overdue { color: #dc2626; font-weight: bold; }
        .status-paid { color: #059669; font-weight: bold; }
        .footer { position: fixed; bottom: 0; width: 100%; text-align: center; font-size: 8px; color: #999; border-top: 1px solid #eee; padding-top: 5px; }
    </style>
</head>
<body>
    <div class="header">
        <div class="title">Cuentas por Pagar</div>
        <div class="info">Reporte generado el {{ date('d/m/Y H:i:s') }}</div>
    </div>

    <table>
        <thead>
            <tr>
                <th width="15%">Documento</th>
                <th width="30%">Proveedor</th>
                <th width="14%">F. Vencimiento</th>
                <th width="14%">Monto</th>
                <th width="12%">Estado</th>
                <th width="15%">F. Pago</th>
            </tr>
        </thead>
        <tbody>
            @php $totalPendiente = 0; @endphp
            @foreach($cuotas as $c)
            @php
                $compra = $c->compra;
                $esVencido = $c->estado === '1' && $c->fecha->lt(now());
                $estadoClass = $c->estado === '0' ? 'status-paid' : ($esVencido ? 'status-overdue' : 'status-pending');
                $estadoLabel = $c->estado === '0' ? 'PAGADO' : ($esVencido ? 'VENCIDO' : 'PENDIENTE');
                if ($c->estado === '1') $totalPendiente += $c->monto;
            @endphp
            <tr>
                <td class="text-center">{{ $compra->serie }}-{{ str_pad($compra->numero, 8, '0', STR_PAD_LEFT) }}</td>
                <td>
                    <div class="font-bold">{{ $compra->proveedor->razon_social ?? 'N/A' }}</div>
                    <div style="font-size: 8px; color: #666;">RUC: {{ $compra->proveedor->ruc ?? 'N/A' }}</div>
                </td>
                <td class="text-center">{{ $c->fecha->format('d/m/Y') }}</td>
                <td class="text-right font-bold">S/ {{ number_format($c->monto, 2) }}</td>
                <td class="text-center"><span class="{{ $estadoClass }}">{{ $estadoLabel }}</span></td>
                <td class="text-center">{{ $c->fecha_pago ? $c->fecha_pago->format('d/m/Y') : '—' }}</td>
            </tr>
            @endforeach
        </tbody>
        <tfoot>
            <tr style="background-color: #FEF3C7;">
                <td colspan="3" class="text-right font-bold uppercase">Total Pendiente:</td>
                <td colspan="3" class="font-bold">S/ {{ number_format($totalPendiente, 2) }}</td>
            </tr>
        </tfoot>
    </table>

    <div class="footer">
        Plataforma de Gestión Empresarial - Página {PAGENO} de {nbpg}
    </div>
</body>
</html>
