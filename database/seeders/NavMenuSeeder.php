<?php

namespace Database\Seeders;

use App\Models\NavMenu;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class NavMenuSeeder extends Seeder
{
    public function run(): void
    {
        // Limpiar tabla existente
        NavMenu::truncate();

        // Menú secundario del ecommerce (debajo del menú de categorías)
        // Estos items aparecen en la barra de navegación principal

        // 1. INICIO
        NavMenu::create([
            'label' => 'Inicio',
            'url' => 'index.php',
            'parent_id' => null,
            'orden' => 1,
            'estado' => '1',
            'target' => '_self',
        ]);

        // 2. PRODUCTOS
        NavMenu::create([
            'label' => 'Productos',
            'url' => 'shop-list-prod.php',
            'parent_id' => null,
            'orden' => 2,
            'estado' => '1',
            'target' => '_self',
        ]);

        // 3. NOVEDADES
        NavMenu::create([
            'label' => 'Novedades',
            'url' => 'shop-list-prod.php?search=+&type=last',
            'parent_id' => null,
            'orden' => 3,
            'estado' => '1',
            'target' => '_self',
        ]);

        // 4. OFERTAS (con subitems)
        $ofertas = NavMenu::create([
            'label' => 'Ofertas',
            'url' => 'shop-list-prod-ofertas.php',
            'parent_id' => null,
            'orden' => 4,
            'estado' => '1',
            'target' => '_self',
        ]);

        NavMenu::create([
            'label' => 'En Remate',
            'url' => 'shop-list-prod-remate.php',
            'parent_id' => $ofertas->id,
            'orden' => 1,
            'estado' => '1',
            'target' => '_self',
        ]);

        NavMenu::create([
            'label' => 'Exclusivos',
            'url' => 'shop-list-prod-exclu.php',
            'parent_id' => $ofertas->id,
            'orden' => 2,
            'estado' => '1',
            'target' => '_self',
        ]);

        NavMenu::create([
            'label' => 'VIP',
            'url' => 'shop-list-vip.php',
            'parent_id' => $ofertas->id,
            'orden' => 3,
            'estado' => '1',
            'target' => '_self',
        ]);

        // 4. PC ARMADAS
        NavMenu::create([
            'label' => 'PC Armadas',
            'url' => 'shop-list-prod-remate.php',
            'parent_id' => null,
            'orden' => 4,
            'estado' => '1',
            'target' => '_self',
        ]);

        // 5. MARCAS
        NavMenu::create([
            'label' => 'Marcas',
            'url' => 'shop-list-mrc.php',
            'parent_id' => null,
            'orden' => 5,
            'estado' => '1',
            'target' => '_self',
        ]);

        // 6. SERVICIOS (con subitems)
        $servicios = NavMenu::create([
            'label' => 'Servicios',
            'url' => '#',
            'parent_id' => null,
            'orden' => 6,
            'estado' => '1',
            'target' => '_self',
        ]);

        NavMenu::create([
            'label' => 'Arma tu PC',
            'url' => 'arma-tu-pc.php',
            'parent_id' => $servicios->id,
            'orden' => 1,
            'estado' => '1',
            'target' => '_self',
        ]);

        NavMenu::create([
            'label' => 'Entregas',
            'url' => 'delivery.php',
            'parent_id' => $servicios->id,
            'orden' => 2,
            'estado' => '1',
            'target' => '_self',
        ]);

        NavMenu::create([
            'label' => 'Contacto',
            'url' => 'contact.php',
            'parent_id' => $servicios->id,
            'orden' => 3,
            'estado' => '1',
            'target' => '_self',
        ]);

        // 7. INFORMACIÓN (con subitems)
        $info = NavMenu::create([
            'label' => 'Información',
            'url' => '#',
            'parent_id' => null,
            'orden' => 7,
            'estado' => '1',
            'target' => '_self',
        ]);

        NavMenu::create([
            'label' => 'Acerca de',
            'url' => 'about.php',
            'parent_id' => $info->id,
            'orden' => 1,
            'estado' => '1',
            'target' => '_self',
        ]);

        NavMenu::create([
            'label' => 'Términos y Condiciones',
            'url' => 'term.php',
            'parent_id' => $info->id,
            'orden' => 2,
            'estado' => '1',
            'target' => '_self',
        ]);

        NavMenu::create([
            'label' => 'Preguntas Frecuentes',
            'url' => 'faq.html',
            'parent_id' => $info->id,
            'orden' => 3,
            'estado' => '1',
            'target' => '_self',
        ]);
    }
}
