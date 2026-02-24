<?php

namespace App\Services;

use App\Models\Producto;
use Illuminate\Support\Facades\Storage;

class ProductoService
{
    /**
     * Listar productos por almacén
     */
    public function listar(int $idEmpresa, string $almacen, ?string $search = null, bool $soloConStock = false)
    {
        $query = Producto::with(['categoria', 'unidad'])
            ->where('id_empresa', $idEmpresa)
            ->where('almacen', $almacen)
            ->where('estado', '1');

        if ($soloConStock) {
            $query->where('cantidad', '>', 0);
        }

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('nombre', 'LIKE', "%$search%")
                  ->orWhere('codigo', 'LIKE', "%$search%")
                  ->orWhere('cod_barra', 'LIKE', "%$search%");
            });
        }

        $query->orderBy('id_producto', 'desc');

        // Limitar solo cuando es búsqueda (autocomplete), sin búsqueda devolver todo
        if ($search) {
            $query->limit(50);
        }

        return $query->get();
    }

    /**
     * Crear producto en ambos almacenes
     */
    public function crear(array $data, int $idEmpresa): Producto
    {
        if (empty($data['codigo'])) {
            $data['codigo'] = $this->generarCodigo($idEmpresa, $data['almacen']);
        }

        $data['id_empresa'] = $idEmpresa;
        $data['fecha_registro'] = now();

        $producto = Producto::create($data);

        // Crear automáticamente en el otro almacén
        $otroAlmacen = $data['almacen'] === '1' ? '2' : '1';
        $dataCopia = $data;
        $dataCopia['almacen'] = $otroAlmacen;
        $dataCopia['cantidad'] = 0;
        Producto::create($dataCopia);

        $producto->load(['categoria', 'unidad']);

        return $producto;
    }

    /**
     * Actualizar producto y sincronizar con almacén hermano
     */
    public function actualizar(Producto $producto, array $data): array
    {
        $producto->update($data);

        $sincronizado = $this->sincronizarHermano($producto, $data);

        $producto->load(['categoria', 'unidad']);

        return ['producto' => $producto, 'sincronizado' => $sincronizado];
    }

    /**
     * Eliminar producto (soft delete)
     */
    public function eliminar(Producto $producto): void
    {
        $producto->update(['estado' => '0']);
    }

    /**
     * Manejar subida de imagen
     */
    public function subirImagen($file, ?string $imagenAnterior = null): string
    {
        if ($imagenAnterior && Storage::disk('public')->exists($imagenAnterior)) {
            Storage::disk('public')->delete($imagenAnterior);
        }

        $nombreImagen = time() . '_' . $file->getClientOriginalName();
        return $file->storeAs('productos', $nombreImagen, 'public');
    }

    /**
     * Sincronizar datos con producto hermano en otro almacén
     */
    private function sincronizarHermano(Producto $producto, array $data): bool
    {
        $otroAlmacen = $producto->almacen === '1' ? '2' : '1';
        $hermano = Producto::where('codigo', $producto->codigo)
            ->where('almacen', $otroAlmacen)
            ->where('id_empresa', $producto->id_empresa)
            ->first();

        if (!$hermano) {
            return false;
        }

        $camposSincronizar = [
            'nombre', 'descripcion', 'precio', 'costo',
            'precio_mayor', 'precio_menor', 'precio_unidad',
            'stock_minimo', 'stock_maximo', 'categoria_id', 'unidad_id',
            'codsunat', 'usar_barra', 'usar_multiprecio', 'moneda',
        ];

        $datosSync = [];
        foreach ($camposSincronizar as $campo) {
            $datosSync[$campo] = $data[$campo] ?? null;
        }

        if (isset($data['imagen'])) {
            $datosSync['imagen'] = $data['imagen'];
        }

        $hermano->update($datosSync);

        return true;
    }

    /**
     * Generar código automático
     */
    private function generarCodigo(int $idEmpresa, string $almacen): string
    {
        $prefijo = "PROD-A{$almacen}-";
        $ultimo = Producto::where('id_empresa', $idEmpresa)
            ->where('almacen', $almacen)
            ->where('codigo', 'LIKE', "{$prefijo}%")
            ->orderBy('id_producto', 'desc')
            ->first();

        if ($ultimo && preg_match('/-(\d+)$/', $ultimo->codigo, $matches)) {
            $numero = intval($matches[1]) + 1;
        } else {
            $numero = 1;
        }

        return $prefijo . str_pad($numero, 5, '0', STR_PAD_LEFT);
    }
}
