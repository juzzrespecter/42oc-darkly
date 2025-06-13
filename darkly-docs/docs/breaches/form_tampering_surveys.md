# Web parameter tampering
### A03:2021 – Injection

En la implementación de formularios pueden cometerse errores de diseño, como usar parámetros **ocultos** para almacenar el estado del formulario,
por el cual se puede enviar información customizada al servidor.

## Ataque

- **Localización**: http://<IP>/?page=survey

Tenemos un formulario en el que se nos permite seleccionar de entre una serie de opciones, al hacerlo se ejecuta el submit y el valor de la opción se incrementa.

![Formulario vulnerable](image.png)

Inspeccionando la página se nos revela que los dos parámetros que se envían se encuentran como valores en el formulario, la selección del elemento en un **hidden input** y el valor en opciones dentro de un select. 

## Mitigaciones

- buen diseño forms
- validacion backend

## Referencias
- [OWASP: Web Parameter Tampering](https://owasp.org/www-community/attacks/Web_Parameter_Tampering)