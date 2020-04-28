#!/bin/bash

echo "CMD: conda build -c conda-forge -c defaults conda/recipes/bsql-spdlog/"
conda build -c conda-forge -c defaults conda/recipes/bsql-spdlog/
