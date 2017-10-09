#!/bin/bash

JNA_JAR_URL=https://maven.java.net/content/repositories/releases/net/java/dev/jna/jna/4.1.0/jna-4.1.0.jar
CASSANDRA_GIT_REPO=https://github.com/apache/cassandra.git
CASSANDRA_VERSION=cassandra-2.1.10
CASSANDRA_YAML_TEMPLATE=cassandra/cassandra.yaml.j2
CASSANDRA_ENV_TEMPLATE=cassandra/cassandra-env.sh.j2
CASSANDRA_DIR=${INSTALL_DIR}/cassandra
CASSANDRA_PID=${CASSANDRA_DIR}/cassandra.pid
CASSANDRA_OUT=${CASSANDRA_DIR}/cassandra.out
CASSANDRA_ERR=${CASSANDRA_DIR}/cassandra.err
NODETOOL=${CASSANDRA_DIR}/bin/nodetool

locale-gen "en_US.UTF-8"
dpkg-reconfigure locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
update-locale LANG=en_US.UTF-8 LC_MESSAGES=POSIX
cd ${INSTALL_DIR}
git clone ${CASSANDRA_GIT_REPO}
cd ${CASSANDRA_DIR}
git checkout ${CASSANDRA_VERSION}
${ANT_HOME_DIR}/bin/ant

cd ${CASSANDRA_DIR}/lib
curl -LJO ${JNA_JAR_URL}
