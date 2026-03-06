import { useState, useEffect } from "react";
import Sidebar from "./Sidebar";
import Header from "./Header";
import Loader from "../Loader";
import { useLoadPermissions } from "@/hooks/usePermissions";
import { baseUrl } from "@/lib/baseUrl";
import BASE_URL from "@/lib/baseUrl";

export default function MainLayout({
    children,
    currentPath = (window.location.pathname + window.location.search).replace(new RegExp(`^${BASE_URL}`), '') || '/',
}) {
    const [isSidebarOpen, setIsSidebarOpen] = useState(false);
    const [isCollapsed, setIsCollapsed] = useState(() => {
        const saved = localStorage.getItem('sidebar-collapsed');
        return saved === 'true';
    });
    const [authChecked, setAuthChecked] = useState(false);
    const { loadPermissions } = useLoadPermissions();

    useEffect(() => {
        const token = localStorage.getItem("auth_token");
        if (!token) {
            window.location.replace(baseUrl("/login"));
            return;
        }

        fetch(baseUrl("/api/verify"), {
            headers: {
                Authorization: `Bearer ${token}`,
                Accept: "application/json",
            },
        })
            .then((res) => {
                if (res.ok) {
                    setAuthChecked(true);
                    loadPermissions();
                } else {
                    localStorage.removeItem("auth_token");
                    localStorage.removeItem("user");
                    window.location.replace(baseUrl("/login"));
                }
            })
            .catch(() => {
                localStorage.removeItem("auth_token");
                localStorage.removeItem("user");
                window.location.replace(baseUrl("/login"));
            });
    }, []);

    const toggleSidebar = () => {
        setIsSidebarOpen(!isSidebarOpen);
    };

    const toggleCollapse = () => {
        const newState = !isCollapsed;
        setIsCollapsed(newState);
        // Guardar el estado en localStorage
        localStorage.setItem('sidebar-collapsed', newState.toString());
    };

    if (!authChecked) {
        return <Loader text="Verificando sesión..." variant="dual" />;
    }

    return (
        <div className="min-h-screen bg-white">
            {/* Sidebar */}
            <Sidebar
                isOpen={isSidebarOpen}
                isCollapsed={isCollapsed}
                currentPath={currentPath}
                toggleCollapse={toggleCollapse}
            />

            {/* Overlay para mobile */}
            {isSidebarOpen && (
                <div
                    className="fixed inset-0 bg-black/50 z-30 lg:hidden"
                    onClick={toggleSidebar}
                ></div>
            )}

            {/* Main Content Area */}
            <div
                className={`transition-all duration-300 ${isCollapsed ? "lg:ml-20" : "lg:ml-64"
                    }`}
            >
                {/* Header */}
                <Header
                    toggleSidebar={toggleSidebar}
                    isSidebarOpen={isSidebarOpen}
                    isCollapsed={isCollapsed}
                />

                {/* Page Content */}
                <main className="pt-16 min-h-screen">
                    <div className="px-6 pt-4 pb-6">{children}</div>
                </main>
            </div>
        </div>
    );
}
