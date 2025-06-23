# Inyección XSS
### A03:2021-Injection

Una **inyección de código XSS** o **stored xss** es un ataque de inyección de 
...
## Ataque

- **Localización**: 

- Reconocimiento
- Identificación de la vulnerabilidad

La validación de tamaño máximo del nombre sólo se encuentra en front, por lo que podemos bypassearla.

```js
document.querySelector('input').maxLength = 1000
```
Probamos a inyectar un tag
```html 
<script type="text/javascript"></script>
```
Y observamos que en el comentario resultante se filtra la palabra javascript, por lo que bypasseamos escapando uno de los caracteres, por ejemplo `&#106`.

Nuestro payload final:
```html
<div> User <script type="text/&#106avascript">alert("Hey")</script></div>
```

Lo introducimos en el input de usuario, guardamos y refrescamos la página, y ya podemos ejecutar código en navegadores remotos.

Para obtener la flag, simplemente hemos de escribir script en el input del nombre y enviar.

## Mitigación
- Validación de input de usuario en servidor.
- Escape de caracteres especiales (html) en servidor.

## Referencias
- https://owasp.org/www-community/attacks/xss/