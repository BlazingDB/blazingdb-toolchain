#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Tries to find Brotli headers and libraries.
#
# Usage of this module as follows:
#
#  find_package(Brotli)
#
# Variables used by this module, they can change the default behaviour and need
# to be set before calling find_package:
#
#  BROTLI_HOME - When set, this path is inspected instead of standard library
#                locations as the root of the Brotli installation.
#                The environment variable BROTLI_HOME overrides this veriable.
#
# This module defines
#  BROTLI_INCLUDE_DIR, directory containing headers
#  BROTLI_LIBS, directory containing brotli libraries
#  BROTLI_STATIC_LIB, path to libbrotli.a
#  BROTLI_SHARED_LIB, path to libbrotli's shared library
#  BROTLI_FOUND, whether brotli has been found

if ("${UCX_ROOT}" STREQUAL "")
    set(UCX_ROOT "/usr")
endif()

set(UCX_SEARCH_LIB_PATH
  ${UCX_ROOT}/lib
  ${UCX_ROOT}/lib/x86_64-linux-gnu
  ${UCX_ROOT}/lib64
  ${UCX_ROOT}/build
)

set(UCX_SEARCH_INCLUDE_DIR
  ${UCX_ROOT}/include/ucp/api/
)

find_path(UCX_INCLUDE_DIR ucp.h
    PATHS ${UCX_SEARCH_INCLUDE_DIR}
    NO_DEFAULT_PATH
    DOC "Path to rapidjson headers"
)

if (NOT UCX_INCLUDE_DIR)
    message(FATAL_ERROR "ucx includes and libraries NOT found. "
      "Looked for headers in ${UCX_SEARCH_INCLUDE_DIR}")
    set(UCX_FOUND FALSE)
else()
    set(UCX_INCLUDE_DIR ${UCX_ROOT}/include/)
    set(UCX_INCLUDEDIR ${UCX_ROOT}/include/)
    set(UCX_LIBDIR ${UCX_ROOT}/lib) # TODO percy make this part cross platform
    set(UCX_FOUND TRUE)
endif ()

mark_as_advanced(
  UCX_FOUND
  UCX_INCLUDEDIR
  UCX_INCLUDE_DIR
  UCX_STATIC_LIB
)
