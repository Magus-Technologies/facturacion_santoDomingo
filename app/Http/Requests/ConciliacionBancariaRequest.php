<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class ConciliacionBancariaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'id_cuenta'          => 'required|exists:cuentas_bancarias,id_cuenta',
            'fecha_conciliacion' => 'required|date',
            'saldo_empresa'      => 'required|numeric',
            'saldo_banco'        => 'required|numeric',
            'observaciones'      => 'nullable|string|max:1000',
        ];
    }

    public function messages(): array
    {
        return [
            'id_cuenta.required'          => 'La cuenta bancaria es obligatoria.',
            'id_cuenta.exists'            => 'La cuenta bancaria seleccionada no existe.',
            'fecha_conciliacion.required' => 'La fecha de conciliación es obligatoria.',
            'saldo_empresa.required'      => 'El saldo según empresa es obligatorio.',
            'saldo_banco.required'        => 'El saldo según banco es obligatorio.',
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
