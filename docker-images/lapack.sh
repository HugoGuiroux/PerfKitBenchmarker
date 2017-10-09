#!/bin/bash

TMP_DIR=/tmp/pkb
LAPACK_VERSION=3.6.1
LAPACK_FOLDER=lapack-${LAPACK_VERSION}
LAPACK_TAR=${LAPACK_FOLDER}.tgz
LAPACK_URL=http://www.netlib.org/lapack/${LAPACK_TAR}
LAPACK_DIR=${TMP_DIR}/${LAPACK_FOLDER}

cd ${TMP_DIR}/
wget ${LAPACK_URL}
tar xf ${LAPACK_TAR}

cd ${LAPACK_DIR}
mv make.inc.example make.inc.example
cmake .
make -j 8
cd ${LAPACK_DIR}/BLAS
make -j 8
