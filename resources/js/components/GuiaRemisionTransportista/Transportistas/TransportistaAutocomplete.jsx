import { useState, useEffect, useRef } from 'react';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';
import { Search, X } from 'lucide-react';
import { toast } from '@/lib/sweetalert';

export default function TransportistaAutocomplete({ 
  value, 
  onChange, 
  onSelect,
  placeholder = "Buscar transportista...",
  disabled = false 
}) {
  const [search, setSearch] = useState('');
  const [transportistas, setTransportistas] = useState([]);
  const [loading, setLoading] = useState(false);
  const [showDropdown, setShowDropdown] = useState(false);
  const dropdownRef = useRef(null);

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setShowDropdown(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const handleSearch = async (searchTerm) => {
    setSearch(searchTerm);
    
    if (!searchTerm.trim()) {
      setTransportistas([]);
      setShowDropdown(false);
      return;
    }

    setLoading(true);
    try {
      const token = localStorage.getItem('auth_token');
      const res = await fetch(`/api/transportistas?search=${encodeURIComponent(searchTerm)}`, {
        headers: {
          Authorization: `Bearer ${token}`,
          Accept: 'application/json',
        },
      });

      const data = await res.json();
      if (data.success) {
        setTransportistas(data.data?.data || data.data || []);
        setShowDropdown(true);
      }
    } catch (error) {
      toast.error('Error al buscar transportistas');
    } finally {
      setLoading(false);
    }
  };

  const handleSelect = (transportista) => {
    setSearch('');
    setShowDropdown(false);
    onSelect?.(transportista);
  };

  const handleClear = () => {
    setSearch('');
    setTransportistas([]);
    setShowDropdown(false);
    onChange?.('');
  };

  return (
    <div className="relative" ref={dropdownRef}>
      <div className="flex gap-1">
        <Input
          value={search}
          onChange={(e) => handleSearch(e.target.value)}
          placeholder={placeholder}
          disabled={disabled}
          className="flex-1"
        />
        {search && (
          <Button
            type="button"
            variant="ghost"
            size="icon"
            onClick={handleClear}
            disabled={disabled}
          >
            <X className="h-4 w-4" />
          </Button>
        )}
        <Button
          type="button"
          variant="outline"
          size="icon"
          disabled={disabled || loading}
        >
          <Search className="h-4 w-4" />
        </Button>
      </div>

      {showDropdown && transportistas.length > 0 && (
        <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-200 rounded-md shadow-lg z-50 max-h-64 overflow-y-auto">
          {transportistas.map((transportista) => (
            <button
              key={transportista.id}
              type="button"
              onClick={() => handleSelect(transportista)}
              className="w-full text-left px-4 py-2 hover:bg-gray-100 border-b border-gray-100 last:border-b-0 transition-colors"
            >
              <div className="font-medium text-sm">{transportista.razon_social}</div>
              <div className="text-xs text-gray-500">
                {transportista.numero_documento} • {transportista.numero_mtc || 'Sin MTC'}
              </div>
            </button>
          ))}
        </div>
      )}

      {showDropdown && search && transportistas.length === 0 && !loading && (
        <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-200 rounded-md shadow-lg z-50 p-4 text-center text-sm text-gray-500">
          No se encontraron transportistas
        </div>
      )}
    </div>
  );
}
