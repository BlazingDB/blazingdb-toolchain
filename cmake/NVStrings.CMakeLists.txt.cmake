#=============================================================================
# Copyright 2018 BlazingDB, Inc.
#     Copyright 2018 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

cmake_minimum_required(VERSION 2.8.12)

cmake_policy(SET CMP0048 NEW)

project(nvstrings-download NONE)

include(ExternalProject)

ExternalProject_Add(nvstrings
    GIT_REPOSITORY    https://github.com/rapidsai/custrings.git
    GIT_TAG           branch-0.4
    SOURCE_SUBDIR     cpp
    SOURCE_DIR        "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/nvstrings-src"
    BINARY_DIR        "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/nvstrings-build"
    INSTALL_DIR       "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/nvstrings-install"
    UPDATE_COMMAND    ""
    CMAKE_ARGS        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                      -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/nvstrings-install
                      ${NVSTRINGS_CMAKE_ARGS}
)
