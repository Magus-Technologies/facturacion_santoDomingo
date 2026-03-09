<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class BannerPromocionalRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'imagen' => 'required|image|mimes:jpeg,png,gif,webp|max:2048',
            'url' => 'required|string|max:255',
            'estado' => 'required|in:0,1',
        ];
    }

    public function messages(): array
    {
        return [
            'imagen.required' => 'La imagen es requerida',
            'imagen.image' => 'El archivo debe ser una imagen',
            'imagen.mimes' => 'La imagen debe ser JPG, PNG, GIF o WebP',
            'imagen.max' => 'La imagen no debe exceder 2MB',
            'url.required' => 'La URL es requerida',
            'estado.required' => 'El estado es requerido',
            'estado.in' => 'El estado debe ser 0 o 1',
        ];
    }
}
