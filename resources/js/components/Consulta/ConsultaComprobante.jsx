import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from "@/components/ui/select";
import {
    Loader2,
    Search,
    CheckCircle2,
    ExternalLink,
    AlertCircle,
} from "lucide-react";

export default function ConsultaComprobante() {
    const [form, setForm] = useState({
        tipo_documento: "",
        serie: "",
        numero: "",
    });
    const [loading, setLoading] = useState(false);
    const [resultado, setResultado] = useState(null);
    const [error, setError] = useState(null);
    const [buscado, setBuscado] = useState(false);

    const handleChange = (field, value) => {
        setForm((prev) => ({ ...prev, [field]: value }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        setResultado(null);
        setError(null);
        setBuscado(false);

        try {
            const res = await fetch("/consulta/buscar", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRF-TOKEN": document
                        .querySelector('meta[name="csrf-token"]')
                        ?.getAttribute("content"),
                },
                body: JSON.stringify(form),
            });

            const data = await res.json();
            setBuscado(true);

            if (data.encontrado) {
                setResultado(data.comprobante);
            } else {
                setError(data.mensaje || "Comprobante no encontrado.");
            }
        } catch {
            setError("Error al consultar. Intente nuevamente.");
        } finally {
            setLoading(false);
        }
    };

    const isFormValid =
        form.tipo_documento &&
        form.serie.length >= 3 &&
        form.numero;

    return (
        <div className="min-h-screen flex items-center justify-center p-4 bg-linear-to-tr from-primary-500 to-primary-600">
            <div className="relative w-full max-w-md">
                <div className="bg-white/98 backdrop-blur-sm rounded-3xl shadow-2xl p-8 space-y-6">
                    {/* Logo / Icon */}
                    <div className="text-center">
                        <div className="flex justify-center mb-4">
                            <img
                                src="/images/logos/logo.svg"
                                alt="Logo"
                                className="h-24 w-auto object-contain"
                            />
                        </div>
                        <h1 className="text-xl font-bold text-gray-800">
                            Consulta de Comprobante Electrónico
                        </h1>
                        <p className="text-sm text-gray-500 mt-1">
                            Ingrese los datos del comprobante para verificar su validez
                        </p>
                    </div>

                    {/* Formulario */}
                    <form onSubmit={handleSubmit} className="space-y-5">
                        <div className="space-y-2">
                            <label className="text-sm font-medium text-gray-700 flex items-center gap-2">
                                <Search className="h-4 w-4 text-gray-400" />
                                Tipo de Documento
                            </label>
                            <Select
                                value={form.tipo_documento}
                                onValueChange={(val) =>
                                    handleChange("tipo_documento", val)
                                }
                            >
                                <SelectTrigger>
                                    <SelectValue placeholder="Seleccione tipo" />
                                </SelectTrigger>
                                <SelectContent>
                                    <SelectItem value="factura">Factura</SelectItem>
                                    <SelectItem value="boleta">Boleta de Venta</SelectItem>
                                    <SelectItem value="nota_credito">Nota de Crédito</SelectItem>
                                    <SelectItem value="guia_remision">Guía de Remisión</SelectItem>
                                </SelectContent>
                            </Select>
                        </div>

                        <div className="grid grid-cols-2 gap-3">
                            <div className="space-y-2">
                                <label className="text-sm font-medium text-gray-700">
                                    Serie
                                </label>
                                <Input
                                    placeholder="F001"
                                    value={form.serie}
                                    onChange={(e) =>
                                        handleChange(
                                            "serie",
                                            e.target.value.toUpperCase().slice(0, 4)
                                        )
                                    }
                                    variant="underline"
                                    maxLength={4}
                                />
                            </div>
                            <div className="space-y-2">
                                <label className="text-sm font-medium text-gray-700">
                                    Número
                                </label>
                                <Input
                                    placeholder="123"
                                    value={form.numero}
                                    onChange={(e) => {
                                        const val = e.target.value.replace(/\D/g, "");
                                        handleChange("numero", val);
                                    }}
                                    variant="underline"
                                />
                            </div>
                        </div>

                        {/* Error */}
                        {buscado && !resultado && error && (
                            <div className="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-lg text-sm flex items-center gap-2">
                                <AlertCircle className="h-5 w-5 shrink-0" />
                                {error}
                            </div>
                        )}

                        <Button
                            type="submit"
                            className="w-full"
                            size="lg"
                            disabled={!isFormValid || loading}
                        >
                            {loading ? (
                                <>
                                    <Loader2 className="h-5 w-5 animate-spin" />
                                    Consultando...
                                </>
                            ) : (
                                <>
                                    Consultar Comprobante
                                    <Search className="h-5 w-5" />
                                </>
                            )}
                        </Button>
                    </form>

                    {/* Resultado */}
                    {buscado && resultado && (
                        <div className="bg-green-50 border border-green-200 rounded-xl p-5 space-y-3">
                            <div className="flex items-center gap-2">
                                <CheckCircle2 className="h-5 w-5 text-green-600" />
                                <span className="font-semibold text-green-700">
                                    Comprobante Encontrado
                                </span>
                            </div>

                            <div className="space-y-2 text-sm">
                                <div className="grid grid-cols-2 gap-2">
                                    <div>
                                        <span className="text-gray-500 text-xs">Tipo</span>
                                        <p className="font-medium text-gray-800">{resultado.tipo}</p>
                                    </div>
                                    <div>
                                        <span className="text-gray-500 text-xs">Serie - Número</span>
                                        <p className="font-medium text-gray-800">{resultado.serie_numero}</p>
                                    </div>
                                </div>

                                <div className="grid grid-cols-2 gap-2">
                                    <div>
                                        <span className="text-gray-500 text-xs">Fecha Emisión</span>
                                        <p className="font-medium text-gray-800">{resultado.fecha_emision}</p>
                                    </div>
                                    {resultado.total && (
                                        <div>
                                            <span className="text-gray-500 text-xs">Total</span>
                                            <p className="font-medium text-gray-800">
                                                {resultado.moneda} {resultado.total}
                                            </p>
                                        </div>
                                    )}
                                </div>

                                <div>
                                    <span className="text-gray-500 text-xs">Emisor</span>
                                    <p className="font-medium text-gray-800">
                                        {resultado.ruc_emisor} - {resultado.razon_social_emisor}
                                    </p>
                                </div>

                                {resultado.cliente && (
                                    <div>
                                        <span className="text-gray-500 text-xs">
                                            {resultado.tipo === "Guía de Remisión"
                                                ? "Destinatario"
                                                : "Cliente"}
                                        </span>
                                        <p className="font-medium text-gray-800">
                                            {resultado.documento_cliente && `${resultado.documento_cliente} - `}
                                            {resultado.cliente}
                                        </p>
                                    </div>
                                )}

                                {resultado.hash_cpe && (
                                    <div>
                                        <span className="text-gray-500 text-xs">Hash CPE</span>
                                        <p className="font-mono text-xs break-all text-gray-700">
                                            {resultado.hash_cpe}
                                        </p>
                                    </div>
                                )}

                                {resultado.pdf_url && (
                                    <Button
                                        variant="outline"
                                        size="sm"
                                        className="w-full gap-2 mt-1"
                                        onClick={() =>
                                            window.open(resultado.pdf_url, "_blank")
                                        }
                                    >
                                        <ExternalLink className="h-4 w-4" />
                                        Ver PDF del Comprobante
                                    </Button>
                                )}
                            </div>
                        </div>
                    )}

                    {/* Footer */}
                    <div className="text-center pt-4 border-t border-gray-100">
                        <p className="text-xs text-gray-400">
                            Sistema de Facturación Electrónica
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
}
