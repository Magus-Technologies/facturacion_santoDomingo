import { Eye } from 'lucide-react';
import { Button } from '@/components/ui/button';

export default function ResumenVentasPorMetodo({ metodos = [], onVerDetalle }) {
    if (!metodos || metodos.length === 0) {
        return (
            <div className="text-center py-8 text-gray-500">
                No hay ventas registradas
            </div>
        );
    }

    const totalVentas = metodos.reduce((sum, m) => sum + (parseFloat(m.total) || 0), 0);

    return (
        <div className="space-y-3">
            {metodos.map((metodo) => (
                <div key={metodo.id_metodo_pago} className="flex items-center justify-between p-3 border rounded-lg hover:bg-gray-50">
                    <div className="flex-1">
                        <p className="font-semibold text-gray-900">{metodo.nombre}</p>
                        <p className="text-sm text-gray-500">{metodo.cantidad_ventas || 0} venta(s)</p>
                    </div>
                    <div className="flex items-center gap-3">
                        <span className="font-mono font-semibold text-lg">
                            S/. {parseFloat(metodo.total || 0).toFixed(2)}
                        </span>
                        <Button
                            variant="ghost"
                            size="sm"
                            onClick={() => onVerDetalle(metodo)}
                            title="Ver detalle"
                            className="hover:bg-blue-50"
                        >
                            <Eye className="h-4 w-4 text-primary-600" />
                        </Button>
                    </div>
                </div>
            ))}
            <div className="border-t-2 pt-3 mt-3">
                <div className="flex items-center justify-between">
                    <p className="font-bold text-gray-900">TOTAL VENTAS</p>
                    <span className="font-mono font-bold text-lg">
                        S/. {totalVentas.toFixed(2)}
                    </span>
                </div>
            </div>
        </div>
    );
}
