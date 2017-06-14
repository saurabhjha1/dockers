#!/bin/bash
SPARK_IMAGE=zubin.maas/symphony-spark-x86_64:2.1.0
SPARK_IMAGE_PPC64EL=zubin.maas/symphony-spark-ppc64le:2.1.0

NOTEBOOK_IMAGE=zubin.maas/symphony-notebook-x86_64:2.1.0

PROXY_IMAGE=nginx-spark-symphony-proxy

SPARK_NOTEBOOK="sparkNotebook"
SPARK_MASTER="sparkMaster"
SPARK_WORKER="sparkWorker"
SPARK_WORKER_IBM="sparkWorkerIBM"
SPARK_CLIENT="sparkClient"
ALLUXIO_UNDER_FS="/ssd/"
SPARK_NETWORK="sparkNetwork"
SPARK_PROXY="sparkProxy"
NUM_WORKERS=8
NUM_IBM_WORKERS=2
