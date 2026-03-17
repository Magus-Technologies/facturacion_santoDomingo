<?php

namespace App\Http\Controllers;

use App\Models\Oferta;
use App\Models\Producto;
use App\Http\Requests\OfertaRequest;
use App\Http\Resources\OfertaResource;
use Illuminate\Http\Request;

class OfertaController extends Controller
{
    /**
     * GET /api/ofertas
     * Listar todas las ofertas (admin)
     */
    public function index(Request $request)
    {
        try {
            $user = $request->user();
            $idEmpresa = $request->header('X-Empresa-Activa') ?: $user->id_empresa;

            $query = Oferta::where('id_empresa', $idEmpresa);

            // Filtros
            if ($request->has('estado')) {
                $query->where('estado', $request->get('estado'));
            }

            if ($request->has('tipo')) {
                $query->where('tipo', $request->get('tipo'));
            }

            if ($request->has('vigentes')) {
                if ($request->boolean('vigentes')) {
                    $query->vigente();
                }
            }

            $ofertas = $query->with('producto')
                ->orderBy('fecha_inicio', 'desc')
                ->paginate(15);

            return response()->json([
                'success' => true,
                'data' => OfertaResource::collection($ofertas->items()),
                'pagination' => [
                    'total' => $ofertas->total(),
                    'per_page' => $ofertas->perPage(),
                    'current_page' => $ofertas->currentPage(),
                    'last_page' => $ofertas->lastPage(),
                ],
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener ofertas: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * POST /api/ofertas
     * Crear nueva oferta
     */
    public function store(OfertaRequest $request)
    {
        try {
            $user = $request->user();
            $data = $request->validated();
            $data['id_empresa'] = $request->header('X-Empresa-Activa') ?: $user->id_empresa;

            // Calcular precio final
            $producto = Producto::findOrFail($data['id_producto']);
            $data['precio_final'] = $this->calcularPrecioFinal(
                $producto->precio,
                $data['tipo'],
                $data['valor']
            );

            $oferta = Oferta::create($data);

            return response()->json([
                'success' => true,
                'message' => 'Oferta creada exitosamente',
                'data' => new OfertaResource($oferta),
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al crear oferta: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * GET /api/ofertas/{id}
     * Obtener detalle de una oferta
     */
    public function show($id)
    {
        try {
            $oferta = Oferta::with('producto')->findOrFail($id);

            return response()->json([
                'success' => true,
                'data' => new OfertaResource($oferta),
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Oferta no encontrada'
            ], 404);
        }
    }

    /**
     * PUT /api/ofertas/{id}
     * Actualizar oferta
     */
    public function update(OfertaRequest $request, $id)
    {
        try {
            $oferta = Oferta::findOrFail($id);
            $data = $request->validated();

            // Recalcular precio final si cambió tipo o valor
            if (isset($data['tipo']) || isset($data['valor'])) {
                $producto = $oferta->producto;
                $data['precio_final'] = $this->calcularPrecioFinal(
                    $producto->precio,
                    $data['tipo'] ?? $oferta->tipo,
                    $data['valor'] ?? $oferta->valor
                );
            }

            $oferta->update($data);

            return response()->json([
                'success' => true,
                'message' => 'Oferta actualizada exitosamente',
                'data' => new OfertaResource($oferta),
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar oferta: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * DELETE /api/ofertas/{id}
     * Eliminar oferta
     */
    public function destroy($id)
    {
        try {
            $oferta = Oferta::findOrFail($id);
            $oferta->delete();

            return response()->json([
                'success' => true,
                'message' => 'Oferta eliminada exitosamente',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar oferta: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * GET /api/public/ofertas/vigentes
     * Listar ofertas vigentes (público)
     */
    public function vigentes()
    {
        try {
            $ofertas = Oferta::vigente()
                ->with('producto')
                ->orderBy('fecha_inicio', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => OfertaResource::collection($ofertas),
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener ofertas vigentes: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * GET /api/productos/{id}/ofertas
     * Obtener ofertas de un producto específico
     */
    public function porProducto($idProducto)
    {
        try {
            $producto = Producto::findOrFail($idProducto);
            $ofertas = $producto->ofertas()->orderBy('fecha_inicio', 'desc')->get();

            return response()->json([
                'success' => true,
                'data' => OfertaResource::collection($ofertas),
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener ofertas del producto: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Calcular precio final según tipo de descuento
     */
    private function calcularPrecioFinal(float $precioBase, string $tipo, float $valor): float
    {
        if ($tipo === 'porcentaje') {
            return $precioBase * (1 - $valor / 100);
        }
        return max(0, $precioBase - $valor);
    }
}
