# Big Data Pipeline Workshop del [Dataday 2017](https://sg.com.mx/dataday/)
En este workshop se mostrarán algunos aspectos claves durante el diseño/implementación de un Data Pipeline con un ejemplo práctico sencillo.


## Requerimientos
Para el workshop es necesario lo siguiente:
* Sistema Operativo OSX o Linux
* [docker-engine](https://docs.docker.com/engine/installation/)
* [docker-compose](https://docs.docker.com/compose/install/) cli
* [aws cli](https://aws.amazon.com/cli/)
* make ([command line developer tools](https://developer.apple.com/downloads/index.action?=command%20line%20tools) en OSX o [gnu make](https://www.gnu.org/software/make/) en Linux).


## Set Up inicial
Teniendo instalados los requerimientos, crear las imagenes base de docker. Para ello ejecutar desde el root del proyecto:
```bash
$ make build
```

Posteriormente, descargar los datos de prueba desde S3:
```bash
$ make data
```


## Proyecto
Supongamos que el equipo de Data Science está investigando la forma de automatizar el etiquetado de documentos para evitar los errores humanos causados, principalmente, por el sesgo de editores. Para lo cual requieren la generación de los siguientes datasets a partir de una muestra de páginas web:

* PageRank de páginas
* Contenido en texto plano normalizado
* Conteo de palabras


## Iniciar el cluster local
Para ejecutar los pipelines es necesario iniciar el cluster de hadoop localmente (en docker) y copiar los datos de prueba a hdfs:
```bash
$ make start
```

Si sale un error como el siguiente:
```
Copying data/* to hdfs
mkdir: Cannot create directory /app/data. Name node is in safe mode.
make: *** [.copied] Error 1
```
Es porque el cluster no había terminado de arrancar cuando se intentó copiar datos a hdfs. En dicho caso volver a ejecutar *make start* anterior.
