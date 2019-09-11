#!/bin/bash

#project_root_dir=$PWD
project_root_dir=/home/percy/Blazing/projects/code/blazingdb-toolchain/

working_directory=$PWD

cd $project_root_dir
gcs_build_dir=$project_root_dir/build/gcs/build/
gcs_deps_dir=$project_root_dir/build/gcs/deps/
gcs_install_dir=$project_root_dir/build/gcs/install/
mkdir -p $gcs_build_dir

#NOTE https://github.com/googleapis/google-cloud-cpp/blob/master/INSTALL.md#ubuntu-1604---xenial-xerus

#BEGIN crc32c

cd $gcs_build_dir
wget -q https://github.com/google/crc32c/archive/1.0.6.tar.gz
tar -xf 1.0.6.tar.gz
cd crc32c-1.0.6
cmake \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=yes \
      -DCRC32C_BUILD_TESTS=OFF \
      -DCRC32C_BUILD_BENCHMARKS=OFF \
      -DCRC32C_USE_GLOG=OFF \
      -DCMAKE_INSTALL_PREFIX=$gcs_deps_dir \
      -H. -Bcmake-out/crc32c
cmake --build cmake-out/crc32c --target install -- -j ${NCPU:-4}

#END crc32c

#BEGIN protobuf CONDA

## cd $gcs_build_dir
## wget -q https://github.com/google/protobuf/archive/v3.6.1.tar.gz
## tar -xf v3.6.1.tar.gz
## cd protobuf-3.6.1/cmake
## #percy -DBUILD_SHARED_LIBS=yes debe ser yes porque sino luego grcp se queja
## cmake -DCMAKE_BUILD_TYPE=Release \
##       -DBUILD_SHARED_LIBS=yes \
##       -Dprotobuf_BUILD_TESTS=OFF \
##       -DCMAKE_INSTALL_PREFIX=$gcs_deps_dir \
##       -H. -Bcmake-out
## cmake --build cmake-out --target install -- -j ${NCPU:-4}

#END protobuf

#BEGIN cares CONDA

## cd $gcs_build_dir
## wget -q https://github.com/c-ares/c-ares/archive/cares-1_14_0.tar.gz
## tar -xf cares-1_14_0.tar.gz
## cd c-ares-cares-1_14_0
## mkdir -p build
##  #./buildconf
## #./configure --prefix=/home/percy/Blazing/projects/local/dependencies/install/ esta forma es la antigua con unix y no es compatible si construyes grpc con cmake
## cd build
## cmake -DCMAKE_INSTALL_PREFIX=$gcs_deps_dir ..
## make -j8
## make -j8 install

#END cares CONDA

#BEGIN gflags CONDA

## cd $gcs_build_dir
## git clone https://github.com/gflags/gflags.git
## cd gflags
## mkdir -p build
## cd build
## cmake -DCMAKE_INSTALL_PREFIX=$gcs_deps_dir ..

#END gflags CONDA

#BEGIN grpc CONDA
## cd $gcs_build_dir
## instalar 
## wget -q https://github.com/grpc/grpc/archive/v1.19.1.tar.gz
## tar -xf v1.19.1.tar.gz
## no se puede con cmake o es muy yuka no hay tiempo meh mejor asi nomas
## cd grpc-1.19.1
## export PKG_CONFIG_PATH=$gcs_deps_dir/lib/pkgconfig/

#para protoc

## # TODO percy CONDA deberiamos usar el protoc de conda
## export PATH=$PATH:$gcs_deps_dir/bin/
## 
## make -j8
## 
## aparitr de la linea 236 del make
# General settings.
# You may want to change these depending on your system.

#prefix ?= /usr/local

## #BEGIN percy
## prefix ?= /home/percy/Blazing/projects/local/dependencies/install/
## #END percy


# cd build
# cmake -Dprotobuf_BUILD_TESTS=OFF -DProtobuf_USE_STATIC_LIBS=ON -DProtobuf_SRC_ROOT_FOLDER=/home/percy/Blazing/projects/local/dependencies/protobuf/protobuf-3.6.1/ -DCMAKE_INSTALL_PREFIX=/home/percy/Blazing/projects/local/dependencies/install/ ..
# 
# y en el cmake princpal modifique todo de provider a pacjkage
# # Providers for third-party dependencies (gRPC_*_PROVIDER properties):
# # "module": build the dependency using sources from git submodule (under third_party)
# # "package": use cmake's find_package functionality to locate a pre-installed dependency
# 
# set(gRPC_ZLIB_PROVIDER "package" CACHE STRING "Provider of zlib library")
# set_property(CACHE gRPC_ZLIB_PROVIDER PROPERTY STRINGS "module" "package")
# 
# set(gRPC_CARES_PROVIDER "package" CACHE STRING "Provider of c-ares library")
# set_property(CACHE gRPC_CARES_PROVIDER PROPERTY STRINGS "module" "package")
# 
# set(gRPC_SSL_PROVIDER "package" CACHE STRING "Provider of ssl library")
# set_property(CACHE gRPC_SSL_PROVIDER PROPERTY STRINGS "module" "package")
# 
# set(gRPC_PROTOBUF_PROVIDER "package" CACHE STRING "Provider of protobuf library")
# set_property(CACHE gRPC_PROTOBUF_PROVIDER PROPERTY STRINGS "module" "package")
# 
# set(gRPC_PROTOBUF_PACKAGE_TYPE "" CACHE STRING "Algorithm for searching protobuf package")
# set_property(CACHE gRPC_PROTOBUF_PACKAGE_TYPE PROPERTY STRINGS "CONFIG" "MODULE")
# 
# set(gRPC_GFLAGS_PROVIDER "package" CACHE STRING "Provider of gflags library")
# set_property(CACHE gRPC_GFLAGS_PROVIDER PROPERTY STRINGS "module" "package")
# 
# set(gRPC_BENCHMARK_PROVIDER "package" CACHE STRING "Provider of benchmark library")
# set_property(CACHE gRPC_BENCHMARK_PROVIDER PROPERTY STRINGS "module" "package")
# 
# yagregue esto
# 
# set(c-ares_DIR "/home/percy/Blazing/projects/local/dependencies/")
# set(gflags_DIR "/home/percy/Blazing/projects/local/dependencies/")
# set(benchmark_DIR "/home/percy/Blazing/projects/local/workspace/dependencies/lib/cmake/benchmark/")
# 
# 
# 
# 

#END grpc CONDA

#BEGIN googleapis c++

#cd $gcs_build_dir
#wget -q https://github.com/googleapis/cpp-cmakefiles/archive/v0.1.5.tar.gz
#tar -xf v0.1.5.tar.gz
#cd cpp-cmakefiles-0.1.5
#
#export PATH=$PATH:$gcs_deps_dir/bin/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$gcs_deps_dir/lib/:$CONDA_PREFIX/lib/
#
#cmake \
#    -DBUILD_SHARED_LIBS=YES \
#    -DCMAKE_INSTALL_PREFIX=$gcs_deps_dir \
#    -H. -Bcmake-out
#cmake --build cmake-out --target install -- -j ${NCPU:-4}

#END googleapis c++ CONDA

#instalar googletest
#cmake \
#      -DCMAKE_BUILD_TYPE="Release" \
#      -DBUILD_SHARED_LIBS=yes \
#      -DCMAKE_INSTALL_PREFIX=/home/percy/Blazing/projects/local/dependencies/install/  \
#      -H. -Bcmake-out
#cmake --build cmake-out --target install -- -j ${NCPU:-4}

#BEGIN google-cloud-cpp

cd $gcs_build_dir
#wget https://github.com/googleapis/google-cloud-cpp/archive/v0.13.0.tar.gz
#tar xvf v0.13.0.tar.gz
cd google-cloud-cpp-0.13.0

#NOTE usaremos el de conda aqui
#export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:/home/percy/Blazing/projects/local/dependencies/install/

#como falla al encotnrar el include de crc32c le digo q use por cpath (tanto para c/c++) el dir adecuado
export CPATH=$CPATH:$gcs_deps_dir/include/:$CONDA_PREFIX/include/

export PKG_CONFIG_PATH=$gcs_deps_dir/lib/pkgconfig/

cmake -DGOOGLE_CLOUD_CPP_ENABLE_BIGTABLE=OFF \
      -DBUILD_TESTING=OFF \
      -DCMAKE_MODULE_PATH=$gcs_deps_dir/lib/cmake/ \
      -Dprotobuf_DIR=$CONDA_PREFIX \
      -DCMAKE_INSTALL_PREFIX=$gcs_install_dir \
      -H. -Bcmake-out
cmake --build cmake-out -- -j ${NCPU:-4}
cmake --build cmake-out -- -j ${NCPU:-4} install

#no es necesario correr ni hacer build de los tests
#cd $HOME/google-cloud-cpp/cmake-out
#ctest --output-on-failure
#sudo cmake --build . --target install

#END google-cloud-cpp

cd $working_directory
