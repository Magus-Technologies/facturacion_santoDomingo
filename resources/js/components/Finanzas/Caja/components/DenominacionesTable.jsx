import { Input } from '@/components/ui/input';
import { Banknote } from 'lucide-react';

export default function DenominacionesTable({ denominaciones, onChange }) {
    const handleCantidadChange = (id, cantidad) => {
        const updated = denominaciones.map(d => {
            if (d.id_denominacion === id) {
                const cant = parseInt(cantidad) || 0;
                return { ...d, cantidad: cant, subtotal: cant * d.valor };
            }
            return d;
        });
        onChange(updated);
    };

    const total = denominaciones.reduce((sum, d) => sum + (d.subtotal || 0), 0);

    const getNombre = (d) => {
        if (d.nombre) return d.nombre;
        const prefix = d.tipo === 'billete' ? 'Billete' : 'Moneda';
        return `${prefix} S/. ${parseFloat(d.valor).toFixed(2)}`;
    };

    return (
        <div className="border border-gray-200 rounded-lg overflow-hidden">
            {/* Subheader */}
            <div className="flex items-center gap-2 px-4 py-2 bg-red-50 border-b border-red-100">
                <Banknote className="h-4 w-4 text-primary-600" />
                <span className="text-sm font-medium text-gray-700">Desglose de Billetes y Monedas</span>
            </div>

            <table className="w-full text-sm">
                <thead className="bg-gray-50">
                    <tr className="border-b border-gray-200">
                        <th className="text-center py-2 px-3 font-semibold text-gray-600 w-8">#</th>
                        <th className="text-left py-2 px-3 font-semibold text-gray-600">Denominación</th>
                        <th className="text-center py-2 px-3 font-semibold text-gray-600 w-28">Cant.</th>
                        <th className="text-right py-2 px-3 font-semibold text-gray-600 w-24">Total</th>
                    </tr>
                </thead>
                <tbody>
                    {denominaciones.map((denom, idx) => (
                        <tr key={denom.id_denominacion} className="border-b border-gray-100 hover:bg-gray-50">
                            <td className="py-2 px-3 text-center text-gray-400 text-xs">{idx + 1}</td>
                            <td className="py-2 px-3 text-gray-800">{getNombre(denom)}</td>
                            <td className="py-2 px-3">
                                <Input
                                    type="number"
                                    min="0"
                                    value={denom.cantidad || 0}
                                    onChange={(e) => handleCantidadChange(denom.id_denominacion, e.target.value)}
                                    className="h-7 w-full text-center bg-gray-100 border-gray-200 text-sm font-mono px-2"
                                />
                            </td>
                            <td className="py-2 px-3 text-right font-mono text-gray-700">
                                {(denom.subtotal || 0).toFixed(2)}
                            </td>
                        </tr>
                    ))}
                </tbody>
                <tfoot>
                    <tr className="bg-gray-50 border-t-2 border-gray-300">
                        <td colSpan="3" className="py-2 px-3 text-right font-bold text-gray-700 text-xs uppercase tracking-wide">
                            Total
                        </td>
                        <td className="py-2 px-3 text-right font-bold font-mono text-gray-900">
                            S/. {total.toFixed(2)}
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
    );
}
