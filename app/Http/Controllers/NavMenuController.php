<?php

namespace App\Http\Controllers;

use App\Models\NavMenu;
use App\Http\Resources\NavMenuResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class NavMenuController extends Controller
{
    /**
     * GET /api/nav-menu
     * Lista todos los ítems (con sus hijos) — uso admin
     */
    public function index(): JsonResponse
    {
        $items = NavMenu::whereNull('parent_id')
            ->with('hijos')
            ->orderBy('orden')
            ->get();

        return response()->json([
            'success' => true,
            'data'    => NavMenuResource::collection($items),
        ]);
    }

    /**
     * GET /api/public/nav-menu
     * Solo ítems activos — uso ecommerce
     */
    public function public(): JsonResponse
    {
        $items = NavMenu::whereNull('parent_id')
            ->where('estado', '1')
            ->with(['hijos' => fn($q) => $q->where('estado', '1')])
            ->orderBy('orden')
            ->get();

        return response()->json([
            'success' => true,
            'data'    => NavMenuResource::collection($items),
        ]);
    }

    /**
     * POST /api/nav-menu
     */
    public function store(Request $request): JsonResponse
    {
        $data = $request->validate([
            'label'     => 'required|string|max:100',
            'url'       => 'nullable|string|max:255',
            'parent_id' => 'nullable|exists:nav_menu,id',
            'orden'     => 'nullable|integer',
            'estado'    => 'nullable|in:0,1',
            'target'    => 'nullable|in:_self,_blank',
        ]);

        $item = NavMenu::create($data);

        return response()->json([
            'success' => true,
            'data'    => new NavMenuResource($item),
            'message' => 'Ítem creado exitosamente',
        ], 201);
    }

    /**
     * PUT /api/nav-menu/{id}
     */
    public function update(Request $request, int $id): JsonResponse
    {
        $item = NavMenu::findOrFail($id);

        $data = $request->validate([
            'label'     => 'sometimes|string|max:100',
            'url'       => 'nullable|string|max:255',
            'parent_id' => 'nullable|exists:nav_menu,id',
            'orden'     => 'nullable|integer',
            'estado'    => 'nullable|in:0,1',
            'target'    => 'nullable|in:_self,_blank',
        ]);

        $item->update($data);

        return response()->json([
            'success' => true,
            'data'    => new NavMenuResource($item),
            'message' => 'Ítem actualizado exitosamente',
        ]);
    }

    /**
     * DELETE /api/nav-menu/{id}
     */
    public function destroy(int $id): JsonResponse
    {
        $item = NavMenu::findOrFail($id);
        $item->delete();

        return response()->json([
            'success' => true,
            'message' => 'Ítem eliminado exitosamente',
        ]);
    }
}
