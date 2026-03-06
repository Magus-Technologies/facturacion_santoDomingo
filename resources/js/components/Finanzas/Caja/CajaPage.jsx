import { Wallet, Plus, Loader2 } from 'lucide-react';
import { DataTable } from '@/components/ui/data-table';
import { Button } from '@/components/ui/button';
import MainLayout from '@/components/Layout/MainLayout';
import { usePermissions } from '@/hooks/usePermissions';
import { useCajas } from './hooks/useCajas';
import { getCajasColumns } from './columns/cajasColumns';
import CajaCrearModal from './CajaCrearModal';
import CajaAperturaModal from './CajaAperturaModal';
import CajaCierreModal from './CajaCierreModal';
import CajaDetalle from './CajaDetalle';

const fmt = (val) => val != null ? `S/ ${parseFloat(val).toFixed(2)}` : '—';

export default function CajaPage() {
    const {
        cajas, cajaActiva, loading, error,
        isCrearOpen, isAperturaOpen, isCierreOpen, isDetalleOpen, selectedCaja,
        fetchData,
        handleNuevaCaja, handleCrearClose, handleCrearSuccess,
        handleAbrirCaja, handleAperturaClose, handleAperturaSuccess,
        handleCerrar, handleCierreClose, handleCierreSuccess,
        handleVerDetalle, handleDetalleClose,
        handleAutorizar, handleRechazar,
    } = useCajas();

    const { hasPermission } = usePermissions();

    const columns = getCajasColumns({
        handleVerDetalle,
        handleCerrar,
        handleAutorizar,
        handleRechazar,
        handleAbrirCaja,
    });

    if (loading) return (
        <MainLayout>
            <div className="flex items-center justify-center min-h-[400px]">
                <Loader2 className="h-10 w-10 animate-spin text-primary-600" />
            </div>
        </MainLayout>
    );

    if (error) return (
        <MainLayout>
            <div className="flex items-center justify-center min-h-[400px]">
                <div className="text-center">
                    <p className="text-red-600">{error}</p>
                    <Button onClick={fetchData} className="mt-3">Reintentar</Button>
                </div>
            </div>
        </MainLayout>
    );

    return (
        <MainLayout>
            <div className="space-y-6">
                <div className="flex items-center justify-between">
                    <div>
                        <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
                            <Wallet className="h-6 w-6 text-primary-600" /> Control de Caja
                        </h1>
                        <p className="text-gray-500 mt-1">Gestiona las cajas y sus aperturas diarias</p>
                    </div>
                    {hasPermission('caja.create') && (
                        <Button onClick={handleNuevaCaja} className="gap-2 bg-primary-600 hover:bg-primary-700 text-white">
                            <Plus className="h-4 w-4" /> Nueva Caja
                        </Button>
                    )}
                </div>

                {/* Banner caja activa */}
                {cajaActiva && (
                    <div className="bg-green-50 border border-green-200 rounded-lg p-4 flex items-center justify-between">
                        <div className="flex items-center gap-3">
                            <div className="h-3 w-3 rounded-full bg-green-500 animate-pulse" />
                            <div>
                                <p className="font-semibold text-green-800">
                                    {cajaActiva.nombre || `Caja #${cajaActiva.id_caja}`} — Abierta
                                </p>
                                <p className="text-sm text-green-600">
                                    Desde {new Date(cajaActiva.fecha_apertura).toLocaleString('es-PE', { dateStyle: 'short', timeStyle: 'short' })}
                                    {' · '}Saldo inicial: {fmt(cajaActiva.saldo_inicial)}
                                    {cajaActiva.responsable && ` · Responsable: ${cajaActiva.responsable.name}`}
                                </p>
                            </div>
                        </div>
                        <div className="flex gap-2">
                            <Button variant="outline" size="sm" onClick={() => handleVerDetalle(cajaActiva)} className="border-green-300 text-green-700">
                                Ver detalle
                            </Button>
                            <Button size="sm" onClick={() => handleCerrar(cajaActiva)} className="bg-orange-600 hover:bg-orange-700 text-white">
                                Cerrar caja
                            </Button>
                        </div>
                    </div>
                )}

                <DataTable
                    columns={columns}
                    data={cajas}
                    searchable
                    searchPlaceholder="Buscar por nombre, responsable o estado..."
                    pagination
                    pageSize={10}
                />

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
                    onClose={handleCierreClose}
                    caja={selectedCaja}
                    onSuccess={handleCierreSuccess}
                />

                <CajaDetalle
                    isOpen={isDetalleOpen}
                    onClose={handleDetalleClose}
                    caja={selectedCaja}
                />
            </div>
        </MainLayout>
    );
}
