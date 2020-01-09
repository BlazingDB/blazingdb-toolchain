#!/bin/bash

INSTALL_PREFIX=${INSTALL_PREFIX:=${PREFIX:=${CONDA_PREFIX}}}

DIR_BSQL="bsql-rapids-thirdparty"
mkdir -p $INSTALL_PREFIX/include/bsql-rapids-thirdparty/
git clone -b branch-0.12 --recurse-submodules https://github.com/rapidsai/cudf.git

cp -rf cudf/thirdparty/cub ${INSTALL_PREFIX}/include/$DIR_BSQL/cub

rm -rf cudf/thirdparty/libcudacxx/libcxx/test/
cp -rf cudf/thirdparty/libcudacxx ${INSTALL_PREFIX}/include/$DIR_BSQL/libcudacxx

