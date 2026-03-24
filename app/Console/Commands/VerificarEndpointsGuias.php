<?php

namespace App\Console\Commands;

use App\Models\GuiaRemision;
use Illuminate\Console\Command;

class VerificarEndpointsGuias extends Command
{
    protected $signature = 'verificar:endpoints-guias';
    protected $description = 'Verificar qué guías lista cada endpoint';

    public function handle()
    {
        $this->line('═══════════════════════════════════════════════════════════════════════════════');
        $this->line('VERIFICACIÓN: Endpoints de Guías de Remisión');
        $this->line('═══════════════════════════════════════════════════════════════════════════════');
        $this->newLine();

        // Endpoint Remitente (T001)
        $this->line('📋 /guia-remision (Remitente - T001):');
        $this->line('─────────────────────────────────────────────────────────────────────────────');
        $remitentes = GuiaRemision::where('serie', 'T001')->get(['id', 'serie', 'numero', 'tipo_doc']);
        if ($remitentes->isEmpty()) {
            $this->warn('  ❌ No hay guías');
        } else {
            foreach ($remitentes as $g) {
                $this->info(sprintf('  ✅ ID %2d: %s-%d (tipo_doc: %s)', $g->id, $g->serie, $g->numero, $g->tipo_doc));
            }
        }
        $this->newLine();

        // Endpoint Transportista (V001)
        $this->line('🚚 /guia-remision-transportista (Transportista - V001):');
        $this->line('─────────────────────────────────────────────────────────────────────────────');
        $transportistas = GuiaRemision::where('serie', 'V001')->get(['id', 'serie', 'numero', 'tipo_doc']);
        if ($transportistas->isEmpty()) {
            $this->warn('  ❌ No hay guías');
        } else {
            foreach ($transportistas as $g) {
                $this->info(sprintf('  ✅ ID %2d: %s-%d (tipo_doc: %s)', $g->id, $g->serie, $g->numero, $g->tipo_doc));
            }
        }
        $this->newLine();

        // Verificar si hay guías sin tipo_doc
        $this->line('⚠️  Guías sin tipo_doc:');
        $this->line('─────────────────────────────────────────────────────────────────────────────');
        $sinTipo = GuiaRemision::whereNull('tipo_doc')->get(['id', 'serie', 'numero']);
        if ($sinTipo->isEmpty()) {
            $this->info('  ✅ Todas las guías tienen tipo_doc');
        } else {
            foreach ($sinTipo as $g) {
                $this->warn(sprintf('  ⚠️  ID %2d: %s-%d (sin tipo_doc)', $g->id, $g->serie, $g->numero));
            }
        }
        
        $this->newLine();
        $this->line('═══════════════════════════════════════════════════════════════════════════════');
    }
}
