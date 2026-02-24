<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MotivoTraslado extends Model
{
    protected $table = 'motivo_traslado';

    protected $fillable = [
        'codigo',
        'descripcion',
        'estado',
    ];

    protected $casts = [
        'estado' => 'boolean',
    ];
}
