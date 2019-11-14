#!/bin/bash

echo "CMD: conda build -c conda-forge -c defaults conda/recipes/bsql-toolchain-aws-cpp/"
conda build -c conda-forge -c defaults conda/recipes/bsql-toolchain-aws-cpp/
