<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DenominacionBillete extends Model
{
    use HasFactory;

    protected $table = 'denominaciones_billetes';
    protected $primaryKey = 'id_denominacion';

    protected $fillable = [
        'moneda',
        'valor',
        'tipo',
        'activa',
    ];

    protected $casts = [
        'valor' => 'decimal:2',
        'activa' => 'boolean',
    ];

    public function scopeActiva($query)
    {
        return $query->where('activa', true);
    }

    public function scopeMoneda($query, $moneda)
    {
        return $query->where('moneda', $moneda);
    }
}
