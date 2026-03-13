<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Marca extends Model
{
    protected $table      = 'marcra_productos';
    protected $primaryKey = 'cod_marca';
    protected $keyType    = 'string';
    public    $incrementing = false;

    protected $fillable = [
        'cod_marca',
        'nombre_marca',
        'descripcion',
        'imagen',
        'estado',
    ];

    protected $appends = ['imagen_url'];

    public function getImagenUrlAttribute(): ?string
    {
        if (!$this->imagen) return null;
        if (str_starts_with($this->imagen, 'http')) return $this->imagen;
        return asset('storage/' . $this->imagen);
    }
}
