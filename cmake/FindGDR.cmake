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

if ("${GDR_ROOT}" STREQUAL "")
    set(GDR_ROOT "/usr")
endif()

set(GDR_SEARCH_LIB_PATH
  ${GDR_ROOT}/lib
  ${GDR_ROOT}/lib/x86_64-linux-gnu
  ${GDR_ROOT}/lib64
  ${GDR_ROOT}/build
)

set(GDR_SEARCH_INCLUDE_DIR
  ${GDR_ROOT}/include/
)

find_path(GDR_INCLUDE_DIR gdrapi.h
    PATHS ${GDR_SEARCH_INCLUDE_DIR}
    NO_DEFAULT_PATH
    DOC "Path to rapidjson headers"
)

if (NOT GDR_INCLUDE_DIR)
    message(FATAL_ERROR "gdr includes and libraries NOT found. "
      "Looked for headers in ${GDR_SEARCH_INCLUDE_DIR}")
    set(GDR_FOUND FALSE)
else()
    set(GDR_INCLUDE_DIR ${GDR_ROOT}/include/)
    set(GDR_INCLUDEDIR ${GDR_ROOT}/include/)
    set(GDR_LIBDIR ${GDR_ROOT}/lib) # TODO percy make this part cross platform
    set(GDR_FOUND TRUE)
endif ()

mark_as_advanced(
  GDR_FOUND
  GDR_INCLUDEDIR
  GDR_INCLUDE_DIR
  GDR_STATIC_LIB
)
