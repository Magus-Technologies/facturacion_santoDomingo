---
name: nuevo-controller
description: Crea un controller Laravel REST + modelo + rutas + Form Request siguiendo exactamente los patrones del sistema Santo Domingo. Usar cuando el usuario pida crear un endpoint, recurso API, controller o modelo.
argument-hint: <NombreRecurso> [descripción opcional]
allowed-tools: Read, Glob, Grep, Write, Edit, Bash
---

# Skill: Crear Nuevo Controller Laravel

Crea el backend completo para **$ARGUMENTS** siguiendo los patrones del sistema.

## ARCHIVOS A GENERAR

1. `app/Http/Controllers/$NombreController.php` — Controller REST
2. `app/Models/$Nombre.php` — Modelo Eloquent
3. `app/Http/Requests/$NombreRequest.php` — Form Request con validación
4. Rutas en `routes/api.php` (agregar al grupo existente)
5. Migración si es necesaria (usar skill `/nueva-migracion`)

## PASOS A SEGUIR

### 1. LEER EL CONTEXTO
Antes de generar código, leer:
- `routes/api.php` — Ver estructura de rutas existentes y middleware
- Un controller existente similar para referencia (ej. `app/Http/Controllers/ClientesController.php`)
- El modelo principal del sistema para ver el scope de empresa

### 2. MODELO (`app/Models/$Nombre.php`)
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class $Nombre extends Model
{
    protected $table = '$nombre_tabla';
    protected $primaryKey = 'id_$nombre';

    protected $fillable = [
        'id_empresa',
        // ... campos del modelo
    ];

    protected $casts = [
        'activo' => 'boolean',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    // Relaciones
    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }
}
```

### 3. FORM REQUEST (`app/Http/Requests/$NombreRequest.php`)
```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class $NombreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $id = $this->route('id');

        return [
            'nombre' => 'required|string|max:255|unique:$nombre_tabla,nombre' . ($id ? ",{$id},id_$nombre" : ''),
            // ... reglas de validación
        ];
    }

    public function messages(): array
    {
        return [
            'nombre.required' => 'El nombre es obligatorio.',
            'nombre.unique' => 'Ya existe un registro con este nombre.',
            // ...
        ];
    }
}
```

### 4. CONTROLLER (`app/Http/Controllers/$NombreController.php`)
```php
<?php

namespace App\Http\Controllers;

use App\Models\$Nombre;
use App\Http\Requests\$NombreRequest;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class $NombreController extends Controller
{
    /**
     * GET /api/$nombre-ruta
     * Lista todos los registros de la empresa activa
     */
    public function index(Request $request): JsonResponse
    {
        try {
            $user = $request->user();
            $idEmpresa = $user->id_empresa;

            $items = $Nombre::where('id_empresa', $idEmpresa)
                ->orderBy('created_at', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $items,
            ]);
        } catch (\Exception $e) {
            Log::error('Error listando $nombre: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener los datos.',
            ], 500);
        }
    }

    /**
     * POST /api/$nombre-ruta
     */
    public function store($NombreRequest $request): JsonResponse
    {
        try {
            $user = $request->user();
            $data = $request->validated();
            $data['id_empresa'] = $user->id_empresa;

            $item = DB::transaction(function () use ($data) {
                return $Nombre::create($data);
            });

            return response()->json([
                'success' => true,
                'message' => '$Nombre creado correctamente.',
                'data' => $item,
            ], 201);
        } catch (\Exception $e) {
            Log::error('Error creando $nombre: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al crear el registro.',
            ], 500);
        }
    }

    /**
     * GET /api/$nombre-ruta/{id}
     */
    public function show(Request $request, $id): JsonResponse
    {
        try {
            $user = $request->user();
            $item = $Nombre::where('id_$nombre', $id)
                ->where('id_empresa', $user->id_empresa)
                ->firstOrFail();

            return response()->json([
                'success' => true,
                'data' => $item,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Registro no encontrado.',
            ], 404);
        }
    }

    /**
     * PUT /api/$nombre-ruta/{id}
     */
    public function update($NombreRequest $request, $id): JsonResponse
    {
        try {
            $user = $request->user();
            $item = $Nombre::where('id_$nombre', $id)
                ->where('id_empresa', $user->id_empresa)
                ->firstOrFail();

            $item->update($request->validated());

            return response()->json([
                'success' => true,
                'message' => '$Nombre actualizado correctamente.',
                'data' => $item->fresh(),
            ]);
        } catch (\Exception $e) {
            Log::error('Error actualizando $nombre: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar el registro.',
            ], 500);
        }
    }

    /**
     * DELETE /api/$nombre-ruta/{id}
     */
    public function destroy(Request $request, $id): JsonResponse
    {
        try {
            $user = $request->user();
            $item = $Nombre::where('id_$nombre', $id)
                ->where('id_empresa', $user->id_empresa)
                ->firstOrFail();

            $item->delete();

            return response()->json([
                'success' => true,
                'message' => '$Nombre eliminado correctamente.',
            ]);
        } catch (\Exception $e) {
            Log::error('Error eliminando $nombre: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar el registro.',
            ], 500);
        }
    }
}
```

### 5. RUTAS (`routes/api.php`)
Agregar dentro del grupo `middleware(['auth:sanctum'])` existente:
```php
// $NombreModulo
Route::prefix('$nombre-ruta')->group(function () {
    Route::get('/', [$NombreController::class, 'index']);
    Route::post('/', [$NombreController::class, 'store']);
    Route::get('/{id}', [$NombreController::class, 'show']);
    Route::put('/{id}', [$NombreController::class, 'update']);
    Route::delete('/{id}', [$NombreController::class, 'destroy']);
});
```

## REGLAS OBLIGATORIAS

1. **Scoping por empresa**: SIEMPRE filtrar `->where('id_empresa', $user->id_empresa)` en todas las queries
2. **Formato respuesta**:
   - Éxito lista: `{ success: true, data: [...] }`
   - Éxito crear/actualizar: `{ success: true, message: '...', data: {...} }`
   - Éxito eliminar: `{ success: true, message: '...' }`
   - Error: `{ success: false, message: '...' }` con código HTTP apropiado
3. **Transacciones DB**: Usar `DB::transaction()` en store/update con múltiples operaciones
4. **Logging**: Usar `Log::error()` en todos los catch
5. **Primary key**: Siempre `id_$nombre` (no `id` genérico)
6. **Auth middleware**: Todos los endpoints van bajo `auth:sanctum`
7. **Permiso middleware**: Si el módulo tiene permisos, agregar `->middleware('permission:$nombre.action')`
8. **Nunca** devolver el stack trace al frontend en producción
