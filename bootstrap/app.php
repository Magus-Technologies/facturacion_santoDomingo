<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->statefulApi();

        // Excluir rutas API del middleware CSRF
        $middleware->validateCsrfTokens(except: [
            'api/*',
        ]);

        // Registrar middleware de permisos
        $middleware->alias([
            'permission' => \App\Http\Middleware\CheckPermission::class,
            'token.query' => \App\Http\Middleware\TokenFromQuery::class,
        ]);

        // Habilitar CORS para todas las rutas API
        $middleware->append(\Illuminate\Http\Middleware\HandleCors::class);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        // Dominio Caja: respuestas JSON automáticas sin try/catch en controladores
        $exceptions->render(function (\App\Exceptions\CajaException $e, $request) {
            if ($request->expectsJson() || $request->is('api/*')) {
                return response()->json([
                    'success' => false,
                    'message' => $e->jsonMessage(),
                ], $e->httpStatus());
            }
        });

        // ModelNotFoundException → 404 JSON en rutas API
        $exceptions->render(function (\Illuminate\Database\Eloquent\ModelNotFoundException $e, $request) {
            if ($request->expectsJson() || $request->is('api/*')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Recurso no encontrado.',
                ], 404);
            }
        });
    })->create();
