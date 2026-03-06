# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Peruvian electronic invoicing system (facturación electrónica) for **Santo Domingo** — forked from `factura_ilidesava`. Built with Laravel 12 + React 19. Integrates with SUNAT (Peru's tax authority) for issuing facturas, boletas, notas de crédito/débito, and guías de remisión. Uses the Greenter PHP library for SUNAT XML generation and submission.

**Key differences from the original (ilidesava):**
- Single-company system (only `id_empresa = 1`). Company selector in header is disabled; "Nueva Empresa" button is commented out. All users must have `id_empresa = 1`.
- Color scheme: primary = red (`#c7161d`), accent/text = cream (`#ece6a3`) — defined in `resources/css/app.css`
- Database: MySQL `factura_santoD` (not SQLite)

## Development Commands

```bash
composer dev          # Start full dev stack (Laravel server + queue + logs + Vite HMR)
composer setup        # Initial setup (install, migrate, build)
composer test         # Run PHPUnit tests (uses SQLite in-memory)
npm run dev           # Vite dev server only
npm run build         # Production build
php artisan serve     # Laravel server only
php artisan migrate   # Run pending migrations
php artisan pint      # Code formatting (Laravel Pint)

# Run a single test or filter by name
php artisan test --filter TestName
php artisan test tests/Feature/ExampleTest.php

# Run a single migration
php artisan migrate --path=database/migrations/FILENAME.php
```

> **Note:** The queue worker (`php artisan queue:listen`) is required for async SUNAT operations (Resumen Diario, Comunicación de Baja). `composer dev` starts it automatically.

## Architecture

### Rendering Model
This is NOT a typical SPA. Blade templates mount React components via `data-react-component` attributes. Each page is a Blade view that renders a specific React component. Navigation between pages is full page loads, not client-side routing. See `resources/js/app.jsx` for the component registry.

### Database
Default database is MySQL (`factura_santoD`). Tests use SQLite in-memory (configured in `phpunit.xml`).

**Important:** The `empresas.id_empresa` column is `int` (signed). Any new table with an `id_empresa` foreign key must use `$table->integer('id_empresa')` — NOT `unsignedInteger`, or the FK constraint will fail with error 3780.

### Backend Structure
- **Controllers** handle API endpoints. SUNAT-related controllers (VentasController, NotaCreditoController, GuiaRemisionController, etc.) delegate XML generation and submission to `SunatService`.
- **`app/Services/SunatService.php`** (~700+ lines) is the core service. It builds Greenter objects, generates XML, signs with certificates, sends to SUNAT, and processes CDR responses. All SUNAT document types are handled here.
- **`app/Services/ProductoService.php`** handles stock movement logic (entries, exits, adjustments) used across ventas and compras.
- **Caja services** use interfaces (`CajaServiceInterface`, `CajaSesionServiceInterface`, `CajaArqueoServiceInterface`) for cash register business logic.
- **PDF controllers** (e.g., `VentaPdfController`, `GuiaRemisionPdfController`) serve reports via web routes using mPDF. These routes use the `TokenFromQuery` middleware to accept `?token=` in the URL for browser-based PDF downloads.
- **SUNAT submission flows differ by document type:**
  - Facturas/Boletas/Notas: Synchronous via SOAP — `sendXml()` returns CDR immediately
  - Guías de Remisión: Async via REST (GRE API) — `enviar()` returns a ticket, then `consultarTicket()` polls for CDR
  - Boletas also require Resumen Diario for SUNAT acceptance
  - Annulment uses Comunicación de Baja (async with tickets)
- **Permission middleware** `CheckPermission` uses format `resource.action` (e.g., `ventas.create`, `productos.view`, `cuentas-cobrar.edit`, `caja.open`). Admin (rol_id=1) bypasses all checks.
- **Single-company**: This fork uses only one empresa (`id_empresa = 1`). The multi-company switching UI is disabled, but the underlying scoping on the User model still works. All queries scope by `id_empresa`.

### Frontend Structure
- **Feature-based organization** under `resources/js/components/` — each module (Ventas, GuiaRemision, NotaCredito, Finanzas, etc.) has its own folder with page component, form, columns definition, detail modal, and hooks.
- **Pattern for list pages**: `page.jsx` (list + DataTable + modal) → `columns/` (column definitions with action buttons) → `hooks/` (data fetching + API calls). For filtering, use pill buttons (like Productos/Finanzas) + DataTable's built-in `searchable` prop — do NOT add separate search inputs.
- **UI primitives** in `resources/js/components/ui/` — modal, button, input, select, data-table, etc. Built on Radix UI + Tailwind CSS. Always use these components (e.g., `Select` from `@/components/ui/select`) instead of native HTML elements.
- **Shared components** in `resources/js/components/shared/` — `PaymentSchedule.jsx` (installment plan modal), `ClienteAutocomplete.jsx`, `ProveedorAutocomplete.jsx`, `TransportistaAutocomplete.jsx`, `MetodoPago.jsx`.
- **API communication** in `resources/js/services/` — thin wrappers around fetch that attach the auth token. Hooks call these services; they don't call the API directly.
- **Path alias**: `@` maps to `resources/js/` (configured in vite.config.js)
- **State management**: Zustand stores in `resources/js/stores/`
- **Key libraries**: TanStack React Query (data fetching/caching, 5min stale time), TanStack React Table (DataTable), Recharts (dashboard charts), SweetAlert2 (confirmation dialogs), Quill (rich text editor), jsPDF + html2canvas (client-side PDF), Lucide React (icons)
- **Auth tokens**: Stored in `localStorage` as `auth_token`, sent via `Authorization: Bearer` header. PDF download links pass the token as `?token=` query param (handled server-side by `TokenFromQuery` middleware).
- **Sidebar navigation** is data-driven from `resources/js/data/menuModules.json`. Icons come from lucide-react and must be registered in `Sidebar.jsx`'s `iconMap`.

### Module Map
| Module | Backend | Frontend | DB Tables |
|--------|---------|----------|-----------|
| Facturación: Ventas | VentasController, SunatService | Facturacion/Ventas/ | ventas, detalle_ventas, dias_ventas |
| Facturación: Notas | NotaCreditoController | NotaCredito/ | (same as ventas) |
| Facturación: Guías | GuiaRemisionController | GuiaRemision/ | guia_remisions, detalle_guia_remisions |
| Guías Transportista | GuiaRemisionTransportistaController | GuiaRemisionTransportista/ | guia_remision_transportistas |
| Cotizaciones | CotizacionController | Cotizaciones/ | cotizaciones, detalle_cotizaciones |
| Compras | ComprasController | Compras/ | compras, detalle_compras, dias_compras |
| Clientes | ClienteController | Clientes/ | clientes |
| Proveedores | ProveedorController | Proveedores/ | proveedores |
| Productos | ProductosController, ProductoService | Almacen/ | productos, movimientos_stock |
| Finanzas: CxC | CuentasPorCobrarController | Finanzas/CuentasPorCobrar/ | dias_ventas (estados P/C/V) |
| Finanzas: CxP | CuentasPorPagarController | Finanzas/CuentasPorPagar/ | dias_compras (estados 1/0) |
| Finanzas: Caja | Api/CajaController | Finanzas/Caja/ | cajas, movimientos_caja, arqueos_diarios, apertura/cierre_caja_billetes |
| Finanzas: Bancos | Api/BancoController | Finanzas/Bancos/ | bancos, cuentas_bancarias, movimientos_bancarios |
| Finanzas: Métodos de Pago | Api/MetodoPagoController | Finanzas/MetodosPago/ | metodos_pago, caja_metodos_pago |
| Finanzas: Utilidades | — | Finanzas/Utilidades/ | (calculated from ventas/compras) |
| Usuarios | UserController | Usuarios/ | users |
| Configuración | RolPermisoController | Configuracion/ | roles, permisos, rol_permisos |

### File Storage
SUNAT files stored under `storage/app/sunat/`:
- `xml/{ruc}/` — Generated XML documents
- `cdr/{ruc}/` — CDR (Constancia de Recepción) ZIP files from SUNAT
- `certificados/` — Digital certificates (.pem) for XML signing

### Key Configuration
- `config/sunat.php` — SUNAT endpoints (beta/production), IGV rate, SOL credentials, storage paths
- Beta testing uses RUC `20000000001` with credentials `MODDATOS/moddatos`
- GRE API (guías) requires separate OAuth client credentials (`SUNAT_GRE_CLIENT_ID`, `SUNAT_GRE_CLIENT_SECRET`)

## Conventions

- Backend language: PHP code, variable names, database columns, and API responses are in **Spanish**
- Frontend: Component names in English (PascalCase), but labels, messages, and field names in Spanish
- SUNAT document naming: `{RUC}-{tipoDoc}-{serie}-{numero}.xml` (e.g., `20612706702-09-T001-00000001.xml`)
- CDR files prefixed with `R-` (e.g., `R-20612706702-09-T001-00000001.zip`)
- Database uses `id_empresa` for company scoping across all main tables
- Series format: `F001` (factura), `B001` (boleta), `FC01`/`BC01` (notas de crédito), `T001` (guías)
- PDF reports served via web routes (`/reporteNV/`, `/reporteGR/`, etc.) using mPDF
- Excel exports use PhpSpreadsheet with styled headers and alternating row colors
- Caja permissions are per-user (not role-based): `puede_abrir_caja`, `puede_cerrar_caja`, `puede_autorizar_cierre`, `puede_registrar_movimientos`, `puede_ver_reportes`
- New React components must be registered in `resources/js/app.jsx`'s `components` object AND have a corresponding Blade view with `data-react-component` attribute
- QR codes on invoices use `chillerlan/php-qrcode`
- Export controllers live in `app/Http/Controllers/Exports/` (Excel) and `app/Http/Controllers/Reportes/` (PDF)
