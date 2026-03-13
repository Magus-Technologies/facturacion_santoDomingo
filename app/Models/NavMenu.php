<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class NavMenu extends Model
{
    protected $table = 'nav_menu';

    protected $fillable = [
        'label',
        'url',
        'parent_id',
        'orden',
        'estado',
        'target',
    ];

    public function hijos(): HasMany
    {
        return $this->hasMany(NavMenu::class, 'parent_id')->orderBy('orden');
    }

    public function padre(): BelongsTo
    {
        return $this->belongsTo(NavMenu::class, 'parent_id');
    }
}
