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

# BEGIN MAIN #

set(GOOGLETEST_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR}) # NOTE for unit tests
set(GOOGLEBENCHMARK_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR}) # NOTE for performance tests
set(BOOST_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR})
set(RAPIDJSON_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR}) # TODO remove when we use binary protocol with ucx
set(SIMPLEWEBSERVER_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR}) # TODO remove when we use binary protocol with ucx
set(AWS_SDK_CPP_BUILD_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR}/build/aws-sdk-cpp)
set(FLATBUFFERS_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR})
set(LZ4_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR})
set(ZSTD_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR})
set(BROTLI_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR})
set(SNAPPY_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR})
set(THRIFT_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR})
set(ARROW_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR})
set(NVSTRINGS_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR}) # NOTE cudf related
set(JITIFY_INSTALL_DIR ${BLAZINGDB_DEPENDENCIES_INSTALL_DIR}) # NOTE cudf related

message(STATUS "GOOGLETEST_INSTALL_DIR: ${GOOGLETEST_INSTALL_DIR}") # NOTE for unit tests
message(STATUS "GOOGLEBENCHMARK_INSTALL_DIR: ${GOOGLEBENCHMARK_INSTALL_DIR}") # NOTE for performance tests
message(STATUS "BOOST_INSTALL_DIR: ${BOOST_INSTALL_DIR}")
message(STATUS "RAPIDJSON_INSTALL_DIR: ${RAPIDJSON_INSTALL_DIR}") # TODO remove when we use binary protocol with ucx
message(STATUS "SIMPLEWEBSERVER_INSTALL_DIR: ${SIMPLEWEBSERVER_INSTALL_DIR}") # TODO remove when we use binary protocol with ucx
message(STATUS "AWS_SDK_CPP_BUILD_DIR: ${AWS_SDK_CPP_BUILD_DIR}")
message(STATUS "FLATBUFFERS_INSTALL_DIR: ${FLATBUFFERS_INSTALL_DIR}")
message(STATUS "LZ4_INSTALL_DIR: ${LZ4_INSTALL_DIR}")
message(STATUS "ZSTD_INSTALL_DIR: ${ZSTD_INSTALL_DIR}")
message(STATUS "BROTLI_INSTALL_DIR: ${BROTLI_INSTALL_DIR}")
message(STATUS "SNAPPY_INSTALL_DIR: ${SNAPPY_INSTALL_DIR}")
message(STATUS "THRIFT_INSTALL_DIR: ${THRIFT_INSTALL_DIR}")
message(STATUS "ARROW_INSTALL_DIR: ${ARROW_INSTALL_DIR}")
message(STATUS "NVSTRINGS_INSTALL_DIR: ${NVSTRINGS_INSTALL_DIR}") # NOTE cudf related
message(STATUS "JITIFY_INSTALL_DIR: ${JITIFY_INSTALL_DIR}") # NOTE cudf related

# END MAIN #
