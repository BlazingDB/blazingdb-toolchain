#!/bin/bash
# usage:   ./conda-build-docker.sh conda-build conda-upload token
# example: ./conda-build-docker.sh blazingsql-nightly blazingsql-nightly 123

export WORKSPACE=$PWD

docker run -e CONDA_BUILD=$1 -e CONDA_UPLOAD=$2 -e MY_UPLOAD_KEY=$3 --rm -v ${WORKSPACE}:${WORKSPACE} -w ${WORKSPACE} gpuci/miniconda-cuda:10.0-devel-ubuntu16.04 ./ci/cpu/build.sh
