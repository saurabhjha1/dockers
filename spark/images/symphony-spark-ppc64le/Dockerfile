# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

# Debian Jessie debootstrap from 2017-02-27
# https://github.com/docker-library/official-images/commit/aa5973d0c918c70c035ec0746b8acaec3a4d7777

FROM ppc64le/ubuntu:16.04

#vicamo/debian-linux-kernel:jessie-ppc64el


USER root

# Install all OS dependencies for notebook server that starts but lacks all
# features (e.g., download as all possible file formats)
RUN apt-get update --yes  \
 && apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    openjdk-8-jre-headless \
    maven \
    curl \
    unzip \
    vim \
    sudo 

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen 

# JAVA
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-ppc64el

ENV PATH $PATH:$JAVA_HOME/bin
RUN ln -s $JAVA_HOME /usr/java \
  && rm -rf $JAVA_HOME/man

# install python tools
RUN apt-get update --yes \
 && apt-get install -yq --no-install-recommends \
    python3 \
    python3-setuptools \
    libsnappy-java \
 && easy_install3 pip py4j \
 && ln -s /usr/bin/python3 /usr/bin/python \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
# && mvn -X install snappy-java \


# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Configure environment
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV SHELL /bin/bash
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/$NB_USER
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# http://blog.stuart.axelbrooke.com/python-3-on-spark-return-of-the-pythonhashseed
ENV PYTHONHASHSEED 0
ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

# Create jovyan user with UID=1000 and in the 'users' group
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    mkdir -p $CONDA_DIR && \
    chown $NB_USER $CONDA_DIR

USER $NB_USER

# Setup jovyan home directory
RUN mkdir /home/$NB_USER/work && \
    mkdir /home/$NB_USER/.jupyter && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc

# Install conda as jovyan
RUN cd /tmp && \
    mkdir -p $CONDA_DIR && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-ppc64le.sh && \
    /bin/bash Miniconda3-4.2.12-Linux-ppc64le.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-4.2.12-Linux-ppc64le.sh && \
    $CONDA_DIR/bin/conda config --system --add channels conda-forge && \
    $CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
    conda clean -tipsy


USER root

WORKDIR /home/$NB_USER/work
# Configure container startup

# HADOOP
ENV HADOOP_VERSION 2.7.3
ENV HADOOP_HOME /usr/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin
RUN curl -sL --retry 3 \
  "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" \
  | gunzip \
  | tar -x -C /usr/ \
 && rm -rf $HADOOP_HOME/share/doc \
 && chown -R root:root $HADOOP_HOME

# SPARK
ENV SPARK_VERSION 2.1.0
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-without-hadoop
ENV SPARK_HOME /usr/spark-${SPARK_VERSION}
ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -sL --retry 3 \
  "http://d3kbcqa49mib13.cloudfront.net/${SPARK_PACKAGE}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
 && mv /usr/$SPARK_PACKAGE $SPARK_HOME \
 && chown -R root:root $SPARK_HOME
#configure spark-default conf


WORKDIR $SPARK_HOME
RUN touch ${SPARK_HOME}/conf/spark-defaults.conf \
    && echo "spark.driver.extraClassPath /usr/symphony/alluxio-core-client-1.3.0-jar-with-dependencies.jar" >> ${SPARK_HOME}/conf/spark-defaults.conf  \
    && echo "spark.executor.extraClassPath /usr/symphony/alluxio/alluxio-core-client-1.3.0-jar-with-dependencies.jar" >> ${SPARK_HOME}/conf/spark-defaults.conf \
    && echo "spark.history.fs.logDirectory /scratch/saurabh/spark/logs" >> ${SPARK_HOME}/conf/spark-defaults.conf \
    && echo "spark.eventLog.enabled = true" >> ${SPARK_HOME}/conf/spark-defaults.conf \
    && echo "spark.eventLog.dir /scratch/saurabh/spark/logs" >> ${SPARK_HOME}/conf/spark-defaults.conf \
    && echo "spark.history.provider org.apache.spark.deploy.history.FsHistoryProvider" >> ${SPARK_HOME}/conf/spark-defaults.conf


WORKDIR /usr/
#ENV ALLUXIO /usr/alluxio/
ENV SYM /usr/symphony
RUN mkdir -p ${SYM}
ADD log4j.properties ${SPARK_HOME}/conf/

#RUN mv ${SYM}/alluxio-1.3.0 /usr/alluxio

# RUN SPARK IN USER MODE
USER $NB_USER
#CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]
