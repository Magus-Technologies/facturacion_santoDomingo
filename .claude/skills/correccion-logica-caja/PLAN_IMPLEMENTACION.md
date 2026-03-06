# Plan de Implementación - Corrección de Lógica de Caja

## Resumen Ejecutivo

Se requiere refactorizar la lógica de "apertura de caja" de un modelo de **activación permanente** a un modelo de **sesiones diarias**.

**Impacto**: Medio-Alto
**Complejidad**: Media
**Tiempo estimado**: 2-3 días

---

## 1. Análisis Detallado del Problema

### 1.1 Problema Actual

```
Tabla: cajas
┌─────────────────────────────────────────────────────┐
│ id_caja │ nombre │ id_responsable │ estado │ ...    │
├─────────────────────────────────────────────────────┤
│    1    │ Caja 1 │      5         │ Abierta│        │
│    2    │ Caja 2 │      6         │ Inactiva       │
│    3    │ Caja 3 │      7         │ Cerrada│        │
└─────────────────────────────────────────────────────┘

Problema:
- Caja 1 está "Abierta" permanentemente
- No se puede abrir nuevamente mañana
- El estado es confuso (¿Abierta hoy? ¿Siempre?)
- No hay histórico de sesiones
```

### 1.2 Solución Propuesta

```
Tabla: cajas (Configuración)
┌──────────────────────────────────────────────────────┐
│ id_caja │ nombre │ id_responsable │ activo │ ...     │
├──────────────────────────────────────────────────────┤
│    1    │ Caja 1 │      5         │  true │         │
│    2    │ Caja 2 │      6         │  true │         │
│    3    │ Caja 3 │      7         │  false│         │
└──────────────────────────────────────────────────────┘

Tabla: sesiones_caja (Operación diaria)
┌────────────────────────────────────────────────────────────────┐
│ id_sesion │ id_caja │ fecha │ estado │ saldo_inicial │ ...     │
├────────────────────────────────────────────────────────────────┤
│     1     │    1    │ 2026-03-04 │ Cerrada │   1000.00 │      │
│     2     │    1    │ 2026-03-05 │ Abierta │   1000.00 │      │
│     3     │    2    │ 2026-03-04 │ Cerrada │    500.00 │      │
└────────────────────────────────────────────────────────────────┘

Beneficio:
- Caja 1 puede tener múltiples sesiones
- Cada sesión es un día diferente
- Histórico completo
- Estado claro (Abierta = hoy, Cerrada = ayer)
```

---

## 2. Cambios en Base de Datos

### 2.1 Nueva Migración

```php
// database/migrations/2026_03_05_refactor_cajas_to_sessions.php

Schema::create('sesiones_caja', function (Blueprint $table) {
    $table->id('id_sesion');
    $table->unsignedBigInteger('id_caja');
    $table->unsignedBigInteger('id_empresa');
    
    // Apertura
    $table->dateTime('fecha_apertura')->nullable();
    $table->unsignedBigInteger('id_usuario_apertura')->nullable();
    $table->decimal('saldo_inicial', 12, 2)->default(0);
    $table->string('tipo_apertura')->default('monto_fijo'); // monto_fijo, billetes
    
    // Cierre
    $table->dateTime('fecha_cierre')->nullable();
    $table->unsignedBigInteger('id_usuario_cierre')->nullable();
    $table->decimal('saldo_final', 12, 2)->nullable();
    $table->string('tipo_cierre')->nullable();
    
    // Validación
    $table->dateTime('fecha_validacion')->nullable();
    $table->unsignedBigInteger('id_usuario_validacion')->nullable();
    
    // Cálculos
    $table->decimal('total_teorico', 12, 2)->nullable();
    $table->decimal('total_real', 12, 2)->nullable();
    $table->decimal('diferencia', 12, 2)->nullable();
    $table->string('tipo_diferencia')->nullable(); // exacto, sobrante, faltante
    
    // Estado
    $table->enum('estado', ['Abierta', 'Cerrada', 'Validada', 'Rechazada'])->default('Abierta');
    
    // Observaciones
    $table->text('observaciones')->nullable();
    $table->text('observaciones_cierre')->nullable();
    
    // Auditoría
    $table->timestamps();
    $table->softDeletes();
    
    // Índices
    $table->foreign('id_caja')->references('id_caja')->on('cajas');
    $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
    $table->foreign('id_usuario_apertura')->references('id')->on('users');
    $table->foreign('id_usuario_cierre')->references('id')->on('users');
    $table->foreign('id_usuario_validacion')->references('id')->on('users');
    
    $table->index(['id_caja', 'fecha_apertura']);
    $table->index(['id_empresa', 'estado']);
});

// Modificar tabla cajas
Schema::table('cajas', function (Blueprint $table) {
    // Cambiar estado a activo
    $table->dropColumn('estado');
    $table->boolean('activo')->default(true)->after('id_responsable');
    
    // Remover campos de sesión (ahora en sesiones_caja)
    $table->dropColumn([
        'id_usuario',
        'id_usuario_cierre',
        'id_usuario_validacion',
        'fecha_apertura',
        'fecha_cierre',
        'fecha_autorizacion_cierre',
        'saldo_inicial',
        'tipo_apertura',
        'total_teorico',
        'total_real',
        'diferencia',
        'tipo_cierre',
        'tipo_diferencia',
        'observaciones',
        'observaciones_cierre',
    ]);
});
```

### 2.2 Migración de Datos

```php
// En la misma migración, después de crear tabla

// Copiar datos de cajas a sesiones_caja
DB::statement('
    INSERT INTO sesiones_caja (
        id_caja, id_empresa, fecha_apertura, id_usuario_apertura,
        saldo_inicial, tipo_apertura, fecha_cierre, id_usuario_cierre,
        saldo_final, tipo_cierre, fecha_validacion, id_usuario_validacion,
        total_teorico, total_real, diferencia, tipo_diferencia,
        estado, observaciones, observaciones_cierre, created_at, updated_at
    )
    SELECT
        id_caja, id_empresa, fecha_apertura, id_usuario,
        saldo_inicial, tipo_apertura, fecha_cierre, id_usuario_cierre,
        total_real, tipo_cierre, fecha_autorizacion_cierre, id_usuario_validacion,
        total_teorico, total_real, diferencia, tipo_diferencia,
        CASE 
            WHEN estado = "Abierta" THEN "Abierta"
            WHEN estado = "Cerrada" THEN "Validada"
            ELSE "Rechazada"
        END,
        observaciones, observaciones_cierre, created_at, updated_at
    FROM cajas
    WHERE estado IN ("Abierta", "Cerrada")
');

// Actualizar cajas a activo
DB::statement('UPDATE cajas SET activo = 1 WHERE estado != "Inactiva"');
DB::statement('UPDATE cajas SET activo = 0 WHERE estado = "Inactiva"');
```

---

## 3. Cambios en Modelos

### 3.1 Crear Modelo SesionCaja

```php
// app/Models/SesionCaja.php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SesionCaja extends Model
{
    use SoftDeletes;

    protected $table = 'sesiones_caja';
    protected $primaryKey = 'id_sesion';

    protected $fillable = [
        'id_caja', 'id_empresa',
        'fecha_apertura', 'id_usuario_apertura', 'saldo_inicial', 'tipo_apertura',
        'fecha_cierre', 'id_usuario_cierre', 'saldo_final', 'tipo_cierre',
        'fecha_validacion', 'id_usuario_validacion',
        'total_teorico', 'total_real', 'diferencia', 'tipo_diferencia',
        'estado', 'observaciones', 'observaciones_cierre',
    ];

    protected $casts = [
        'fecha_apertura' => 'datetime',
        'fecha_cierre' => 'datetime',
        'fecha_validacion' => 'datetime',
        'saldo_inicial' => 'decimal:2',
        'saldo_final' => 'decimal:2',
        'total_teorico' => 'decimal:2',
        'total_real' => 'decimal:2',
        'diferencia' => 'decimal:2',
    ];

    // Relaciones
    public function caja()
    {
        return $this->belongsTo(Caja::class, 'id_caja', 'id_caja');
    }

    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    public function usuarioApertura()
    {
        return $this->belongsTo(User::class, 'id_usuario_apertura', 'id');
    }

    public function usuarioCierre()
    {
        return $this->belongsTo(User::class, 'id_usuario_cierre', 'id');
    }

    public function usuarioValidacion()
    {
        return $this->belongsTo(User::class, 'id_usuario_validacion', 'id');
    }

    public function movimientos()
    {
        return $this->hasMany(MovimientoCaja::class, 'id_sesion', 'id_sesion');
    }

    public function aperturaBilletes()
    {
        return $this->hasMany(AperturaCajaBillete::class, 'id_sesion', 'id_sesion');
    }

    public function cierreBilletes()
    {
        return $this->hasMany(CierreCajaBillete::class, 'id_sesion', 'id_sesion');
    }

    // Scopes
    public function scopeAbierta($query)
    {
        return $query->where('estado', 'Abierta');
    }

    public function scopeHoy($query)
    {
        return $query->whereDate('fecha_apertura', today());
    }

    public function scopeByEmpresa($query, $empresaId)
    {
        return $query->where('id_empresa', $empresaId);
    }
}
```

### 3.2 Actualizar Modelo Caja

```php
// app/Models/Caja.php

class Caja extends Model
{
    // ... código existente ...

    protected $fillable = [
        'id_empresa',
        'nombre',
        'descripcion',
        'id_responsable',
        'activo', // Cambio: antes era 'estado'
    ];

    // Remover relaciones antiguas de sesión
    // Agregar nueva relación
    public function sesiones()
    {
        return $this->hasMany(SesionCaja::class, 'id_caja', 'id_caja');
    }

    public function sesionActiva()
    {
        return $this->hasOne(SesionCaja::class, 'id_caja', 'id_caja')
            ->where('estado', 'Abierta')
            ->whereDate('fecha_apertura', today());
    }

    public function scopeActiva($query)
    {
        return $query->where('activo', true);
    }
}
```

### 3.3 Actualizar Modelo MovimientoCaja

```php
// app/Models/MovimientoCaja.php

class MovimientoCaja extends Model
{
    // Agregar id_sesion
    protected $fillable = [
        'id_sesion', // Nuevo
        'id_caja',
        'id_empresa',
        'id_usuario',
        'tipo',
        'concepto',
        'monto',
        'numero_operacion',
        'tipo_referencia',
        'id_referencia',
        'descripcion',
    ];

    public function sesion()
    {
        return $this->belongsTo(SesionCaja::class, 'id_sesion', 'id_sesion');
    }

    // Mantener relación con caja para compatibilidad
    public function caja()
    {
        return $this->belongsTo(Caja::class, 'id_caja', 'id_caja');
    }
}
```

---

## 4. Cambios en Controladores

### 4.1 Crear SesionCajaController

```php
// app/Http/Controllers/Api/SesionCajaController.php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\BaseApiController;
use App\Http\Requests\CajaAperturaRequest;
use App\Http\Requests\CajaCierreRequest;
use App\Models\Caja;
use App\Models\SesionCaja;
use App\Services\Contracts\SesionCajaServiceInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class SesionCajaController extends BaseApiController
{
    public function __construct(
        private readonly SesionCajaServiceInterface $sesionService,
    ) {}

    // Crear sesión (apertura diaria)
    public function store(CajaAperturaRequest $request, int $cajaId): JsonResponse
    {
        $caja = Caja::where('id_empresa', $request->user()->id_empresa)
            ->where('activo', true)
            ->find($cajaId);

        if (!$caja) {
            return $this->notFound('Caja no encontrada o inactiva.');
        }

        // Verificar que no haya sesión abierta hoy
        $sesionHoy = $caja->sesionActiva()->first();
        if ($sesionHoy) {
            return $this->unprocessable('Ya existe una sesión abierta hoy para esta caja.');
        }

        $sesion = $this->sesionService->crearSesion($caja, $request->validated(), $request->user());

        return $this->created($sesion, 'Sesión de caja abierta exitosamente.');
    }

    // Cerrar sesión
    public function cerrar(CajaCierreRequest $request, int $sesionId): JsonResponse
    {
        $sesion = SesionCaja::where('id_empresa', $request->user()->id_empresa)
            ->find($sesionId);

        if (!$sesion) {
            return $this->notFound('Sesión no encontrada.');
        }

        if ($sesion->estado !== 'Abierta') {
            return $this->unprocessable('La sesión no está abierta.');
        }

        $sesion = $this->sesionService->cerrarSesion($sesion, $request->validated(), $request->user());

        return $this->success($sesion, 'Sesión cerrada exitosamente.');
    }

    // Validar cierre (admin)
    public function validar(Request $request, int $sesionId): JsonResponse
    {
        $sesion = SesionCaja::where('id_empresa', $request->user()->id_empresa)
            ->find($sesionId);

        if (!$sesion) {
            return $this->notFound('Sesión no encontrada.');
        }

        if ($sesion->estado !== 'Cerrada') {
            return $this->unprocessable('La sesión no está cerrada.');
        }

        $sesion = $this->sesionService->validarSesion($sesion, $request->user());

        return $this->success($sesion, 'Sesión validada exitosamente.');
    }

    // Listar sesiones de una caja
    public function sesiones(Request $request, int $cajaId): JsonResponse
    {
        $caja = Caja::where('id_empresa', $request->user()->id_empresa)
            ->find($cajaId);

        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }

        $sesiones = $caja->sesiones()
            ->orderByDesc('fecha_apertura')
            ->paginate(15);

        return $this->success($sesiones);
    }
}
```

### 4.2 Actualizar CajaController

```php
// app/Http/Controllers/Api/CajaController.php

class CajaController extends BaseApiController
{
    // Cambiar index para listar cajas activas
    public function index(Request $request): JsonResponse
    {
        $cajas = Caja::where('id_empresa', $request->user()->id_empresa)
            ->where('activo', true)
            ->with('sesionActiva')
            ->get();

        return $this->success($cajas);
    }

    // Remover métodos de sesión (ahora en SesionCajaController)
    // - activar()
    // - abrir()
    // - cierre()
    // - autorizarCierre()
    // - rechazarCierre()

    // Mantener métodos de consulta
    public function cajaActiva(Request $request): JsonResponse
    {
        $sesion = SesionCaja::where('id_empresa', $request->user()->id_empresa)
            ->where('estado', 'Abierta')
            ->whereDate('fecha_apertura', today())
            ->with('caja', 'movimientos')
            ->first();

        return $this->success($sesion ? $sesion : null);
    }

    // ... resto de métodos ...
}
```

---

## 5. Cambios en Frontend

### 5.1 Actualizar CajaAperturaModal

```jsx
// resources/js/components/Finanzas/Caja/modals/CajaAperturaModal.jsx

export default function CajaAperturaModal({ isOpen, onClose, onSuccess }) {
    const [cajaSeleccionada, setCajaSeleccionada] = useState(null);
    const [cajasDisponibles, setCajasDisponibles] = useState([]);
    // ... resto del estado ...

    useEffect(() => {
        if (isOpen) {
            fetchCajasDisponibles(); // Cambio: antes era fetchCajasInactivas
            fetchDenominaciones();
            document.body.style.overflow = 'hidden';
        }
        return () => { document.body.style.overflow = 'unset'; };
    }, [isOpen]);

    const fetchCajasDisponibles = async () => {
        try {
            setLoadingCajas(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch('/api/cajas', {
                headers: { Authorization: `Bearer ${token}`, Accept: 'application/json' }
            });
            const data = await res.json();
            if (data.success) {
                const lista = data.data?.data ?? data.data ?? [];
                // Filtrar: cajas activas sin sesión abierta hoy
                setCajasDisponibles(lista.filter(c => 
                    c.activo && !c.sesion_activa
                ));
            }
        } catch {
            toast.error('Error al cargar cajas disponibles');
        } finally {
            setLoadingCajas(false);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        if (!cajaSeleccionada?.id_caja) {
            toast.error('Selecciona una caja para aperturar');
            return;
        }

        setLoading(true);
        try {
            const token = localStorage.getItem('auth_token');
            const payload = {
                tipo_apertura: tipoApertura,
                saldo_inicial: tipoApertura === 'monto_fijo'
                    ? parseFloat(montoFijo)
                    : denominaciones.reduce((sum, d) => sum + (d.subtotal || 0), 0),
                observaciones,
            };

            // Cambio: endpoint ahora es /api/cajas/{id}/sesiones
            const res = await fetch(`/api/cajas/${cajaSeleccionada.id_caja}/sesiones`, {
                method: 'POST',
                headers: {
                    Authorization: `Bearer ${token}`,
                    'Content-Type': 'application/json',
                    Accept: 'application/json',
                },
                body: JSON.stringify(payload),
            });

            const data = await res.json();
            if (data.success) {
                toast.success('Sesión de caja abierta correctamente');
                handleReset();
                onSuccess?.();
            } else {
                toast.error(data.message || 'Error al aperturar caja');
            }
        } catch {
            toast.error('Error de conexión');
        } finally {
            setLoading(false);
        }
    };

    // ... resto del componente ...
}
```

### 5.2 Actualizar Rutas

```php
// routes/api.php

Route::middleware('auth:sanctum')->group(function () {
    // Cajas (configuración)
    Route::apiResource('cajas', CajaController::class);
    
    // Sesiones de caja (operación diaria)
    Route::post('cajas/{cajaId}/sesiones', [SesionCajaController::class, 'store']);
    Route::get('cajas/{cajaId}/sesiones', [SesionCajaController::class, 'sesiones']);
    Route::post('sesiones/{sesionId}/cerrar', [SesionCajaController::class, 'cerrar']);
    Route::post('sesiones/{sesionId}/validar', [SesionCajaController::class, 'validar']);
    
    // Consultas
    Route::get('cajas-activa', [CajaController::class, 'cajaActiva']);
});
```

---

## 6. Checklist de Implementación

```
FASE 1: Base de Datos
  ☐ Crear migración de sesiones_caja
  ☐ Crear migración de actualización de cajas
  ☐ Migrar datos existentes
  ☐ Verificar integridad de datos

FASE 2: Modelos
  ☐ Crear SesionCaja.php
  ☐ Actualizar Caja.php
  ☐ Actualizar MovimientoCaja.php
  ☐ Actualizar AperturaCajaBillete.php
  ☐ Actualizar CierreCajaBillete.php

FASE 3: Servicios
  ☐ Crear SesionCajaService
  ☐ Actualizar CajaService
  ☐ Actualizar CajaSesionService

FASE 4: Controladores
  ☐ Crear SesionCajaController
  ☐ Actualizar CajaController
  ☐ Actualizar rutas

FASE 5: Frontend
  ☐ Actualizar CajaAperturaModal
  ☐ Actualizar CajaAbiertaDetail
  ☐ Actualizar CajaCierreModal
  ☐ Actualizar CajaValidacionModal
  ☐ Actualizar hooks (useCajas)
  ☐ Actualizar llamadas API

FASE 6: Testing
  ☐ Tests unitarios de modelos
  ☐ Tests de servicios
  ☐ Tests de controladores
  ☐ Tests de integración
  ☐ Pruebas manuales

FASE 7: Documentación
  ☐ Actualizar README
  ☐ Actualizar API docs
  ☐ Actualizar guías de usuario
```

---

## 7. Riesgos y Mitigación

| Riesgo | Probabilidad | Impacto | Mitigación |
|--------|-------------|--------|-----------|
| Pérdida de datos históricos | Baja | Alto | Backup antes de migración, verificar datos |
| Incompatibilidad con código existente | Media | Medio | Tests exhaustivos, mantener compatibilidad |
| Rendimiento de queries | Baja | Medio | Índices en sesiones_caja, optimizar queries |
| Confusión de usuarios | Media | Bajo | Documentación clara, capacitación |

---

## 8. Estimación de Tiempo

| Fase | Tiempo |
|------|--------|
| Base de Datos | 1 hora |
| Modelos | 1 hora |
| Servicios | 2 horas |
| Controladores | 2 horas |
| Frontend | 3 horas |
| Testing | 2 horas |
| Documentación | 1 hora |
| **Total** | **12 horas** |

---

## 9. Próximos Pasos

1. Revisar y aprobar este plan
2. Crear skill de migración de base de datos
3. Crear skill de actualización de modelos
4. Crear skill de actualización de servicios
5. Crear skill de actualización de controladores
6. Crear skill de actualización de frontend
7. Crear skill de testing
8. Ejecutar en orden

