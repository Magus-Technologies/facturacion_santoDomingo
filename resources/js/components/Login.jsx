import React, { useState, useEffect, useMemo } from "react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { usePermissionsStore } from "@/hooks/usePermissions";
import {
    User,
    Lock,
    Users,
    Eye,
    EyeOff,
    ArrowRight,
    Loader2,
    AlertCircle,
    Wine,
    Grape,
} from "lucide-react";

// Partículas flotantes para el panel izquierdo
function FloatingParticles() {
    const particles = useMemo(() =>
        Array.from({ length: 20 }, (_, i) => ({
            id: i,
            size: Math.random() * 4 + 2,
            x: Math.random() * 100,
            y: Math.random() * 100,
            duration: Math.random() * 15 + 10,
            delay: Math.random() * 8,
            opacity: Math.random() * 0.15 + 0.05,
        }))
    , []);

    return (
        <div className="absolute inset-0 overflow-hidden pointer-events-none">
            {particles.map((p) => (
                <div
                    key={p.id}
                    className="absolute rounded-full bg-accent-300 login-particle"
                    style={{
                        width: p.size,
                        height: p.size,
                        left: `${p.x}%`,
                        top: `${p.y}%`,
                        opacity: p.opacity,
                        animationDuration: `${p.duration}s`,
                        animationDelay: `${p.delay}s`,
                    }}
                />
            ))}
        </div>
    );
}

// Línea de luz que recorre el borde de la card
function GlowBorder() {
    return (
        <div className="absolute -inset-px rounded-2xl overflow-hidden pointer-events-none">
            <div className="login-glow-line absolute w-20 h-20 bg-primary-400/30 rounded-full blur-xl" />
        </div>
    );
}

export default function Login({ onLoginSuccess }) {
    const [formData, setFormData] = useState({
        user: "",
        password: "",
        rol: "",
    });
    const [showPassword, setShowPassword] = useState(false);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState("");
    const [mounted, setMounted] = useState(false);
    const { setPermissions } = usePermissionsStore();

    useEffect(() => {
        // Activar animaciones de entrada
        const timer = setTimeout(() => setMounted(true), 100);
        return () => clearTimeout(timer);
    }, []);

    // Verificar si ya está logeado al cargar el componente
    useEffect(() => {
        const checkExistingAuth = async () => {
            const token = localStorage.getItem("auth_token");

            if (!token) {
                return;
            }

            try {
                const response = await fetch("/api/verify", {
                    headers: {
                        Authorization: `Bearer ${token}`,
                        Accept: "application/json",
                    },
                });

                if (response.ok) {
                    window.location.href = "/inicio";
                } else {
                    localStorage.removeItem("auth_token");
                    localStorage.removeItem("user");
                }
            } catch (error) {
                console.error("Error verificando token:", error);
                localStorage.removeItem("auth_token");
                localStorage.removeItem("user");
            }
        };

        checkExistingAuth();
    }, []);

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData((prev) => ({
            ...prev,
            [name]: value,
        }));
        setError("");
    };

    const handleSubmit = async (e) => {
        if (e) {
            e.preventDefault();
            e.stopPropagation();
        }

        setLoading(true);
        setError("");

        try {
            const response = await fetch("/api/login", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    Accept: "application/json",
                },
                body: JSON.stringify(formData),
            });

            const data = await response.json();

            if (response.ok && data.success) {
                localStorage.setItem("auth_token", data.token);
                localStorage.setItem("user", JSON.stringify(data.user));

                if (data.empresas) {
                    localStorage.setItem("empresas", JSON.stringify(data.empresas));
                }

                if (!localStorage.getItem("empresa_activa") && data.empresas?.length > 0) {
                    const empresaDefault = data.empresas.find(e => e.id_empresa === data.user.id_empresa) || data.empresas[0];
                    localStorage.setItem("empresa_activa", JSON.stringify(empresaDefault));
                }

                if (data.permissions) {
                    setPermissions(data.permissions);
                }

                window.location.href = "/inicio";

                if (onLoginSuccess) {
                    onLoginSuccess(data);
                }
            } else {
                if (data.errors) {
                    const errorMessages = Object.values(data.errors).flat();
                    setError(errorMessages.join('. '));
                } else {
                    setError(data.message || "Credenciales incorrectas");
                }
            }
        } catch (err) {
            console.error("Login error:", err);
            setError("Error de conexión. Intente nuevamente.");
        } finally {
            setLoading(false);
        }

        return false;
    };

    return (
        <div className="min-h-screen flex flex-col lg:flex-row">
            {/* Panel izquierdo - Branding */}
            <div className="hidden lg:flex lg:w-[55%] relative overflow-hidden bg-gradient-to-br from-primary-950 via-primary-800 to-primary-700">
                {/* Patrón decorativo de fondo */}
                <div className="absolute inset-0">
                    {/* Anillos animados */}
                    <div className="absolute -top-32 -left-32 w-[500px] h-[500px] rounded-full border border-white/[0.06] login-ring-spin" />
                    <div className="absolute -top-16 -left-16 w-[400px] h-[400px] rounded-full border border-white/[0.04] login-ring-spin-reverse" />
                    <div className="absolute -bottom-40 -right-40 w-[600px] h-[600px] rounded-full border border-accent-300/[0.08] login-ring-spin" />
                    <div className="absolute -bottom-20 -right-20 w-[450px] h-[450px] rounded-full border border-accent-300/[0.05] login-ring-spin-reverse" />

                    {/* Gradiente radial pulsante */}
                    <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] bg-accent-300/[0.04] rounded-full blur-3xl login-glow-pulse" />

                    {/* Líneas decorativas diagonales */}
                    <div className="absolute inset-0 opacity-[0.03]" style={{
                        backgroundImage: 'repeating-linear-gradient(135deg, transparent, transparent 60px, rgba(236,230,163,0.4) 60px, rgba(236,230,163,0.4) 61px)',
                    }} />
                </div>

                {/* Partículas flotantes */}
                <FloatingParticles />

                {/* Contenido del panel con animaciones escalonadas */}
                <div className="relative z-10 flex flex-col justify-center items-center w-full px-12 xl:px-20">
                    {/* Logo grande con glow */}
                    <div
                        className={`login-float mb-8 transition-all duration-1000 ease-out ${
                            mounted ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
                        }`}
                    >
                        <div className="relative">
                            {/* Glow detrás del logo */}
                            <div className="absolute inset-0 blur-2xl bg-accent-300/10 rounded-full scale-110 login-glow-pulse" />
                            <img
                                src="/images/logos/logo.svg"
                                alt="Santo Domingo Logo"
                                className="relative h-52 xl:h-64 w-auto object-contain drop-shadow-2xl"
                                style={{ filter: 'brightness(1.1)' }}
                            />
                        </div>
                    </div>

                    {/* Separador elegante animado */}
                    <div
                        className={`flex items-center gap-4 mb-8 w-full max-w-xs transition-all duration-1000 delay-300 ease-out ${
                            mounted ? 'opacity-100 scale-x-100' : 'opacity-0 scale-x-0'
                        }`}
                    >
                        <div className="flex-1 h-px login-line-shimmer" />
                        <Grape className="h-5 w-5 text-accent-300/50 login-icon-spin" />
                        <div className="flex-1 h-px login-line-shimmer-reverse" />
                    </div>

                    {/* Texto descriptivo */}
                    <div
                        className={`text-center max-w-sm transition-all duration-1000 delay-500 ease-out ${
                            mounted ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-6'
                        }`}
                    >
                        <h2 className="text-accent-200 text-lg font-light tracking-wide mb-3">
                            Sistema de Facturación Electrónica
                        </h2>
                        <p className="text-white/40 text-sm leading-relaxed">
                            Gestión integral de comprobantes electrónicos, control de inventario y administración financiera.
                        </p>
                    </div>

                    {/* Indicador decorativo inferior */}
                    <div
                        className={`absolute bottom-10 left-12 xl:left-20 right-12 xl:right-20 transition-all duration-1000 delay-700 ease-out ${
                            mounted ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'
                        }`}
                    >
                        <div className="flex items-center justify-center text-accent-300/50 text-xs tracking-widest uppercase">
                            <Wine className="h-3.5 w-3.5 mr-2" />
                            Viña Santo Domingo
                        </div>
                    </div>
                </div>
            </div>

            {/* Panel derecho - Formulario */}
            <div className="flex-1 flex items-center justify-center bg-gray-50 relative min-h-screen lg:min-h-0">
                {/* Fondo decorativo sutil para mobile */}
                <div className="absolute inset-0 lg:hidden bg-gradient-to-br from-primary-800 via-primary-600 to-primary-500">
                    <div className="absolute inset-0 opacity-[0.05]" style={{
                        backgroundImage: 'repeating-linear-gradient(135deg, transparent, transparent 60px, rgba(255,255,255,0.3) 60px, rgba(255,255,255,0.3) 61px)',
                    }} />
                </div>

                {/* Decoración sutil esquina superior desktop */}
                <div className="hidden lg:block absolute top-0 right-0 w-64 h-64 overflow-hidden pointer-events-none">
                    <div className="absolute -top-32 -right-32 w-64 h-64 rounded-full border border-primary-100" />
                </div>
                <div className="hidden lg:block absolute bottom-0 left-0 w-48 h-48 overflow-hidden pointer-events-none">
                    <div className="absolute -bottom-24 -left-24 w-48 h-48 rounded-full border border-primary-50" />
                </div>

                <div className="w-full max-w-md px-6 sm:px-8 py-12 relative z-10">
                    {/* Logo solo en mobile */}
                    <div className={`lg:hidden text-center mb-8 transition-all duration-700 ${
                        mounted ? 'opacity-100 scale-100' : 'opacity-0 scale-90'
                    }`}>
                        <img
                            src="/images/logos/logo.svg"
                            alt="Santo Domingo Logo"
                            className="h-32 w-auto object-contain mx-auto drop-shadow-lg"
                        />
                    </div>

                    {/* Card del formulario */}
                    <div className={`relative bg-white rounded-2xl shadow-xl shadow-black/5 lg:shadow-lg p-8 sm:p-10 border border-gray-100 lg:border-gray-100/80 overflow-hidden transition-all duration-700 delay-200 ${
                        mounted ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
                    }`}>
                        {/* Línea de glow animada en el borde */}
                        <GlowBorder />

                        {/* Barra decorativa superior */}
                        <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-primary-500 via-primary-400 to-accent-400 login-line-shimmer" />

                        {/* Encabezado */}
                        <div className={`mb-8 transition-all duration-500 delay-400 ${
                            mounted ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'
                        }`}>
                            <h1 className="text-2xl font-bold text-gray-900 mb-1">
                                Bienvenido
                            </h1>
                            <p className="text-gray-400 text-sm">
                                Ingresa tus credenciales para continuar
                            </p>
                        </div>

                        {/* Formulario */}
                        <form
                            onSubmit={handleSubmit}
                            className="space-y-5"
                            noValidate
                            action="javascript:void(0);"
                        >
                            {/* Campo Usuario/Email */}
                            <div className={`transition-all duration-500 delay-[600ms] ${
                                mounted ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'
                            }`}>
                                <label className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2 block">
                                    Usuario / Email
                                </label>
                                <div className="relative group">
                                    <div className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-primary-500 transition-colors">
                                        <User className="h-5 w-5" />
                                    </div>
                                    <input
                                        type="text"
                                        name="user"
                                        value={formData.user}
                                        onChange={handleChange}
                                        required
                                        className="w-full pl-12 pr-4 py-3.5 bg-gray-50 border border-gray-200 rounded-xl text-base text-gray-900 placeholder:text-gray-400 focus:outline-none focus:bg-white focus:border-primary-400 focus:ring-2 focus:ring-primary-100 transition-all duration-200"
                                        placeholder="Ingresa tu usuario o email"
                                    />
                                </div>
                            </div>

                            {/* Campo Contraseña */}
                            <div className={`transition-all duration-500 delay-[700ms] ${
                                mounted ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'
                            }`}>
                                <label className="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-2 block">
                                    Contraseña
                                </label>
                                <div className="relative group">
                                    <div className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 group-focus-within:text-primary-500 transition-colors">
                                        <Lock className="h-5 w-5" />
                                    </div>
                                    <input
                                        type={showPassword ? "text" : "password"}
                                        name="password"
                                        value={formData.password}
                                        onChange={handleChange}
                                        required
                                        className="w-full pl-12 pr-12 py-3.5 bg-gray-50 border border-gray-200 rounded-xl text-base text-gray-900 placeholder:text-gray-400 focus:outline-none focus:bg-white focus:border-primary-400 focus:ring-2 focus:ring-primary-100 transition-all duration-200"
                                        placeholder="Ingresa tu contraseña"
                                    />
                                    <button
                                        type="button"
                                        onClick={() =>
                                            setShowPassword(!showPassword)
                                        }
                                        className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 hover:text-primary-500 transition-colors"
                                    >
                                        {showPassword ? (
                                            <EyeOff className="h-5 w-5" />
                                        ) : (
                                            <Eye className="h-5 w-5" />
                                        )}
                                    </button>
                                </div>
                            </div>

                            {/* Mensaje de Error */}
                            {error && (
                                <div className="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-xl text-sm flex items-center gap-2 animate-scaleIn">
                                    <AlertCircle className="h-5 w-5 shrink-0" />
                                    {error}
                                </div>
                            )}

                            {/* Enlace Olvidé Contraseña */}
                            <div className={`text-right transition-all duration-500 delay-[800ms] ${
                                mounted ? 'opacity-100' : 'opacity-0'
                            }`}>
                                <button
                                    type="button"
                                    onClick={(e) => {
                                        e.preventDefault();
                                    }}
                                    className="text-sm text-primary-500 hover:text-primary-700 font-medium transition-colors bg-transparent border-0 cursor-pointer hover:underline"
                                >
                                    ¿Olvidaste tu contraseña?
                                </button>
                            </div>

                            {/* Botón Submit */}
                            <div className={`transition-all duration-500 delay-[900ms] ${
                                mounted ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'
                            }`}>
                                <button
                                    type="submit"
                                    disabled={loading}
                                    className="w-full py-3.5 px-6 bg-gradient-to-r from-primary-600 to-primary-500 hover:from-primary-700 hover:to-primary-600 text-white font-semibold rounded-xl shadow-lg shadow-primary-500/25 hover:shadow-primary-500/40 transition-all duration-300 flex items-center justify-center gap-2 disabled:opacity-60 disabled:cursor-not-allowed active:scale-[0.98]"
                                >
                                    {loading ? (
                                        <>
                                            <Loader2 className="h-5 w-5 animate-spin" />
                                            Ingresando...
                                        </>
                                    ) : (
                                        <>
                                            Ingresar
                                            <ArrowRight className="h-5 w-5" />
                                        </>
                                    )}
                                </button>
                            </div>
                        </form>
                    </div>

                    {/* Footer fuera de la card */}
                    <div className={`text-center mt-8 transition-all duration-500 delay-[1000ms] ${
                        mounted ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'
                    }`}>
                        <p className="text-xs text-gray-400 lg:text-gray-400 mb-2">
                            Desarrollado por:
                        </p>
                        <a
                            href="https://magustechnologies.com/"
                            target="_blank"
                            rel="noopener noreferrer"
                            className="inline-block transition-all duration-300 hover:scale-105"
                        >
                            <img
                                src="/images/login/magus.svg"
                                alt="Magus Technologies"
                                className="h-12 w-auto mx-auto transition-all duration-300"
                                style={{
                                    filter: "grayscale(100%) opacity(0.4) brightness(0.75)",
                                }}
                                onMouseEnter={(e) => {
                                    e.currentTarget.style.filter =
                                        "grayscale(0%) opacity(1) brightness(1)";
                                }}
                                onMouseLeave={(e) => {
                                    e.currentTarget.style.filter =
                                        "grayscale(100%) opacity(0.4) brightness(0.75)";
                                }}
                            />
                        </a>
                    </div>
                </div>
            </div>
        </div>
    );
}
