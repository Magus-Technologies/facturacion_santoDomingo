<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class CajaCierreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'saldo_final_real'    => 'required|numeric|min:0',
            'observaciones_cierre' => 'nullable|string|max:1000',
            // Billetes de cierre (opcional)
            'billetes'                    => 'nullable|array',
            'billetes.*.id_denominacion'  => 'required_with:billetes|exists:denominaciones_billetes,id_denominacion',
            'billetes.*.cantidad'         => 'required_with:billetes|integer|min:0',
        ];
    }

    public function messages(): array
    {
        return [
            'saldo_final_real.required' => 'El saldo final real es obligatorio.',
            'saldo_final_real.min'      => 'El saldo final no puede ser negativo.',
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
