import { Save } from 'lucide-react';
import { useState } from 'react';

export default function ConfiguracionPage() {
    const [config, setConfig] = useState({
        nombreTienda: 'Viña Santo Domingo',
        email: 'info@vinasantodomingo.com',
        telefono: '+51 123 456 789',
        direccion: 'Jr. Andahuaylas 1049, Lima',
        comisionVentas: '2.5',
        impuesto: '18',
    });

    const handleChange = (e) => {
        const { name, value } = e.target;
        setConfig(prev => ({ ...prev, [name]: value }));
    };

    const handleSave = () => {
        console.log('Configuración guardada:', config);
    };

    return (
        <div className="space-y-6">
            <h1 className="text-3xl font-bold text-gray-900">Configuración del Ecommerce</h1>

            <div className="bg-white rounded-lg shadow p-6">
                <div className="space-y-6">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-2">Nombre de la Tienda</label>
                            <input
                                type="text"
                                name="nombreTienda"
                                value={config.nombreTienda}
                                onChange={handleChange}
                                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            />
                        </div>
                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-2">Email</label>
                            <input
                                type="email"
                                name="email"
                                value={config.email}
                                onChange={handleChange}
                                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            />
                        </div>
                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-2">Teléfono</label>
                            <input
                                type="tel"
                                name="telefono"
                                value={config.telefono}
                                onChange={handleChange}
                                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            />
                        </div>
                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-2">Dirección</label>
                            <input
                                type="text"
                                name="direccion"
                                value={config.direccion}
                                onChange={handleChange}
                                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            />
                        </div>
                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-2">Comisión de Ventas (%)</label>
                            <input
                                type="number"
                                name="comisionVentas"
                                value={config.comisionVentas}
                                onChange={handleChange}
                                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            />
                        </div>
                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-2">Impuesto (%)</label>
                            <input
                                type="number"
                                name="impuesto"
                                value={config.impuesto}
                                onChange={handleChange}
                                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                            />
                        </div>
                    </div>

                    <button
                        onClick={handleSave}
                        className="bg-blue-600 text-white px-6 py-2 rounded-lg flex items-center gap-2 hover:bg-blue-700"
                    >
                        <Save className="w-5 h-5" />
                        Guardar Configuración
                    </button>
                </div>
            </div>
        </div>
    );
}
