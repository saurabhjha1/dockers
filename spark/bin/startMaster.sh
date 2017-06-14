#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/env.sh
echo "creating spark master as ${SPARK_MASTER}"

docker service create \
  --name ${SPARK_MASTER} \
  --constraint "node.labels.arch==x86_64,node.role!=manager" \
  --replicas 1  \
  --network ${SPARK_NETWORK} \
  --container-label ${SPARK_MASTER} \
  --mount type=bind,source=/scratch,destination=/scratch \
  --mount type=bind,source=/ssd,destination=/ssd \
  --endpoint-mode dnsrr \
  --with-registry-auth \
  ${SPARK_IMAGE} \
  /usr/symphony/startAlluxioMaster.sh ${SPARK_MASTER} ${ALLUXIO_UNDER_FS}

  #bin/spark-class org.apache.spark.deploy.master.Master

