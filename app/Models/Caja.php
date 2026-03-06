<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Caja extends Model
{
    use HasFactory;

    protected $table = 'cajas';
    protected $primaryKey = 'id_caja';

    protected $fillable = [
        'id_empresa',
        'nombre',
        'descripcion',
        'id_responsable',
        'id_usuario',           // quien abre la caja
        'id_usuario_cierre',
        'id_usuario_validacion',
        'fecha_apertura',
        'fecha_cierre',
        'fecha_autorizacion_cierre',
        'saldo_inicial',
        'tipo_apertura',
        'total_teorico',
        'total_real',
        'diferencia',
        'tipo_cierre',
        'tipo_diferencia',
        'estado',
        'observaciones',
        'observaciones_cierre',
    ];

    protected $casts = [
        'fecha_apertura'            => 'datetime',
        'fecha_cierre'              => 'datetime',
        'fecha_autorizacion_cierre' => 'datetime',
        'saldo_inicial'             => 'decimal:2',
        'total_teorico'             => 'decimal:2',
        'total_real'                => 'decimal:2',
        'diferencia'                => 'decimal:2',
    ];

    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    public function responsable()
    {
        return $this->belongsTo(User::class, 'id_responsable', 'id');
    }

    public function usuarioApertura()
    {
        return $this->belongsTo(User::class, 'id_usuario', 'id');
    }

    public function usuarioCierre()
    {
        return $this->belongsTo(User::class, 'id_usuario_cierre', 'id');
    }

    public function usuarioValidacion()
    {
        return $this->belongsTo(User::class, 'id_usuario_validacion', 'id');
    }

    public function movimientos()
    {
        return $this->hasMany(MovimientoCaja::class, 'id_caja', 'id_caja');
    }

    public function aperturaBilletes()
    {
        return $this->hasMany(AperturaCajaBillete::class, 'id_caja', 'id_caja');
    }

    public function cierreBilletes()
    {
        return $this->hasMany(CierreCajaBillete::class, 'id_caja', 'id_caja');
    }

    public function auditorias()
    {
        return $this->hasMany(AuditoriaCaja::class, 'id_caja', 'id_caja');
    }

    public function arqueoDiario()
    {
        return $this->hasOne(ArqueoDiario::class, 'id_caja', 'id_caja');
    }

    public function metodosPago()
    {
        return $this->belongsToMany(MetodoPago::class, 'caja_metodos_pago', 'id_caja', 'id_metodo_pago', 'id_caja', 'id_metodo_pago')
            ->withPivot('activo')
            ->withTimestamps();
    }

    public function scopeAbierta($query)
    {
        return $query->where('estado', CajaEstadoEnum::Activa->value);
    }

    public function scopeByEmpresa($query, $empresaId)
    {
        return $query->where('id_empresa', $empresaId);
    }

    /**
     * Calcula el saldo teórico final sumando movimientos
     */
    public function calcularSaldoTeorico(): float
    {
        $ingresos = $this->movimientos()->where('tipo', 'Ingreso')->sum('monto');
        $egresos = $this->movimientos()->where('tipo', 'Egreso')->sum('monto');

        return (float) $this->saldo_inicial + $ingresos - $egresos;
    }
}
