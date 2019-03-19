#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
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

project(jitify-download NONE)

include(ExternalProject)

ExternalProject_Add(jitify
    GIT_REPOSITORY    https://github.com/NVIDIA/jitify.git
    GIT_TAG           ebcaeee01f4156e846cef553f38ca8dd02deae2b
    SOURCE_DIR        "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/jitify-src"
    CONFIGURE_COMMAND ""
    BUILD_COMMAND     ""
    UPDATE_COMMAND    ""
    INSTALL_COMMAND   ""
)
