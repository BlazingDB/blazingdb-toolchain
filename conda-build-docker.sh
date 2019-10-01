#!/bin/bash
# usage:   ./conda-build-docker.sh token
# example: ./conda-build-docker.sh 123

export WORKSPACE=$PWD

docker run -e MY_UPLOAD_KEY=$1 --rm -v ${WORKSPACE}:${WORKSPACE} -w ${WORKSPACE} gpuci/miniconda-cuda:9.2-devel-ubuntu16.04 ./ci/cpu/build.sh
