/**
 * Utilidad centralizada para manejar la URL base del proyecto.
 * Usa VITE_BASE_URL del .env (vacío para local, "/facturacion" para producción con subdirectorio).
 *
 * Ejemplo:
 *   baseUrl('/login') → '/login' (local)
 *   baseUrl('/login') → '/facturacion/login' (producción)
 */
const BASE_URL = (import.meta.env.VITE_BASE_URL || '').replace(/\/+$/, '');

/**
 * Genera una URL con el prefijo base.
 * @param {string} path - Ruta relativa (ej: '/dashboard', '/api/productos')
 * @returns {string}
 */
export function baseUrl(path = '') {
    if (!path || path === '/') return BASE_URL || '/';
    const normalizedPath = path.startsWith('/') ? path : `/${path}`;
    return `${BASE_URL}${normalizedPath}`;
}

/**
 * Genera una URL de asset estático (imágenes, etc.)
 * @param {string} path
 * @returns {string}
 */
export function assetUrl(path = '') {
    return baseUrl(path);
}

export default BASE_URL;
