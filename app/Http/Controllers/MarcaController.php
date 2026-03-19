<?php

namespace App\Http\Controllers;

use App\Models\Marca;
use App\Http\Resources\MarcaResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class MarcaController extends Controller
{
    /** GET /api/marcas — admin (todas) */
    public function index(): JsonResponse
    {
        $marcas = Marca::orderBy('nombre_marca')->get();

        return response()->json([
            'success' => true,
            'data'    => MarcaResource::collection($marcas),
        ]);
    }

    /** GET /api/public/marcas — ecommerce (solo activas) */
    public function public(): JsonResponse
    {
        $marcas = Marca::where('estado', '1')->orderBy('nombre_marca')->get();

        return response()->json([
            'success' => true,
            'data'    => MarcaResource::collection($marcas),
        ]);
    }

    /**
     * PUT /api/marcas/{cod}
     * Solo actualiza imagen y/o estado (visible en ecommerce).
     */
    public function update(Request $request, string $cod): JsonResponse
    {
        $marca = Marca::findOrFail($cod);

        $request->validate([
            'imagen'  => 'nullable|image|mimes:jpeg,png,gif,webp|max:2048',
            'estado'  => 'nullable|in:0,1',
        ]);

        if ($request->hasFile('imagen')) {
            if ($marca->imagen && Storage::disk('public')->exists($marca->imagen)) {
                Storage::disk('public')->delete($marca->imagen);
            }
            $marca->imagen = $request->file('imagen')->store('marcas', 'public');
        }

        if ($request->has('estado')) {
            $marca->estado = $request->estado;
        }

        $marca->save();

        return response()->json([
            'success' => true,
            'data'    => new MarcaResource($marca),
            'message' => 'Marca actualizada',
        ]);
    }

    /**
     * DELETE /api/marcas/{cod}/imagen
     * Elimina solo la imagen de la marca.
     */
    public function destroyImagen(string $cod): JsonResponse
    {
        $marca = Marca::findOrFail($cod);

        if ($marca->imagen && Storage::disk('public')->exists($marca->imagen)) {
            Storage::disk('public')->delete($marca->imagen);
        }

        $marca->imagen = null;
        $marca->save();

        return response()->json([
            'success' => true,
            'message' => 'Imagen eliminada',
        ]);
    }

    /**
     * DELETE /api/marcas/{cod}
     * Oculta la marca del ecommerce (estado = '0'). No elimina el registro.
     */
    public function destroy(string $cod): JsonResponse
    {
        $marca = Marca::findOrFail($cod);
        $marca->estado = '0';
        $marca->save();

        return response()->json([
            'success' => true,
            'message' => 'Marca ocultada del ecommerce',
        ]);
    }
}
