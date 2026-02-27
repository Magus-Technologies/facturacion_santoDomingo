import React from "react";
import MainLayout from "../Layout/MainLayout";
import {
    LayoutDashboard, Plus, Eye, FileText, Receipt, FileCheck,
    FileX, Truck, Users, BookOpen, ShoppingCart, UserCog,
    Package, Building2, Shield, Printer,
} from "lucide-react";

const GRUPOS = [
    {
        label: "Facturación",
        color: "bg-primary-600 hover:bg-primary-700",
        acciones: [
            { label: "Nueva Venta",       icon: Plus,      path: "/ventas/productos" },
            { label: "Ver Ventas",        icon: Eye,       path: "/ventas" },
            { label: "Facturas",          icon: FileText,  path: "/ventas?tipo=factura" },
            { label: "Boletas",           icon: Receipt,   path: "/ventas?tipo=boleta" },
            { label: "Notas de Venta",    icon: FileCheck, path: "/ventas?tipo=nota" },
            { label: "Notas de Crédito",  icon: FileX,     path: "/nota-credito" },
            { label: "Guías de Remisión", icon: Truck,     path: "/guia-remision" },
        ],
    },
    {
        label: "Clientes y Cotizaciones",
        color: "bg-blue-500 hover:bg-blue-600",
        acciones: [
            { label: "Clientes",     icon: Users,    path: "/clientes" },
            { label: "Cotizaciones", icon: BookOpen, path: "/cotizaciones" },
        ],
    },
    {
        label: "Compras y Proveedores",
        color: "bg-green-600 hover:bg-green-700",
        acciones: [
            { label: "Compras",     icon: ShoppingCart, path: "/compras" },
            { label: "Proveedores", icon: UserCog,      path: "/proveedores" },
        ],
    },
    {
        label: "Productos e Inventario",
        color: "bg-amber-500 hover:bg-amber-600",
        acciones: [
            { label: "Productos",  icon: Package, path: "/productos" },
        ],
    },
    {
        label: "Configuración",
        color: "bg-gray-500 hover:bg-gray-600",
        acciones: [
            { label: "Empresa",             icon: Building2, path: "/configuracion/empresa" },
            { label: "Usuarios",            icon: UserCog,   path: "/configuracion/usuarios" },
            { label: "Permisos",            icon: Shield,    path: "/configuracion/permisos" },
            { label: "Plantillas Impresión",icon: Printer,   path: "/configuracion/plantilla-impresion" },
        ],
    },
];

export default function Inicio() {
    const user = (() => {
        try { return JSON.parse(localStorage.getItem("user") || "{}"); }
        catch { return {}; }
    })();
    const nombre = user.name || user.nombre || "Usuario";

    return (
        <MainLayout>
            <div className="space-y-6">

                {/* Saludo */}
                <div className="flex items-center justify-between">
                    <div>
                        <h1 className="text-3xl font-bold text-gray-800">Hola, {nombre}</h1>
                        <p className="text-gray-500 mt-1">¿Qué deseas hacer hoy?</p>
                    </div>
                    <a
                        href="/dashboard"
                        className="flex items-center gap-2 px-4 py-2 rounded-lg border border-gray-200 bg-white hover:bg-gray-50 text-gray-700 text-sm font-medium transition-colors no-underline shadow-sm"
                    >
                        <LayoutDashboard className="h-4 w-4" />
                        Dashboard
                    </a>
                </div>

                {/* Grupos */}
                {GRUPOS.map((grupo) => (
                    <div key={grupo.label} className="bg-white rounded-2xl shadow-sm border border-gray-100 p-5">
                        {/* Título del grupo — solo texto, sin fondo */}
                        <h2 className="text-base font-bold text-gray-800 mb-4">{grupo.label}</h2>

                        {/* Cards */}
                        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-3">
                            {grupo.acciones.map((accion) => {
                                const Icon = accion.icon;
                                return (
                                    <a
                                        key={accion.path}
                                        href={accion.path}
                                        className={`flex flex-col items-center justify-between gap-3 px-3 pt-4 pb-5 rounded-xl ${grupo.color} text-white text-center transition-all hover:scale-105 hover:shadow-md no-underline`}
                                    >
                                        <span className="text-sm font-medium leading-tight">{accion.label}</span>
                                        <Icon className="h-10 w-10 opacity-70" strokeWidth={1.5} />
                                    </a>
                                );
                            })}
                        </div>
                    </div>
                ))}

            </div>
        </MainLayout>
    );
}
