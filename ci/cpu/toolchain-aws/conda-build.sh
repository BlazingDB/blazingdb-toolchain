#!/bin/bash

echo "CMD: conda build -c conda-forge -c defaults conda/recipes/blazingsql-toolchain-aws-cpp/"
conda build -c conda-forge -c defaults conda/recipes/blazingsql-toolchain-aws-cpp/
