#!/bin/bash

#docker service create \
#  --name sparkClient \
#  --constraint "node.labels.arch==x86_64,node.role==manager" \
#  --replicas 1 \
#  --network sparkNetwork \
#  --mount type=bind,source=/scratch,destination=/scratch \
#  --mount type=bind,source=/ssd,destination=/ssd \
#  --endpoint-mode dnsrr ${SPARK_IMAGE} \
#  /scratch/saurabh/alluxio/bin/startClient.sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/env.sh

docker service create \
  --name ${SPARK_NOTEBOOK} \
  --constraint "node.labels.arch==x86_64,node.role!=manager" \
  --replicas 1 \
  --network ${SPARK_NETWORK} \
  --mount type=bind,source=/scratch,destination=/scratch \
  --mount type=bind,source=/ssd,destination=/ssd \
  --endpoint-mode dnsrr \
    ${NOTEBOOK_IMAGE} /usr/local/bin/start-notebook.sh /scratch/saurabh/jupyter-notebooks/

#    jupyter/all-spark-notebook

#  /scratch/saurabh/alluxio/bin/startSClient.sh
#  jupyter/pyspark-notebook
