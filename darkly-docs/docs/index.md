# Investigaciones sobre Darkly

Cuaderno de desarrollo del proyecto **Darkly** en 42, donde se expondrán las principales vulnerabilidades en desarrollo web, siguiendo la metodología propuesta por [el framework de ciberseguridad OWASP](https://owasp.org/www-project-web-security-testing-guide/).

## Recopilación de información
**WSTG-INFO-01**

Como primer paso en el reconocimiento de la página, realizamos un scrappeo inicial. De primeras observamos que el servidor enmascara los 404 retornando un 200, con una respuesta siempre de 975 bytes (el tamaño de la página de error), podemos usar este dato para filtrar misses en el crawleo.

```bash
./gospider -v -s http://192.168.13.47 --blacklist "html5shiv.js|.hidden" -d 3

./gospider -s http://192.168.13.47 --blacklist "html5shiv.js|.hidden" -d 3 -v
[0000]  INFO Start crawling: http://192.168.13.47
[0000]  INFO Found robots.txt: http://192.168.13.47/robots.txt
[robots] - http://192.168.13.47/whatever
[robots] - http://192.168.13.47/.hidden
[url] - [code-200] - http://192.168.13.47/whatever/
[href] - http://192.168.13.47/
[href] - http://192.168.13.47/whatever/htpasswd
[url] - [code-200] - http://192.168.13.47/whatever/htpasswd
[url] - [code-200] - http://192.168.13.47/
[url] - [code-200] - http://192.168.13.47
[href] - http://192.168.13.47/index.php
[href] - http://192.168.13.47/?page=survey
[href] - http://192.168.13.47/?page=member
[href] - http://192.168.13.47/?page=signin
[href] - http://192.168.13.47/?page=media&src=nsa
[href] - https://en.wikipedia.org/wiki/PRISM_(surveillance_program)
[href] - http://192.168.13.47/?page=upload
[href] - http://192.168.13.47/?page=searchimg
[href] - http://192.168.13.47/?page=feedback
[href] - http://192.168.13.47/index.php?page=redirect&site=facebook
[href] - http://192.168.13.47/index.php?page=redirect&site=twitter
[href] - http://192.168.13.47/index.php?page=redirect&site=instagram
[href] - http://192.168.13.47/?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f
[javascript] - http://192.168.13.47/js/jquery.min.js
[javascript] - http://192.168.13.47/js/skel.min.js
[javascript] - http://192.168.13.47/js/skel-layers.min.js
[javascript] - http://192.168.13.47/js/init.js
...
```

De primeras, encontramos que el servidor contiene un archivo **robots.txt**, del cual encontramos dos directorios, **/.hidden** y **/whatever**, en donde encontraremos [un par](breaches/insecure_authentication_method.md) [de cosas interesantes](breaches/web_crawling.md).

## Fingerprint Web server
**WSTG-INFO-02**

Curl a la aplicacion para pillar back
- banner grabbing 

```bash
$ curl <IP> -I
HTTP/1.1 200 OK
Server: nginx/1.4.6 (Ubuntu)
Date: Fri, 06 Jun 2025 11:42:57 GMT
Content-Type: text/html
Connection: keep-alive
X-Powered-By: PHP/5.5.9-1ubuntu4.29
Set-Cookie: I_am_admin=68934a3e9455fa72420237eb05902327; expires=Fri, 06-Jun-2025 12:42:57 GMT; Max-Age=3600
```

Tenemos el proxy, el sistema y el framework usado. Tambien vemos una cabecera `Set-Cookie` que nos va a [resultar interesante](./cookie_tampering.md) en un futuro.

## Descubrimiento de servicios
Usamos la herramienta **nmap** para descubrir posibles servicios en el servidor.

```bash
nmap 192.168.13.47 -p1-10000 -sV
Starting Nmap 7.93 ( https://nmap.org ) at 2025-06-06 16:46 CEST
Nmap scan report for 192.168.13.47
Host is up (0.000089s latency).
Not shown: 9999 closed tcp ports (conn-refused)
PORT   STATE SERVICE VERSION
80/tcp open  http    nginx 1.4.6 (Ubuntu)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 6.69 seconds
```

Nmap no nos devuelve más información relevante que no hayamos obtenido con el banner grabbing.

## Fuzzeando la aplicación web
Tras una exploración inicial a la página, nos damos cuenta de que el servidor gestiona la navegación a partir de la introducción de un parámetro al propio index, de la forma **index.php?page=XXX**, por lo que podemos aprovechar y fuzzear el argumento para obtener información interesante.

```bash
wfuzz -w /rockyou.txt --hh 6924 http://xxx.xxx.xxx.xxx/index.php?page=FUZZ

********************************************************
* Wfuzz 3.1.0 - The Web Fuzzer                         *
********************************************************

Target: http://192.168.1.244/index.php?page=FUZZ
Total requests: 951

=====================================================================
ID           Response   Lines    Word       Chars       Payload                                                                                                     
=====================================================================

000000247:   200        133 L    745 W      6997 Ch     "default"                                                                                                   
000000339:   200        107 L    245 W      3325 Ch     "feedback"                                                                                                  
000000390:   200        86 L     213 W      3071 Ch     "header"                                                                                                    
000000516:   200        71 L     170 W      2460 Ch     "member"                                                                                                    
000000673:   200        54 L     128 W      1893 Ch     "redirect"                                                                                                  
000000758:   200        85 L     204 W      3014 Ch     "signin"                                                                                                    
000000810:   200        211 L    424 W      5913 Ch     "survey"                                                                                                    
000000862:   200        77 L     176 W      2497 Ch     "upload"                                                                                                    

Total time: 0
Processed Requests: 951
Filtered Requests: 943
Requests/sec.: 0

```

No obtenemos nada que no hayamos visto con el crawler.

## Índice
- [Obtención de credenciales por fuerza bruta](./breaches/brute_force.md)
- [Manipulación de cookies](./breaches/cookie_tampering.md)
- [Manipulación de parámetros en formularios - Encuesta](./breaches/form_tampering_surveys.md)
- [Manipulación de cabeceras de petición - Uso de proxies](./breaches/form_tampering_surveys.md)
- [Método inseguro de autentificación](./breaches/insecure_authentication_method.md)
- [Inclusión local de archivos](./breaches/local_file_inclusion.md)
- [Redirección en cliente](./breaches/open_redirect.md)
- [Ataque XSS reflejado](./breaches/reflected_xss_attack.md)
- [Inyección SQL - imágenes](./breaches/sql_injection_images.md)
- [Inyección SQL - usuarios](./breaches/sql_injection_users.md)
- [Subida de archivos](./breaches/unrestricted_file_upload.md)
- [Web crawling](./breaches/web_crawling.md)
- [Manipulación de parámetros - hidden input](./breaches/web_parameter_tampering.md)
- [Inyección XSS](./breaches/xss_injection.md)