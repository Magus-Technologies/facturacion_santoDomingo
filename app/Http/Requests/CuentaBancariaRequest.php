<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Validation\Rule;

class CuentaBancariaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $id = $this->route('id');

        return [
            'id_banco'      => 'required|exists:bancos,id_banco',
            'numero_cuenta' => [
                'required', 'string', 'max:255',
                Rule::unique('cuentas_bancarias', 'numero_cuenta')->ignore($id, 'id_cuenta'),
            ],
            'tipo_cuenta'   => 'required|in:Corriente,Ahorros',
            'moneda'        => 'required|in:PEN,USD',
            'cci'           => 'nullable|string|size:20',
            'activa'        => 'boolean',
            // Titulares (opcional al crear)
            'titulares'                          => 'nullable|array',
            'titulares.*.nombre'                 => 'required_with:titulares|string|max:255',
            'titulares.*.documento_tipo'         => 'required_with:titulares|string|max:3',
            'titulares.*.documento_numero'       => 'required_with:titulares|string|max:255',
            'titulares.*.titular_principal'      => 'boolean',
        ];
    }

    public function messages(): array
    {
        return [
            'id_banco.required'      => 'El banco es obligatorio.',
            'id_banco.exists'        => 'El banco seleccionado no existe.',
            'numero_cuenta.required' => 'El número de cuenta es obligatorio.',
            'numero_cuenta.unique'   => 'Este número de cuenta ya está registrado.',
            'tipo_cuenta.required'   => 'El tipo de cuenta es obligatorio.',
            'tipo_cuenta.in'         => 'El tipo de cuenta debe ser Corriente o Ahorros.',
            'moneda.required'        => 'La moneda es obligatoria.',
            'moneda.in'              => 'La moneda debe ser PEN o USD.',
            'cci.size'               => 'El CCI debe tener exactamente 20 dígitos.',
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
