/**
 * Tipos de documentos de facturación
 * Basado en catálogo SUNAT
 */

export const TIPOS_DOCUMENTO_VENTA = [
    { value: '1', label: 'BOLETA', codigo: '03' },
    { value: '2', label: 'FACTURA', codigo: '01' },
    { value: '6', label: 'NOTA DE VENTA', codigo: 'NV' },
];

/**
 * Tipos de documentos para COMPRAS
 * Documentos que los PROVEEDORES emiten y tú registras
 * 
 * FACTURA (01): Documento que emite el proveedor con RUC. Permite deducir IGV y gastos.
 *               Uso: Compras a empresas formales con RUC.
 * 
 * BOLETA (03): Documento que emite el proveedor. NO permite deducir IGV.
 *              Uso: Compras menores, proveedores sin RUC.
 * 
 * NOTA DE CRÉDITO (07): Documento que emite el proveedor para anular o corregir una factura/boleta.
 *                       Uso: Devoluciones, descuentos, anulaciones.
 * 
 * NOTA DE DÉBITO (08): Documento que emite el proveedor para aumentar el monto de una factura.
 *                      Uso: Intereses, penalidades, cargos adicionales.
 * 
 * GUÍA DE REMISIÓN (09): Documento que sustenta el traslado de mercadería.
 *                        Uso: Cuando el proveedor envía productos.
 * 
 * NOTA DE COMPRA (00): Documento interno para registrar compras sin comprobante formal.
 *                      Uso: Compras a personas naturales sin RUC, gastos menores.
 */
export const TIPOS_DOCUMENTO_COMPRA = [
    { value: '2', label: 'FACTURA', codigo: '01' },
    { value: '1', label: 'BOLETA', codigo: '03' },
    { value: '3', label: 'NOTA DE CRÉDITO', codigo: '07' },
    { value: '4', label: 'NOTA DE DÉBITO', codigo: '08' },
    { value: '11', label: 'GUÍA DE REMISIÓN', codigo: '09' },
    { value: '12', label: 'NOTA DE COMPRA', codigo: '00' },
];

export const TIPOS_DOCUMENTO_COTIZACION = [
    { value: '1', label: 'BOLETA', codigo: '03' },
    { value: '2', label: 'FACTURA', codigo: '01' },
];

// Función helper para obtener el label de un tipo de documento
export const getTipoDocumentoLabel = (value, tipo = 'venta') => {
    let lista = TIPOS_DOCUMENTO_VENTA;
    
    if (tipo === 'compra') {
        lista = TIPOS_DOCUMENTO_COMPRA;
    } else if (tipo === 'cotizacion') {
        lista = TIPOS_DOCUMENTO_COTIZACION;
    }
    
    const doc = lista.find(d => d.value === value);
    return doc ? doc.label : 'DOCUMENTO';
};

// Función helper para obtener el código de un tipo de documento
export const getTipoDocumentoCodigo = (value, tipo = 'venta') => {
    let lista = TIPOS_DOCUMENTO_VENTA;
    
    if (tipo === 'compra') {
        lista = TIPOS_DOCUMENTO_COMPRA;
    } else if (tipo === 'cotizacion') {
        lista = TIPOS_DOCUMENTO_COTIZACION;
    }
    
    const doc = lista.find(d => d.value === value);
    return doc ? doc.codigo : '';
};

export default {
    TIPOS_DOCUMENTO_VENTA,
    TIPOS_DOCUMENTO_COMPRA,
    TIPOS_DOCUMENTO_COTIZACION,
    getTipoDocumentoLabel,
    getTipoDocumentoCodigo,
};
