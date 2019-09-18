#!/bin/bash

set -e

export TAR_FILE=`conda build conda/recipes/blazingdb-toolchain --python=$PYTHON --output`

LABEL_OPTION="--label main"
echo "LABEL_OPTION=${LABEL_OPTION}"

if [ -z "$MY_UPLOAD_KEY" ]; then
    echo "No upload key"
    return 0
fi

test -e ${TAR_FILE}
echo "Upload communication"
echo ${TAR_FILE}
anaconda -t ${MY_UPLOAD_KEY} upload -u blazingsql ${LABEL_OPTION} --force ${TAR_FILE}
