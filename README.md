hadoop-multinode
================

Create a N-nodes Hadoop cluster using docker container

# Configuration
## Create docker network
`docker network create --driver=bridge hadoop`

## Initialize a cluster by specifying the number of nodes
`./init-cluster -n 5`

### Available options
`./init-cluster -n NODES_NUMBER -h HADOOP_VERSION -s SPARK_VERSION -c COMPILE_HADOOP`

- NODES_NUMBER: default to `3`
- HADOOP_VERSION: default to `2.8.2`
- SPARK_VERSION: default to `2.2.0`
- COMPILE_HADOOP: default to `false`

Based on [kiwenlau](https://github.com/kiwenlau/hadoop-cluster-docker)