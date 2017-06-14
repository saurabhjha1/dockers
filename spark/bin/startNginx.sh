#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/env.sh

docker service create \
  --name ${SPARK_PROXY} \
  --constraint "node.labels.arch==x86_64,node.role==manager" \
  --replicas 1 \
  --mount type=bind,source=/scratch,destination=/scratch \
  --publish "80:80" \
  --publish "8888:8888" \
  --publish "18080:18080" \
  --publish "19999:19999" \
  --network ${SPARK_NETWORK}\
  ${PROXY_IMAGE} 
