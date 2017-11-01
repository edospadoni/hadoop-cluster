#!/bin/sh

# get version of hadoop or fallback to 2.8.2
HADOOP_VERSION=${1:-2.8.2}

# get version of spark or fallback to 2.2.0
SPARK_VERSION=${2:-2.2.0}

# build container image based on hadoop container
docker build --build-arg CREATOR=$(whoami) \
             --build-arg HADOOP_VERSION=$HADOOP_VERSION \
             --build-arg SPARK_VERSION=$SPARK_VERSION \
             -t $(whoami)/hadoop-spark:$SPARK_VERSION .
