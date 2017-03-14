FROM openjdk:8

MAINTAINER Fernando Cisneros <fernando@datank.ai>

ENV LIB_PREFIX /opt
RUN mkdir -p $LIB_PREFIX

# Hadoop
ENV HADOOP_VERSION 2.7.3
RUN curl -s http://www.eu.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz | tar -xz -C $LIB_PREFIX/
RUN mv $LIB_PREFIX/hadoop-$HADOOP_VERSION $LIB_PREFIX/hadoop

# Pig
ENV PIG_VERSION 0.16.0
RUN curl -s http://www.eu.apache.org/dist/pig/pig-$PIG_VERSION/pig-$PIG_VERSION.tar.gz | tar -xz -C $LIB_PREFIX/
RUN mv $LIB_PREFIX/pig-$PIG_VERSION $LIB_PREFIX/pig

# Hive
ENV HIVE_VERSION 2.1.1
RUN curl -s http://www.eu.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz | tar -xz -C $LIB_PREFIX/
RUN mv $LIB_PREFIX/apache-hive-$HIVE_VERSION-bin $LIB_PREFIX/hive

# Set the environment variables
ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_PREFIX /opt/hadoop
ENV YARN_HOME /opt/hadoop
ENV HADOOP_YARN_HOME /opt/hadoop
ENV HADOOP_HDFS_HOME /opt/hadoop
ENV HADOOP_COMMON_HOME /opt/hadoop
ENV HADOOP_MAPRED_HOME /opt/hadoop
ENV HADOOP_CONF_DIR /opt/hadoop/etc/hadoop
ENV HDFS_CONF_DIR /opt/hadoop/etc/hadoop
ENV YARN_CONF_DIR /opt/hadoop/etc/hadoop

ADD core-site.xml $HADOOP_CONF_DIR/core-site.xml

CMD ["/bin/bash"]
