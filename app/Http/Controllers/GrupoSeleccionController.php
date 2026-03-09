<?php

namespace App\Http\Controllers;

use App\Models\GrupoSeleccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class GrupoSeleccionController extends Controller
{
    public function index()
    {
        try {
            $grupos = GrupoSeleccion::orderBy('id_seleccion', 'desc')->get();
            return response()->json([
                'success' => true,
                'data' => $grupos
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener los grupos de selección: ' . $e->getMessage()
            ], 500);
        }
    }

    public function store(Request $request)
    {
        try {
            $request->validate([
                'nombre_cate' => 'required|string|max:100',
                'codi_categoria' => 'nullable|string|max:50',
                'imagen' => 'required|image|mimes:jpeg,png,jpg,gif,webp|max:2048',
                'estado' => 'nullable|string|max:1'
            ]);

            $path = null;
            if ($request->hasFile('imagen')) {
                $path = $request->file('imagen')->store('banners', 'public');
            }

            $grupo = GrupoSeleccion::create([
                'nombre_cate' => $request->nombre_cate,
                'codi_categoria' => $request->codi_categoria ?? '',
                'imagen' => $path,
                'estado' => $request->estado ?? '1'
            ]);

            return response()->json([
                'success' => true,
                'data' => $grupo,
                'message' => 'Grupo de selección creado exitosamente'
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al crear el grupo de selección: ' . $e->getMessage()
            ], 500);
        }
    }

    public function show($id)
    {
        try {
            $grupo = GrupoSeleccion::findOrFail($id);
            return response()->json([
                'success' => true,
                'data' => $grupo
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Grupo de selección no encontrado'
            ], 404);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $grupo = GrupoSeleccion::findOrFail($id);

            $request->validate([
                'nombre_cate' => 'sometimes|string|max:100',
                'codi_categoria' => 'nullable|string|max:50',
                'imagen' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:2048',
                'estado' => 'nullable|string|max:1'
            ]);

            $dataToUpdate = [
                'nombre_cate' => $request->nombre_cate ?? $grupo->nombre_cate,
                'codi_categoria' => $request->codi_categoria ?? $grupo->codi_categoria,
                'estado' => $request->estado ?? $grupo->estado
            ];

            if ($request->hasFile('imagen')) {
                // Eliminar imagen anterior si existe
                if ($grupo->imagen && Storage::disk('public')->exists($grupo->imagen)) {
                    Storage::disk('public')->delete($grupo->imagen);
                }
                
                $dataToUpdate['imagen'] = $request->file('imagen')->store('banners', 'public');
            }

            $grupo->update($dataToUpdate);

            // Refrescar para tener el imagen_url actualizado
            $grupo->refresh();

            return response()->json([
                'success' => true,
                'data' => $grupo,
                'message' => 'Grupo de selección actualizado exitosamente'
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Grupo de selección no encontrado'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar el grupo de selección: ' . $e->getMessage()
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $grupo = GrupoSeleccion::findOrFail($id);
            
            if ($grupo->imagen && Storage::disk('public')->exists($grupo->imagen)) {
                Storage::disk('public')->delete($grupo->imagen);
            }
            
            $grupo->delete();

            return response()->json([
                'success' => true,
                'message' => 'Grupo de selección eliminado exitosamente'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar el grupo de selección: ' . $e->getMessage()
            ], 500);
        }
    }
}
