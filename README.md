# BlazingSQL dependencies

# Requirements

## Compiler

- g++-5.4

## Builders

- Make

If you want to use Ninja (which is optional) on Ubuntu 16.04 then just run:

```bash
apt-get -y install ninja-build
```

## CMake

We need at least CMake version 3.12+. Follow these commands to install CMake:

```bash
wget https://github.com/Kitware/CMake/releases/download/v3.14.1/cmake-3.14.1-Linux-x86_64.tar.gz
tar xvf cmake-3.14.1-Linux-x86_64.tar.gz 
# Add cmake-3.14.1-Linux-x86_64/bin to your PATH
cmake --version
cmake version 3.14.1

CMake suite maintained and supported by Kitware (kitware.com/cmake).
```

NOTE:
*Never build CMake* use always the official binary releases!!!

## System Requirements

And also make sure to install these system requirements:
```bash
# Install common dev tools
apt-get install -y build-essential ssh wget curl git

# Add autotools suite to build some Apache Parquet dependencies
apt-get -y install libtool automake autoconf

# Install Boost regex dependency
apt-get install -y libicu-dev

# Install AWS C++ SDK dependencies
apt-get install -y --no-install-recommends libcurl4-openssl-dev libssl-dev uuid-dev zlib1g-dev

# Install Apache Arrow / Thrift dependencies
apt-get install -y libssl-dev libtool bison flex pkg-config
```

# Build

```bash
cd blazingdb-dependencies
mkdir -p build
cd build
CUDACXX=/usr/local/cuda-9.2/bin/nvcc cmake -DCMAKE_INSTALL_PREFIX=/foo/blazingsql/dependencies/ ..
make -j8 install
```

NOTE:
If you want to build the dependencies using the old C++ ABI, run the cmake command like this:

```bash
CUDACXX=/usr/local/cuda-9.2/bin/nvcc cmake -DCXX_OLD_ABI=ON -DCMAKE_INSTALL_PREFIX=/foo/blazingsql/dependencies/ ..
```
