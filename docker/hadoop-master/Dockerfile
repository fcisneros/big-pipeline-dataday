FROM sequenceiq/hadoop-docker:2.7.0

RUN service sshd start && $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver

EXPOSE 10020
