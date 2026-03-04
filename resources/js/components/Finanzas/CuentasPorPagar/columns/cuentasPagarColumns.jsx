import { MoreHorizontal, DollarSign } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

const getEstadoBadge = (estado, fechaVencimiento) => {
    if (estado === '0') return { label: 'Pagado', class: 'bg-green-100 text-green-800' };
    if (estado === '1' && new Date(fechaVencimiento) < new Date()) {
        return { label: 'Vencido', class: 'bg-red-100 text-red-800' };
    }
    return { label: 'Pendiente', class: 'bg-yellow-100 text-yellow-800' };
};

export const getCuentasPagarColumns = ({ handlePagar }) => [
    {
        accessorKey: "documento",
        header: "Documento",
        cell: ({ row }) => (
            <span className="font-mono text-sm font-medium">{row.getValue("documento")}</span>
        ),
    },
    {
        accessorKey: "proveedor",
        header: "Proveedor",
        cell: ({ row }) => (
            <div>
                <p className="font-medium text-gray-900 text-sm truncate max-w-[200px]" title={row.getValue("proveedor")}>
                    {row.getValue("proveedor")}
                </p>
                <p className="text-xs text-gray-500">{row.original.proveedor_ruc}</p>
            </div>
        ),
    },
    {
        accessorKey: "fecha_vencimiento",
        header: "F. Vencimiento",
        cell: ({ row }) => {
            const fecha = row.getValue("fecha_vencimiento");
            if (!fecha) return "—";
            const [y, m, d] = fecha.split("-");
            return <span className="text-sm">{d}/{m}/{y}</span>;
        },
    },
    {
        accessorKey: "monto",
        header: "Monto",
        cell: ({ row }) => (
            <span className="text-sm font-bold text-right block">S/ {parseFloat(row.getValue("monto")).toFixed(2)}</span>
        ),
    },
    {
        accessorKey: "estado",
        header: "Estado",
        cell: ({ row }) => {
            const badge = getEstadoBadge(row.getValue("estado"), row.original.fecha_vencimiento);
            return (
                <span className={`inline-flex items-center px-2 py-1 rounded-full text-xs font-medium ${badge.class}`}>
                    {badge.label}
                </span>
            );
        },
    },
    {
        accessorKey: "fecha_pago",
        header: "F. Pago",
        cell: ({ row }) => {
            const fecha = row.getValue("fecha_pago");
            if (!fecha) return <span className="text-gray-400">—</span>;
            const [y, m, d] = fecha.split("-");
            return <span className="text-sm">{d}/{m}/{y}</span>;
        },
    },
    {
        id: "actions",
        header: "",
        enableSorting: false,
        cell: ({ row }) => {
            const cuota = row.original;
            if (cuota.estado === '0') return null;
            return (
                <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="sm">
                            <MoreHorizontal className="h-4 w-4" />
                        </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent align="end">
                        <DropdownMenuItem onClick={() => handlePagar(cuota)}>
                            <DollarSign className="h-4 w-4 mr-2" />
                            Registrar Pago
                        </DropdownMenuItem>
                    </DropdownMenuContent>
                </DropdownMenu>
            );
        },
    },
];
