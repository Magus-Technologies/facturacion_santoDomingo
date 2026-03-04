import React, { useState, useEffect } from "react";
import {
    Menu,
    X,
    Bell,
    User,
    LogOut,
    ChevronDown,
    Settings,
    Building2,
    Check,
} from "lucide-react";

export default function Header({ toggleSidebar, isSidebarOpen, isCollapsed }) {
    const [user, setUser] = useState(null);
    const [showUserMenu, setShowUserMenu] = useState(false);
    const [showEmpresaMenu, setShowEmpresaMenu] = useState(false);
    const [notifications, setNotifications] = useState(3);
    const [empresas, setEmpresas] = useState([]);
    const [empresaActiva, setEmpresaActiva] = useState(null);

    useEffect(() => {
        const userData = localStorage.getItem("user");
        if (userData) {
            setUser(JSON.parse(userData));
        }

        const empresasData = localStorage.getItem("empresas");
        if (empresasData) {
            setEmpresas(JSON.parse(empresasData));
        }

        const empresaActivaData = localStorage.getItem("empresa_activa");
        if (empresaActivaData) {
            setEmpresaActiva(JSON.parse(empresaActivaData));
        }
    }, []);

    const isAdmin = user?.rol_id === 1;

    const handleCambiarEmpresa = async (empresa) => {
        setShowEmpresaMenu(false);
        try {
            const token = localStorage.getItem("auth_token");
            const res = await fetch("/api/switch-empresa", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                },
                body: JSON.stringify({ id_empresa: empresa.id_empresa }),
            });
            const data = await res.json();
            if (!data.success) {
                console.error("Error al cambiar empresa:", data.message);
                return;
            }
        } catch (err) {
            console.error("Error al cambiar empresa:", err);
            return;
        }
        setEmpresaActiva(empresa);
        localStorage.setItem("empresa_activa", JSON.stringify(empresa));
        // Recargar para que todos los componentes usen la nueva empresa
        window.location.reload();
    };

    const handleLogout = () => {
        const token = localStorage.getItem("auth_token");

        // Limpiar localStorage y redirigir inmediatamente
        localStorage.removeItem("auth_token");
        localStorage.removeItem("user");
        localStorage.removeItem("empresas");
        localStorage.removeItem("empresa_activa");
        window.location.href = "/login";

        // Invalidar token en segundo plano (no bloquea al usuario)
        if (token) {
            fetch("/api/logout", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    Authorization: `Bearer ${token}`,
                },
            }).catch(() => {});
        }
    };

    const getNombreCorto = (nombre) => {
        if (!nombre) return "Empresa";
        // Si tiene " - " tomar la parte corta (ej: "ILIDESAVA & DESAVA S.R.L.")
        const partes = nombre.split(" - ");
        if (partes.length > 1) return partes[partes.length - 1];
        // Si es muy largo, truncar
        return nombre.length > 30 ? nombre.substring(0, 30) + "…" : nombre;
    };

    return (
        <header
            className={`bg-white border-b border-gray-200 h-16 fixed top-0 right-0 z-30 transition-all duration-300 ${
                isCollapsed ? "left-0 lg:left-20" : "left-0 lg:left-64"
            }`}
        >
            <div className="h-full px-4 flex items-center justify-between">
                {/* Left Side - Menu Toggle & Empresa */}
                <div className="flex items-center gap-4">
                    <button
                        onClick={toggleSidebar}
                        className="lg:hidden p-2 rounded-lg hover:bg-gray-100 transition-colors"
                    >
                        {isSidebarOpen ? (
                            <X className="h-6 w-6 text-gray-600" />
                        ) : (
                            <Menu className="h-6 w-6 text-gray-600" />
                        )}
                    </button>

                    {/* Empresa activa - Solo muestra info, sin selector */}
                    <div className="flex items-center gap-2">
                        <Building2 className="h-5 w-5 text-primary-600" />
                        <div>
                            <p className="text-sm font-bold text-gray-800 leading-tight">
                                {getNombreCorto(empresaActiva?.comercial) ||
                                    "Sistema de Facturación"}
                            </p>
                            {empresaActiva?.ruc && (
                                <p className="text-[10px] text-gray-400">
                                    RUC: {empresaActiva.ruc}
                                </p>
                            )}
                        </div>
                    </div>
                </div>

                {/* Right Side - Notifications & User */}
                <div className="flex items-center gap-3">
                    {/* Notifications */}
                    <button className="relative p-2 rounded-lg hover:bg-gray-100 transition-colors">
                        <Bell className="h-5 w-5 text-gray-600" />
                        {notifications > 0 && (
                            <span className="absolute top-1 right-1 h-4 w-4 bg-red-500 text-white text-xs rounded-full flex items-center justify-center">
                                {notifications}
                            </span>
                        )}
                    </button>

                    {/* User Menu */}
                    <div className="relative">
                        <button
                            onClick={() => setShowUserMenu(!showUserMenu)}
                            className="flex items-center gap-3 px-3 py-2 rounded-lg hover:bg-gray-100 transition-colors"
                        >
                            <div className="hidden sm:block text-right">
                                <p className="text-sm font-medium text-gray-800">
                                    {user?.name || "Usuario"}
                                </p>
                                <p className="text-xs text-gray-500">
                                    {user?.email || ""}
                                </p>
                            </div>
                            <div className="h-9 w-9 rounded-full bg-linear-to-br from-primary-500 to-primary-600 flex items-center justify-center text-white font-semibold">
                                {user?.name?.charAt(0) || "U"}
                            </div>
                            <ChevronDown className="h-4 w-4 text-gray-500 hidden sm:block" />
                        </button>

                        {/* Dropdown Menu */}
                        {showUserMenu && (
                            <>
                                <div
                                    className="fixed inset-0 z-10"
                                    onClick={() => setShowUserMenu(false)}
                                ></div>
                                <div className="absolute right-0 mt-2 w-56 bg-white rounded-lg shadow-lg border border-gray-200 py-2 z-20">
                                    <div className="px-4 py-3 border-b border-gray-100">
                                        <p className="text-sm font-medium text-gray-800">
                                            {user?.name || "Usuario"}
                                        </p>
                                        <p className="text-xs text-gray-500 mt-1">
                                            {user?.email || ""}
                                        </p>
                                    </div>

                                    <a
                                        href="/perfil"
                                        className="flex items-center gap-3 px-4 py-2.5 hover:bg-gray-50 transition-colors"
                                    >
                                        <User className="h-4 w-4 text-gray-500" />
                                        <span className="text-sm text-gray-700">
                                            Mi Perfil
                                        </span>
                                    </a>

                                    <a
                                        href="/configuracion"
                                        className="flex items-center gap-3 px-4 py-2.5 hover:bg-gray-50 transition-colors"
                                    >
                                        <Settings className="h-4 w-4 text-gray-500" />
                                        <span className="text-sm text-gray-700">
                                            Configuración
                                        </span>
                                    </a>

                                    <div className="border-t border-gray-100 my-1"></div>

                                    <button
                                        onClick={handleLogout}
                                        className="w-full flex items-center gap-3 px-4 py-2.5 hover:bg-red-50 transition-colors text-red-600"
                                    >
                                        <LogOut className="h-4 w-4" />
                                        <span className="text-sm font-medium">
                                            Cerrar Sesión
                                        </span>
                                    </button>
                                </div>
                            </>
                        )}
                    </div>
                </div>
            </div>
        </header>
    );
}
