#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/env.sh
docker service create \
  --name ${SPARK_CLIENT} \
  --constraint "node.labels.arch==x86_64,node.role==manager" \
  --replicas 1 \
  --network ${SPARK_NETWORK} \
  --mount type=bind,source=/scratch,destination=/scratch \
  --mount type=bind,source=/ssd,destination=/ssd \
  --endpoint-mode dnsrr \
  ${SPARK_IMAGE} \
  sleep 10000000
  #bin/spark-class org.apache.spark.deploy.worker.Worker spark://sparkMaster:7077


