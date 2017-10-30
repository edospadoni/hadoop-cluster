hadoop-multinode
================

Create a N-nodes Hadoop cluster using docker container

# Configuration
## Create docker network
`docker network create --driver=bridge hadoop`

## Initialize a cluster by specifying the number of nodes
`./init-cluster 5`

Based on [kiwenlau](https://github.com/kiwenlau/hadoop-cluster-docker)