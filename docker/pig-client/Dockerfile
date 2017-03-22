FROM dataday/hadoop-client

WORKDIR /app

ADD https://github.com/fcisneros/webarchive-commons/releases/download/webarchive-commons-1.1.5-hadoop2/webarchive-commons-jar-with-dependencies.jar lib/webarchive-commons-jar-with-dependencies.jar

ADD * ./

#ADD run-pig.sh run-pig.sh
ENTRYPOINT ["/app/run-pig.sh"]
