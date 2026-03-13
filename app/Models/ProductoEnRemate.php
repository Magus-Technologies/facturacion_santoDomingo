<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductoEnRemate extends Model
{
    use HasFactory;

    protected $table = 'productos_exclusivos';
    protected $primaryKey = 'id_exclusivo';

    protected $fillable = [
        'tab_name',
        'imagen',
        'producto_id',
        'orden',
        'estado'
    ];

    public function __construct(array $attributes = [])
    {
        parent::__construct($attributes);
        $this->attributes['tab_name'] = 'productos_en_remate';
    }

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'producto_id', 'id_producto');
    }
}

