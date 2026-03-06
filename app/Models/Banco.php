<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Banco extends Model
{
    use HasFactory;

    protected $table = 'bancos';
    protected $primaryKey = 'id_banco';

    protected $fillable = [
        'nombre',
        'codigo_sunat',
        'codigo_swift',
        'telefono',
        'email',
        'website',
        'activo',
    ];

    protected $casts = [
        'activo' => 'boolean',
    ];

    public function cuentasBancarias()
    {
        return $this->hasMany(CuentaBancaria::class, 'id_banco', 'id_banco');
    }

    public function metodosP_ago()
    {
        return $this->hasMany(MetodoPago::class, 'id_banco', 'id_banco');
    }

    public function billeterasDigitales()
    {
        return $this->hasMany(BilleteraDigital::class, 'id_banco', 'id_banco');
    }

    public function scopeActivo($query)
    {
        return $query->where('activo', true);
    }
}
