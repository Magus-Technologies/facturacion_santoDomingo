<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Proveedores</title>
    <style>
        body { font-family: 'Helvetica', sans-serif; color: #333; font-size: 10px; }
        .header { text-align: center; margin-bottom: 20px; border-bottom: 2px solid #f97316; padding-bottom: 10px; }
        .title { font-size: 18px; font-weight: bold; color: #f97316; text-transform: uppercase; }
        .info { margin-bottom: 15px; font-style: italic; color: #666; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th { background-color: #90BFEB; color: white; padding: 8px; text-align: left; border: 1px solid #ddd; text-transform: uppercase; font-size: 9px; }
        td { padding: 8px; border: 1px solid #ddd; }
        tr:nth-child(even) { background-color: #f9fafb; }
        .footer { position: fixed; bottom: 0; width: 100%; text-align: center; font-size: 8px; color: #999; border-top: 1px solid #eee; padding-top: 5px; }
    </style>
</head>
<body>
    <div class="header">
        <div class="title">Cartera de Proveedores</div>
        <div class="info">Reporte generado el {{ date('d/m/Y H:i:s') }}</div>
    </div>

    <table>
        <thead>
            <tr>
                <th width="10%">RUC</th>
                <th width="25%">Razón Social</th>
                <th width="15%">Email</th>
                <th width="10%">Teléfono</th>
                <th width="25%">Dirección</th>
                <th width="15%">Ubicación</th>
            </tr>
        </thead>
        <tbody>
            @foreach($proveedores as $p)
            <tr>
                <td>{{ $p->ruc }}</td>
                <td style="font-weight: bold;">{{ $p->razon_social }}</td>
                <td>{{ $p->email ?? '-' }}</td>
                <td>{{ $p->telefono ?? '-' }}</td>
                <td>{{ $p->direccion ?? '-' }}</td>
                <td>{{ implode(', ', array_filter([$p->distrito, $p->provincia, $p->departamento])) }}</td>
            </tr>
            @endforeach
        </tbody>
    </table>

    <div class="footer">
        Este documento es un reporte informativo de la plataforma de facturación. Página {PAGENO} de {nbpg}
    </div>
</body>
</html>
