FROM ubuntu:14.04

MAINTAINER edospadoni <edoardo.spadoni@gmail.com>

# get version from build or fallback to 2.7.2
ARG VERSION=2.7.2

# set working directory
WORKDIR /root

# install dependencies for compiling hadoop
RUN apt-get update && \
    apt-get install -y wget \
                       openjdk-7-jdk \
                       libprotobuf-dev \
                       protobuf-compiler \
                       maven \
                       cmake \
                       build-essential \
                       pkg-config \
                       libssl-dev \
                       zlib1g-dev \
                       llvm-gcc \
                       automake \
                       autoconf \
                       make \
                       openssh-server

# download hadoop
RUN wget http://archive.apache.org/dist/hadoop/core/hadoop-$VERSION/hadoop-$VERSION-src.tar.gz

# extract hadoop sources
RUN tar -xzvf hadoop-$VERSION-src.tar.gz

# compile hadoop
RUN cd hadoop-$VERSION-src && \
    mvn package -Pdist,native -DskipTests -Dtar && \
    cd .. && \
    tar -xzvf hadoop-$VERSION-src/hadoop-dist/target/hadoop-$VERSION.tar.gz

# move compiled hadoop to binary directory
RUN mv hadoop-$VERSION /usr/local/hadoop

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
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
    mv /tmp/start-hadoop ~/start-hadoop.sh && \
    mv /tmp/wordcount ~/wordcount.sh

# make scripts executable
RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]