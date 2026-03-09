<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GrupoSeleccion extends Model
{
    protected $table = 'grupo_seleccion';
    protected $primaryKey = 'id_seleccion';

    protected $fillable = [
        'nombre_cate',
        'codi_categoria',
        'imagen',
        'estado'
    ];

    protected $appends = ['imagen_url'];

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
