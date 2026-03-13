<?php

namespace App\Http\Controllers;

use App\Models\ProductoDeTendencia;
use App\Models\Producto;
use Illuminate\Http\Request;

class ProductoDeTendenciaController extends Controller
{
    public function index(Request $request)
    {
        $items = ProductoDeTendencia::with('producto')
            ->where('tab_name', 'productos_de_tendencia')
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
        $exists = ProductoDeTendencia::where('tab_name', 'productos_de_tendencia')
            ->where('producto_id', $request->producto_id)
            ->first();

        if ($exists) {
            return response()->json([
                'success' => false,
                'message' => 'El producto ya está en tendencia.'
            ], 422);
        }

        $data = $request->all();
        $data['tab_name'] = 'productos_de_tendencia';

        if ($request->hasFile('imagen')) {
            $path = $request->file('imagen')->store('tendencia', 'public');
            $data['imagen'] = $path;
        }

        $productoDeTendencia = ProductoDeTendencia::create($data);

        return response()->json([
            'success' => true,
            'data' => $productoDeTendencia,
            'message' => 'Producto agregado a tendencia exitosamente.'
        ]);
    }

    public function show($id)
    {
        $productoDeTendencia = ProductoDeTendencia::with('producto')->findOrFail($id);
        
        if ($productoDeTendencia->imagen) {
            $productoDeTendencia->imagen_url = asset('storage/' . $productoDeTendencia->imagen);
        }

        return response()->json([
            'success' => true,
            'data' => $productoDeTendencia
        ]);
    }

    public function update(Request $request, $id)
    {
        $productoDeTendencia = ProductoDeTendencia::findOrFail($id);
        
        $request->validate([
            'orden' => 'nullable|integer',
            'estado' => 'nullable|string|max:1',
            'imagen' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:2048'
        ]);

        $data = $request->only(['orden', 'estado']);

        if ($request->hasFile('imagen')) {
            if ($productoDeTendencia->imagen) {
                \Storage::disk('public')->delete($productoDeTendencia->imagen);
            }
            $path = $request->file('imagen')->store('tendencia', 'public');
            $data['imagen'] = $path;
        }

        $productoDeTendencia->update($data);

        return response()->json([
            'success' => true,
            'data' => $productoDeTendencia,
            'message' => 'Producto actualizado exitosamente.'
        ]);
    }

    public function destroy($id)
    {
        $productoDeTendencia = ProductoDeTendencia::findOrFail($id);
        $productoDeTendencia->delete();

        return response()->json([
            'success' => true,
            'message' => 'Producto eliminado de tendencia.'
        ]);
    }
}
