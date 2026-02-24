<?php

return [
    'igv' => env('SUNAT_IGV', 0.18),

    'endpoints' => [
        'facturacion' => [
            'beta' => 'https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService',
            'production' => 'https://e-factura.sunat.gob.pe/ol-ti-itcpfegem/billService',
        ],
        'guia' => [
            'beta' => 'https://e-beta.sunat.gob.pe/ol-ti-itemision-guia-gem-beta/billService',
            'production' => 'https://e-guiaremision.sunat.gob.pe/ol-ti-itemision-guia-gem/billService',
        ],
        'gre' => [
            'auth' => 'https://api-seguridad.sunat.gob.pe/v1',
            'cpe' => 'https://api-cpe.sunat.gob.pe/v1',
            'client_id' => env('SUNAT_GRE_CLIENT_ID', ''),
            'client_secret' => env('SUNAT_GRE_CLIENT_SECRET', ''),
        ],
    ],

    'beta' => [
        'ruc' => '20000000001',
        'usuario_sol' => 'MODDATOS',
        'clave_sol' => 'moddatos',
    ],

    'certificado_prueba' => base_path('sunat/resources/cert.pem'),

    'storage' => [
        'xml' => 'sunat/xml',
        'cdr' => 'sunat/cdr',
        'certificados' => 'sunat/certificados',
    ],
];
