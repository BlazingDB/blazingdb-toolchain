#=============================================================================
# Copyright 2018 BlazingDB, Inc.
#     Copyright 2018 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

cmake_minimum_required(VERSION 2.8.12)

cmake_policy(SET CMP0048 NEW)

project(rmm-download NONE)

include(ExternalProject)

ExternalProject_Add(rmm
    GIT_REPOSITORY    ${RMM_GIT_REPOSITORY}
    GIT_TAG           ${RMM_GIT_REPOSITORY}
    SOURCE_DIR        "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rmm-src"
    BINARY_DIR        "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rmm-build"
    INSTALL_DIR       "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rmm-install"
    UPDATE_COMMAND    ""
    CMAKE_ARGS        -DCMAKE_BUILD_TYPE=${RMM_BUILD_TYPE}
                      -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rmm-install
                      ${RMM_CMAKE_ARGS}
)
