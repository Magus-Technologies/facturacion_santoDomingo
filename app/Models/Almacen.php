<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Almacen extends Model
{
    protected $table = 'almacenes';

    protected $fillable = [
        'nombre',
        'descripcion',
        'id_padre',
        'es_principal',
        'id_empresa',
        'estado',
    ];

    protected $casts = [
        'es_principal' => 'boolean',
    ];

    public function padre(): BelongsTo
    {
        return $this->belongsTo(Almacen::class, 'id_padre');
    }

    public function hijos(): HasMany
    {
        return $this->hasMany(Almacen::class, 'id_padre');
    }

    public function empresa(): BelongsTo
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    public function productos(): HasMany
    {
        return $this->hasMany(Producto::class, 'almacen');
    }

    public function scopeActivo($query)
    {
        return $query->where('estado', '1');
    }

    public function scopeEmpresa($query, $idEmpresa)
    {
        return $query->where('id_empresa', $idEmpresa);
    }

    public function scopePrincipal($query)
    {
        return $query->where('es_principal', true);
    }
}
