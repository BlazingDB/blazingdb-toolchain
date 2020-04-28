#!/bin/bash
# Copyright (c) 2019, BLAZINGSQL.
######################################
# blazingsql-toolchain CPU conda build script for CI #
######################################
set -e

# Logger function for build status output
function logger() {
  echo -e "\n>>>> $@\n"
}

# Set home to the job's workspace
export HOME=$WORKSPACE

# Switch to project root; also root of repo checkout
cd $WORKSPACE

# Get latest tag and number of commits since tag
export GIT_DESCRIBE_TAG=`git describe --abbrev=0 --tags`
export GIT_DESCRIBE_NUMBER=`git rev-list ${GIT_DESCRIBE_TAG}..HEAD --count`

CONDA_CH=""
if [ ! -z "$CONDA_BUILD" ]; then
    IFS=', ' read -r -a array <<< "$CONDA_BUILD"
    for item in "${array[@]}"
    do
        CONDA_CH=$CONDA_CH" -c "$item
    done
fi
export CONDA_CH

if [ -z "$CONDA_UPLOAD" ]; then
    CONDA_UPLOAD="blazingsql"
fi
export CONDA_UPLOAD

################################################################################
# SETUP - Check environment
################################################################################

logger "Creating bsql-builder"
conda create -n bsql-builder python=3.7.4 -y
source activate bsql-builder

logger "Get env..."
env

logger "Check versions..."
python --version
gcc --version
g++ --version
conda list

# FIX Added to deal with Anancoda SSL verification issues during conda builds
conda config --set ssl_verify False

logger "Install dependencies..."
conda install -y conda-build anaconda-client

################################################################################
# BUILD - Conda package builds
################################################################################

logger "Build conda pkg for toolchain-aws..."
source ci/cpu/bsql-toolchain-aws/conda-build.sh

logger "Build conda pkg for toolchain-gcp..."
source ci/cpu/bsql-toolchain-gcp/conda-build.sh

logger "Build conda pkg for bsql-rapids-thirdparty..."
source ci/cpu/bsql-rapids-thirdparty/conda-build.sh

logger "Build conda pkg for bsql-spdlog..."
source ci/cpu/bsql-spdlog/conda-build.sh

logger "Build conda pkg for toolchain..."
source ci/cpu/bsql-toolchain/conda-build.sh

logger "Upload conda pkg for toolchain-aws..."
source ci/cpu/upload_anaconda.sh
