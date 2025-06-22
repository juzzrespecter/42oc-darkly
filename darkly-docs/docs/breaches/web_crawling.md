# Web scraping
### Owasp

`Scraping` es una técnica que puede ser usada en detección de vulnerabilidades, que consiste en la recopilación y acceso de todos los links presentes en una aplicación web de forma recursiva. 

Esto nos permite explorar todos directorios y archivos a los que puede tener acceso un usuario, y encontrar ficheros, archivos de credenciales o directorios mal configurados que nos permitan aprovechar una vulnerabilidad.

## Ataque 
En este caso, tenemos un directorio descubierto por la lectura del archivo **robots.txt**, en el que vemos muchas carpetas anidadas y un fichero README. Esperamos que en alguno de estos readmes se encuentre nuestra flag, así que creamos un pequeño script que recorra de forma recursiva por todos los directorios y nos imprima el fichero que contenga la flag.

```bash
docker run --rm -v ./crawler.py:/crawler.py python sh -c "pip install requests bs4; python crawler.py http://<IP>/.hidden/"
```

## Mitigaciones
Control de acceso a recursos y revisión de ficheros.
Tema de control de peticiones, user-agent, etx

## Referencias

- [Definición de la amenaza Scraping por OWASP](https://owasp.org/www-project-automated-threats-to-web-applications/assets/oats/EN/OAT-011_Scraping)
- [OWASP: Path Traversal Attack](https://owasp.org/www-community/attacks/Path_Traversal)