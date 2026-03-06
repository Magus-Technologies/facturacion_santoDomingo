<?php

namespace App\Http\Controllers\Api;

use App\Models\Transportista;
use App\Http\Requests\TransportistaRequest;
use App\Http\Controllers\BaseApiController;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class TransportistaController extends BaseApiController
{
    public function index(Request $request): JsonResponse
    {
        $empresaId = $request->user()->id_empresa ?? $request->input('empresa_id');

        $transportistas = Transportista::byEmpresa($empresaId)
            ->when($request->input('search'), function ($query, $search) {
                return $query->where('razon_social', 'like', "%{$search}%")
                    ->orWhere('numero_documento', 'like', "%{$search}%");
            })
            ->when($request->input('estado') !== null, function ($query) use ($request) {
                return $query->where('estado', $request->boolean('estado'));
            })
            ->orderBy('razon_social')
            ->paginate($request->input('per_page', 15));

        return $this->success($transportistas);
    }

    public function show(int $id, Request $request): JsonResponse
    {
        $transportista = Transportista::findOrFail($id);

        $this->authorize('view', $transportista);

        return $this->success($transportista);
    }

    public function store(TransportistaRequest $request): JsonResponse
    {
        $empresaId = $request->user()->id_empresa ?? $request->input('empresa_id');

        $transportista = Transportista::create([
            ...$request->validated(),
            'id_empresa' => $empresaId,
        ]);

        return $this->success($transportista, 'Transportista creado exitosamente', 201);
    }

    public function update(int $id, TransportistaRequest $request): JsonResponse
    {
        $transportista = Transportista::findOrFail($id);

        $this->authorize('update', $transportista);

        $transportista->update($request->validated());

        return $this->success($transportista, 'Transportista actualizado exitosamente');
    }

    public function destroy(int $id, Request $request): JsonResponse
    {
        $transportista = Transportista::findOrFail($id);

        $this->authorize('delete', $transportista);

        $transportista->delete();

        return $this->success(null, 'Transportista eliminado exitosamente');
    }

    public function activos(Request $request): JsonResponse
    {
        $empresaId = $request->user()->id_empresa ?? $request->input('empresa_id');

        $transportistas = Transportista::byEmpresa($empresaId)
            ->activo()
            ->orderBy('razon_social')
            ->get();

        return $this->success($transportistas);
    }
}
