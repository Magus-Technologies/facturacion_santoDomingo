<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Oferta extends Model
{
    protected $table = 'ofertas';
    protected $primaryKey = 'id';

    protected $fillable = [
        'id_producto',
        'id_empresa',
        'tipo',
        'valor',
        'precio_final',
        'fecha_inicio',
        'fecha_fin',
        'estado',
        'descripcion',
    ];

    protected $casts = [
        'valor' => 'decimal:2',
        'precio_final' => 'decimal:2',
        'fecha_inicio' => 'datetime',
        'fecha_fin' => 'datetime',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    // Relaciones
    public function producto()
    {
        return $this->belongsTo(Producto::class, 'id_producto', 'id_producto');
    }

    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    // Scopes
    public function scopeActiva($query)
    {
        return $query->where('estado', '1');
    }

    public function scopeVigente($query)
    {
        return $query->where('estado', '1')
            ->where('fecha_inicio', '<=', now())
            ->where(function ($q) {
                $q->whereNull('fecha_fin')
                  ->orWhere('fecha_fin', '>=', now());
            });
    }

    public function scopePorcentaje($query)
    {
        return $query->where('tipo', 'porcentaje');
    }

    public function scopeMonto($query)
    {
        return $query->where('tipo', 'monto');
    }

    // Métodos
    public function calcularPrecioFinal(float $precioBase): float
    {
        if ($this->tipo === 'porcentaje') {
            return $precioBase * (1 - $this->valor / 100);
        }
        return max(0, $precioBase - $this->valor);
    }
}
