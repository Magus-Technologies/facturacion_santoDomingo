<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MovimientoBancario extends Model
{
    use HasFactory;

    protected $table = 'movimientos_bancarios';
    protected $primaryKey = 'id_movimiento';

    protected $fillable = [
        'id_cuenta',
        'id_empresa',
        'tipo',
        'monto',
        'fecha_movimiento',
        'numero_operacion',
        'referencia',
        'descripcion',
        'conciliado',
    ];

    protected $casts = [
        'monto' => 'decimal:2',
        'fecha_movimiento' => 'date',
        'conciliado' => 'boolean',
    ];

    public function cuenta()
    {
        return $this->belongsTo(CuentaBancaria::class, 'id_cuenta', 'id_cuenta');
    }

    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    public function scopeNoConciliado($query)
    {
        return $query->where('conciliado', false);
    }
}
