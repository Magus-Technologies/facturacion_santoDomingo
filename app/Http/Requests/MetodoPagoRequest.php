<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Validation\Rule;

class MetodoPagoRequest extends FormRequest
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
                Rule::unique('metodos_pago', 'nombre')->ignore($id, 'id_metodo_pago'),
            ],
            'codigo' => [
                'required', 'string', 'max:255',
                Rule::unique('metodos_pago', 'codigo')->ignore($id, 'id_metodo_pago'),
            ],
            'descripcion'          => 'nullable|string',
            'tipo'                 => 'required|in:Efectivo,Tarjeta,Transferencia,Billetera,Cheque,Otro',
            'id_banco'             => 'nullable|exists:bancos,id_banco',
            'id_cuenta'            => 'nullable|exists:cuentas_bancarias,id_cuenta',
            'es_efectivo'          => 'boolean',
            'requiere_referencia'  => 'boolean',
            'requiere_comprobante' => 'boolean',
            'activo'               => 'boolean',
        ];
    }

    public function messages(): array
    {
        return [
            'nombre.required'  => 'El nombre del método de pago es obligatorio.',
            'nombre.unique'    => 'Ya existe un método de pago con ese nombre. Usa un nombre distinto (ej: "Yape BCP", "Yape Scotiabank").',
            'codigo.required'  => 'El código es obligatorio.',
            'codigo.unique'    => 'Ya existe un método con ese código. Usa un código distinto (ej: YAPE_BCP, YAPE_SCO).',
            'tipo.required'    => 'El tipo es obligatorio.',
            'tipo.in'          => 'El tipo debe ser: Efectivo, Tarjeta, Transferencia, Billetera, Cheque u Otro.',
            'id_banco.exists'  => 'El banco seleccionado no existe.',
            'id_cuenta.exists' => 'La cuenta bancaria seleccionada no existe.',
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
