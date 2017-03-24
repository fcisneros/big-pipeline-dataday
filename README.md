# Big Data Pipeline Workshop del [Dataday 2017](https://sg.com.mx/dataday/)
En este workshop se mostrarán algunos aspectos claves durante el diseño/implementación de un Data Pipeline con un ejemplo práctico sencillo.

## Requerimientos
Para el workshop es necesario lo siguiente:
* SO: Linux | macOSX
* [docker-engine](https://docs.docker.com/engine/installation/)
* [docker-compose](https://docs.docker.com/compose/install/) cli
* [aws cli](https://aws.amazon.com/cli/)


## Ambiente inicial
Teniendo instalados los requerimientos, es necesario crear las imagenes base de docker. Para ello ejecutar desde el root del proyecto:
```
$ scripts/docker-build.sh
```

Posteriormente, descargar los datos de prueba desde S3:
```
$ scripts/download-sample-data.sh
```
