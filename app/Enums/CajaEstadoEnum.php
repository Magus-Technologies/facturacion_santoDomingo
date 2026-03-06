<?php

namespace App\Enums;

enum CajaEstadoEnum: string
{
    case Inactiva              = 'Inactiva';
    case Abierta               = 'Abierta';
    case Cerrada               = 'Cerrada';
    case PendienteAutorizacion = 'Pendiente Autorización';
}
