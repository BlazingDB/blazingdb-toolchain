#!/bin/bash

#project_root_dir=$PWD
project_root_dir=/home/percy/Blazing/projects/code/blazingdb-toolchain/

working_directory=$PWD

cd $project_root_dir
gcs_deps_dir=$project_root_dir/build/gcs/deps/
gcs_install_dir=$project_root_dir/build/gcs/install/
mkdir -p $gcs_deps_dir

#NOTE https://github.com/googleapis/google-cloud-cpp/blob/master/INSTALL.md#ubuntu-1604---xenial-xerus

#BEGIN crc32c

cd $gcs_deps_dir
wget -q https://github.com/google/crc32c/archive/1.0.6.tar.gz
tar -xf 1.0.6.tar.gz
cd crc32c-1.0.6
cmake \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=no \
      -DCRC32C_BUILD_TESTS=OFF \
      -DCRC32C_BUILD_BENCHMARKS=OFF \
      -DCRC32C_USE_GLOG=OFF \
      -DCMAKE_INSTALL_PREFIX=$gcs_install_dir \
      -H. -Bcmake-out/crc32c
cmake --build cmake-out/crc32c --target install -- -j ${NCPU:-4}

#END crc32c

#BEGIN googleapis c++

cd $gcs_deps_dir
wget -q https://github.com/googleapis/cpp-cmakefiles/archive/v0.1.5.tar.gz
tar -xf v0.1.5.tar.gz
cd cpp-cmakefiles-0.1.5

export PATH=$PATH:$gcs_install_dir/bin/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$gcs_install_dir/lib/:$CONDA_PREFIX/lib/

cmake \
    -DBUILD_SHARED_LIBS=NO \
    -DCMAKE_INSTALL_PREFIX=$gcs_install_dir \
    -H. -Bcmake-out
cmake --build cmake-out --target install -- -j ${NCPU:-4}

#END googleapis c++ CONDA

#BEGIN google-cloud-cpp

cd $gcs_deps_dir
wget https://github.com/googleapis/google-cloud-cpp/archive/v0.13.0.tar.gz
tar xvf v0.13.0.tar.gz
cd google-cloud-cpp-0.13.0
# NOTE force include crc32c headers
export CPATH=$CPATH:$gcs_install_dir/include/:$CONDA_PREFIX/include/
export PKG_CONFIG_PATH=$gcs_install_dir/lib/pkgconfig/
cmake -DGOOGLE_CLOUD_CPP_ENABLE_BIGTABLE=OFF \
      -DBUILD_TESTING=OFF \
      -DCMAKE_MODULE_PATH=$gcs_install_dir/lib/cmake/ \
      -Dprotobuf_DIR=$CONDA_PREFIX \
      -DCMAKE_INSTALL_PREFIX=$gcs_install_dir \
      -H. -Bcmake-out
cmake --build cmake-out -- -j ${NCPU:-4}
cmake --build cmake-out -- -j ${NCPU:-4} install

#END google-cloud-cpp

cd $working_directory
