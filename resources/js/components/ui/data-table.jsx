import React, { useState, useEffect } from "react";
import {
    flexRender,
    getCoreRowModel,
    getFilteredRowModel,
    getPaginationRowModel,
    getSortedRowModel,
    useReactTable,
} from "@tanstack/react-table";
import {
    ChevronDown,
    ChevronUp,
    ChevronsUpDown,
    Search,
    ChevronLeft,
    ChevronRight,
    ChevronsLeft,
    ChevronsRight,
    Table as TableIcon,
    Grid3x3,
    ArrowUp,
    ArrowDown,
    EyeOff,
    Columns,
    Settings2,
    MoreHorizontal,
    Pin,
    PinOff,
    ArrowUpDown,
} from "lucide-react";
import { Input } from "./input";
import { Button } from "./button";
import {
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
} from "./table";
import { cn } from "@/lib/utils";
import {
    DropdownMenu,
    DropdownMenuCheckboxItem,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuLabel,
    DropdownMenuSeparator,
    DropdownMenuTrigger,
} from "./dropdown-menu";

export function DataTable({
    columns,
    data,
    searchable = false,
    searchPlaceholder = "Buscar...",
    pagination = false,
    pageSize = 10,
    onRowClick,
    gridView = false,
    renderGridCard,
    onSearchChange,
}) {
    const [sorting, setSorting] = useState([]);
    const [columnFilters, setColumnFilters] = useState([]);
    const [globalFilter, setGlobalFilter] = useState("");
    const [viewMode, setViewMode] = useState("table"); // "table" o "grid"

    const tableId =
        typeof window !== "undefined"
            ? window.location.pathname.replace(/\//g, "_") || "main"
            : "main";

    const [columnVisibility, setColumnVisibility] = useState(() => {
        try {
            const saved = localStorage.getItem(`dt_visibility_${tableId}`);
            return saved ? JSON.parse(saved) : {};
        } catch {
            return {};
        }
    });

    const [columnPinning, setColumnPinning] = useState(() => {
        try {
            const saved = localStorage.getItem(`dt_pinning_${tableId}`);
            return saved ? JSON.parse(saved) : {};
        } catch {
            return {};
        }
    });

    const resetTableState = () => {
        setColumnVisibility({});
        setColumnPinning({});
        localStorage.removeItem(`dt_visibility_${tableId}`);
        localStorage.removeItem(`dt_pinning_${tableId}`);
    };

    useEffect(() => {
        localStorage.setItem(
            `dt_visibility_${tableId}`,
            JSON.stringify(columnVisibility),
        );
    }, [columnVisibility, tableId]);

    useEffect(() => {
        localStorage.setItem(
            `dt_pinning_${tableId}`,
            JSON.stringify(columnPinning),
        );
    }, [columnPinning, tableId]);

    // Filtro global que busca en TODOS los campos del objeto original
    const globalFilterFn = (row, _columnId, filterValue) => {
        const search = filterValue.toLowerCase();
        const original = row.original;
        return Object.values(original).some((val) => {
            if (val == null) return false;
            if (typeof val === "object") {
                return Object.values(val).some(
                    (v) => v != null && String(v).toLowerCase().includes(search),
                );
            }
            return String(val).toLowerCase().includes(search);
        });
    };

    const table = useReactTable({
        data,
        columns,
        getCoreRowModel: getCoreRowModel(),
        getPaginationRowModel: pagination ? getPaginationRowModel() : undefined,
        getSortedRowModel: getSortedRowModel(),
        getFilteredRowModel: getFilteredRowModel(),
        globalFilterFn,
        onSortingChange: setSorting,
        onColumnFiltersChange: setColumnFilters,
        onColumnVisibilityChange: setColumnVisibility,
        onColumnPinningChange: setColumnPinning,
        onGlobalFilterChange: setGlobalFilter,
        autoResetPageIndex: false,
        state: {
            sorting,
            columnFilters,
            globalFilter,
            columnVisibility,
            columnPinning,
        },
        initialState: {
            pagination: {
                pageSize: pageSize,
            },
        },
    });

    return (
        <div className="space-y-4">
            {/* Search Bar and View Toggle */}
            <div className="flex items-center justify-between gap-4">
                {searchable && (
                    <div className="relative flex-1 max-w-sm">
                        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
                        <Input
                            placeholder={searchPlaceholder}
                            value={globalFilter ?? ""}
                            onChange={(e) => {
                                setGlobalFilter(e.target.value);
                                onSearchChange?.(e.target.value);
                            }}
                            className="pl-9"
                        />
                    </div>
                )}

                {/* Right controls: Columns Dropdown and View Toggle */}
                <div className="flex items-center gap-2 relative">
                    {/* Columns Dropdown */}
                    <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                            <Button
                                variant="outline"
                                className="hidden sm:flex items-center gap-2 px-3 py-1.5 h-auto rounded-lg text-sm font-medium border-gray-200 text-gray-700 bg-white hover:bg-gray-100 hover:text-blue-600 hover:border-blue-200 shadow-sm transition-all outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-1 group"
                            >
                                <Settings2 className="h-4 w-4 text-gray-500 group-hover:text-blue-600 transition-colors" />
                                <span className="hidden sm:inline">Vistas</span>
                            </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end" className="w-[220px]">
                            {(() => {
                                const hideableCols = table
                                    .getAllColumns()
                                    .filter(
                                        (column) =>
                                            typeof column.accessorFn !==
                                                "undefined" &&
                                            column.getCanHide(),
                                    );
                                const allVisible =
                                    hideableCols.length > 0 &&
                                    hideableCols.every((c) => c.getIsVisible());
                                return (
                                    <>
                                        <div className="p-1">
                                            <DropdownMenuCheckboxItem
                                                className="font-bold cursor-pointer text-gray-900"
                                                checked={allVisible}
                                                onSelect={(e) => {
                                                    e.preventDefault();
                                                    hideableCols.forEach(
                                                        (column) =>
                                                            column.toggleVisibility(
                                                                !allVisible,
                                                            ),
                                                    );
                                                }}
                                            >
                                                Ver Todo
                                            </DropdownMenuCheckboxItem>
                                        </div>
                                        <DropdownMenuSeparator />
                                        <div className="max-h-[400px] overflow-y-auto p-1 custom-scrollbar">
                                            {hideableCols.map((column) => {
                                                return (
                                                    <DropdownMenuCheckboxItem
                                                        key={column.id}
                                                        className="cursor-pointer font-medium text-gray-700"
                                                        checked={column.getIsVisible()}
                                                        onCheckedChange={(
                                                            value,
                                                        ) =>
                                                            column.toggleVisibility(
                                                                !!value,
                                                            )
                                                        }
                                                    >
                                                        {typeof column.columnDef
                                                            .header === "string"
                                                            ? column.columnDef
                                                                  .header
                                                            : column.id}
                                                    </DropdownMenuCheckboxItem>
                                                );
                                            })}
                                        </div>
                                        <DropdownMenuSeparator />
                                        <div className="p-1">
                                            <DropdownMenuItem
                                                onClick={resetTableState}
                                                className="text-red-600 focus:text-red-700 focus:bg-red-50 cursor-pointer justify-center font-medium"
                                            >
                                                Restaurar por defecto
                                            </DropdownMenuItem>
                                        </div>
                                    </>
                                );
                            })()}
                        </DropdownMenuContent>
                    </DropdownMenu>

                    {/* View Toggle Buttons */}
                    {gridView && renderGridCard && (
                        <div className="flex items-center gap-2 bg-gray-100 p-1 rounded-lg">
                            <button
                                onClick={() => setViewMode("table")}
                                className={`flex items-center gap-2 px-3 py-1.5 rounded-md text-sm font-medium transition-all ${
                                    viewMode === "table"
                                        ? "bg-primary-600 text-white shadow-sm"
                                        : "text-gray-600 hover:text-gray-900"
                                }`}
                            >
                                <TableIcon className="h-4 w-4" />
                                <span className="hidden sm:inline">
                                    Vista Tabla
                                </span>
                            </button>
                            <button
                                onClick={() => setViewMode("grid")}
                                className={`flex items-center gap-2 px-3 py-1.5 rounded-md text-sm font-medium transition-all ${
                                    viewMode === "grid"
                                        ? "bg-primary-600 text-white shadow-sm"
                                        : "text-gray-600 hover:text-gray-900"
                                }`}
                            >
                                <Grid3x3 className="h-4 w-4" />
                                <span className="hidden sm:inline">
                                    Vista Grid
                                </span>
                            </button>
                        </div>
                    )}
                </div>
            </div>

            {/* Table View */}
            {viewMode === "table" && (
                <div className="rounded-lg border border-gray-200 overflow-hidden bg-white shadow-sm">
                    <Table>
                        <TableHeader>
                            {table.getHeaderGroups().map((headerGroup) => (
                                <TableRow
                                    key={headerGroup.id}
                                    className="hover:bg-transparent"
                                >
                                    {headerGroup.headers.map((header) => {
                                        const isPinned =
                                            header.column.getIsPinned();
                                        const isLastLeftPinned =
                                            isPinned === "left" &&
                                            header.column.getIsLastColumn(
                                                "left",
                                            );
                                        const isFirstRightPinned =
                                            isPinned === "right" &&
                                            header.column.getIsFirstColumn(
                                                "right",
                                            );

                                        return (
                                            <TableHead
                                                key={header.id}
                                                style={{
                                                    left:
                                                        isPinned === "left"
                                                            ? `${header.column.getStart("left")}px`
                                                            : undefined,
                                                    right:
                                                        isPinned === "right"
                                                            ? `${header.column.getAfter("right")}px`
                                                            : undefined,
                                                    position: isPinned
                                                        ? "sticky"
                                                        : "relative",
                                                    width: isPinned
                                                        ? header.column.getSize()
                                                        : undefined,
                                                    zIndex: isPinned ? 20 : 0,
                                                    boxShadow: isLastLeftPinned
                                                        ? "inset -4px 0 4px -4px rgba(0,0,0,0.1)"
                                                        : isFirstRightPinned
                                                          ? "inset 4px 0 4px -4px rgba(0,0,0,0.1)"
                                                          : undefined,
                                                }}
                                                className={
                                                    isPinned
                                                        ? "bg-primary-600 shadow-sm"
                                                        : ""
                                                }
                                            >
                                                {header.isPlaceholder ? null : header.column.getCanSort() ||
                                                  header.column.getCanHide() ? (
                                                    <div className="flex items-center justify-between gap-1 w-full group">
                                                        <div
                                                            className={`flex-1 flex items-center gap-1 select-none ${header.column.getCanSort() ? "cursor-pointer hover:text-accent-300 transition-colors" : ""}`}
                                                            onClick={header.column.getToggleSortingHandler()}
                                                        >
                                                            {flexRender(
                                                                header.column
                                                                    .columnDef
                                                                    .header,
                                                                header.getContext(),
                                                            )}
                                                            {header.column.getCanSort() &&
                                                                header.column.getIsSorted() && (
                                                                    <span className="text-white/90 shrink-0">
                                                                        {
                                                                            {
                                                                                asc: (
                                                                                    <ArrowUp className="h-4 w-4" />
                                                                                ),
                                                                                desc: (
                                                                                    <ArrowDown className="h-4 w-4" />
                                                                                ),
                                                                            }[
                                                                                header.column.getIsSorted()
                                                                            ]
                                                                        }
                                                                    </span>
                                                                )}
                                                            {header.column.getCanSort() &&
                                                                !header.column.getIsSorted() && (
                                                                    <span className="text-white/40 shrink-0 opacity-0 group-hover:opacity-100 transition-opacity">
                                                                        <ArrowUpDown className="h-4 w-4" />
                                                                    </span>
                                                                )}
                                                        </div>

                                                        <DropdownMenu>
                                                            <DropdownMenuTrigger
                                                                asChild
                                                            >
                                                                <button className="h-8 w-8 flex items-center justify-center rounded-md hover:bg-white/20 transition-colors opacity-0 group-hover:opacity-100 data-[state=open]:opacity-100 focus:opacity-100 ml-1 shrink-0 text-white">
                                                                    <MoreHorizontal className="h-4 w-4" />
                                                                </button>
                                                            </DropdownMenuTrigger>
                                                            <DropdownMenuContent
                                                                align="start"
                                                                className="w-[190px] p-1.5 shadow-xl rounded-xl border-gray-100"
                                                            >
                                                                {header.column.getCanSort() && (
                                                                    <>
                                                                        <DropdownMenuItem
                                                                            onClick={() =>
                                                                                header.column.toggleSorting(
                                                                                    false,
                                                                                )
                                                                            }
                                                                            className="cursor-pointer px-3 py-2 text-gray-700 focus:bg-gray-100 focus:text-gray-900 rounded-lg transition-colors"
                                                                        >
                                                                            <ArrowUp className="mr-3 h-4 w-4 text-gray-400" />
                                                                            <span className="font-medium">
                                                                                Ordenar
                                                                                ASC
                                                                            </span>
                                                                        </DropdownMenuItem>
                                                                        <DropdownMenuItem
                                                                            onClick={() =>
                                                                                header.column.toggleSorting(
                                                                                    true,
                                                                                )
                                                                            }
                                                                            className="cursor-pointer px-3 py-2 text-gray-700 focus:bg-gray-100 focus:text-gray-900 rounded-lg transition-colors"
                                                                        >
                                                                            <ArrowDown className="mr-3 h-4 w-4 text-gray-400" />
                                                                            <span className="font-medium">
                                                                                Ordenar
                                                                                DESC
                                                                            </span>
                                                                        </DropdownMenuItem>
                                                                        {header.column.getIsSorted() && (
                                                                            <DropdownMenuItem
                                                                                onClick={() =>
                                                                                    header.column.clearSorting()
                                                                                }
                                                                                className="cursor-pointer px-3 py-2 text-gray-700 focus:bg-gray-100 focus:text-gray-900 rounded-lg transition-colors"
                                                                            >
                                                                                <ArrowUpDown className="mr-3 h-4 w-4 text-gray-400" />
                                                                                <span className="font-medium">
                                                                                    Desordenar
                                                                                </span>
                                                                            </DropdownMenuItem>
                                                                        )}
                                                                        <DropdownMenuSeparator className="my-1.5" />
                                                                    </>
                                                                )}

                                                                {typeof header
                                                                    .column
                                                                    .getCanPin ===
                                                                    "function" &&
                                                                    header.column.getCanPin() && (
                                                                        <>
                                                                            <DropdownMenuItem
                                                                                onClick={() =>
                                                                                    header.column.pin(
                                                                                        "left",
                                                                                    )
                                                                                }
                                                                                className="cursor-pointer px-3 py-2 text-gray-700 focus:bg-gray-100 focus:text-gray-900 rounded-lg transition-colors"
                                                                            >
                                                                                <Pin className="mr-3 h-4 w-4 text-gray-400" />
                                                                                <span className="font-medium">
                                                                                    Fijar
                                                                                    a
                                                                                    la
                                                                                    izquierda
                                                                                </span>
                                                                            </DropdownMenuItem>
                                                                            <DropdownMenuItem
                                                                                onClick={() =>
                                                                                    header.column.pin(
                                                                                        "right",
                                                                                    )
                                                                                }
                                                                                className="cursor-pointer px-3 py-2 text-gray-700 focus:bg-gray-100 focus:text-gray-900 rounded-lg transition-colors"
                                                                            >
                                                                                <Pin className="mr-3 h-4 w-4 text-gray-400 transform scale-x-[-1]" />
                                                                                <span className="font-medium">
                                                                                    Fijar
                                                                                    a
                                                                                    la
                                                                                    derecha
                                                                                </span>
                                                                            </DropdownMenuItem>
                                                                            {header.column.getIsPinned() && (
                                                                                <DropdownMenuItem
                                                                                    onClick={() =>
                                                                                        header.column.pin(
                                                                                            false,
                                                                                        )
                                                                                    }
                                                                                    className="cursor-pointer px-3 py-2 text-gray-700 focus:bg-gray-100 focus:text-gray-900 rounded-lg transition-colors"
                                                                                >
                                                                                    <PinOff className="mr-3 h-4 w-4 text-gray-400" />
                                                                                    <span className="font-medium">
                                                                                        Desprender
                                                                                    </span>
                                                                                </DropdownMenuItem>
                                                                            )}
                                                                            <DropdownMenuSeparator className="my-1.5" />
                                                                        </>
                                                                    )}

                                                                {header.column.getCanHide() && (
                                                                    <DropdownMenuItem
                                                                        onClick={() =>
                                                                            header.column.toggleVisibility(
                                                                                false,
                                                                            )
                                                                        }
                                                                        className="cursor-pointer px-3 py-2 text-gray-700 focus:bg-gray-100 focus:text-gray-900 rounded-lg transition-colors"
                                                                    >
                                                                        <EyeOff className="mr-3 h-4 w-4 text-gray-400" />
                                                                        <span className="font-medium">
                                                                            Ocultar
                                                                            columna
                                                                        </span>
                                                                    </DropdownMenuItem>
                                                                )}
                                                            </DropdownMenuContent>
                                                        </DropdownMenu>
                                                    </div>
                                                ) : (
                                                    flexRender(
                                                        header.column.columnDef
                                                            .header,
                                                        header.getContext(),
                                                    )
                                                )}
                                            </TableHead>
                                        );
                                    })}
                                </TableRow>
                            ))}
                        </TableHeader>
                        <TableBody>
                            {table.getRowModel().rows?.length ? (
                                table.getRowModel().rows.map((row) => (
                                    <TableRow
                                        key={row.id}
                                        data-state={
                                            row.getIsSelected() && "selected"
                                        }
                                        onClick={() =>
                                            onRowClick?.(row.original)
                                        }
                                        className={cn(
                                            onRowClick ? "cursor-pointer" : "",
                                            "group",
                                        )}
                                    >
                                        {row.getVisibleCells().map((cell) => {
                                            const isPinned =
                                                cell.column.getIsPinned();
                                            const isLastLeftPinned =
                                                isPinned === "left" &&
                                                cell.column.getIsLastColumn(
                                                    "left",
                                                );
                                            const isFirstRightPinned =
                                                isPinned === "right" &&
                                                cell.column.getIsFirstColumn(
                                                    "right",
                                                );

                                            return (
                                                <TableCell
                                                    key={cell.id}
                                                    style={{
                                                        left:
                                                            isPinned === "left"
                                                                ? `${cell.column.getStart("left")}px`
                                                                : undefined,
                                                        right:
                                                            isPinned === "right"
                                                                ? `${cell.column.getAfter("right")}px`
                                                                : undefined,
                                                        position: isPinned
                                                            ? "sticky"
                                                            : "relative",
                                                        width: isPinned
                                                            ? cell.column.getSize()
                                                            : undefined,
                                                        zIndex: isPinned
                                                            ? 10
                                                            : 0,
                                                        boxShadow:
                                                            isLastLeftPinned
                                                                ? "inset -4px 0 4px -4px rgba(0,0,0,0.1)"
                                                                : isFirstRightPinned
                                                                  ? "inset 4px 0 4px -4px rgba(0,0,0,0.1)"
                                                                  : undefined,
                                                    }}
                                                    className={
                                                        isPinned
                                                            ? "bg-white group-hover:bg-gray-50 shadow-sm"
                                                            : ""
                                                    }
                                                >
                                                    {flexRender(
                                                        cell.column.columnDef
                                                            .cell,
                                                        cell.getContext(),
                                                    )}
                                                </TableCell>
                                            );
                                        })}
                                    </TableRow>
                                ))
                            ) : (
                                <TableRow>
                                    <TableCell
                                        colSpan={columns.length}
                                        className="h-24 text-center text-gray-500"
                                    >
                                        No se encontraron resultados.
                                    </TableCell>
                                </TableRow>
                            )}
                        </TableBody>
                    </Table>
                </div>
            )}

            {/* Grid View */}
            {viewMode === "grid" && renderGridCard && (
                <div>
                    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
                        {table.getRowModel().rows?.length ? (
                            table
                                .getRowModel()
                                .rows.map((row) => (
                                    <div key={row.id}>
                                        {renderGridCard(row.original)}
                                    </div>
                                ))
                        ) : (
                            <div className="col-span-full text-center py-12 text-gray-500">
                                No se encontraron resultados.
                            </div>
                        )}
                    </div>
                </div>
            )}

            {/* Pagination */}
            {pagination && viewMode === "table" && (
                <div className="flex items-center justify-between px-2">
                    <div className="text-sm text-gray-600">
                        Mostrando{" "}
                        <span className="font-medium">
                            {table.getState().pagination.pageIndex *
                                table.getState().pagination.pageSize +
                                1}
                        </span>{" "}
                        a{" "}
                        <span className="font-medium">
                            {Math.min(
                                (table.getState().pagination.pageIndex + 1) *
                                    table.getState().pagination.pageSize,
                                table.getFilteredRowModel().rows.length,
                            )}
                        </span>{" "}
                        de{" "}
                        <span className="font-medium">
                            {table.getFilteredRowModel().rows.length}
                        </span>{" "}
                        resultados
                    </div>
                    <div className="flex items-center gap-2">
                        <Button
                            variant="outline"
                            size="sm"
                            onClick={() => table.setPageIndex(0)}
                            disabled={!table.getCanPreviousPage()}
                        >
                            <ChevronsLeft className="h-4 w-4" />
                        </Button>
                        <Button
                            variant="outline"
                            size="sm"
                            onClick={() => table.previousPage()}
                            disabled={!table.getCanPreviousPage()}
                        >
                            <ChevronLeft className="h-4 w-4" />
                        </Button>
                        <span className="text-sm text-gray-600">
                            Página{" "}
                            <span className="font-medium">
                                {table.getState().pagination.pageIndex + 1}
                            </span>{" "}
                            de{" "}
                            <span className="font-medium">
                                {table.getPageCount()}
                            </span>
                        </span>
                        <Button
                            variant="outline"
                            size="sm"
                            onClick={() => table.nextPage()}
                            disabled={!table.getCanNextPage()}
                        >
                            <ChevronRight className="h-4 w-4" />
                        </Button>
                        <Button
                            variant="outline"
                            size="sm"
                            onClick={() =>
                                table.setPageIndex(table.getPageCount() - 1)
                            }
                            disabled={!table.getCanNextPage()}
                        >
                            <ChevronsRight className="h-4 w-4" />
                        </Button>
                    </div>
                </div>
            )}
        </div>
    );
}
