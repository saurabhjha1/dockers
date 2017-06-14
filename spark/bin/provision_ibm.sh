#!/bin/bash

UBUNTU_IMAGE=multiarch/ubuntu-core:ppc64el-xenial
NUM_WORKERS=2

# Create an overlay network


# Create a Spark Master
docker service create \
  --name sparkWorkerPPC \
  --constraint "node.labels.arch!=x86_64,node.role!=manager" \
  --replicas $NUM_WORKERS  \
  --network sparkNetwork \
  --container-label sparkWorkerPPC \
  --mount type=bind,source=/scratch,destination=/scratch \
  --mount type=bind,source=/ssd,destination=/ssd \
  --endpoint-mode dnsrr \
  ${UBUNTU_IMAGE} \
  /scratch/saurabh/alluxio/bin/startAlluxioWorkerIBM.sh                                                        
