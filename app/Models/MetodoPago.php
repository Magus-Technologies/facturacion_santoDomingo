<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MetodoPago extends Model
{
    use HasFactory;

    protected $table = 'metodos_pago';
    protected $primaryKey = 'id_metodo_pago';

    protected $fillable = [
        'nombre',
        'codigo',
        'descripcion',
        'tipo',
        'id_banco',
        'id_cuenta',
        'es_efectivo',
        'requiere_referencia',
        'requiere_comprobante',
        'activo',
    ];

    protected $casts = [
        'requiere_referencia' => 'boolean',
        'requiere_comprobante' => 'boolean',
        'es_efectivo' => 'boolean',
        'activo' => 'boolean',
    ];

    public function banco()
    {
        return $this->belongsTo(Banco::class, 'id_banco', 'id_banco');
    }

    // Cuenta bancaria destino donde llegan los pagos de este método
    public function cuentaBancaria()
    {
        return $this->belongsTo(CuentaBancaria::class, 'id_cuenta', 'id_cuenta');
    }

    public function configuraciones()
    {
        return $this->hasMany(ConfiguracionMetodoPago::class, 'id_metodo_pago', 'id_metodo_pago');
    }

    public function billeterasDigitales()
    {
        return $this->hasMany(BilleteraDigital::class, 'id_metodo_pago', 'id_metodo_pago');
    }

    public function cajas()
    {
        return $this->belongsToMany(Caja::class, 'caja_metodos_pago', 'id_metodo_pago', 'id_caja', 'id_metodo_pago', 'id_caja')
            ->withPivot('activo')
            ->withTimestamps();
    }

    public function scopeActivo($query)
    {
        return $query->where('activo', true);
    }
}
