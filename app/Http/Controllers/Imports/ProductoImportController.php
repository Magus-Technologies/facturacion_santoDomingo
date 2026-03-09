<?php

namespace App\Http\Controllers\Imports;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use PhpOffice\PhpSpreadsheet\IOFactory;

class ProductoImportController extends Controller
{
    /**
     * Leer archivo Excel y devolver lista normalizada de productos.
     * Detecta automáticamente el formato del cliente o el de la plantilla propia.
     */
    public function leerExcel(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'archivo' => 'required|file|mimes:xlsx,xls,csv|max:10240',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Archivo no válido',
                    'errors'  => $validator->errors()
                ], 422);
            }

            $user    = $request->user();
            $file    = $request->file('archivo');

            // Obtener empresa activa (primero actualizar idEmpresa, luego buscar nombre)
            $idEmpresa = $user->id_empresa;
            if ($request->header('X-Empresa-Activa')) {
                $idEmpresa = $request->header('X-Empresa-Activa');
            }
            $empresa = DB::table('empresas')->where('id_empresa', $idEmpresa)->first();
            $nombreEmpresa = $empresa ? ($empresa->razon_social ?? $empresa->nombre ?? null) : null;

            // Cargar Excel
            $spreadsheet = IOFactory::load($file->getPathname());
            $sheet       = $spreadsheet->getActiveSheet();
            $rows        = $sheet->toArray(null, true, false, false); // índice 0-based, sin formato (valores numéricos crudos)

            if (empty($rows)) {
                return response()->json(['success' => false, 'message' => 'El archivo está vacío'], 422);
            }

            // ── Detección de formato ──────────────────────────────────────
            $primeraFila = array_map('strval', $rows[0]);
            $primeraFila = array_map('trim', $primeraFila);
            $headerUpper = array_map(fn($s) => mb_strtoupper($s, 'UTF-8'), $primeraFila);

            $formatoCliente = in_array('CODIGOITEM', $headerUpper);
            $formatoPropio  = !$formatoCliente && (
                in_array('PRODUCTO', $headerUpper) ||
                in_array('CÓDIGO',   $headerUpper) ||
                in_array('CODIGO',   $headerUpper)
            );

            if (!$formatoCliente && !$formatoPropio) {
                return response()->json([
                    'success' => false,
                    'message' => 'Formato de archivo no reconocido. Por favor descargue la plantilla del sistema e intente de nuevo.',
                    'detalle' => 'La primera fila debe contener los encabezados correctos. Se esperaba "Código" / "Producto" (plantilla propia) o "CODIGOITEM" / "DESCRIPCIONITEM" (formato cliente).',
                ], 422);
            }

            // Quitar fila de encabezado
            array_shift($rows);

            $warnings       = [];
            $productos      = [];
            $omitidosSinStock = 0;

            // ── Mapeador según formato ────────────────────────────────────
            if ($formatoCliente) {
                // Detectar posición de cada columna por nombre (flexible ante columnas extra)
                $colCodigo      = array_search('CODIGOITEM',        $headerUpper);
                $colNombre      = array_search('DESCRIPCIONITEM',    $headerUpper);
                $colCategoria   = array_search('MARCAITEM',          $headerUpper);
                $colDescAlmacen = array_search('DESCRIPCIONALMACEN', $headerUpper);
                $colMoneda      = array_search('MONEDA',             $headerUpper);
                $colCosto       = array_search('COSTOPROMEDIO',      $headerUpper);
                $colStock       = array_search('STOCK',              $headerUpper);
                $colPrecio      = array_search('VALORTOTAL',         $headerUpper);

                // Unidad: buscar columna cuyo header contenga "UNIDAD"
                $colUnidad = null;
                foreach ($headerUpper as $i => $h) {
                    if (str_contains($h, 'UNIDAD') && $i !== $colCategoria) {
                        $colUnidad = $i;
                        break;
                    }
                }

                $nombresAlmacenVistos = [];

                foreach ($rows as $index => $row) {
                    $codigoVal = trim((string)($colCodigo !== false ? ($row[$colCodigo] ?? '') : ''));
                    $nombreVal = trim((string)($colNombre !== false ? ($row[$colNombre] ?? '') : ''));

                    // Saltar filas completamente vacías
                    if (empty($codigoVal) && empty($nombreVal)) {
                        continue;
                    }

                    $descAlmacen = $colDescAlmacen !== false ? trim((string)($row[$colDescAlmacen] ?? '')) : '';
                    if ($descAlmacen && !in_array($descAlmacen, $nombresAlmacenVistos)) {
                        $nombresAlmacenVistos[] = $descAlmacen;
                    }

                    $stockVal  = $colStock !== false && !empty($row[$colStock]) ? floatval($row[$colStock]) : 0;

                    // Omitir productos sin stock
                    if ($stockVal <= 0) {
                        $omitidosSinStock++;
                        continue;
                    }

                    $monedaRaw = strtoupper(trim((string)($colMoneda !== false ? ($row[$colMoneda] ?? '') : '')));
                    $moneda    = $this->mapearMoneda($monedaRaw);

                    $unidadVal = $colUnidad !== false ? trim((string)($row[$colUnidad] ?? '')) : '';

                    $productos[] = [
                        'codigoProd'      => $codigoVal,
                        'producto'        => $nombreVal,
                        'descripcicon'    => '',
                        'categoria'       => $colCategoria !== false ? trim((string)($row[$colCategoria] ?? '')) : '',
                        'unidad'          => $unidadVal,
                        'moneda'          => $moneda,
                        'costo'           => $colCosto  !== false && !empty($row[$colCosto])  ? floatval($row[$colCosto])  : 0,
                        'cantidad'        => $stockVal,
                        'precio_unidad'   => $colPrecio !== false && !empty($row[$colPrecio]) ? floatval($row[$colPrecio]) : 0,
                        'precio_mayor'    => 0,
                        'precio_menor'    => 0,
                    ];
                }

                // Warning empresa
                if (!empty($nombresAlmacenVistos) && $nombreEmpresa) {
                    foreach ($nombresAlmacenVistos as $descAlmacen) {
                        $coincide = $this->nombreEmpresaCoincide($descAlmacen, $nombreEmpresa);
                        if (!$coincide) {
                            $warnings[] = [
                                'tipo'    => 'empresa',
                                'mensaje' => "La columna DESCRIPCIONALMACEN contiene \"{$descAlmacen}\", que no coincide exactamente con la empresa activa (\"{$nombreEmpresa}\"). Los productos se importarán a la empresa activa de todos modos.",
                            ];
                        }
                    }
                }

                // Warning unidad
                if ($colUnidad !== null) {
                    $warnings[] = [
                        'tipo'    => 'unidad',
                        'mensaje' => 'Se detectó la columna de Unidad en el Excel del cliente. Los productos sin unidad se asignarán a "UNIDAD (NIU)" por defecto.',
                    ];
                } else {
                    $warnings[] = [
                        'tipo'    => 'unidad',
                        'mensaje' => 'Este formato de Excel no incluye columna de Unidad. Todos los productos se asignarán a "UNIDAD (NIU)" por defecto. Puede cambiarla desde la lista antes de importar.',
                    ];
                }

                // Warning categorías nuevas
                $categoriasNuevas = $this->detectarCategoriasNuevas($productos, $idEmpresa);
                if (!empty($categoriasNuevas)) {
                    $warnings[] = [
                        'tipo'    => 'categorias',
                        'mensaje' => 'Se crearán ' . count($categoriasNuevas) . ' categoría(s) nueva(s) automáticamente: ' . implode(', ', $categoriasNuevas) . '.',
                    ];
                }

            } else {
                // Formato propio (flexible): detecta columnas por nombre, no por posición fija.
                // Soporta plantilla del sistema y cualquier variante con encabezados similares.
                $pC  = $this->buscarColumna($headerUpper, ['CÓDIGO', 'CODIGO', 'COD']);
                $pN  = $this->buscarColumna($headerUpper, ['PRODUCTO', 'NOMBRE', 'DESCRIPCION', 'DESCRIPCIÓN']);
                $pD  = $this->buscarColumna($headerUpper, ['DETALLE']);
                $pCa = $this->buscarColumna($headerUpper, ['CATEGORÍA', 'CATEGORIA', 'MARCA', 'MARCAITEM']);
                $pU  = $this->buscarColumna($headerUpper, ['UNIDAD', 'MEDIDA', 'UNIDAD DE MEDIDA']);
                $pMo = $this->buscarColumna($headerUpper, ['MONEDA']);
                $pCo = $this->buscarColumna($headerUpper, ['COSTO', 'COSTOPROMEDIO', 'COSTO PROMEDIO', 'PRECIO COSTO']);
                $pSt = $this->buscarColumna($headerUpper, ['STOCK', 'CANTIDAD', 'EXISTENCIA']);
                $pPv = $this->buscarColumna($headerUpper, ['PRECIO VTA', 'PRECIO VENTA', 'PRECIO UNITARIO', 'PRECIO UNIDAD', 'PRECIOVTA', 'VALORTOTAL', 'VALOR TOTAL']);
                $pPm = $this->buscarColumna($headerUpper, ['PRECIO DISTRIBUIDOR', 'PRECIO DIST', 'PRECIO MAYOR']);
                $pPn = $this->buscarColumna($headerUpper, ['PRECIO MAYORISTA', 'PRECIO MENOR', 'PRECIO MINORISTA']);

                foreach ($rows as $index => $row) {
                    $nombreVal  = trim((string)(($pN  !== null ? $row[$pN]  : null) ?? ''));
                    $codigoVal  = trim((string)(($pC  !== null ? $row[$pC]  : null) ?? ''));

                    // Saltar fila de ejemplo
                    if ($nombreVal === 'Nombre del producto') {
                        continue;
                    }
                    // Saltar filas vacías
                    if (empty($codigoVal) && empty($nombreVal)) {
                        continue;
                    }

                    $stockVal = ($pSt !== null && !empty($row[$pSt])) ? floatval($row[$pSt]) : 0;

                    // Omitir productos sin stock
                    if ($stockVal <= 0) {
                        $omitidosSinStock++;
                        continue;
                    }

                    $monedaRaw = $pMo !== null ? strtoupper(trim((string)($row[$pMo] ?? ''))) : '';
                    $moneda    = $this->mapearMoneda($monedaRaw);

                    $productos[] = [
                        'codigoProd'    => $codigoVal,
                        'producto'      => $nombreVal,
                        'descripcicon'  => trim((string)(($pD  !== null ? $row[$pD]  : null) ?? '')),
                        'categoria'     => trim((string)(($pCa !== null ? $row[$pCa] : null) ?? '')),
                        'unidad'        => trim((string)(($pU  !== null ? $row[$pU]  : null) ?? '')),
                        'moneda'        => $moneda,
                        'costo'         => ($pCo !== null && !empty($row[$pCo])) ? floatval($row[$pCo]) : 0,
                        'cantidad'      => $stockVal,
                        'precio_unidad' => ($pPv !== null && !empty($row[$pPv])) ? floatval($row[$pPv]) : 0,
                        'precio_mayor'  => ($pPm !== null && !empty($row[$pPm])) ? floatval($row[$pPm]) : 0,
                        'precio_menor'  => ($pPn !== null && !empty($row[$pPn])) ? floatval($row[$pPn]) : 0,
                    ];
                }

                // Warning categorías nuevas
                $categoriasNuevas = $this->detectarCategoriasNuevas($productos, $idEmpresa);
                if (!empty($categoriasNuevas)) {
                    $warnings[] = [
                        'tipo'    => 'categorias',
                        'mensaje' => 'Se crearán ' . count($categoriasNuevas) . ' categoría(s) nueva(s) automáticamente: ' . implode(', ', $categoriasNuevas) . '.',
                    ];
                }

                // Warning unidades por defecto
                $sinUnidad = collect($productos)->filter(fn($p) => empty($p['unidad']))->count();
                if ($sinUnidad > 0) {
                    $warnings[] = [
                        'tipo'    => 'unidad',
                        'mensaje' => "{$sinUnidad} producto(s) sin unidad serán asignados a \"UNIDAD (NIU)\" por defecto.",
                    ];
                }
            }

            // Warning: productos omitidos por stock 0
            if ($omitidosSinStock > 0) {
                $warnings[] = [
                    'tipo'    => 'stock_cero',
                    'mensaje' => "{$omitidosSinStock} producto(s) omitido(s) porque tienen stock 0.",
                ];
            }

            // ── Detectar códigos duplicados y marcar cada producto ────────
            $codigosVistos = [];
            foreach ($productos as $idx => $prod) {
                $cod = trim($prod['codigoProd'] ?? '');
                if (!empty($cod)) {
                    if (isset($codigosVistos[$cod])) {
                        $productos[$codigosVistos[$cod]]['duplicado'] = true;
                        $productos[$idx]['duplicado'] = true;
                    } else {
                        $codigosVistos[$cod] = $idx;
                    }
                }
            }
            $codigosDuplicados = array_values(array_unique(
                array_keys(array_filter(
                    array_count_values(array_filter(array_column($productos, 'codigoProd'), fn($c) => !empty($c))),
                    fn($n) => $n > 1
                ))
            ));
            if (!empty($codigosDuplicados)) {
                $warnings[] = [
                    'tipo'    => 'duplicados',
                    'mensaje' => count($codigosDuplicados) . ' código(s) duplicado(s) en el Excel: ' . implode(', ', $codigosDuplicados) . '. Edita los códigos antes de importar para evitar que se sobreescriban.',
                ];
            }

            if (empty($productos)) {
                $msg = 'No se encontraron productos con stock en el archivo.';
                if ($omitidosSinStock > 0) {
                    $msg .= " Se omitieron {$omitidosSinStock} producto(s) con stock 0.";
                }
                return response()->json(['success' => false, 'message' => $msg], 422);
            }

            return response()->json([
                'success'          => true,
                'data'             => $productos,
                'total'            => count($productos),
                'warnings'         => $warnings,
                'formato_detectado' => $formatoCliente ? 'cliente' : 'propio',
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al leer archivo: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Importar lista de productos con creación automática de categorías y unidades.
     */
    public function importarLista(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'almacen'           => 'required|exists:almacenes,id',
                'lista'             => 'required|array|min:1',
                'lista.*.producto'  => 'required|string',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Datos no válidos',
                    'errors'  => $validator->errors()
                ], 422);
            }

            $user = $request->user();

            // Obtener empresa activa
            $idEmpresa = $user->id_empresa;
            if ($request->header('X-Empresa-Activa')) {
                $idEmpresa = $request->header('X-Empresa-Activa');
            }

            $almacenDestino = $request->almacen;
            $lista          = $request->lista;

            $importados         = 0;
            $actualizados       = 0;
            $categoriasCreadas  = 0;
            $unidadesCreadas    = 0;
            $errores            = [];

            DB::beginTransaction();

            // ── Cache de categorías existentes ────────────────────────────
            $categoriasCache = DB::table('categorias')
                ->where('estado', '1')
                ->get(['id', 'nombre'])
                ->keyBy(fn($c) => strtolower(trim($c->nombre)));

            // ── Cache de unidades existentes ──────────────────────────────
            $unidadesCache = DB::table('unidades')
                ->where('estado', '1')
                ->get(['id', 'nombre', 'codigo'])
                ->keyBy(fn($u) => strtolower(trim($u->nombre)));

            // ID de unidad por defecto: buscar "UNIDAD" o "NIU" en la tabla, nunca asumir ID fijo
            $unidadDefault = $unidadesCache['unidad'] ?? $unidadesCache['niu'] ?? $unidadesCache->first();
            if (!$unidadDefault) {
                // No existe ninguna unidad: crear "UNIDAD" como base
                $nuevoId = DB::table('unidades')->insertGetId([
                    'nombre'     => 'UNIDAD',
                    'estado'     => '1',
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
                $unidadDefault = (object)['id' => $nuevoId, 'nombre' => 'UNIDAD'];
                $unidadesCache['unidad'] = $unidadDefault;
            }
            $unidadDefaultId = $unidadDefault->id;

            foreach ($lista as $index => $item) {
                try {
                    $codigo      = trim($item['codigoProd'] ?? '');
                    $nombreProd  = trim($item['producto'] ?? '');
                    $detalle     = trim($item['descripcicon'] ?? '');

                    // Si el nombre supera 255 chars, truncar y mover el exceso a descripcion
                    if (mb_strlen($nombreProd) > 255) {
                        $detalle    = $nombreProd . ($detalle ? "\n" . $detalle : '');
                        $nombreProd = mb_substr($nombreProd, 0, 252) . '...';
                    }

                    $categoriaNombre = trim($item['categoria'] ?? '');
                    $unidadNombre    = trim($item['unidad'] ?? '');
                    $moneda          = $this->mapearMoneda(strtoupper($item['moneda'] ?? 'PEN'));

                    // ── Resolver categoría ────────────────────────────────
                    $categoriaId = null;
                    if (!empty($categoriaNombre)) {
                        $clave = strtolower($categoriaNombre);
                        if (isset($categoriasCache[$clave])) {
                            $categoriaId = $categoriasCache[$clave]->id;
                        } else {
                            // Crear categoría nueva
                            $nuevaCatId = DB::table('categorias')->insertGetId([
                                'nombre'     => $categoriaNombre,
                                'estado'     => '1',
                                'created_at' => now(),
                                'updated_at' => now(),
                            ]);
                            $categoriaId = $nuevaCatId;
                            $categoriasCache[$clave] = (object)['id' => $nuevaCatId, 'nombre' => $categoriaNombre];
                            $categoriasCreadas++;
                        }
                    }

                    // ── Resolver unidad ───────────────────────────────────
                    $unidadId = $unidadDefaultId;
                    if (!empty($unidadNombre)) {
                        $clave = strtolower($unidadNombre);
                        if (isset($unidadesCache[$clave])) {
                            $unidadId = $unidadesCache[$clave]->id;
                        } else {
                            // Crear unidad nueva
                            $nuevaUnidadId = DB::table('unidades')->insertGetId([
                                'nombre'     => strtoupper($unidadNombre),
                                'estado'     => '1',
                                'created_at' => now(),
                                'updated_at' => now(),
                            ]);
                            $unidadId = $nuevaUnidadId;
                            $unidadesCache[$clave] = (object)['id' => $nuevaUnidadId, 'nombre' => $unidadNombre];
                            $unidadesCreadas++;
                        }
                    }

                    // ── Preparar datos del producto ───────────────────────
                    $datos = [
                        'nombre'        => $nombreProd,
                        'descripcion'   => $detalle,
                        'precio'        => floatval($item['precio_unidad'] ?? 0),
                        'precio_unidad' => floatval($item['precio_unidad'] ?? 0),
                        'precio_mayor'  => floatval($item['precio_mayor'] ?? 0),
                        'precio_menor'  => floatval($item['precio_menor'] ?? 0),
                        'almacen'       => $almacenDestino,
                        'costo'         => floatval($item['costo'] ?? 0),
                        'cantidad'      => floatval($item['cantidad'] ?? 0),
                        'estado'        => '1',
                        'moneda'        => $moneda,
                        'categoria_id'  => $categoriaId,
                        'unidad_id'     => $unidadId,
                        'updated_at'    => now(),
                    ];

                    // ── Insertar o actualizar en almacén destino ──────────
                    $condicion = ['id_empresa' => $idEmpresa, 'almacen' => $almacenDestino];
                    if (!empty($codigo)) {
                        $condicion['codigo'] = $codigo;
                    } else {
                        // Sin código, buscar por nombre exacto
                        $condicion['nombre'] = $nombreProd;
                    }

                    $productoExistente = DB::table('productos')->where($condicion)->first();

                    if ($productoExistente) {
                        DB::table('productos')
                            ->where('id_producto', $productoExistente->id_producto)
                            ->update($datos);
                        $actualizados++;
                    } else {
                        $datos['codigo']         = !empty($codigo) ? $codigo : null;
                        $datos['id_empresa']     = $idEmpresa;
                        $datos['fecha_registro'] = now();
                        $datos['codsunat']       = '51121703';
                        $datos['created_at']     = now();

                        DB::table('productos')->insert($datos);
                        $importados++;
                    }

                } catch (\Exception $e) {
                    $msgError = $e->getMessage();
                    if (str_contains($msgError, 'Data too long')) {
                        $msgError = 'El nombre del producto es demasiado largo';
                    } elseif (str_contains($msgError, 'Duplicate entry')) {
                        $msgError = 'Código duplicado, el producto ya existe';
                    } elseif (str_contains($msgError, 'foreign key constraint')) {
                        $msgError = 'Referencia inválida (categoría o unidad no existe)';
                    } elseif (str_contains($msgError, 'SQLSTATE')) {
                        $msgError = 'Error de base de datos al insertar producto';
                    }
                    $errores[] = 'Fila ' . ($index + 2) . ': ' . $msgError;
                }
            }

            DB::commit();

            $mensaje = "Importación completada: {$importados} nuevos, {$actualizados} actualizados";
            if ($categoriasCreadas > 0) {
                $mensaje .= ", {$categoriasCreadas} categoría(s) creada(s)";
            }
            if ($unidadesCreadas > 0) {
                $mensaje .= ", {$unidadesCreadas} unidad(es) creada(s)";
            }
            if (!empty($errores)) {
                $totalErrores = count($errores);
                $mensaje .= ". {$totalErrores} producto(s) no pudieron importarse";
                if ($totalErrores <= 5) {
                    $mensaje .= ': ' . implode('; ', $errores);
                } else {
                    $mensaje .= ' (primeros: ' . implode('; ', array_slice($errores, 0, 3)) . '...)';
                }
            }

            return response()->json([
                'success' => true,
                'message' => $mensaje,
                'data'    => [
                    'importados'        => $importados,
                    'actualizados'      => $actualizados,
                    'categorias_creadas' => $categoriasCreadas,
                    'unidades_creadas'  => $unidadesCreadas,
                    'errores'           => count($errores),
                ],
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Error al importar productos: ' . $e->getMessage()
            ], 500);
        }
    }

    // ── Helpers privados ──────────────────────────────────────────────────

    private function mapearMoneda(string $valor): string
    {
        $mapa = [
            'SOLES'    => 'PEN',
            'SOL'      => 'PEN',
            'PEN'      => 'PEN',
            'S/'       => 'PEN',
            'DOLARES'  => 'USD',
            'DÓLARES'  => 'USD',
            'DOLAR'    => 'USD',
            'DÓLAR'    => 'USD',
            'USD'      => 'USD',
            '$'        => 'USD',
        ];
        return $mapa[$valor] ?? 'PEN';
    }

    private function nombreEmpresaCoincide(string $descAlmacen, string $nombreEmpresa): bool
    {
        $a = strtolower(trim($descAlmacen));
        $b = strtolower(trim($nombreEmpresa));

        if ($a === $b) return true;
        if (str_contains($b, $a) || str_contains($a, $b)) return true;

        // Comparar versiones sin espacios ni símbolos (ej: "ARIESDM" vs "ARIES D & M")
        $aSinEspacios = preg_replace('/[\s&\-_.,\/]+/', '', $a);
        $bSinEspacios = preg_replace('/[\s&\-_.,\/]+/', '', $b);
        if ($aSinEspacios === $bSinEspacios) return true;
        if (str_contains($bSinEspacios, $aSinEspacios) || str_contains($aSinEspacios, $bSinEspacios)) return true;

        // Palabras genéricas a ignorar en la comparación
        $stopWords = ['de', 'del', 'la', 'el', 'los', 'las', 'y', 'en', 'a', 'con',
                      'ventas', 'almacen', 'almacén', 'tienda', 'bodega', 'deposito',
                      'deposito', 'depósito', 'store', 'shop'];

        $palabrasA = array_filter(explode(' ', $a), fn($w) => strlen($w) >= 4 && !in_array($w, $stopWords));
        $palabrasB = array_filter(explode(' ', $b), fn($w) => strlen($w) >= 4 && !in_array($w, $stopWords));

        // Coincide si al menos UNA palabra significativa del Excel aparece en el nombre empresa
        foreach ($palabrasA as $palabra) {
            if (in_array($palabra, $palabrasB) || str_contains($b, $palabra)) {
                return true;
            }
        }

        return false;
    }

    private function detectarCategoriasNuevas(array $productos, $idEmpresa): array
    {
        $categoriasEnExcel = array_filter(array_unique(
            array_map(fn($p) => trim($p['categoria'] ?? ''), $productos)
        ));

        if (empty($categoriasEnExcel)) return [];

        $existentes = DB::table('categorias')
            ->where('estado', '1')
            ->whereIn(DB::raw('LOWER(TRIM(nombre))'), array_map('strtolower', $categoriasEnExcel))
            ->pluck('nombre')
            ->map(fn($n) => strtolower(trim($n)))
            ->toArray();

        $nuevas = [];
        foreach ($categoriasEnExcel as $cat) {
            if (!in_array(strtolower($cat), $existentes)) {
                $nuevas[] = $cat;
            }
        }

        return $nuevas;
    }

    /**
     * Busca el índice de una columna en los encabezados (en mayúsculas).
     * Acepta múltiples nombres alternativos.
     */
    private function buscarColumna(array $headers, array $nombres): ?int
    {
        foreach ($nombres as $nombre) {
            $idx = array_search(mb_strtoupper($nombre, 'UTF-8'), $headers);
            if ($idx !== false) return $idx;
        }
        return null;
    }
}
