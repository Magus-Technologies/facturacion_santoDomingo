import axios from 'axios';
window.axios = axios;

window.axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

// Interceptor global para Axios (manejo de token expirado o no autorizado)
window.axios.interceptors.response.use(
    (response) => response,
    (error) => {
        if (error.response && error.response.status === 401) {
            localStorage.removeItem('auth_token');
            window.location.href = '/login';
        }
        return Promise.reject(error);
    }
);

// Interceptor global simulado para la función nativa window.fetch (ya que React usa fetch)
const originalFetch = window.fetch;
window.fetch = async function () {
    const response = await originalFetch.apply(this, arguments);

    if (response.status === 401) {
        localStorage.removeItem('auth_token');
        window.location.href = '/login';
        return new Promise(() => {}); // Detenemos la ejecución de este request para que no choque con la UI al redirigirse
    }

    return response;
};
