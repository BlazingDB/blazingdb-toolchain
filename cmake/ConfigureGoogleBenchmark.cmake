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

# BEGIN macros

# NOTE percy c.gonzales if you want to pass other RAL CMAKE_CXX_FLAGS into this dependency add it by harcoding
set(GOOGLEBENCHMARK_CMAKE_ARGS
    " -DCMAKE_BUILD_TYPE=RELEASE" 
    " -DBENCHMARK_ENABLE_GTEST_TESTS=OFF"
    " -DCMAKE_C_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0"      # enable old ABI for C/C++
    " -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0")   # enable old ABI for C/C++

macro(CONFIGURE_GOOGLEBENCHMARK_EXTERNAL_PROJECT)
    # Download and unpack googlebenchmark at configure time
    configure_file(${CMAKE_CURRENT_LIST_DIR}/GoogleBenchmark.CMakeLists.txt.cmake
                   ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/googlebenchmark-download/CMakeLists.txt)

    execute_process(
        COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/googlebenchmark-download/
    )

    if(result)
        message(FATAL_ERROR "CMake step for googlebenchmark failed: ${result}")
    endif()

    execute_process(
        COMMAND ${CMAKE_COMMAND} --build .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/googlebenchmark-download/
    )

    if(result)
        message(FATAL_ERROR "Build step for googlebenchmark failed: ${result}")
    endif()
endmacro()

# END macros

# BEGIN MAIN #

if (GOOGLEBENCHMARK_INSTALL_DIR)
    message(STATUS "GOOGLEBENCHMARK_INSTALL_DIR defined, it will use vendor version from ${GOOGLEBENCHMARK_INSTALL_DIR}")
    set(GBENCHMARK_ROOT "${GOOGLEBENCHMARK_INSTALL_DIR}")
else()
    message(STATUS "GOOGLEBENCHMARK_INSTALL_DIR not defined, it will be built from sources")
    configure_googlebenchmark_external_project()
    set(GBENCHMARK_ROOT "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/googlebenchmark-install/")
endif()

message(STATUS "GBENCHMARK_ROOT: " ${GBENCHMARK_ROOT})

find_package(GBenchmark QUIET)
set_package_properties(GBenchmark PROPERTIES TYPE OPTIONAL
    PURPOSE "Google C++ Benchmarking Framework (Google Benchmark)."
    URL "https://github.com/google/benchmark.git")

set(GBENCHMARK_INCLUDE_DIR "${GBENCHMARK_ROOT}/include")
set(GBENCHMARK_LIBRARY_DIR "${GBENCHMARK_ROOT}/lib")

if(GBENCHMARK_ROOT)
    message(STATUS "Google C++ Benchmarking Framework (Google Benchmark) found in ${GBENCHMARK_ROOT}")
    set(GBENCHMARK_FOUND TRUE)
else()
    message(AUTHOR_WARNING "Google C++ Benchmarking Framework (Google Benchmark) not found")
endif()

# END MAIN #