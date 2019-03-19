# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# - Find JITIFY (jitify.h, libjitify.a, libjitify.so, and libjitify.so.0)
# This module defines
#  JITIFY_INCLUDE_DIR, directory containing headers
#  JITIFY_SHARED_LIB, path to libjitify shared library
#  JITIFY_STATIC_LIB, path to libjitify static library
#  JITIFY_FOUND, whether jitify has been found

if( NOT "${JITIFY_HOME}" STREQUAL "")
    file( TO_CMAKE_PATH "${JITIFY_HOME}" _native_path )
    list( APPEND _jitify_roots ${_native_path} )
elseif ( JITIFY_HOME )
    list( APPEND _jitify_roots ${JITIFY_HOME} )
endif()

find_path(JITIFY_INCLUDE_DIR NAMES jitify.hpp
  PATHS ${_jitify_roots}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include" )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(JITIFY REQUIRED_VARS JITIFY_INCLUDE_DIR)
