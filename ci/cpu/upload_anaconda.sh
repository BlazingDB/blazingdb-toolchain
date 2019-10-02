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
echo "Upload toolchain"
echo ${TAR_FILE}

# Nightly seccion
echo "IS_NIGHTLY" $IS_NIGHTLY
if [ $IS_NIGHTLY == true ]; then
      NIGHTLY="-nightly"
fi
#echo "anaconda -t ${MY_UPLOAD_KEY} upload -u editha$NIGHTLY ${LABEL_OPTION} --force ${TAR_FILE}"
anaconda -t ${MY_UPLOAD_KEY} upload -u editha$NIGHTLY ${LABEL_OPTION} --force ${TAR_FILE}