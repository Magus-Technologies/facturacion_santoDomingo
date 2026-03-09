<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductoExclusivo extends Model
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

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'producto_id', 'id_producto');
    }
}
