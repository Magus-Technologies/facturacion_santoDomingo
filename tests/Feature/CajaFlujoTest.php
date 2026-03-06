<?php

namespace Tests\Feature;

use App\Enums\CajaEstadoEnum;
use App\Models\Caja;
use App\Models\Empresa;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use Laravel\Sanctum\Sanctum;

class CajaFlujoTest extends TestCase
{
    use RefreshDatabase;

    protected $user;
    protected $empresa;

    protected function setUp(): void
    {
        parent::setUp();
        
        $this->empresa = Empresa::create([
            'ruc' => '20123456789',
            'razon_social' => 'Empresa Test',
            'comercial' => 'Empresa Test SAC',
            'cod_sucursal' => '0000',
            'direccion' => 'Calle Falsa 123',
            'email' => 'test@empresa.com',
            'telefono' => '987654321',
            'estado' => 1,
            'modo' => 'beta',
            'igv' => 18.00
        ]);

        $this->user = User::create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password'),
            'id_empresa' => $this->empresa->id_empresa,
            'rol_id' => 1,
            'estado' => 1
        ]);

        Sanctum::actingAs($this->user);
    }

    public function test_activar_caja_inactiva_pasa_a_cerrada()
    {
        $caja = Caja::create([
            'id_empresa' => $this->empresa->id_empresa,
            'nombre' => 'Caja Test',
            'id_responsable' => $this->user->id,
            'estado' => CajaEstadoEnum::Inactiva->value
        ]);

        $response = $this->postJson("/api/cajas/{$caja->id_caja}/activar");

        $response->assertStatus(200);
        $this->assertEquals(CajaEstadoEnum::Cerrada->value, $caja->fresh()->estado);
    }

    public function test_no_se_puede_activar_caja_que_no_este_inactiva()
    {
        $caja = Caja::create([
            'id_empresa' => $this->empresa->id_empresa,
            'nombre' => 'Caja Test',
            'id_responsable' => $this->user->id,
            'estado' => CajaEstadoEnum::Cerrada->value
        ]);

        $response = $this->postJson("/api/cajas/{$caja->id_caja}/activar");

        $response->assertStatus(422);
    }

    public function test_aperturar_caja_cerrada_con_saldo_inicial()
    {
        $caja = Caja::create([
            'id_empresa' => $this->empresa->id_empresa,
            'nombre' => 'Caja Test',
            'id_responsable' => $this->user->id,
            'estado' => CajaEstadoEnum::Cerrada->value
        ]);

        $response = $this->postJson("/api/cajas/{$caja->id_caja}/abrir", [
            'saldo_inicial' => 100,
            'tipo_apertura' => 'monto_fijo'
        ]);

        $response->assertStatus(200);
        $this->assertEquals(CajaEstadoEnum::Abierta->value, $caja->fresh()->estado);
        $this->assertEquals(100, $caja->fresh()->saldo_inicial);
    }

    public function test_no_se_puede_aperturar_caja_inactiva_directamente()
    {
        $caja = Caja::create([
            'id_empresa' => $this->empresa->id_empresa,
            'nombre' => 'Caja Test',
            'id_responsable' => $this->user->id,
            'estado' => CajaEstadoEnum::Inactiva->value
        ]);

        $response = $this->postJson("/api/cajas/{$caja->id_caja}/abrir", [
            'saldo_inicial' => 100,
            'tipo_apertura' => 'monto_fijo'
        ]);

        // Debe fallar porque requiere estar Cerrada (habilitada)
        $response->assertStatus(500); // CajaSesionService lanza excepción
    }

    public function test_apertura_limpia_campos_de_sesion_anterior()
    {
        $caja = Caja::create([
            'id_empresa' => $this->empresa->id_empresa,
            'nombre' => 'Caja Test',
            'id_responsable' => $this->user->id,
            'estado' => CajaEstadoEnum::Cerrada->value,
            'total_real' => 500, // residuo de sesion anterior
            'diferencia' => 10
        ]);

        $this->postJson("/api/cajas/{$caja->id_caja}/abrir", [
            'saldo_inicial' => 50,
            'tipo_apertura' => 'monto_fijo'
        ]);

        $cajaFresh = $caja->fresh();
        $this->assertEquals(50, $cajaFresh->saldo_inicial);
        $this->assertNull($cajaFresh->total_real);
        $this->assertNull($cajaFresh->diferencia);
    }
}
