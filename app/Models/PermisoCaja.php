<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PermisoCaja extends Model
{
    protected $table = 'permisos_caja';
    protected $primaryKey = 'id_permiso';
    public $timestamps = true;

    protected $fillable = [
        'id_usuario',
        'id_empresa',
        'puede_abrir_caja',
        'puede_cerrar_caja',
        'puede_autorizar_cierre',
        'puede_rechazar_cierre',
        'puede_registrar_movimientos',
        'puede_ver_reportes',
    ];

    protected $casts = [
        'puede_abrir_caja' => 'boolean',
        'puede_cerrar_caja' => 'boolean',
        'puede_autorizar_cierre' => 'boolean',
        'puede_rechazar_cierre' => 'boolean',
        'puede_registrar_movimientos' => 'boolean',
        'puede_ver_reportes' => 'boolean',
    ];

    public function usuario()
    {
        return $this->belongsTo(User::class, 'id_usuario', 'id');
    }

    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }
}
