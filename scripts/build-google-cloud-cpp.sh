#!/bin/bash

project_root_dir=$1
current_conda_prefix=$CURRENT_CONDA_PREFIX

working_directory=$PWD

cd $project_root_dir
gcs_deps_dir=$project_root_dir/build/gcs/deps/
gcs_install_dir=$project_root_dir/build/gcs/install/
mkdir -p $gcs_deps_dir

#NOTE https://github.com/googleapis/google-cloud-cpp/blob/master/INSTALL.md#ubuntu-1604---xenial-xerus

export CFLAGS="-DCURL_STATICLIB"
export CXXFLAGS="-DCURL_STATICLIB"
export PKG_CONFIG_PATH=$current_conda_prefix/lib/pkgconfig/
export PATH=$PATH:$gcs_install_dir/bin/:$current_conda_prefix/bin/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$gcs_install_dir/lib/:$current_conda_prefix/lib/

#BEGIN crc32c

echo "====> Building crc32c ..."

cd $gcs_deps_dir
wget -q https://github.com/google/crc32c/archive/1.0.6.tar.gz
if [ $? != 0 ]; then
    echo "ERROR: Could not download https://github.com/google/crc32c/archive/1.0.6.tar.gz"
    exit 1
fi

tar -xf 1.0.6.tar.gz
if [ $? != 0 ]; then
    echo "ERROR: Could not decompress 1.0.6.tar.gz"
    exit 1
fi

cd crc32c-1.0.6

cmake \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=NO \
      -DCRC32C_BUILD_TESTS=OFF \
      -DCRC32C_BUILD_BENCHMARKS=OFF \
      -DCRC32C_USE_GLOG=OFF \
      -DCMAKE_INSTALL_PREFIX=$gcs_install_dir \
      -H. -Bcmake-out/crc32c
if [ $? != 0 ]; then
    echo "ERROR: Could not run cmake on crc32c"
    exit 1
fi

cmake --build cmake-out/crc32c --target install -- -j ${NCPU:-4}
if [ $? != 0 ]; then
    echo "ERROR: Could not run make crc32c"
    exit 1
fi

echo "====> crc32c DONE!"

#END crc32c

#BEGIN googleapis c++

echo "====> Building googleapis c++ ..."

cd $gcs_deps_dir

wget -q https://github.com/googleapis/cpp-cmakefiles/archive/v0.1.5.tar.gz
if [ $? != 0 ]; then
    echo "ERROR: Could not download  https://github.com/googleapis/cpp-cmakefiles/archive/v0.1.5.tar.gz"
    exit 1
fi

tar -xf v0.1.5.tar.gz
if [ $? != 0 ]; then
    echo "ERROR: Could not decompress v0.1.5.tar.gz"
    exit 1
fi

cd cpp-cmakefiles-0.1.5

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=NO \
    -DCMAKE_INSTALL_PREFIX=$gcs_install_dir \
    -H. -Bcmake-out
if [ $? != 0 ]; then
    echo "ERROR: Could not run cmake on googleapis c++"
    exit 1
fi

cmake --build cmake-out --target install -- -j ${NCPU:-4}
if [ $? != 0 ]; then
    echo "ERROR: Could not run make on googleapis c++"
    exit 1
fi

echo "====> googleapis c++ DONE!"

#END googleapis c++ CONDA

#BEGIN google-cloud-cpp

echo "====> Building google-cloud-cpp ..."

cd $gcs_deps_dir

wget https://github.com/googleapis/google-cloud-cpp/archive/v0.13.0.tar.gz
if [ $? != 0 ]; then
    echo "ERROR: Could not download https://github.com/googleapis/google-cloud-cpp/archive/v0.13.0.tar.gz"
    exit 1
fi

tar xf v0.13.0.tar.gz
if [ $? != 0 ]; then
    echo "ERROR: Could not decompress v0.13.0.tar.gz"
    exit 1
fi

cd google-cloud-cpp-0.13.0
# NOTE force include crc32c headers
export CPATH=$CPATH:$gcs_install_dir/include/:$current_conda_prefix/include/

cmake -DGOOGLE_CLOUD_CPP_ENABLE_BIGTABLE=OFF \
      -DBUILD_TESTING=OFF \
      -DCMAKE_MODULE_PATH=$gcs_install_dir/lib/cmake/ \
      -DCMAKE_INSTALL_PREFIX=$gcs_install_dir \
      -H. -Bcmake-out
if [ $? != 0 ]; then
    echo "ERROR: Could not run cmake on google-cloud-cpp"
    exit 1
fi

cmake --build cmake-out -- -j ${NCPU:-4} install
if [ $? != 0 ]; then
    echo "ERROR: Could not run make on google-cloud-cpp"
    exit 1
fi

echo "====> google-cloud-cpp DONE"

#END google-cloud-cpp

cd $working_directory
