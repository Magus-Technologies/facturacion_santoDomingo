<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BilleteraDigital extends Model
{
    use HasFactory;

    protected $table = 'billeteras_digitales';
    protected $primaryKey = 'id_billetera';

    protected $fillable = [
        'id_empresa',
        'id_metodo_pago',
        'id_banco',
        'numero_cuenta',
        'titular',
        'documento_tipo',
        'documento_numero',
        'saldo',
        'activa',
    ];

    protected $casts = [
        'saldo' => 'decimal:2',
        'activa' => 'boolean',
    ];

    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    public function metodoPago()
    {
        return $this->belongsTo(MetodoPago::class, 'id_metodo_pago', 'id_metodo_pago');
    }

    public function banco()
    {
        return $this->belongsTo(Banco::class, 'id_banco', 'id_banco');
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
