<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\UbicacionesControlller;
use App\Http\Controllers\UnidadProductoController;
use App\Http\Controllers\CategoriaProductoController;
use App\Http\Controllers\CotizacionController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// Rutas públicas (sin autenticación)
Route::post('/login', [AuthController::class, 'login']);

// Rutas protegidas (requieren autenticación)
Route::middleware(['token.query', 'auth:sanctum'])->group(function () {
    // Autenticación
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);
    Route::post('/refresh', [AuthController::class, 'refresh']);
    Route::get('/verify', [AuthController::class, 'verify']);
    Route::post('/switch-empresa', [AuthController::class, 'switchEmpresa']);

    // Usuarios
    Route::get('users/roles', [\App\Http\Controllers\Api\UserController::class, 'getRoles']);
    Route::apiResource('users', \App\Http\Controllers\Api\UserController::class);

    // Permisos
    Route::get('permissions', [\App\Http\Controllers\Api\PermissionController::class, 'index']);
    Route::get('permissions/user', [\App\Http\Controllers\Api\PermissionController::class, 'getUserPermissions']);
    Route::post('permissions/refresh', [\App\Http\Controllers\Api\PermissionController::class, 'refreshUserPermissions']);
    Route::get('permissions/role/{rolId}', [\App\Http\Controllers\Api\PermissionController::class, 'getRolePermissions']);
    Route::put('permissions/role/{rolId}', [\App\Http\Controllers\Api\PermissionController::class, 'updateRolePermissions']);

    // Dashboard
    Route::get('/dashboard/stats', [\App\Http\Controllers\Api\DashboardController::class, 'stats']);
    Route::get('/dashboard/ventas-por-dia', [\App\Http\Controllers\Api\DashboardController::class, 'ventasPorDia']);
    Route::get('/dashboard/metodos-pago', [\App\Http\Controllers\Api\DashboardController::class, 'metodosPago']);
    Route::get('/dashboard/ingresos-egresos', [\App\Http\Controllers\Api\DashboardController::class, 'ingresosEgresos']);
    Route::get('/dashboard/top-productos', [\App\Http\Controllers\Api\DashboardController::class, 'topProductos']);
    Route::get('/dashboard/ultimas-transacciones', [\App\Http\Controllers\Api\DashboardController::class, 'ultimasTransacciones']);
    Route::get('/dashboard/cajas-pendientes', [\App\Http\Controllers\Api\DashboardController::class, 'cajasPendientes']);
    Route::get('/dashboard/top-categorias', [\App\Http\Controllers\Api\DashboardController::class, 'topCategorias']);
    Route::get('/dashboard/top-marcas', [\App\Http\Controllers\Api\DashboardController::class, 'topMarcas']);
    Route::get('/dashboard/top-fechas', [\App\Http\Controllers\Api\DashboardController::class, 'topFechas']);
    Route::get('/dashboard/rentabilidad', [\App\Http\Controllers\Api\DashboardController::class, 'rentabilidad']);
    Route::get('/dashboard/top-clientes', [\App\Http\Controllers\Api\DashboardController::class, 'topClientes']);
    Route::get('/dashboard/ventas-por-hora', [\App\Http\Controllers\Api\DashboardController::class, 'ventasPorHora']);
    Route::get('/dashboard/vendedores', [\App\Http\Controllers\Api\DashboardController::class, 'vendedores']);
    Route::get('/dashboard/stock-bajo', [\App\Http\Controllers\Api\DashboardController::class, 'stockBajo']);

    // Clientes
    Route::get('clientes', [\App\Http\Controllers\Api\ClienteController::class, 'index'])->middleware('permission:clientes.view');
    Route::post('clientes', [\App\Http\Controllers\Api\ClienteController::class, 'store'])->middleware('permission:clientes.create');
    Route::get('clientes/{id}', [\App\Http\Controllers\Api\ClienteController::class, 'show'])->middleware('permission:clientes.view');
    Route::put('clientes/{id}', [\App\Http\Controllers\Api\ClienteController::class, 'update'])->middleware('permission:clientes.edit');
    Route::post('clientes/{id}', [\App\Http\Controllers\Api\ClienteController::class, 'update'])->middleware('permission:clientes.edit'); // POST para FormData con foto
    Route::delete('clientes/{id}', [\App\Http\Controllers\Api\ClienteController::class, 'destroy'])->middleware('permission:clientes.delete');
    Route::post('clientes/buscar-documento', [\App\Http\Controllers\Api\ClienteController::class, 'buscarPorDocumento']);

    // Plantilla de Impresión
    Route::get('plantilla-impresion', [\App\Http\Controllers\PlantillaImpresionController::class, 'show']);
    Route::post('plantilla-impresion', [\App\Http\Controllers\PlantillaImpresionController::class, 'update']);

    // Empresas
    Route::get('empresas', [\App\Http\Controllers\EmpresaController::class, 'index']);
    Route::post('empresas', [\App\Http\Controllers\EmpresaController::class, 'store']);
    Route::get('empresas/{id}', [\App\Http\Controllers\EmpresaController::class, 'show']);
    Route::post('empresas/{id}', [\App\Http\Controllers\EmpresaController::class, 'update']); // POST para FormData con logo
    Route::delete('empresas/{id}/logo', [\App\Http\Controllers\EmpresaController::class, 'deleteLogo']);

    // Movimientos de Stock
    Route::get('movimientos-stock', [\App\Http\Controllers\MovimientosStockController::class, 'index'])->middleware('permission:productos.view');

    // Productos
    Route::get('productos/plantilla-excel', [\App\Http\Controllers\Exports\ProductoExportController::class, 'descargarPlantilla']);
    Route::get('productos/descargar-excel', [\App\Http\Controllers\Exports\ProductoExportController::class, 'descargarExcel']);
    Route::post('productos/leer-excel', [\App\Http\Controllers\Imports\ProductoImportController::class, 'leerExcel'])->middleware('permission:productos.create');
    Route::post('productos/importar-lista', [\App\Http\Controllers\Imports\ProductoImportController::class, 'importarLista'])->middleware('permission:productos.create');
    Route::post('productos/replicar-masivo', [\App\Http\Controllers\ProductoController::class, 'replicarMasivo'])->middleware('permission:productos.create');
    Route::get('productos', [\App\Http\Controllers\ProductoController::class, 'index'])->middleware('permission:productos.view');
    Route::post('productos', [\App\Http\Controllers\ProductoController::class, 'store'])->middleware('permission:productos.create');
    Route::get('productos/{id}', [\App\Http\Controllers\ProductoController::class, 'show'])->middleware('permission:productos.view');
    Route::put('productos/{id}', [\App\Http\Controllers\ProductoController::class, 'update'])->middleware('permission:productos.edit');
    Route::delete('productos/{id}', [\App\Http\Controllers\ProductoController::class, 'destroy'])->middleware('permission:productos.delete');

    // Proveedores
    Route::get('proveedores/{id}/detalles', [\App\Http\Controllers\ProveedorController::class, 'getDetalles'])->middleware('permission:proveedores.view');
    Route::get('proveedores', [\App\Http\Controllers\ProveedorController::class, 'index'])->middleware('permission:proveedores.view');
    Route::post('proveedores', [\App\Http\Controllers\ProveedorController::class, 'store'])->middleware('permission:proveedores.create');
    Route::get('proveedores/{id}', [\App\Http\Controllers\ProveedorController::class, 'show'])->middleware('permission:proveedores.view');
    Route::put('proveedores/{id}', [\App\Http\Controllers\ProveedorController::class, 'update'])->middleware('permission:proveedores.edit');
    Route::delete('proveedores/{id}', [\App\Http\Controllers\ProveedorController::class, 'destroy'])->middleware('permission:proveedores.delete');

    // Unidades - CRUD completo
    Route::get('unidades', [UnidadProductoController::class, 'index']);
    Route::post('unidades', [UnidadProductoController::class, 'store']);
    Route::put('unidades/{id}', [UnidadProductoController::class, 'update']);
    Route::delete('unidades/{id}', [UnidadProductoController::class, 'destroy']);

    // Categorías - CRUD completo
    Route::get('categorias', [CategoriaProductoController::class, 'index']);
    Route::post('categorias', [CategoriaProductoController::class, 'store']);
    Route::put('categorias/{id}', [CategoriaProductoController::class, 'update']);
    Route::delete('categorias/{id}', [CategoriaProductoController::class, 'destroy']);

    // Cotizaciones
    Route::get('cotizaciones/proximo-numero', [CotizacionController::class, 'proximoNumero']);
    Route::get('cotizaciones', [CotizacionController::class, 'index'])->middleware('permission:cotizaciones.view');
    Route::post('cotizaciones', [CotizacionController::class, 'store'])->middleware('permission:cotizaciones.create');
    Route::get('cotizaciones/{id}', [CotizacionController::class, 'show'])->middleware('permission:cotizaciones.view');
    Route::put('cotizaciones/{id}', [CotizacionController::class, 'update'])->middleware('permission:cotizaciones.edit');
    Route::delete('cotizaciones/{id}', [CotizacionController::class, 'destroy'])->middleware('permission:cotizaciones.delete');
    Route::post('cotizaciones/{id}/estado', [CotizacionController::class, 'cambiarEstado'])->middleware('permission:cotizaciones.edit');

    // Ventas - Exportaciones
    Route::get('ventas/exportar-txt', [\App\Http\Controllers\Exports\VentaExportController::class, 'exportarTxt'])->middleware('permission:ventas.view');
    Route::get('ventas/exportar-excel', [\App\Http\Controllers\Exports\VentaExportController::class, 'exportarExcel'])->middleware('permission:ventas.view');
    Route::get('ventas/reporte-rvta', [\App\Http\Controllers\Exports\VentaExportController::class, 'reporteRVTA'])->middleware('permission:ventas.view');
    Route::get('ventas/reporte-producto', [\App\Http\Controllers\Exports\VentaExportController::class, 'reporteVentasProducto'])->middleware('permission:ventas.view');
    Route::get('ventas/reporte-ganancias', [\App\Http\Controllers\Exports\VentaExportController::class, 'reporteGanancias'])->middleware('permission:ventas.view');
    Route::get('ventas/exportar-pdf', [\App\Http\Controllers\Exports\VentaExportController::class, 'exportarPdf'])->middleware('permission:ventas.view');

    // Ventas
    Route::get('ventas/proximo-numero', [\App\Http\Controllers\VentasController::class, 'proximoNumero']);
    Route::get('ventas', [\App\Http\Controllers\VentasController::class, 'index'])->middleware('permission:ventas.view');
    Route::post('ventas', [\App\Http\Controllers\VentasController::class, 'store'])->middleware('permission:ventas.create');
    Route::get('ventas/{id}', [\App\Http\Controllers\VentasController::class, 'show'])->middleware('permission:ventas.view');
    Route::put('ventas/{id}', [\App\Http\Controllers\VentasController::class, 'update'])->middleware('permission:ventas.edit');
    Route::delete('ventas/{id}', [\App\Http\Controllers\VentasController::class, 'destroy'])->middleware('permission:ventas.delete');
    Route::post('ventas/{id}/anular', [\App\Http\Controllers\VentasController::class, 'anular'])->middleware('permission:ventas.delete');
    Route::get('ventas/{id}/preview-descontar-stock', [\App\Http\Controllers\VentasController::class, 'previewDescontarStock'])->middleware('permission:ventas.edit');
    Route::post('ventas/{id}/descontar-stock', [\App\Http\Controllers\VentasController::class, 'descontarStock'])->middleware('permission:ventas.edit');

    // Compras
    Route::get('compras', [\App\Http\Controllers\CompraController::class, 'index'])->middleware('permission:compras.view');
    Route::post('compras', [\App\Http\Controllers\CompraController::class, 'store'])->middleware('permission:compras.create');
    Route::get('compras/{id}', [\App\Http\Controllers\CompraController::class, 'show'])->middleware('permission:compras.view');
    Route::put('compras/{id}', [\App\Http\Controllers\CompraController::class, 'update'])->middleware('permission:compras.edit');
    Route::delete('compras/{id}', [\App\Http\Controllers\CompraController::class, 'destroy'])->middleware('permission:compras.delete');
    Route::post('compras/{id}/anular', [\App\Http\Controllers\CompraController::class, 'anular'])->middleware('permission:compras.delete');

    // Cuentas por Cobrar
    Route::get('cuentas-por-cobrar/exportar-excel', [\App\Http\Controllers\Exports\CuentasPorCobrarExportController::class, 'exportExcel'])->middleware('permission:cuentas-cobrar.view');
    Route::get('cuentas-por-cobrar', [\App\Http\Controllers\CuentasPorCobrarController::class, 'index'])->middleware('permission:cuentas-cobrar.view');
    Route::post('cuentas-por-cobrar/{id}/pagar', [\App\Http\Controllers\CuentasPorCobrarController::class, 'pagar'])->middleware('permission:cuentas-cobrar.edit');

    // Cuentas por Pagar
    Route::get('cuentas-por-pagar/exportar-excel', [\App\Http\Controllers\Exports\CuentasPorPagarExportController::class, 'exportExcel'])->middleware('permission:cuentas-pagar.view');
    Route::get('cuentas-por-pagar', [\App\Http\Controllers\CuentasPorPagarController::class, 'index'])->middleware('permission:cuentas-pagar.view');
    Route::post('cuentas-por-pagar/{id}/pagar', [\App\Http\Controllers\CuentasPorPagarController::class, 'pagar'])->middleware('permission:cuentas-pagar.edit');

    // Comprobantes Electrónicos (SUNAT)
    Route::post('comprobantes/generar-xml/{ventaId}', [\App\Http\Controllers\ComprobanteElectronicoController::class, 'generarXml']);
    Route::post('comprobantes/enviar/{ventaId}', [\App\Http\Controllers\ComprobanteElectronicoController::class, 'enviar']);
    Route::get('comprobantes/xml/{nombre}', [\App\Http\Controllers\ComprobanteElectronicoController::class, 'xml'])->where('nombre', '.*');
    Route::get('comprobantes/{ventaId}/cdr', [\App\Http\Controllers\ComprobanteElectronicoController::class, 'cdr']);
    Route::get('comprobantes/estado/{ventaId}', [\App\Http\Controllers\ComprobanteElectronicoController::class, 'estado']);

    // Notas de Crédito
    Route::get('notas-credito/motivos', [\App\Http\Controllers\NotaCreditoController::class, 'motivos']);
    Route::get('notas-credito/buscar-venta', [\App\Http\Controllers\NotaCreditoController::class, 'buscarVenta']);
    Route::get('notas-credito', [\App\Http\Controllers\NotaCreditoController::class, 'index']);
    Route::post('notas-credito', [\App\Http\Controllers\NotaCreditoController::class, 'store']);
    Route::get('notas-credito/{id}', [\App\Http\Controllers\NotaCreditoController::class, 'show']);
    Route::post('notas-credito/{id}/enviar', [\App\Http\Controllers\NotaCreditoController::class, 'enviar']);
    Route::get('notas-credito/{id}/cdr', [\App\Http\Controllers\NotaCreditoController::class, 'cdr']);
    Route::get('notas-credito/xml/{nombre}', [\App\Http\Controllers\NotaCreditoController::class, 'xml'])->where('nombre', '.*');

    // Notas de Débito
    Route::get('notas-debito/motivos', [\App\Http\Controllers\NotaDebitoController::class, 'motivos']);
    Route::get('notas-debito', [\App\Http\Controllers\NotaDebitoController::class, 'index']);
    Route::post('notas-debito', [\App\Http\Controllers\NotaDebitoController::class, 'store']);
    Route::get('notas-debito/{id}', [\App\Http\Controllers\NotaDebitoController::class, 'show']);
    Route::post('notas-debito/{id}/enviar', [\App\Http\Controllers\NotaDebitoController::class, 'enviar']);

    // Guías de Remisión
    Route::get('guias-remision/proximo-numero', [\App\Http\Controllers\GuiaRemisionController::class, 'proximoNumero']);
    Route::get('guias-remision/motivos', [\App\Http\Controllers\GuiaRemisionController::class, 'motivos']);
    Route::get('guias-remision/empresa', [\App\Http\Controllers\GuiaRemisionController::class, 'empresaActiva']);
    Route::get('guias-remision/ubigeos', [\App\Http\Controllers\GuiaRemisionController::class, 'ubigeos']);
    Route::get('guias-remision/exportar-excel', [\App\Http\Controllers\Exports\GuiaRemisionExportController::class, 'descargarExcel']);
    Route::get('guias-remision', [\App\Http\Controllers\GuiaRemisionController::class, 'index']);
    Route::post('guias-remision', [\App\Http\Controllers\GuiaRemisionController::class, 'store']);
    Route::get('guias-remision/{id}/cdr', [\App\Http\Controllers\GuiaRemisionController::class, 'cdr']);
    Route::get('guias-remision/{id}', [\App\Http\Controllers\GuiaRemisionController::class, 'show']);
    Route::post('guias-remision/{id}/enviar', [\App\Http\Controllers\GuiaRemisionController::class, 'enviar']);
    Route::get('guias-remision/{id}/ticket', [\App\Http\Controllers\GuiaRemisionController::class, 'consultarTicket']);
    Route::get('guias-remision/xml/{nombre}', [\App\Http\Controllers\GuiaRemisionController::class, 'xml'])->where('nombre', '.*');

    // -----------------------------------------------------------------------
    // MÓDULO FINANZAS
    // -----------------------------------------------------------------------

    // Bancos
    Route::get('bancos', [\App\Http\Controllers\Api\BancoController::class, 'index']);
    Route::post('bancos', [\App\Http\Controllers\Api\BancoController::class, 'store'])->middleware('permission:finanzas.create');
    Route::get('bancos/{id}', [\App\Http\Controllers\Api\BancoController::class, 'show']);
    Route::put('bancos/{id}', [\App\Http\Controllers\Api\BancoController::class, 'update'])->middleware('permission:finanzas.edit');
    Route::delete('bancos/{id}', [\App\Http\Controllers\Api\BancoController::class, 'destroy'])->middleware('permission:finanzas.delete');

    // Transportistas
    Route::get('transportistas/activos', [\App\Http\Controllers\Api\TransportistaController::class, 'activos']);
    Route::get('transportistas', [\App\Http\Controllers\Api\TransportistaController::class, 'index']);
    Route::post('transportistas', [\App\Http\Controllers\Api\TransportistaController::class, 'store'])->middleware('permission:guias-remision.create');
    Route::get('transportistas/{id}', [\App\Http\Controllers\Api\TransportistaController::class, 'show']);
    Route::put('transportistas/{id}', [\App\Http\Controllers\Api\TransportistaController::class, 'update'])->middleware('permission:guias-remision.edit');
    Route::delete('transportistas/{id}', [\App\Http\Controllers\Api\TransportistaController::class, 'destroy'])->middleware('permission:guias-remision.delete');

    // Métodos de Pago
    Route::get('metodos-pago', [\App\Http\Controllers\Api\MetodoPagoController::class, 'index']);
    Route::post('metodos-pago', [\App\Http\Controllers\Api\MetodoPagoController::class, 'store'])->middleware('permission:finanzas.create');
    Route::get('metodos-pago/empresa/configuracion', [\App\Http\Controllers\Api\MetodoPagoController::class, 'configuracionEmpresa']);
    Route::post('metodos-pago/empresa/configuracion', [\App\Http\Controllers\Api\MetodoPagoController::class, 'guardarConfiguracionEmpresa'])->middleware('permission:finanzas.edit');
    Route::get('metodos-pago/{id}', [\App\Http\Controllers\Api\MetodoPagoController::class, 'show']);
    Route::put('metodos-pago/{id}', [\App\Http\Controllers\Api\MetodoPagoController::class, 'update'])->middleware('permission:finanzas.edit');
    Route::delete('metodos-pago/{id}', [\App\Http\Controllers\Api\MetodoPagoController::class, 'destroy'])->middleware('permission:finanzas.delete');

    // Cajas
    Route::get('cajas/activa', [\App\Http\Controllers\Api\CajaController::class, 'cajaActiva']);
    Route::get('cajas/denominaciones', [\App\Http\Controllers\Api\CajaController::class, 'denominaciones']);
    Route::get('cajas', [\App\Http\Controllers\Api\CajaController::class, 'index'])->middleware('permission:caja.view');
    Route::post('cajas', [\App\Http\Controllers\Api\CajaController::class, 'store'])->middleware('permission:caja.create');
    Route::get('cajas/{id}', [\App\Http\Controllers\Api\CajaController::class, 'show'])->middleware('permission:caja.view');
    Route::get('cajas/{id}/resumen', [\App\Http\Controllers\Api\CajaController::class, 'resumen'])->middleware('permission:caja.view');
    Route::get('cajas/{id}/ventas-por-metodo', [\App\Http\Controllers\Api\CajaController::class, 'ventasPorMetodo'])->middleware('permission:caja.view');
    Route::get('cajas/{id}/auditoria', [\App\Http\Controllers\Api\CajaController::class, 'auditoria'])->middleware('permission:caja.view');
    Route::get('cajas/{id}/arqueo', [\App\Http\Controllers\Api\CajaController::class, 'arqueo'])->middleware('permission:caja.view');
    Route::post('cajas/{id}/activar', [\App\Http\Controllers\Api\CajaController::class, 'activar']);
    Route::post('cajas/{id}/abrir', [\App\Http\Controllers\Api\CajaController::class, 'abrir'])->middleware('permission:caja.abrir');
    Route::put('cajas/{id}/cierre', [\App\Http\Controllers\Api\CajaController::class, 'cierre'])->middleware('permission:caja.edit');
    Route::post('cajas/{id}/autorizar', [\App\Http\Controllers\Api\CajaController::class, 'autorizarCierre'])->middleware('permission:caja.autorizar');
    Route::post('cajas/{id}/rechazar', [\App\Http\Controllers\Api\CajaController::class, 'rechazarCierre'])->middleware('permission:caja.autorizar');
    Route::get('cajas/{id}/movimientos', [\App\Http\Controllers\Api\CajaController::class, 'movimientos'])->middleware('permission:caja.view');
    Route::post('cajas/{id}/movimientos', [\App\Http\Controllers\Api\CajaController::class, 'registrarMovimiento'])->middleware('permission:caja.edit');
    Route::get('cajas/permisos/{usuario_id}', [\App\Http\Controllers\Api\CajaController::class, 'obtenerPermisos'])->middleware('permission:caja.autorizar');
    Route::post('cajas/permisos/{usuario_id}', [\App\Http\Controllers\Api\CajaController::class, 'actualizarPermisos'])->middleware('permission:caja.autorizar');

    // Utilidades / BI Financiero
    Route::get('finanzas/utilidades', [\App\Http\Controllers\Api\UtilidadesController::class, 'index'])->middleware('permission:utilidades.view');

    // Cuentas Bancarias
    Route::get('cuentas-bancarias', [\App\Http\Controllers\Api\CuentaBancariaController::class, 'index'])->middleware('permission:banco.view');
    Route::post('cuentas-bancarias', [\App\Http\Controllers\Api\CuentaBancariaController::class, 'store'])->middleware('permission:banco.create');
    Route::get('cuentas-bancarias/{id}', [\App\Http\Controllers\Api\CuentaBancariaController::class, 'show'])->middleware('permission:banco.view');
    Route::put('cuentas-bancarias/{id}', [\App\Http\Controllers\Api\CuentaBancariaController::class, 'update'])->middleware('permission:banco.edit');
    Route::delete('cuentas-bancarias/{id}', [\App\Http\Controllers\Api\CuentaBancariaController::class, 'destroy'])->middleware('permission:banco.delete');
    Route::get('cuentas-bancarias/{id}/movimientos', [\App\Http\Controllers\Api\CuentaBancariaController::class, 'movimientos'])->middleware('permission:banco.view');
    Route::post('cuentas-bancarias/{id}/movimientos', [\App\Http\Controllers\Api\CuentaBancariaController::class, 'registrarMovimiento'])->middleware('permission:banco.edit');
    Route::get('cuentas-bancarias/{id}/conciliaciones', [\App\Http\Controllers\Api\CuentaBancariaController::class, 'conciliaciones'])->middleware('permission:banco.view');
    Route::post('cuentas-bancarias/{id}/conciliaciones', [\App\Http\Controllers\Api\CuentaBancariaController::class, 'registrarConciliacion'])->middleware('permission:banco.edit');

    // -----------------------------------------------------------------------
    // Comunicación de Baja (anular facturas, NC, ND)
    Route::post('comunicacion-baja', [\App\Http\Controllers\ComunicacionBajaController::class, 'store']);
    Route::post('comunicacion-baja/consultar', [\App\Http\Controllers\ComunicacionBajaController::class, 'consultarTicket']);

    // Resumen Diario (enviar/anular boletas)
    Route::post('resumen-diario', [\App\Http\Controllers\ResumenDiarioController::class, 'store']);
    Route::post('resumen-diario/anular', [\App\Http\Controllers\ResumenDiarioController::class, 'anular']);
    Route::post('resumen-diario/consultar', [\App\Http\Controllers\ResumenDiarioController::class, 'consultarTicket']);
});

Route::get('/departamentos' ,[UbicacionesControlller::class,'obtenerDepartamentos']);
Route::get('/provincias/{departamentoId}',[UbicacionesControlller::class,'obtenerProvincias']);
Route::get('/distritos/{departamentoId}/{provinciaId}' ,[UbicacionesControlller::class,'obtenerDistritos']);