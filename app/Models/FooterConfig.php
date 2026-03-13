<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FooterConfig extends Model
{
    protected $table = 'footer_configs';

    protected $fillable = [
        'slogan',
        'subtitulo',
        'boton_texto',
        'imagen',
    ];
}
