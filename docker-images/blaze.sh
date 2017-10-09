#!/bin/bash

TMP_DIR=/tmp/pkb
BLAZE_VERSION=3.0
BLAZE_TAR=blaze-${BLAZE_VERSION}.tar.gz
BLAZE_DIR=${TMP_DIR}/blaze-${BLAZE_VERSION}
BLAZE_TAR_URL=https://bitbucket.org/blaze-lib/blaze/downloads/${BLAZE_TAR}
CONFIG_TEMPLATE=${TMP_DIR}/blaze_config.j2
CONFIG=${TMP_DIR}/config
MAX_BLAZE_CACHE_SIZE_IN_B=100000000

cd ${TMP_DIR}
wget ${BLAZE_TAR_URL}
tar xzvf ${BLAZE_TAR}
cp -r ${BLAZE_DIR}/blaze /usr/local/include

sed 's/{{ compiler }}/g++-5/g' ${CONFIG_TEMPLATE} | sed 's/{{ compile_flags }}/ -DBLAZE_USE_BOOST_THREADS --std=c++14/g' > ${CONFIG}

# Adjust cache size
cache_in_KB=40960
let cache_in_B=$cache_in_KB*1024
sed -i 's/constexpr size_t cacheSize = 3145728UL;/constexpr size_t cacheSize = '${cache_in_B}';/g' ${BLAZE_DIR}/blaze/config/CacheSize.h
cd ${BLAZE_DIR}
./configure ${CONFIG}
make -j 8
