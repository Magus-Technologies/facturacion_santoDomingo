<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
    use HasFactory;

    protected $table = 'clientes';
    protected $primaryKey = 'id_cliente';

    protected $fillable = [
        'documento',
        'tipo_doc',
        'datos',
        'direccion',
        'direccion2',
        'telefono',
        'telefono2',
        'email',
        'foto_url',
        'id_empresa',
        'ultima_venta',
        'total_venta',
        'ubigeo',
        'departamento',
        'provincia',
        'distrito',
    ];

    protected $casts = [
        'ultima_venta' => 'datetime',
        'total_venta' => 'decimal:2',
    ];

    /**
     * Relación con empresa
     */
    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    /**
     * Relación con ventas
     */
    public function ventas()
    {
        return $this->hasMany(Venta::class, 'id_cliente', 'id_cliente');
    }

    /**
     * Scope para buscar clientes
     */
    public function scopeSearch($query, $search)
    {
        return $query->where(function ($q) use ($search) {
            $q->where('documento', 'like', "%{$search}%")
                ->orWhere('datos', 'like', "%{$search}%")
                ->orWhere('email', 'like', "%{$search}%")
                ->orWhere('telefono', 'like', "%{$search}%");
        });
    }

    /**
     * Scope para filtrar por empresa
     */
    public function scopeByEmpresa($query, $empresaId)
    {
        return $query->where('id_empresa', $empresaId);
    }
}
