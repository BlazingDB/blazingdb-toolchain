#!/bin/bash

build_type=Release
if [ ! -z $1 ]; then
  build_type=$1
fi

INSTALL_PREFIX=${INSTALL_PREFIX:=${PREFIX:=${CONDA_PREFIX}}}

mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=$build_type -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}
make -j8 install
