# Local File Inclusion
### A03:2021 – Injection

La vulnerabilidad de **inclusión de archivo local** consiste en la posible carga de ficheros no expuestos por parte del propio servidor.
Esta vulnerabilidad se produce por una falta de validación de los parámetros de entrada por el usuario en inputs, y a través de este ataque podemos obtener archivos de configuración o de credenciales que de otra forma estarían restringidos. 

## Ataque

- **Localización**: /index.php?page=xxx

La navegación en la aplicación se realiza a través de el query param **page**, donde se envía el nombre del archivo a renderizar de la siguiente manera.

```php
<?php
include($_GET['page'] . '.php');
?>
```

Si no se sanitiza bien este input, podemos forzar al servidor a que intente cargar un archivo dentro de su sistema de ficheros local que tenga información comprometida, como por ejemplo `/etc/passwd`.

Lo intentamos.
```
http://xxx.xxx.xxx.xxx/index.php?page=../../../../../../../etc/passwd
```

Y obtenemos la flag.
## Mitigación

## Referencias
- [OWASP: Testing for Local File Inclusion](https://owasp.org/www-project-web-security-testing-guide/v42/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion)