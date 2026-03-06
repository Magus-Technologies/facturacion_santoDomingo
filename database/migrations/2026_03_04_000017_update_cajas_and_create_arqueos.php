<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // 1. Agregar campos faltantes a denominaciones_billetes
        if (!Schema::hasColumn('denominaciones_billetes', 'nombre')) {
            Schema::table('denominaciones_billetes', function (Blueprint $table) {
                $table->string('nombre')->nullable()->after('valor');
                $table->integer('orden')->default(0)->after('activa');
            });
        }

        // 2. Agregar campos faltantes a cajas
        if (!Schema::hasColumn('cajas', 'tipo_apertura')) {
            Schema::table('cajas', function (Blueprint $table) {
                $table->enum('tipo_apertura', ['monto_fijo', 'billetes'])->default('monto_fijo')->after('saldo_inicial');
            });
        }

        if (!Schema::hasColumn('cajas', 'tipo_cierre')) {
            Schema::table('cajas', function (Blueprint $table) {
                $table->enum('tipo_cierre', ['monto_fijo', 'billetes'])->nullable()->after('fecha_cierre');
            });
        }

        if (!Schema::hasColumn('cajas', 'tipo_diferencia')) {
            Schema::table('cajas', function (Blueprint $table) {
                $table->enum('tipo_diferencia', ['exacto', 'sobrante', 'faltante'])->nullable()->after('diferencia');
            });
        }

        // 3. Crear tabla arqueos_diarios
        if (!Schema::hasTable('arqueos_diarios')) {
            Schema::create('arqueos_diarios', function (Blueprint $table) {
                $table->bigIncrements('id_arqueo');
                $table->unsignedBigInteger('id_caja');
                $table->integer('id_empresa');
                
                $table->date('fecha_arqueo');
                $table->unsignedBigInteger('usuario_cierre');
                $table->unsignedBigInteger('usuario_validacion');
                
                // Montos
                $table->decimal('saldo_inicial', 12, 2);
                $table->decimal('total_ventas', 12, 2)->default(0);
                $table->decimal('total_ingresos_manuales', 12, 2)->default(0);
                $table->decimal('total_egresos', 12, 2)->default(0);
                $table->decimal('total_teorico', 12, 2);
                $table->decimal('total_real', 12, 2);
                $table->decimal('diferencia', 12, 2);
                $table->enum('tipo_diferencia', ['exacto', 'sobrante', 'faltante']);
                
                // Desglose de ventas por método (JSON)
                $table->json('ventas_por_metodo')->nullable();
                
                // Estado
                $table->enum('estado', ['cerrada', 'rechazada'])->default('cerrada');
                $table->text('observaciones')->nullable();
                
                // Auditoría
                $table->dateTime('fecha_cierre');
                $table->dateTime('fecha_validacion');
                $table->timestamps();
                
                // Relaciones
                $table->foreign('id_caja')->references('id_caja')->on('cajas');
                $table->foreign('id_empresa')->references('id_empresa')->on('empresas');
                $table->foreign('usuario_cierre')->references('id')->on('users');
                $table->foreign('usuario_validacion')->references('id')->on('users');
                
                // Índices
                $table->index(['id_empresa', 'fecha_arqueo']);
                $table->index('usuario_cierre');
                $table->index('usuario_validacion');
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('arqueos_diarios');
        
        Schema::table('cajas', function (Blueprint $table) {
            if (Schema::hasColumn('cajas', 'tipo_apertura')) {
                $table->dropColumn('tipo_apertura');
            }
            if (Schema::hasColumn('cajas', 'tipo_cierre')) {
                $table->dropColumn('tipo_cierre');
            }
            if (Schema::hasColumn('cajas', 'tipo_diferencia')) {
                $table->dropColumn('tipo_diferencia');
            }
        });

        Schema::table('denominaciones_billetes', function (Blueprint $table) {
            if (Schema::hasColumn('denominaciones_billetes', 'nombre')) {
                $table->dropColumn('nombre');
            }
            if (Schema::hasColumn('denominaciones_billetes', 'orden')) {
                $table->dropColumn('orden');
            }
        });
    }
};
