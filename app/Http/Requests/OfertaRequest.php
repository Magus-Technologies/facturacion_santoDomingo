<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class OfertaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'id_producto' => 'required|exists:productos,id_producto',
            'tipo' => 'required|in:porcentaje,monto',
            'valor' => 'required|numeric|min:0',
            'fecha_inicio' => 'required|date',
            'fecha_fin' => 'nullable|date',
            'descripcion' => 'nullable|string|max:500',
            'estado' => 'nullable|in:0,1',
        ];
    }

    protected function prepareForValidation()
    {
        // Convertir fechas en formato Y-m-d a Y-m-d H:i:s
        if ($this->fecha_inicio && !str_contains($this->fecha_inicio, ':')) {
            $this->merge([
                'fecha_inicio' => $this->fecha_inicio . ' 00:00:00',
            ]);
        }

        if ($this->fecha_fin && !str_contains($this->fecha_fin, ':')) {
            $this->merge([
                'fecha_fin' => $this->fecha_fin . ' 23:59:59',
            ]);
        }
    }

    protected function failedValidation(Validator $validator)
    {
        throw new HttpResponseException(response()->json([
            'success' => false,
            'message' => 'Errores de validación',
            'errors' => $validator->errors()
        ], 422));
    }
}
