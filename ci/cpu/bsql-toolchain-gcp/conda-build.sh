#!/bin/bash

echo "CMD: conda build -c conda-forge -c defaults conda/recipes/bsql-toolchain-gcp-cpp/"
conda build -c conda-forge -c defaults conda/recipes/bsql-toolchain-gcp-cpp/
