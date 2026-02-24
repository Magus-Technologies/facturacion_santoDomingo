<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'rol_id',
        'id_empresa',
        'num_doc',
        'nombres',
        'apellidos',
        'telefono',
        'estado',
        'foto_perfil',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    /**
     * Relación con empresa
     */
    public function empresa()
    {
        return $this->belongsTo(\App\Models\Empresa::class, 'id_empresa', 'id_empresa');
    }

    /**
     * Relación con rol
     */
    public function rol()
    {
        return $this->belongsTo(\App\Models\Rol::class, 'rol_id', 'rol_id');
    }

    /**
     * Verificar si el usuario tiene un permiso específico
     */
    public function hasPermission($permissionName)
    {
        // Admin (rol_id = 1) tiene todos los permisos
        if ($this->rol_id == 1) {
            return true;
        }
        
        return $this->rol && $this->rol->hasPermission($permissionName);
    }

    /**
     * Verificar si el usuario tiene alguno de los permisos
     */
    public function hasAnyPermission(array $permissions)
    {
        // Admin (rol_id = 1) tiene todos los permisos
        if ($this->rol_id == 1) {
            return true;
        }
        
        return $this->rol && $this->rol->hasAnyPermission($permissions);
    }

    /**
     * Verificar si el usuario tiene todos los permisos
     */
    public function hasAllPermissions(array $permissions)
    {
        // Admin (rol_id = 1) tiene todos los permisos
        if ($this->rol_id == 1) {
            return true;
        }
        
        return $this->rol && $this->rol->hasAllPermissions($permissions);
    }

    /**
     * Obtener todos los permisos del usuario
     */
    public function getPermissions()
    {
        // Admin (rol_id = 1) tiene todos los permisos
        if ($this->rol_id == 1) {
            return \App\Models\Permission::all();
        }
        
        return $this->rol ? $this->rol->permissions : collect();
    }
}
