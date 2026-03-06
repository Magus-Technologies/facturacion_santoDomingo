<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class CajaAperturaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'saldo_inicial'  => 'required|numeric|min:0',
            'observaciones'  => 'nullable|string|max:1000',
            // Billetes de apertura (opcional - si se proporciona, debe ser array válido)
            'billetes'                    => 'nullable|array',
            'billetes.*.id_denominacion'  => 'required_with:billetes|exists:denominaciones_billetes,id_denominacion',
            'billetes.*.cantidad'         => 'required_with:billetes|integer|min:0',
        ];
    }

    public function messages(): array
    {
        return [
            'saldo_inicial.required'  => 'El saldo inicial es obligatorio.',
            'saldo_inicial.min'       => 'El saldo inicial no puede ser negativo.',
            'billetes.*.id_denominacion.exists'   => 'Una denominación de billete no es válida.',
            'billetes.*.cantidad.integer'         => 'La cantidad de billetes debe ser un número entero.',
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
