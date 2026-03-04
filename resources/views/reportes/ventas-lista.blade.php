<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte de Ventas</title>
    <style>
        body { font-family: 'Helvetica', sans-serif; color: #333; font-size: 9px; }
        .header { text-align: center; margin-bottom: 15px; border-bottom: 2px solid #f97316; padding-bottom: 8px; }
        .title { font-size: 16px; font-weight: bold; color: #1f2937; text-transform: uppercase; }
        .subtitle { font-size: 11px; color: #f97316; font-weight: bold; margin-top: 2px; }
        .info { font-size: 9px; font-style: italic; color: #6b7280; margin-top: 4px; }
        table { width: 100%; border-collapse: collapse; margin-top: 8px; }
        th { background-color: #f3f4f6; color: #374151; padding: 6px 4px; text-align: center; border-bottom: 2px solid #d1d5db; text-transform: uppercase; font-size: 8px; font-weight: bold; }
        td { padding: 5px 4px; border-bottom: 1px solid #e5e7eb; }
        tr:nth-child(even) { background-color: #f9fafb; }
        .text-right { text-align: right; }
        .text-center { text-align: center; }
        .font-bold { font-weight: bold; }
        .status-active { color: #059669; font-weight: bold; }
        .status-void { color: #dc2626; font-weight: bold; }
        .totals-row { background-color: #fef3c7 !important; }
        .totals-row td { border-top: 2px solid #f59e0b; border-bottom: 2px solid #f59e0b; font-weight: bold; color: #92400e; }
        .footer { position: fixed; bottom: 0; width: 100%; text-align: center; font-size: 7px; color: #9ca3af; border-top: 1px solid #e5e7eb; padding-top: 4px; }
    </style>
</head>
<body>
    <div class="header">
        @if($empresa)
            <div style="font-size: 12px; font-weight: bold; color: #374151;">{{ $empresa->razon_social }}</div>
            <div style="font-size: 9px; color: #6b7280;">RUC: {{ $empresa->ruc }} | {{ $empresa->direccion ?? '' }}</div>
        @endif
        <div class="title">Reporte de Ventas</div>
        <div class="subtitle">{{ $meses[(int)$mes] }} {{ $anio }}</div>
        <div class="info">Generado el {{ date('d/m/Y H:i:s') }}</div>
    </div>

    <table>
        <thead>
            <tr>
                <th width="3%">#</th>
                <th width="10%">Documento</th>
                <th width="8%">Fecha</th>
                <th width="25%">Cliente</th>
                <th width="9%">RUC/DNI</th>
                <th width="9%">Subtotal</th>
                <th width="8%">IGV</th>
                <th width="9%">Total</th>
                <th width="6%">Moneda</th>
                <th width="6%">Estado</th>
                <th width="7%">SUNAT</th>
            </tr>
        </thead>
        <tbody>
            @php $totalPEN = 0; $totalUSD = 0; $num = 0; @endphp
            @foreach($ventas as $v)
                @php
                    $num++;
                    $anulada = in_array($v->estado, ['2', 'A']);
                    $tipoAbrev = $v->tipoDocumento->abreviatura ?? '';
                    $numCompleto = $v->serie . '-' . str_pad($v->numero, 8, '0', STR_PAD_LEFT);
                @endphp
                <tr>
                    <td class="text-center">{{ $num }}</td>
                    <td class="text-center font-bold">{{ $tipoAbrev }} {{ $numCompleto }}</td>
                    <td class="text-center">{{ $v->fecha_emision->format('d/m/Y') }}</td>
                    <td>{{ $v->cliente->datos ?? 'N/A' }}</td>
                    <td class="text-center">{{ $v->cliente->documento ?? '' }}</td>
                    <td class="text-right">{{ number_format($v->subtotal, 2) }}</td>
                    <td class="text-right">{{ number_format($v->igv, 2) }}</td>
                    <td class="text-right font-bold">{{ number_format($v->total, 2) }}</td>
                    <td class="text-center">{{ $v->tipo_moneda }}</td>
                    <td class="text-center">
                        <span class="{{ $anulada ? 'status-void' : 'status-active' }}">
                            {{ $anulada ? 'ANULADA' : 'ACTIVA' }}
                        </span>
                    </td>
                    <td class="text-center">
                        {{ $v->estado_sunat == '1' ? 'ENVIADO' : ($v->estado_sunat == '2' ? 'RECHAZADO' : 'PENDIENTE') }}
                    </td>
                </tr>
                @if(!$anulada)
                    @php
                        if ($v->tipo_moneda == 'USD') $totalUSD += $v->total;
                        else $totalPEN += $v->total;
                    @endphp
                @endif
            @endforeach
        </tbody>
        <tfoot>
            <tr class="totals-row">
                <td colspan="7" class="text-right font-bold">TOTALES (Solo Activas):</td>
                <td class="text-right font-bold">
                    @if($totalPEN > 0) S/ {{ number_format($totalPEN, 2) }} @endif
                    @if($totalUSD > 0) <br>$ {{ number_format($totalUSD, 2) }} @endif
                </td>
                <td colspan="3" class="text-center">{{ $ventas->count() }} documentos</td>
            </tr>
        </tfoot>
    </table>

    <div class="footer">
        {{ $empresa->razon_social ?? '' }} - Reporte de Ventas {{ $meses[(int)$mes] }} {{ $anio }} - Pagina {PAGENO} de {nbpg}
    </div>
</body>
</html>
