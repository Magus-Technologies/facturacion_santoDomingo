<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ConciliacionBancaria extends Model
{
    use HasFactory;

    protected $table = 'conciliaciones_bancarias';
    protected $primaryKey = 'id_conciliacion';

    protected $fillable = [
        'id_cuenta',
        'id_empresa',
        'id_usuario',
        'fecha_conciliacion',
        'saldo_empresa',
        'saldo_banco',
        'diferencia',
        'estado',
        'observaciones',
    ];

    protected $casts = [
        'fecha_conciliacion' => 'date',
        'saldo_empresa' => 'decimal:2',
        'saldo_banco' => 'decimal:2',
        'diferencia' => 'decimal:2',
    ];

    public function cuenta()
    {
        return $this->belongsTo(CuentaBancaria::class, 'id_cuenta', 'id_cuenta');
    }

    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    public function usuario()
    {
        return $this->belongsTo(User::class, 'id_usuario', 'id');
    }
}
