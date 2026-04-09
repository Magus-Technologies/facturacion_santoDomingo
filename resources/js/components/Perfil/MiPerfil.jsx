import React, { useState, useEffect, useRef } from "react";
import MainLayout from "../Layout/MainLayout";
import { Button } from "../ui/button";
import { Input } from "../ui/input";
import api from "@/services/api";
import { baseUrl } from "@/lib/baseUrl";
import {
    User,
    Mail,
    Phone,
    FileText,
    Shield,
    Building2,
    Calendar,
    Camera,
    Loader2,
    Save,
    Lock,
    Eye,
    EyeOff,
    CheckCircle2,
    AlertCircle,
} from "lucide-react";

function PerfilPage() {
    const [perfil, setPerfil] = useState(null);
    const [loading, setLoading] = useState(true);
    const [saving, setSaving] = useState(false);
    const [savingPassword, setSavingPassword] = useState(false);
    const [uploadingFoto, setUploadingFoto] = useState(false);
    const [mensaje, setMensaje] = useState(null);
    const [errors, setErrors] = useState({});
    const [activeTab, setActiveTab] = useState("datos");
    const fileInputRef = useRef(null);

    const [form, setForm] = useState({
        nombres: "",
        apellidos: "",
        email: "",
        telefono: "",
        num_doc: "",
    });

    const [passwordForm, setPasswordForm] = useState({
        password_actual: "",
        password: "",
        password_confirmation: "",
    });

    const [showPasswords, setShowPasswords] = useState({
        actual: false,
        nueva: false,
        confirmar: false,
    });

    useEffect(() => {
        cargarPerfil();
    }, []);

    const cargarPerfil = async () => {
        try {
            const { data } = await api.get("/perfil");
            if (data.success) {
                setPerfil(data.data);
                setForm({
                    nombres: data.data.nombres || "",
                    apellidos: data.data.apellidos || "",
                    email: data.data.email || "",
                    telefono: data.data.telefono || "",
                    num_doc: data.data.num_doc || "",
                });
            }
        } catch (err) {
            console.error("Error al cargar perfil:", err);
        } finally {
            setLoading(false);
        }
    };

    const handleChange = (e) => {
        setForm({ ...form, [e.target.name]: e.target.value });
        setErrors({ ...errors, [e.target.name]: null });
    };

    const handlePasswordChange = (e) => {
        setPasswordForm({ ...passwordForm, [e.target.name]: e.target.value });
        setErrors({ ...errors, [e.target.name]: null });
    };

    const mostrarMensaje = (tipo, texto) => {
        setMensaje({ tipo, texto });
        setTimeout(() => setMensaje(null), 4000);
    };

    const guardarDatos = async (e) => {
        e.preventDefault();
        setSaving(true);
        setErrors({});
        try {
            const { data } = await api.put("/perfil", form);
            if (data.success) {
                mostrarMensaje("success", data.message);
                // Actualizar localStorage con el nuevo name
                const userData = JSON.parse(localStorage.getItem("user") || "{}");
                userData.name = data.data.name;
                userData.email = data.data.email;
                localStorage.setItem("user", JSON.stringify(userData));
                setPerfil((prev) => ({ ...prev, ...data.data }));
            }
        } catch (err) {
            if (err.response?.status === 422) {
                setErrors(err.response.data.errors || {});
            }
            mostrarMensaje("error", err.response?.data?.message || "Error al guardar");
        } finally {
            setSaving(false);
        }
    };

    const cambiarPassword = async (e) => {
        e.preventDefault();
        setSavingPassword(true);
        setErrors({});
        try {
            const { data } = await api.put("/perfil/password", passwordForm);
            if (data.success) {
                mostrarMensaje("success", data.message);
                setPasswordForm({ password_actual: "", password: "", password_confirmation: "" });
            }
        } catch (err) {
            if (err.response?.status === 422) {
                setErrors(err.response.data.errors || {});
            }
            mostrarMensaje("error", err.response?.data?.message || "Error al cambiar contraseña");
        } finally {
            setSavingPassword(false);
        }
    };

    const subirFoto = async (e) => {
        const file = e.target.files[0];
        if (!file) return;
        setUploadingFoto(true);
        try {
            const formData = new FormData();
            formData.append("foto", file);
            const { data } = await api.post("/perfil/foto", formData, {
                headers: { "Content-Type": "multipart/form-data" },
            });
            if (data.success) {
                setPerfil((prev) => ({ ...prev, foto_perfil: data.data.foto_perfil }));
                // Actualizar localStorage para que el Header muestre la foto
                const userData = JSON.parse(localStorage.getItem("user") || "{}");
                userData.foto_perfil = data.data.foto_perfil;
                localStorage.setItem("user", JSON.stringify(userData));
                mostrarMensaje("success", data.message);
            }
        } catch (err) {
            mostrarMensaje("error", "Error al subir la foto");
        } finally {
            setUploadingFoto(false);
        }
    };

    if (loading) {
        return (
            <div className="flex items-center justify-center min-h-[60vh]">
                <Loader2 className="h-8 w-8 animate-spin text-primary-600" />
            </div>
        );
    }

    const tabs = [
        { id: "datos", label: "Datos Personales", icon: User },
        { id: "password", label: "Cambiar Contraseña", icon: Lock },
    ];

    return (
        <div className="p-4 md:p-6 max-w-5xl mx-auto">
            {/* Header */}
            <div className="mb-6">
                <h1 className="text-2xl font-bold text-gray-900">Mi Perfil</h1>
                <p className="text-gray-500 mt-1">Gestiona tu información personal y seguridad</p>
            </div>

            {/* Mensaje */}
            {mensaje && (
                <div
                    className={`mb-4 flex items-center gap-2 px-4 py-3 rounded-lg text-sm font-medium ${
                        mensaje.tipo === "success"
                            ? "bg-green-50 text-green-700 border border-green-200"
                            : "bg-red-50 text-red-700 border border-red-200"
                    }`}
                >
                    {mensaje.tipo === "success" ? (
                        <CheckCircle2 className="h-4 w-4" />
                    ) : (
                        <AlertCircle className="h-4 w-4" />
                    )}
                    {mensaje.texto}
                </div>
            )}

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                {/* Card izquierda - Foto y resumen */}
                <div className="lg:col-span-1">
                    <div className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden">
                        <div className="bg-gradient-to-br from-primary-600 to-primary-700 h-24"></div>
                        <div className="px-6 pb-6 -mt-12 text-center">
                            <div className="relative inline-block">
                                <div className="h-24 w-24 rounded-full border-4 border-white bg-primary-100 flex items-center justify-center overflow-hidden shadow-lg">
                                    {perfil?.foto_perfil ? (
                                        <img
                                            src={baseUrl("/" + perfil.foto_perfil)}
                                            alt="Foto de perfil"
                                            className="h-full w-full object-cover"
                                        />
                                    ) : (
                                        <span className="text-3xl font-bold text-primary-600">
                                            {perfil?.name?.charAt(0)?.toUpperCase() || "U"}
                                        </span>
                                    )}
                                </div>
                                <button
                                    onClick={() => fileInputRef.current?.click()}
                                    disabled={uploadingFoto}
                                    className="absolute bottom-0 right-0 h-8 w-8 bg-primary-600 text-white rounded-full flex items-center justify-center hover:bg-primary-700 transition-colors shadow-md"
                                >
                                    {uploadingFoto ? (
                                        <Loader2 className="h-4 w-4 animate-spin" />
                                    ) : (
                                        <Camera className="h-4 w-4" />
                                    )}
                                </button>
                                <input
                                    ref={fileInputRef}
                                    type="file"
                                    accept="image/jpeg,image/png,image/webp"
                                    className="hidden"
                                    onChange={subirFoto}
                                />
                            </div>

                            <h3 className="mt-3 text-lg font-bold text-gray-900">
                                {perfil?.name || "Usuario"}
                            </h3>
                            <p className="text-sm text-gray-500">{perfil?.email}</p>

                            <div className="mt-4 space-y-3 text-left">
                                <div className="flex items-center gap-3 p-2.5 bg-gray-50 rounded-lg">
                                    <Shield className="h-4 w-4 text-primary-600" />
                                    <div>
                                        <p className="text-[10px] text-gray-400 uppercase font-semibold">Rol</p>
                                        <p className="text-sm font-medium text-gray-800">
                                            {perfil?.rol?.nombre || "Sin rol"}
                                        </p>
                                    </div>
                                </div>
                                <div className="flex items-center gap-3 p-2.5 bg-gray-50 rounded-lg">
                                    <Building2 className="h-4 w-4 text-primary-600" />
                                    <div>
                                        <p className="text-[10px] text-gray-400 uppercase font-semibold">Empresa</p>
                                        <p className="text-sm font-medium text-gray-800">
                                            {perfil?.empresa?.comercial || "Sin empresa"}
                                        </p>
                                    </div>
                                </div>
                                <div className="flex items-center gap-3 p-2.5 bg-gray-50 rounded-lg">
                                    <Calendar className="h-4 w-4 text-primary-600" />
                                    <div>
                                        <p className="text-[10px] text-gray-400 uppercase font-semibold">Miembro desde</p>
                                        <p className="text-sm font-medium text-gray-800">
                                            {perfil?.created_at
                                                ? new Date(perfil.created_at).toLocaleDateString("es-ES", {
                                                      day: "numeric",
                                                      month: "long",
                                                      year: "numeric",
                                                  })
                                                : "-"}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                {/* Card derecha - Formularios */}
                <div className="lg:col-span-2">
                    <div className="bg-white rounded-xl border border-gray-200 shadow-sm">
                        {/* Tabs */}
                        <div className="border-b border-gray-200 px-6">
                            <nav className="flex gap-6">
                                {tabs.map((tab) => {
                                    const Icon = tab.icon;
                                    return (
                                        <button
                                            key={tab.id}
                                            onClick={() => setActiveTab(tab.id)}
                                            className={`flex items-center gap-2 py-4 text-sm font-medium border-b-2 transition-colors ${
                                                activeTab === tab.id
                                                    ? "border-primary-600 text-primary-600"
                                                    : "border-transparent text-gray-500 hover:text-gray-700"
                                            }`}
                                        >
                                            <Icon className="h-4 w-4" />
                                            {tab.label}
                                        </button>
                                    );
                                })}
                            </nav>
                        </div>

                        <div className="p-6">
                            {activeTab === "datos" && (
                                <form onSubmit={guardarDatos} className="space-y-5">
                                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1.5">
                                                Nombres
                                            </label>
                                            <div className="relative">
                                                <User className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                                                <input
                                                    type="text"
                                                    name="nombres"
                                                    value={form.nombres}
                                                    onChange={handleChange}
                                                    className="w-full pl-10 pr-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 text-sm"
                                                    placeholder="Tus nombres"
                                                />
                                            </div>
                                            {errors.nombres && (
                                                <p className="text-red-500 text-xs mt-1">{errors.nombres[0]}</p>
                                            )}
                                        </div>
                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1.5">
                                                Apellidos
                                            </label>
                                            <div className="relative">
                                                <User className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                                                <input
                                                    type="text"
                                                    name="apellidos"
                                                    value={form.apellidos}
                                                    onChange={handleChange}
                                                    className="w-full pl-10 pr-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 text-sm"
                                                    placeholder="Tus apellidos"
                                                />
                                            </div>
                                            {errors.apellidos && (
                                                <p className="text-red-500 text-xs mt-1">{errors.apellidos[0]}</p>
                                            )}
                                        </div>
                                    </div>

                                    <div>
                                        <label className="block text-sm font-medium text-gray-700 mb-1.5">
                                            Correo Electrónico
                                        </label>
                                        <div className="relative">
                                            <Mail className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                                            <input
                                                type="email"
                                                name="email"
                                                value={form.email}
                                                onChange={handleChange}
                                                className="w-full pl-10 pr-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 text-sm"
                                                placeholder="correo@ejemplo.com"
                                                required
                                            />
                                        </div>
                                        {errors.email && (
                                            <p className="text-red-500 text-xs mt-1">{errors.email[0]}</p>
                                        )}
                                    </div>

                                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1.5">
                                                Teléfono
                                            </label>
                                            <div className="relative">
                                                <Phone className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                                                <input
                                                    type="text"
                                                    name="telefono"
                                                    value={form.telefono}
                                                    onChange={handleChange}
                                                    className="w-full pl-10 pr-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 text-sm"
                                                    placeholder="999 999 999"
                                                />
                                            </div>
                                            {errors.telefono && (
                                                <p className="text-red-500 text-xs mt-1">{errors.telefono[0]}</p>
                                            )}
                                        </div>
                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1.5">
                                                N° Documento
                                            </label>
                                            <div className="relative">
                                                <FileText className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                                                <input
                                                    type="text"
                                                    name="num_doc"
                                                    value={form.num_doc}
                                                    onChange={handleChange}
                                                    className="w-full pl-10 pr-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 text-sm"
                                                    placeholder="DNI / CE"
                                                />
                                            </div>
                                            {errors.num_doc && (
                                                <p className="text-red-500 text-xs mt-1">{errors.num_doc[0]}</p>
                                            )}
                                        </div>
                                    </div>

                                    <div className="flex justify-end pt-2">
                                        <Button type="submit" disabled={saving} className="gap-2">
                                            {saving ? (
                                                <Loader2 className="h-4 w-4 animate-spin" />
                                            ) : (
                                                <Save className="h-4 w-4" />
                                            )}
                                            Guardar Cambios
                                        </Button>
                                    </div>
                                </form>
                            )}

                            {activeTab === "password" && (
                                <form onSubmit={cambiarPassword} className="space-y-5 max-w-md">
                                    <div>
                                        <label className="block text-sm font-medium text-gray-700 mb-1.5">
                                            Contraseña Actual
                                        </label>
                                        <div className="relative">
                                            <Lock className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                                            <input
                                                type={showPasswords.actual ? "text" : "password"}
                                                name="password_actual"
                                                value={passwordForm.password_actual}
                                                onChange={handlePasswordChange}
                                                className="w-full pl-10 pr-10 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 text-sm"
                                                placeholder="********"
                                                required
                                            />
                                            <button
                                                type="button"
                                                onClick={() =>
                                                    setShowPasswords((p) => ({ ...p, actual: !p.actual }))
                                                }
                                                className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
                                            >
                                                {showPasswords.actual ? (
                                                    <EyeOff className="h-4 w-4" />
                                                ) : (
                                                    <Eye className="h-4 w-4" />
                                                )}
                                            </button>
                                        </div>
                                        {errors.password_actual && (
                                            <p className="text-red-500 text-xs mt-1">{errors.password_actual[0]}</p>
                                        )}
                                    </div>

                                    <div>
                                        <label className="block text-sm font-medium text-gray-700 mb-1.5">
                                            Nueva Contraseña
                                        </label>
                                        <div className="relative">
                                            <Lock className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                                            <input
                                                type={showPasswords.nueva ? "text" : "password"}
                                                name="password"
                                                value={passwordForm.password}
                                                onChange={handlePasswordChange}
                                                className="w-full pl-10 pr-10 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 text-sm"
                                                placeholder="Mínimo 6 caracteres"
                                                required
                                                minLength={6}
                                            />
                                            <button
                                                type="button"
                                                onClick={() =>
                                                    setShowPasswords((p) => ({ ...p, nueva: !p.nueva }))
                                                }
                                                className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
                                            >
                                                {showPasswords.nueva ? (
                                                    <EyeOff className="h-4 w-4" />
                                                ) : (
                                                    <Eye className="h-4 w-4" />
                                                )}
                                            </button>
                                        </div>
                                        {errors.password && (
                                            <p className="text-red-500 text-xs mt-1">{errors.password[0]}</p>
                                        )}
                                    </div>

                                    <div>
                                        <label className="block text-sm font-medium text-gray-700 mb-1.5">
                                            Confirmar Nueva Contraseña
                                        </label>
                                        <div className="relative">
                                            <Lock className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                                            <input
                                                type={showPasswords.confirmar ? "text" : "password"}
                                                name="password_confirmation"
                                                value={passwordForm.password_confirmation}
                                                onChange={handlePasswordChange}
                                                className="w-full pl-10 pr-10 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 text-sm"
                                                placeholder="Repite la nueva contraseña"
                                                required
                                            />
                                            <button
                                                type="button"
                                                onClick={() =>
                                                    setShowPasswords((p) => ({ ...p, confirmar: !p.confirmar }))
                                                }
                                                className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
                                            >
                                                {showPasswords.confirmar ? (
                                                    <EyeOff className="h-4 w-4" />
                                                ) : (
                                                    <Eye className="h-4 w-4" />
                                                )}
                                            </button>
                                        </div>
                                        {errors.password_confirmation && (
                                            <p className="text-red-500 text-xs mt-1">
                                                {errors.password_confirmation[0]}
                                            </p>
                                        )}
                                    </div>

                                    <div className="flex justify-end pt-2">
                                        <Button type="submit" disabled={savingPassword} className="gap-2">
                                            {savingPassword ? (
                                                <Loader2 className="h-4 w-4 animate-spin" />
                                            ) : (
                                                <Lock className="h-4 w-4" />
                                            )}
                                            Cambiar Contraseña
                                        </Button>
                                    </div>
                                </form>
                            )}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default function MiPerfil() {
    return (
        <MainLayout>
            <PerfilPage />
        </MainLayout>
    );
}
