<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    protected $table = 'productos';
    protected $primaryKey = 'id_producto';
    
    protected $fillable = [
        'codigo',
        'cod_barra',
        'nombre',
        'descripcion',
        'precio',
        'oferta',
        'costo',
        'precio_mayor',
        'precio_menor',
        'precio_unidad',
        'cantidad',
        'stock_minimo',
        'stock_maximo',
        'id_empresa',
        'categoria_id',
        'marca_id',
        'cod_marca',
        'unidad_id',
        'almacen',
        'codsunat',
        'usar_barra',
        'usar_multiprecio',
        'moneda',
        'estado',
        'imagen',
        'ultima_salida',
        'fecha_ultimo_ingreso',
        'es_destacado',
        'en_oferta',
        'precio_oferta',
        'tipo_descuento',
        'valor_descuento',
        'valoracion',
    ];

    protected $casts = [
        'precio' => 'decimal:2',
        'costo' => 'decimal:2',
        'precio_mayor' => 'decimal:2',
        'precio_menor' => 'decimal:2',

        'precio_unidad' => 'decimal:2',
        'cantidad' => 'integer',
        'stock_minimo' => 'integer',
        'stock_maximo' => 'integer',
        'ultima_salida' => 'date',
        'fecha_registro' => 'datetime',
        'fecha_ultimo_ingreso' => 'datetime',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    // Relaciones
    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    public function categoria()
    {
        return $this->belongsTo(Categoria::class, 'categoria_id');
    }

    public function unidad()
    {
        return $this->belongsTo(Unidad::class, 'unidad_id');
    }

    public function marca()
    {
        return $this->belongsTo(Marca::class, 'marca_id', 'cod_marca');
    }

    public function ofertas()
    {
        return $this->hasMany(Oferta::class, 'id_producto', 'id_producto');
    }

    public function ofertaVigente()
    {
        return $this->hasOne(Oferta::class, 'id_producto', 'id_producto')
            ->where('estado', '1')
            ->where('fecha_inicio', '<=', now())
            ->where(function ($q) {
                $q->whereNull('fecha_fin')
                  ->orWhere('fecha_fin', '>=', now());
            });
    }

    // Scopes
    public function scopeAlmacen($query, $almacen)
    {
        return $query->where('almacen', $almacen);
    }

    public function scopeActivo($query)
    {
        return $query->where('estado', '1');
    }

    public function scopeEmpresa($query, $idEmpresa)
    {
        return $query->where('id_empresa', $idEmpresa);
    }
}
