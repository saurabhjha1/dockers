#!/usr/bin/env bash
set -evx
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"                                                                                                                                                                                
source $DIR/../bin/env.sh

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#extract alluxio components
#tar -xvf ./alluxio.tar.gz -C /scratch/saurabh/


# Create an overlay network
docker network create \
  --driver overlay \
  --subnet 10.0.100.0/24 \
  ${SPARK_NETWORK}


#Create the spark notebook. Lets do some common good
$CWD/../bin/startNotebook.sh


# Create a Spark Master
$CWD/../bin/startMaster.sh

#start the nginx server for web proxy ports
sleep 10
$CWD/../bin/startNginx.sh


sleep 30
# Create Spark Workers
$CWD/../bin/startWorkers.sh ${NUM_WORKERS}
$CWD/../bin/startIBMWorkers.sh ${NUM_IBM_WORKERS}

#start a client to run docker exec and spark
$CWD/../bin/startClient.sh
