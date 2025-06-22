# HTTP Proxying

Esto no es un ataque en sí, sino una introducción a la hora de **manipular peticiones** a la hora de realizar un reconocimiento extensivo de la plataforma.

La exploración e identificación de comportamientos por parte del servidor según las cabeceras enviadas por un cliente son una buena forma de descubrir potenciales vulnerabilidades.

## Ataque

- **Localización**: /index.php?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f

En nuestro reconocimiento inicial, descubrimos semiobfuscada una url que nos lleva a una vista con un texto y una imágen.

La página comienza a reproducir audio de forma automática como si estuviesemos en 2005, así que abrimos el inspector de elementos para matar el script que reproduce un tema bastante mierdero de edm dosmilero.

En la exploración del DOM, descubrimos un par de comentarios interesantes, que hacen potencialmente referencia a dos cabeceras.
```
<!--
You must come from : "https://www.nsa.gov/".
-->

...

<!--
Let's use this browser : "ft_bornToSec". It will help you a lot.
-->
```

La primera, [Referer](https://developer.mozilla.org/es/docs/Web/HTTP/Reference/Headers/Referer), y la segunda, [User-Agent](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/User-Agent). Usando un proxy (como BurpSuite) o un cliente que permita la manipulación de cabeceras, 

```bash
curl http://xxx.xxx.xxx.xxx/?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f -H "Referer: https://www.nsa.gov/" -H "User-Agent: ft_bornToSec"
```

El servidor nos retorna la flag.

## Mitigaciones

- No procede

## Referencias

- [OWASP: HTML Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/HTTP_Headers_Cheat_Sheet.html)
- [Artículo interesante sobre el uso de la cabecera **referer** para control de acceso](https://medium.com/@vipulparveenjain/vulnerabilities-in-referer-based-access-controls-authorization-series-part-6-4d02291db9c2)