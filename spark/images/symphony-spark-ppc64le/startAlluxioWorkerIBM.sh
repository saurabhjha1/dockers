#!/bin/bash

#nohup /usr/spark-2.0.2/bin/spark-class org.apache.spark.deploy.master.Master &

# ALLUXIO MODE
mode="worker"
#setup packages

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

host=`hostname`
LOGFILE=/scratch/saurabh/containerLogs/$host.txt
echo $host &>> $LOGFILE
apt update &>> $LOGFILE
apt --yes install vim sudo openjdk-8-jre-headless &>> $LOGFILE

echo "export \$JAVA_HOME=/usr/lib/jvm/java-8-openjdk-ppc64el" >> ~/.bashrc
source ~/.bashrc
ls /usr/lib/jvm/* &>> $LOGFILE

echo -e "\n\n JRE INSTALLED \n\n" &>> $LOGFILE
cd /usr
cp $CWD/../spark-2.0.2-bin-hadoop2.7.tgz /usr/
tar -xf  spark-2.0.2-bin-hadoop2.7.tgz
mv spark-2.0.2-bin-hadoop2.7  spark-2.0.2

echo "move complete" &>> $LOGFILE
# SETUP SPARK CONF for ALLUXIO
$CWD/setupSpark.sh &>> $LOGFILE

echo "spark setup complete" &>> $LOGFILE

#setup Alluxio filesystem
$CWD/setupAlluxio.sh &>> LOGFILE

echo "alluxio setup complete" &>> $LOGFILE

# start Worker
/usr/alluxio/bin/alluxio-start.sh worker

echo "alluxio started" &>> $LOGFILE

ls /usr &>> $LOGFILE
# Start Spark Worker
/usr/spark-2.0.2/bin/spark-class org.apache.spark.deploy.worker.Worker spark://sparkMaster:7077 &>> $LOGFILE
