<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BannerInferior extends Model
{
    protected $fillable = ['url', 'imagen', 'estado'];

    public function scopeActivos($query)
    {
        return $query->where('estado', '1');
    }

    /**
     * Obtiene la URL completa de la imagen
     */
    public function getImagenUrlAttribute()
    {
        if ($this->imagen && str_starts_with($this->imagen, 'http')) {
            return $this->imagen;
        }
        
        if ($this->imagen) {
            return asset('storage/' . $this->imagen);
        }
        
        return null;
    }
}
