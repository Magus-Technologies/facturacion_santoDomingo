<?php

namespace App\Http\Controllers;

use App\Models\BannerInferior;
use App\Http\Resources\BannerPromocionalResource;
use Illuminate\Http\Request;

class BannerPromocionalController extends Controller
{
    /**
     * GET /api/banners-promocionales
     * Obtiene lista de banners promocionales
     */
    public function index()
    {
        try {
            $banners = BannerInferior::all();
            return response()->json([
                'success' => true,
                'data' => BannerPromocionalResource::collection($banners),
                'message' => 'Banners obtenidos exitosamente'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener banners',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * POST /api/banners-promocionales
     * Crea un nuevo banner promocional
     */
    public function store(\App\Http\Requests\BannerPromocionalRequest $request)
    {
        \Log::info('=== STORE INICIADO ===');
        \Log::info('Content-Type: ' . $request->header('Content-Type'));
        \Log::info('Has file imagen: ' . ($request->hasFile('imagen') ? 'SI' : 'NO'));
        \Log::info('Request all: ' . json_encode($request->all()));
        \Log::info('Request files: ' . json_encode(array_keys($request->allFiles())));

        try {
            // El Form Request ya validó
            $file = $request->file('imagen');
            
            \Log::info('Archivo recibido:', [
                'nombre' => $file->getClientOriginalName(),
                'tamaño' => $file->getSize(),
                'mime' => $file->getMimeType(),
                'temp_path' => $file->getRealPath(),
            ]);

            // Guardar
            $imagenPath = $file->store('banners', 'public');
            \Log::info('Archivo guardado:', [
                'ruta' => $imagenPath,
                'existe' => \Storage::disk('public')->exists($imagenPath),
            ]);

            $banner = BannerInferior::create([
                'imagen' => $imagenPath,
                'url' => $request->url,
                'estado' => $request->estado,
            ]);

            \Log::info('Banner creado:', ['id' => $banner->id]);

            return response()->json([
                'success' => true,
                'data' => new BannerPromocionalResource($banner),
                'message' => 'Banner creado exitosamente'
            ], 201);

        } catch (\Exception $e) {
            \Log::error('Error:', [
                'mensaje' => $e->getMessage(),
                'archivo' => $e->getFile(),
                'linea' => $e->getLine(),
            ]);
            return response()->json([
                'success' => false,
                'message' => 'Error al crear banner',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * GET /api/banners-inferiores/{id}
     * Obtiene un banner específico
     */
    public function show($id)
    {
        try {
            $banner = BannerInferior::findOrFail($id);
            return response()->json([
                'success' => true,
                'data' => new BannerPromocionalResource($banner),
                'message' => 'Banner obtenido exitosamente'
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Banner no encontrado'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener banner',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * PUT /api/banners-promocionales/{id}
     * Actualiza un banner
     */
    public function update(Request $request, $id)
    {
        try {
            $banner = BannerInferior::findOrFail($id);

            $validated = $request->validate([
                'imagen' => 'sometimes|image|mimes:jpeg,png,gif,webp|max:2048',
                'url' => 'sometimes|string|max:255',
                'estado' => 'sometimes|in:0,1',
            ]);

            // Si hay archivo nuevo, guardar y eliminar el anterior
            if ($request->hasFile('imagen')) {
                // Eliminar archivo anterior si existe
                if ($banner->imagen && \Storage::disk('public')->exists($banner->imagen)) {
                    \Storage::disk('public')->delete($banner->imagen);
                }
                $imagenPath = $request->file('imagen')->store('banners', 'public');
                $validated['imagen'] = $imagenPath;
            }

            $banner->update($validated);

            return response()->json([
                'success' => true,
                'data' => new BannerPromocionalResource($banner),
                'message' => 'Banner actualizado exitosamente'
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Banner no encontrado'
            ], 404);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validación fallida',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar banner',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * DELETE /api/banners-inferiores/{id}
     * Elimina un banner
     */
    public function destroy($id)
    {
        try {
            $banner = BannerInferior::findOrFail($id);
            $banner->delete();

            return response()->json([
                'success' => true,
                'message' => 'Banner eliminado exitosamente'
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Banner no encontrado'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar banner',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
