#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/env.sh
echo "creating ${NUM_IBM_WORKERS} of ${SPARK_WORKER_IBM}"
docker service create \
  --name ${SPARK_WORKER_IBM} \
  --constraint "node.labels.arch!=x86_64,node.role!=manager" \
  --replicas ${NUM_IBM_WORKERS} \
  --network ${SPARK_NETWORK} \
  --mount type=bind,source=/scratch,destination=/scratch \
  --mount type=bind,source=/ssd,destination=/ssd \
  --endpoint-mode dnsrr \
  ${SPARK_IMAGE_PPC64EL} \
  spark-class org.apache.spark.deploy.worker.Worker spark://sparkMaster:7077


