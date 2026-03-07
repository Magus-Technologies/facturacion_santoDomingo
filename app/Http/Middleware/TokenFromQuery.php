<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class TokenFromQuery
{
    public function handle(Request $request, Closure $next)
    {
        if ($request->has('token')) {
            // Asegurar que Laravel no redirija a /login en caso de error de auth
            $request->headers->set('Accept', 'application/json');
            
            if (!$request->bearerToken()) {
                $request->headers->set('Authorization', 'Bearer ' . $request->query('token'));
            }
        }

        return $next($request);
    }
}
