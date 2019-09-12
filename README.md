# BlazingSQL Toolchain

This project contains software development tools and dependencies to develop and 
build BlazingSQL using Anaconda environments.

# Requirements

## Compiler

- conda

## CMake

We need at least CMake version 3.12+. Follow these commands to install CMake:

**Never build CMake**. Use **always** the **official binary** from conda releases!!!

## System Requirements

And also make sure to install these system requirements:

```bash
# Add classic tools and autotools suite
apt-get -y install wget libtool automake autoconf pkg-config

# Install system dependencies
#apt-get install -y --no-install-recommends uuid-dev zlib1g-dev
```

# Build

```bash
CURRENT_CONDA_PREFIX=$CONDA_PREFIX conda build --label "main" -c conda-forge --python=3.7 --output-folder /some/directory/
```

For more details, see the conda-build process.