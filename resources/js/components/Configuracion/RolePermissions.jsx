import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "../ui/card";
import { Button } from "../ui/button";
import { toast } from "@/lib/sweetalert";
import { Loader2, Shield, Check, X } from "lucide-react";
import MainLayout from "../Layout/MainLayout";

export default function RolePermissions() {
    const [roles, setRoles] = useState([]);
    const [permissions, setPermissions] = useState([]);
    const [selectedRole, setSelectedRole] = useState(null);
    const [rolePermissions, setRolePermissions] = useState([]);
    const [loading, setLoading] = useState(false);
    const [saving, setSaving] = useState(false);

    useEffect(() => {
        fetchRoles();
        fetchPermissions();
    }, []);

    const fetchRoles = async () => {
        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch("/api/users/roles", {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                },
            });
            const data = await response.json();
            if (data.success) {
                // Filtrar el rol ADMIN (rol_id = 1) porque tiene todos los permisos por defecto
                const rolesFiltered = data.data.filter(role => role.rol_id !== 1 && role.nombre !== 'ADMIN');
                setRoles(rolesFiltered);
                console.log('Roles filtrados:', rolesFiltered); // Debug
            }
        } catch (error) {
            console.error("Error al cargar roles:", error);
        }
    };

    const fetchPermissions = async () => {
        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch("/api/permissions", {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                },
            });
            const data = await response.json();
            if (data.success) {
                setPermissions(data.data);
            }
        } catch (error) {
            console.error("Error al cargar permisos:", error);
        }
    };

    const fetchRolePermissions = async (rolId) => {
        setLoading(true);
        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch(`/api/permissions/role/${rolId}`, {
                headers: {
                    Authorization: `Bearer ${token}`,
                    Accept: "application/json",
                },
            });
            const data = await response.json();
            if (data.success) {
                setRolePermissions(data.data.permissions);
            }
        } catch (error) {
            console.error("Error al cargar permisos del rol:", error);
        } finally {
            setLoading(false);
        }
    };

    const handleRoleSelect = (role) => {
        setSelectedRole(role);
        fetchRolePermissions(role.rol_id);
    };

    const togglePermission = (permissionId) => {
        setRolePermissions((prev) => {
            if (prev.includes(permissionId)) {
                return prev.filter((id) => id !== permissionId);
            } else {
                return [...prev, permissionId];
            }
        });
    };

    const toggleModulePermissions = (modulePermissions) => {
        const modulePermissionIds = modulePermissions.map((p) => p.id);
        const allSelected = modulePermissionIds.every((id) =>
            rolePermissions.includes(id)
        );

        if (allSelected) {
            // Deseleccionar todos
            setRolePermissions((prev) =>
                prev.filter((id) => !modulePermissionIds.includes(id))
            );
        } else {
            // Seleccionar todos
            setRolePermissions((prev) => [
                ...new Set([...prev, ...modulePermissionIds]),
            ]);
        }
    };

    const selectAllByAction = (action) => {
        const permissionsByAction = permissions.flatMap((group) =>
            group.permissions
                .filter((p) => p.action === action)
                .map((p) => p.id)
        );
        setRolePermissions((prev) => [
            ...new Set([...prev, ...permissionsByAction]),
        ]);
    };

    const selectAllPermissions = () => {
        const allPermissionIds = permissions.flatMap((group) =>
            group.permissions.map((p) => p.id)
        );
        setRolePermissions(allPermissionIds);
    };

    const handleSave = async () => {
        if (!selectedRole) return;

        setSaving(true);
        try {
            const token = localStorage.getItem("auth_token");
            const response = await fetch(
                `/api/permissions/role/${selectedRole.rol_id}`,
                {
                    method: "PUT",
                    headers: {
                        Authorization: `Bearer ${token}`,
                        "Content-Type": "application/json",
                        Accept: "application/json",
                    },
                    body: JSON.stringify({
                        permissions: rolePermissions,
                    }),
                }
            );

            const data = await response.json();

            if (data.success) {
                toast.success("Permisos actualizados correctamente. Los usuarios deben refrescar la página (F5) para ver los cambios.");
            } else {
                toast.error(data.message || "Error al actualizar permisos");
            }
        } catch (error) {
            console.error("Error:", error);
            toast.error("Error de conexión al servidor");
        } finally {
            setSaving(false);
        }
    };

    const actionLabels = {
        view: "Ver",
        create: "Crear",
        edit: "Editar",
        delete: "Eliminar",
    };

    const actionColors = {
        view: "bg-blue-100 text-blue-700 border-blue-200",
        create: "bg-green-100 text-green-700 border-green-200",
        edit: "bg-yellow-100 text-yellow-700 border-yellow-200",
        delete: "bg-red-100 text-red-700 border-red-200",
    };

    return (
        <MainLayout>
            <div className="space-y-6">
                <div className="flex items-center justify-between">
                    <div>
                        <h1 className="text-2xl font-bold text-gray-900">
                            Gestión de Permisos
                        </h1>
                        <p className="text-gray-600 mt-1">
                            Configura los permisos para cada rol
                        </p>
                    </div>
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
                    {/* Lista de Roles */}
                    <Card className="lg:col-span-1">
                        <CardHeader>
                            <CardTitle className="text-lg flex items-center gap-2">
                                <Shield className="h-5 w-5" />
                                Roles
                            </CardTitle>
                        </CardHeader>
                        <CardContent>
                            <div className="space-y-2">
                                {roles.map((role) => (
                                    <button
                                        key={role.rol_id}
                                        onClick={() => handleRoleSelect(role)}
                                        className={`w-full text-left px-4 py-3 rounded-lg transition-colors ${
                                            selectedRole?.rol_id === role.rol_id
                                                ? "bg-primary-100 text-primary-700 font-medium"
                                                : "bg-gray-50 hover:bg-gray-100 text-gray-700"
                                        }`}
                                    >
                                        {role.nombre}
                                    </button>
                                ))}
                            </div>
                        </CardContent>
                    </Card>

                    {/* Permisos */}
                    <Card className="lg:col-span-3">
                        <CardHeader>
                            <div className="flex items-center justify-between">
                                <CardTitle className="text-lg">
                                    {selectedRole
                                        ? `Permisos de: ${selectedRole.nombre}`
                                        : "Selecciona un rol"}
                                </CardTitle>
                                {selectedRole && (
                                    <Button
                                        onClick={handleSave}
                                        disabled={saving}
                                        className="gap-2"
                                    >
                                        {saving && (
                                            <Loader2 className="h-4 w-4 animate-spin" />
                                        )}
                                        Guardar Cambios
                                    </Button>
                                )}
                            </div>
                        </CardHeader>
                        <CardContent>
                            {!selectedRole ? (
                                <div className="text-center py-12 text-gray-500">
                                    Selecciona un rol para gestionar sus permisos
                                </div>
                            ) : loading ? (
                                <div className="flex justify-center py-12">
                                    <Loader2 className="h-8 w-8 animate-spin text-primary-600" />
                                </div>
                            ) : (
                                <div className="space-y-6">
                                    {/* Botones de selección rápida */}
                                    <div className="flex flex-wrap gap-2 p-4 bg-gray-50 rounded-lg border border-gray-200">
                                        <span className="text-sm font-medium text-gray-700 mr-2">
                                            Selección rápida:
                                        </span>
                                        <button
                                            onClick={() => selectAllByAction("view")}
                                            className="px-3 py-1 text-xs font-medium bg-blue-100 text-blue-700 rounded-md hover:bg-blue-200 transition-colors"
                                        >
                                            Todos "Ver"
                                        </button>
                                        <button
                                            onClick={() => selectAllByAction("create")}
                                            className="px-3 py-1 text-xs font-medium bg-green-100 text-green-700 rounded-md hover:bg-green-200 transition-colors"
                                        >
                                            Todos "Crear"
                                        </button>
                                        <button
                                            onClick={() => selectAllByAction("edit")}
                                            className="px-3 py-1 text-xs font-medium bg-yellow-100 text-yellow-700 rounded-md hover:bg-yellow-200 transition-colors"
                                        >
                                            Todos "Editar"
                                        </button>
                                        <button
                                            onClick={() => selectAllByAction("delete")}
                                            className="px-3 py-1 text-xs font-medium bg-red-100 text-red-700 rounded-md hover:bg-red-200 transition-colors"
                                        >
                                            Todos "Eliminar"
                                        </button>
                                        <button
                                            onClick={() => selectAllPermissions()}
                                            className="px-3 py-1 text-xs font-medium bg-primary-100 text-primary-700 rounded-md hover:bg-primary-200 transition-colors"
                                        >
                                            Todos
                                        </button>
                                        <button
                                            onClick={() => setRolePermissions([])}
                                            className="px-3 py-1 text-xs font-medium bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300 transition-colors"
                                        >
                                            Limpiar
                                        </button>
                                    </div>

                                    {permissions.map((group) => {
                                        const allSelected = group.permissions.every(
                                            (p) => rolePermissions.includes(p.id)
                                        );

                                        return (
                                            <div
                                                key={group.module}
                                                className="bg-gray-50 rounded-lg p-4"
                                            >
                                                <div className="flex items-center justify-between mb-4">
                                                    <h3 className="font-semibold text-gray-900">
                                                        {group.module_name}
                                                    </h3>
                                                    <button
                                                        onClick={() =>
                                                            toggleModulePermissions(
                                                                group.permissions
                                                            )
                                                        }
                                                        className="text-sm text-primary-600 hover:text-primary-700 font-medium"
                                                    >
                                                        {allSelected
                                                            ? "Deseleccionar todos"
                                                            : "Seleccionar todos"}
                                                    </button>
                                                </div>
                                                <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
                                                    {group.permissions.map(
                                                        (permission) => {
                                                            const isSelected =
                                                                rolePermissions.includes(
                                                                    permission.id
                                                                );
                                                            return (
                                                                <button
                                                                    key={
                                                                        permission.id
                                                                    }
                                                                    onClick={() =>
                                                                        togglePermission(
                                                                            permission.id
                                                                        )
                                                                    }
                                                                    className={`flex items-center justify-between px-3 py-2 rounded-lg border-2 transition-all ${
                                                                        isSelected
                                                                            ? actionColors[
                                                                                  permission
                                                                                      .action
                                                                              ] +
                                                                              " border-current"
                                                                            : "bg-gray-50 text-gray-600 border-gray-200 hover:border-gray-300"
                                                                    }`}
                                                                >
                                                                    <span className="text-sm font-medium">
                                                                        {
                                                                            actionLabels[
                                                                                permission
                                                                                    .action
                                                                            ]
                                                                        }
                                                                    </span>
                                                                    {isSelected ? (
                                                                        <Check className="h-4 w-4" />
                                                                    ) : (
                                                                        <X className="h-4 w-4 opacity-30" />
                                                                    )}
                                                                </button>
                                                            );
                                                        }
                                                    )}
                                                </div>
                                            </div>
                                        );
                                    })}
                                </div>
                            )}
                        </CardContent>
                    </Card>
                </div>
            </div>
        </MainLayout>
    );
}
