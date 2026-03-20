<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Cliente;
use App\Models\Cotizacion;
use App\Models\CotizacionDetalle;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class InternalCotizacionController extends Controller
{
    /**
     * POST /api/internal/pedido-a-cotizacion
     * Crea una cotización desde el eCommerce (sin auth de usuario, con clave interna).
     *
     * Body JSON:
     * {
     *   "secret": "...",
     *   "pedido_id": 5022,
     *   "cliente_documento": "76165962",
     *   "cliente_nombre": "VICTOR RAUL CANCHARI RIQUI",
     *   "direccion": "INDEPENDENCIA",
     *   "total": 10.70,
     *   "productos": [
     *     { "producto_id": 938, "nombre": "Lapicero", "cantidad": 1, "precio": 9.5 }
     *   ]
     * }
     */
    public function store(Request $request)
    {
        // Validar clave interna
        $secret = config('app.internal_secret');
        if (!$secret || $request->input('secret') !== $secret) {
            return response()->json(['success' => false, 'message' => 'No autorizado'], 401);
        }

        $request->validate([
            'pedido_id'          => 'required|integer',
            'total'              => 'required|numeric|min:0',
            'productos'          => 'required|array|min:1',
            'productos.*.producto_id' => 'required|integer',
            'productos.*.nombre'      => 'required|string',
            'productos.*.cantidad'    => 'required|numeric|min:1',
            'productos.*.precio'      => 'required|numeric|min:0',
        ]);

        DB::beginTransaction();
        try {
            $idEmpresa = 1;

            // Buscar o crear cliente
            $idCliente   = null;
            $clienteNombre = null;
            $doc = $request->input('cliente_documento', '');

            if ($doc) {
                $cliente = Cliente::where('documento', $doc)
                    ->where('id_empresa', $idEmpresa)
                    ->first();

                if (!$cliente) {
                    $tipoDoc = strlen($doc) === 11 ? '6' : (strlen($doc) === 8 ? '1' : '4');
                    $cliente = Cliente::create([
                        'documento'  => $doc,
                        'tipo_doc'   => $tipoDoc,
                        'datos'      => $request->input('cliente_nombre', ''),
                        'direccion'  => $request->input('direccion', ''),
                        'id_empresa' => $idEmpresa,
                    ]);
                }
                $idCliente = $cliente->id_cliente;
            } else {
                $clienteNombre = $request->input('cliente_nombre');
            }

            // Siguiente número correlativo
            $numero = (Cotizacion::where('id_empresa', $idEmpresa)->max('numero') ?? 0) + 1;

            // Calcular IGV (precios incluyen IGV)
            $total    = (float) $request->input('total');
            $subtotal = round($total / 1.18, 2);
            $igv      = round($total - $subtotal, 2);

            // Crear cotización
            $cotizacion = Cotizacion::create([
                'numero'        => $numero,
                'fecha'         => now()->toDateString(),
                'id_cliente'    => $idCliente,
                'cliente_nombre'=> $clienteNombre,
                'direccion'     => $request->input('direccion'),
                'subtotal'      => $subtotal,
                'igv'           => $igv,
                'total'         => $total,
                'descuento'     => 0,
                'aplicar_igv'   => true,
                'moneda'        => 'PEN',
                'estado'        => 'pendiente',
                'id_empresa'    => $idEmpresa,
                'id_usuario'    => 2, // usuario admin del sistema
                'asunto'        => 'Pedido eCommerce #' . $request->input('pedido_id'),
            ]);

            // Crear detalles
            foreach ($request->input('productos') as $prod) {
                $precio    = (float) $prod['precio'];
                $cantidad  = (float) $prod['cantidad'];
                CotizacionDetalle::create([
                    'cotizacion_id'   => $cotizacion->id,
                    'producto_id'     => $prod['producto_id'],
                    'nombre'          => $prod['nombre'],
                    'cantidad'        => $cantidad,
                    'precio_unitario' => $precio,
                    'subtotal'        => round($precio * $cantidad, 2),
                ]);
            }

            DB::commit();

            return response()->json([
                'success'       => true,
                'cotizacion_id' => $cotizacion->id,
                'numero'        => $numero,
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
