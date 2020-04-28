#=============================================================================
# Copyright 2020 BlazingDB, Inc.
#     Copyright 2020 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

cmake_minimum_required(VERSION 3.11)

project(spdlog-download NONE)

include(ExternalProject)

ExternalProject_Add(spdlog
    GIT_REPOSITORY  ${SPDLOG_GIT_REPOSITORY}
    GIT_TAG         ${SPDLOG_GIT_TAG}
    SOURCE_DIR      "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/spdlog-src"
    BINARY_DIR      "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/spdlog-build"
    INSTALL_DIR     "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/spdlog-install"
    UPDATE_COMMAND  ""
    GIT_SHALLOW     1
    CMAKE_ARGS      -DCMAKE_BUILD_TYPE=${SPDLOG_BUILD_TYPE}
                    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/spdlog-install
                    ${SPDLOG_CMAKE_ARGS}
)
