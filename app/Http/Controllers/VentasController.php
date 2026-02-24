<?php

namespace App\Http\Controllers;

use App\Models\Venta;
use App\Models\ProductoVenta;
use App\Models\VentaServicio;
use App\Models\VentaPago;
use App\Models\Cliente;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\ValidationException;

class VentasController extends Controller
{
    /**
     * Listar todas las ventas
     */
    public function index(Request $request): JsonResponse
    {
        try {
            $user = $request->user();

            $ventas = Venta::with(['cliente', 'tipoDocumento', 'pagos'])
                ->where('id_empresa', $user->id_empresa)
                ->orderBy('fecha_emision', 'desc')
                ->orderBy('numero', 'desc')
                ->get()
                ->map(function ($venta) {
                    $pago = $venta->pagos->first();
                    return [
                        'id_venta' => $venta->id_venta,
                        'id_tido' => $venta->id_tido,
                        'serie' => $venta->serie,
                        'numero' => $venta->numero,
                        'fecha_emision' => $venta->fecha_emision?->format('Y-m-d'),
                        'cliente' => [
                            'documento' => $venta->cliente?->documento,
                            'datos' => $venta->cliente?->datos,
                        ],
                        'tipo_documento' => [
                            'abreviatura' => $venta->tipoDocumento?->abreviatura,
                        ],
                        'subtotal' => $venta->subtotal,
                        'igv' => $venta->igv,
                        'total' => $venta->total,
                        'tipo_moneda' => $venta->tipo_moneda,
                        'id_tipo_pago' => $venta->id_tipo_pago,
                        'metodo_pago' => $pago ? $pago->id_tipo_pago : null,
                        'voucher' => $pago && $pago->voucher ? $pago->voucher : null,
                        'estado' => $venta->estado,
                        'estado_sunat' => $venta->estado_sunat,
                        'afecta_stock' => $venta->afecta_stock,
                        'stock_real_descontado' => $venta->stock_real_descontado,
                    ];
                });

            return response()->json([
                'success' => true,
                'ventas' => $ventas,
            ]);
        } catch (\Exception $e) {
            Log::error('Error al listar ventas: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al cargar las ventas',
            ], 500);
        }
    }

    /**
     * Crear una nueva venta
     */
    public function store(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'id_tido' => 'required|integer|exists:documentos_sunat,id_tido',
                'id_tipo_pago' => 'nullable|integer',
                'id_cliente' => 'nullable|integer|exists:clientes,id_cliente',
                'cliente_documento' => 'required_without:id_cliente|string|max:11',
                'cliente_datos' => 'required_without:id_cliente|string|max:250',
                'cliente_direccion' => 'nullable|string|max:500',
                'fecha_emision' => 'required|date',
                'serie' => 'required|string|max:4',
                'numero' => 'required|integer',
                'subtotal' => 'required|numeric|min:0',
                'igv' => 'required|numeric|min:0',
                'total' => 'required|numeric|min:0',
                'tipo_moneda' => 'required|in:PEN,USD',
                'afecta_stock' => 'nullable|boolean',
                'cotizacion_id' => 'nullable|integer|exists:cotizaciones,id',
                'nota_venta_id' => 'nullable|integer|exists:ventas,id_venta',
                'empresas_ids' => 'nullable|array',
                'empresas_ids.*' => 'integer|exists:empresas,id_empresa',
                'productos' => 'required|array|min:1',
                'productos.*.id_producto' => 'required|integer|exists:productos,id_producto',
                'productos.*.cantidad' => 'required|integer|min:1',
                'productos.*.precio_unitario' => 'required|numeric|min:0',
                'productos.*.subtotal' => 'required|numeric|min:0',
                'productos.*.igv' => 'required|numeric|min:0',
                'productos.*.total' => 'required|numeric|min:0',
                'pago_id_tipo_pago' => 'nullable|integer',
                'pago_numero_operacion' => 'nullable|string|max:50',
                'pago_banco' => 'nullable|string|max:100',
                'pago_voucher' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:2048',
            ], [
                'id_tido.required' => 'El tipo de documento es obligatorio.',
                'cliente_documento.required_without' => 'El documento del cliente es obligatorio.',
                'cliente_datos.required_without' => 'El nombre del cliente es obligatorio.',
                'productos.required' => 'Debe agregar al menos un producto a la venta.',
                'productos.min' => 'Debe agregar al menos un producto a la venta.',
                'productos.*.id_producto.required' => 'El producto seleccionado no es válido.',
                'productos.*.id_producto.exists' => 'El producto seleccionado no existe en la base de datos.',
                'productos.*.cantidad.required' => 'La cantidad es obligatoria.',
                'productos.*.cantidad.min' => 'La cantidad debe ser mayor a 0.',
                'productos.*.precio_unitario.required' => 'El precio unitario es obligatorio.',
            ]);

            $user = $request->user();

            return DB::transaction(function () use ($validated, $user, $request) {
                $idCliente = $validated['id_cliente'];

                // Si no hay id_cliente, buscar por documento o crear
                if (!$idCliente) {
                    $clienteModel = \App\Models\Cliente::where('documento', $validated['cliente_documento'])
                        ->where('id_empresa', $user->id_empresa)
                        ->first();
                    
                    if (!$clienteModel) {
                        $clienteModel = \App\Models\Cliente::create([
                            'documento' => $validated['cliente_documento'],
                            'datos' => $validated['cliente_datos'],
                            'direccion' => $validated['cliente_direccion'] ?? '',
                            'id_empresa' => $user->id_empresa,
                        ]);
                    }
                    $idCliente = $clienteModel->id_cliente;
                }

                // Obtener el próximo número para la serie
                $ultimaVenta = Venta::where('id_empresa', $user->id_empresa)
                    ->where('serie', $validated['serie'])
                    ->orderBy('numero', 'desc')
                    ->first();
                
                $proximoNumero = $ultimaVenta ? $ultimaVenta->numero + 1 : 1;
                
                // Crear venta
                $venta = Venta::create([
                    'id_tido' => $validated['id_tido'],
                    'id_tipo_pago' => $validated['id_tipo_pago'] ?? 1,
                    'id_cliente' => $idCliente,
                    'fecha_emision' => $validated['fecha_emision'],
                    'serie' => $validated['serie'],
                    'numero' => $proximoNumero, // Usar el número calculado
                    'subtotal' => $validated['subtotal'],
                    'igv' => $validated['igv'],
                    'total' => $validated['total'],
                    'tipo_moneda' => $validated['tipo_moneda'],
                    'afecta_stock' => $validated['id_tido'] == 6 ? false : ($validated['afecta_stock'] ?? true),
                    'estado' => '1',
                    'estado_sunat' => '0',
                    'id_empresa' => $user->id_empresa,
                    'id_usuario' => $user->id,
                    'fecha_registro' => now(),
                    'direccion' => '',
                    'cotizacion_id' => $validated['cotizacion_id'] ?? null,
                    'nota_venta_id' => $validated['nota_venta_id'] ?? null,
                ]);

                $afectaStock = $validated['id_tido'] == 6 ? false : ($validated['afecta_stock'] ?? true);

                // Crear productos de la venta y descontar stock
                foreach ($validated['productos'] as $producto) {
                    ProductoVenta::create([
                        'id_venta' => $venta->id_venta,
                        'id_producto' => $producto['id_producto'],
                        'cantidad' => $producto['cantidad'],
                        'precio_unitario' => $producto['precio_unitario'],
                        'subtotal' => $producto['subtotal'],
                        'igv' => $producto['igv'],
                        'total' => $producto['total'],
                        'unidad_medida' => $producto['unidad_medida'] ?? 'NIU',
                        'tipo_afectacion_igv' => $producto['tipo_afectacion_igv'] ?? '10',
                    ]);

                    // Descontar stock del producto si aplica
                    if ($afectaStock) {
                        $productoModel = \App\Models\Producto::find($producto['id_producto']);
                        if ($productoModel) {
                            $productoModel->decrement('cantidad', $producto['cantidad']);
                            $productoModel->update(['ultima_salida' => now()]);
                        }
                    }
                }

                // Guardar empresas seleccionadas en tabla pivot
                if (!empty($validated['empresas_ids'])) {
                    $venta->empresas()->attach($validated['empresas_ids']);
                }

                // Guardar pago si viene info de método de pago
                if ($request->has('pago_id_tipo_pago') && $request->pago_id_tipo_pago) {
                    $voucherPath = null;
                    if ($request->hasFile('pago_voucher')) {
                        $file = $request->file('pago_voucher');
                        $filename = 'voucher_' . $venta->id_venta . '_' . time() . '.' . $file->getClientOriginalExtension();
                        $voucherPath = $file->storeAs('vouchers', $filename, 'public');
                    }

                    VentaPago::create([
                        'id_venta' => $venta->id_venta,
                        'id_tipo_pago' => $request->pago_id_tipo_pago,
                        'monto' => $venta->total,
                        'fecha_pago' => $venta->fecha_emision,
                        'numero_operacion' => $request->pago_numero_operacion,
                        'banco' => $request->pago_banco,
                        'voucher' => $voucherPath,
                        'tipo_moneda' => $venta->tipo_moneda,
                    ]);
                }

                // Si viene de una cotización → cambiar su estado a 'aprobada'
                if (!empty($validated['cotizacion_id'])) {
                    \App\Models\Cotizacion::where('id', $validated['cotizacion_id'])
                        ->where('id_empresa', $user->id_empresa)
                        ->update(['estado' => 'aprobada']);
                }

                // Si viene de una nota de venta → marcar como 'vendida' (estado 3)
                if (!empty($validated['nota_venta_id'])) {
                    Venta::where('id_venta', $validated['nota_venta_id'])
                        ->where('id_empresa', $user->id_empresa)
                        ->where('id_tido', 6) // Solo notas de venta
                        ->update(['estado' => '3']);
                }

                return response()->json([
                    'success' => true,
                    'message' => 'Venta creada exitosamente',
                    'venta' => [
                        'id_venta' => $venta->id_venta,
                        'numero_completo' => $venta->serie . '-' . str_pad($venta->numero, 6, '0', STR_PAD_LEFT),
                    ],
                ], 201);
            });
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error de validación',
                'errors' => $e->errors(),
            ], 422);
        } catch (\Exception $e) {
            Log::error('Error al crear venta: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al crear la venta',
            ], 500);
        }
    }

    /**
     * Ver detalle de una venta
     */
    public function show(Request $request, int $id): JsonResponse
    {
        try {
            $user = $request->user();

            $venta = Venta::with([
                'cliente',
                'tipoDocumento',
                'productosVentas.producto',
                'serviciosVentas',
                'cuotas',
                'pagos',
            ])
                ->where('id_empresa', $user->id_empresa)
                ->findOrFail($id);

            return response()->json([
                'success' => true,
                'venta' => $venta,
            ]);
        } catch (\Exception $e) {
            Log::error('Error al obtener venta: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Venta no encontrada',
            ], 404);
        }
    }

    /**
     * Anular una venta
     */
    public function anular(Request $request, int $id): JsonResponse
    {
        try {
            $validated = $request->validate([
                'motivo_anulacion' => 'required|string|max:500',
            ]);

            $user = $request->user();

            return DB::transaction(function () use ($id, $validated, $user, $request) {
                $venta = Venta::with(['productosVentas.producto'])
                    ->where('id_empresa', $user->id_empresa)
                    ->where('estado', '1')
                    ->findOrFail($id);

                // Cambiar estado de la venta
                $venta->update(['estado' => '2']);
                
                // NUEVO: Retornar stock al almacén correcto si afectó stock
                if ($venta->afecta_stock) {
                    foreach ($venta->productosVentas as $detalle) {
                        $producto = $detalle->producto;
                        if ($producto) {
                            // Incrementar stock del producto
                            $producto->increment('cantidad', $detalle->cantidad);
                            
                            Log::info("Stock retornado al anular venta", [
                                'id_producto' => $producto->id_producto,
                                'codigo' => $producto->codigo,
                                'almacen' => $producto->almacen,
                                'cantidad_retornada' => $detalle->cantidad,
                                'stock_nuevo' => $producto->fresh()->cantidad
                            ]);
                        }
                    }
                }

                // Registrar anulación
                DB::table('ventas_anuladas')->insert([
                    'id_venta' => $venta->id_venta,
                    'id_usuario' => $user->id,
                    'motivo_anulacion' => $validated['motivo_anulacion'],
                    'fecha_anulacion' => now(),
                    'tipo_documento' => $venta->tipoDocumento->cod_sunat ?? '',
                    'serie' => $venta->serie,
                    'numero' => $venta->numero,
                    'total_anulado' => $venta->total,
                    'estado_comunicacion_baja' => '0',
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                return response()->json([
                    'success' => true,
                    'message' => 'Venta anulada exitosamente' . ($venta->afecta_stock ? ' (stock retornado)' : ''),
                ]);
            });
        } catch (\Exception $e) {
            Log::error('Error al anular venta: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al anular la venta',
            ], 500);
        }
    }

    /**
     * Descontar stock del almacén 2 (real) para cualquier venta
     */
    public function descontarStock(Request $request, int $id): JsonResponse
    {
        try {
            $user = $request->user();

            return DB::transaction(function () use ($id, $user) {
                $venta = Venta::with(['productosVentas'])
                    ->where('id_empresa', $user->id_empresa)
                    ->where('estado', '1')
                    ->where('stock_real_descontado', false)
                    ->findOrFail($id);

                foreach ($venta->productosVentas as $detalle) {
                    // Buscar el producto equivalente en almacén 2
                    $productoAlmacen2 = \App\Models\Producto::where('id_empresa', $user->id_empresa)
                        ->where('almacen', '2')
                        ->where('codigo', function ($query) use ($detalle) {
                            $query->select('codigo')
                                ->from('productos')
                                ->where('id_producto', $detalle->id_producto)
                                ->limit(1);
                        })
                        ->first();

                    if ($productoAlmacen2) {
                        $productoAlmacen2->decrement('cantidad', $detalle->cantidad);
                        $productoAlmacen2->update(['ultima_salida' => now()]);

                        Log::info("Stock descontado de almacén real", [
                            'id_producto_almacen2' => $productoAlmacen2->id_producto,
                            'codigo' => $productoAlmacen2->codigo,
                            'cantidad_descontada' => $detalle->cantidad,
                            'stock_nuevo' => $productoAlmacen2->fresh()->cantidad,
                        ]);
                    }
                }

                $venta->update(['stock_real_descontado' => true]);

                return response()->json([
                    'success' => true,
                    'message' => 'Stock descontado del almacén real exitosamente',
                ]);
            });
        } catch (\Exception $e) {
            Log::error('Error al descontar stock: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al descontar stock del almacén real',
            ], 500);
        }
    }

    /**
     * Obtener próximo número de venta
     */
    public function proximoNumero(Request $request): JsonResponse
    {
        try {
            $user = $request->user();
            $serie = $request->input('serie', 'F001');

            $ultimaVenta = Venta::where('id_empresa', $user->id_empresa)
                ->where('serie', $serie)
                ->orderBy('numero', 'desc')
                ->first();

            $proximoNumero = $ultimaVenta ? $ultimaVenta->numero + 1 : 1;

            return response()->json([
                'success' => true,
                'numero' => $proximoNumero,
                'numero_completo' => $serie . '-' . str_pad($proximoNumero, 6, '0', STR_PAD_LEFT),
            ]);
        } catch (\Exception $e) {
            Log::error('Error al obtener próximo número: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener próximo número',
            ], 500);
        }
    }
}
