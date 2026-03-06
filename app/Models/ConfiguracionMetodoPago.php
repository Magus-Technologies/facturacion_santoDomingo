<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ConfiguracionMetodoPago extends Model
{
    use HasFactory;

    protected $table = 'configuracion_metodos_pago';
    protected $primaryKey = 'id_config';

    protected $fillable = [
        'id_empresa',
        'id_metodo_pago',
        'habilitado',
        'comision',
        'limite_minimo',
        'limite_maximo',
        'requiere_comprobante',
        'requiere_referencia',
    ];

    protected $casts = [
        'habilitado' => 'boolean',
        'comision' => 'decimal:2',
        'limite_minimo' => 'decimal:2',
        'limite_maximo' => 'decimal:2',
        'requiere_comprobante' => 'boolean',
        'requiere_referencia' => 'boolean',
    ];

    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    public function metodoPago()
    {
        return $this->belongsTo(MetodoPago::class, 'id_metodo_pago', 'id_metodo_pago');
    }

    public function scopeHabilitado($query)
    {
        return $query->where('habilitado', true);
    }

    public function scopeByEmpresa($query, $empresaId)
    {
        return $query->where('id_empresa', $empresaId);
    }
}
