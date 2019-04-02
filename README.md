# BlazingSQL dependencies

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
