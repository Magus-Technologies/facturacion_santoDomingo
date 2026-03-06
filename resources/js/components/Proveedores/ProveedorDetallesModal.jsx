import React, { useState, useEffect } from "react";
import { Modal } from "@/components/ui/modal";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
    Phone,
    MapPin,
    Mail,
    Building2,
    Calendar,
    Coins,
    DollarSign,
    ShoppingCart,
    Loader2,
    CheckCircle,
    XCircle,
} from "lucide-react";
import { baseUrl } from "@/lib/baseUrl";

export default function ProveedorDetallesModal({
    isOpen,
    onClose,
    proveedorId,
}) {
    const [loading, setLoading] = useState(true);
    const [data, setData] = useState(null);
    const [error, setError] = useState(null);

    useEffect(() => {
        if (isOpen && proveedorId) {
            fetchDetalles();
        }
    }, [isOpen, proveedorId]);

    const fetchDetalles = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem("auth_token");
            const response = await fetch(
                `/api/proveedores/${proveedorId}/detalles`,
                {
                    headers: {
                        Authorization: `Bearer ${token}`,
                        Accept: "application/json",
                    },
                },
            );

            if (!response.ok)
                throw new Error("Error al cargar detalles del proveedor");

            const result = await response.json();
            if (result.success) {
                setData(result.data);
            } else {
                throw new Error(result.message || "Error desconocido");
            }
        } catch (err) {
            console.error("Error fetching supplier details:", err);
            setError(err.message);
        } finally {
            setLoading(false);
        }
    };

    const modalTitle = (
        <div className="flex items-center gap-3">
            <div className="bg-primary-100 p-2 rounded-lg">
                <Building2 className="h-5 w-5 text-primary-600" />
            </div>
            <div>
                <span className="text-lg font-bold text-gray-900 leading-none">
                    Detalles del Proveedor
                </span>
                {data && (
                    <p className="text-xs text-gray-500 font-normal mt-1">
                        {data.proveedor.razon_social} • RUC {data.proveedor.ruc}
                    </p>
                )}
            </div>
        </div>
    );

    const modalFooter = (
        <div className="flex items-center justify-end gap-3 w-full">
            <Button variant="outline" onClick={onClose}>
                Cerrar
            </Button>
            <Button
                className="gap-2"
                onClick={() =>
                    (window.location.href = baseUrl(`/compras?proveedor=${proveedorId}`))
                }
            >
                <ShoppingCart className="h-4 w-4" />
                Ver todas las compras
            </Button>
        </div>
    );

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            size="lg"
            title={modalTitle}
            footer={modalFooter}
        >
            <div className="space-y-6">
                {loading ? (
                    <div className="flex flex-col items-center justify-center py-12 gap-3">
                        <Loader2 className="h-10 w-10 animate-spin text-primary-600" />
                        <p className="text-gray-500 animate-pulse">
                            Cargando historial...
                        </p>
                    </div>
                ) : error ? (
                    <div className="bg-red-50 text-red-700 p-4 rounded-xl border border-red-100 flex items-center gap-3">
                        <XCircle className="h-5 w-5" />
                        <p>{error}</p>
                    </div>
                ) : (
                    <div className="space-y-6">
                        {/* Stats Summary */}
                        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                            <div className="bg-blue-50 border border-blue-100 p-4 rounded-xl flex items-center gap-3">
                                <div className="bg-blue-100 p-2 rounded-lg text-blue-600">
                                    <ShoppingCart className="h-4 w-4" />
                                </div>
                                <div>
                                    <p className="text-[10px] text-blue-700 font-bold uppercase tracking-wider">
                                        Compras
                                    </p>
                                    <p className="text-lg font-semibold text-blue-900 leading-none">
                                        {data.stats.total_count}
                                    </p>
                                </div>
                            </div>
                            <div className="bg-green-50 border border-green-100 p-4 rounded-xl flex items-center gap-3">
                                <div className="bg-green-100 p-2 rounded-lg text-green-600">
                                    <Coins className="h-4 w-4" />
                                </div>
                                <div className="truncate">
                                    <p className="text-[10px] text-green-700 font-bold uppercase tracking-wider">
                                        Total (PEN)
                                    </p>
                                    <p className="text-lg font-semibold text-green-900 leading-none truncate">
                                        S/{" "}
                                        {numberFormat(
                                            data.stats.total_monto_pen,
                                        )}
                                    </p>
                                </div>
                            </div>
                            <div className="bg-purple-50 border border-purple-100 p-4 rounded-xl flex items-center gap-3">
                                <div className="bg-purple-100 p-2 rounded-lg text-purple-600">
                                    <DollarSign className="h-4 w-4" />
                                </div>
                                <div className="truncate">
                                    <p className="text-[10px] text-purple-700 font-bold uppercase tracking-wider">
                                        Total (USD)
                                    </p>
                                    <p className="text-lg font-semibold text-purple-900 leading-none truncate">
                                        ${" "}
                                        {numberFormat(
                                            data.stats.total_monto_usd,
                                        )}
                                    </p>
                                </div>
                            </div>
                        </div>

                        {/* Info Grid */}
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                            {/* Contact Info */}
                            <div className="space-y-3">
                                <h3 className="text-xs font-semibold text-gray-400 uppercase tracking-[0.2em] flex items-center gap-2">
                                    Contacto y Ubicación
                                </h3>
                                <div className="space-y-3 bg-gray-50/50 p-4 rounded-xl border border-gray-100">
                                    <div className="flex items-start gap-3">
                                        <Mail className="h-4 w-4 text-gray-400 mt-0.5" />
                                        <div className="flex-1 min-w-0">
                                            <p className="text-[10px] text-gray-400 font-bold uppercase">
                                                Email
                                            </p>
                                            <p className="text-sm font-medium text-gray-900 truncate">
                                                {data.proveedor.email ||
                                                    "No registrado"}
                                            </p>
                                        </div>
                                    </div>
                                    <div className="flex items-start gap-3">
                                        <Phone className="h-4 w-4 text-gray-400 mt-0.5" />
                                        <div className="flex-1">
                                            <p className="text-[10px] text-gray-400 font-bold uppercase">
                                                Teléfono
                                            </p>
                                            <p className="text-sm font-medium text-gray-900">
                                                {data.proveedor.telefono ||
                                                    "No registrado"}
                                            </p>
                                        </div>
                                    </div>
                                    <div className="flex items-start gap-3 border-t border-gray-100 pt-3">
                                        <MapPin className="h-4 w-4 text-gray-400 mt-0.5" />
                                        <div className="flex-1">
                                            <p className="text-[10px] text-gray-400 font-bold uppercase">
                                                Dirección
                                            </p>
                                            <p className="text-sm font-medium text-gray-900 leading-tight">
                                                {data.proveedor.direccion ||
                                                    "No registrada"}
                                            </p>
                                            <p className="text-[10px] text-gray-500 mt-1">
                                                {[
                                                    data.proveedor.distrito,
                                                    data.proveedor.provincia,
                                                    data.proveedor.departamento,
                                                ]
                                                    .filter(Boolean)
                                                    .join(", ")}
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            {/* Recent Purchases */}
                            <div className="space-y-3">
                                <div className="flex items-center justify-between">
                                    <h3 className="text-xs font-semibold text-gray-400 uppercase tracking-[0.2em]">
                                        Compras Recientes
                                    </h3>
                                    <Badge
                                        variant="outline"
                                        className="text-[10px] font-bold border-gray-200"
                                    >
                                        Últimas {data.compras.length}
                                    </Badge>
                                </div>

                                <div className="bg-white border border-gray-100 rounded-xl overflow-hidden divide-y divide-gray-50 max-h-[280px] overflow-y-auto custom-scrollbar">
                                    {data.compras.length > 0 ? (
                                        data.compras.map((compra) => (
                                            <div
                                                key={compra.id_compra}
                                                className="p-3 hover:bg-gray-50 transition-colors flex items-center justify-between gap-4"
                                            >
                                                <div className="flex-1 min-w-0">
                                                    <div className="flex items-center gap-2">
                                                        <p className="text-sm font-bold text-primary-700">
                                                            {compra.serie}-
                                                            {String(
                                                                compra.numero,
                                                            ).padStart(6, "0")}
                                                        </p>
                                                        <StatusBadge
                                                            status={
                                                                compra.estado
                                                            }
                                                        />
                                                    </div>
                                                    <div className="flex items-center gap-2 mt-0.5">
                                                        <Calendar className="h-3 w-3 text-gray-400" />
                                                        <p className="text-xs text-gray-500">
                                                            {new Date(
                                                                compra.fecha_emision,
                                                            ).toLocaleDateString()}
                                                        </p>
                                                    </div>
                                                </div>
                                                <div className="text-right">
                                                    <p className="text-sm font-semibold text-gray-900">
                                                        {compra.moneda === "PEN"
                                                            ? "S/ "
                                                            : "$ "}
                                                        {numberFormat(
                                                            compra.total,
                                                        )}
                                                    </p>
                                                </div>
                                            </div>
                                        ))
                                    ) : (
                                        <div className="p-8 text-center text-gray-400">
                                            <ShoppingCart className="h-8 w-8 mx-auto mb-2 opacity-20" />
                                            <p className="text-xs font-medium">
                                                Sin registros
                                            </p>
                                        </div>
                                    )}
                                </div>
                            </div>
                        </div>
                    </div>
                )}
            </div>
        </Modal>
    );
}

function StatusBadge({ status }) {
    if (status === "1" || status === 1) {
        return (
            <span className="inline-flex items-center gap-1 px-1.5 py-0.5 rounded-full bg-green-50 text-green-600 text-[10px] font-bold border border-green-100">
                <CheckCircle className="h-2.5 w-2.5" /> Registrado
            </span>
        );
    }
    return (
        <span className="inline-flex items-center gap-1 px-1.5 py-0.5 rounded-full bg-red-50 text-red-600 text-[10px] font-bold border border-red-100">
            <XCircle className="h-2.5 w-2.5" /> Anulado
        </span>
    );
}

function numberFormat(num) {
    return parseFloat(num).toLocaleString("en-US", {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2,
    });
}
