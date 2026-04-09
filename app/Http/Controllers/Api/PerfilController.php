<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;

class PerfilController extends Controller
{
    /**
     * Obtener datos del perfil del usuario autenticado
     */
    public function show(Request $request)
    {
        $user = $request->user();
        $user->load(['rol:rol_id,nombre', 'empresa:id_empresa,comercial,ruc']);

        return response()->json([
            'success' => true,
            'data' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'nombres' => $user->nombres,
                'apellidos' => $user->apellidos,
                'num_doc' => $user->num_doc,
                'telefono' => $user->telefono,
                'foto_perfil' => $user->foto_perfil,
                'rol' => $user->rol,
                'empresa' => $user->empresa,
                'created_at' => $user->created_at,
            ],
        ]);
    }

    /**
     * Actualizar datos del perfil
     */
    public function update(Request $request)
    {
        $user = $request->user();

        $validated = $request->validate([
            'nombres' => 'sometimes|nullable|string|max:200',
            'apellidos' => 'sometimes|nullable|string|max:200',
            'telefono' => 'sometimes|nullable|string|max:100',
            'num_doc' => 'sometimes|nullable|string|max:20',
            'email' => [
                'sometimes', 'required', 'email', 'max:255',
                Rule::unique('users')->ignore($user->id),
            ],
        ]);

        $user->fill($validated);

        // Actualizar name con nombres + apellidos si se proporcionan
        if (isset($validated['nombres']) || isset($validated['apellidos'])) {
            $nombres = $validated['nombres'] ?? $user->nombres ?? '';
            $apellidos = $validated['apellidos'] ?? $user->apellidos ?? '';
            $user->name = trim("$nombres $apellidos") ?: $user->name;
        }

        $user->save();

        return response()->json([
            'success' => true,
            'message' => 'Perfil actualizado correctamente',
            'data' => $user->only(['id', 'name', 'email', 'nombres', 'apellidos', 'telefono', 'num_doc', 'foto_perfil']),
        ]);
    }

    /**
     * Cambiar contraseña
     */
    public function cambiarPassword(Request $request)
    {
        $request->validate([
            'password_actual' => 'required|string',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $user = $request->user();

        if (!Hash::check($request->password_actual, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'La contraseña actual es incorrecta',
                'errors' => ['password_actual' => ['La contraseña actual es incorrecta']],
            ], 422);
        }

        $user->password = Hash::make($request->password);
        $user->save();

        return response()->json([
            'success' => true,
            'message' => 'Contraseña actualizada correctamente',
        ]);
    }

    /**
     * Subir foto de perfil
     */
    public function subirFoto(Request $request)
    {
        $request->validate([
            'foto' => 'required|image|mimes:jpg,jpeg,png,webp|max:2048',
        ]);

        $user = $request->user();

        // Eliminar foto anterior si existe
        if ($user->foto_perfil) {
            $oldPath = str_replace('storage/', '', $user->foto_perfil);
            if (Storage::disk('public')->exists($oldPath)) {
                Storage::disk('public')->delete($oldPath);
            }
        }

        $file = $request->file('foto');
        $filename = 'perfil_' . $user->id . '_' . time() . '.' . $file->getClientOriginalExtension();
        $file->storeAs('perfiles', $filename, 'public');

        $user->foto_perfil = 'storage/perfiles/' . $filename;
        $user->save();

        return response()->json([
            'success' => true,
            'message' => 'Foto actualizada correctamente',
            'data' => ['foto_perfil' => $user->foto_perfil],
        ]);
    }
}
