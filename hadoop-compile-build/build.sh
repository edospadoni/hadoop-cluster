#!/bin/bash

# get number of cluster nodes
NODES=${1:-3}

# get version of hadoop or fallback to 2.8.2
VERSION=${2:-2.8.2}

# clean old slaves configuration
if [ -f config/slaves ]; then
    rm config/slaves
fi

# create dynamic slaves file based on NODES number
i=1
while [ $i -lt $NODES ]
do
	echo "hadoop-slave$i" >> config/slaves
	((i++))
done

# print status
echo -e "compiling and building docker image for a cluster of $NODES nodes with hadoop-$VERSION\n"

# build container image with dependencies
docker build --build-arg VERSION=$VERSION -t $(whoami)/hadoop:$VERSION .