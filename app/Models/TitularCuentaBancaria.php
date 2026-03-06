<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TitularCuentaBancaria extends Model
{
    protected $table = 'titulares_cuenta_bancaria';
    protected $primaryKey = 'id_titular';

    protected $fillable = [
        'id_cuenta',
        'nombre',
        'documento_tipo',
        'documento_numero',
        'titular_principal',
    ];

    protected $casts = [
        'titular_principal' => 'boolean',
    ];

    public function cuenta()
    {
        return $this->belongsTo(CuentaBancaria::class, 'id_cuenta', 'id_cuenta');
    }
}
