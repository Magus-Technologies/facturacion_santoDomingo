import { useState, useEffect } from 'react';
import { useQuery } from '@tanstack/react-query';
import MainLayout from '@/components/Layout/MainLayout';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Badge } from '@/components/ui/badge';
import {
    Select, SelectContent, SelectItem, SelectTrigger, SelectValue,
} from '@/components/ui/select';
import {
    Card, CardHeader, CardTitle, CardDescription, CardContent,
} from '@/components/ui/card';
import {
    Table, TableBody, TableCell, TableHead, TableHeader, TableRow,
} from '@/components/ui/table';
import {
    Loader2, ArrowLeft, Plus, Trash2, Truck, MapPin,
    User, Package, Building2, Search, FileText,
} from 'lucide-react';
import { toast } from '@/lib/sweetalert';
import ClienteAutocomplete from '@/components/shared/ClienteAutocomplete';
import { consultarDNI, consultarRUC } from '@/services/apisPeru';
import api from '@/services/api';
import { baseUrl } from "@/lib/baseUrl";

// ─── constantes ──────────────────────────────────────────────────────────────

const TIPOS_DOC_REMITENTE = [
    { value: '1', label: 'DNI' },
    { value: '6', label: 'RUC' },
];

const TIPOS_DOC_CONDUCTOR = [
    { value: '1', label: 'DNI' },
    { value: '4', label: 'Carnet de extranjería' },
];

// ─── componente principal ─────────────────────────────────────────────────────

export default function GuiaRemisionTransportistaForm() {
    const [submitting, setSubmitting] = useState(false);
    const [errors, setErrors] = useState({});
    const [proximoNumero, setProximoNumero] = useState(null);

    // Remitente
    const [remitente, setRemitente] = useState({
        tipo_doc: '6',
        documento: '',
        nombre: '',
        direccion: '',
        ubigeo: '',
    });
    const [consultandoRemitente, setConsultandoRemitente] = useState(false);

    // Destinatario
    const [clienteNombre, setClienteNombre] = useState('');
    const [destinatario, setDestinatario] = useState({
        tipo_doc: '6',
        documento: '',
        nombre: '',
        direccion: '',
        ubigeo: '',
    });

    // Partida
    const [partida, setPartida] = useState({
        direccion: '',
        ubigeo: '',
    });

    // Form lateral
    const [form, setForm] = useState({
        motivo_traslado: '',
        descripcion_motivo: '',
        fecha_traslado: new Date().toISOString().split('T')[0],
        peso_total: '',
        und_peso_total: 'KGM',
        observaciones: '',
        // Conductor
        conductor_tipo_doc: '1',
        conductor_documento: '',
        conductor_nombres: '',
        conductor_apellidos: '',
        conductor_licencia: '',
        // Vehículo
        vehiculo_placa: '',
        vehiculo_placa_secundaria: '',
    });

    const [detalles, setDetalles] = useState([
        { codigo: '', descripcion: '', cantidad: '1', unidad: 'NIU' },
    ]);

    const [consultandoConductor, setConsultandoConductor] = useState(false);

    // ── motivos ───────────────────────────────────────────────────────────────

    const { data: motivos = [] } = useQuery({
        queryKey: ['motivos-traslado-transportista'],
        queryFn: async () => {
            const res = await api.get('/guias-remision-transportista/motivos');
            return res.data;
        },
        staleTime: Infinity,
    });

    // ── próximo número + empresa ──────────────────────────────────────────────

    useEffect(() => {
        api.get('/guias-remision-transportista/proximo-numero')
            .then((res) => { if (res.data?.success) setProximoNumero(res.data); })
            .catch(() => {});

        api.get('/guias-remision/empresa')
            .then((res) => {
                const emp = res.data?.data;
                if (emp?.direccion) {
                    setPartida((prev) => ({
                        direccion: prev.direccion || emp.direccion,
                        ubigeo:    prev.ubigeo    || emp.ubigeo || '',
                    }));
                }
            })
            .catch(() => {});
    }, []);

    // ── consulta RUC remitente ────────────────────────────────────────────────

    const handleConsultarRemitente = async () => {
        const doc = remitente.documento.trim();
        if (remitente.tipo_doc === '6' && doc.length !== 11) {
            toast.warning('Ingrese un RUC válido (11 dígitos)');
            return;
        }
        if (remitente.tipo_doc === '1' && doc.length !== 8) {
            toast.warning('Ingrese un DNI válido (8 dígitos)');
            return;
        }
        setConsultandoRemitente(true);
        try {
            const fn = remitente.tipo_doc === '6' ? consultarRUC : consultarDNI;
            const result = await fn(doc);
            if (result.success) {
                const nombre = result.data.razonSocial
                    || `${result.data.nombres || ''} ${result.data.apellidoPaterno || ''} ${result.data.apellidoMaterno || ''}`.trim();
                setRemitente((prev) => ({ ...prev, nombre }));
                toast.success('Encontrado');
            } else {
                toast.error(result.message || 'No encontrado');
            }
        } catch {
            toast.error('Error al consultar');
        }
        setConsultandoRemitente(false);
    };

    // ── consulta DNI conductor ────────────────────────────────────────────────

    const handleConsultarConductor = async () => {
        const dni = form.conductor_documento.trim();
        if (dni.length !== 8) {
            toast.warning('Ingrese un DNI válido (8 dígitos)');
            return;
        }
        setConsultandoConductor(true);
        try {
            const result = await consultarDNI(dni);
            if (result.success) {
                setForm((prev) => ({
                    ...prev,
                    conductor_nombres:   result.data.nombres || '',
                    conductor_apellidos: `${result.data.apellidoPaterno || ''} ${result.data.apellidoMaterno || ''}`.trim(),
                }));
                toast.success('DNI encontrado');
            } else {
                toast.error(result.message || 'DNI no encontrado');
            }
        } catch {
            toast.error('Error al consultar DNI');
        }
        setConsultandoConductor(false);
    };

    // ── destinatario ──────────────────────────────────────────────────────────

    const handleClienteSelect = (cliente) => {
        const doc = cliente.documento || '';
        const tipDoc = cliente.tipo_doc || (doc.length === 11 ? '6' : doc.length === 8 ? '1' : '4');
        setDestinatario({
            tipo_doc:  tipDoc,
            documento: doc,
            nombre:    cliente.datos || '',
            direccion: cliente.direccion || '',
            ubigeo:    cliente.ubigeo || '',
        });
        setClienteNombre(cliente.datos || '');
        if (errors.destinatario) setErrors((prev) => ({ ...prev, destinatario: undefined }));
    };

    // ── form helpers ──────────────────────────────────────────────────────────

    const handleChange = (field, value) => {
        setForm((prev) => ({ ...prev, [field]: value }));
        if (errors[field]) setErrors((prev) => ({ ...prev, [field]: undefined }));
    };

    const handleDetalleChange = (idx, field, value) => {
        setDetalles((prev) => {
            const copy = [...prev];
            copy[idx] = { ...copy[idx], [field]: value };
            return copy;
        });
    };

    const addDetalle = () => setDetalles((prev) => [...prev, { codigo: '', descripcion: '', cantidad: '1', unidad: 'NIU' }]);

    const removeDetalle = (idx) => {
        if (detalles.length <= 1) return;
        setDetalles((prev) => prev.filter((_, i) => i !== idx));
    };

    // ── submit ────────────────────────────────────────────────────────────────

    const handleSubmit = async (e) => {
        e?.preventDefault();

        const newErrors = {};
        if (!remitente.documento?.trim()) newErrors.remitente_documento = 'El documento del remitente es requerido';
        if (!remitente.nombre?.trim())    newErrors.remitente_nombre    = 'El nombre del remitente es requerido';
        if (!remitente.direccion?.trim()) newErrors.remitente_direccion = 'La dirección del remitente es requerida';
        if (!destinatario.documento)      newErrors.destinatario        = 'Seleccione un destinatario';
        if (!destinatario.direccion?.trim()) newErrors.dir_llegada      = 'La dirección de llegada es requerida';
        if (!partida.direccion?.trim())   newErrors.dir_partida         = 'La dirección de partida es requerida';
        if (!form.motivo_traslado)        newErrors.motivo_traslado     = 'Seleccione el motivo';
        if (!form.fecha_traslado)         newErrors.fecha_traslado      = 'La fecha es requerida';
        if (!form.peso_total || parseFloat(form.peso_total) <= 0) newErrors.peso_total = 'Ingrese el peso total';
        if (!form.conductor_documento?.trim()) newErrors.conductor_documento = 'El documento del conductor es requerido';
        if (!form.conductor_nombres?.trim())   newErrors.conductor_nombres   = 'Los nombres del conductor son requeridos';
        if (!form.conductor_apellidos?.trim()) newErrors.conductor_apellidos = 'Los apellidos del conductor son requeridos';
        if (!form.conductor_licencia?.trim())  newErrors.conductor_licencia  = 'La licencia es requerida';
        if (!form.vehiculo_placa?.trim())      newErrors.vehiculo_placa      = 'La placa del vehículo es requerida';

        const detallesValidos = detalles.filter((d) => d.descripcion && parseFloat(d.cantidad) > 0);
        if (detallesValidos.length === 0) newErrors.detalles = 'Agregue al menos un ítem';

        if (Object.keys(newErrors).length > 0) {
            setErrors(newErrors);
            toast.error('Complete los campos requeridos');
            return;
        }
        setErrors({});

        setSubmitting(true);
        try {
            await api.post('/guias-remision-transportista', {
                ...form,
                remitente_tipo_doc:  remitente.tipo_doc,
                remitente_documento: remitente.documento,
                remitente_nombre:    remitente.nombre,
                remitente_direccion: remitente.direccion,
                remitente_ubigeo:    remitente.ubigeo,
                destinatario_tipo_doc:   destinatario.tipo_doc,
                destinatario_documento:  destinatario.documento,
                destinatario_nombre:     destinatario.nombre,
                dir_llegada:  destinatario.direccion,
                ubigeo_llegada: destinatario.ubigeo,
                dir_partida:  partida.direccion,
                ubigeo_partida: partida.ubigeo,
                peso_total: parseFloat(form.peso_total),
                detalles: detallesValidos.map((d) => ({
                    ...d,
                    cantidad: parseFloat(d.cantidad),
                })),
            });
            toast.success('Guía de remisión transportista creada y XML generado');
            window.location.href = baseUrl('/guia-remision-transportista');
        } catch (err) {
            if (err.response?.status === 422) {
                setErrors(err.response.data.errors || {});
                toast.error('Corrija los errores en el formulario');
            } else {
                toast.error(err.response?.data?.message || 'Error al crear la guía');
            }
        } finally {
            setSubmitting(false);
        }
    };

    // ─────────────────────────────────────────────────────────────────────────

    return (
        <MainLayout>
            {/* Header */}
            <div className="mb-6">
                <div className="flex items-center justify-between">
                    <div>
                        <nav className="text-sm text-gray-500 mb-2">
                            <a href={baseUrl("/guia-remision-transportista")} className="hover:text-primary-600">
                                GR Transportista
                            </a>
                            <span className="mx-2">/</span>
                            <span className="text-gray-900">Nueva</span>
                        </nav>
                        <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-3">
                            Nueva Guía de Remisión Transportista
                            {proximoNumero && (
                                <span className="text-sm font-mono px-3 py-1 rounded-md bg-gray-100 text-gray-700 border border-gray-300">
                                    {proximoNumero.numero_completo}
                                </span>
                            )}
                        </h1>
                    </div>
                    <div className="flex gap-3">
                        <Button onClick={handleSubmit} disabled={submitting} className="gap-2">
                            {submitting && <Loader2 className="h-4 w-4 animate-spin" />}
                            Crear Guía
                        </Button>
                        <Button variant="outline" onClick={() => (window.location.href = baseUrl('/guia-remision-transportista'))}>
                            <ArrowLeft className="h-4 w-4 mr-2" />
                            Regresar
                        </Button>
                    </div>
                </div>
            </div>

            <form onSubmit={handleSubmit} className="grid grid-cols-1 lg:grid-cols-12 gap-4">

                {/* ── Columna principal ──────────────────────────────────── */}
                <div className="lg:col-span-8 space-y-4">

                    {/* Remitente */}
                    <Card>
                        <CardHeader className="pb-3">
                            <CardTitle className="flex items-center gap-2 text-base">
                                <Building2 className="h-4 w-4 text-orange-600" />
                                Remitente
                            </CardTitle>
                            <CardDescription>Empresa o persona que envía la mercadería</CardDescription>
                        </CardHeader>
                        <CardContent className="space-y-3">
                            <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1 block">Tipo Doc. *</Label>
                                    <Select
                                        value={remitente.tipo_doc}
                                        onValueChange={(v) => setRemitente((prev) => ({ ...prev, tipo_doc: v }))}
                                    >
                                        <SelectTrigger><SelectValue /></SelectTrigger>
                                        <SelectContent>
                                            {TIPOS_DOC_REMITENTE.map((t) => (
                                                <SelectItem key={t.value} value={t.value}>{t.label}</SelectItem>
                                            ))}
                                        </SelectContent>
                                    </Select>
                                </div>
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1 block">
                                        Número de Documento *
                                    </Label>
                                    <div className="flex gap-1">
                                        <Input
                                            value={remitente.documento}
                                            onChange={(e) => setRemitente((prev) => ({ ...prev, documento: e.target.value.replace(/\D/g, '') }))}
                                            onKeyDown={(e) => { if (e.key === 'Enter') { e.preventDefault(); handleConsultarRemitente(); } }}
                                            placeholder={remitente.tipo_doc === '6' ? '20xxxxxxxxx' : '12345678'}
                                            maxLength={remitente.tipo_doc === '6' ? 11 : 8}
                                            className={errors.remitente_documento ? 'border-red-500' : ''}
                                        />
                                        <Button
                                            type="button"
                                            size="icon"
                                            onClick={handleConsultarRemitente}
                                            disabled={consultandoRemitente}
                                            className="shrink-0"
                                        >
                                            {consultandoRemitente ? <Loader2 className="h-4 w-4 animate-spin" /> : <Search className="h-4 w-4" />}
                                        </Button>
                                    </div>
                                    {errors.remitente_documento && <p className="text-xs text-red-600 mt-1">{errors.remitente_documento}</p>}
                                </div>
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1 block">Razón Social / Nombre *</Label>
                                    <Input
                                        value={remitente.nombre}
                                        onChange={(e) => setRemitente((prev) => ({ ...prev, nombre: e.target.value }))}
                                        placeholder="VIÑA SANTO DOMINGO SAC"
                                        className={errors.remitente_nombre ? 'border-red-500' : ''}
                                    />
                                    {errors.remitente_nombre && <p className="text-xs text-red-600 mt-1">{errors.remitente_nombre}</p>}
                                </div>
                            </div>
                            <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1 block">
                                        Dirección <span className="text-red-500">*</span>
                                    </Label>
                                    <Input
                                        value={remitente.direccion}
                                        onChange={(e) => {
                                            setRemitente((prev) => ({ ...prev, direccion: e.target.value }));
                                            if (errors.remitente_direccion) setErrors((prev) => ({ ...prev, remitente_direccion: undefined }));
                                        }}
                                        placeholder="Av. Principal 123, Lima"
                                        className={errors.remitente_direccion ? 'border-red-500' : ''}
                                    />
                                    {errors.remitente_direccion && <p className="text-xs text-red-600 mt-1">{errors.remitente_direccion}</p>}
                                </div>
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1 block">Ubigeo</Label>
                                    <Input
                                        value={remitente.ubigeo}
                                        onChange={(e) => setRemitente((prev) => ({ ...prev, ubigeo: e.target.value }))}
                                        placeholder="150101"
                                        maxLength={6}
                                    />
                                </div>
                            </div>
                        </CardContent>
                    </Card>

                    {/* Destinatario */}
                    <Card>
                        <CardHeader className="pb-3">
                            <CardTitle className="flex items-center gap-2 text-base">
                                <User className="h-4 w-4 text-blue-600" />
                                Destinatario
                            </CardTitle>
                            <CardDescription>Busca por nombre o RUC/DNI</CardDescription>
                        </CardHeader>
                        <CardContent className="space-y-3">
                            <ClienteAutocomplete
                                onClienteSelect={handleClienteSelect}
                                value={clienteNombre}
                                placeholder="Buscar por nombre, RUC o DNI..."
                                initialTipoDoc={destinatario.tipo_doc}
                            />
                            {errors.destinatario && !destinatario.documento && (
                                <p className="text-xs text-red-600 mt-1">{errors.destinatario}</p>
                            )}
                            {destinatario.documento && (
                                <div className="grid grid-cols-1 md:grid-cols-3 gap-3 bg-gray-50 rounded-lg p-3">
                                    <div>
                                        <p className="text-xs text-gray-500">Tipo Doc.</p>
                                        <p className="text-sm font-medium text-gray-900">
                                            {destinatario.tipo_doc === '6' ? 'RUC' : destinatario.tipo_doc === '4' ? 'CE' : 'DNI'}
                                        </p>
                                    </div>
                                    <div>
                                        <p className="text-xs text-gray-500">N° Documento</p>
                                        <p className="text-sm font-medium text-gray-900">{destinatario.documento}</p>
                                    </div>
                                    <div>
                                        <p className="text-xs text-gray-500">Razón Social / Nombre</p>
                                        <p className="text-sm font-medium text-gray-900">{destinatario.nombre}</p>
                                    </div>
                                    <div className="md:col-span-3">
                                        <Label className="text-xs text-gray-500 flex items-center gap-1">
                                            <MapPin className="h-3 w-3 text-red-500" />
                                            Dirección de llegada <span className="text-red-500">*</span>
                                        </Label>
                                        <Input
                                            value={destinatario.direccion}
                                            onChange={(e) => {
                                                setDestinatario((prev) => ({ ...prev, direccion: e.target.value }));
                                                if (errors.dir_llegada) setErrors((prev) => ({ ...prev, dir_llegada: undefined }));
                                            }}
                                            placeholder="Ingrese la dirección de destino"
                                            className={`mt-1 ${errors.dir_llegada ? 'border-red-500' : ''}`}
                                        />
                                        {errors.dir_llegada && <p className="text-xs text-red-600 mt-1">{errors.dir_llegada}</p>}
                                    </div>
                                    <div>
                                        <Label className="text-xs text-gray-500 mb-1 block">Ubigeo llegada</Label>
                                        <Input
                                            value={destinatario.ubigeo}
                                            onChange={(e) => setDestinatario((prev) => ({ ...prev, ubigeo: e.target.value }))}
                                            placeholder="150101"
                                            maxLength={6}
                                        />
                                    </div>
                                </div>
                            )}
                        </CardContent>
                    </Card>

                    {/* Punto de partida */}
                    <Card>
                        <CardHeader className="pb-3">
                            <CardTitle className="flex items-center gap-2 text-sm">
                                <Building2 className="h-4 w-4 text-orange-600" />
                                Punto de Partida
                            </CardTitle>
                        </CardHeader>
                        <CardContent className="space-y-3">
                            <div>
                                <Label className="text-xs text-gray-500 mb-1 block">
                                    Dirección de partida <span className="text-red-500">*</span>
                                </Label>
                                <Input
                                    value={partida.direccion}
                                    onChange={(e) => {
                                        setPartida((prev) => ({ ...prev, direccion: e.target.value }));
                                        if (errors.dir_partida) setErrors((prev) => ({ ...prev, dir_partida: undefined }));
                                    }}
                                    placeholder="Av. Principal 123, Lima"
                                    className={errors.dir_partida ? 'border-red-500' : ''}
                                />
                                {errors.dir_partida && <p className="text-xs text-red-600 mt-1">{errors.dir_partida}</p>}
                            </div>
                            <div>
                                <Label className="text-xs text-gray-500 mb-1 block">Ubigeo partida</Label>
                                <Input
                                    value={partida.ubigeo}
                                    onChange={(e) => setPartida((prev) => ({ ...prev, ubigeo: e.target.value }))}
                                    placeholder="150101"
                                    maxLength={6}
                                    className="max-w-[120px]"
                                />
                            </div>
                        </CardContent>
                    </Card>

                    {/* Conductor */}
                    <Card>
                        <CardHeader className="pb-3">
                            <CardTitle className="flex items-center gap-2 text-base">
                                <User className="h-4 w-4 text-purple-600" />
                                Conductor y Vehículo
                            </CardTitle>
                        </CardHeader>
                        <CardContent className="space-y-4">
                            <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1 block">Tipo Doc. *</Label>
                                    <Select
                                        value={form.conductor_tipo_doc}
                                        onValueChange={(v) => handleChange('conductor_tipo_doc', v)}
                                    >
                                        <SelectTrigger><SelectValue /></SelectTrigger>
                                        <SelectContent>
                                            {TIPOS_DOC_CONDUCTOR.map((t) => (
                                                <SelectItem key={t.value} value={t.value}>{t.label}</SelectItem>
                                            ))}
                                        </SelectContent>
                                    </Select>
                                </div>
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1 block">Documento *</Label>
                                    <div className="flex gap-1">
                                        <Input
                                            value={form.conductor_documento}
                                            onChange={(e) => handleChange('conductor_documento', e.target.value.replace(/\D/g, ''))}
                                            onKeyDown={(e) => { if (e.key === 'Enter') { e.preventDefault(); handleConsultarConductor(); } }}
                                            placeholder="12345678"
                                            maxLength={15}
                                            className={errors.conductor_documento ? 'border-red-500' : ''}
                                        />
                                        <Button
                                            type="button"
                                            size="icon"
                                            onClick={handleConsultarConductor}
                                            disabled={consultandoConductor || form.conductor_documento.trim().length < 8}
                                            className="shrink-0"
                                        >
                                            {consultandoConductor ? <Loader2 className="h-4 w-4 animate-spin" /> : <Search className="h-4 w-4" />}
                                        </Button>
                                    </div>
                                    {errors.conductor_documento && <p className="text-xs text-red-600 mt-1">{errors.conductor_documento}</p>}
                                </div>
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1 block">Licencia *</Label>
                                    <Input
                                        value={form.conductor_licencia}
                                        onChange={(e) => handleChange('conductor_licencia', e.target.value)}
                                        placeholder="Q12345678"
                                        maxLength={20}
                                        className={errors.conductor_licencia ? 'border-red-500' : ''}
                                    />
                                    {errors.conductor_licencia && <p className="text-xs text-red-600 mt-1">{errors.conductor_licencia}</p>}
                                </div>
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1 block">Nombres *</Label>
                                    <Input
                                        value={form.conductor_nombres}
                                        onChange={(e) => handleChange('conductor_nombres', e.target.value)}
                                        placeholder="Juan Carlos"
                                        className={errors.conductor_nombres ? 'border-red-500' : ''}
                                    />
                                    {errors.conductor_nombres && <p className="text-xs text-red-600 mt-1">{errors.conductor_nombres}</p>}
                                </div>
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1 block">Apellidos *</Label>
                                    <Input
                                        value={form.conductor_apellidos}
                                        onChange={(e) => handleChange('conductor_apellidos', e.target.value)}
                                        placeholder="Pérez García"
                                        className={errors.conductor_apellidos ? 'border-red-500' : ''}
                                    />
                                    {errors.conductor_apellidos && <p className="text-xs text-red-600 mt-1">{errors.conductor_apellidos}</p>}
                                </div>
                            </div>

                            {/* Vehículo */}
                            <div className="border-t border-gray-100 pt-4 grid grid-cols-1 md:grid-cols-2 gap-3">
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1 block">Placa Principal *</Label>
                                    <Input
                                        value={form.vehiculo_placa}
                                        onChange={(e) => handleChange('vehiculo_placa', e.target.value.toUpperCase())}
                                        placeholder="ABC-123"
                                        maxLength={10}
                                        className={`uppercase ${errors.vehiculo_placa ? 'border-red-500' : ''}`}
                                    />
                                    {errors.vehiculo_placa && <p className="text-xs text-red-600 mt-1">{errors.vehiculo_placa}</p>}
                                </div>
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1 block">
                                        Placa Secundaria <span className="text-gray-400 font-normal">(semirremolque)</span>
                                    </Label>
                                    <Input
                                        value={form.vehiculo_placa_secundaria}
                                        onChange={(e) => handleChange('vehiculo_placa_secundaria', e.target.value.toUpperCase())}
                                        placeholder="XYZ-456"
                                        maxLength={20}
                                        className="uppercase"
                                    />
                                </div>
                            </div>
                        </CardContent>
                    </Card>

                    {/* Items */}
                    <Card>
                        <CardHeader className="pb-3">
                            <div className="flex items-center justify-between">
                                <CardTitle className="flex items-center gap-2 text-base">
                                    <Package className="h-4 w-4 text-amber-600" />
                                    Items a Trasladar
                                    <Badge variant="outline" className="ml-2">
                                        {detalles.length} {detalles.length === 1 ? 'ítem' : 'ítems'}
                                    </Badge>
                                </CardTitle>
                                <Button type="button" variant="outline" size="sm" onClick={addDetalle} className="gap-1">
                                    <Plus className="h-3 w-3" />
                                    Agregar
                                </Button>
                            </div>
                            {errors.detalles && <p className="text-xs text-red-600 mt-1">{errors.detalles}</p>}
                        </CardHeader>
                        <CardContent className="p-0">
                            <Table>
                                <TableHeader>
                                    <TableRow>
                                        <TableHead className="w-[40px]">#</TableHead>
                                        <TableHead className="w-[90px]">Código</TableHead>
                                        <TableHead>Descripción</TableHead>
                                        <TableHead className="w-[90px]">Cant.</TableHead>
                                        <TableHead className="w-[80px]">Und.</TableHead>
                                        <TableHead className="w-[40px]"></TableHead>
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {detalles.map((det, i) => (
                                        <TableRow key={i}>
                                            <TableCell className="text-gray-400 font-mono text-xs">
                                                {String(i + 1).padStart(2, '0')}
                                            </TableCell>
                                            <TableCell>
                                                <Input
                                                    value={det.codigo}
                                                    onChange={(e) => handleDetalleChange(i, 'codigo', e.target.value)}
                                                    placeholder="P001"
                                                    className="h-8 text-xs"
                                                />
                                            </TableCell>
                                            <TableCell>
                                                <Input
                                                    value={det.descripcion}
                                                    onChange={(e) => handleDetalleChange(i, 'descripcion', e.target.value)}
                                                    placeholder="Descripción del producto"
                                                    className="h-8 text-xs"
                                                />
                                            </TableCell>
                                            <TableCell>
                                                <Input
                                                    type="number"
                                                    step="0.001"
                                                    min="0.001"
                                                    value={det.cantidad}
                                                    onChange={(e) => handleDetalleChange(i, 'cantidad', e.target.value)}
                                                    className="h-8 text-xs"
                                                />
                                            </TableCell>
                                            <TableCell>
                                                <Select
                                                    value={det.unidad}
                                                    onValueChange={(v) => handleDetalleChange(i, 'unidad', v)}
                                                >
                                                    <SelectTrigger className="h-8 text-xs"><SelectValue /></SelectTrigger>
                                                    <SelectContent>
                                                        <SelectItem value="NIU">UND</SelectItem>
                                                        <SelectItem value="KGM">KG</SelectItem>
                                                        <SelectItem value="LTR">LT</SelectItem>
                                                        <SelectItem value="MTR">MT</SelectItem>
                                                        <SelectItem value="MTQ">M³</SelectItem>
                                                        <SelectItem value="BOX">CAJA</SelectItem>
                                                    </SelectContent>
                                                </Select>
                                            </TableCell>
                                            <TableCell>
                                                {detalles.length > 1 && (
                                                    <Button
                                                        type="button"
                                                        variant="ghost"
                                                        size="sm"
                                                        onClick={() => removeDetalle(i)}
                                                        className="h-8 w-8 p-0 text-red-500 hover:text-red-700"
                                                    >
                                                        <Trash2 className="h-3 w-3" />
                                                    </Button>
                                                )}
                                            </TableCell>
                                        </TableRow>
                                    ))}
                                </TableBody>
                            </Table>
                        </CardContent>
                    </Card>
                </div>

                {/* ── Sidebar ────────────────────────────────────────────── */}
                <div className="lg:col-span-4">
                    <Card className="sticky top-4">
                        <CardHeader>
                            <CardTitle className="flex items-center gap-2 text-base">
                                <FileText className="h-4 w-4 text-primary-600" />
                                Datos del Traslado
                            </CardTitle>
                            <CardDescription>Configure motivo, fecha y peso</CardDescription>
                        </CardHeader>
                        <CardContent className="space-y-4">
                            <div>
                                <Label className="text-xs text-gray-500 mb-1.5 block">
                                    Motivo de Traslado <span className="text-red-500">*</span>
                                </Label>
                                <Select
                                    value={form.motivo_traslado}
                                    onValueChange={(v) => handleChange('motivo_traslado', v)}
                                >
                                    <SelectTrigger className={errors.motivo_traslado ? 'border-red-500' : ''}>
                                        <SelectValue placeholder="Seleccione motivo" />
                                    </SelectTrigger>
                                    <SelectContent className="max-h-60">
                                        {motivos.map((m) => (
                                            <SelectItem key={m.codigo} value={m.codigo}>
                                                {m.codigo} - {m.descripcion}
                                            </SelectItem>
                                        ))}
                                    </SelectContent>
                                </Select>
                                {errors.motivo_traslado && <p className="text-xs text-red-600 mt-1">{errors.motivo_traslado}</p>}
                            </div>

                            <div>
                                <Label className="text-xs text-gray-500 mb-1.5 block">
                                    Fecha de Traslado <span className="text-red-500">*</span>
                                </Label>
                                <Input
                                    type="date"
                                    value={form.fecha_traslado}
                                    onChange={(e) => handleChange('fecha_traslado', e.target.value)}
                                    className={errors.fecha_traslado ? 'border-red-500' : ''}
                                />
                                {errors.fecha_traslado && <p className="text-xs text-red-600 mt-1">{errors.fecha_traslado}</p>}
                            </div>

                            <div className="grid grid-cols-2 gap-3">
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1.5 block">
                                        Peso Total <span className="text-red-500">*</span>
                                    </Label>
                                    <Input
                                        type="number"
                                        step="0.001"
                                        min="0.001"
                                        value={form.peso_total}
                                        onChange={(e) => handleChange('peso_total', e.target.value)}
                                        placeholder="0.000"
                                        className={errors.peso_total ? 'border-red-500' : ''}
                                    />
                                    {errors.peso_total && <p className="text-xs text-red-600 mt-1">{errors.peso_total}</p>}
                                </div>
                                <div>
                                    <Label className="text-xs text-gray-500 mb-1.5 block">Unidad</Label>
                                    <Select value={form.und_peso_total} onValueChange={(v) => handleChange('und_peso_total', v)}>
                                        <SelectTrigger><SelectValue /></SelectTrigger>
                                        <SelectContent>
                                            <SelectItem value="KGM">KG</SelectItem>
                                            <SelectItem value="TNE">TN</SelectItem>
                                        </SelectContent>
                                    </Select>
                                </div>
                            </div>

                            <div>
                                <Label className="text-xs text-gray-500 mb-1.5 block">
                                    Descripción motivo <span className="text-gray-400 font-normal">(opcional)</span>
                                </Label>
                                <Input
                                    value={form.descripcion_motivo}
                                    onChange={(e) => handleChange('descripcion_motivo', e.target.value)}
                                    placeholder="Detalle adicional"
                                />
                            </div>

                            <div>
                                <Label className="text-xs text-gray-500 mb-1.5 block">
                                    Observaciones <span className="text-gray-400 font-normal">(opcional)</span>
                                </Label>
                                <textarea
                                    value={form.observaciones}
                                    onChange={(e) => handleChange('observaciones', e.target.value)}
                                    placeholder="Notas adicionales"
                                    rows={2}
                                    className="flex w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
                                />
                            </div>

                            {/* Resumen */}
                            <div className="border-t border-gray-200 pt-4 space-y-2">
                                <h4 className="text-xs font-semibold text-gray-500 uppercase tracking-wider">Resumen</h4>
                                <div className="flex justify-between text-sm">
                                    <span className="text-gray-500">Ítems</span>
                                    <span className="font-medium text-gray-900">
                                        {detalles.filter((d) => d.descripcion).length}
                                    </span>
                                </div>
                                <div className="flex justify-between text-sm">
                                    <span className="text-gray-500">Peso</span>
                                    <span className="font-medium text-gray-900">
                                        {form.peso_total || '0'} {form.und_peso_total}
                                    </span>
                                </div>
                                {remitente.nombre && (
                                    <div className="flex justify-between text-sm">
                                        <span className="text-gray-500">Remitente</span>
                                        <span className="font-medium text-gray-900 text-right max-w-[160px] truncate">
                                            {remitente.nombre}
                                        </span>
                                    </div>
                                )}
                                {remitente.direccion && (
                                    <div className="flex justify-between text-sm">
                                        <span className="text-gray-500">Dir. Remitente</span>
                                        <span className="font-medium text-gray-900 text-right max-w-[160px] truncate text-xs">
                                            {remitente.direccion}
                                        </span>
                                    </div>
                                )}
                                {destinatario.nombre && (
                                    <div className="flex justify-between text-sm">
                                        <span className="text-gray-500">Destinatario</span>
                                        <span className="font-medium text-gray-900 text-right max-w-[160px] truncate">
                                            {destinatario.nombre}
                                        </span>
                                    </div>
                                )}
                                {form.vehiculo_placa && (
                                    <div className="flex justify-between text-sm">
                                        <span className="text-gray-500">Placa</span>
                                        <span className="font-mono font-medium text-gray-900">{form.vehiculo_placa}</span>
                                    </div>
                                )}
                            </div>

                            <Button onClick={handleSubmit} disabled={submitting} className="w-full gap-2">
                                {submitting ? (
                                    <><Loader2 className="h-4 w-4 animate-spin" /> Generando XML...</>
                                ) : (
                                    <><Truck className="h-4 w-4" /> Crear Guía</>
                                )}
                            </Button>
                        </CardContent>
                    </Card>
                </div>
            </form>
        </MainLayout>
    );
}
