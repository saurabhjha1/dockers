#!/bin/bash

#nohup /usr/spark-2.0.2/bin/spark-class org.apache.spark.deploy.master.Master &

# ALLUXIO MODE
mode="master"
#setup packages


# SETUP SPARK CONF for ALLUXIO

#setup Alluxio filesystem
${SYM}/setupAlluxio.sh $1 $2 

# start Master
${ALLUXIO}/bin/alluxio-start.sh $mode

# start SPARK Master
$SPARK_HOME/sbin/start-history-server.sh
$SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master
