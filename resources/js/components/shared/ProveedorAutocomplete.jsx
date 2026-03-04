import { useState, useEffect, useRef } from 'react';
import { Search, Loader2, Building2 } from 'lucide-react';
import { Input } from '../ui/input';
import { Button } from '../ui/button';
import { consultarRUC } from '@/services/apisPeru';
import { toast } from '@/lib/sweetalert';

/**
 * Componente de autocompletado para buscar proveedores por RUC o razón social.
 * Si no existe, permite consultar SUNAT y auto-crear el proveedor.
 */
export default function ProveedorAutocomplete({ onProveedorSelect, value = '' }) {
    const [searchTerm, setSearchTerm] = useState(value);
    const [proveedores, setProveedores] = useState([]);
    const [showDropdown, setShowDropdown] = useState(false);
    const [loading, setLoading] = useState(false);
    const [consultando, setConsultando] = useState(false);
    const [selectedIndex, setSelectedIndex] = useState(-1);
    const dropdownRef = useRef(null);
    const isExternalUpdate = useRef(false);

    useEffect(() => {
        isExternalUpdate.current = true;
        setSearchTerm(value);
    }, [value]);

    useEffect(() => {
        if (isExternalUpdate.current) {
            isExternalUpdate.current = false;
            return;
        }

        if (searchTerm.length < 2) {
            setProveedores([]);
            setShowDropdown(false);
            return;
        }

        const delay = setTimeout(() => {
            buscarProveedores(searchTerm);
        }, 300);

        return () => clearTimeout(delay);
    }, [searchTerm]);

    useEffect(() => {
        const handleClickOutside = (event) => {
            if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
                setShowDropdown(false);
            }
        };
        document.addEventListener('mousedown', handleClickOutside);
        return () => document.removeEventListener('mousedown', handleClickOutside);
    }, []);

    const buscarProveedores = async (term) => {
        setLoading(true);
        try {
            const token = localStorage.getItem('auth_token');
            const response = await fetch(`/api/proveedores?search=${encodeURIComponent(term)}`, {
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Accept': 'application/json'
                }
            });

            const data = await response.json();
            if (data.success) {
                setProveedores(data.data || []);
                setShowDropdown(true);
                setSelectedIndex(-1);
            }
        } catch (error) {
            console.error('Error buscando proveedores:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleSelectProveedor = (proveedor) => {
        setSearchTerm(proveedor.ruc + ' - ' + proveedor.razon_social);
        setShowDropdown(false);
        onProveedorSelect(proveedor);
    };

    const handleConsultarRUC = async () => {
        const ruc = searchTerm.trim();

        if (!ruc || ruc.length !== 11) {
            toast.warning('Ingrese un RUC válido de 11 dígitos');
            return;
        }

        setConsultando(true);
        try {
            const result = await consultarRUC(ruc);

            if (result.success) {
                const data = result.data;

                // Crear proveedor en el backend
                const token = localStorage.getItem('auth_token');
                const response = await fetch('/api/proveedores', {
                    method: 'POST',
                    headers: {
                        'Authorization': `Bearer ${token}`,
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    },
                    body: JSON.stringify({
                        ruc: ruc,
                        razon_social: data.razonSocial,
                        direccion: data.direccion || '',
                        departamento: data.departamento || '',
                        provincia: data.provincia || '',
                        distrito: data.distrito || '',
                        ubigeo: data.ubigeo || '',
                    })
                });

                const provResponse = await response.json();

                if (provResponse.success) {
                    const nuevoProveedor = provResponse.data;
                    toast.success('Proveedor registrado desde SUNAT');
                    setSearchTerm(nuevoProveedor.ruc + ' - ' + nuevoProveedor.razon_social);
                    setShowDropdown(false);
                    onProveedorSelect(nuevoProveedor);
                } else {
                    // Si ya existe (error de validación unique), buscar y seleccionar
                    if (provResponse.errors?.ruc) {
                        const searchResp = await fetch(`/api/proveedores?search=${ruc}`, {
                            headers: {
                                'Authorization': `Bearer ${token}`,
                                'Accept': 'application/json'
                            }
                        });
                        const searchData = await searchResp.json();
                        const existente = searchData.data?.find(p => p.ruc === ruc);
                        if (existente) {
                            toast.info('Proveedor ya existe, seleccionado');
                            setSearchTerm(existente.ruc + ' - ' + existente.razon_social);
                            setShowDropdown(false);
                            onProveedorSelect(existente);
                        }
                    } else {
                        toast.error(provResponse.message || 'Error al registrar proveedor');
                    }
                }
            } else {
                toast.error(result.message || 'RUC no encontrado en SUNAT');
            }
        } catch (error) {
            console.error('Error consultando RUC:', error);
            toast.error('Error al consultar RUC');
        } finally {
            setConsultando(false);
        }
    };

    const handleKeyDown = (e) => {
        if (!showDropdown || proveedores.length === 0) {
            if (e.key === 'Enter') {
                e.preventDefault();
                handleConsultarRUC();
            }
            return;
        }

        switch (e.key) {
            case 'ArrowDown':
                e.preventDefault();
                setSelectedIndex(prev => prev < proveedores.length - 1 ? prev + 1 : prev);
                break;
            case 'ArrowUp':
                e.preventDefault();
                setSelectedIndex(prev => prev > 0 ? prev - 1 : -1);
                break;
            case 'Enter':
                e.preventDefault();
                if (selectedIndex >= 0 && proveedores[selectedIndex]) {
                    handleSelectProveedor(proveedores[selectedIndex]);
                }
                break;
            case 'Escape':
                setShowDropdown(false);
                setSelectedIndex(-1);
                break;
        }
    };

    return (
        <div className="relative" ref={dropdownRef}>
            <div className="flex gap-2">
                <div className="relative flex-1">
                    <Input
                        type="text"
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        onKeyDown={handleKeyDown}
                        placeholder="Buscar por RUC o razón social..."
                        autoComplete="off"
                    />
                    {loading && (
                        <Loader2 className="absolute right-3 top-1/2 -translate-y-1/2 h-4 w-4 animate-spin text-gray-400" />
                    )}
                </div>

                <Button
                    type="button"
                    onClick={handleConsultarRUC}
                    disabled={consultando || !searchTerm.trim()}
                    size="icon"
                    className="flex-shrink-0"
                    title="Consultar RUC en SUNAT"
                >
                    {consultando ? (
                        <Loader2 className="h-4 w-4 animate-spin" />
                    ) : (
                        <Search className="h-4 w-4" />
                    )}
                </Button>
            </div>

            {showDropdown && proveedores.length > 0 && (
                <div className="absolute z-50 w-full mt-1 bg-white border border-gray-200 rounded-lg shadow-lg max-h-[400px] overflow-y-auto">
                    {proveedores.map((proveedor, index) => (
                        <div
                            key={proveedor.proveedor_id}
                            onClick={() => handleSelectProveedor(proveedor)}
                            onMouseEnter={() => setSelectedIndex(index)}
                            className={`
                                flex items-start gap-3 p-3 cursor-pointer transition-colors
                                hover:bg-orange-50 border-b border-gray-100 last:border-b-0
                                ${selectedIndex === index ? 'bg-orange-50 border-l-4 border-l-orange-500' : ''}
                            `}
                        >
                            <div className="w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0 bg-green-100">
                                <Building2 className="h-5 w-5 text-green-600" />
                            </div>
                            <div className="flex-1 min-w-0">
                                <p className="font-medium text-sm text-gray-900 truncate">
                                    {proveedor.razon_social}
                                </p>
                                <p className="text-xs text-gray-500">
                                    RUC: {proveedor.ruc}
                                </p>
                                {proveedor.direccion && (
                                    <p className="text-xs text-gray-400 truncate mt-1">
                                        {proveedor.direccion}
                                    </p>
                                )}
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {showDropdown && !loading && searchTerm.length >= 2 && proveedores.length === 0 && (
                <div className="absolute z-50 w-full mt-1 bg-white border border-gray-200 rounded-lg shadow-lg p-4 text-center">
                    <p className="text-gray-500 text-sm">No se encontraron proveedores</p>
                    <p className="text-gray-400 text-xs mt-1">
                        Ingrese el RUC y presione el botón de búsqueda para consultar SUNAT
                    </p>
                </div>
            )}
        </div>
    );
}
