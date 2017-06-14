#!/bin/bash

#nohup /usr/spark-2.0.2/bin/spark-class org.apache.spark.deploy.master.Master &

# ALLUXIO MODE
mode="worker"
#setup packages

# SETUP SPARK CONF for ALLUXIO

#setup Alluxio filesystem
${SYM}/setupAlluxio.sh $1 $2

# start Worker
${ALLUXIO}/bin/alluxio-start.sh worker

# Start Spark Worker
$SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker spark://$1:7077 
