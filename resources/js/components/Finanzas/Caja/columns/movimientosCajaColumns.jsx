export const getMovimientosCajaColumns = () => [
    {
        accessorKey: 'fecha_movimiento',
        header: 'Hora',
        cell: ({ row }) => new Date(row.original.fecha_movimiento).toLocaleTimeString(),
    },
    {
        accessorKey: 'tipo',
        header: 'Tipo',
        cell: ({ row }) => {
            const tipo = row.original.tipo;
            const color = tipo === 'Ingreso' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800';
            return (
                <span className={`inline-flex items-center px-2 py-1 rounded-full text-xs font-medium ${color}`}>
                    {tipo}
                </span>
            );
        },
    },
    {
        accessorKey: 'concepto',
        header: 'Concepto',
        cell: ({ row }) => row.original.concepto || 'N/A',
    },
    {
        accessorKey: 'monto',
        header: 'Monto',
        cell: ({ row }) => (
            <span className="font-mono">S/. {parseFloat(row.original.monto || 0).toFixed(2)}</span>
        ),
    },
];
