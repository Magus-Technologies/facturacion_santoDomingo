<?php

namespace App\Http\Controllers;

use App\Models\FooterConfig;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class FooterConfigController extends Controller
{
    /**
     * Endpoint público para el ecommerce (sin auth)
     */
    public function public()
    {
        $config = FooterConfig::first();

        if (!$config) {
            return response()->json([
                'success' => true,
                'data'    => [
                    'slogan'      => '',
                    'subtitulo'   => 'Recibe las mejores Ofertas SUSCRÍBETE',
                    'boton_texto' => 'Suscríbete',
                    'imagen_url'  => null,
                ]
            ]);
        }

        return response()->json([
            'success' => true,
            'data'    => [
                'slogan'      => $config->slogan,
                'subtitulo'   => $config->subtitulo,
                'boton_texto' => $config->boton_texto,
                'imagen_url'  => $config->imagen ? asset('storage/' . $config->imagen) : null,
            ]
        ]);
    }

    /**
     * Obtener configuración (admin)
     */
    public function show()
    {
        $config = FooterConfig::first();

        if (!$config) {
            $config = FooterConfig::create([
                'slogan'      => '',
                'subtitulo'   => 'Recibe las mejores Ofertas SUSCRÍBETE',
                'boton_texto' => 'Suscríbete',
            ]);
        }

        return response()->json([
            'success' => true,
            'data'    => array_merge($config->toArray(), [
                'imagen_url' => $config->imagen ? asset('storage/' . $config->imagen) : null,
            ])
        ]);
    }

    /**
     * Actualizar configuración (admin)
     */
    public function update(Request $request)
    {
        $config = FooterConfig::first();

        if (!$config) {
            $config = new FooterConfig();
        }

        $data = $request->only(['slogan', 'subtitulo', 'boton_texto']);

        if ($request->hasFile('imagen')) {
            $file = $request->file('imagen');

            // Eliminar imagen anterior
            if ($config->imagen && Storage::disk('public')->exists($config->imagen)) {
                Storage::disk('public')->delete($config->imagen);
            }

            $filename = 'footer_' . time() . '.' . $file->getClientOriginalExtension();
            $data['imagen'] = $file->storeAs('footer', $filename, 'public');
        }

        // Eliminar imagen si se solicitó
        if ($request->input('remove_imagen') === 'true' && !$request->hasFile('imagen')) {
            if ($config->imagen && Storage::disk('public')->exists($config->imagen)) {
                Storage::disk('public')->delete($config->imagen);
            }
            $data['imagen'] = null;
        }

        $config->fill($data);
        $config->save();

        return response()->json([
            'success' => true,
            'message' => 'Footer actualizado exitosamente',
            'data'    => array_merge($config->toArray(), [
                'imagen_url' => $config->imagen ? asset('storage/' . $config->imagen) : null,
            ])
        ]);
    }
}
