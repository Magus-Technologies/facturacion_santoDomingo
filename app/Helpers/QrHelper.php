<?php

namespace App\Helpers;

use App\Models\GuiaRemision;
use App\Models\Venta;
use chillerlan\QRCode\QRCode;
use chillerlan\QRCode\QROptions;

class QrHelper
{
    /**
     * Genera un QR como imagen PNG en base64 listo para <img src="">
     */
    public static function generarQrBase64(string $contenido): string
    {
        $options = new QROptions([
            'outputType' => QRCode::OUTPUT_IMAGE_PNG,
            'scale' => 5,
            'imageBase64' => false,
        ]);

        $qrcode = new QRCode($options);
        $imageData = $qrcode->render($contenido);

        return 'data:image/png;base64,' . base64_encode($imageData);
    }

    /**
     * Construye el string QR estándar SUNAT para Factura/Boleta
     * Formato: RUC|tipoDoc|serie-numero|IGV|total|fecha|tipoDocCliente|numDocCliente|hash
     */
    public static function buildQrStringVenta(Venta $venta): string
    {
        $empresa = $venta->empresa;
        $ruc = $empresa->ruc ?? '';

        // Tipo documento SUNAT: 01=Factura, 03=Boleta
        $tipoDoc = '01';
        if ($venta->tipoDocumento) {
            $abrev = strtoupper($venta->tipoDocumento->abreviatura ?? '');
            if (in_array($abrev, ['BOL', 'BV', 'B'])) {
                $tipoDoc = '03';
            }
        }
        // Si la serie empieza con B, es boleta
        if (str_starts_with(strtoupper($venta->serie), 'B')) {
            $tipoDoc = '03';
        }

        $serieNumero = $venta->serie . '-' . str_pad($venta->numero, 8, '0', STR_PAD_LEFT);
        $igv = number_format($venta->igv ?? 0, 2, '.', '');
        $total = number_format($venta->total ?? 0, 2, '.', '');
        $fecha = $venta->fecha_emision ? $venta->fecha_emision->format('Y-m-d') : '';

        // Tipo doc cliente: 6=RUC, 1=DNI
        $tipoDocCliente = '1';
        $numDocCliente = '';
        if ($venta->cliente) {
            $numDocCliente = $venta->cliente->documento ?? '';
            $tipoDocCliente = strlen($numDocCliente) === 11 ? '6' : '1';
        }

        $hash = $venta->hash_cpe ?? '';

        return implode('|', [
            $ruc,
            $tipoDoc,
            $serieNumero,
            $igv,
            $total,
            $fecha,
            $tipoDocCliente,
            $numDocCliente,
            $hash,
        ]);
    }

    /**
     * Construye el string QR para Guía de Remisión
     */
    public static function buildQrStringGuia(GuiaRemision $guia): string
    {
        $empresa = $guia->empresa;
        $ruc = $empresa->ruc ?? '';
        $serieNumero = $guia->serie . '-' . str_pad($guia->numero, 8, '0', STR_PAD_LEFT);
        $fecha = $guia->fecha_emision ? $guia->fecha_emision->format('Y-m-d') : '';
        $hash = $guia->hash_cpe ?? '';

        return implode('|', [
            $ruc,
            '09', // Tipo doc: Guía de Remisión
            $serieNumero,
            $fecha,
            $guia->destinatario_documento ?? '',
            $hash,
        ]);
    }
}
