FROM sequenceiq/hadoop-docker:2.7.1

# Replace some config to add S3 access
#ADD core-site.xml.template $HADOOP_PREFIX/etc/hadoop/core-site.xml.template
ADD yarn-site.xml  $HADOOP_PREFIX/etc/hadoop/yarn-site.xml
RUN echo 'export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$HADOOP_PREFIX/share/hadoop/tools/lib/*' >> $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

# Pig always wants to connect to JobHistory server but sequenceiq's image does not start it
# Replace bootstrap to start jobhistoryserver (only in master branch of sequenceiq's repo)
ENV USER root
ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh
