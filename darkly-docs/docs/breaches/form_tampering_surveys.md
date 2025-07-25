# Web parameter tampering
### A03:2021 – Injection

En la implementación de formularios pueden cometerse errores de diseño, como usar parámetros **ocultos** para almacenar el estado del formulario,
por el cual se puede enviar información customizada al servidor.

## Ataque

- **Localización**: /?page=survey

Tenemos un formulario en el que se nos permite seleccionar de entre una serie de opciones, al hacerlo se ejecuta el submit y el valor de la opción se incrementa.

![Formulario vulnerable](../static/options.png)

Inspeccionando la página se nos revela que los dos parámetros que se envían se encuentran como valores en el formulario, la selección del elemento en un **hidden input** y el valor en opciones dentro de un select.

El input oculto selecciona el índice del elemento en el que se va a añadir la puntuación, pero el input que realmente interesa es el valor de la selección.

## Mitigaciones

- El envío del valor del mail es completamente innecesario en este caso, una buena forma de mitigación es eliminar los inputs que no necesitan ser provistos por el usuario y gestionar esos valores desde el servidor.
- En caso de que sea necesaria la introducción del input por parte de usuario, validación de este en backend.

## Referencias
- [OWASP: Web Parameter Tampering](https://owasp.org/www-community/attacks/Web_Parameter_Tampering)