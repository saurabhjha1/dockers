#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/env.sh
echo "creating ${NUM_WORKERS} of ${SPARK_WORKER} and using ${ALLUXIO_UNDER_FS} as underfs"
docker service create \
  --name ${SPARK_WORKER} \
  --constraint "node.labels.arch==x86_64,node.role!=manager" \
  --replicas $NUM_WORKERS \
  --network ${SPARK_NETWORK} \
  --mount type=bind,source=/scratch,destination=/scratch \
  --mount type=bind,source=/ssd,destination=/ssd \
  --endpoint-mode dnsrr \
  ${SPARK_IMAGE} \
  /usr/symphony/startAlluxioWorker.sh ${SPARK_MASTER} ${ALLUXIO_UNDER_FS}
  
#--reserve-memory=300g \
  #bin/spark-class org.apache.spark.deploy.worker.Worker spark://sparkMaster:7077


