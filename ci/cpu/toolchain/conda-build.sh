#!/bin/bash

conda build -c conda-forge -c defaults --python=$PYTHON conda/recipes/blazingsql-toolchain/
