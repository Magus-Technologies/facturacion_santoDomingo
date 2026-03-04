import { useState, useEffect } from "react";
import { Modal } from "../ui/modal";
import { Button } from "../ui/button";
import {
    Select,
    SelectTrigger,
    SelectValue,
    SelectContent,
    SelectItem,
} from "../ui/select";
import { toast } from "@/lib/sweetalert";
import { Loader2, Copy, AlertCircle, CheckCircle2 } from "lucide-react";

export default function ReplicarProductosModal({ isOpen, onClose, onSuccess, almacenActivo }) {
    const [loading, setLoading] = useState(false);
    const [loadingEmpresas, setLoadingEmpresas] = useState(false);
    const [empresas, setEmpresas] = useState([]);
    const [empresaDestino, setEmpresaDestino] = useState("todas");
    const [ambosAlmacenes, setAmbosAlmacenes] = useState(true);
    const [resultado, setResultado] = useState(null); // { creados, omitidos }

    const empresaActiva = JSON.parse(localStorage.getItem("empresa_activa") || "{}");

    useEffect(() => {
        if (isOpen) {
            setResultado(null);
            setEmpresaDestino("todas");
            setAmbosAlmacenes(true);
            cargarEmpresas();
        }
    }, [isOpen]);

    const cargarEmpresas = async () => {
        setLoadingEmpresas(true);
        try {
            const token = localStorage.getItem("auth_token");
            const res = await fetch("/api/empresas", {
                headers: { Authorization: `Bearer ${token}`, Accept: "application/json" },
            });
            const data = await res.json();
            const lista = (data.data || data || []).filter(
                (e) => e.id_empresa !== empresaActiva?.id_empresa && String(e.estado) === "1"
            );
            setEmpresas(lista);
        } catch {
            toast.error("Error al cargar empresas");
        } finally {
            setLoadingEmpresas(false);
        }
    };

    const handleReplicar = async () => {
        setLoading(true);
        setResultado(null);
        try {
            const token = localStorage.getItem("auth_token");
            const almacenes = ambosAlmacenes ? ["1", "2"] : [almacenActivo];

            let creadosTotal = 0;
            let omitidosTotal = 0;

            for (const alm of almacenes) {
                const body = { almacen: alm };
                if (empresaDestino && empresaDestino !== "todas") body.id_empresa_destino = empresaDestino;

                const res = await fetch("/api/productos/replicar-masivo", {
                    method: "POST",
                    headers: {
                        Authorization: `Bearer ${token}`,
                        Accept: "application/json",
                        "Content-Type": "application/json",
                        ...(empresaActiva?.id_empresa && { "X-Empresa-Activa": String(empresaActiva.id_empresa) }),
                    },
                    body: JSON.stringify(body),
                });

                let data;
                try {
                    data = await res.json();
                } catch {
                    toast.error(`Error HTTP ${res.status}: respuesta inválida del servidor`);
                    return;
                }

                if (!res.ok || !data.success) {
                    toast.error(data.message || `Error ${res.status} en la replicación`);
                    return;
                }

                creadosTotal += data.creados || 0;
                omitidosTotal += data.omitidos || 0;
            }

            setResultado({ creados: creadosTotal, omitidos: omitidosTotal });
            onSuccess?.();
        } catch (err) {
            toast.error("Error de conexión: " + (err?.message || "desconocido"));
        } finally {
            setLoading(false);
        }
    };

    const nombreAlmacen = almacenActivo === "1" ? "Facturación" : "Almacén Real";

    return (
        <Modal
            isOpen={isOpen}
            onClose={onClose}
            title="Replicar productos a otras empresas"
            size="md"
            footer={
                resultado ? (
                    <Button onClick={onClose} className="w-full">
                        Cerrar
                    </Button>
                ) : (
                    <>
                        <Button variant="outline" onClick={onClose} disabled={loading} size="sm">
                            Cancelar
                        </Button>
                        <Button
                            onClick={handleReplicar}
                            disabled={loading || loadingEmpresas || empresas.length === 0}
                            size="sm"
                            className="gap-2"
                        >
                            {loading ? (
                                <Loader2 className="h-4 w-4 animate-spin" />
                            ) : (
                                <Copy className="h-4 w-4" />
                            )}
                            {loading ? "Replicando..." : "Replicar ahora"}
                        </Button>
                    </>
                )
            }
        >
            <div className="space-y-4 p-1">
                {resultado ? (
                    /* Pantalla de resultado */
                    <div className="text-center space-y-3 py-2">
                        <CheckCircle2 className="h-12 w-12 text-green-500 mx-auto" />
                        <p className="font-semibold text-gray-800">¡Replicación completada!</p>
                        <div className="bg-gray-50 rounded-lg p-3 text-sm space-y-1">
                            <p className="text-green-700">
                                ✅ <strong>{resultado.creados}</strong> producto(s) creado(s)
                            </p>
                            <p className="text-gray-500">
                                ⏭️ <strong>{resultado.omitidos}</strong> omitido(s) — ya existían en destino
                            </p>
                        </div>
                        <p className="text-xs text-gray-400">
                            Los productos omitidos no fueron modificados para preservar precios y stock del destino.
                        </p>
                    </div>
                ) : (
                    <>
                        {/* Empresa destino */}
                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-1">
                                Empresa destino
                            </label>
                            {loadingEmpresas ? (
                                <div className="flex items-center gap-2 text-sm text-gray-500 py-2">
                                    <Loader2 className="h-4 w-4 animate-spin" />
                                    Cargando empresas...
                                </div>
                            ) : empresas.length === 0 ? (
                                <p className="text-sm text-red-500">No hay otras empresas activas disponibles.</p>
                            ) : (
                                <Select value={empresaDestino} onValueChange={setEmpresaDestino}>
                                    <SelectTrigger className="w-full">
                                        <SelectValue placeholder="— Todas las empresas activas —" />
                                    </SelectTrigger>
                                    <SelectContent className="z-[200] w-[var(--radix-select-trigger-width)] max-w-[var(--radix-select-trigger-width)]">
                                        <SelectItem value="todas">— Todas las empresas activas —</SelectItem>
                                        {empresas.map((e) => (
                                            <SelectItem key={e.id_empresa} value={String(e.id_empresa)}>
                                                {e.razon_social || e.nombre}
                                            </SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                            )}
                        </div>

                        {/* Almacenes */}
                        <div>
                            <label className="block text-sm font-medium text-gray-700 mb-2">
                                Almacenes a replicar
                            </label>
                            <div className="space-y-2">
                                <label className="flex items-center gap-2 cursor-pointer">
                                    <input
                                        type="radio"
                                        name="almacenes"
                                        checked={ambosAlmacenes}
                                        onChange={() => setAmbosAlmacenes(true)}
                                        className="text-blue-600"
                                    />
                                    <span className="text-sm text-gray-700">
                                        Ambos almacenes <span className="text-gray-400 text-xs">(Facturación + Almacén Real)</span>
                                    </span>
                                </label>
                                <label className="flex items-center gap-2 cursor-pointer">
                                    <input
                                        type="radio"
                                        name="almacenes"
                                        checked={!ambosAlmacenes}
                                        onChange={() => setAmbosAlmacenes(false)}
                                        className="text-blue-600"
                                    />
                                    <span className="text-sm text-gray-700">
                                        Solo almacén activo <span className="text-gray-400 text-xs">({nombreAlmacen})</span>
                                    </span>
                                </label>
                            </div>
                        </div>

                        {/* Aviso comportamiento */}
                        <div className="flex gap-2 bg-amber-50 border border-amber-200 rounded-lg p-3">
                            <AlertCircle className="h-4 w-4 text-amber-600 mt-0.5 shrink-0" />
                            <p className="text-xs text-amber-700">
                                Los productos que <strong>ya existan</strong> (mismo nombre) en la empresa destino
                                serán <strong>omitidos</strong> sin modificar su precio ni stock.
                                Los productos nuevos se copiarán con el stock actual del origen.
                            </p>
                        </div>
                    </>
                )}
            </div>
        </Modal>
    );
}
