<?php

namespace App\Http\Controllers;

use App\Models\ProductoExclusivo;
use App\Models\Producto;
use Illuminate\Http\Request;

class ProductoExclusivoController extends Controller
{
    public function index(Request $request)
    {
        $query = ProductoExclusivo::with('producto');

        if ($request->tab) {
            $query->where('tab_name', $request->tab);
        }

        $productos = $query->orderBy('orden', 'asc')->get();

        return response()->json([
            'success' => true,
            'data' => $productos
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'tab_name' => 'required|string',
            'producto_id' => 'required|exists:productos,id_producto',
            'orden' => 'nullable|integer',
            'estado' => 'nullable|string|max:1',
            'imagen' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:2048'
        ]);

        // Verificar si ya existe en esa pestaña
        $exists = ProductoExclusivo::where('tab_name', $request->tab_name)
            ->where('producto_id', $request->producto_id)
            ->first();

        if ($exists) {
            return response()->json([
                'success' => false,
                'message' => 'El producto ya está en esta pestaña.'
            ], 422);
        }

        $data = $request->all();

        if ($request->hasFile('imagen')) {
            $path = $request->file('imagen')->store('exclusivos', 'public');
            $data['imagen'] = $path;
        }

        $productoExclusivo = ProductoExclusivo::create($data);

        return response()->json([
            'success' => true,
            'data' => $productoExclusivo,
            'message' => 'Producto agregado a exclusivos exitosamente.'
        ]);
    }

    public function show($id)
    {
        $productoExclusivo = ProductoExclusivo::with('producto')->findOrFail($id);
        
        // Agregar URL completa de imagen si existe
        if ($productoExclusivo->imagen) {
            $productoExclusivo->imagen_url = asset('storage/' . $productoExclusivo->imagen);
        }

        return response()->json([
            'success' => true,
            'data' => $productoExclusivo
        ]);
    }

    public function update(Request $request, $id)
    {
        $productoExclusivo = ProductoExclusivo::findOrFail($id);
        
        $request->validate([
            'orden' => 'nullable|integer',
            'estado' => 'nullable|string|max:1',
            'imagen' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:2048'
        ]);

        $data = $request->only(['orden', 'estado', 'tab_name']);

        if ($request->hasFile('imagen')) {
            // Eliminar imagen anterior si existe
            if ($productoExclusivo->imagen) {
                \Storage::disk('public')->delete($productoExclusivo->imagen);
            }
            $path = $request->file('imagen')->store('exclusivos', 'public');
            $data['imagen'] = $path;
        }

        $productoExclusivo->update($data);

        return response()->json([
            'success' => true,
            'data' => $productoExclusivo,
            'message' => 'Producto actualizado exitosamente.'
        ]);
    }

    public function destroy($id)
    {
        $productoExclusivo = ProductoExclusivo::findOrFail($id);
        $productoExclusivo->delete();

        return response()->json([
            'success' => true,
            'message' => 'Producto eliminado de exclusivos.'
        ]);
    }
}
