import { MoreHorizontal, DollarSign } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

const getEstadoBadge = (estado) => {
    switch (estado) {
        case 'P': return { label: 'Pendiente', class: 'bg-yellow-100 text-yellow-800' };
        case 'V': return { label: 'Vencido', class: 'bg-red-100 text-red-800' };
        case 'C': return { label: 'Pagado', class: 'bg-green-100 text-green-800' };
        default: return { label: estado, class: 'bg-gray-100 text-gray-800' };
    }
};

export const getCuentasCobrarColumns = ({ handlePagar }) => [
    {
        accessorKey: "documento",
        header: "Documento",
        cell: ({ row }) => (
            <span className="font-mono text-sm font-medium">{row.getValue("documento")}</span>
        ),
    },
    {
        accessorKey: "cliente",
        header: "Cliente",
        cell: ({ row }) => (
            <div>
                <p className="font-medium text-gray-900 text-sm truncate max-w-[180px]" title={row.getValue("cliente")}>
                    {row.getValue("cliente")}
                </p>
                <p className="text-xs text-gray-500">{row.original.cliente_documento}</p>
            </div>
        ),
    },
    {
        accessorKey: "numero_cuota",
        header: "Cuota",
        cell: ({ row }) => (
            <span className="text-center block text-sm">#{row.getValue("numero_cuota")}</span>
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
        accessorKey: "monto_cuota",
        header: "Monto",
        cell: ({ row }) => (
            <span className="text-sm text-right block">S/ {parseFloat(row.getValue("monto_cuota")).toFixed(2)}</span>
        ),
    },
    {
        accessorKey: "monto_pagado",
        header: "Pagado",
        cell: ({ row }) => (
            <span className="text-sm text-right block">S/ {parseFloat(row.getValue("monto_pagado")).toFixed(2)}</span>
        ),
    },
    {
        accessorKey: "saldo",
        header: "Saldo",
        cell: ({ row }) => (
            <span className="text-sm font-bold text-right block">S/ {parseFloat(row.getValue("saldo")).toFixed(2)}</span>
        ),
    },
    {
        accessorKey: "estado",
        header: "Estado",
        cell: ({ row }) => {
            const badge = getEstadoBadge(row.getValue("estado"));
            return (
                <span className={`inline-flex items-center px-2 py-1 rounded-full text-xs font-medium ${badge.class}`}>
                    {badge.label}
                </span>
            );
        },
    },
    {
        id: "actions",
        header: "",
        enableSorting: false,
        cell: ({ row }) => {
            const cuota = row.original;
            if (cuota.estado === 'C') return null;
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
