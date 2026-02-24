import React, { useEffect, useState } from "react";
import {
    FileText,
    TrendingUp,
    Users,
    Package,
    DollarSign,
    ShoppingCart,
    AlertCircle,
    CheckCircle,
    Clock,
    ArrowUpRight,
    ArrowDownRight,
    Loader2,
} from "lucide-react";

const ICON_MAP = {
    DollarSign: DollarSign,
    FileText: FileText,
    Users: Users,
    Package: Package,
};

export default function Dashboard() {
    const [stats, setStats] = useState([]);
    const [recentInvoices, setRecentInvoices] = useState([]);
    const [sunatStatus, setSunatStatus] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        fetchDashboardData();
    }, []);

    const fetchDashboardData = async () => {
        try {
            setLoading(true);
            const token = localStorage.getItem("auth_token");
            const response = await fetch("/api/dashboard/stats", {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                },
            });

            if (!response.ok) {
                throw new Error("Error al cargar datos del dashboard");
            }

            const data = await response.json();
            
            // Manejar error de empresa no asignada o cualquier otro error
            if (data.success === false) {
                setError(data.message || "Error al cargar datos del dashboard");
                setStats([]);
                setRecentInvoices([]);
                setSunatStatus({ pendientes: 0, ultima_conexion: null });
                setLoading(false);
                return;
            }

            setStats(data.stats || []);
            setRecentInvoices(data.recentInvoices || []);
            setSunatStatus(data.sunat || { pendientes: 0, ultima_conexion: null });
            setError(null);
        } catch (err) {
            console.error("Dashboard error:", err);
            setError(err.message || "Error de conexión al servidor");
        } finally {
            setLoading(false);
        }
    };

    if (loading) {
        return (
            <div className="flex flex-col items-center justify-center min-h-[400px] gap-3 text-gray-500">
                <Loader2 className="h-8 w-8 animate-spin text-primary-600" />
                <p className="text-sm font-medium animate-pulse">
                    Analizando datos reales...
                </p>
            </div>
        );
    }

    if (error) {
        return (
            <div className="p-8 bg-red-50 text-red-700 rounded-xl border border-red-100 flex items-center gap-3">
                <AlertCircle className="h-6 w-6" />
                <p>{error}</p>
            </div>
        );
    }

    return (
        <div className="space-y-6">
            {/* Welcome Section */}
            <div className="bg-gradient-to-r from-primary-600 to-primary-700 rounded-2xl p-6 text-white shadow-lg">
                <div className="flex items-center justify-between">
                    <div>
                        <h1 className="text-2xl font-bold mb-2">
                            ¡Bienvenido de nuevo! 👋
                        </h1>
                        <p className="text-primary-100">
                            Aquí está un resumen de tu negocio hoy
                        </p>
                    </div>
                    <div className="hidden md:block">
                        <div className="bg-white/10 backdrop-blur-sm rounded-lg px-6 py-4">
                            <p className="text-sm text-primary-100">Fecha</p>
                            <p className="text-xl font-semibold">
                                {new Date().toLocaleDateString("es-ES", {
                                    day: "2-digit",
                                    month: "long",
                                    year: "numeric",
                                })}
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            {/* Stats Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                {stats.map((stat) => {
                    const Icon = ICON_MAP[stat.icon] || Package;
                    return (
                        <div
                            key={stat.id}
                            className="bg-white rounded-xl p-6 shadow-sm border border-gray-100 hover:shadow-md transition-shadow"
                        >
                            <div className="flex items-start justify-between">
                                <div className="flex-1">
                                    <p className="text-sm text-gray-500 mb-1">
                                        {stat.title}
                                    </p>
                                    <h3 className="text-2xl font-bold text-gray-900 mb-2">
                                        {stat.value}
                                    </h3>
                                    <div className="flex items-center gap-1">
                                        {stat.isPositive ? (
                                            <ArrowUpRight className="h-4 w-4 text-green-500" />
                                        ) : (
                                            <ArrowDownRight className="h-4 w-4 text-red-500" />
                                        )}
                                        <span
                                            className={`text-sm font-medium ${
                                                stat.isPositive
                                                    ? "text-green-600"
                                                    : "text-red-600"
                                            }`}
                                        >
                                            {stat.change}
                                        </span>
                                        <span className="text-xs text-gray-500">
                                            {stat.id === 4
                                                ? ""
                                                : "vs mes anterior"}
                                        </span>
                                    </div>
                                </div>
                                <div
                                    className={`${stat.bgColor} p-3 rounded-lg`}
                                >
                                    <Icon className="h-6 w-6 text-white" />
                                </div>
                            </div>
                        </div>
                    );
                })}
            </div>

            {/* Recent Activity */}
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                {/* Recent Invoices */}
                <div className="lg:col-span-2 bg-white rounded-xl shadow-sm border border-gray-100">
                    <div className="p-6 border-b border-gray-100">
                        <div className="flex items-center justify-between">
                            <div>
                                <h2 className="text-lg font-semibold text-gray-900">
                                    Documentos Recientes
                                </h2>
                                <p className="text-sm text-gray-500 mt-1">
                                    Últimas ventas emitidas
                                </p>
                            </div>
                            <a
                                href="/ventas"
                                className="text-sm text-primary-600 hover:text-primary-700 font-medium"
                            >
                                Ver todas →
                            </a>
                        </div>
                    </div>
                    <div className="divide-y divide-gray-100">
                        {recentInvoices.length > 0 ? (
                            recentInvoices.map((invoice, idx) => (
                                <div
                                    key={invoice.id || idx}
                                    className="p-4 hover:bg-gray-50 transition-colors"
                                >
                                    <div className="flex items-center justify-between">
                                        <div className="flex-1">
                                            <div className="flex items-center gap-3">
                                                <div className="bg-primary-50 p-2 rounded-lg">
                                                    <FileText className="h-5 w-5 text-primary-600" />
                                                </div>
                                                <div>
                                                    <p className="font-medium text-gray-900">
                                                        {invoice.id}
                                                    </p>
                                                    <p className="text-sm text-gray-500">
                                                        {invoice.client}
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="text-right">
                                            <p className="font-semibold text-gray-900">
                                                {invoice.amount}
                                            </p>
                                            <div className="flex items-center gap-2 mt-1">
                                                <span
                                                    className={`text-xs px-2 py-1 rounded-full font-medium ${
                                                        invoice.status ===
                                                        "Aceptado"
                                                            ? "bg-green-100 text-green-700"
                                                            : invoice.status ===
                                                                "Anulado"
                                                              ? "bg-red-100 text-red-700"
                                                              : "bg-yellow-100 text-yellow-700"
                                                    }`}
                                                >
                                                    {invoice.status}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            ))
                        ) : (
                            <div className="p-8 text-center text-gray-500">
                                <Package className="h-12 w-12 mx-auto mb-3 opacity-20" />
                                <p>No hay ventas registradas recientemente.</p>
                            </div>
                        )}
                    </div>
                </div>

                {/* Quick Actions */}
                <div className="space-y-6">
                    {/* Quick Actions Card */}
                    <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
                        <h2 className="text-lg font-semibold text-gray-900 mb-4">
                            Acciones Rápidas
                        </h2>
                        <div className="space-y-3">
                            <a
                                href="/ventas/productos"
                                className="w-full flex items-center gap-3 px-4 py-3 bg-primary-600 hover:bg-primary-700 text-white rounded-lg transition-colors no-underline"
                            >
                                <ShoppingCart className="h-5 w-5" />
                                <span className="font-medium">Nueva Venta</span>
                            </a>
                            <a
                                href="/productos"
                                className="w-full flex items-center gap-3 px-4 py-3 bg-accent-500 hover:bg-accent-600 text-gray-900 rounded-lg transition-colors no-underline"
                            >
                                <Package className="h-5 w-5" />
                                <span className="font-medium">
                                    Ver Inventario
                                </span>
                            </a>
                            <a
                                href="/clientes"
                                className="w-full flex items-center gap-3 px-4 py-3 bg-gray-100 hover:bg-gray-200 text-gray-700 rounded-lg transition-colors no-underline"
                            >
                                <Users className="h-5 w-5" />
                                <span className="font-medium">
                                    Nuevo Cliente
                                </span>
                            </a>
                        </div>
                    </div>

                    {/* Status Card */}
                    <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
                        <h2 className="text-lg font-semibold text-gray-900 mb-4">
                            Estado SUNAT
                        </h2>
                        <div className="space-y-3">
                            <div className="flex items-center gap-3">
                                <CheckCircle className="h-5 w-5 text-green-500" />
                                <div className="flex-1">
                                    <p className="text-sm font-medium text-gray-700">
                                        Conexión activa
                                    </p>
                                    <p className="text-xs text-gray-500">
                                        Última sincronización:{" "}
                                        {sunatStatus?.ultima_conexion
                                            ? new Date(
                                                  sunatStatus.ultima_conexion,
                                              ).toLocaleTimeString()
                                            : "---"}
                                    </p>
                                </div>
                            </div>
                            <div className="flex items-center gap-3">
                                {sunatStatus?.pendientes > 0 ? (
                                    <Clock className="h-5 w-5 text-yellow-500" />
                                ) : (
                                    <CheckCircle className="h-5 w-5 text-green-500" />
                                )}
                                <div className="flex-1">
                                    <p className="text-sm font-medium text-gray-700">
                                        {sunatStatus?.pendientes || 0}{" "}
                                        documentos pendientes
                                    </p>
                                    <p className="text-xs text-gray-500">
                                        {sunatStatus?.pendientes > 0
                                            ? "En cola de envío"
                                            : "Al día con SUNAT"}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
