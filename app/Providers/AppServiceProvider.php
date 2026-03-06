<?php

namespace App\Providers;

use App\Services\CajaArqueoService;
use App\Services\CajaService;
use App\Services\CajaSesionService;
use App\Services\Contracts\CajaArqueoServiceInterface;
use App\Services\Contracts\CajaServiceInterface;
use App\Services\Contracts\CajaSesionServiceInterface;
use App\Services\SunatService;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        $this->app->singleton(SunatService::class);

        // Caja: bind interfaces → implementaciones concretas
        $this->app->bind(CajaServiceInterface::class,       CajaService::class);
        $this->app->bind(CajaSesionServiceInterface::class, CajaSesionService::class);
        $this->app->bind(CajaArqueoServiceInterface::class, CajaArqueoService::class);
    }

    public function boot(): void {}
}
