<?php

namespace App\Services;

use App\Models\Transportista;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;

class TransportistaService
{
    public function listar(int $empresaId, array $filtros = []): LengthAwarePaginator
    {
        $query = Transportista::where('id_empresa', $empresaId);

        if (!empty($filtros['search'])) {
            $search = $filtros['search'];
            $query->where(function ($q) use ($search) {
                $q->where('razon_social', 'like', "%{$search}%")
                    ->orWhere('numero_documento', 'like', "%{$search}%")
                    ->orWhere('nombre_comercial', 'like', "%{$search}%");
            });
        }

        if (isset($filtros['estado'])) {
            $query->where('estado', $filtros['estado']);
        }

        return $query->orderBy('razon_social')
            ->paginate($filtros['per_page'] ?? 15);
    }

    public function activos(int $empresaId): Collection
    {
        return Transportista::where('id_empresa', $empresaId)
            ->where('estado', true)
            ->orderBy('razon_social')
            ->get();
    }

    public function obtener(int $id, int $empresaId): ?Transportista
    {
        return Transportista::where('id_empresa', $empresaId)
            ->find($id);
    }

    public function crear(array $datos, int $empresaId): Transportista
    {
        return Transportista::create([
            ...$datos,
            'id_empresa' => $empresaId,
        ]);
    }

    public function actualizar(int $id, array $datos, int $empresaId): Transportista
    {
        $transportista = $this->obtener($id, $empresaId);
        if (!$transportista) {
            throw new \Exception('Transportista no encontrado');
        }

        $transportista->update($datos);
        return $transportista;
    }

    public function eliminar(int $id, int $empresaId): bool
    {
        $transportista = $this->obtener($id, $empresaId);
        if (!$transportista) {
            throw new \Exception('Transportista no encontrado');
        }

        return $transportista->delete();
    }

    public function buscarPorDocumento(string $documento, int $empresaId): ?Transportista
    {
        return Transportista::where('id_empresa', $empresaId)
            ->where('numero_documento', $documento)
            ->first();
    }
}
