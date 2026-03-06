import { useState } from 'react';
import { User, X } from 'lucide-react';
import { createPortal } from 'react-dom';

export default function FotoClienteCell({ fotoUrl, nombreCliente }) {
    const [showModal, setShowModal] = useState(false);

    return (
        <>
            <button
                onClick={() => setShowModal(true)}
                className="flex items-center justify-center w-10 h-10 rounded-lg bg-gradient-to-br from-red-500 to-red-600 hover:from-red-600 hover:to-red-700 transition-all cursor-pointer shadow-sm overflow-hidden"
                title="Ver foto"
            >
                {fotoUrl ? (
                    <img
                        src={fotoUrl}
                        alt={nombreCliente}
                        className="w-full h-full object-cover"
                    />
                ) : (
                    <User className="w-5 h-5 text-white" />
                )}
            </button>

            {showModal && createPortal(
                <div
                    className="fixed inset-0 bg-black/50 flex items-center justify-center z-[9999] p-4"
                    onClick={() => setShowModal(false)}
                >
                    <div
                        className="bg-white rounded-2xl shadow-2xl max-w-2xl w-full overflow-hidden"
                        onClick={(e) => e.stopPropagation()}
                    >
                        <div className="flex items-center justify-between p-6 border-b border-gray-100 bg-gray-50">
                            <h3 className="font-bold text-lg text-gray-900">{nombreCliente}</h3>
                            <button
                                onClick={() => setShowModal(false)}
                                className="p-2 hover:bg-gray-200 rounded-lg transition-colors"
                            >
                                <X className="w-5 h-5 text-gray-600" />
                            </button>
                        </div>
                        <div className="p-6 flex items-center justify-center bg-gray-50 min-h-96">
                            {fotoUrl ? (
                                <img
                                    src={fotoUrl}
                                    alt={nombreCliente}
                                    className="max-w-full max-h-96 rounded-xl shadow-lg"
                                />
                            ) : (
                                <div className="flex flex-col items-center justify-center h-64 text-center">
                                    <User className="w-16 h-16 text-gray-300 mb-3" />
                                    <p className="text-gray-500 font-medium">Sin foto disponible</p>
                                </div>
                            )}
                        </div>
                    </div>
                </div>,
                document.body
            )}
        </>
    );
}
