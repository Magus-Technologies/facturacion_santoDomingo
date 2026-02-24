<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MotivoNota extends Model
{
    protected $table = 'motivo_nota';

    protected $fillable = [
        'tipo',
        'codigo_sunat',
        'descripcion',
        'estado',
    ];

    protected $casts = [
        'estado' => 'boolean',
    ];

    public function scopeNotaCredito($query)
    {
        return $query->where('tipo', 'NC');
    }

    public function scopeNotaDebito($query)
    {
        return $query->where('tipo', 'ND');
    }

    public function scopeActivos($query)
    {
        return $query->where('estado', true);
    }
}
