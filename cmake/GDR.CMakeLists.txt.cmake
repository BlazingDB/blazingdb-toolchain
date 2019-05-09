#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2018 Alexander Ocsa <alexander@blazingdb.com>
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

project(gdr-download NONE)

include(ExternalProject)

ExternalProject_Add(gdr
    GIT_REPOSITORY    ${GDR_GIT_REPOSITORY}
    GIT_TAG           ${GDR_GIT_TAG}
    SOURCE_DIR        "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/gdr-src"
    BUILD_IN_SOURCE   1
    INSTALL_DIR       "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/gdr-install"
    CONFIGURE_COMMAND ""
    BUILD_COMMAND     ${CMAKE_MAKE_PROGRAM} PREFIX=${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/gdr-install CUDA=/usr/local/cuda/ all install 
    UPDATE_COMMAND    ""
)
