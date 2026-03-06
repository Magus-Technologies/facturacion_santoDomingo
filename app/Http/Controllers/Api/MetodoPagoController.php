<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\MetodoPagoRequest;
use App\Models\MetodoPago;
use App\Models\ConfiguracionMetodoPago;
use Illuminate\Http\Request;

class MetodoPagoController extends Controller
{
    public function index()
    {
        try {
            $metodos = MetodoPago::with(['banco', 'cuentaBancaria'])->where('activo', true)->orderBy('nombre')->get();
            
            return response()->json([
                'success' => true,
                'data' => $metodos
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener métodos de pago: ' . $e->getMessage()
            ], 500);
        }
    }

    public function store(MetodoPagoRequest $request)
    {
        $data = $request->validated();

        if ($data['es_efectivo'] ?? false) {
            $data['id_banco']  = null;
            $data['id_cuenta'] = null;
        }

        $metodo = MetodoPago::create($data);

        return response()->json([
            'success' => true,
            'message' => 'Método de pago creado exitosamente',
            'data'    => $metodo->load('cuentaBancaria.banco'),
        ], 201);
    }

    public function show($id)
    {
        try {
            $metodo = MetodoPago::with(['banco', 'cuentaBancaria'])->findOrFail($id);

            return response()->json([
                'success' => true,
                'data' => $metodo
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Método de pago no encontrado'
            ], 404);
        }
    }

    public function update(MetodoPagoRequest $request, $id)
    {
        $metodo = MetodoPago::findOrFail($id);
        $data   = $request->validated();

        if ($data['es_efectivo'] ?? false) {
            $data['id_banco']  = null;
            $data['id_cuenta'] = null;
        }

        $metodo->update($data);

        return response()->json([
            'success' => true,
            'message' => 'Método de pago actualizado exitosamente',
            'data'    => $metodo->load('cuentaBancaria.banco'),
        ]);
    }

    public function destroy($id)
    {
        try {
            $metodo = MetodoPago::findOrFail($id);
            $metodo->delete();

            return response()->json([
                'success' => true,
                'message' => 'Método de pago eliminado exitosamente'
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Método de pago no encontrado'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar método de pago: ' . $e->getMessage()
            ], 500);
        }
    }

    public function configuracionEmpresa(Request $request)
    {
        try {
            $user = $request->user();
            $empresaId = $user->id_empresa;

            $configuraciones = ConfiguracionMetodoPago::where('id_empresa', $empresaId)
                ->with('metodo')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $configuraciones
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener configuración: ' . $e->getMessage()
            ], 500);
        }
    }

    public function guardarConfiguracionEmpresa(Request $request)
    {
        try {
            $user = $request->user();
            $empresaId = $user->id_empresa;

            $validated = $request->validate([
                'id_metodo_pago' => 'required|exists:metodos_pago,id_metodo_pago',
                'habilitado' => 'nullable|boolean',
                'comision' => 'nullable|numeric|min:0',
                'limite_minimo' => 'nullable|numeric|min:0',
                'limite_maximo' => 'nullable|numeric|min:0',
                'requiere_comprobante' => 'nullable|boolean',
                'requiere_referencia' => 'nullable|boolean',
            ]);

            $config = ConfiguracionMetodoPago::updateOrCreate(
                [
                    'id_empresa' => $empresaId,
                    'id_metodo_pago' => $validated['id_metodo_pago']
                ],
                $validated
            );

            return response()->json([
                'success' => true,
                'message' => 'Configuración guardada exitosamente',
                'data' => $config
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error de validación',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al guardar configuración: ' . $e->getMessage()
            ], 500);
        }
    }
}
