<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AuditoriaCaja extends Model
{
    protected $table = 'auditoria_cajas';
    protected $primaryKey = 'id_auditoria';
    public $timestamps = true;

    protected $fillable = [
        'id_caja',
        'id_usuario',
        'accion',
        'detalles',
        'ip_address',
        'user_agent',
    ];

    public function caja()
    {
        return $this->belongsTo(Caja::class, 'id_caja', 'id_caja');
    }

    public function usuario()
    {
        return $this->belongsTo(User::class, 'id_usuario', 'id');
    }
}
