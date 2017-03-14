FROM dataday/hadoop-client

WORKDIR /app

ADD run-example.sh run-example.sh
ADD https://github.com/fcisneros/cc-warc-examples/releases/download/0.3-SNAPSHOT/cc-warc-examples-0.3-SNAPSHOT-jar-with-dependencies.jar ./cc-warc-examples.jar

CMD ["/app/run-example.sh", "wc"]
