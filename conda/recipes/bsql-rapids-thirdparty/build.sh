#!/bin/bash

INSTALL_PREFIX=${INSTALL_PREFIX:=${PREFIX:=${CONDA_PREFIX}}}

mkdir -p $INSTALL_PREFIX/include/
#cp -rf bsql-rapids-thirdparty/* ${INSTALL_PREFIX}/include/

#echo $PWD
#ls -la $PWD
git clone -b branch-0.12 --recurse-submodules https://github.com/rapidsai/cudf.git

cp -rf cudf/thirdparty/cub ${INSTALL_PREFIX}/include/

#rm -rf cudf/thirdparty/libcudacxx/include/libcudacxx/libcxx/test/
cp -rf cudf/thirdparty/libcudacxx ${INSTALL_PREFIX}/include/
rm -rf ${INSTALL_PREFIX}/include/libcudacxx/libcxx/test/

# Cub
#git clone -b cudf-cub https://github.com/rapidsai/thirdparty-cub.git ${INSTALL_PREFIX}/include/cub/
# Freestanding
#git clone -b cudf --recurse-submodules https://github.com/rapidsai/thirdparty-freestanding.git ${INSTALL_PREFIX}/include/libcudacxx/
#rm -rf ${INSTALL_PREFIX}/include/libcudacxx/libcxx/test/

