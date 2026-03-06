<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CuentaBancaria;
use Illuminate\Http\Request;

class CuentaBancariaController extends Controller
{
    public function index(Request $request)
    {
        try {
            $user = $request->user();
            $cuentas = CuentaBancaria::where('id_empresa', $user->id_empresa)
                ->with(['banco'])
                ->orderBy('numero_cuenta')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $cuentas
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener cuentas bancarias: ' . $e->getMessage()
            ], 500);
        }
    }

    public function store(Request $request)
    {
        try {
            $user = $request->user();

            $validated = $request->validate([
                'id_banco' => 'required|exists:bancos,id_banco',
                'numero_cuenta' => 'required|string|max:50|unique:cuentas_bancarias',
                'tipo_cuenta' => 'required|in:Corriente,Ahorros',
                'moneda' => 'required|in:PEN,USD,EUR',
                'saldo_actual' => 'required|numeric|min:0',
                'titular' => 'required|string|max:255',
                'cci' => 'nullable|string|size:17',
            ]);

            $cuenta = CuentaBancaria::create([
                'id_empresa' => $user->id_empresa,
                'id_banco' => $validated['id_banco'],
                'numero_cuenta' => $validated['numero_cuenta'],
                'tipo_cuenta' => $validated['tipo_cuenta'],
                'moneda' => $validated['moneda'],
                'saldo_actual' => $validated['saldo_actual'],
                'saldo_banco' => $validated['saldo_actual'],
                'titular' => $validated['titular'],
                'cci' => $validated['cci'] ?? null,
                'activa' => true,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Cuenta bancaria creada exitosamente',
                'data' => $cuenta
            ], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error de validación',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al crear cuenta bancaria: ' . $e->getMessage()
            ], 500);
        }
    }

    public function show($id)
    {
        try {
            $cuenta = CuentaBancaria::with(['banco'])->findOrFail($id);

            return response()->json([
                'success' => true,
                'data' => $cuenta
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Cuenta bancaria no encontrada'
            ], 404);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $cuenta = CuentaBancaria::findOrFail($id);

            $validated = $request->validate([
                'numero_cuenta' => 'sometimes|required|string|max:50|unique:cuentas_bancarias,numero_cuenta,' . $id,
                'tipo_cuenta' => 'sometimes|required|in:Corriente,Ahorros',
                'moneda' => 'sometimes|required|in:PEN,USD,EUR',
                'saldo_actual' => 'sometimes|required|numeric|min:0',
                'saldo_banco' => 'sometimes|required|numeric|min:0',
                'titular' => 'sometimes|required|string|max:255',
                'cci' => 'nullable|string|size:17',
                'activa' => 'nullable|boolean',
            ]);

            $cuenta->update($validated);

            return response()->json([
                'success' => true,
                'message' => 'Cuenta bancaria actualizada exitosamente',
                'data' => $cuenta
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error de validación',
                'errors' => $e->errors()
            ], 422);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Cuenta bancaria no encontrada'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar cuenta bancaria: ' . $e->getMessage()
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $cuenta = CuentaBancaria::findOrFail($id);
            $cuenta->delete();

            return response()->json([
                'success' => true,
                'message' => 'Cuenta bancaria eliminada exitosamente'
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Cuenta bancaria no encontrada'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar cuenta bancaria: ' . $e->getMessage()
            ], 500);
        }
    }

    public function movimientos($id)
    {
        try {
            $cuenta = CuentaBancaria::findOrFail($id);
            $movimientos = $cuenta->movimientos()->orderBy('fecha_movimiento', 'desc')->get();

            return response()->json([
                'success' => true,
                'data' => $movimientos
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Cuenta bancaria no encontrada'
            ], 404);
        }
    }

    public function registrarMovimiento(Request $request, $id)
    {
        try {
            $user = $request->user();
            $cuenta = CuentaBancaria::findOrFail($id);

            $validated = $request->validate([
                'tipo' => 'required|in:Deposito,Retiro,Transferencia,Comision,Interes',
                'monto' => 'required|numeric|min:0.01',
                'fecha_movimiento' => 'required|date',
                'referencia' => 'nullable|string|max:255',
                'descripcion' => 'nullable|string',
            ]);

            $movimiento = $cuenta->movimientos()->create([
                'id_empresa' => $user->id_empresa,
                'tipo' => $validated['tipo'],
                'monto' => $validated['monto'],
                'fecha_movimiento' => $validated['fecha_movimiento'],
                'referencia' => $validated['referencia'] ?? null,
                'descripcion' => $validated['descripcion'] ?? null,
                'conciliado' => false,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Movimiento registrado exitosamente',
                'data' => $movimiento
            ], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error de validación',
                'errors' => $e->errors()
            ], 422);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Cuenta bancaria no encontrada'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al registrar movimiento: ' . $e->getMessage()
            ], 500);
        }
    }

    public function conciliaciones($id)
    {
        try {
            $cuenta = CuentaBancaria::findOrFail($id);
            $conciliaciones = $cuenta->conciliaciones()->orderBy('fecha_conciliacion', 'desc')->get();

            return response()->json([
                'success' => true,
                'data' => $conciliaciones
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Cuenta bancaria no encontrada'
            ], 404);
        }
    }

    public function registrarConciliacion(Request $request, $id)
    {
        try {
            $user = $request->user();
            $cuenta = CuentaBancaria::findOrFail($id);

            $validated = $request->validate([
                'saldo_banco' => 'required|numeric',
                'observaciones' => 'nullable|string',
            ]);

            $saldoEmpresa = $cuenta->saldo_actual;
            $diferencia = $validated['saldo_banco'] - $saldoEmpresa;
            $estado = $diferencia == 0 ? 'Conciliada' : 'Diferencia';

            $conciliacion = $cuenta->conciliaciones()->create([
                'id_empresa' => $user->id_empresa,
                'id_usuario' => $user->id,
                'fecha_conciliacion' => now(),
                'saldo_empresa' => $saldoEmpresa,
                'saldo_banco' => $validated['saldo_banco'],
                'diferencia' => $diferencia,
                'estado' => $estado,
                'observaciones' => $validated['observaciones'] ?? null,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Conciliación registrada exitosamente',
                'data' => $conciliacion
            ], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error de validación',
                'errors' => $e->errors()
            ], 422);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Cuenta bancaria no encontrada'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al registrar conciliación: ' . $e->getMessage()
            ], 500);
        }
    }
}
