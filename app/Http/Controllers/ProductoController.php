<?php

namespace App\Http\Controllers;

use App\Models\Producto;
use App\Http\Requests\ProductoRequest;
use App\Services\ProductoService;
use Illuminate\Http\Request;

class ProductoController extends Controller
{
    public function __construct(
        private ProductoService $productoService
    ) {}

    public function index(Request $request)
    {
        try {
            $user = $request->user();
            $productos = $this->productoService->listar(
                $user->id_empresa,
                $request->get('almacen', '1'),
                $request->get('search'),
                $request->boolean('solo_con_stock', false)
            );

            return response()->json(['success' => true, 'data' => $productos]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener productos: ' . $e->getMessage()
            ], 500);
        }
    }

    public function show($id)
    {
        try {
            $producto = Producto::with(['categoria', 'unidad'])->findOrFail($id);
            return response()->json(['success' => true, 'data' => $producto]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Producto no encontrado'
            ], 404);
        }
    }

    public function store(ProductoRequest $request)
    {
        try {
            $data = $request->validated();

            if ($request->hasFile('imagen')) {
                $data['imagen'] = $this->productoService->subirImagen($request->file('imagen'));
            }

            $producto = $this->productoService->crear($data, $request->user()->id_empresa);

            return response()->json([
                'success' => true,
                'message' => 'Producto creado exitosamente en ambos almacenes',
                'data' => $producto,
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al crear producto: ' . $e->getMessage()
            ], 500);
        }
    }

    public function update(ProductoRequest $request, $id)
    {
        try {
            $producto = Producto::findOrFail($id);
            $data = $request->except(['imagen']);

            if ($request->hasFile('imagen')) {
                $data['imagen'] = $this->productoService->subirImagen(
                    $request->file('imagen'),
                    $producto->imagen
                );
            }

            $resultado = $this->productoService->actualizar($producto, $data);

            return response()->json([
                'success' => true,
                'message' => 'Producto actualizado exitosamente' . ($resultado['sincronizado'] ? ' (sincronizado en ambos almacenes)' : ''),
                'data' => $resultado['producto'],
                'sincronizado' => $resultado['sincronizado'],
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar producto: ' . $e->getMessage()
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $producto = Producto::findOrFail($id);
            $this->productoService->eliminar($producto);

            return response()->json([
                'success' => true,
                'message' => 'Producto eliminado exitosamente'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar producto: ' . $e->getMessage()
            ], 500);
        }
    }
}
