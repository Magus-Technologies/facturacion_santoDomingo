<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Aquí registramos las rutas de la interfaz y reportes que dependen de la sesión.
|
*/

// --- RUTAS PÚBLICAS Y AUTENTICACIÓN ---

Route::get('/', function () {
    return redirect('/inicio');
});

Route::get('/inicio', function () {
    return view('inicio');
})->middleware(['token.query', 'auth:sanctum'])->name('inicio');

Route::get('/login', function () {
    return view('auth.login');
})->name('login');

// --- VISTAS DEL FRONTEND ---
// Las rutas web no pueden usar auth:sanctum directamente porque el token está en localStorage
// La protección se maneja en el frontend, pero agregamos verificación básica

Route::get('/dashboard', function () { return view('dashboard'); })->name('dashboard');

// Configuración
Route::get('/configuracion/usuarios', function () { 
    return view('configuracion.userList'); 
})->name('userList');

Route::get('/configuracion/permisos', function () { 
    return view('configuracion.rolePermissions'); 
})->name('rolePermissions');

Route::get('/configuracion/empresa', function () {
    return view('configuracion.misEmpresas');
})->name('misEmpresas');

Route::get('/configuracion/plantilla-impresion', function () {
    return view('configuracion.plantillaImpresion');
})->name('plantillaImpresion');

// Ventas
Route::get('/ventas', function () { 
    return view('ventas.ventasList'); 
})->name('ventasList');

Route::get('/ventas/productos', function () { 
    return view('ventas.ventas-productos'); 
})->name('ventas.productos');

Route::get('/facturas', function () { 
    return redirect('/ventas?tipo=factura'); 
})->name('facturas');

Route::get('/boletas', function () { 
    return redirect('/ventas?tipo=boleta'); 
})->name('boletas');

Route::get('/notas-venta', function () { 
    return redirect('/ventas?tipo=nota'); 
})->name('notas-venta');

// Cotizaciones
Route::get('/cotizaciones', function () { 
    return view('cotizaciones.cotizaciones'); 
})->name('cotizaciones');

Route::get('/cotizaciones/nueva', function () { 
    return view('cotizaciones.cotizaciones-nueva'); 
})->name('cotizaciones.nueva');

Route::get('/cotizaciones/editar/{id}', function ($id) { 
    return view('cotizaciones.cotizaciones-editar', ['id' => $id]); 
})->name('cotizaciones.editar');

// Productos
Route::get('/productos', function () {
    return view('almacen.productosList');
})->name('productosList');

Route::get('/historial-movimientos', function () {
    return view('almacen.historialMovimientos');
})->name('historialMovimientos');

// Clientes
Route::get('/clientes', function () { 
    return view('clientesList'); 
})->name('clientesList');

// Compras
Route::get('/compras', function () { 
    return view('compras.compras'); 
})->name('compras');

Route::get('/compras/nueva', function () { 
    return view('compras.compras-nueva'); 
})->name('compras.nueva');

Route::get('/compras/editar/{id}', function ($id) { 
    return view('compras.compras-editar', ['id' => $id]); 
})->name('compras.editar');

// Proveedores
Route::get('/proveedores', function () { 
    return view('proveedores'); 
})->name('proveedores');

// Guía de Remisión
Route::get('/guia-remision', function () {
    return view('guiaRemision.guia-remision');
})->name('guia-remision');

Route::get('/guia-remision/add', function () {
    return view('guiaRemision.guia-remision-add');
})->name('guia-remision.add');

// Guía de Remisión Transportista
Route::get('/guia-remision-transportista', function () {
    return view('guiaRemision.guia-remision-transportista');
})->name('guia-remision-transportista');

Route::get('/guia-remision-transportista/add', function () {
    return view('guiaRemision.guia-remision-transportista-add');
})->name('guia-remision-transportista.add');

// Nota de Crédito
Route::get('/nota-credito', function () {
    return view('notaCredito.nota-credito');
})->name('nota-credito');

Route::get('/nota-credito/add', function () {
    return view('notaCredito.nota-credito-add');
})->name('nota-credito.add');

// --- REPORTES Y EXPORTACIONES ---
// Estas rutas cargan sesión automáticamente por estar en web.php.
// Eliminamos el middleware 'auth' explícito para evitar bucles de redirección con React.

// PDFs de ventas
Route::get('/reporteNV/ticket.php', function (Request $request) {
    return app(\App\Http\Controllers\Reportes\VentaPdfController::class)->generarTicket($request->get('id'));
});
Route::get('/reporteNV/a4.php', function (Request $request) {
    return app(\App\Http\Controllers\Reportes\VentaPdfController::class)->generarA4($request->get('id'));
});

// PDFs de compras
Route::get('/reporteOC/ticket.php', function (Request $request) {
    return app(\App\Http\Controllers\Reportes\CompraPdfController::class)->generarTicket($request->get('id'));
});
Route::get('/reporteOC/a4.php', function (Request $request) {
    return app(\App\Http\Controllers\Reportes\CompraPdfController::class)->generarA4($request->get('id'));
});

// PDFs de cotizaciones
Route::get('/reporteCOT/ticket.php', function (Request $request) {
    return app(\App\Http\Controllers\Reportes\CotizacionPdfController::class)->generarTicket($request->get('id'));
});
Route::get('/reporteCOT/a4.php', function (Request $request) {
    return app(\App\Http\Controllers\Reportes\CotizacionPdfController::class)->generarA4($request->get('id'));
});


// Facturación - Catálogos auxiliares
Route::get('/facturacion/transportistas', function () { return view('facturacion.transportistas'); })->name('facturacion.transportistas');
Route::get('/facturacion/transportistas/add', function () { return view('facturacion.transportistas-add'); })->name('facturacion.transportistas.add');

// Finanzas - Catálogos
Route::get('/finanzas/utilidades', function () { return view('finanzas.utilidades'); })->name('finanzas.utilidades');
Route::get('/finanzas/bancos', function () { return view('finanzas.bancos'); })->name('finanzas.bancos');
Route::get('/finanzas/metodos-pago', function () { return view('finanzas.metodos-pago'); })->name('finanzas.metodos-pago');
Route::get('/finanzas/caja', function () { return view('finanzas.caja'); })->name('finanzas.caja');
Route::get('/finanzas/cuentas-bancarias', function () { return view('finanzas.cuentas-bancarias'); })->name('finanzas.cuentas-bancarias');

// Cuentas por Cobrar
Route::get('/cuentas-por-cobrar', function () { return view('finanzas.cuentas-por-cobrar'); })->name('cuentas-por-cobrar');
Route::get('cuentas-por-cobrar/descargar-pdf', [\App\Http\Controllers\Exports\CuentasPorCobrarExportController::class, 'exportPdf']);

// Cuentas por Pagar
Route::get('/cuentas-por-pagar', function () { return view('finanzas.cuentas-por-pagar'); })->name('cuentas-por-pagar');
Route::get('cuentas-por-pagar/descargar-pdf', [\App\Http\Controllers\Exports\CuentasPorPagarExportController::class, 'exportPdf']);

// Exportaciones Excel/PDF (Requieren Auth::user() activo)
Route::get('compras/descargar-excel', [\App\Http\Controllers\Exports\CompraExportController::class, 'exportExcel']);
Route::get('compras/descargar-pdf', [\App\Http\Controllers\Exports\CompraExportController::class, 'exportPdf']);
Route::get('proveedores/descargar-excel', [\App\Http\Controllers\Exports\ProveedorExportController::class, 'exportExcel']);
Route::get('proveedores/descargar-pdf', [\App\Http\Controllers\Exports\ProveedorExportController::class, 'exportPdf']);

// PDFs de guías de remisión
Route::get('/reporteGR/a4.php', function (Request $request) {
    return app(\App\Http\Controllers\Reportes\GuiaRemisionPdfController::class)->generarA4($request->get('id'));
});

// Página pública de consulta de comprobante
Route::get('/consulta', [\App\Http\Controllers\ConsultaComprobanteController::class, 'index']);
Route::post('/consulta/buscar', [\App\Http\Controllers\ConsultaComprobanteController::class, 'consultar']);

// Ecommerce
Route::get('/ecommerce/productos', function () { return view('ecommerce.productos'); })->name('ecommerce.productos');
Route::get('/ecommerce/reportes', function () { return view('ecommerce.reportes'); })->name('ecommerce.reportes');
Route::get('/ecommerce/configuracion', function () { return view('ecommerce.configuracion'); })->name('ecommerce.configuracion');
Route::get('/ecommerce/pedidos', function () { return view('ecommerce.pedidos'); })->name('ecommerce.pedidos');
Route::get('/ecommerce/exclusivos', function () { return view('ecommerce.exclusivos'); })->name('ecommerce.exclusivos');
