<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Validation\Rule;

class BancoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $id = $this->route('id');

        return [
            'nombre' => [
                'required', 'string', 'max:255',
                Rule::unique('bancos', 'nombre')->ignore($id, 'id_banco'),
            ],
            'codigo_sunat' => [
                'nullable', 'string', 'max:255',
                Rule::unique('bancos', 'codigo_sunat')->ignore($id, 'id_banco'),
            ],
            'codigo_swift' => 'nullable|string|max:255',
            'telefono'     => 'nullable|string|max:255',
            'email'        => 'nullable|email|max:255',
            'website'      => 'nullable|string|max:255',
            'activo'       => 'boolean',
        ];
    }

    public function messages(): array
    {
        return [
            'nombre.required' => 'El nombre del banco es obligatorio.',
            'nombre.unique'   => 'Ya existe un banco con ese nombre.',
            'email.email'     => 'El email no tiene un formato válido.',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        throw new HttpResponseException(response()->json([
            'success' => false,
            'message' => 'Errores de validación',
            'errors'  => $validator->errors(),
        ], 422));
    }
}
