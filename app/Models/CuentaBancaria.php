<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CuentaBancaria extends Model
{
    use HasFactory;

    protected $table = 'cuentas_bancarias';
    protected $primaryKey = 'id_cuenta';

    protected $fillable = [
        'id_empresa',
        'id_banco',
        'numero_cuenta',
        'tipo_cuenta',
        'moneda',
        'saldo_actual',
        'saldo_banco',
        'cci',
        'activa',
    ];

    protected $casts = [
        'saldo_actual' => 'decimal:2',
        'saldo_banco' => 'decimal:2',
        'activa' => 'boolean',
    ];

    public function banco()
    {
        return $this->belongsTo(Banco::class, 'id_banco', 'id_banco');
    }

    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    public function titulares()
    {
        return $this->hasMany(TitularCuentaBancaria::class, 'id_cuenta', 'id_cuenta');
    }

    public function movimientos()
    {
        return $this->hasMany(MovimientoBancario::class, 'id_cuenta', 'id_cuenta');
    }

    public function conciliaciones()
    {
        return $this->hasMany(ConciliacionBancaria::class, 'id_cuenta', 'id_cuenta');
    }

    // Métodos de pago que depositan en esta cuenta (Yape, POS, Transferencia, etc.)
    public function metodosPago()
    {
        return $this->hasMany(MetodoPago::class, 'id_cuenta', 'id_cuenta');
    }

    public function scopeActiva($query)
    {
        return $query->where('activa', true);
    }

    public function scopeByEmpresa($query, $empresaId)
    {
        return $query->where('id_empresa', $empresaId);
    }
}
