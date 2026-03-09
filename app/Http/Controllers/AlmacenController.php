<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use Illuminate\Http\Request;

class AlmacenController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        $almacenes = Almacen::with(['padre:id,nombre', 'hijos:id,nombre,id_padre,es_principal,estado'])
            ->where('id_empresa', $user->id_empresa)
            ->where('estado', '1')
            ->orderByDesc('es_principal')
            ->orderBy('nombre')
            ->get();

        return response()->json(['success' => true, 'data' => $almacenes]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'nombre'      => 'required|string|max:100',
            'descripcion' => 'nullable|string|max:255',
            'id_padre'    => 'nullable|exists:almacenes,id',
        ]);

        $user = $request->user();

        // Si no se especifica padre, asignar el principal
        $idPadre = $request->id_padre;
        if (!$idPadre) {
            $principal = Almacen::where('id_empresa', $user->id_empresa)
                ->where('es_principal', true)
                ->first();
            $idPadre = $principal?->id;
        }

        // Validar que no se cree otro principal
        $almacen = Almacen::create([
            'nombre'       => $request->nombre,
            'descripcion'  => $request->descripcion,
            'id_padre'     => $idPadre,
            'es_principal' => false,
            'id_empresa'   => $user->id_empresa,
        ]);

        $almacen->load('padre:id,nombre');

        return response()->json([
            'success' => true,
            'message' => 'Almacén creado exitosamente',
            'data'    => $almacen,
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'nombre'      => 'required|string|max:100',
            'descripcion' => 'nullable|string|max:255',
        ]);

        $almacen = Almacen::findOrFail($id);

        // No permitir cambiar el nombre del principal a algo vacío
        $almacen->update([
            'nombre'      => $request->nombre,
            'descripcion' => $request->descripcion,
        ]);

        $almacen->load('padre:id,nombre');

        return response()->json([
            'success' => true,
            'message' => 'Almacén actualizado exitosamente',
            'data'    => $almacen,
        ]);
    }

    public function destroy($id)
    {
        $almacen = Almacen::findOrFail($id);

        if ($almacen->es_principal) {
            return response()->json([
                'success' => false,
                'message' => 'No se puede eliminar el almacén principal',
            ], 422);
        }

        // Verificar que no tenga productos activos
        $tieneProductos = $almacen->productos()->where('estado', '1')->exists();
        if ($tieneProductos) {
            return response()->json([
                'success' => false,
                'message' => 'No se puede eliminar: el almacén tiene productos activos. Muévalos primero.',
            ], 422);
        }

        $almacen->update(['estado' => '0']);

        return response()->json([
            'success' => true,
            'message' => 'Almacén eliminado exitosamente',
        ]);
    }
}
