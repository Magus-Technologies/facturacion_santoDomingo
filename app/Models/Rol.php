<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Rol extends Model
{
    use HasFactory;

    protected $table = 'roles';
    protected $primaryKey = 'rol_id';

    protected $fillable = [
        'nombre',
        'ver_precios',
        'puede_eliminar',
    ];

    protected $casts = [
        'ver_precios' => 'boolean',
        'puede_eliminar' => 'boolean',
    ];

    /**
     * Relación con usuarios
     */
    public function usuarios()
    {
        return $this->hasMany(User::class, 'rol_id', 'rol_id');
    }

    /**
     * Relación con permisos (muchos a muchos)
     */
    public function permissions()
    {
        return $this->belongsToMany(
            Permission::class,
            'role_permission',
            'rol_id',
            'permission_id'
        );
    }

    /**
     * Verificar si el rol tiene un permiso específico
     */
    public function hasPermission($permissionName)
    {
        return $this->permissions()->where('name', $permissionName)->exists();
    }

    /**
     * Verificar si el rol tiene alguno de los permisos
     */
    public function hasAnyPermission(array $permissions)
    {
        return $this->permissions()->whereIn('name', $permissions)->exists();
    }

    /**
     * Verificar si el rol tiene todos los permisos
     */
    public function hasAllPermissions(array $permissions)
    {
        return $this->permissions()->whereIn('name', $permissions)->count() === count($permissions);
    }
}
