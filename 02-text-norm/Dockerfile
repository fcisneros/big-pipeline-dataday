FROM dataday/hadoop-client

WORKDIR /text

#RUN apt-get update && apt-get install -y python3 python3-pip
#RUN echo "alias python='/usr/bin/python3.4'" >> ~/.bashrc
#ADD requirements.txt /tmp/requirements.txt
#RUN pip3 install --install-option="--prefix=/text" -r /tmp/requirements.txt
#RUN tar -cvf normalize-stream.tar .

ADD *.pig *.sh ./

ENTRYPOINT ["/text/run.sh"]
