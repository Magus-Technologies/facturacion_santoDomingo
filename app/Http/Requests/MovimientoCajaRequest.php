<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class MovimientoCajaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'tipo'             => 'required|in:Ingreso,Egreso',
            'concepto'         => 'required|string|max:255',
            'monto'            => 'required|numeric|min:0.01',
            'numero_operacion' => 'nullable|string|max:255',
            'referencia_tipo'  => 'nullable|string|max:255',
            'referencia_id'    => 'nullable|integer',
            'descripcion'      => 'nullable|string|max:1000',
        ];
    }

    public function messages(): array
    {
        return [
            'tipo.required'    => 'El tipo de movimiento es obligatorio.',
            'tipo.in'          => 'El tipo debe ser Ingreso o Egreso.',
            'concepto.required' => 'El concepto es obligatorio.',
            'monto.required'   => 'El monto es obligatorio.',
            'monto.min'        => 'El monto debe ser mayor a 0.',
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
