#!/bin/bash

GIT_REPO=https://github.com/aerospike/aerospike-server.git
GIT_TAG=3.7.5
AEROSPIKE_DIR=${INSTALL_DIR}/aerospike-server
AEROSPIKE_CONF_PATH=${AEROSPIKE_DIR}/as/etc/aerospike_dev.conf
AEROSPIKE_DEFAULT_TELNET_PORT=3003

git clone ${GIT_REPO} ${AEROSPIKE_DIR}
cd ${AEROSPIKE_DIR}
git checkout ${GIT_TAG}
git submodule update --init
cp ${INSTALL_DIR}/aerospike.conf.j2 ${AEROSPIKE_CONF_PATH}
make -j8
