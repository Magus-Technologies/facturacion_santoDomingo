<?php

namespace App\Http\Controllers\Api;

use App\Enums\CajaEstadoEnum;
use App\Http\Controllers\BaseApiController;
use App\Http\Requests\CajaAperturaRequest;
use App\Http\Requests\CajaCierreRequest;
use App\Http\Requests\CajaCrearRequest;
use App\Http\Requests\MovimientoCajaRequest;
use App\Http\Resources\CajaResource;
use App\Models\Caja;
use App\Models\DenominacionBillete;
use App\Models\PermisoCaja;
use App\Services\Contracts\CajaArqueoServiceInterface;
use App\Services\Contracts\CajaServiceInterface;
use App\Services\Contracts\CajaSesionServiceInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CajaController extends BaseApiController
{
    public function __construct(
        private readonly CajaServiceInterface       $cajaService,
        private readonly CajaSesionServiceInterface $sesionService,
        private readonly CajaArqueoServiceInterface $arqueoService,
    ) {}

    // ─── CRUD ─────────────────────────────────────────────────────────────────

    public function index(Request $request): JsonResponse
    {
        // Obtener todas las cajas de la empresa
        $cajas = Caja::where('id_empresa', $request->user()->id_empresa)
            ->with(['responsable', 'usuarioApertura', 'usuarioCierre', 'metodosPago.cuentaBancaria.banco'])
            ->orderBy('created_at', 'desc')
            ->paginate(15);
        
        return $this->success(CajaResource::collection($cajas)->response()->getData(true));
    }

    public function store(CajaCrearRequest $request): JsonResponse
    {
        $caja = $this->cajaService->crear($request->validated(), $request->user()->id_empresa, $request->user());
        return $this->created(new CajaResource($caja));
    }

    public function show(Request $request, int $id): JsonResponse
    {
        $caja = $this->cajaService->obtener($id, $request->user()->id_empresa);
        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }
        return $this->success(new CajaResource($caja));
    }

    // ─── Sesión ───────────────────────────────────────────────────────────────

    public function activar(Request $request, int $id): JsonResponse
    {
        $caja = $this->cajaService->obtener($id, $request->user()->id_empresa);
        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }

        $caja = $this->sesionService->abrir($caja, [
            'saldo_inicial' => 0,
            'tipo_apertura' => 'monto_fijo',
        ], $request->user());

        return $this->success(new CajaResource($caja), 'Caja activada exitosamente.');
    }

    public function abrir(CajaAperturaRequest $request, int $id): JsonResponse
    {
        $caja = $this->cajaService->obtener($id, $request->user()->id_empresa);
        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }

        $caja = $this->sesionService->abrir($caja, $request->validated(), $request->user());
        return $this->success(new CajaResource($caja), 'Caja abierta exitosamente.');
    }

    public function cierre(CajaCierreRequest $request, int $id): JsonResponse
    {
        $caja = Caja::where('id_empresa', $request->user()->id_empresa)->find($id);
        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }

        $caja = $this->sesionService->cerrar($caja, $request->validated(), $request->user());
        return $this->success(new CajaResource($caja), 'Caja cerrada exitosamente.');
    }

    public function autorizarCierre(Request $request, int $id): JsonResponse
    {
        $caja = Caja::where('id_empresa', $request->user()->id_empresa)->find($id);
        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }

        $arqueo = $this->arqueoService->crearArqueo($caja, $request->user());
        $caja   = $this->sesionService->autorizarCierre($caja, $request->user());
        return $this->success(['caja' => new CajaResource($caja), 'arqueo_id' => $arqueo->id_arqueo], 'Cierre autorizado.');
    }

    public function rechazarCierre(Request $request, int $id): JsonResponse
    {
        $caja = Caja::where('id_empresa', $request->user()->id_empresa)->find($id);
        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }

        $caja = $this->sesionService->rechazarCierre($caja, $request->user());
        return $this->success(new CajaResource($caja), 'Cierre rechazado. Caja reabierta.');
    }

    // ─── Movimientos ──────────────────────────────────────────────────────────

    public function movimientos(int $id): JsonResponse
    {
        $caja = Caja::find($id);
        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }
        return $this->success($caja->movimientos()->with('usuario')->get());
    }

    public function registrarMovimiento(MovimientoCajaRequest $request, int $id): JsonResponse
    {
        $caja = Caja::find($id);
        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }

        if ($caja->estado !== CajaEstadoEnum::Abierta->value) {
            return $this->unprocessable('La caja no está abierta.');
        }

        $movimiento = $caja->movimientos()->create([
            'id_empresa'      => $request->user()->id_empresa,
            'id_usuario'      => $request->user()->id,
            ...$request->validated(),
        ]);

        return $this->created($movimiento, 'Movimiento registrado.');
    }

    // ─── Consultas ────────────────────────────────────────────────────────────

    public function cajaActiva(Request $request): JsonResponse
    {
        $caja = Caja::where('id_empresa', $request->user()->id_empresa)
            ->where('estado', CajaEstadoEnum::Abierta->value)
            ->with('metodosPago')
            ->first();

        return $this->success($caja ? new CajaResource($caja) : null);
    }

    public function denominaciones(): JsonResponse
    {
        return $this->success(DenominacionBillete::orderBy('valor', 'desc')->get());
    }

    public function resumen(int $id): JsonResponse
    {
        $caja = Caja::find($id);
        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }
        return $this->success($this->arqueoService->resumen($caja));
    }

    public function ventasPorMetodo(int $id): JsonResponse
    {
        $caja = Caja::find($id);
        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }
        $resumen = $this->arqueoService->resumen($caja);
        return $this->success($resumen['ventas_por_metodo']);
    }

    public function auditoria(int $id): JsonResponse
    {
        $caja = Caja::find($id);
        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }
        return $this->success($caja->auditorias()->with('usuario')->orderByDesc('created_at')->get());
    }

    public function arqueo(int $id): JsonResponse
    {
        $caja   = Caja::find($id);
        if (!$caja) {
            return $this->notFound('Caja no encontrada.');
        }
        $arqueo = $caja->arqueoDiario()->first();
        if (!$arqueo) {
            return $this->notFound('No hay arqueo para esta caja.');
        }
        return $this->success($arqueo);
    }

    // ─── Permisos ─────────────────────────────────────────────────────────────

    public function obtenerPermisos(Request $request, int $usuarioId): JsonResponse
    {
        $permisos = PermisoCaja::where('id_usuario', $usuarioId)
            ->where('id_empresa', $request->user()->id_empresa)
            ->first();

        if (!$permisos) {
            return $this->notFound('Permisos no encontrados.');
        }

        return $this->success($permisos);
    }

    public function actualizarPermisos(Request $request, int $usuarioId): JsonResponse
    {
        $validated = $request->validate([
            'puede_abrir_caja'          => 'boolean',
            'puede_cerrar_caja'         => 'boolean',
            'puede_autorizar_cierre'    => 'boolean',
            'puede_rechazar_cierre'     => 'boolean',
            'puede_registrar_movimientos' => 'boolean',
            'puede_ver_reportes'        => 'boolean',
        ]);

        $permisos = PermisoCaja::firstOrCreate(
            ['id_usuario' => $usuarioId, 'id_empresa' => $request->user()->id_empresa]
        );
        $permisos->update($validated);

        return $this->success($permisos, 'Permisos actualizados.');
    }
}
