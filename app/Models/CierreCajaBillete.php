<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CierreCajaBillete extends Model
{
    protected $table = 'cierre_caja_billetes';
    protected $primaryKey = 'id_cierre_billete';
    public $timestamps = true;

    protected $fillable = [
        'id_caja',
        'id_denominacion',
        'cantidad',
        'subtotal',
    ];

    protected $casts = [
        'subtotal' => 'decimal:2',
    ];

    public function caja()
    {
        return $this->belongsTo(Caja::class, 'id_caja', 'id_caja');
    }

    public function denominacion()
    {
        return $this->belongsTo(DenominacionBillete::class, 'id_denominacion', 'id_denominacion');
    }
}
