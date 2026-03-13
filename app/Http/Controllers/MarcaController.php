<?php

namespace App\Http\Controllers;

use App\Models\Marca;
use App\Http\Resources\MarcaResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

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

    /** POST /api/marcas */
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'cod_marca'    => 'required|string|max:50|unique:marcra_productos,cod_marca',
            'nombre_marca' => 'required|string|max:255',
            'descripcion'  => 'nullable|string',
            'imagen'       => 'nullable|image|mimes:jpeg,png,gif,webp|max:2048',
            'estado'       => 'nullable|in:0,1',
        ]);

        $data = $request->only(['cod_marca', 'nombre_marca', 'descripcion', 'estado']);

        if ($request->hasFile('imagen')) {
            $data['imagen'] = $request->file('imagen')->store('marcas', 'public');
        }

        $marca = Marca::create($data);

        return response()->json([
            'success' => true,
            'data'    => new MarcaResource($marca),
            'message' => 'Marca creada exitosamente',
        ], 201);
    }

    /** PUT /api/marcas/{cod} */
    public function update(Request $request, string $cod): JsonResponse
    {
        $marca = Marca::findOrFail($cod);

        $request->validate([
            'nombre_marca' => 'sometimes|string|max:255',
            'descripcion'  => 'nullable|string',
            'imagen'       => 'nullable|image|mimes:jpeg,png,gif,webp|max:2048',
            'estado'       => 'nullable|in:0,1',
        ]);

        $data = $request->only(['nombre_marca', 'descripcion', 'estado']);

        if ($request->hasFile('imagen')) {
            if ($marca->imagen && \Storage::disk('public')->exists($marca->imagen)) {
                \Storage::disk('public')->delete($marca->imagen);
            }
            $data['imagen'] = $request->file('imagen')->store('marcas', 'public');
        }

        $marca->update($data);

        return response()->json([
            'success' => true,
            'data'    => new MarcaResource($marca),
            'message' => 'Marca actualizada exitosamente',
        ]);
    }

    /** DELETE /api/marcas/{cod} */
    public function destroy(string $cod): JsonResponse
    {
        $marca = Marca::findOrFail($cod);

        if ($marca->imagen && \Storage::disk('public')->exists($marca->imagen)) {
            \Storage::disk('public')->delete($marca->imagen);
        }

        $marca->delete();

        return response()->json([
            'success' => true,
            'message' => 'Marca eliminada exitosamente',
        ]);
    }
}
