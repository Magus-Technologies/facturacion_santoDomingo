<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class CajaCrearRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'nombre'         => 'required|string|max:100',
            'descripcion'    => 'nullable|string|max:500',
            'id_responsable' => 'required|exists:users,id',
            'metodos_pago'   => 'nullable|array',
            'metodos_pago.*' => 'integer|exists:metodos_pago,id_metodo_pago',
        ];
    }

    public function messages(): array
    {
        return [
            'nombre.required'         => 'El nombre de la caja es obligatorio.',
            'nombre.max'              => 'El nombre no puede superar los 100 caracteres.',
            'id_responsable.required' => 'El responsable es obligatorio.',
            'id_responsable.exists'   => 'El responsable seleccionado no existe.',
            'metodos_pago.*.exists'   => 'Uno de los métodos de pago seleccionados no es válido.',
        ];
    }

    protected function failedValidation(Validator $validator): never
    {
        throw new HttpResponseException(response()->json([
            'success' => false,
            'message' => 'Errores de validación',
            'errors'  => $validator->errors(),
        ], 422));
    }
}
