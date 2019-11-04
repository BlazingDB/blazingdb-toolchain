#!/bin/bash
# usage:   ./conda-build-docker.sh token conda-upload
# example: ./conda-build-docker.sh 123 blazingsql-nightly

export WORKSPACE=$PWD

docker run  -e MY_UPLOAD_KEY=$1 -e CONDA_UPLOAD=$2 --rm -v ${WORKSPACE}:${WORKSPACE} -w ${WORKSPACE} gpuci/miniconda-cuda:10.0-devel-ubuntu16.04 ./ci/cpu/build.sh
