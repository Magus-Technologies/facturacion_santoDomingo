---
name: nuevo-controller
description: Crea un controller Laravel REST + modelo + rutas + Form Request siguiendo exactamente los patrones del sistema Santo Domingo. Usar cuando el usuario pida crear un endpoint, recurso API, controller o modelo.
argument-hint: <NombreRecurso> [descripción opcional]
---

# Skill: Crear Nuevo Controller Laravel

Crea el backend completo para **$ARGUMENTS** siguiendo los patrones del sistema.

## ARCHIVOS A GENERAR

1. `app/Http/Controllers/Api/$NombreController.php` — Controller REST
2. `app/Models/$Nombre.php` — Modelo Eloquent con scopes
3. `app/Http/Requests/$NombreRequest.php` — Form Request con validación
4. Rutas en `routes/api.php` (dentro del middleware group existente)
5. Migración si es necesaria (usar skill `/nueva-migracion`)

## PASOS A SEGUIR

### 1. LEER EL CONTEXTO
Antes de generar código, leer:
- `routes/api.php` — Ver estructura de rutas y middleware group
- `app/Http/Controllers/Api/TransportistaController.php` — Referencia más reciente
- `app/Http/Controllers/BaseApiController.php` — Clase base
- `app/Traits/ApiResponseTrait.php` — Helpers de respuesta disponibles

### 2. MODELO (`app/Models/$Nombre.php`)

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class $Nombre extends Model
{
    protected $table = '$nombre_tabla';

    protected $fillable = [
        'id_empresa',
        // ... campos del modelo
        'estado',
    ];

    protected $casts = [
        'estado' => 'boolean',
    ];

    // Relaciones
    public function empresa(): BelongsTo
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    // Scopes obligatorios
    public function scopeByEmpresa($query, $empresaId)
    {
        return $query->where('id_empresa', $empresaId);
    }

    public function scopeActivo($query)
    {
        return $query->where('estado', true);
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
            'nombre' => [
                'required', 'string', 'max:255',
                'unique:$nombre_tabla,nombre' . ($id ? ",{$id},id_$nombre" : ''),
            ],
            // ... otras reglas
            'estado' => 'sometimes|boolean',
        ];
    }

    public function messages(): array
    {
        return [
            'nombre.required' => 'El nombre es obligatorio.',
            'nombre.unique' => 'Ya existe un registro con este nombre.',
        ];
    }
}
```

### 4. CONTROLLER (`app/Http/Controllers/Api/$NombreController.php`)

**CRÍTICO**: Extender `BaseApiController`, ubicar en namespace `Api`, usar helpers `$this->success()` / `$this->error()`.

```php
<?php

namespace App\Http\Controllers\Api;

use App\Models\$Nombre;
use App\Http\Requests\$NombreRequest;
use App\Http\Controllers\BaseApiController;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class $NombreController extends BaseApiController
{
    /**
     * GET /api/$nombre-ruta
     */
    public function index(Request $request): JsonResponse
    {
        $empresaId = $request->user()->id_empresa;

        $items = $Nombre::byEmpresa($empresaId)
            ->when($request->input('search'), function ($query, $search) {
                return $query->where('nombre', 'like', "%{$search}%");
            })
            ->when($request->input('estado') !== null, function ($query) use ($request) {
                return $query->where('estado', $request->boolean('estado'));
            })
            ->orderBy('nombre')
            ->paginate($request->input('per_page', 15));

        return $this->success($items);
    }

    /**
     * POST /api/$nombre-ruta
     */
    public function store($NombreRequest $request): JsonResponse
    {
        $item = $Nombre::create([
            ...$request->validated(),
            'id_empresa' => $request->user()->id_empresa,
        ]);

        return $this->success($item, '$Nombre creado exitosamente', 201);
    }

    /**
     * GET /api/$nombre-ruta/{id}
     */
    public function show(int $id, Request $request): JsonResponse
    {
        $item = $Nombre::findOrFail($id);

        return $this->success($item);
    }

    /**
     * PUT /api/$nombre-ruta/{id}
     */
    public function update(int $id, $NombreRequest $request): JsonResponse
    {
        $item = $Nombre::findOrFail($id);
        $item->update($request->validated());

        return $this->success($item, '$Nombre actualizado exitosamente');
    }

    /**
     * DELETE /api/$nombre-ruta/{id}
     */
    public function destroy(int $id, Request $request): JsonResponse
    {
        $item = $Nombre::findOrFail($id);
        $item->delete();

        return $this->success(null, '$Nombre eliminado exitosamente');
    }

    /**
     * GET /api/$nombre-ruta/activos  — listado simple sin paginar
     */
    public function activos(Request $request): JsonResponse
    {
        $items = $Nombre::byEmpresa($request->user()->id_empresa)
            ->activo()
            ->orderBy('nombre')
            ->get();

        return $this->success($items);
    }
}
```

### 5. RUTAS (`routes/api.php`)

Agregar dentro del grupo `middleware(['token.query', 'auth:sanctum'])` existente.

**Opción A — apiResource** (para CRUD estándar):
```php
// $NombreModulo
Route::get('$nombre-ruta/activos', [\App\Http\Controllers\Api\$NombreController::class, 'activos']);
Route::apiResource('$nombre-ruta', \App\Http\Controllers\Api\$NombreController::class)
    ->parameters(['$nombre-ruta' => 'id']);
```

**Opción B — rutas individuales con permisos** (cuando hay middleware por acción):
```php
// $NombreModulo
Route::get('$nombre-ruta/activos', [\App\Http\Controllers\Api\$NombreController::class, 'activos']);
Route::get('$nombre-ruta', [\App\Http\Controllers\Api\$NombreController::class, 'index'])->middleware('permission:$nombre.view');
Route::post('$nombre-ruta', [\App\Http\Controllers\Api\$NombreController::class, 'store'])->middleware('permission:$nombre.create');
Route::get('$nombre-ruta/{id}', [\App\Http\Controllers\Api\$NombreController::class, 'show'])->middleware('permission:$nombre.view');
Route::put('$nombre-ruta/{id}', [\App\Http\Controllers\Api\$NombreController::class, 'update'])->middleware('permission:$nombre.edit');
Route::delete('$nombre-ruta/{id}', [\App\Http\Controllers\Api\$NombreController::class, 'destroy'])->middleware('permission:$nombre.delete');
```

## HELPERS DE RESPUESTA DISPONIBLES (ApiResponseTrait)

| Método | Uso |
|--------|-----|
| `$this->success($data, $message, $status)` | Respuesta exitosa (default 200) |
| `$this->created($data, $message)` | Respuesta 201 |
| `$this->error($message, $status, $errors)` | Respuesta de error |
| `$this->notFound($message)` | 404 |
| `$this->unprocessable($message, $errors)` | 422 |

## FORMATO DE RESPUESTA API

El frontend espera `response.data.data` (axios), que corresponde a:
```json
{ "success": true, "message": "OK", "data": { ... } }
```

Para paginación Laravel, `response.data.data` es el objeto paginado completo (con `data`, `current_page`, `last_page`, etc.).

## REGLAS OBLIGATORIAS

1. **Namespace**: Siempre `App\Http\Controllers\Api\` (no `App\Http\Controllers\`)
2. **Clase base**: Extender `BaseApiController` (no `Controller`)
3. **Scopes en modelos**: `scopeByEmpresa()` y `scopeActivo()` son obligatorios en todo modelo con `id_empresa`
4. **Scoping empresa**: SIEMPRE filtrar por `id_empresa` en queries de index/store
5. **Sin try-catch genérico**: No envolver todo en try-catch. Laravel maneja excepciones en `bootstrap/app.php`. Solo capturar cuando haya lógica específica de recuperación
6. **Primary key**: Usar `id_$nombre` (no `id` genérico) a menos que sea una tabla pivot
7. **Ruta `/activos`**: Registrar ANTES del apiResource para evitar conflicto con `/{id}`
8. **Validación única**: Considerar `unique` en Form Request con exclusión del ID actual en updates
