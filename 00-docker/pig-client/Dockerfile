FROM dataday/hadoop-client

RUN curl -o /usr/local/lib/webarchive-commons-jar-with-dependencies.jar https://github.com/fcisneros/webarchive-commons/releases/download/webarchive-commons-1.1.5-hadoop2/webarchive-commons-jar-with-dependencies.jar 

ADD run-pig.sh /usr/local/bin/run-pig.sh

ENTRYPOINT ["/usr/local/bin/run-pig.sh"]
