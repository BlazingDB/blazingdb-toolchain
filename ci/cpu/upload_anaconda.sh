#!/bin/bash

set -e

export TAR_FILE=`conda build conda/recipes/blazingsql-toolchain --output`

LABEL_OPTION="--label main"
echo "LABEL_OPTION=${LABEL_OPTION}"

if [ -z "$MY_UPLOAD_KEY" ]; then
    echo "No upload key"
    return 0
fi

test -e ${TAR_FILE}
echo "Upload file: "${TAR_FILE}

if [ -z "$CONDA_UPLOAD" ]; then
    CONDA_UPLOAD="blazingsql"
fi

anaconda -t ${MY_UPLOAD_KEY} upload -u ${CONDA_UPLOAD} ${LABEL_OPTION} --force ${TAR_FILE}
