#!/bin/bash

echo "conda build -c ${CONDA_BUILD} -c conda-forge -c defaults conda/recipes/blazingsql-toolchain/"
conda build -c ${CONDA_BUILD} -c conda-forge -c defaults conda/recipes/blazingsql-toolchain/
