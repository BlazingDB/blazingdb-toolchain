#=============================================================================
# Copyright 2018 BlazingDB, Inc.
#     Copyright 2018 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

cmake_minimum_required(VERSION 2.8.12)

cmake_policy(SET CMP0048 NEW)

project(libgdf-download NONE)

include(ExternalProject)

ExternalProject_Add(libgdf
    GIT_REPOSITORY    https://github.com/BlazingDB/cudf.git
    GIT_TAG           develop
    SOURCE_SUBDIR     cpp
    SOURCE_DIR        "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/libgdf-src"
    BINARY_DIR        "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/libgdf-build"
    INSTALL_DIR       "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/libgdf-install"
    UPDATE_COMMAND    ""
    CMAKE_ARGS        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                      -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/libgdf-install
)
