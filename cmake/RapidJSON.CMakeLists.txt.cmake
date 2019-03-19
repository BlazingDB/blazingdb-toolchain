#=============================================================================
# Copyright 2018 BlazingDB, Inc.
#     Copyright 2018 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

cmake_minimum_required(VERSION 2.8.12)

cmake_policy(SET CMP0048 NEW)

project(rapidjson-download NONE)

include(ExternalProject)

# NOTE the commit f54b0e47a08782a6131cc3d60f94d038fa6e0a51 is the stable release v1.1.0
ExternalProject_Add(rapidjson
    GIT_REPOSITORY  https://github.com/Tencent/rapidjson.git
    GIT_TAG         f54b0e47a08782a6131cc3d60f94d038fa6e0a51
    SOURCE_DIR      "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rapidjson-src"
    BINARY_DIR      "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rapidjson-build"
    INSTALL_DIR     "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rapidjson-install"
    UPDATE_COMMAND  ""
    CMAKE_ARGS      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rapidjson-install
                    ${RAPIDJSON_CMAKE_ARGS}
)
