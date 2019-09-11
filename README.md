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
# Install common dev tools
apt-get install -y build-essential ssh wget curl git

# Add classic autotools suite
apt-get -y install libtool automake autoconf pkg-config

# Install AWS C++ SDK dependencies
apt-get install -y --no-install-recommends libcurl4-openssl-dev libssl-dev uuid-dev zlib1g-dev
 
```

# Build

See conda-build process.
