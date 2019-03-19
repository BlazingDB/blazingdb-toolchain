#=============================================================================
# Copyright 2018 BlazingDB, Inc.
#     Copyright 2018 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

cmake_minimum_required(VERSION 2.8.12)

cmake_policy(SET CMP0048 NEW)

project(nvstrings-download NONE)

include(ExternalProject)

ExternalProject_Add(nvstrings
    URL               https://anaconda.org/nvidia/nvstrings/0.2.0/download/linux-64/nvstrings-0.2.0-cuda9.2_py36_0.tar.bz2
    SOURCE_DIR        "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/nvstrings-src"
    PATCH_COMMAND     bash ${CMAKE_SOURCE_DIR}/scripts/patch_nvstrings.sh ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/nvstrings-src
    CONFIGURE_COMMAND ""
    BUILD_COMMAND     ""
    INSTALL_COMMAND   ""
)
