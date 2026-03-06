import { createRoot } from "react-dom/client";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import Login from "./components/Login";
import DashboardApp from "./components/DashboardApp";
import DashboardPage from "./components/Dashboard/DashboardPage";
import UserList from "./components/Usuarios/UserList";
import RolePermissions from "./components/Configuracion/RolePermissions";
import VentasList from "./components/Facturacion/Ventas/VentasList";
import VentaForm from "./components/Facturacion/Ventas/VentaForm";
import CotizacionesList from "./components/Cotizaciones/CotizacionesList";
import CotizacionForm from "./components/Cotizaciones/CotizacionForm";
import ClientsList from "./components/Clientes/ClientsList";
import MisEmpresas from "./components/Empresas/MisEmpresas";
import ProductosList from "./components/Almacen/ProductosList";
import MovimientosStockList from "./components/Almacen/MovimientosStock/page";
import NotFound from "./components/NotFound";
import Compras from "./components/Compras/Compras";
import CompraForm from "./components/Compras/CompraForm";
import ProveedoresList from "./components/Proveedores/ProveedoresList";
import GuiaRemision from "./components/GuiaRemision/page";
import GuiaRemisionForm from "./components/GuiaRemision/GuiaRemisionForm";
import NotaCredito from "./components/NotaCredito/page";
import NotaCreditoForm from "./components/NotaCredito/NotaCreditoForm";
import ConsultaComprobante from "./components/Consulta/ConsultaComprobante";
import Inicio from "./components/Inicio/Inicio";
import PlantillaImpresion from "./components/Configuracion/PlantillaImpresion";
import CuentasPorCobrar from "./components/Finanzas/CuentasPorCobrar/CuentasPorCobrar";
import CuentasPorPagar from "./components/Finanzas/CuentasPorPagar/CuentasPorPagar";
import BancosList from "./components/Finanzas/Bancos/BancosList";
import MetodosPagoList from "./components/Finanzas/MetodosPago/MetodosPagoList";
import CajasList from "./components/Finanzas/Caja/CajasList";
import CuentasBancariasList from "./components/Finanzas/CuentasBancarias/CuentasBancariasList";
import UtilidadesPage from "./components/Finanzas/Utilidades/UtilidadesPage";
import { TransportistasPage } from "./components/GuiaRemisionTransportista/Transportistas/TransportistasPage";
import { TransportistaAddPage } from "./components/GuiaRemisionTransportista/Transportistas/TransportistaAddPage";
import GuiaRemisionTransportista from "./components/GuiaRemisionTransportista/GuiaRemisionTransportistaPage";
import GuiaRemisionTransportistaForm from "./components/GuiaRemisionTransportista/GuiaRemisionTransportistaForm";

import "./bootstrap";
import "../css/app.css";
import "../css/select-custom.css";

// Crear QueryClient
const queryClient = new QueryClient({
    defaultOptions: {
        queries: {
            staleTime: 1000 * 60 * 5, // 5 minutos
            gcTime: 1000 * 60 * 10, // 10 minutos
        },
    },
});

// Registrar componentes disponibles para montado desde Blade
const components = {
    Login,
    DashboardApp,
    DashboardPage,
    NotFound,
    UserList,
    RolePermissions,
    VentasList,
    CotizacionesList,
    CotizacionForm,
    VentaForm,
    ClientsList,
    MisEmpresas,
    ProductosList,
    MovimientosStockList,
    Compras,
    CompraForm,
    ProveedoresList,
    GuiaRemision,
    GuiaRemisionForm,
    NotaCredito,
    NotaCreditoForm,
    ConsultaComprobante,
    Inicio,
    PlantillaImpresion,
    CuentasPorCobrar,
    CuentasPorPagar,
    BancosList,
    MetodosPagoList,
    CajasList,
    CuentasBancariasList,
    UtilidadesPage,
    TransportistasPage,
    TransportistaAddPage,
    GuiaRemisionTransportista,
    GuiaRemisionTransportistaForm,
};

// Monta cada elemento con atributo data-react-component
function mountAll() {
    document.querySelectorAll("[data-react-component]").forEach((el) => {
        const name = el.getAttribute("data-react-component");
        const propsAttr = el.getAttribute("data-props") || "{}";
        let props = {};
        try {
            props = JSON.parse(propsAttr);
        } catch (e) {
            console.warn("No se pudo parsear data-props para", name, e);
        }
        const Component = components[name];
        if (!Component) {
            console.warn(`Componente React "${name}" no encontrado.`);
            return;
        }
        createRoot(el).render(
            <QueryClientProvider client={queryClient}>
                <Component {...props} />
            </QueryClientProvider>
        );
    });
}

// Montamos al cargar el DOM
if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", mountAll);
} else {
    mountAll();
}
