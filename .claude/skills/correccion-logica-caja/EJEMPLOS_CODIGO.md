# Ejemplos de Código - Corrección de Lógica de Caja

## 1. Modelos

### Modelo SesionCaja (NUEVO)

```php
<?php

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

    public function movimientos()
    {
        return $this->hasMany(MovimientoCaja::class, 'id_sesion', 'id_sesion');
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
}
```

### Modelo Caja (ACTUALIZADO)

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Caja extends Model
{
    protected $table = 'cajas';
    protected $primaryKey = 'id_caja';

    protected $fillable = [
        'id_empresa',
        'nombre',
        'descripcion',
        'id_responsable',
        'activo', // Cambio: antes era 'estado'
    ];

    // Relaciones
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

    // Scopes
    public function scopeActiva($query)
    {
        return $query->where('activo', true);
    }
}
```

---

## 2. Servicios

### SesionCajaService

```php
<?php

namespace App\Services;

use App\Models\Caja;
use App\Models\SesionCaja;
use App\Models\User;

class SesionCajaService
{
    public function crearSesion(Caja $caja, array $datos, User $usuario): SesionCaja
    {
        // Verificar que no haya sesión abierta hoy
        $sesionHoy = $caja->sesionActiva()->first();
        if ($sesionHoy) {
            throw new \Exception('Ya existe una sesión abierta hoy');
        }

        // Crear sesión
        $sesion = $caja->sesiones()->create([
            'id_empresa' => $caja->id_empresa,
            'fecha_apertura' => now(),
            'id_usuario_apertura' => $usuario->id,
            'saldo_inicial' => $datos['saldo_inicial'],
            'tipo_apertura' => $datos['tipo_apertura'],
            'estado' => 'Abierta',
            'observaciones' => $datos['observaciones'] ?? null,
        ]);

        // Si es por billetes, registrar denominaciones
        if ($datos['tipo_apertura'] === 'billetes') {
            $this->registrarBilletes($sesion, $datos['denominaciones']);
        }

        return $sesion;
    }

    public function cerrarSesion(SesionCaja $sesion, array $datos, User $usuario): SesionCaja
    {
        // Calcular totales
        $totalIngresos = $sesion->movimientos()
            ->where('tipo', 'Ingreso')
            ->sum('monto');
        
        $totalEgresos = $sesion->movimientos()
            ->where('tipo', 'Egreso')
            ->sum('monto');

        $totalTeorico = $sesion->saldo_inicial + $totalIngresos - $totalEgresos;
        $diferencia = $datos['saldo_final'] - $totalTeorico;

        // Actualizar sesión
        $sesion->update([
            'fecha_cierre' => now(),
            'id_usuario_cierre' => $usuario->id,
            'saldo_final' => $datos['saldo_final'],
            'tipo_cierre' => $datos['tipo_cierre'],
            'total_teorico' => $totalTeorico,
            'total_real' => $datos['saldo_final'],
            'diferencia' => $diferencia,
            'tipo_diferencia' => $this->getTipoDiferencia($diferencia),
            'estado' => 'Cerrada',
            'observaciones_cierre' => $datos['observaciones_cierre'] ?? null,
        ]);

        return $sesion;
    }

    public function validarSesion(SesionCaja $sesion, User $usuario): SesionCaja
    {
        $sesion->update([
            'fecha_validacion' => now(),
            'id_usuario_validacion' => $usuario->id,
            'estado' => 'Validada',
        ]);

        return $sesion;
    }

    private function getTipoDiferencia(float $diferencia): string
    {
        if ($diferencia === 0) {
            return 'exacto';
        } elseif ($diferencia > 0) {
            return 'sobrante';
        } else {
            return 'faltante';
        }
    }

    private function registrarBilletes(SesionCaja $sesion, array $denominaciones): void
    {
        foreach ($denominaciones as $denom) {
            $sesion->aperturaBilletes()->create([
                'id_denominacion' => $denom['id_denominacion'],
                'cantidad' => $denom['cantidad'],
            ]);
        }
    }
}
```

---

## 3. Controladores

### SesionCajaController

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\BaseApiController;
use App\Http\Requests\CajaAperturaRequest;
use App\Http\Requests\CajaCierreRequest;
use App\Models\Caja;
use App\Models\SesionCaja;
use App\Services\SesionCajaService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class SesionCajaController extends BaseApiController
{
    public function __construct(
        private readonly SesionCajaService $sesionService,
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

        try {
            $sesion = $this->sesionService->crearSesion(
                $caja,
                $request->validated(),
                $request->user()
            );

            return $this->created($sesion, 'Sesión de caja abierta exitosamente.');
        } catch (\Exception $e) {
            return $this->unprocessable($e->getMessage());
        }
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

        try {
            $sesion = $this->sesionService->cerrarSesion(
                $sesion,
                $request->validated(),
                $request->user()
            );

            return $this->success($sesion, 'Sesión cerrada exitosamente.');
        } catch (\Exception $e) {
            return $this->unprocessable($e->getMessage());
        }
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

        try {
            $sesion = $this->sesionService->validarSesion($sesion, $request->user());

            return $this->success($sesion, 'Sesión validada exitosamente.');
        } catch (\Exception $e) {
            return $this->unprocessable($e->getMessage());
        }
    }
}
```

---

## 4. Frontend

### Hook useSesiones

```javascript
// resources/js/hooks/useSesiones.js

import { useState, useCallback } from 'react';
import { toast } from '@/lib/sweetalert';

export function useSesiones() {
    const [sesiones, setSesiones] = useState([]);
    const [loading, setLoading] = useState(false);

    const fetchSesiones = useCallback(async (cajaId) => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch(`/api/cajas/${cajaId}/sesiones`, {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: 'application/json',
                },
            });

            const data = await res.json();
            if (data.success) {
                setSesiones(data.data);
            }
        } catch (error) {
            toast.error('Error al cargar sesiones');
        } finally {
            setLoading(false);
        }
    }, []);

    const crearSesion = useCallback(async (cajaId, payload) => {
        try {
            setLoading(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch(`/api/cajas/${cajaId}/sesiones`, {
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
                toast.success('Sesión creada exitosamente');
                return data.data;
            } else {
                toast.error(data.message || 'Error al crear sesión');
                return null;
            }
        } catch (error) {
            toast.error('Error de conexión');
            return null;
        } finally {
            setLoading(false);
        }
    }, []);

    return {
        sesiones,
        loading,
        fetchSesiones,
        crearSesion,
    };
}
```

### Componente CajaAperturaModal (ACTUALIZADO)

```jsx
// resources/js/components/Finanzas/Caja/modals/CajaAperturaModal.jsx

import { useState, useEffect } from 'react';
import { useSesiones } from '@/hooks/useSesiones';
import { toast } from '@/lib/sweetalert';

export default function CajaAperturaModal({ isOpen, onClose, onSuccess }) {
    const [cajaSeleccionada, setCajaSeleccionada] = useState(null);
    const [cajasDisponibles, setCajasDisponibles] = useState([]);
    const [tipoApertura, setTipoApertura] = useState('monto_fijo');
    const [montoFijo, setMontoFijo] = useState('');
    const [loading, setLoading] = useState(false);
    const [loadingCajas, setLoadingCajas] = useState(false);
    const { crearSesion } = useSesiones();

    useEffect(() => {
        if (isOpen) {
            fetchCajasDisponibles();
        }
    }, [isOpen]);

    const fetchCajasDisponibles = async () => {
        try {
            setLoadingCajas(true);
            const token = localStorage.getItem('auth_token');
            const res = await fetch('/api/cajas', {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: 'application/json',
                },
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
            toast.error('Error al cargar cajas');
        } finally {
            setLoadingCajas(false);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        if (!cajaSeleccionada?.id_caja) {
            toast.error('Selecciona una caja');
            return;
        }

        if (!montoFijo || parseFloat(montoFijo) < 0) {
            toast.error('Ingresa un monto válido');
            return;
        }

        setLoading(true);
        const sesion = await crearSesion(cajaSeleccionada.id_caja, {
            tipo_apertura: tipoApertura,
            saldo_inicial: parseFloat(montoFijo),
        });

        if (sesion) {
            handleReset();
            onSuccess?.();
        }

        setLoading(false);
    };

    const handleReset = () => {
        setTipoApertura('monto_fijo');
        setMontoFijo('');
        setCajaSeleccionada(null);
        onClose();
    };

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50">
            <div className="bg-white rounded-lg shadow-xl max-w-2xl w-full">
                <div className="p-6 border-b">
                    <h2 className="text-xl font-semibold">Apertura de Caja</h2>
                </div>

                <form onSubmit={handleSubmit} className="p-6 space-y-6">
                    {/* Selector de caja */}
                    <div className="space-y-2">
                        <label className="block text-sm font-medium">
                            Caja a aperturar
                        </label>
                        {loadingCajas ? (
                            <p className="text-sm text-gray-500">Cargando...</p>
                        ) : cajasDisponibles.length === 0 ? (
                            <p className="text-sm text-amber-600">
                                No hay cajas disponibles
                            </p>
                        ) : (
                            <select
                                className="w-full rounded-md border px-3 py-2"
                                value={cajaSeleccionada?.id_caja ?? ''}
                                onChange={(e) => {
                                    const id = parseInt(e.target.value);
                                    setCajaSeleccionada(
                                        cajasDisponibles.find(c => c.id_caja === id)
                                    );
                                }}
                            >
                                <option value="">— Selecciona una caja —</option>
                                {cajasDisponibles.map(c => (
                                    <option key={c.id_caja} value={c.id_caja}>
                                        {c.nombre}
                                    </option>
                                ))}
                            </select>
                        )}
                    </div>

                    {/* Monto */}
                    <div className="space-y-2">
                        <label className="block text-sm font-medium">
                            Saldo Inicial
                        </label>
                        <input
                            type="number"
                            step="0.01"
                            min="0"
                            placeholder="0.00"
                            value={montoFijo}
                            onChange={(e) => setMontoFijo(e.target.value)}
                            className="w-full rounded-md border px-3 py-2"
                        />
                    </div>

                    {/* Botones */}
                    <div className="flex justify-end gap-2 pt-4 border-t">
                        <button
                            type="button"
                            onClick={handleReset}
                            disabled={loading}
                            className="px-4 py-2 border rounded-md"
                        >
                            Cancelar
                        </button>
                        <button
                            type="submit"
                            disabled={loading || !cajaSeleccionada}
                            className="px-4 py-2 bg-blue-600 text-white rounded-md"
                        >
                            {loading ? 'Aperturando...' : 'Aperturar'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
}
```

---

## 5. Rutas

### routes/api.php

```php
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

**Nota**: Estos son ejemplos simplificados. La implementación completa incluirá validaciones, manejo de errores y tests.

