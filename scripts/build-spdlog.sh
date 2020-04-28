#!/bin/bash

project_root_dir=$1
current_conda_prefix=$CURRENT_CONDA_PREFIX

working_directory=$PWD

cd $project_root_dir
spdlog_install_dir=$project_root_dir/build/spdlog/install/
mkdir -p $spdlog_deps_dir

export PKG_CONFIG_PATH=$current_conda_prefix/lib/pkgconfig/
export PATH=$PATH:$spdlog_install_dir/bin/:$current_conda_prefix/bin/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$spdlog_install_dir/lib/:$current_conda_prefix/lib/

#BEGIN spdlog

echo "====> Building spdlog ..."

cd $spdlog_deps_dir

wget https://github.com/gabime/spdlog/archive/v1.5.0.tar.gz
if [ $? != 0 ]; then
    echo "ERROR: Could not download https://github.com/gabime/spdlog/archive/v1.5.0.tar.gz"
    exit 1
fi

tar xf v1.5.0.tar.gz
if [ $? != 0 ]; then
    echo "ERROR: Could not decompress v1.5.0.tar.gz"
    exit 1
fi

cd spdlog-1.5.0

# NOTE percy jp patch for stringview
cp $project_root_dir/patches/spdlog-patch/include_spdlog_fmt_bundled/core.h include/spdlog/fmt/bundled

if [ $? != 0 ]; then
    echo "ERROR: Could not apply patch for stringview"
    exit 1
fi

echo "INFO: spdlog patch for c++ stringview applied!"

export CPATH=$CPATH:$spdlog_install_dir/include/:$current_conda_prefix/include/

cmake -DSPDLOG_BUILD_SHARED=ON \
      -DSPDLOG_BUILD_TESTS=OFF \
      -DSPDLOG_BUILD_TESTS_HO=OFF \
      -DCMAKE_MODULE_PATH=$spdlog_install_dir/lib/cmake/ \
      -DCMAKE_INSTALL_PREFIX=$spdlog_install_dir \
      -H. -Bcmake-out
if [ $? != 0 ]; then
    echo "ERROR: Could not run cmake on spdlog"
    exit 1
fi

cmake --build cmake-out -- -j ${NCPU:-4} install
if [ $? != 0 ]; then
    echo "ERROR: Could not run make on spdlog"
    exit 1
fi

echo "====> spdlog DONE"

#END spdlog

cd $working_directory
