#!/bin/bash

echo "CMD: conda build ${CONDA_CH} -c conda-forge -c defaults conda/recipes/bsql-toolchain/"
conda build ${CONDA_CH} -c conda-forge -c defaults conda/recipes/bsql-toolchain/
