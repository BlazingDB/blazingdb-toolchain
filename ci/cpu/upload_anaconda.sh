#!/bin/bash

set -e

export RAPIDS_FILE=`conda build conda/recipes/bsql-rapids-thirdparty/ --output`
export TAR_FILE=`conda build conda/recipes/bsql-toolchain/ --output`

LABEL_OPTION="--label main"
echo "LABEL_OPTION=${LABEL_OPTION}"

if [ -z "$MY_UPLOAD_KEY" ]; then
    echo "No upload key"
    return 0
fi

test -e ${RAPIDS_FILE}
echo "Upload file: "${RAPIDS_FILE}
anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_UPLOAD} ${LABEL_OPTION} --force ${RAPIDS_FILE}

test -e ${TAR_FILE}
echo "Upload file: "${TAR_FILE}
anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_UPLOAD} ${LABEL_OPTION} --force ${TAR_FILE}
