<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cuentas por Cobrar</title>
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
        <div class="title">Cuentas por Cobrar</div>
        <div class="info">Reporte generado el {{ date('d/m/Y H:i:s') }}</div>
    </div>

    <table>
        <thead>
            <tr>
                <th width="13%">Documento</th>
                <th width="25%">Cliente</th>
                <th width="6%">Cuota</th>
                <th width="12%">F. Vencimiento</th>
                <th width="12%">Monto</th>
                <th width="10%">Pagado</th>
                <th width="12%">Saldo</th>
                <th width="10%">Estado</th>
            </tr>
        </thead>
        <tbody>
            @php $totalSaldo = 0; @endphp
            @foreach($cuotas as $c)
            @php
                $venta = $c->venta;
                $estadoClass = match($c->estado) { 'P' => 'status-pending', 'V' => 'status-overdue', 'C' => 'status-paid', default => '' };
                $estadoLabel = match($c->estado) { 'P' => 'PENDIENTE', 'V' => 'VENCIDO', 'C' => 'PAGADO', default => $c->estado };
                if ($c->estado !== 'C') $totalSaldo += $c->saldo;
            @endphp
            <tr>
                <td class="text-center">{{ $venta->serie }}-{{ str_pad($venta->numero, 8, '0', STR_PAD_LEFT) }}</td>
                <td>
                    <div class="font-bold">{{ $venta->cliente->datos ?? 'N/A' }}</div>
                    <div style="font-size: 8px; color: #666;">{{ $venta->cliente->documento ?? '' }}</div>
                </td>
                <td class="text-center">{{ $c->numero_cuota }}</td>
                <td class="text-center">{{ $c->fecha_vencimiento->format('d/m/Y') }}</td>
                <td class="text-right">S/ {{ number_format($c->monto_cuota, 2) }}</td>
                <td class="text-right">S/ {{ number_format($c->monto_pagado, 2) }}</td>
                <td class="text-right font-bold">S/ {{ number_format($c->saldo, 2) }}</td>
                <td class="text-center"><span class="{{ $estadoClass }}">{{ $estadoLabel }}</span></td>
            </tr>
            @endforeach
        </tbody>
        <tfoot>
            <tr style="background-color: #FEF3C7;">
                <td colspan="6" class="text-right font-bold uppercase">Total Saldo Pendiente:</td>
                <td colspan="2" class="font-bold">S/ {{ number_format($totalSaldo, 2) }}</td>
            </tr>
        </tfoot>
    </table>

    <div class="footer">
        Plataforma de Gestión Empresarial - Página {PAGENO} de {nbpg}
    </div>
</body>
</html>
