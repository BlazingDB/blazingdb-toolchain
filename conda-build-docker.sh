#!/bin/bash
# usage:   ./conda-build-docker.sh python_version token
# example: ./conda-build-docker.sh 3.7|3.6 123

export WORKSPACE=$PWD
PYTHON_VERSION="3.7"
if [ ! -z $1 ]; then
    PYTHON_VERSION=$1
fi

docker run -e PYTHON=$PYTHON_VERSION -e MY_UPLOAD_KEY=$2 --rm -v ${WORKSPACE}:${WORKSPACE} -w ${WORKSPACE} gpuci/miniconda-cuda:9.2-devel-ubuntu16.04 ./ci/cpu/build.sh
