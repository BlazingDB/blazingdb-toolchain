#=============================================================================
# Copyright 2018 BlazingDB, Inc.
#     Copyright 2018 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

cmake_minimum_required(VERSION 2.8.12)

cmake_policy(SET CMP0048 NEW)

project(blazingdb-io-download NONE)

include(ExternalProject)

ExternalProject_Add(blazingdb-io
    GIT_REPOSITORY  git@github.com:BlazingDB/blazingdb-io.git
    GIT_TAG         develop
    SOURCE_DIR      "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/blazingdb-io-src"
    BINARY_DIR      "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/blazingdb-io-build"
    INSTALL_DIR     "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/blazingdb-io-install"
    CMAKE_ARGS      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/blazingdb-io-install
                    ${BLAZINGDB_IO_CMAKE_ARGS}
)
