<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
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

            $idEmpresa = $request->header('X-Empresa-Activa') ?: $user->id_empresa;
            $almacenId = (int) $request->get('almacen', 0);

            // Si no se envía almacén, usar el principal
            if (!$almacenId) {
                $principal = Almacen::where('id_empresa', $idEmpresa)->principal()->activo()->first();
                $almacenId = $principal?->id ?? 1;
            }

            $productos = $this->productoService->listar(
                $idEmpresa,
                $almacenId,
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
            $user = $request->user();
            $data = $request->validated();

            $idEmpresa = $request->header('X-Empresa-Activa') ?: $user->id_empresa;

            if ($request->hasFile('imagen')) {
                $data['imagen'] = $this->productoService->subirImagen($request->file('imagen'));
            }

            $producto = $this->productoService->crear($data, $idEmpresa);

            // Replicar a almacenes hijos si se solicitó (solo desde almacén principal)
            $replicarHijos = filter_var($request->input('replicar_hijos', false), FILTER_VALIDATE_BOOLEAN);
            $hijosReplicados = 0;

            if ($replicarHijos) {
                $almacenActual = Almacen::find($data['almacen']);

                if ($almacenActual && $almacenActual->es_principal) {
                    $hijos = Almacen::where('id_padre', $almacenActual->id)
                        ->where('estado', '1')
                        ->pluck('id');

                    foreach ($hijos as $hijoId) {
                        $existe = Producto::where('id_empresa', $idEmpresa)
                            ->where('almacen', $hijoId)
                            ->where('nombre', $data['nombre'])
                            ->exists();

                        if (!$existe) {
                            $dataHijo = array_merge($data, [
                                'almacen' => $hijoId,
                                'imagen' => $producto->imagen ?? null,
                            ]);
                            unset($dataHijo['replicar_hijos']);
                            $this->productoService->crear($dataHijo, $idEmpresa);
                            $hijosReplicados++;
                        }
                    }
                }
            }

            $mensaje = 'Producto creado exitosamente';
            if ($hijosReplicados > 0) {
                $mensaje .= " y replicado a {$hijosReplicados} almacén(es) hijo(s)";
            }

            return response()->json([
                'success' => true,
                'message' => $mensaje,
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
                'message' => 'Producto actualizado exitosamente',
                'data' => $resultado['producto'],
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
