import { Label } from "../ui/label";
import { Input } from "../ui/input";
import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from "../ui/select";
import {
    Banknote,
    CreditCard,
    Building2,
    Smartphone,
    Upload,
    X,
    Image,
    Loader2,
} from "lucide-react";
import { toast } from "@/lib/sweetalert";
import { useEffect, useState } from "react";

const TIPO_ICONS = {
    Efectivo: Banknote,
    Tarjeta: CreditCard,
    Transferencia: Building2,
    Billetera: Smartphone,
    Cheque: CreditCard,
    Otro: Banknote,
};

const BANCOS = [
    "BCP",
    "BBVA",
    "Interbank",
    "Scotiabank",
    "BanBif",
    "Otro",
];

export default function MetodoPago({
    metodoPago,
    onMetodoPagoChange,
    condicionPago = "1", // "1" = Contado, "2" = Crédito
}) {
    const [metodos, setMetodos] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const cargarMetodos = async () => {
            try {
                const token = localStorage.getItem('auth_token');
                const response = await fetch('/api/metodos-pago', {
                    headers: {
                        'Authorization': `Bearer ${token}`,
                        'Accept': 'application/json',
                    },
                });
                const data = await response.json();
                if (data.success) {
                    setMetodos(data.data);
                }
            } catch (error) {
                console.error('Error al cargar métodos de pago:', error);
            } finally {
                setLoading(false);
            }
        };
        cargarMetodos();
    }, []);

    // Si es crédito, no mostrar método de pago
    if (String(condicionPago) === "2") {
        return null;
    }

    const requiresDetails = metodoPago.id_metodo_pago && 
        ['Tarjeta', 'Transferencia', 'Billetera'].includes(
            metodos.find(m => m.id_metodo_pago == metodoPago.id_metodo_pago)?.tipo
        );

    const handleChange = (field, value) => {
        onMetodoPagoChange({ ...metodoPago, [field]: value });
    };

    const handleVoucherChange = (e) => {
        const file = e.target.files[0];
        if (!file) return;

        const validTypes = ["image/jpeg", "image/png", "image/jpg", "image/webp"];
        if (!validTypes.includes(file.type)) {
            toast.error("Formato no válido. Use JPG, PNG o WebP.");
            e.target.value = "";
            return;
        }

        if (file.size > 2 * 1024 * 1024) {
            toast.error("El archivo es muy grande. Máximo 2MB.");
            e.target.value = "";
            return;
        }

        const reader = new FileReader();
        reader.onloadend = () => {
            onMetodoPagoChange({
                ...metodoPago,
                voucher_file: file,
                voucher_preview: reader.result,
            });
        };
        reader.readAsDataURL(file);
    };

    const handleRemoveVoucher = () => {
        onMetodoPagoChange({
            ...metodoPago,
            voucher_file: null,
            voucher_preview: null,
        });
    };

    const metodoSeleccionado = metodos.find(m => m.id_metodo_pago == metodoPago.id_metodo_pago);
    const MetodoIcon = metodoSeleccionado ? (TIPO_ICONS[metodoSeleccionado.tipo] || Banknote) : Banknote;

    if (loading) {
        return (
            <div className="pt-3 border-t space-y-3 flex items-center justify-center">
                <Loader2 className="h-4 w-4 animate-spin" />
                <span className="text-xs text-gray-500">Cargando métodos...</span>
            </div>
        );
    }

    return (
        <div className="pt-3 border-t space-y-3">
            <h4 className="text-xs font-semibold text-gray-700 flex items-center gap-2">
                <MetodoIcon className="h-3.5 w-3.5 text-primary-600" />
                Método de Pago
            </h4>

            {/* Selector de método */}
            <Select
                value={metodoPago.id_metodo_pago ? String(metodoPago.id_metodo_pago) : ""}
                onValueChange={(val) => handleChange("id_metodo_pago", val)}
            >
                <SelectTrigger>
                    <SelectValue placeholder="Seleccione método" />
                </SelectTrigger>
                <SelectContent>
                    {metodos.map((m) => {
                        const Icon = TIPO_ICONS[m.tipo] || Banknote;
                        return (
                            <SelectItem key={m.id_metodo_pago} value={String(m.id_metodo_pago)}>
                                <span className="flex items-center gap-2">
                                    <Icon className="h-4 w-4" />
                                    {m.nombre}
                                </span>
                            </SelectItem>
                        );
                    })}
                </SelectContent>
            </Select>

            {/* Campos adicionales para Transferencia/Yape/Tarjeta */}
            {requiresDetails && (
                <>
                    <div className="grid grid-cols-2 gap-2">
                        <div>
                            <Label className="block text-xs font-medium mb-1">
                                N° Operación
                            </Label>
                            <Input
                                type="text"
                                placeholder="00123456"
                                value={metodoPago.numero_operacion || ""}
                                onChange={(e) =>
                                    handleChange("numero_operacion", e.target.value)
                                }
                            />
                        </div>
                        <div>
                            <Label className="block text-xs font-medium mb-1">
                                Banco
                            </Label>
                            <Select
                                value={metodoPago.banco || ""}
                                onValueChange={(val) => handleChange("banco", val)}
                            >
                                <SelectTrigger>
                                    <SelectValue placeholder="Banco" />
                                </SelectTrigger>
                                <SelectContent>
                                    {BANCOS.map((b) => (
                                        <SelectItem key={b} value={b}>
                                            {b}
                                        </SelectItem>
                                    ))}
                                </SelectContent>
                            </Select>
                        </div>
                    </div>

                    {/* Subir Voucher */}
                    <div>
                        <Label className="block text-xs font-medium mb-1">
                            Voucher
                        </Label>

                        {!metodoPago.voucher_preview ? (
                            <label className="flex items-center justify-center gap-2 w-full h-16 border-2 border-dashed border-gray-300 rounded-lg cursor-pointer hover:border-primary-400 hover:bg-primary-50/30 transition-colors">
                                <Upload className="h-4 w-4 text-gray-400" />
                                <span className="text-xs text-gray-500">
                                    Subir imagen
                                </span>
                                <span className="text-[10px] text-gray-400">
                                    (máx 2MB)
                                </span>
                                <input
                                    type="file"
                                    className="hidden"
                                    accept="image/jpeg,image/png,image/jpg,image/webp"
                                    onChange={handleVoucherChange}
                                />
                            </label>
                        ) : (
                            <div className="relative group">
                                <img
                                    src={metodoPago.voucher_preview}
                                    alt="Voucher"
                                    className="w-full h-24 object-cover rounded-lg border"
                                />
                                <button
                                    type="button"
                                    onClick={handleRemoveVoucher}
                                    className="absolute top-1 right-1 bg-red-500 text-white rounded-full p-0.5 opacity-0 group-hover:opacity-100 transition-opacity"
                                >
                                    <X className="h-3 w-3" />
                                </button>
                                <div className="absolute bottom-1 left-1 bg-black/60 text-white text-[10px] px-1.5 py-0.5 rounded flex items-center gap-1">
                                    <Image className="h-3 w-3" />
                                    Adjunto
                                </div>
                            </div>
                        )}
                    </div>
                </>
            )}
        </div>
    );
}
