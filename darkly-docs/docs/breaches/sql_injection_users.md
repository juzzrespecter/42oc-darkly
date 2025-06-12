# Inyección SQL - Usuarios


## Ataque

En la url de http://<IP>/???, tenemos acceso a un input para buscar usuarios por id, por lo que suponemos que el input de usuario va a formar parte de una query a la base de datos.

Probamos si podemos tener acceso a una vulnerabilidad por mala validación de input; escribimos un `'` y enviamos.

- lo de pillar versionado

- tras versionado, explorar information_schema

- lanzar query para nombre de columnas
( mencion uso de hex para evitar parseo)

- lanzar query para info de columnas

- logueasion

## Mitigación

## Referencias