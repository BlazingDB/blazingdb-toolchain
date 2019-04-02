#!/bin/bash

nvstrings_install_dir=$1

echo " ==>> Performing patch for NVStrings on $nvstrings_install_dir"

#TODO percy remove this fix once cudf use modern custrings
cp $nvstrings_install_dir/include/nvstrings/*.h $nvstrings_install_dir/include/

#NOTE percy it seems they are using pragma once so these patches would not be necessary
#TODO percy remove this fix once nvstrings has pre compiler flags in its headers
#sed -i '1s/^/#define NVIDIA_NV_STRINGS_H_NVStrings\n/' $nvstrings_install_dir/include/NVStrings.h
#sed -i '1s/^/#ifndef NVIDIA_NV_STRINGS_H_NVStrings\n/' $nvstrings_install_dir/include/NVStrings.h
#echo "#endif" >> $nvstrings_install_dir/include/NVStrings.h

#sed -i '1s/^/#define NVIDIA_NV_STRINGS_H_NVCategory\n/' $nvstrings_install_dir/include/NVCategory.h
#sed -i '1s/^/#ifndef NVIDIA_NV_STRINGS_H_NVCategory\n/' $nvstrings_install_dir/include/NVCategory.h
#echo "#endif" >> $nvstrings_install_dir/include/NVCategory.h
