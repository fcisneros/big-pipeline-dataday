# Big Data Pipeline Workshop del [Dataday 2017](https://sg.com.mx/dataday/)
En este workshop se mostrarán algunos aspectos claves durante el diseño/implementación de un Data Pipeline con un ejemplo práctico sencillo.


## Requerimientos
Para el workshop es necesario lo siguiente:
* SO: Linux | OS X
* [docker-engine](https://docs.docker.com/engine/installation/)
* [docker-compose](https://docs.docker.com/compose/install/) cli
* [aws cli](https://aws.amazon.com/cli/)
* make: [command line developer tools](https://developer.apple.com/downloads/index.action?=command%20line%20tools) en OS X | [gnu make](https://www.gnu.org/software/make/) en Linux.


## Instrucciones
Teniendo instalados los requerimientos, crear las imagenes base de docker. Para ello ejecutar desde el root del proyecto:
```
$ make build
```

Posteriormente, descargar los datos de prueba desde S3:
```
$ make data
```


## Proyecto
Supongamos que el equipo de Data Science está investigando la forma de automatizar el etiquetado de documentos para evitar los errores humanos causados, principalmente, por el sesgo de editores. Para lo cual requieren la generación de los siguientes datasets a partir de una muestra de páginas web:

* PageRank de páginas
* Contenido en texto plano normalizado
* Conteo de palabras
