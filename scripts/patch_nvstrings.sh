#!/bin/bash

nvstrings_install_dir=$1

#TODO percy remove this fix once nvstrings has pre compiler flags in its headers
sed -i '1s/^/#define NVIDIA_NV_STRINGS_H_NVStrings\n/' $nvstrings_install_dir/include/NVStrings.h
sed -i '1s/^/#ifndef NVIDIA_NV_STRINGS_H_NVStrings\n/' $nvstrings_install_dir/include/NVStrings.h
echo "#endif" >> $nvstrings_install_dir/include/NVStrings.h

sed -i '1s/^/#define NVIDIA_NV_STRINGS_H_NVCategory\n/' $nvstrings_install_dir/include/NVCategory.h
sed -i '1s/^/#ifndef NVIDIA_NV_STRINGS_H_NVCategory\n/' $nvstrings_install_dir/include/NVCategory.h
echo "#endif" >> $nvstrings_install_dir/include/NVCategory.h
