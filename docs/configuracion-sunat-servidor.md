# Configuración del Servidor para SUNAT - Facturación Electrónica

## Resumen
Documentación de los pasos realizados para configurar el envío de comprobantes electrónicos (XML) a SUNAT desde el servidor de producción (ilidesava.com).

---

## 1. Error: OpenSSL 3.x - "invalid digest"

### Problema
Al generar el XML firmado, OpenSSL 3.x rechaza el algoritmo SHA1 usado por los certificados digitales de SUNAT:

```
error:0308010C:digital envelope routines::unsupported
invalid digest
```

### Causa
OpenSSL 3.x deshabilitó SHA1 por defecto al considerarlo inseguro. Sin embargo, SUNAT aún requiere certificados firmados con SHA1.

### Solución
Habilitar el proveedor legacy de OpenSSL y permitir SHA1:

```bash
# Cambiar la política de criptografía del sistema
sudo update-crypto-policies --set DEFAULT:SHA1

# Reiniciar PHP-FPM para que tome los cambios
sudo systemctl restart php-fpm
```

**Alternativa manual** (si `update-crypto-policies` no está disponible):

Editar `/etc/pki/tls/openssl.cnf` y agregar al inicio:

```ini
openssl_conf = openssl_init

[openssl_init]
providers = provider_sect

[provider_sect]
default = default_sect
legacy = legacy_sect

[default_sect]
activate = 1

[legacy_sect]
activate = 1
```

---

## 2. Error: "Permission denied" al crear directorios en storage

### Problema
```
mkdir(): Permission denied
```
PHP no podía crear carpetas dentro de `storage/app/sunat/` para guardar los XML generados.

### Solución
Asignar permisos correctos al directorio storage:

```bash
# Dar permisos de escritura
sudo chmod -R 775 /var/www/html/facturacion_ilidesava/storage

# Asignar propietario al usuario de Apache/PHP-FPM
sudo chown -R apache:apache /var/www/html/facturacion_ilidesava/storage
```

---

## 3. Error: "Could not connect to host" (SOAP)

### Problema
Al intentar enviar el XML a SUNAT vía SOAP, la conexión fallaba:

```
SoapFault: Could not connect to host
```

### Causa
**SELinux** estaba bloqueando las conexiones de red salientes desde Apache/PHP-FPM.

### Diagnóstico
```bash
# Verificar que SOAP está instalado
php -m | grep soap

# Verificar que curl funciona desde CLI
curl -v https://e-beta.sunat.gob.pe

# Test de SoapClient desde PHP CLI (funciona porque CLI no pasa por SELinux de httpd)
php -r "new SoapClient('https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService?wsdl'); echo 'OK';"
```

Si desde CLI funciona pero desde el navegador (Apache/PHP-FPM) no, el problema es SELinux.

### Solución
Permitir a Apache/httpd hacer conexiones de red salientes:

```bash
sudo setsebool -P httpd_can_network_connect 1
```

> **Nota:** El flag `-P` hace el cambio permanente (persiste después de reiniciar).

### ¿Es seguro?
Sí. Este booleano de SELinux solo permite que httpd (Apache) realice conexiones TCP salientes. No desactiva SELinux ni abre puertos. Es la configuración estándar para cualquier servidor web que necesite conectarse a APIs externas (SUNAT, pasarelas de pago, etc.).

---

## 4. Configuración de modo Beta/Pruebas

### Problema
La empresa en la base de datos tenía `modo: production` en vez de `modo: beta`, lo que hacía que intentara conectarse al endpoint de producción de SUNAT (que requiere certificado real y credenciales de producción).

### Solución
Actualizar el campo `modo` de la empresa en la base de datos:

```sql
UPDATE empresas SET modo = 'beta' WHERE id_empresa = 1;
```

### Endpoints de SUNAT

| Modo | Endpoint |
|------|----------|
| Beta | `https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService` |
| Producción | `https://e-factura.sunat.gob.pe/ol-ti-itcpfegem/billService` |

### Credenciales Beta (fijas por SUNAT)
```
RUC: 20000000001
Usuario SOL: MODDATOS
Clave SOL: moddatos
```

Estas credenciales están configuradas en `config/sunat.php`.

---

## 5. Certificado Digital

### Ubicación
El certificado `.pem` se almacena en:
```
storage/app/sunat/certificados/{RUC}-cert.pem
```

Si no existe, se usa el certificado de fallback:
```
storage/app/sunat/resources/cert.pem
```

### Formato
El certificado debe estar en formato PEM (`.pem`), conteniendo tanto el certificado como la clave privada:

```
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
-----BEGIN PRIVATE KEY-----
...
-----END PRIVATE KEY-----
```

### Convertir desde .pfx/.p12
Si tienes un certificado en formato `.pfx` o `.p12`:

```bash
openssl pkcs12 -in certificado.pfx -out certificado.pem -nodes
```

---

## 6. Verificación Final

### Checklist del servidor
```bash
# 1. PHP tiene SOAP habilitado
php -m | grep soap

# 2. OpenSSL permite SHA1
php -r "echo openssl_get_md_methods() ? 'OK' : 'FAIL';"

# 3. SELinux permite conexiones salientes
getsebool httpd_can_network_connect
# Debe mostrar: httpd_can_network_connect --> on

# 4. Permisos de storage
ls -la /var/www/html/facturacion_ilidesava/storage/app/sunat/

# 5. Certificado existe
ls -la /var/www/html/facturacion_ilidesava/storage/app/sunat/certificados/

# 6. Test de conexión a SUNAT
curl -s -o /dev/null -w "%{http_code}" https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService
# Debe retornar: 200 o 500 (500 es normal sin enviar SOAP request válido)
```

### Test desde la aplicación
1. Ir a Ventas → seleccionar una venta
2. Click en "Enviar a SUNAT" (icono de avión)
3. Debe generar el XML, firmarlo y enviarlo al endpoint beta
4. Si retorna código 0 de SUNAT = éxito

---

## 7. Archivos Relevantes

| Archivo | Descripción |
|---------|-------------|
| `config/sunat.php` | Configuración de endpoints y credenciales |
| `app/Services/SunatService.php` | Servicio principal de generación y envío |
| `app/Http/Controllers/ComprobanteElectronicoController.php` | Controller de la API |
| `vendor/greenter/lite/src/Greenter/See.php` | Librería Greenter (firmado + envío SOAP) |
| `storage/app/sunat/certificados/` | Certificados digitales |
| `storage/app/sunat/xml/` | XMLs generados |
| `storage/app/sunat/cdr/` | CDRs recibidos de SUNAT |

---

## 8. Limpieza Post-Configuración

Eliminar archivos de prueba creados durante la configuración:

```bash
rm /var/www/html/facturacion_ilidesava/public/test_soap.php
```
