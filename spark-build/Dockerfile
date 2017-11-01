# get previous creator of hadoop builded image
ARG CREATOR=edoardo

# get version from build or fallback to 2.8.2
ARG HADOOP_VERSION=2.8.2

# specify container base from
FROM $CREATOR/hadoop:$HADOOP_VERSION

MAINTAINER edospadoni <edoardo.spadoni@gmail.com>

# get version from build or fallback to 2.2.0
ARG SPARK_VERSION=2.2.0

# set working directory
WORKDIR /root

# download spark
RUN wget https://www.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-without-hadoop.tgz

# extract spark
RUN tar -zxvf spark-$SPARK_VERSION-bin-without-hadoop.tgz

# move directory in spark path
RUN mv spark-$SPARK_VERSION-bin-without-hadoop /usr/local/spark

# set environment variable
ENV SPARK_HOME=/usr/local/spark
ENV YARN_CONF_DIR=/usr/local/hadoop/etc/hadoop
ENV PATH=$PATH:/usr/local/spark/bin

# copy wordcount script
COPY task/wordcount.sh .

# export ENV variable for spark
RUN echo "export SPARK_DIST_CLASSPATH=$(hadoop classpath)" >> /usr/local/spark/conf/spark-env.sh

CMD [ "sh", "-c", "bash"]
