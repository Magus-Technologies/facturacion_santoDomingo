<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class GuiaRemision extends Model
{
    protected $table = 'guia_remision';

    protected $fillable = [
        'id_empresa',
        'id_usuario',
        'id_venta',
        'serie',
        'numero',
        'fecha_emision',
        'destinatario_tipo_doc',
        'destinatario_documento',
        'destinatario_nombre',
        'remitente_tipo_doc',
        'remitente_documento',
        'remitente_nombre',
        'remitente_direccion',
        'remitente_ubigeo',
        'motivo_traslado',
        'descripcion_motivo',
        'mod_transporte',
        'fecha_traslado',
        'peso_total',
        'und_peso_total',
        'ubigeo_partida',
        'dir_partida',
        'ubigeo_llegada',
        'dir_llegada',
        'establecimiento_codigo',
        'transportista_tipo_doc',
        'transportista_documento',
        'transportista_nombre',
        'transportista_nro_mtc',
        'conductor_tipo_doc',
        'conductor_documento',
        'conductor_nombres',
        'conductor_apellidos',
        'conductor_licencia',
        'vehiculo_placa',
        'vehiculo_placa_secundaria',
        'vehiculo_marca',
        'vehiculo_configuracion',
        'vehiculo_habilitacion',
        'vehiculo_m1l',
        'remitente_cod_establecimiento',
        'destinatario_cod_establecimiento',
        'doc_relacionado_tipo',
        'doc_relacionado_serie',
        'doc_relacionado_numero',
        'doc_relacionado_emisor_ruc',
        'observaciones',
        'estado',
        'nombre_xml',
        'xml_url',
        'cdr_url',
        'hash_cpe',
        'codigo_sunat',
        'mensaje_sunat',
        'ticket_sunat',
        // ─── NUEVOS CAMPOS SUNAT ────────────────────────────────────────
        // Pagador del Flete
        'pagador_tipo_doc',
        'pagador_documento',
        'pagador_razon_social',
        // Mercancía Especial
        'mercancia_iqbf',
        'mercancia_peligrosa',
        'codigo_onu',
        'mercancia_voluminosa',
        // Vehículo - Ampliación
        'numero_registro_mtc',
        'emisor_autorizacion',
        // Transportista
        'tipo_documento_identidad_transportista',
        'numero_documento_transportista',
        // Tipo de Guía y Carga
        'tipo_guia',
        'nro_bultos',
        'indicador_transbordo',
    ];

    protected $casts = [
        'fecha_emision' => 'date',
        'fecha_traslado' => 'date',
        'peso_total' => 'decimal:3',
        'numero' => 'integer',
        // ─── NUEVOS CASTS SUNAT ─────────────────────────────────────────
        'mercancia_iqbf' => 'boolean',
        'mercancia_peligrosa' => 'boolean',
        'mercancia_voluminosa' => 'boolean',
        'vehiculo_m1l' => 'boolean',
        'indicador_transbordo' => 'boolean',
    ];

    public function empresa(): BelongsTo
    {
        return $this->belongsTo(Empresa::class, 'id_empresa', 'id_empresa');
    }

    public function usuario(): BelongsTo
    {
        return $this->belongsTo(User::class, 'id_usuario', 'id');
    }

    public function venta(): BelongsTo
    {
        return $this->belongsTo(Venta::class, 'id_venta', 'id_venta');
    }

    public function detalles(): HasMany
    {
        return $this->hasMany(GuiaRemisionDetalle::class, 'id_guia', 'id');
    }

    public function transportista(): BelongsTo
    {
        return $this->belongsTo(Transportista::class, 'id_transportista', 'id');
    }

    public function getNumeroCompletoAttribute(): string
    {
        return $this->serie . '-' . str_pad($this->numero, 6, '0', STR_PAD_LEFT);
    }
}