<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cotización COT-{{ str_pad($cotizacion->numero, 6, '0', STR_PAD_LEFT) }}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Arial', sans-serif;
            font-size: 8pt;
            color: #000;
            width: 70mm;
        }
        .ticket { padding: 5mm; }

        /* Header */
        .logos { text-align: center; margin-bottom: 8px; }
        .logos img { height: 25px; max-height: 25px; width: auto; }
        .company-name {
            text-align: center; font-weight: bold;
            font-size: 10pt; margin-bottom: 3px;
        }
        .company-info {
            text-align: center; font-size: 7pt;
            line-height: 1.3; margin-bottom: 8px;
        }
        .divider { border-top: 1px dashed #000; margin: 8px 0; }

        /* Documento */
        .doc-info  { text-align: center; margin-bottom: 8px; }
        .doc-type  { font-weight: bold; font-size: 9pt; margin-bottom: 2px; }
        .doc-number { font-weight: bold; font-size: 10pt; }

        /* Cliente */
        .client-info   { font-size: 7pt; margin-bottom: 8px; }
        .client-row    { margin-bottom: 2px; }
        .client-label  { font-weight: bold; display: inline; }

        /* Productos */
        .products { margin-bottom: 8px; }
        .products table { width: 100%; border-collapse: collapse; font-size: 7pt; }
        .products th { border-bottom: 1px solid #000; padding: 3px 0; text-align: left; font-weight: bold; }
        .products td { padding: 3px 0; vertical-align: top; }
        .text-center { text-align: center; }
        .text-right  { text-align: right; }

        /* Totales */
        .totals      { font-size: 8pt; margin-bottom: 8px; }
        .total-row   { display: table; width: 100%; margin-bottom: 3px; }
        .total-label { display: table-cell; font-weight: bold; }
        .total-value { display: table-cell; text-align: right; }
        .total-final { font-size: 10pt; font-weight: bold; margin-top: 5px; }

        /* Footer */
        .footer { text-align: center; font-size: 7pt; margin-top: 8px; }
    </style>
</head>
<body>
    <div class="ticket">
        <!-- Logo -->
        @if($cotizacion->empresa && $cotizacion->empresa->logo && file_exists(public_path('storage/' . $cotizacion->empresa->logo)))
        <div class="logos">
            <img src="{{ public_path('storage/' . $cotizacion->empresa->logo) }}" alt="Logo" height="25" style="max-height:25px; width:auto;">
        </div>
        @endif

        <!-- Empresa -->
        <div class="company-name">{{ $cotizacion->empresa->razon_social ?? 'EMPRESA' }}</div>
        <div class="company-info">
            R.U.C. {{ $cotizacion->empresa->ruc ?? '' }}<br>
            {{ $cotizacion->empresa->direccion ?? '' }}<br>
            @if($cotizacion->empresa->telefono)Tel: {{ $cotizacion->empresa->telefono }}<br>@endif
            {{ $cotizacion->empresa->email ?? '' }}
        </div>

        <div class="divider"></div>

        <!-- Documento -->
        <div class="doc-info">
            <div class="doc-type">COTIZACIÓN</div>
            <div class="doc-number">COT-{{ str_pad($cotizacion->numero, 6, '0', STR_PAD_LEFT) }}</div>
        </div>

        <div class="divider"></div>

        <!-- Cliente -->
        <div class="client-info">
            <div class="client-row">
                <span class="client-label">FECHA:</span> {{ $cotizacion->fecha->format('d/m/Y') }}
            </div>
            <div class="client-row">
                <span class="client-label">CLIENTE:</span> {{ $cotizacion->cliente->datos ?? '-' }}
            </div>
            <div class="client-row">
                <span class="client-label">DOC:</span> {{ $cotizacion->cliente->documento ?? '-' }}
            </div>
            @if($cotizacion->asunto)
            <div class="client-row">
                <span class="client-label">ATENCIÓN:</span> {{ $cotizacion->asunto }}
            </div>
            @endif
        </div>

        <div class="divider"></div>

        <!-- Productos -->
        @php $simbolo = $cotizacion->moneda === 'USD' ? '$' : 'S/'; @endphp
        <div class="products">
            <table>
                <thead>
                    <tr>
                        <th width="44%">Producto</th>
                        <th width="14%" class="text-center">Cant</th>
                        <th width="20%" class="text-right">P.U.</th>
                        <th width="22%" class="text-right">Total</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($cotizacion->detalles as $item)
                    <tr>
                        <td>{{ $item->nombre }}</td>
                        <td class="text-center">{{ number_format($item->cantidad, 2) }}</td>
                        <td class="text-right">{{ number_format($item->precio_especial ?? $item->precio_unitario, 2) }}</td>
                        <td class="text-right">{{ number_format($item->subtotal, 2) }}</td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>

        <div class="divider"></div>

        <!-- Totales -->
        <div class="totals">
            <div class="total-row">
                <div class="total-label">SUBTOTAL:</div>
                <div class="total-value">{{ $simbolo }} {{ number_format($cotizacion->subtotal, 2) }}</div>
            </div>
            @if($cotizacion->descuento > 0)
            <div class="total-row">
                <div class="total-label">DESCUENTO:</div>
                <div class="total-value">- {{ $simbolo }} {{ number_format($cotizacion->descuento, 2) }}</div>
            </div>
            @endif
            <div class="total-row">
                <div class="total-label">IGV (18%):</div>
                <div class="total-value">{{ $simbolo }} {{ number_format($cotizacion->igv, 2) }}</div>
            </div>
            <div class="total-row total-final">
                <div class="total-label">TOTAL:</div>
                <div class="total-value">{{ $simbolo }} {{ number_format($cotizacion->total, 2) }}</div>
            </div>
        </div>

        <div class="divider"></div>

        <!-- Footer -->
        <div class="footer">
            Válida por 30 días desde la fecha de emisión.
        </div>
    </div>
</body>
</html>
