<?php

namespace App\Services;

use App\Exceptions\GuiaRemisionCreationException;
use App\Exceptions\GuiaRemisionException;
use App\Http\Requests\GuiaRemisionTransportistaStoreRequest;
use App\Http\Requests\GuiaRemisionTransportistaUpdateRequest;
use App\Models\Empresa;
use App\Models\GuiaRemision;
use App\Models\GuiaRemisionDetalle;
use Illuminate\Support\Facades\DB;

class GuiaRemisionTransportistaService
{
    private const SERIE = 'V001';

    public function __construct() {}

    public function crear(GuiaRemisionTransportistaStoreRequest $request, int $idEmpresa): GuiaRemision
    {
        try {
            return DB::transaction(function () use ($request, $idEmpresa) {
                $empresa = Empresa::findOrFail($idEmpresa);
                $proximoNumero = $this->resolverProximoNumero($idEmpresa);

                $guia = GuiaRemision::create($this->construirDatosGuia($request, $idEmpresa, $empresa, $proximoNumero));

                $this->crearDetalles($guia->id, $request->detalles);

                return $guia->load(['detalles']);
            });
        } catch (\Exception $e) {
            throw GuiaRemisionCreationException::fromThrowable($e);
        }
    }

    public function actualizar(GuiaRemision $guia, GuiaRemisionTransportistaUpdateRequest $request): GuiaRemision
    {
        if ($guia->estado !== 'pendiente') {
            throw new GuiaRemisionException('Solo se pueden editar guías en estado pendiente.', 400);
        }

        $guia->update($request->validated());
        return $guia->load(['detalles']);
    }

    private function resolverProximoNumero(int $idEmpresa): int
    {
        $ultimoNumero = GuiaRemision::where('serie', self::SERIE)
            ->where('id_empresa', $idEmpresa)
            ->max('numero') ?? 0;

        $numeroBase = DB::table('documentos_empresas')
            ->where('id_empresa', $idEmpresa)
            ->where('serie', self::SERIE)
            ->value('numero') ?? 0;

        $proximoNumero = max($ultimoNumero, $numeroBase) + 1;

        DB::table('documentos_empresas')
            ->where('id_empresa', $idEmpresa)
            ->where('serie', self::SERIE)
            ->update(['numero' => $proximoNumero]);

        return $proximoNumero;
    }

    private function construirDatosGuia(GuiaRemisionTransportistaStoreRequest $request, int $idEmpresa, Empresa $empresa, int $numero): array
    {
        return [
            'id_empresa'               => $idEmpresa,
            'id_usuario'               => $request->user()->id,
            'serie'                    => self::SERIE,
            'numero'                   => $numero,
            'fecha_emision'            => now()->toDateString(),
            'remitente_tipo_doc'       => $request->remitente_tipo_doc,
            'remitente_documento'      => $request->remitente_documento,
            'remitente_nombre'         => $request->remitente_nombre,
            'remitente_direccion'      => $request->remitente_direccion,
            'remitente_ubigeo'         => $request->remitente_ubigeo,
            'remitente_cod_establecimiento' => $request->remitente_cod_establecimiento,
            'destinatario_tipo_doc'    => $request->destinatario_tipo_doc,
            'destinatario_documento'   => $request->destinatario_documento,
            'destinatario_nombre'      => $request->destinatario_nombre,
            'destinatario_cod_establecimiento' => $request->destinatario_cod_establecimiento,
            'motivo_traslado'          => $request->motivo_traslado,
            'descripcion_motivo'       => $request->descripcion_motivo,
            'mod_transporte'           => '02',
            'fecha_traslado'           => $request->fecha_traslado,
            'peso_total'               => $request->peso_total,
            'und_peso_total'           => $request->und_peso_total ?? 'KGM',
            'ubigeo_partida'           => $request->ubigeo_partida ?: ($empresa->ubigeo ?: '150101'),
            'dir_partida'              => $request->dir_partida,
            'ubigeo_llegada'           => $request->ubigeo_llegada ?: '150101',
            'dir_llegada'              => $request->dir_llegada,
            'conductor_tipo_doc'       => $request->conductor_tipo_doc,
            'conductor_documento'      => $request->conductor_documento,
            'conductor_nombres'        => $request->conductor_nombres,
            'conductor_apellidos'      => $request->conductor_apellidos,
            'conductor_licencia'       => $request->conductor_licencia,
            'vehiculo_placa'           => $request->vehiculo_placa,
            'vehiculo_placa_secundaria'=> $request->vehiculo_placa_secundaria,
            'vehiculo_marca'           => $request->vehiculo_marca,
            'vehiculo_configuracion'   => $request->vehiculo_configuracion,
            'vehiculo_habilitacion'    => $request->vehiculo_habilitacion,
            'vehiculo_m1l'             => false,
            'numero_registro_mtc'      => $request->numero_registro_mtc,
            'emisor_autorizacion'      => $request->emisor_autorizacion,
            'doc_relacionado_tipo'     => $request->doc_relacionado_tipo,
            'doc_relacionado_serie'    => $request->doc_relacionado_serie,
            'doc_relacionado_numero'   => $request->doc_relacionado_numero,
            'doc_relacionado_emisor_ruc'=> $request->doc_relacionado_emisor_ruc,
            'mercancia_iqbf'           => $request->mercancia_iqbf ?? false,
            'mercancia_peligrosa'      => $request->mercancia_peligrosa ?? false,
            'codigo_onu'               => $request->codigo_onu,
            'mercancia_voluminosa'     => $request->mercancia_voluminosa ?? false,
            'pagador_tipo_doc'         => $request->pagador_tipo_doc,
            'pagador_documento'        => $request->pagador_documento,
            'pagador_razon_social'     => $request->pagador_razon_social,
            'observaciones'            => $request->observaciones,
            'estado'                   => 'pendiente',
        ];
    }

    private function crearDetalles(int $guiaId, array $detalles): void
    {
        $detallesFormateados = array_map(function ($detalle) use ($guiaId) {
            return [
                'id_guia'      => $guiaId,
                'id_producto'  => $detalle['id_producto'] ?? null,
                'codigo'       => $detalle['codigo'] ?? null,
                'descripcion'  => $detalle['descripcion'],
                'cantidad'     => $detalle['cantidad'],
                'unidad'       => $detalle['unidad'] ?? 'NIU',
                'created_at'   => now(),
                'updated_at'   => now(),
            ];
        }, $detalles);

        GuiaRemisionDetalle::insert($detallesFormateados);
    }

}
