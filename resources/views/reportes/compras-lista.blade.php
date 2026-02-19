<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte de Compras</title>
    <style>
        body { font-family: 'Helvetica', sans-serif; color: #333; font-size: 10px; }
        .header { text-align: center; margin-bottom: 20px; border-bottom: 2px solid #10b981; padding-bottom: 10px; }
        .title { font-size: 18px; font-weight: bold; color: #10b981; text-transform: uppercase; }
        .info { margin-bottom: 15px; font-style: italic; color: #666; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th { background-color: #90BFEB; color: white; padding: 8px; text-align: center; border: 1px solid #ddd; text-transform: uppercase; font-size: 9px; }
        td { padding: 8px; border: 1px solid #ddd; }
        tr:nth-child(even) { background-color: #f9fafb; }
        .text-right { text-align: right; }
        .text-center { text-align: center; }
        .font-bold { font-weight: bold; }
        .status-active { color: #059669; font-weight: bold; }
        .status-void { color: #dc2626; font-weight: bold; }
        .footer { position: fixed; bottom: 0; width: 100%; text-align: center; font-size: 8px; color: #999; border-top: 1px solid #eee; padding-top: 5px; }
    </style>
</head>
<body>
    <div class="header">
        <div class="title">Historial General de Compras</div>
        <div class="info">Reporte generado el {{ date('d/m/Y H:i:s') }}</div>
    </div>

    <table>
        <thead>
            <tr>
                <th width="12%">Fecha</th>
                <th width="15%">Documento</th>
                <th width="30%">Proveedor / RUC</th>
                <th width="10%">Moneda</th>
                <th width="15%">Total</th>
                <th width="10%">Estado</th>
            </tr>
        </thead>
        <tbody>
            @php $totalPEN = 0; $totalUSD = 0; @endphp
            @foreach($compras as $c)
            <tr>
                <td class="text-center">{{ $c->fecha_emision->format('d/m/Y') }}</td>
                <td class="text-center">{{ $c->serie }}-{{ str_pad($c->numero, 8, '0', STR_PAD_LEFT) }}</td>
                <td>
                    <div class="font-bold">{{ $c->proveedor->razon_social ?? 'N/A' }}</div>
                    <div style="font-size: 8px; color: #666;">RUC: {{ $c->proveedor->ruc ?? 'N/A' }}</div>
                </td>
                <td class="text-center">{{ $c->moneda }}</td>
                <td class="text-right font-bold">
                    {{ $c->moneda == 'PEN' ? 'S/' : '$' }} {{ number_format($c->total, 2) }}
                </td>
                <td class="text-center">
                    <span class="{{ $c->estado == '1' ? 'status-active' : 'status-void' }}">
                        {{ $c->estado == '1' ? 'ACTIVO' : 'ANULADO' }}
                    </span>
                </td>
            </tr>
            @php 
                if($c->estado == '1') {
                    if($c->moneda == 'PEN') $totalPEN += $c->total;
                    else $totalUSD += $c->total;
                }
            @endphp
            @endforeach
        </tbody>
        <tfoot>
            <tr style="background-color: #FEF3C7;">
                <td colspan="4" class="text-right font-bold uppercase">Totales Acumulados (Solo Activos):</td>
                <td colspan="2" class="text-left">
                    <div class="font-bold">S/ {{ number_format($totalPEN, 2) }}</div>
                    <div class="font-bold">$ {{ number_format($totalUSD, 2) }}</div>
                </td>
            </tr>
        </tfoot>
    </table>

    <div class="footer">
        Plataforma de Gestión Empresarial - Página {PAGENO} de {nbpg}
    </div>
</body>
</html>
