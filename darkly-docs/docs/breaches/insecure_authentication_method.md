# Path Traversal | Explotación de archivo htpasswd
### A07:2021 – Identification and Authentication Failures
### A02:2021 – Cryptographic Failures

Aunque no sea exactamente un ataque de path traversal, se incluye como tipo de vulnerabilidad ya que implica el acceso a directorios que no forman parte de la lógica de la aplicación.

El fichero **robots.txt** es un fichero que permite excluir distintos directorios y ficheros en la rutina de búsqueda de crawlers y bots para indexadores y buscadores. Un mal uso de este archivo es tratar de ocultar recursos sensibles, ya que estos siguen siendo accesibles.

## Ataque

- **Localización**: /whatever/

En el reconocimiento inicial, hemos visto que el servidor usa el fichero **robots.txt** para ocultar ciertos archivos o directorios de crawlers.


Nos centramos aquí en la carpeta **whatever**, en donde encontramos un archivo **htpasswd**, que es un archivo de credenciales para acceso por roles.

Obtenemos el archivo en local para ver su contenido.

```bash
curl http://192.168.13.47/whatever/htpaswd -o htpasswd -L && cat htpasswd

root:437394baff5aa33daa618be47b75cb49
```

Hemos obtenido un archivo con lo que parece ser credenciales para el usuario root, y el hash es sospechosamente parecido a un **MD5**.

Lanzamos un john para ver si podemos crackearlo.

```
./john --format=raw-md5 --wordlist=rockyou.txt ./htpasswd
```

Son credenciales de admin, pues nos intentamos loggear como admin.
Usamos las credenciales en la URL **/index.php?page=admin**, donde se presenta un formulario para introducir credenciales de administración, obtenemos la flag.

## Mitigaciones

- Uso de algoritmos de encriptación fuertes y actualizados.
- Revisión y correcta gestión del sistema de archivos de la aplicación.

## Referencias

- [OWASP: Path Traversal](https://owasp.org/www-community/attacks/Path_Traversal)
- [OWASP: Testing for Weak Encryption](https://owasp.org/www-project-web-security-testing-guide/v41/4-Web_Application_Security_Testing/09-Testing_for_Weak_Cryptography/04-Testing_for_Weak_Encryption)