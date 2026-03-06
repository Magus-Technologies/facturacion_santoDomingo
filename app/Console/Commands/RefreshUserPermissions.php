<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;
use Illuminate\Support\Facades\Cache;

class RefreshUserPermissions extends Command
{
    protected $signature = 'permissions:refresh {email?}';
    protected $description = 'Recarga los permisos en caché para un usuario o todos los usuarios';

    public function handle()
    {
        $email = $this->argument('email');

        if ($email) {
            $user = User::where('email', $email)->first();
            if (!$user) {
                $this->error("Usuario con email {$email} no encontrado");
                return 1;
            }
            
            // Limpiar caché de permisos del usuario
            Cache::forget("user_permissions_{$user->id}");
            $this->info("✓ Permisos recargados para: {$user->email}");
        } else {
            // Limpiar caché de todos los usuarios
            $users = User::all();
            foreach ($users as $user) {
                Cache::forget("user_permissions_{$user->id}");
            }
            $this->info("✓ Permisos recargados para todos los usuarios ({$users->count()})");
        }

        return 0;
    }
}
