/**
 * Funciones auxiliares para el módulo de Cotizaciones
 */

/**
 * Calcula el subtotal de la cotización
 */
export const calcularSubtotal = (productos) => {
    return productos.reduce((sum, producto) => {
        const cantidad = parseFloat(producto.cantidad || 0);
        const precio = parseFloat(producto.precioEspecial || producto.precioVenta || 0);
        return sum + (cantidad * precio);
    }, 0);
};

/**
 * Calcula el descuento
 */
export const calcularDescuento = (productos, descuentoActivado, descuentoGeneral) => {
    if (!descuentoActivado) return 0;
    const subtotal = calcularSubtotal(productos);
    const descuento = parseFloat(descuentoGeneral || 0);
    return subtotal * (descuento / 100);
};

/**
 * Calcula la base imponible (Operaciones gravadas = Total / 1.18)
 */
export const calcularBase = (productos, aplicarIgv, descuentoActivado, descuentoGeneral) => {
    const total = calcularTotal(productos, aplicarIgv, descuentoActivado, descuentoGeneral);
    if (aplicarIgv === '1' || aplicarIgv === true) {
        return total / 1.18;
    }
    return total;
};

/**
 * Calcula el IGV
 */
export const calcularIGV = (productos, aplicarIgv, descuentoActivado, descuentoGeneral) => {
    if (aplicarIgv === '0' || aplicarIgv === false) return 0;
    const total = calcularTotal(productos, aplicarIgv, descuentoActivado, descuentoGeneral);
    const base = calcularBase(productos, aplicarIgv, descuentoActivado, descuentoGeneral);
    return total - base;
};

/**
 * Calcula el total de la cotización
 */
export const calcularTotal = (productos, aplicarIgv, descuentoActivado, descuentoGeneral) => {
    const montoBruto = calcularSubtotal(productos);
    const descuento = calcularDescuento(productos, descuentoActivado, descuentoGeneral);
    return montoBruto - descuento;
};

/**
 * Obtiene el símbolo de moneda
 */
export const getSimboloMoneda = (moneda) => {
    const simbolos = {
        'PEN': 'S/',
        'USD': '$',
    };
    return simbolos[moneda] || 'S/';
};

/**
 * Formatea el monto con símbolo de moneda
 */
export const formatMonto = (monto, moneda) => {
    const simbolo = getSimboloMoneda(moneda);
    return `${simbolo} ${parseFloat(monto || 0).toFixed(2)}`;
};

/**
 * Formatea el número de cotización
 */
export const formatNumeroCotizacion = (numero) => {
    return String(numero).padStart(6, '0');
};

/**
 * Formatea la fecha
 */
export const formatFecha = (fecha) => {
    const fechaObj = new Date(fecha);
    return fechaObj.toLocaleDateString('es-PE', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
    });
};

/**
 * Obtiene el badge de estado
 */
export const getEstadoBadge = (estado) => {
    const badges = {
        pendiente: {
            color: 'bg-yellow-100 text-yellow-800',
            text: 'Pendiente',
        },
        aprobada: {
            color: 'bg-green-100 text-green-800',
            text: 'Aprobada',
        },
        rechazada: {
            color: 'bg-red-100 text-red-800',
            text: 'Rechazada',
        },
        vencida: {
            color: 'bg-gray-100 text-gray-800',
            text: 'Vencida',
        },
    };

    return badges[estado] || badges.pendiente;
};

/**
 * Valida que haya productos en la cotización
 */
export const validarProductos = (productos) => {
    if (productos.length === 0) {
        return { valid: false, message: 'Agregue al menos un producto' };
    }
    return { valid: true };
};

/**
 * Valida que haya cliente seleccionado
 */
export const validarCliente = (cliente, formData) => {
    // Nombre libre (sin documento) es válido para cotizaciones
    if (formData.nom_cli) {
        return { valid: true };
    }
    if (!cliente || !formData.num_doc) {
        return { valid: false, message: 'Ingrese un nombre de cliente' };
    }
    return { valid: true };
};

/**
 * Valida las cuotas para cotizaciones a crédito
 */
export const validarCuotas = (tipoPago, cuotas) => {
    if (tipoPago === '2' && cuotas.length === 0) {
        return { valid: false, message: 'Configure las cuotas de pago para crédito' };
    }
    return { valid: true };
};

/**
 * Prepara los datos para enviar al backend
 */
export const prepararDatosCotizacion = (cliente, formData, productos, user, totales) => {
    // Normalizar moneda: puede venir como 'PEN'/'USD' o como '1'/'2' (legacy)
    const normalizarMoneda = (m) => {
        if (m === '1' || m === 1) return 'PEN';
        if (m === '2' || m === 2) return 'USD';
        if (m === 'PEN' || m === 'USD') return m;
        return 'PEN'; // Soles por defecto
    };
    const moneda = normalizarMoneda(formData.moneda || formData.tipo_moneda);
    const cli = cliente || {};

    return {
        fecha: formData.fecha,
        numero: formData.numero,
        id_cliente: cli.id_cliente || null,
        cliente_documento: cli.documento || formData.num_doc || '',
        cliente_datos: cli.datos || formData.nom_cli || '',
        cliente_nombre: formData.nom_cli || cli.datos || '',
        cliente_direccion: cli.direccion || formData.dir_cli || '',
        direccion: formData.dir_cli,
        moneda: moneda,
        tipo_cambio: formData.tipo_cambio,
        aplicar_igv: formData.aplicar_igv === '1' || formData.aplicar_igv === true,
        descuento: formData.descuento_activado ? parseFloat(formData.descuento_general || 0) : 0,
        asunto: formData.asunto,
        observaciones: '',
        subtotal: totales.subtotal,
        igv: totales.igv,
        total: totales.total,
        estado: 'pendiente',
        productos: productos.map(p => ({
            producto_id: p.id_producto,
            codigo: p.codigo || '',
            nombre: p.descripcion || p.nombre || '',  // Backend espera 'nombre'
            descripcion: p.descripcion || '',
            cantidad: parseFloat(p.cantidad),
            precio_unitario: parseFloat(p.precioVenta || p.precio || 0),
            precio_especial: p.precioEspecial ? parseFloat(p.precioEspecial) : null
        })),
        cuotas: formData.tipo_pago === '2' ? formData.cuotas.map((c) => ({
            monto: parseFloat(c.monto),
            fecha_vencimiento: c.fecha,
            tipo: 'cuota'
        })) : []
    };
};
