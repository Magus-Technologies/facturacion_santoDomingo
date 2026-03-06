import axios from 'axios';
import { baseUrl } from '@/lib/baseUrl';

const api = axios.create({
  baseURL: baseUrl('/api'),
  headers: {
    'X-Requested-With': 'XMLHttpRequest',
    'Content-Type': 'application/json',
  },
});

// Add token to requests if it exists
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('auth_token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

// Handle response errors
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('auth_token');
      window.location.href = baseUrl('/login');
    }
    return Promise.reject(error);
  }
);

export default api;
