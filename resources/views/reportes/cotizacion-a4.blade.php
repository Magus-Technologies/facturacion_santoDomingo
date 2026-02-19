<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cotización COT-{{ str_pad($cotizacion->numero, 6, '0', STR_PAD_LEFT) }}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Arial', sans-serif; font-size: 9pt; color: #333; }

        /* Header */
        .company-name { font-size: 14pt; font-weight: bold; color: #000; margin-bottom: 5px; }
        .company-info  { font-size: 8pt; color: #666; line-height: 1.4; }
        .logos img { height: 45px; max-height: 45px; width: auto; margin-right: 8px; vertical-align: middle; }

        /* Caja de documento */
        .doc-box { border: 2px solid #f97316; text-align: center; min-width: 200px; }
        .doc-ruc  { padding: 8px; background: #fff; font-weight: bold; font-size: 10pt;
                    border-bottom: 2px solid #f97316; }
        .doc-type { padding: 10px; background: #f97316; font-weight: bold; font-size: 11pt;
                    color: #fff; border-bottom: 2px solid #f97316; }
        .doc-number { padding: 10px; background: #fff; font-weight: bold; font-size: 14pt; color: #000; }

        /* Sección cliente */
        .client-section { background: #f8f9fa; padding: 10px 15px; border-radius: 4px; margin-bottom: 15px; }

        /* Tabla de productos */
        .products-table { width: 100%; border-collapse: collapse; margin-bottom: 15px; }
        .products-table thead { background: #f97316; }
        .products-table th { padding: 7px 8px; text-align: left; font-size: 8pt;
                             font-weight: bold; border: 1px solid #ddd; color: #fff; }
        .products-table td { padding: 7px 8px; font-size: 8pt; border: 1px solid #ddd; }
        .products-table tbody tr:nth-child(even) { background: #fafafa; }
        .text-center { text-align: center; }
        .text-right  { text-align: right; }

        /* Totales */
        .totals-box { float: right; width: 260px; border: 1px solid #ddd; border-radius: 4px; overflow: hidden; }
        .total-row   { display: table; width: 100%; padding: 7px 12px; border-bottom: 1px solid #ddd; }
        .total-row:last-child { border-bottom: none; }
        .total-label { display: table-cell; font-weight: bold; font-size: 9pt; }
        .total-value { display: table-cell; text-align: right; font-size: 9pt; }
        .total-final { background: #f97316; color: #fff; font-size: 11pt; }
        .total-final .total-label, .total-final .total-value { color: #fff; }

        /* Cuotas */
        .cuotas-table { width: 100%; border-collapse: collapse; margin-top: 10px; font-size: 8pt; }
        .cuotas-table th { background: #374151; color: #fff; padding: 5px 8px; text-align: left; }
        .cuotas-table td { padding: 5px 8px; border-bottom: 1px solid #eee; }

        /* Footer */
        .footer { clear: both; text-align: center; margin-top: 30px; padding-top: 15px;
                  border-top: 1px solid #ddd; font-size: 8pt; color: #666; }
        .badge-estado { display: inline-block; padding: 3px 10px; border-radius: 12px;
                        font-size: 8pt; font-weight: bold; }
        .badge-pendiente { background: #fef3c7; color: #92400e; }
        .badge-aprobada  { background: #d1fae5; color: #065f46; }
        .badge-rechazada { background: #fee2e2; color: #991b1b; }
        .badge-vencida   { background: #f3f4f6; color: #374151; }
    </style>
</head>
<body>
    <div class="container">
        <!-- ===== HEADER ===== -->
        <table style="width:100%; margin-bottom:20px; border-collapse:collapse;">
            <tr>
                <!-- Columna izquierda: empresa -->
                <td style="width:60%; vertical-align:top; text-align:center; padding-right:10px;">
                    @if($cotizacion->empresa && $cotizacion->empresa->logo && file_exists(public_path('storage/' . $cotizacion->empresa->logo)))
                        <div class="logos">
                            <img src="{{ public_path('storage/' . $cotizacion->empresa->logo) }}" alt="Logo" height="45" style="max-height:45px; width:auto;">
                        </div>
                    @endif
                    <div class="company-name">{{ $cotizacion->empresa->razon_social ?? 'EMPRESA' }}</div>
                    <div class="company-info">
                        {{ $cotizacion->empresa->direccion ?? '' }}<br>
                        @if($cotizacion->empresa->telefono)Tel: {{ $cotizacion->empresa->telefono }}@endif
                        @if($cotizacion->empresa->email) | Email: {{ $cotizacion->empresa->email }}@endif
                    </div>
                </td>

                <!-- Columna derecha: caja de documento -->
                <td style="width:40%; vertical-align:top; text-align:center;">
                    <div class="doc-box">
                        <div class="doc-ruc">R.U.C. {{ $cotizacion->empresa->ruc ?? '' }}</div>
                        <div class="doc-type">COTIZACIÓN</div>
                        <div class="doc-number">COT-{{ str_pad($cotizacion->numero, 6, '0', STR_PAD_LEFT) }}</div>
                    </div>
                </td>
            </tr>
        </table>

        <!-- ===== DATOS DEL CLIENTE ===== -->
        <div class="client-section">
            <table style="width:100%; border-collapse:collapse;">
                <tr>
                    <td style="width:15%; font-weight:bold; color:#666; font-size:8pt; padding:3px 0; vertical-align:top;">FECHA:</td>
                    <td style="width:35%; font-size:9pt; padding:3px 0; vertical-align:top;">{{ $cotizacion->fecha->format('d/m/Y') }}</td>
                    <td style="width:15%; font-weight:bold; color:#666; font-size:8pt; padding:3px 0; vertical-align:top;">MONEDA:</td>
                    <td style="width:35%; font-size:9pt; padding:3px 0; vertical-align:top;">
                        {{ $cotizacion->moneda === 'USD' ? 'Dólares (USD)' : 'Soles (PEN)' }}
                    </td>
                </tr>
                <tr>
                    <td style="font-weight:bold; color:#666; font-size:8pt; padding:3px 0; vertical-align:top;">DNI/RUC:</td>
                    <td style="font-size:9pt; padding:3px 0; vertical-align:top;">{{ $cotizacion->cliente->documento ?? '-' }}</td>
                    <td style="font-weight:bold; color:#666; font-size:8pt; padding:3px 0; vertical-align:top;">ESTADO:</td>
                    <td style="font-size:9pt; padding:3px 0; vertical-align:top;">
                        <span class="badge-estado badge-{{ $cotizacion->estado }}">
                            {{ strtoupper($cotizacion->estado) }}
                        </span>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight:bold; color:#666; font-size:8pt; padding:3px 0; vertical-align:top;">CLIENTE:</td>
                    <td colspan="3" style="font-size:9pt; padding:3px 0; font-weight:bold;">{{ $cotizacion->cliente->datos ?? '-' }}</td>
                </tr>
                @if($cotizacion->direccion)
                <tr>
                    <td style="font-weight:bold; color:#666; font-size:8pt; padding:3px 0; vertical-align:top;">DIRECCIÓN:</td>
                    <td colspan="3" style="font-size:9pt; padding:3px 0;">{{ $cotizacion->direccion }}</td>
                </tr>
                @endif
                @if($cotizacion->asunto)
                <tr>
                    <td style="font-weight:bold; color:#666; font-size:8pt; padding:3px 0; vertical-align:top;">ATENCIÓN:</td>
                    <td colspan="3" style="font-size:9pt; padding:3px 0;">{{ $cotizacion->asunto }}</td>
                </tr>
                @endif
            </table>
        </div>

        <!-- ===== TABLA DE PRODUCTOS ===== -->
        @php
            $simbolo = $cotizacion->moneda === 'USD' ? '$' : 'S/';
        @endphp
        <table class="products-table">
            <thead>
                <tr>
                    <th width="5%"  class="text-center">#</th>
                    <th width="12%">Código</th>
                    <th width="40%">Producto / Descripción</th>
                    <th width="10%" class="text-center">Cant.</th>
                    <th width="15%" class="text-right">P. Unit.</th>
                    <th width="18%" class="text-right">Total</th>
                </tr>
            </thead>
            <tbody>
                @foreach($cotizacion->detalles as $index => $item)
                <tr>
                    <td class="text-center">{{ $index + 1 }}</td>
                    <td>{{ $item->codigo ?? '-' }}</td>
                    <td>
                        {{ $item->nombre }}
                        @if($item->descripcion && $item->descripcion !== $item->nombre)
                            <br><span style="color:#666; font-size:7.5pt;">{{ $item->descripcion }}</span>
                        @endif
                    </td>
                    <td class="text-center">{{ number_format($item->cantidad, 2) }}</td>
                    <td class="text-right">{{ $simbolo }} {{ number_format($item->precio_especial ?? $item->precio_unitario, 2) }}</td>
                    <td class="text-right">{{ $simbolo }} {{ number_format($item->subtotal, 2) }}</td>
                </tr>
                @endforeach
            </tbody>
        </table>

        <!-- ===== TOTALES ===== -->
        <div style="overflow:hidden; margin-bottom:20px;">
            <div class="totals-box">
                <div class="total-row">
                    <div class="total-label">SUBTOTAL:</div>
                    <div class="total-value">{{ $simbolo }} {{ number_format($cotizacion->subtotal, 2) }}</div>
                </div>
                @if($cotizacion->descuento > 0)
                <div class="total-row">
                    <div class="total-label">DESCUENTO:</div>
                    <div class="total-value" style="color:#dc2626;">- {{ $simbolo }} {{ number_format($cotizacion->descuento, 2) }}</div>
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
        </div>

        <!-- ===== CUOTAS (si aplica) ===== -->
        @if($cotizacion->cuotas && $cotizacion->cuotas->count() > 0)
        <div style="clear:both; margin-top:20px;">
            <p style="font-weight:bold; font-size:9pt; margin-bottom:5px; color:#374151;">PLAN DE PAGOS:</p>
            <table class="cuotas-table">
                <thead>
                    <tr>
                        <th>N°</th>
                        <th>Tipo</th>
                        <th>Fecha Vencimiento</th>
                        <th style="text-align:right;">Monto</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($cotizacion->cuotas as $cuota)
                    <tr>
                        <td>{{ $cuota->numero_cuota }}</td>
                        <td>{{ ucfirst($cuota->tipo) }}</td>
                        <td>{{ \Carbon\Carbon::parse($cuota->fecha_vencimiento)->format('d/m/Y') }}</td>
                        <td style="text-align:right;">{{ $simbolo }} {{ number_format($cuota->monto, 2) }}</td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
        @endif

        <!-- ===== CONDICIONES ===== -->
        @if($cotizacion->observaciones)
        <div style="clear:both; margin-top:15px; padding:10px; background:#f8f9fa; border-radius:4px; font-size:8pt;">
            <strong>Observaciones:</strong> {{ $cotizacion->observaciones }}
        </div>
        @endif

        <!-- ===== FOOTER ===== -->
        <div class="footer">
            <p>Esta cotización es válida por 30 días a partir de la fecha de emisión.</p>
            <p style="margin-top:4px;">{{ $cotizacion->empresa->razon_social ?? '' }} | RUC: {{ $cotizacion->empresa->ruc ?? '' }}</p>
        </div>
    </div>
</body>
</html>
