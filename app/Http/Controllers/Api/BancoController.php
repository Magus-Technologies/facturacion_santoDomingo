<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\BancoRequest;
use App\Models\Banco;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class BancoController extends Controller
{
    /**
     * GET /api/bancos
     */
    public function index(Request $request)
    {
        try {
            $query = Banco::query();

            if ($request->boolean('solo_activos')) {
                $query->activo();
            }

            if ($request->has('search')) {
                $search = $request->search;
                $query->where(function ($q) use ($search) {
                    $q->where('nombre', 'like', "%{$search}%")
                      ->orWhere('codigo_sunat', 'like', "%{$search}%");
                });
            }

            $bancos = $query->orderBy('nombre')->get();

            return response()->json([
                'success' => true,
                'data'    => $bancos,
            ]);
        } catch (\Exception $e) {
            Log::error('Error listando bancos: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener los bancos.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * POST /api/bancos
     */
    public function store(BancoRequest $request)
    {
        try {
            $banco = Banco::create($request->validated());

            return response()->json([
                'success' => true,
                'message' => 'Banco creado exitosamente.',
                'data'    => $banco,
            ], 201);
        } catch (\Exception $e) {
            Log::error('Error creando banco: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al crear el banco.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * GET /api/bancos/{id}
     */
    public function show($id)
    {
        try {
            $banco = Banco::findOrFail($id);

            return response()->json([
                'success' => true,
                'data'    => $banco,
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Banco no encontrado.',
            ], 404);
        }
    }

    /**
     * PUT /api/bancos/{id}
     */
    public function update(BancoRequest $request, $id)
    {
        try {
            $banco = Banco::findOrFail($id);
            $banco->update($request->validated());

            return response()->json([
                'success' => true,
                'message' => 'Banco actualizado exitosamente.',
                'data'    => $banco->fresh(),
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Banco no encontrado.',
            ], 404);
        } catch (\Exception $e) {
            Log::error('Error actualizando banco: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar el banco.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * DELETE /api/bancos/{id}
     */
    public function destroy($id)
    {
        try {
            $banco = Banco::findOrFail($id);

            if ($banco->cuentasBancarias()->exists()) {
                return response()->json([
                    'success' => false,
                    'message' => 'No se puede eliminar el banco porque tiene cuentas bancarias asociadas.',
                ], 409);
            }

            $banco->delete();

            return response()->json([
                'success' => true,
                'message' => 'Banco eliminado exitosamente.',
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Banco no encontrado.',
            ], 404);
        } catch (\Exception $e) {
            Log::error('Error eliminando banco: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar el banco.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
}
