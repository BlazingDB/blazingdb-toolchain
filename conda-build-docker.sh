#!/bin/bash
# usage:   ./conda-build-docker.sh token
# example: ./conda-build-docker.sh 123

export WORKSPACE=$PWD

docker run -e MY_UPLOAD_KEY=$1 -e IS_NIGHTLY=$2 --rm -v ${WORKSPACE}:${WORKSPACE} -w ${WORKSPACE} gpuci/miniconda-cuda:10.0-devel-ubuntu16.04 ./ci/cpu/build.sh
