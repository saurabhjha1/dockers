#!/usr/bin/env bash
set -evx
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"                                                                                                                                                                                
source $DIR/../bin/env.sh


docker service rm ${SPARK_PROXY}  
docker service rm ${SPARK_NOTEBOOK} 
docker service rm ${SPARK_CLIENT}
docker service rm ${SPARK_WORKER} 
docker service rm ${SPARK_MASTER}  
docker network rm ${SPARK_NETWORK} 
