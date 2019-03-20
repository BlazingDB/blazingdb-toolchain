# Build

cd blazingdb-dependencies
mkdir -p build
cd build
CUDACXX=/usr/local/cuda-9.2/bin/nvcc cmake -DPYTHON_LIBRARY=/home/percy/Applications/anaconda/conda/envs/blazing/lib/ -DPYTHON_INCLUDE_DIR=/home/percy/Applications/anaconda/conda/envs/blazing/include/python3.5m/ -DCMAKE_INSTALL_PREFIX=/home/tus_dependencies/ ..
make -j8 install


PYTHON_LIBRARY es donde esta libpython3.x.so
PYTHON_INCLUDE_DIR es donde esta Python.h









LO DE ABAAJO FALTA NO HACER CASO POR EL MOMENTO 























OJOOOOOOOOOOOOOOOO


en los configure y templtes y todo lo q sea de blazingdb siempre usar los install_dir definidos en bzdbdependencies.cmake ... nunca usar los X_root alli porqu corren el riesgo q el usurio no los defina (por ejemplo google tests etc)



--------------


# blazingdb-ral
BlazingDB Relational Algebra Interpreter
 b
# Requirements
- g++-5.4
- CMake 3.11+
- Make

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

# Dependencies
- nvstrings
- boost
- aws_sdk_cpp
- flatbuffers
- lz4
- zstd
- brotli
- snappy
- thrift
- arrow
- libgdf (cudf/cpp)
- blazingdb-protocol
- blazingdb-io
- GoogleTest

## Build the dependencies
Setup your workspace and output folders:
```bash
mkdir workspace
mkdir output
cd workspace
wget https://github.com/BlazingDB/blazingdb-automation/blob/develop/docker/blazingsql-build/blazingsql-build.properties
```

The blazingsql-build.properties describes how you want to build BlazingSQL, if you want to build only the dependencies then disable the unnecessary modules:
```bash
...
#optional: enable build (default is true)
cudf_enable=true
blazingdb_protocol_enable=true
blazingdb_io_enable=true
blazingdb_ral_enable=false
blazingdb_orchestrator_enable=false
blazingdb_calcite_enable=false
pyblazing_enable=false
...
```

Finally run the build.sh script: 
```bash
wget https://github.com/BlazingDB/blazingdb-automation/blob/develop/docker/blazingsql-build/build.sh
chmod +x build.sh
./build.sh /path/to/workspace /path/to/output
```

All the dependencies will be inside /path/to/workspace/ where:

- Low level dependencies are located in /path/to/workspace/dependencies
- BlazingSQL & RAPIDS dependencies are located in /path/to/workspace/$component_project/$branch/install

| /path/to/workspace/dependencies | /path/to/workspace/blazingdb-$component_project/$branch/install |
| ------------- | ------------- |
| nvstrings_install_dir | libgdf_install_dir |
| boost_install_dir | blazingdb_protocol_install_dir |
| aws_sdk_cpp_build_dir | blazingdb_io_install_dir |
| flatbuffers_install_dir |
| lz4_install_dir | |
| zstd_install_dir | |
| brotli_install_dir | |
| snappy_install_dir | |
| thrift_install_dir | |
| arrow_install_dir | |
| googletest_install_dir | |

Note: The $branch is based on blazingsql-build.properties but usually $branch is develop 

# Clone
This repo uses submodules. Make sure you cloned recursively:

```bash
git clone --recurse-submodules git@github.com:BlazingDB/blazingdb-ral.git
```

Or, after cloning:

```bash
cd blazingdb-ral
git submodule update --init --recursive
```

# Build
There are two ways to build the RAL component (for both cases you don't need to have conda in your system).

## First approach: Basic build
The first one will automagically download all the RAL dependencies as part of the cmake process.

```bash
cd blazingdb-ral
mkdir build
CUDACXX=/usr/local/cuda-9.2/bin/nvcc cmake -DCMAKE_BUILD_TYPE=Debug ..
make
```

## Second approach: Custom build with dependencies
This second approach will reuse your development environment.
So you just need to pass cmake arguments for installation paths of the dependencies you want.

```bash
cd blazingdb-ral
mkdir build
CUDACXX=/usr/local/cuda-9.2/bin/nvcc cmake -DCMAKE_BUILD_TYPE=Debug \
      -DNVSTRINGS_INSTALL_DIR=/path/to/workspace/dependencies/nvstrings_install_dir \
      -DBOOST_INSTALL_DIR=/path/to/workspace/dependencies/boost_install_dir \
      -DAWS_SDK_CPP_BUILD_DIR=/path/to/workspace/dependencies/aws_sdk_cpp_build_dir \
      -DFLATBUFFERS_INSTALL_DIR=/path/to/workspace/dependencies/flatbuffers_install_dir \
      -DLZ4_INSTALL_DIR=/path/to/workspace/dependencies/lz4_install_dir \
      -DZSTD_INSTALL_DIR=/path/to/workspace/dependencies/zstd_install_dir \
      -DBROTLI_INSTALL_DIR=/path/to/workspace/dependencies/brotli_install_dir \
      -DSNAPPY_INSTALL_DIR=/path/to/workspace/dependencies/snappy_install_dir \
      -DTHRIFT_INSTALL_DIR=/path/to/workspace/dependencies/thrift_install_dir \
      -DARROW_INSTALL_DIR=/path/to/workspace/dependencies/_install_dir \
      -DLIBGDF_INSTALL_DIR=/path/to/workspace/dependencies/libgdf_install_dir \
      -DBLAZINGDB_PROTOCOL_INSTALL_DIR=/path/to/workspace/blazingdb-protocol_project/$branch/install \
      -DBLAZINGDB_IO_INSTALL_DIR=/path/to/workspace/blazingdb-io_project/$branch/install \
      -DGOOGLETEST_INSTALL_DIR=/path/to/workspace/dependencies/googletest_install_dir \
      ..
make
```

Remember NVSTRINGS_INSTALL_DIR and LIBGDF_INSTALL_DIR always go together.

Also, if you don't define any of these optional arguments then the cmake process will resolve (download & build) each dependency:
- NVSTRINGS_INSTALL_DIR
- BOOST_INSTALL_DIR
- AWS_SDK_CPP_BUILD_DIR
- FLATBUFFERS_INSTALL_DIR
- LZ4_INSTALL_DIR
- ZSTD_INSTALL_DIR
- BROTLI_INSTALL_DIR
- SNAPPY_INSTALL_DIR
- THRIFT_INSTALL_DIR
- ARROW_INSTALL_DIR
- LIBGDF_INSTALL_DIR
- BLAZINGDB_PROTOCOL_INSTALL_DIR
- BLAZINGDB_IO_INSTALL_DIR
- GOOGLETEST_INSTALL_DIR

Finally, if don't want to use conda and need the nvstrings library, just download https://anaconda.org/nvidia/nvstrings/0.0.3/download/linux-64/nvstrings-0.0.3-cuda9.2_py35_0.tar.bz2 and uncompress the folder, this folder is the NVSTRINGS_INSTALL_DIR.

### Verbose mode

If you want to show verbose, add these args to cmake:

```bash
CUDACXX=/usr/local/cuda-9.2/bin/nvcc cmake -DCUDA_DEFINES=-DVERBOSE -DCXX_DEFINES=-DVERBOSE ...etc...
```
# Integration Tests

```bash
./integration_test-gen.sh
mkdir -p  build && cd build
LIBGDF_HOME="/path/to/libgdf"cmake ..
make -j8
```
