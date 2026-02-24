<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Permission extends Model
{
    use HasFactory;

    protected $table = 'permissions';
    protected $primaryKey = 'permission_id';

    protected $fillable = [
        'name',
        'display_name',
        'module',
        'action',
        'description',
    ];

    /**
     * Relación con roles (muchos a muchos)
     */
    public function roles()
    {
        return $this->belongsToMany(
            Rol::class,
            'role_permission',
            'permission_id',
            'rol_id'
        );
    }
}
