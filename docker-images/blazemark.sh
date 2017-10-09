#!/bin/bash

TMP_DIR=/tmp/pkb

BLAZE_VERSION=3.0
BLAZE_DIR=${TMP_DIR}/blaze-${BLAZE_VERSION}

BLAZEMARK_FOLDER='blazemark'
BLAZEMARK_DIR=${BLAZE_DIR}/${BLAZEMARK_FOLDER}
CONFIG_TEMPLATE=${TMP_DIR}/blazemark_config.j2
CONFIG=${TMP_DIR}/config
FORTRAN_PATH=$(find /usr/lib/ | grep fortran.a)
FORTRAN_PATH=$(dirname ${FORTRAN_PATH})

cd ${TMP_DIR}
cp ${CONFIG_TEMPLATE} ${CONFIG}
sed -i 's/{{ compiler }}/g++-5/g' ${CONFIG}
sed -i 's/{{ compiler_flags }}/"-Wall -Wextra -Werror -Wshadow -Woverloaded-virtual -ansi -O3 -mavx -DNDEBUG -fpermissive -ansi -O3 -DNDEBUG -DBLAZE_USE_BOOST_THREADS --std=c++14"/g' ${CONFIG}
sed -i 's~{{ lapack_path }}~/tmp/pkb/lapack-3.6.1/lib~g' ${CONFIG}
sed -i 's~{{ lapack_libs }}~"-llapack -lblas -L'${FORTRAN_PATH}' -lgfortran"~g' ${CONFIG}

cd ${BLAZEMARK_DIR}
./configure ${CONFIG}
make -j 8
