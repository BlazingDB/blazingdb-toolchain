#!/bin/bash

set -e

export AWS_FILE=`conda build conda/recipes/bsql-toolchain-aws-cpp/ --output`
export GCP_FILE=`conda build conda/recipes/bsql-toolchain-gcp-cpp/ --output`
export RAPIDS_FILE=`conda build conda/recipes/bsql-rapids-thirdparty/ --output`
export TAR_FILE=`conda build conda/recipes/bsql-toolchain/ --output`

LABEL_OPTION="--label main"
echo "LABEL_OPTION=${LABEL_OPTION}"

if [ -z "$MY_UPLOAD_KEY" ]; then
    echo "No upload key"
    return 0
fi

test -e ${AWS_FILE}
echo "Upload file: "${AWS_FILE}
anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_UPLOAD} ${LABEL_OPTION} --force ${AWS_FILE}

test -e ${GCP_FILE}
echo "Upload file: "${GCP_FILE}
anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_UPLOAD} ${LABEL_OPTION} --force ${GCP_FILE}

test -e ${RAPIDS_FILE}
echo "Upload file: "${RAPIDS_FILE}
anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_UPLOAD} ${LABEL_OPTION} --force ${RAPIDS_FILE}

test -e ${TAR_FILE}
echo "Upload file: "${TAR_FILE}
anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_UPLOAD} ${LABEL_OPTION} --force ${TAR_FILE}
