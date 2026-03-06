<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class TransportistaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $transportistaId = $this->route('transportista');

        return [
            'tipo_documento' => 'required|in:1,6',
            'numero_documento' => 'required|string|max:15|unique:transportistas,numero_documento,' . $transportistaId,
            'razon_social' => 'required|string|max:255',
            'nombre_comercial' => 'nullable|string|max:255',
            'numero_mtc' => 'nullable|string|max:20',
            'telefono' => 'nullable|string|max:20',
            'email' => 'nullable|email|max:100',
            'direccion' => 'nullable|string|max:255',
            'estado' => 'nullable|boolean',
        ];
    }

    public function messages(): array
    {
        return [
            'tipo_documento.required' => 'El tipo de documento es requerido',
            'tipo_documento.in' => 'El tipo de documento debe ser 1 (DNI) o 6 (RUC)',
            'numero_documento.required' => 'El número de documento es requerido',
            'numero_documento.unique' => 'El número de documento ya existe',
            'razon_social.required' => 'La razón social es requerida',
        ];
    }
}
