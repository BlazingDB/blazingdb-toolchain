#!/bin/bash

INSTALL_PREFIX=${INSTALL_PREFIX:=${PREFIX:=${CONDA_PREFIX}}}

mkdir -p $INSTALL_PREFIX/include/

git clone -b branch-0.12 --recurse-submodules https://github.com/rapidsai/cudf.git

cp -rf cudf/thirdparty/cub ${INSTALL_PREFIX}/include/

cp -rf cudf/thirdparty/libcudacxx ${INSTALL_PREFIX}/include/
rm -rf ${INSTALL_PREFIX}/include/libcudacxx/libcxx/test/

