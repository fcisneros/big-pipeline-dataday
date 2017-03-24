# Big Data Pipeline Workshop del [Dataday 2017](https://sg.com.mx/dataday/)
En este workshop se mostrarán algunos aspectos claves durante el diseño/implementación de un Data Pipeline con un ejemplo práctico sencillo.

## Requerimientos
Para el workshop es necesario lo siguiente:
* SO: Linux | OS X
* [docker-engine](https://docs.docker.com/engine/installation/)
* [docker-compose](https://docs.docker.com/compose/install/) cli
* [aws cli](https://aws.amazon.com/cli/)
* make: [command line developer tools](https://developer.apple.com/downloads/index.action?=command%20line%20tools) en OS X | [gnu make](https://www.gnu.org/software/make/) en Linux.


## Ambiente inicial
Teniendo instalados los requerimientos, es necesario crear las imagenes base de docker. Para ello ejecutar desde el root del proyecto:
```
$ make build
```

Posteriormente, descargar los datos de prueba desde S3:
```
$ make data
```
