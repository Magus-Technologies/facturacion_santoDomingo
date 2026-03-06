<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ArqueoDiario extends Model
{
    protected $table = 'arqueos_diarios';
    protected $primaryKey = 'id_arqueo';
    public $timestamps = true;

    protected $fillable = [
        'id_caja',
        'id_empresa',
        'fecha_arqueo',
        'usuario_cierre',
        'usuario_validacion',
        'saldo_inicial',
        'total_ventas',
        'total_ingresos_manuales',
        'total_egresos',
        'total_teorico',
        'total_real',
        'diferencia',
        'tipo_diferencia',
        'ventas_por_metodo',
        'estado',
        'observaciones',
        'fecha_cierre',
        'fecha_validacion',
    ];

    protected $casts = [
        'saldo_inicial' => 'decimal:2',
        'total_ventas' => 'decimal:2',
        'total_ingresos_manuales' => 'decimal:2',
        'total_egresos' => 'decimal:2',
        'total_teorico' => 'decimal:2',
        'total_real' => 'decimal:2',
        'diferencia' => 'decimal:2',
        'ventas_por_metodo' => 'json',
        'fecha_arqueo' => 'date',
        'fecha_cierre' => 'datetime',
        'fecha_validacion' => 'datetime',
    ];

    public function caja()
    {
        return $this->belongsTo(Caja::class, 'id_caja', 'id_caja');
    }

    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    public function usuarioCierre()
    {
        return $this->belongsTo(User::class, 'usuario_cierre', 'id');
    }

    public function usuarioValidacion()
    {
        return $this->belongsTo(User::class, 'usuario_validacion', 'id');
    }
}
