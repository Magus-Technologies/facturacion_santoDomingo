import { useState, useEffect } from "react";
import MainLayout from "../Layout/MainLayout";
import { Button } from "../ui/button";
import { Input } from "../ui/input";
import { Label } from "../ui/label";
import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from "../ui/select";
import {
    Card,
    CardHeader,
    CardTitle,
    CardDescription,
    CardContent,
    CardFooter,
} from "../ui/card";
import {
    Table,
    TableBody,
    TableCell,
    TableFooter,
    TableHead,
    TableHeader,
    TableRow,
} from "../ui/table";
import { Badge } from "../ui/badge";
import {
    Loader2,
    ArrowLeft,
    Search,
    CheckCircle,
    FileText,
    Printer,
    Package,
    User,
    Calendar,
    Hash,
    MapPin,
    CreditCard,
    Building2,
} from "lucide-react";
import { toast } from "@/lib/sweetalert";
import { baseUrl } from "@/lib/baseUrl";

const getAuthHeaders = () => {
    const token = localStorage.getItem("auth_token");
    return {
        Authorization: `Bearer ${token}`,
        Accept: "application/json",
        "Content-Type": "application/json",
    };
};

export default function NotaCreditoForm() {
    const [serie, setSerie] = useState("");
    const [numero, setNumero] = useState("");
    const [venta, setVenta] = useState(null);
    const [motivoId, setMotivoId] = useState("");
    const [descripcion, setDescripcion] = useState("");
    const [motivos, setMotivos] = useState([]);
    const [buscando, setBuscando] = useState(false);
    const [guardando, setGuardando] = useState(false);
    const [errorBusqueda, setErrorBusqueda] = useState(null);

    useEffect(() => {
        fetchMotivos();
    }, []);

    const fetchMotivos = async () => {
        try {
            const res = await fetch(baseUrl("/api/notas-credito/motivos"), {
                headers: getAuthHeaders(),
            });
            const data = await res.json();
            if (data.success) {
                setMotivos(data.data);
            }
        } catch (err) {
            console.error("Error cargando motivos:", err);
        }
    };

    const handleBuscar = async () => {
        if (!serie.trim() || !numero.trim()) return;
        setBuscando(true);
        setErrorBusqueda(null);
        setVenta(null);

        try {
            const params = new URLSearchParams({
                serie: serie.trim(),
                numero: numero.trim(),
            });
            const res = await fetch(
                baseUrl(`/api/notas-credito/buscar-venta?${params}`),
                { headers: getAuthHeaders() },
            );
            const data = await res.json();

            if (data.success && data.venta) {
                setVenta(data.venta);
            } else {
                setErrorBusqueda(
                    data.message || "Venta no encontrada",
                );
            }
        } catch {
            setErrorBusqueda("Error de conexión");
        }
        setBuscando(false);
    };

    const handleKeyDown = (e) => {
        if (e.key === "Enter") {
            e.preventDefault();
            handleBuscar();
        }
    };

    const handleSubmit = async () => {
        if (!venta || !motivoId) return;
        setGuardando(true);

        try {
            const res = await fetch(baseUrl("/api/notas-credito"), {
                method: "POST",
                headers: getAuthHeaders(),
                body: JSON.stringify({
                    id_venta: venta.id_venta,
                    motivo_id: parseInt(motivoId),
                    descripcion_motivo: descripcion || undefined,
                }),
            });
            const data = await res.json();

            if (data.success) {
                toast.success("Nota de crédito creada y XML generado");
                window.location.href = baseUrl("/nota-credito");
            } else {
                toast.error(
                    data.message || "Error al crear nota de crédito",
                );
            }
        } catch {
            toast.error("Error de conexión");
        }
        setGuardando(false);
    };

    const handleVerPdf = () => {
        if (!venta) return;
        window.open(
            baseUrl(`/reporteNV/a4.php?id=${venta.id_venta}`),
            "_blank",
        );
    };

    const limpiar = () => {
        setVenta(null);
        setSerie("");
        setNumero("");
        setMotivoId("");
        setDescripcion("");
        setErrorBusqueda(null);
    };

    const monedaSimbolo = venta?.tipo_moneda === "USD" ? "$" : "S/";
    const productos = venta?.productos_ventas || [];
    const tipoDoc = venta?.tipo_documento?.abreviatura || "DOC";
    const docCompleto = venta
        ? `${tipoDoc} ${venta.serie}-${String(venta.numero).padStart(6, "0")}`
        : "";

    return (
        <MainLayout>
            {/* Header con breadcrumb */}
            <div className="mb-6">
                <div className="flex items-center justify-between">
                    <div>
                        <nav className="text-sm text-gray-500 mb-2">
                            <a
                                href={baseUrl("/nota-credito")}
                                className="hover:text-primary-600"
                            >
                                Notas de Crédito
                            </a>
                            <span className="mx-2">/</span>
                            <span className="text-gray-900">Nueva</span>
                        </nav>
                        <h1 className="text-2xl font-bold text-gray-900">
                            Nueva Nota de Crédito
                        </h1>
                    </div>
                    <div className="flex gap-3">
                        <Button
                            onClick={handleSubmit}
                            disabled={!venta || !motivoId || guardando}
                            className="gap-2"
                        >
                            {guardando && (
                                <Loader2 className="h-4 w-4 animate-spin" />
                            )}
                            Crear Nota de Crédito
                        </Button>
                        <Button
                            variant="outline"
                            onClick={() =>
                                (window.location.href = baseUrl("/nota-credito"))
                            }
                        >
                            <ArrowLeft className="h-4 w-4 mr-2" />
                            Regresar
                        </Button>
                    </div>
                </div>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-12 gap-4">
                {/* Columna principal */}
                <div className="lg:col-span-8 space-y-4">
                    {/* Card búsqueda */}
                    <Card>
                        <CardHeader>
                            <CardTitle className="flex items-center gap-2 text-base">
                                <Search className="h-4 w-4 text-primary-600" />
                                Buscar Comprobante
                            </CardTitle>
                            <CardDescription>
                                Ingresa la serie y número del documento a
                                afectar
                            </CardDescription>
                        </CardHeader>
                        <CardContent>
                            <div className="flex items-end gap-3">
                                <div className="w-36">
                                    <Label className="text-xs text-gray-500 mb-1 block">
                                        Serie
                                    </Label>
                                    <Input
                                        value={serie}
                                        onChange={(e) =>
                                            setSerie(
                                                e.target.value
                                                    .toUpperCase()
                                                    .slice(0, 4),
                                            )
                                        }
                                        onKeyDown={handleKeyDown}
                                        placeholder="B001"
                                        maxLength={4}
                                    />
                                </div>
                                <div className="w-36">
                                    <Label className="text-xs text-gray-500 mb-1 block">
                                        Número
                                    </Label>
                                    <Input
                                        value={numero}
                                        onChange={(e) =>
                                            setNumero(
                                                e.target.value.replace(
                                                    /\D/g,
                                                    "",
                                                ),
                                            )
                                        }
                                        onKeyDown={handleKeyDown}
                                        placeholder="1"
                                    />
                                </div>
                                <Button
                                    type="button"
                                    onClick={handleBuscar}
                                    disabled={
                                        buscando ||
                                        !serie.trim() ||
                                        !numero.trim()
                                    }
                                    className="gap-2"
                                >
                                    {buscando ? (
                                        <Loader2 className="h-4 w-4 animate-spin" />
                                    ) : (
                                        <Search className="h-4 w-4" />
                                    )}
                                    Buscar
                                </Button>
                            </div>
                            {errorBusqueda && (
                                <p className="text-sm text-red-500 mt-2">
                                    {errorBusqueda}
                                </p>
                            )}
                        </CardContent>
                    </Card>

                    {/* Card detalle del comprobante */}
                    {venta && (
                        <>
                            {/* Info del comprobante y cliente */}
                            <Card>
                                <CardHeader className="flex flex-row items-center justify-between">
                                    <div className="flex items-center gap-3">
                                        <div className="h-10 w-10 rounded-full bg-green-100 flex items-center justify-center">
                                            <CheckCircle className="h-5 w-5 text-green-600" />
                                        </div>
                                        <div>
                                            <CardTitle className="text-base">
                                                {docCompleto}
                                            </CardTitle>
                                            <CardDescription>
                                                Comprobante encontrado
                                            </CardDescription>
                                        </div>
                                    </div>
                                    <div className="flex gap-2">
                                        <Button
                                            variant="outline"
                                            size="sm"
                                            onClick={handleVerPdf}
                                            className="gap-2"
                                        >
                                            <Printer className="h-4 w-4" />
                                            Ver PDF
                                        </Button>
                                        <Button
                                            variant="ghost"
                                            size="sm"
                                            onClick={limpiar}
                                            className="text-gray-400 hover:text-red-500"
                                        >
                                            Cambiar
                                        </Button>
                                    </div>
                                </CardHeader>
                                <CardContent className="space-y-5">
                                    {/* Datos del cliente */}
                                    <div>
                                        <h4 className="text-sm font-semibold text-gray-700 mb-3 flex items-center gap-2">
                                            <User className="h-4 w-4 text-primary-600" />
                                            Datos del Cliente
                                        </h4>
                                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 bg-gray-50 rounded-lg p-4">
                                            <div className="flex items-start gap-3">
                                                <Building2 className="h-4 w-4 text-gray-400 mt-0.5 shrink-0" />
                                                <div>
                                                    <p className="text-xs text-gray-500">Razón Social / Nombre</p>
                                                    <p className="text-sm font-medium text-gray-900">
                                                        {venta.cliente?.datos || "N/A"}
                                                    </p>
                                                </div>
                                            </div>
                                            <div className="flex items-start gap-3">
                                                <CreditCard className="h-4 w-4 text-gray-400 mt-0.5 shrink-0" />
                                                <div>
                                                    <p className="text-xs text-gray-500">RUC / DNI</p>
                                                    <p className="text-sm font-medium text-gray-900">
                                                        {venta.cliente?.documento || "—"}
                                                    </p>
                                                </div>
                                            </div>
                                            <div className="flex items-start gap-3">
                                                <MapPin className="h-4 w-4 text-gray-400 mt-0.5 shrink-0" />
                                                <div>
                                                    <p className="text-xs text-gray-500">Dirección</p>
                                                    <p className="text-sm text-gray-900">
                                                        {venta.cliente?.direccion || "—"}
                                                    </p>
                                                </div>
                                            </div>
                                            <div className="flex items-start gap-3">
                                                <Calendar className="h-4 w-4 text-gray-400 mt-0.5 shrink-0" />
                                                <div>
                                                    <p className="text-xs text-gray-500">Fecha de Emisión</p>
                                                    <p className="text-sm text-gray-900">
                                                        {venta.fecha_emision
                                                            ? new Date(venta.fecha_emision).toLocaleDateString("es-PE")
                                                            : "—"}
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    {/* Datos del comprobante - resumen rápido */}
                                    <div>
                                        <h4 className="text-sm font-semibold text-gray-700 mb-3 flex items-center gap-2">
                                            <FileText className="h-4 w-4 text-primary-600" />
                                            Información del Comprobante
                                        </h4>
                                        <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
                                            <div className="bg-gray-50 rounded-lg p-3 text-center">
                                                <p className="text-xs text-gray-500">Tipo</p>
                                                <p className="text-sm font-semibold text-gray-900">{tipoDoc}</p>
                                            </div>
                                            <div className="bg-gray-50 rounded-lg p-3 text-center">
                                                <p className="text-xs text-gray-500">Serie-Número</p>
                                                <p className="text-sm font-semibold text-gray-900 font-mono">
                                                    {venta.serie}-{venta.numero}
                                                </p>
                                            </div>
                                            <div className="bg-gray-50 rounded-lg p-3 text-center">
                                                <p className="text-xs text-gray-500">Moneda</p>
                                                <p className="text-sm font-semibold text-gray-900">
                                                    {venta.tipo_moneda === "USD" ? "Dólares" : "Soles"}
                                                </p>
                                            </div>
                                            <div className="bg-green-50 border border-green-200 rounded-lg p-3 text-center">
                                                <p className="text-xs text-green-600">Total</p>
                                                <p className="text-base font-bold text-green-700">
                                                    {monedaSimbolo} {parseFloat(venta.total).toFixed(2)}
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </CardContent>
                            </Card>

                            {/* Tabla de productos */}
                            {productos.length > 0 && (
                                <Card>
                                    <CardHeader>
                                        <CardTitle className="flex items-center gap-2 text-base">
                                            <Package className="h-4 w-4 text-primary-600" />
                                            Productos del Comprobante
                                            <Badge variant="outline" className="ml-2">
                                                {productos.length} {productos.length === 1 ? "item" : "items"}
                                            </Badge>
                                        </CardTitle>
                                    </CardHeader>
                                    <CardContent className="p-0">
                                        <Table>
                                            <TableHeader>
                                                <TableRow>
                                                    <TableHead className="w-[50px]">#</TableHead>
                                                    <TableHead>Producto</TableHead>
                                                    <TableHead className="text-center w-[80px]">Cant.</TableHead>
                                                    <TableHead className="text-right w-[120px]">P. Unit.</TableHead>
                                                    <TableHead className="text-right w-[120px]">Subtotal</TableHead>
                                                </TableRow>
                                            </TableHeader>
                                            <TableBody>
                                                {productos.map((item, idx) => {
                                                    const precio = parseFloat(item.precio_unitario || 0);
                                                    const cant = parseFloat(item.cantidad || 0);
                                                    return (
                                                        <TableRow key={idx}>
                                                            <TableCell className="text-gray-400 font-mono text-xs">
                                                                {String(idx + 1).padStart(2, "0")}
                                                            </TableCell>
                                                            <TableCell>
                                                                <p className="font-medium text-gray-900">
                                                                    {item.producto?.nombre || item.descripcion || "Producto"}
                                                                </p>
                                                                {item.producto?.codigo && (
                                                                    <p className="text-xs text-gray-400">
                                                                        COD: {item.producto.codigo}
                                                                    </p>
                                                                )}
                                                            </TableCell>
                                                            <TableCell className="text-center text-gray-700">
                                                                {cant}
                                                            </TableCell>
                                                            <TableCell className="text-right text-gray-700">
                                                                {monedaSimbolo} {precio.toFixed(2)}
                                                            </TableCell>
                                                            <TableCell className="text-right font-medium text-gray-900">
                                                                {monedaSimbolo} {(precio * cant).toFixed(2)}
                                                            </TableCell>
                                                        </TableRow>
                                                    );
                                                })}
                                            </TableBody>
                                            <TableFooter>
                                                <TableRow>
                                                    <TableCell colSpan={4} className="text-right text-gray-600 font-medium">
                                                        Subtotal
                                                    </TableCell>
                                                    <TableCell className="text-right font-medium">
                                                        {monedaSimbolo} {parseFloat(venta.subtotal || 0).toFixed(2)}
                                                    </TableCell>
                                                </TableRow>
                                                <TableRow>
                                                    <TableCell colSpan={4} className="text-right text-gray-600 font-medium">
                                                        IGV (18%)
                                                    </TableCell>
                                                    <TableCell className="text-right font-medium">
                                                        {monedaSimbolo} {parseFloat(venta.igv || 0).toFixed(2)}
                                                    </TableCell>
                                                </TableRow>
                                                <TableRow className="text-base">
                                                    <TableCell colSpan={4} className="text-right font-bold text-gray-900">
                                                        Total
                                                    </TableCell>
                                                    <TableCell className="text-right font-bold text-primary-600">
                                                        {monedaSimbolo} {parseFloat(venta.total).toFixed(2)}
                                                    </TableCell>
                                                </TableRow>
                                            </TableFooter>
                                        </Table>
                                    </CardContent>
                                </Card>
                            )}
                        </>
                    )}
                </div>

                {/* Sidebar derecho */}
                <div className="lg:col-span-4">
                    <Card className="sticky top-4">
                        <CardHeader>
                            <CardTitle className="flex items-center gap-2 text-base">
                                <FileText className="h-4 w-4 text-primary-600" />
                                Datos de la Nota de Crédito
                            </CardTitle>
                            <CardDescription>
                                Selecciona el motivo y completa la información
                            </CardDescription>
                        </CardHeader>
                        <CardContent className="space-y-4">
                            <div>
                                <Label className="mb-1.5 block">
                                    Motivo <span className="text-red-500">*</span>
                                </Label>
                                <Select
                                    value={motivoId}
                                    onValueChange={setMotivoId}
                                >
                                    <SelectTrigger>
                                        <SelectValue placeholder="Seleccione un motivo" />
                                    </SelectTrigger>
                                    <SelectContent>
                                        {motivos.map((m) => (
                                            <SelectItem
                                                key={m.id}
                                                value={String(m.id)}
                                            >
                                                {m.codigo_sunat} -{" "}
                                                {m.descripcion}
                                            </SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                            </div>

                            <div>
                                <Label className="mb-1.5 block">
                                    Descripción{" "}
                                    <span className="text-gray-400 font-normal text-xs">
                                        (opcional)
                                    </span>
                                </Label>
                                <Input
                                    value={descripcion}
                                    onChange={(e) =>
                                        setDescripcion(e.target.value)
                                    }
                                    placeholder="Detalle del motivo"
                                />
                            </div>

                            {/* Resumen */}
                            {venta && (
                                <div className="border-t border-gray-200 pt-4 space-y-3">
                                    <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider">
                                        Resumen
                                    </h4>
                                    <div className="space-y-2">
                                        <div className="flex justify-between text-sm">
                                            <span className="text-gray-500">
                                                Doc. afectado
                                            </span>
                                            <span className="font-mono font-medium text-gray-900">
                                                {venta.serie}-{venta.numero}
                                            </span>
                                        </div>
                                        <div className="flex justify-between text-sm">
                                            <span className="text-gray-500">
                                                Cliente
                                            </span>
                                            <span className="font-medium text-gray-900 text-right max-w-[160px] truncate" title={venta.cliente?.datos}>
                                                {venta.cliente?.datos || "N/A"}
                                            </span>
                                        </div>
                                        <div className="border-t border-dashed border-gray-200 pt-2 mt-2 space-y-1.5">
                                            <div className="flex justify-between text-sm">
                                                <span className="text-gray-500">
                                                    Subtotal
                                                </span>
                                                <span>
                                                    {monedaSimbolo}{" "}
                                                    {parseFloat(
                                                        venta.subtotal || 0,
                                                    ).toFixed(2)}
                                                </span>
                                            </div>
                                            <div className="flex justify-between text-sm">
                                                <span className="text-gray-500">
                                                    IGV
                                                </span>
                                                <span>
                                                    {monedaSimbolo}{" "}
                                                    {parseFloat(
                                                        venta.igv || 0,
                                                    ).toFixed(2)}
                                                </span>
                                            </div>
                                            <div className="flex justify-between text-sm font-bold pt-2 border-t border-gray-200">
                                                <span>Total NC</span>
                                                <span className="text-primary-600 text-base">
                                                    {monedaSimbolo}{" "}
                                                    {parseFloat(venta.total).toFixed(2)}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            )}
                        </CardContent>
                        <CardFooter>
                            <Button
                                onClick={handleSubmit}
                                disabled={
                                    !venta || !motivoId || guardando
                                }
                                className="w-full gap-2"
                            >
                                {guardando && (
                                    <Loader2 className="h-4 w-4 animate-spin" />
                                )}
                                Crear Nota de Crédito
                            </Button>
                        </CardFooter>
                    </Card>
                </div>
            </div>
        </MainLayout>
    );
}
