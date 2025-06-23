# Open Redirection
### A10:2021 – Server-Side Request Forgery (SSRF)

Las redirecciones en el lado del cliente, si no están debidamente controladas, pueden suponer una superficie de ataque para **campañas de phising**, en las que un actor malicioso puede hacer pasar una web maliciosa como una url legítima usando el parámetro de redirección para realizar su ataque.

## Ataque
En nuestro reconocimiento, hemos observado tres links que hacen referencia a redirecciones a distintas redes sociales.

```bash
[href] - http://192.168.13.47/index.php?page=redirect&site=facebook
[href] - http://192.168.13.47/index.php?page=redirect&site=twitter
[href] - http://192.168.13.47/index.php?page=redirect&site=instagram
```

Al entrar en alguna de estas direcciones, se nos redirige a la red social indicada en el parámetro **site**.

Probamos a introducir nuestra página maligna como valor del parámetro para probar si existe algún tipo de validación en la redirección.

```
/index.php?page=redirect&site=http://mydangeroussite.evil
```

El servidor nos devuelve la flag.

## Mitigaciones

- Validación en backend (estrategia de **whitelist** de inputs)
- Uso de avisos dirigidos hacia el cliente para avisar de redirecciones fuera del dominio.

## Referencias

- [WSTG: Testing for Client Side URL Redirect](https://owasp.org/www-project-web-security-testing-guide/v41/4-Web_Application_Security_Testing/11-Client_Side_Testing/04-Testing_for_Client_Side_URL_Redirect)
- [CWE-601: URL Redirection to Untrusted Site ('Open Redirect')
](https://cwe.mitre.org/data/definitions/601.html)