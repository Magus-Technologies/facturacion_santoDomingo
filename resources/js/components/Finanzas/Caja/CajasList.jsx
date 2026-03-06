import { useState } from 'react';
import { Plus, PlayCircle } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { DataTable } from '@/components/ui/data-table';
import MainLayout from '@/components/Layout/MainLayout';
import { getCajasColumns } from './columns/cajasColumns';
import { useCajas } from './hooks/useCajas';
import CajaCrearModal from './CajaCrearModal';
import CajaAperturaModal from './modals/CajaAperturaModal';
import CajaCierreModal from './modals/CajaCierreModal';
import CajaResumenCierreModal from './modals/CajaResumenCierreModal';
import CajaValidacionModal from './modals/CajaValidacionModal';
import CajaAbiertaDetail from './CajaAbiertaDetail';

export default function CajasList() {
    const {
        cajas, loading, error,
        isCrearOpen, isAperturaOpen, isCierreOpen, isDetalleOpen, selectedCaja,
        fetchData,
        handleNuevaCaja, handleCrearClose, handleCrearSuccess,
        handleActivarCaja,
        handleAbrirCaja, handleAperturaClose, handleAperturaSuccess,
        handleCerrar, handleCierreClose, handleCierreSuccess,
        handleVerDetalle, handleDetalleClose,
        handleAutorizar, handleRechazar,
    } = useCajas();

    const [isResumenOpen, setIsResumenOpen] = useState(false);
    const [isValidacionOpen, setIsValidacionOpen] = useState(false);
    const [cajaParaResumen, setCajaParaResumen] = useState(null);
    const [cajaParaValidacion, setCajaParaValidacion] = useState(null);

    const handleCerrarClick = (caja) => {
        setCajaParaResumen(caja);
        setIsResumenOpen(true);
    };

    const handleProceedCierre = () => {
        if (cajaParaResumen) {
            handleCerrar(cajaParaResumen);
        }
    };

    const handleAutorizarClick = (caja) => {
        setCajaParaValidacion(caja);
        setIsValidacionOpen(true);
    };

    const columns = getCajasColumns({
        handleVerDetalle,
        handleCerrar: handleCerrarClick,
        handleAutorizar: handleAutorizarClick,
        handleRechazar,
        handleAbrirCaja,
        handleActivarCaja,
    });

    return (
        <MainLayout>
            <div className="space-y-6">
                {/* Encabezado */}
                <div className="flex items-center justify-between">
                    <div>
                        <h1 className="text-3xl font-bold text-gray-900">Cajas</h1>
                        <p className="text-gray-600 mt-1">Gestiona la apertura y cierre de cajas diarias</p>
                    </div>
                    <div className="flex gap-2">
                        <Button variant="outline" onClick={() => handleAbrirCaja(null)} className="gap-2">
                            <PlayCircle className="h-4 w-4 text-green-600" />
                            Aperturar Caja
                        </Button>
                        <Button onClick={handleNuevaCaja} className="gap-2 bg-primary-600 hover:bg-primary-700 text-white">
                            <Plus className="h-4 w-4" />
                            Nueva Caja
                        </Button>
                    </div>
                </div>

                {/* Tabla */}
                {error && (
                    <div className="bg-red-50 border border-red-200 rounded-lg p-4 text-red-700">
                        {error}
                    </div>
                )}

                <div className="bg-white rounded-lg shadow">
                    <DataTable
                        columns={columns}
                        data={cajas || []}
                        loading={loading}
                        pageSize={10}
                    />
                </div>
            </div>

            {/* Modales */}
            <CajaCrearModal
                isOpen={isCrearOpen}
                onClose={handleCrearClose}
                onSuccess={handleCrearSuccess}
            />

            <CajaAperturaModal
                isOpen={isAperturaOpen}
                onClose={handleAperturaClose}
                onSuccess={handleAperturaSuccess}
                caja={selectedCaja}
            />

            <CajaCierreModal
                isOpen={isCierreOpen}
                caja={selectedCaja}
                onClose={handleCierreClose}
                onSuccess={handleCierreSuccess}
            />

            <CajaResumenCierreModal
                isOpen={isResumenOpen}
                caja={cajaParaResumen}
                onClose={() => setIsResumenOpen(false)}
                onProceedCierre={handleProceedCierre}
            />

            <CajaValidacionModal
                isOpen={isValidacionOpen}
                caja={cajaParaValidacion}
                onClose={() => setIsValidacionOpen(false)}
                onSuccess={() => {
                    setIsValidacionOpen(false);
                    fetchData();
                }}
            />

            <CajaAbiertaDetail
                isOpen={isDetalleOpen}
                caja={selectedCaja}
                onClose={handleDetalleClose}
                onCerrar={() => {
                    handleDetalleClose();
                    handleCerrarClick(selectedCaja);
                }}
            />
        </MainLayout>
    );
}
