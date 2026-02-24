<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class GuiaRemisionDetalle extends Model
{
    protected $table = 'guia_remision_detalles';

    protected $fillable = [
        'id_guia',
        'id_producto',
        'codigo',
        'descripcion',
        'cantidad',
        'unidad',
    ];

    protected $casts = [
        'cantidad' => 'decimal:3',
    ];

    public function guia(): BelongsTo
    {
        return $this->belongsTo(GuiaRemision::class, 'id_guia', 'id');
    }

    public function producto(): BelongsTo
    {
        return $this->belongsTo(Producto::class, 'id_producto', 'id_producto');
    }
}
