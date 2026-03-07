import { useState, useEffect } from 'react';
import { Upload, X } from 'lucide-react';

export default function FotoUploadField({ value, onChange, error, existingFoto, compact = false }) {
    const [preview, setPreview] = useState(null);

    // Cargar foto existente cuando se abre el modal de edición
    useEffect(() => {
        if (existingFoto && !value) {
            setPreview(existingFoto);
        }
    }, [existingFoto, value]);

    const handleFileChange = (e) => {
        const file = e.target.files?.[0];
        if (file) {
            console.log('Archivo seleccionado:', file.name, file.type, file.size);
            
            // Validar tipo de archivo
            if (!['image/jpeg', 'image/png', 'image/jpg', 'image/gif'].includes(file.type)) {
                alert('Por favor selecciona una imagen válida (JPEG, PNG, JPG o GIF)');
                return;
            }

            // Validar tamaño (máximo 2MB)
            if (file.size > 2 * 1024 * 1024) {
                alert('La imagen no debe exceder 2MB');
                return;
            }

            // Crear preview
            const reader = new FileReader();
            reader.onloadend = () => {
                setPreview(reader.result);
            };
            reader.readAsDataURL(file);

            // Pasar el archivo al padre
            console.log('Pasando archivo al padre');
            onChange(file);
        }
    };

    const handleRemove = () => {
        setPreview(null);
        onChange(null);
    };

    return (
        <div className="space-y-2">
            <label className="block text-sm font-medium text-gray-700">
                Foto del Cliente
            </label>

            {preview ? (
                <div className={`relative ${compact ? 'w-32 h-32' : 'w-full h-40'}`}>
                    <img
                        src={preview}
                        alt="Preview"
                        className={`${compact ? 'w-32 h-32' : 'w-full h-40'} object-cover rounded-lg border border-gray-200`}
                    />
                    <button
                        type="button"
                        onClick={handleRemove}
                        className="absolute top-2 right-2 p-1 bg-red-500 text-white rounded-lg hover:bg-red-600 transition-colors"
                    >
                        <X className="w-4 h-4" />
                    </button>
                </div>
            ) : (
                <label className={`flex flex-col items-center justify-center border-2 border-dashed border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50 transition-colors ${compact ? 'w-32 h-32 p-2' : 'w-full h-40 p-4'}`}>
                    <div className="flex flex-col items-center justify-center">
                        <Upload className={`${compact ? 'w-6 h-6' : 'w-10 h-10'} text-gray-400 mb-2`} />
                        <p className={`${compact ? 'text-xs' : 'text-sm'} text-gray-500 text-center`}>
                            <span className="font-semibold">Haz clic</span> para subir
                        </p>
                        <p className="text-xs text-gray-400 mt-0.5">
                            PNG, JPG (máx. 2MB)
                        </p>
                    </div>
                    <input
                        type="file"
                        className="hidden"
                        accept="image/*"
                        onChange={handleFileChange}
                    />
                </label>
            )}

            {error && (
                <p className="text-sm text-red-600">{error}</p>
            )}
        </div>
    );
}
