#!/bin/bash

echo "CMD: conda build -c ${CONDA_CH} -c conda-forge -c defaults conda/recipes/blazingsql-toolchain/"
conda build -c ${CONDA_CH} -c conda-forge -c defaults conda/recipes/blazingsql-toolchain/
