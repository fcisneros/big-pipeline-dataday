FROM dataday/hadoop-client

WORKDIR /app

ADD run-example.sh run-example.sh
RUN curl -o cc-warc-examples.jar https://github.com/fcisneros/cc-warc-examples/releases/download/0.3-SNAPSHOT/cc-warc-examples-0.3-SNAPSHOT-jar-with-dependencies.jar 

ENTRYPOINT ["/app/run-example.sh"]
