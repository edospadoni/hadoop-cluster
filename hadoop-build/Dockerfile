# specify container base from
FROM ubuntu:16.04

MAINTAINER edospadoni <edoardo.spadoni@gmail.com>

# get version from build or fallback to 2.8.2
ARG VERSION=2.8.2

# set working directory
WORKDIR /root

# install dependencies for compiling hadoop
RUN apt-get update && \
    apt-get install -y wget \
                       openjdk-8-jdk \
                       openssh-server

# download hadoop
RUN wget https://www.apache.org/dist/hadoop/common/hadoop-$VERSION/hadoop-$VERSION.tar.gz

# extract hadoop sources
RUN tar -xzvf hadoop-$VERSION.tar.gz

# move compiled hadoop to binary directory
RUN mv hadoop-$VERSION /usr/local/hadoop

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# create directory for hdfs-dite.xml
RUN mkdir -p ~/hdfs/namenode && \
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

# copy local configurations to container
COPY config/* /tmp/

# copy to correct destinations directory
RUN mv /tmp/ssh-config ~/.ssh/config && \
    mv /tmp/hadoop-env /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh

# make scripts executable
RUN chmod +x ~/start-hadoop.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]