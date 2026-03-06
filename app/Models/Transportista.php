<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Transportista extends Model
{
    protected $table = 'transportistas';

    protected $fillable = [
        'id_empresa',
        'tipo_documento',
        'numero_documento',
        'razon_social',
        'nombre_comercial',
        'numero_mtc',
        'telefono',
        'email',
        'direccion',
        'estado',
    ];

    protected $casts = [
        'estado' => 'boolean',
    ];

    public function empresa(): BelongsTo
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    public function guiasRemision(): HasMany
    {
        return $this->hasMany(GuiaRemision::class, 'id_transportista', 'id');
    }

    public function scopeActivo($query)
    {
        return $query->where('estado', true);
    }

    public function scopeByEmpresa($query, $empresaId)
    {
        return $query->where('id_empresa', $empresaId);
    }
}
