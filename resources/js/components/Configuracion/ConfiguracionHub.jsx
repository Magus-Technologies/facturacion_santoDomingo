import React from "react";
import MainLayout from "../Layout/MainLayout";
import { baseUrl } from "@/lib/baseUrl";
import {
    Building2,
    Users,
    Shield,
    Printer,
    ChevronRight,
} from "lucide-react";

const secciones = [
    {
        titulo: "Datos de Empresa",
        descripcion: "Razón social, RUC, logo, certificados digitales y datos fiscales de tu empresa.",
        icon: Building2,
        path: "/configuracion/empresa",
        color: "from-blue-500 to-blue-600",
        bgLight: "bg-blue-50",
        textColor: "text-blue-600",
    },
    {
        titulo: "Usuarios",
        descripcion: "Gestiona los usuarios del sistema, asigna roles y controla el acceso.",
        icon: Users,
        path: "/configuracion/usuarios",
        color: "from-emerald-500 to-emerald-600",
        bgLight: "bg-emerald-50",
        textColor: "text-emerald-600",
    },
    {
        titulo: "Roles y Permisos",
        descripcion: "Define roles personalizados y configura los permisos de cada uno.",
        icon: Shield,
        path: "/configuracion/permisos",
        color: "from-amber-500 to-amber-600",
        bgLight: "bg-amber-50",
        textColor: "text-amber-600",
    },
    {
        titulo: "Plantillas de Impresión",
        descripcion: "Personaliza el formato de tus comprobantes: tickets, facturas A4 y más.",
        icon: Printer,
        path: "/configuracion/plantilla-impresion",
        color: "from-purple-500 to-purple-600",
        bgLight: "bg-purple-50",
        textColor: "text-purple-600",
    },
];

function ConfiguracionPage() {
    return (
        <div className="p-4 md:p-6 max-w-5xl mx-auto">
            {/* Header */}
            <div className="mb-8">
                <h1 className="text-2xl font-bold text-gray-900">Configuración</h1>
                <p className="text-gray-500 mt-1">
                    Administra la configuración general del sistema
                </p>
            </div>

            {/* Grid de tarjetas */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                {secciones.map((seccion) => {
                    const Icon = seccion.icon;
                    return (
                        <a
                            key={seccion.path}
                            href={baseUrl(seccion.path)}
                            className="group bg-white rounded-xl border border-gray-200 shadow-sm hover:shadow-md hover:border-gray-300 transition-all duration-200 overflow-hidden"
                        >
                            <div className="p-6">
                                <div className="flex items-start gap-4">
                                    <div
                                        className={`h-12 w-12 rounded-xl bg-gradient-to-br ${seccion.color} flex items-center justify-center shrink-0 shadow-sm`}
                                    >
                                        <Icon className="h-6 w-6 text-white" />
                                    </div>
                                    <div className="flex-1 min-w-0">
                                        <div className="flex items-center justify-between">
                                            <h3 className="text-base font-semibold text-gray-900 group-hover:text-primary-600 transition-colors">
                                                {seccion.titulo}
                                            </h3>
                                            <ChevronRight className="h-5 w-5 text-gray-300 group-hover:text-primary-500 group-hover:translate-x-0.5 transition-all" />
                                        </div>
                                        <p className="text-sm text-gray-500 mt-1 leading-relaxed">
                                            {seccion.descripcion}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    );
                })}
            </div>
        </div>
    );
}

export default function ConfiguracionHub() {
    return (
        <MainLayout>
            <ConfiguracionPage />
        </MainLayout>
    );
}
