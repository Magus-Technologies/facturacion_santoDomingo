<?php

namespace App\Http\Controllers;

use App\Models\ProductoEnRemate;
use App\Models\Producto;
use Illuminate\Http\Request;

class ProductoEnRemateController extends Controller
{
    public function index(Request $request)
    {
        $items = ProductoEnRemate::with('producto')
            ->where('tab_name', 'productos_en_remate')
            ->where('estado', '1')
            ->orderBy('orden', 'asc')
            ->get()
            ->map(function ($item) {
                $prod = $item->producto;
                return [
                    'id'          => $item->id_exclusivo,
                    'producto_id' => $item->producto_id,
                    'nombre'      => $prod?->nombre,
                    'precio'      => $prod?->precio,
                    'stock'       => $prod?->cantidad ?? 0,
                    'imagen_url'  => $item->imagen ? asset('storage/' . $item->imagen) : null,
                    'orden'       => $item->orden,
                    'estado'      => $item->estado,
                ];
            });

        return response()->json(['success' => true, 'data' => $items]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'producto_id' => 'required|exists:productos,id_producto',
            'orden' => 'nullable|integer',
            'estado' => 'nullable|string|max:1',
            'imagen' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:2048'
        ]);

        // Verificar si ya existe
        $exists = ProductoEnRemate::where('tab_name', 'productos_en_remate')
            ->where('producto_id', $request->producto_id)
            ->first();

        if ($exists) {
            return response()->json([
                'success' => false,
                'message' => 'El producto ya está en remate.'
            ], 422);
        }

        $data = $request->all();
        $data['tab_name'] = 'productos_en_remate';

        if ($request->hasFile('imagen')) {
            $path = $request->file('imagen')->store('remate', 'public');
            $data['imagen'] = $path;
        }

        $productoEnRemate = ProductoEnRemate::create($data);

        return response()->json([
            'success' => true,
            'data' => $productoEnRemate,
            'message' => 'Producto agregado a remate exitosamente.'
        ]);
    }

    public function show($id)
    {
        $productoEnRemate = ProductoEnRemate::with('producto')->findOrFail($id);
        
        if ($productoEnRemate->imagen) {
            $productoEnRemate->imagen_url = asset('storage/' . $productoEnRemate->imagen);
        }

        return response()->json([
            'success' => true,
            'data' => $productoEnRemate
        ]);
    }

    public function update(Request $request, $id)
    {
        $productoEnRemate = ProductoEnRemate::findOrFail($id);
        
        $request->validate([
            'orden' => 'nullable|integer',
            'estado' => 'nullable|string|max:1',
            'imagen' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:2048'
        ]);

        $data = $request->only(['orden', 'estado']);

        if ($request->hasFile('imagen')) {
            if ($productoEnRemate->imagen) {
                \Storage::disk('public')->delete($productoEnRemate->imagen);
            }
            $path = $request->file('imagen')->store('remate', 'public');
            $data['imagen'] = $path;
        }

        $productoEnRemate->update($data);

        return response()->json([
            'success' => true,
            'data' => $productoEnRemate,
            'message' => 'Producto actualizado exitosamente.'
        ]);
    }

    public function destroy($id)
    {
        $productoEnRemate = ProductoEnRemate::findOrFail($id);
        $productoEnRemate->delete();

        return response()->json([
            'success' => true,
            'message' => 'Producto eliminado de remate.'
        ]);
    }
}
