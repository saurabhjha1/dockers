#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/env.sh
docker network create \
  --driver overlay \
  --subnet 10.0.100.0/24 \
  ${SPARK_NETWORK} 
