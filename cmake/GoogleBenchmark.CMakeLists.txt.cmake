#=============================================================================
# Copyright 2018 BlazingDB, Inc.
#     Copyright 2018 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#=============================================================================
cmake_minimum_required(VERSION 3.12)

project(googlebenchmark-download NONE)

include(ExternalProject)

ExternalProject_Add(googlebenchmark
    GIT_REPOSITORY    ${GOOGLEBENCHMARK_GIT_REPOSITORY}
    GIT_TAG           ${GOOGLEBENCHMARK_GIT_TAG}
    SOURCE_DIR        "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/googlebenchmark-src"
    BINARY_DIR        "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/googlebenchmark-build"
    INSTALL_DIR       "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/googlebenchmark-install"
    CMAKE_ARGS        -DCMAKE_BUILD_TYPE=${GOOGLEBENCHMARK_BUILD_TYPE}
                      -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/googlebenchmark-install
                      ${GOOGLEBENCHMARK_CMAKE_ARGS}
)
