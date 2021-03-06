FROM openjdk:8

MAINTAINER Fernando Cisneros <fernando@datank.ai>

ENV PREFIX /usr/local
RUN mkdir -p $PREFIX

# Hadoop
ENV HADOOP_VERSION 2.7.3
RUN curl -s http://www-us.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz | tar -xz -C $PREFIX/
RUN mv $PREFIX/hadoop-$HADOOP_VERSION $PREFIX/hadoop

# Pig
ENV PIG_VERSION 0.16.0
RUN curl -s http://www-us.apache.org/dist/pig/pig-$PIG_VERSION/pig-$PIG_VERSION.tar.gz | tar -xz -C $PREFIX/
RUN mv $PREFIX/pig-$PIG_VERSION $PREFIX/pig

# Set the environment variables
ENV HADOOP_HOME $PREFIX/hadoop
ENV HADOOP_PREFIX $PREFIX/hadoop
ENV HADOOP_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PIG_HOME $PREFIX/pig
ENV PATH $PATH:$HADOOP_HOME/bin:$PIG_HOME/bin

# Hadoop config
ADD conf/* $HADOOP_CONF_DIR/

# hadoop-aws-*-.jar is not on classpath by default, so let's add it
RUN echo 'export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$HADOOP_HOME/share/hadoop/tools/lib/*' >> $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

# Add some 3rd party libraries
ADD https://github.com/fcisneros/webarchive-commons/releases/download/webarchive-commons-1.1.5-hadoop2/webarchive-commons-jar-with-dependencies.jar $PREFIX/lib/webarchive-commons-jar-with-dependencies.jar
ADD https://github.com/fcisneros/warcutils/releases/download/v1.2.1/warcutils-jar-with-dependencies.jar $PREFIX/lib/warcutils-jar-with-dependencies.jar
ADD https://github.com/fcisneros/text-utils/releases/download/v0.1-SNAPSHOT/textutils-pig-jar-with-dependencies.jar $PREFIX/lib/textutils-pig-jar-with-dependencies.jar

CMD ["/bin/bash"]
