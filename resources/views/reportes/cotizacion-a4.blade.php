<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cotización COT-{{ str_pad($cotizacion->numero, 6, '0', STR_PAD_LEFT) }}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Arial', sans-serif;
            font-size: 9pt;
            color: #333;
        }
        /* Header */
        .header-table {
            width: 100%;
            margin-bottom: 20px;
            border-collapse: collapse;
        }
        .header-left {
            width: 60%;
            vertical-align: top;
            text-align: center;
            padding-right: 5px;
        }
        .header-right {
            width: 40%;
            vertical-align: top;
            text-align: center;
        }
        .logos {
            margin-bottom: 10px;
        }
        .logos img {
            height: 45px;
            max-height: 45px;
            width: auto;
            margin-right: 8px;
            vertical-align: middle;
        }
        .company-name {
            font-size: 14pt;
            font-weight: bold;
            color: #000;
            margin-bottom: 5px;
        }
        .company-info {
            font-size: 8pt;
            color: #666;
            line-height: 1.4;
        }

        /* Client Info */
        .client-section {
            background: #f8f9fa;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .info-row {
            display: table;
            width: 100%;
            margin-bottom: 8px;
        }
        .info-row:last-child {
            margin-bottom: 0;
        }
        .info-col {
            display: table-cell;
            width: 50%;
            padding-right: 10px;
        }
        .info-label {
            font-weight: bold;
            font-size: 8pt;
            color: #666;
            margin-bottom: 2px;
        }
        .info-value {
            font-size: 9pt;
            color: #000;
        }

        /* Products Table */
        .products-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 15px;
        }
        .products-table thead {
            background: #fabd1e;
            color: #000;
        }
        .products-table th {
            padding: 8px;
            text-align: left;
            font-size: 8pt;
            font-weight: bold;
            border: 1px solid #ddd;
        }
        .products-table td {
            padding: 8px;
            font-size: 8pt;
            border: 1px solid #ddd;
        }
        .products-table tbody tr:nth-child(even) {
            background: #f8f9fa;
        }
        .text-center {
            text-align: center;
        }
        .text-right {
            text-align: right;
        }

        /* Totals */
        .totals-section {
            width: 100%;
            margin-top: 20px;
        }
        .totals-box {
            float: right;
            width: 260px;
        }
        .total-row {
            padding: 8px 12px;
            border-bottom: 1px solid #ddd;
            display: table;
            width: 100%;
        }
        .total-label {
            display: table-cell;
            font-weight: bold;
            font-size: 9pt;
        }
        .total-value {
            display: table-cell;
            text-align: right;
            font-size: 9pt;
        }
        .total-final {
            background: #fabd1e;
            color: #000;
            font-weight: bold;
            font-size: 11pt;
            border: none;
        }

        /* Cuotas */
        .cuotas-table { width: 100%; border-collapse: collapse; margin-top: 10px; font-size: 8pt; }
        .cuotas-table th { background: #fabd1e; color: #000; padding: 5px 8px; text-align: left; border: 1px solid #ddd; }
        .cuotas-table td { padding: 5px 8px; border: 1px solid #ddd; }

        /* Footer */
        .footer {
            clear: both;
            text-align: center;
            margin-top: 30px;
            padding-top: 15px;
            border-top: 1px solid #ddd;
            font-size: 9pt;
            color: #666;
        }
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
        <!-- Header -->
        <table style="width: 100%; margin-bottom: 20px; border-collapse: collapse;">
            <tr>
                <td style="width: 60%; vertical-align: top; text-align: center; padding-right: 10px;">
                    <div class="logos">
                        @if($cotizacion->empresa && $cotizacion->empresa->logo && file_exists(public_path('storage/' . $cotizacion->empresa->logo)))
                            <img src="{{ public_path('storage/' . $cotizacion->empresa->logo) }}" alt="Logo" height="45">
                        @endif
                    </div>
                    <div class="company-name">{{ $cotizacion->empresa->razon_social ?? 'EMPRESA' }}</div>
                    <div class="company-info">
                        {{ $cotizacion->empresa->direccion ?? '' }}<br>
                        @if($cotizacion->empresa->telefono)Tel: {{ $cotizacion->empresa->telefono }}@endif
                        @if($cotizacion->empresa->email) | Email: {{ $cotizacion->empresa->email }}@endif
                    </div>
                </td>
                <td style="width: 40%; vertical-align: top; text-align: center; padding: 0;">
                    <svg width="220" height="110" xmlns="http://www.w3.org/2000/svg" style="margin: 0 auto; display: block;">
                        <rect x="0" y="0" width="220" height="110" rx="10" ry="10" fill="white" stroke="#fabd1e" stroke-width="2"/>
                        <rect x="0" y="35" width="220" height="37" fill="#fabd1e"/>
                        <line x1="0" y1="35" x2="220" y2="35" stroke="#fabd1e" stroke-width="2"/>
                        <line x1="0" y1="72" x2="220" y2="72" stroke="#fabd1e" stroke-width="2"/>
                        <text x="110" y="22" text-anchor="middle" font-family="Arial, sans-serif" font-size="11" font-weight="bold" fill="#000">
                            R.U.C. {{ $cotizacion->empresa->ruc ?? '' }}
                        </text>
                        <text x="110" y="57" text-anchor="middle" font-family="Arial, sans-serif" font-size="12" font-weight="bold" fill="#000">
                            COTIZACIÓN
                        </text>
                        <text x="110" y="95" text-anchor="middle" font-family="Arial, sans-serif" font-size="15" font-weight="bold" fill="#000">
                            COT-{{ str_pad($cotizacion->numero, 6, '0', STR_PAD_LEFT) }}
                        </text>
                    </svg>
                </td>
            </tr>
        </table>

        <!-- Client Info -->
        <div class="client-section" style="padding: 10px 15px;">
            <table style="width: 100%; border-collapse: collapse;">
                <tr>
                    <td style="width: 15%; font-weight: bold; color: #666; font-size: 8pt; padding: 3px 0; vertical-align: top;">FECHA:</td>
                    <td style="width: 35%; font-size: 9pt; color: #000; padding: 3px 0; vertical-align: top;">{{ $cotizacion->fecha->format('d/m/Y') }}</td>
                    <td style="width: 15%; font-weight: bold; color: #666; font-size: 8pt; padding: 3px 0; vertical-align: top;">MONEDA:</td>
                    <td style="width: 35%; font-size: 9pt; color: #000; padding: 3px 0; vertical-align: top;">{{ $cotizacion->moneda === 'USD' ? 'Dólares (USD)' : 'Soles (PEN)' }}</td>
                </tr>
                <tr>
                    <td style="font-weight: bold; color: #666; font-size: 8pt; padding: 3px 0; vertical-align: top;">DNI/RUC:</td>
                    <td style="font-size: 9pt; color: #000; padding: 3px 0; vertical-align: top;">{{ $cotizacion->cliente->documento ?? '-' }}</td>
                    <td style="font-weight: bold; color: #666; font-size: 8pt; padding: 3px 0; vertical-align: top;">ESTADO:</td>
                    <td style="font-size: 9pt; color: #000; padding: 3px 0; vertical-align: top;">
                        <span class="badge-estado badge-{{ $cotizacion->estado }}">
                            {{ strtoupper($cotizacion->estado) }}
                        </span>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: bold; color: #666; font-size: 8pt; padding: 3px 0; vertical-align: top;">CLIENTE:</td>
                    <td colspan="3" style="font-size: 9pt; color: #000; padding: 3px 0; vertical-align: top;">{{ $cotizacion->cliente->datos ?? '-' }}</td>
                </tr>
                @if($cotizacion->direccion)
                <tr>
                    <td style="font-weight: bold; color: #666; font-size: 8pt; padding: 3px 0; vertical-align: top;">DIRECCIÓN:</td>
                    <td colspan="3" style="font-size: 9pt; color: #000; padding: 3px 0; vertical-align: top;">{{ $cotizacion->direccion }}</td>
                </tr>
                @endif
                @if($cotizacion->asunto)
                <tr>
                    <td style="font-weight: bold; color: #666; font-size: 8pt; padding: 3px 0; vertical-align: top;">ATENCIÓN:</td>
                    <td colspan="3" style="font-size: 9pt; color: #000; padding: 3px 0; vertical-align: top;">{{ $cotizacion->asunto }}</td>
                </tr>
                @endif
            </table>
        </div>

        <!-- Products Table -->
        @php
            $simbolo = $cotizacion->moneda === 'USD' ? '$' : 'S/';
        @endphp
        <table class="products-table">
            <thead>
                <tr>
                    <th width="5%" class="text-center">#</th>
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

        <!-- Totals -->
        <div class="totals-section">
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

        <!-- Cuotas (si aplica) -->
        @if($cotizacion->cuotas && $cotizacion->cuotas->count() > 0)
        <div style="clear: both; margin-top: 20px;">
            <p style="font-weight: bold; font-size: 9pt; margin-bottom: 5px; color: #374151;">PLAN DE PAGOS:</p>
            <table class="cuotas-table">
                <thead>
                    <tr>
                        <th>N°</th>
                        <th>Tipo</th>
                        <th>Fecha Vencimiento</th>
                        <th style="text-align: right;">Monto</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($cotizacion->cuotas as $cuota)
                    <tr>
                        <td class="text-center">{{ $cuota->numero_cuota }}</td>
                        <td>{{ ucfirst($cuota->tipo) }}</td>
                        <td>{{ \Carbon\Carbon::parse($cuota->fecha_vencimiento)->format('d/m/Y') }}</td>
                        <td style="text-align: right;">{{ $simbolo }} {{ number_format($cuota->monto, 2) }}</td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
        @endif

        <!-- Footer -->
        <div class="footer">
            <p>Esta cotización es válida por 30 días a partir de la fecha de emisión.</p>
            <p style="margin-top: 4px;">{{ $cotizacion->empresa->razon_social ?? '' }} | RUC: {{ $cotizacion->empresa->ruc ?? '' }}</p>
            
            @if($cotizacion->observaciones)
                <div style="margin-top: 10px; text-align: left; background: #f8f9fa; padding: 10px; border-radius: 5px;">
                    <strong>Observaciones:</strong><br>
                    {{ $cotizacion->observaciones }}
                </div>
            @endif
        </div>
    </div>
</body>
</html>
