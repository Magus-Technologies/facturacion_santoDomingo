import { useState, useEffect } from "react";
import { Loader2 } from "lucide-react";
import { baseUrl } from "@/lib/baseUrl";
import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from "./select";

/**
 * Componente para seleccionar un rol de usuario
 */
export default function SelectRol({
    value = "",
    onChange,
    disabled = false,
    error,
}) {
    const [roles, setRoles] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchRoles();
    }, []);

    const fetchRoles = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch(baseUrl("/api/users/roles"), {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                },
            });
            const data = await response.json();
            if (data.success) {
                setRoles(data.data || []);
            }
        } catch (error) {
            console.error("Error al cargar roles:", error);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="relative">
            <Select
                value={value ? String(value) : ""}
                onValueChange={(val) => onChange(val)}
                disabled={disabled || loading}
            >
                <SelectTrigger
                    className={error ? "border-red-500 focus:ring-red-500" : ""}
                >
                    <SelectValue placeholder="Seleccione un rol" />
                </SelectTrigger>
                <SelectContent className="max-h-[300px] overflow-y-auto">
                    {roles.length === 0 && !loading ? (
                        <div className="p-2 text-sm text-center text-gray-500">
                            No hay roles disponibles
                        </div>
                    ) : (
                        roles.map((rol) => (
                            <SelectItem
                                key={rol.rol_id}
                                value={String(rol.rol_id)}
                            >
                                {rol.nombre}
                            </SelectItem>
                        ))
                    )}
                </SelectContent>
            </Select>
            {loading && (
                <Loader2 className="absolute right-10 top-1/2 -translate-y-1/2 h-4 w-4 animate-spin text-gray-400" />
            )}
        </div>
    );
}
