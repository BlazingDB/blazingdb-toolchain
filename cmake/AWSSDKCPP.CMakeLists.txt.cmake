#=============================================================================
# Copyright 2018 BlazingDB, Inc.
#     Copyright 2018 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

cmake_minimum_required(VERSION 3.11)

project(aws-sdk-cpp-download NONE)

include(ExternalProject)

ExternalProject_Add(aws-sdk-cpp
    GIT_REPOSITORY  https://github.com/aws/aws-sdk-cpp.git
    GIT_TAG         864eb0bca8b48427f94850b7a8311ef0ae0f433b
    SOURCE_DIR      "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/aws-sdk-cpp-src"
    BINARY_DIR      "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/aws-sdk-cpp-build"
    INSTALL_DIR     "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/aws-sdk-cpp-install"
    UPDATE_COMMAND  ""
    CMAKE_ARGS      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                    -DBUILD_ONLY=${AWS_MODULES_STR}
                    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/aws-sdk-cpp-install
                    ${AWS_SDK_CPP_CMAKE_ARGS}
)
