import { Modal } from '@/components/ui/modal';
import { Button } from '@/components/ui/button';

export default function ModalDetalleVentas({ isOpen, metodo, ventas = [], total = 0, onClose }) {
    return (
        <Modal isOpen={isOpen} onClose={onClose} title={`Ventas con Método: ${metodo?.nombre || 'N/A'}`} size="md">
            <div className="space-y-4">
                    {/* Tabla de ventas */}
                    <div className="overflow-x-auto">
                        <table className="w-full text-sm">
                            <thead>
                                <tr className="border-b">
                                    <th className="text-left py-2 px-3 font-semibold">#</th>
                                    <th className="text-left py-2 px-3 font-semibold">Número</th>
                                    <th className="text-left py-2 px-3 font-semibold">Cliente</th>
                                    <th className="text-right py-2 px-3 font-semibold">Monto</th>
                                    <th className="text-center py-2 px-3 font-semibold">Hora</th>
                                    <th className="text-center py-2 px-3 font-semibold">Ref.</th>
                                </tr>
                            </thead>
                            <tbody>
                                {ventas && ventas.length > 0 ? (
                                    ventas.map((venta, index) => (
                                        <tr key={venta.id_venta || index} className="border-b hover:bg-gray-50">
                                            <td className="py-3 px-3 text-gray-500">{index + 1}</td>
                                            <td className="py-3 px-3 font-mono">{venta.numero || 'N/A'}</td>
                                            <td className="py-3 px-3">{venta.cliente || 'N/A'}</td>
                                            <td className="py-3 px-3 text-right font-mono">
                                                S/. {parseFloat(venta.monto || 0).toFixed(2)}
                                            </td>
                                            <td className="py-3 px-3 text-center text-sm text-gray-500">
                                                {venta.hora || '—'}
                                            </td>
                                            <td className="py-3 px-3 text-center text-sm text-gray-500">
                                                {venta.referencia || '—'}
                                            </td>
                                        </tr>
                                    ))
                                ) : (
                                    <tr>
                                        <td colSpan="6" className="py-4 text-center text-gray-500">
                                            No hay ventas registradas
                                        </td>
                                    </tr>
                                )}
                            </tbody>
                            <tfoot>
                                <tr className="border-t-2 font-bold">
                                    <td colSpan="3" className="py-3 px-3 text-right">
                                        TOTAL {metodo?.nombre || ''}
                                    </td>
                                    <td className="py-3 px-3 text-right font-mono">
                                        S/. {parseFloat(total || 0).toFixed(2)}
                                    </td>
                                    <td colSpan="2"></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    {/* Botón cerrar */}
                    <div className="flex justify-end gap-2 pt-4 border-t">
                        <Button variant="outline" onClick={onClose}>
                            Cerrar
                        </Button>
                    </div>
                </div>
            </Modal>
        );
    }
