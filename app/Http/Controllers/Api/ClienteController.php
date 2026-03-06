<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Cliente;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class ClienteController extends Controller
{
    /**
     * Listar todos los clientes
     */
    public function index(Request $request)
    {
        try {
            $query = Cliente::with('empresa:id_empresa,comercial,ruc')
                ->select(
                    'id_cliente',
                    'documento',
                    'datos',
                    'direccion',
                    'direccion2',
                    'telefono',
                    'telefono2',
                    'email',
                    'foto_url',
                    'id_empresa',
                    'ubigeo',
                    'departamento',
                    'provincia',
                    'distrito',
                    'created_at',
                    'updated_at'
                )
                ->addSelect([
                    'ultima_venta' => DB::table('ventas')
                        ->selectRaw('MAX(fecha_emision)')
                        ->whereColumn('ventas.id_cliente', 'clientes.id_cliente')
                        ->whereNotIn('ventas.estado', ['2', 'A']),
                    'total_venta' => DB::table('ventas')
                        ->selectRaw('COALESCE(SUM(total), 0)')
                        ->whereColumn('ventas.id_cliente', 'clientes.id_cliente')
                        ->whereNotIn('ventas.estado', ['2', 'A']),
                ]);

            // Siempre filtrar por la empresa del usuario autenticado
            $user = $request->user();
            if ($user && $user->id_empresa) {
                $query->byEmpresa($user->id_empresa);
            } elseif ($request->has('empresa_id')) {
                $query->byEmpresa($request->empresa_id);
            }

            // Buscar si se proporciona término de búsqueda
            if ($request->has('search')) {
                $query->search($request->search);
            }

            $clientes = $query->orderBy('created_at', 'desc')->get();

            return response()->json([
                'success' => true,
                'data' => $clientes
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener clientes',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Crear nuevo cliente
     */
    public function store(Request $request)
    {
        try {
            $validated = $request->validate([
                'documento' => [
                    'required',
                    'string',
                    'max:15',
                    Rule::unique('clientes')->where(function ($query) use ($request) {
                        return $query->where('id_empresa', $request->id_empresa);
                    })
                ],
                'tipo_doc' => 'nullable|string|max:1',
                'datos' => 'required|string|max:245',
                'direccion' => 'nullable|string|max:245',
                'direccion2' => 'nullable|string|max:220',
                'telefono' => 'nullable|string|max:200',
                'telefono2' => 'nullable|string|max:200',
                'email' => 'nullable|email|max:200',
                'foto' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                'id_empresa' => 'required|exists:empresas,id_empresa',
                'ubigeo' => 'nullable|string|max:6',
                'departamento' => 'nullable|string|max:100',
                'provincia' => 'nullable|string|max:100',
                'distrito' => 'nullable|string|max:100',
            ], [
                'documento.required' => 'El documento es obligatorio',
                'documento.unique' => 'Este documento ya está registrado para esta empresa',
                'datos.required' => 'El nombre o razón social es obligatorio',
                'id_empresa.required' => 'La empresa es obligatoria',
                'id_empresa.exists' => 'La empresa seleccionada no existe',
                'email.email' => 'El email no es válido',
                'foto.image' => 'El archivo debe ser una imagen',
                'foto.mimes' => 'La imagen debe ser JPEG, PNG, JPG o GIF',
                'foto.max' => 'La imagen no debe exceder 2MB',
            ]);

            if (empty($validated['tipo_doc']) && !empty($validated['documento'])) {
                $doc = $validated['documento'];
                $validated['tipo_doc'] = strlen($doc) === 11 ? '6' : (strlen($doc) === 8 ? '1' : '4');
            }

            // Manejar la foto
            \Log::info('Verificando archivo foto', ['hasFile' => $request->hasFile('foto')]);
            if ($request->hasFile('foto')) {
                \Log::info('Archivo foto encontrado');
                $foto = $request->file('foto');
                \Log::info('Detalles del archivo', [
                    'nombre' => $foto->getClientOriginalName(),
                    'tipo' => $foto->getMimeType(),
                    'tamaño' => $foto->getSize()
                ]);
                $nombreFoto = 'cliente_' . time() . '.' . $foto->getClientOriginalExtension();
                $ruta = $foto->storeAs('clientes', $nombreFoto, 'public');
                $validated['foto_url'] = '/storage/' . $ruta;
                \Log::info('Foto guardada', ['ruta' => $ruta, 'url' => $validated['foto_url']]);
            } else {
                \Log::info('No hay archivo foto en la solicitud');
            }

            $cliente = Cliente::create($validated);

            return response()->json([
                'success' => true,
                'message' => 'Cliente creado exitosamente',
                'data' => $cliente->load('empresa:id_empresa,comercial,ruc')
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
                'message' => 'Error al crear cliente',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Mostrar un cliente específico
     */
    public function show($id)
    {
        try {
            $cliente = Cliente::with('empresa:id_empresa,comercial,ruc,razon_social')
                ->findOrFail($id);

            return response()->json([
                'success' => true,
                'data' => $cliente
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Cliente no encontrado'
            ], 404);
        }
    }

    /**
     * Actualizar cliente
     */
    public function update(Request $request, $id)
    {
        try {
            $cliente = Cliente::findOrFail($id);

            $validated = $request->validate([
                'documento' => [
                    'sometimes',
                    'required',
                    'string',
                    'max:15',
                    Rule::unique('clientes')->where(function ($query) use ($request) {
                        return $query->where('id_empresa', $request->id_empresa ?? $cliente->id_empresa);
                    })->ignore($cliente->id_cliente, 'id_cliente')
                ],
                'tipo_doc' => 'nullable|string|max:1',
                'datos' => 'sometimes|required|string|max:245',
                'direccion' => 'nullable|string|max:245',
                'direccion2' => 'nullable|string|max:220',
                'telefono' => 'nullable|string|max:200',
                'telefono2' => 'nullable|string|max:200',
                'email' => 'nullable|email|max:200',
                'foto' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                'id_empresa' => 'sometimes|required|exists:empresas,id_empresa',
                'ubigeo' => 'nullable|string|max:6',
                'departamento' => 'nullable|string|max:100',
                'provincia' => 'nullable|string|max:100',
                'distrito' => 'nullable|string|max:100',
            ], [
                'documento.unique' => 'Este documento ya está registrado para esta empresa',
                'datos.required' => 'El nombre o razón social es obligatorio',
                'email.email' => 'El email no es válido',
                'foto.image' => 'El archivo debe ser una imagen',
                'foto.mimes' => 'La imagen debe ser JPEG, PNG, JPG o GIF',
                'foto.max' => 'La imagen no debe exceder 2MB',
            ]);

            // Manejar la foto
            \Log::info('Update: Verificando archivo foto', ['hasFile' => $request->hasFile('foto')]);
            if ($request->hasFile('foto')) {
                \Log::info('Update: Archivo foto encontrado');
                $foto = $request->file('foto');
                \Log::info('Update: Detalles del archivo', [
                    'nombre' => $foto->getClientOriginalName(),
                    'tipo' => $foto->getMimeType(),
                    'tamaño' => $foto->getSize()
                ]);
                $nombreFoto = 'cliente_' . time() . '.' . $foto->getClientOriginalExtension();
                $ruta = $foto->storeAs('clientes', $nombreFoto, 'public');
                $validated['foto_url'] = '/storage/' . $ruta;
                \Log::info('Update: Foto guardada', ['ruta' => $ruta, 'url' => $validated['foto_url']]);
            } else {
                \Log::info('Update: No hay archivo foto en la solicitud');
            }

            $cliente->update($validated);

            return response()->json([
                'success' => true,
                'message' => 'Cliente actualizado exitosamente',
                'data' => $cliente->load('empresa:id_empresa,comercial,ruc')
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
                'message' => 'Cliente no encontrado'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar cliente',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Eliminar cliente
     */
    public function destroy($id)
    {
        try {
            $cliente = Cliente::findOrFail($id);

            if ($cliente->ventas()->exists()) {
                return response()->json([
                    'success' => false,
                    'message' => 'No se puede eliminar el cliente porque tiene ventas asociadas'
                ], 409);
            }

            $cliente->delete();

            return response()->json([
                'success' => true,
                'message' => 'Cliente eliminado exitosamente'
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Cliente no encontrado'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar cliente',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Buscar cliente por documento
     */
    public function buscarPorDocumento(Request $request)
    {
        try {
            $request->validate([
                'documento' => 'required|string',
                'empresa_id' => 'required|exists:empresas,id_empresa'
            ]);

            $cliente = Cliente::where('documento', $request->documento)
                ->where('id_empresa', $request->empresa_id)
                ->with('empresa:id_empresa,comercial,ruc')
                ->first();

            if (!$cliente) {
                return response()->json([
                    'success' => false,
                    'message' => 'Cliente no encontrado'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $cliente
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al buscar cliente',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
