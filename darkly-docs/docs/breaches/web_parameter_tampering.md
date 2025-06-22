# Web parameter tampering
### A03:2021-Injection


Este ataque tiene el mismo planteamiento que [el ataque de manipulación de DOM en la página de encuestas](./form_tampering_surveys.md)

Algunos formularios utilizan **hidden inputs** o inputs ocultos para enviar valores fijos desde el cliente al servidor. Aunque a primera vista no estén disponibles para su edición, si no existen **lógicas de validación de inputs** o estas no funcionan adecuadamente, un atacante puede editar este parámetro para obtener el control de la lógica de funcionamiento de la aplicación.

# Ataque
 - **Localización**: /?page=recover

Observando el formulario para recuperar contraseña, vemos que la petición manda el mismo valor `mail`, valor que se puede encontrar en un **input ocultado** en el DOM si inspeccionamos.  

```html
<form action="#" method="POST">
	<input type="hidden" name="mail" value="webmaster@borntosec.com" maxlength="15">
	<input type="submit" name="Submit" value="Submit">
</form>
```

Podemos editar este valor para poner un mail que esté bajo nuestro control, y al hacer click al botón de postear, la petición envía nuestro mail y retorna la flag.

# Mitigación

- validacion back noseque

# Referencias

 - [OWASP: Web parameter tampering](https://owasp.org/www-community/attacks/Web_Parameter_Tampering)