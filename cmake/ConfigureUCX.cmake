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

macro(CONFIGURE_UCX_EXTERNAL_PROJECT)
    if(CXX_OLD_ABI)
        # NOTE percy c.gonzales if you want to pass other RAL CMAKE_CXX_FLAGS into this dependency add it by harcoding
        set(ENV{CFLAGS} "-D_GLIBCXX_USE_CXX11_ABI=0 -fPIC -O2")
        set(ENV{CXXFLAGS} "-D_GLIBCXX_USE_CXX11_ABI=0 -fPIC -O2")
    else()
        # NOTE percy c.gonzales if you want to pass other RAL CMAKE_CXX_FLAGS into this dependency add it by harcoding
        set(ENV{CFLAGS} "-fPIC -O2")
        set(ENV{CXXFLAGS} "-fPIC -O2")
    endif()

    # Download and unpack UCX at configure time
    configure_file(${CMAKE_CURRENT_LIST_DIR}/UCX.CMakeLists.txt.cmake ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/UCX-download/CMakeLists.txt)

    execute_process(
        COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/UCX-download/
    )

    if(result)
        message(FATAL_ERROR "CMake step for UCX failed: ${result}")
    endif()

    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -- -j8
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/UCX-download/
    )

    if(result)
        message(FATAL_ERROR "Build step for UCX failed: ${result}")
    endif()
endmacro()

# END macros

# BEGIN MAIN #

if (UCX_INSTALL_DIR)
    message(STATUS "UCX_INSTALL_DIR defined, it will use vendor version from ${UCX_INSTALL_DIR}")
    set(UCX_ROOT "${UCX_INSTALL_DIR}")
else()
    message(STATUS "UCX_INSTALL_DIR not defined, it will be built from sources")
    CONFIGURE_UCX_EXTERNAL_PROJECT()
    set(UCX_ROOT "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/UCX-install/")
endif()

set(UCX_HOME ${UCX_ROOT})
find_package(UCX REQUIRED)
set_package_properties(UCX PROPERTIES TYPE REQUIRED
    PURPOSE " UCX."
    URL "http://www.openucx.org/")

set(UCX_INCLUDEDIR ${UCX_ROOT}/include/)

include_directories(${UCX_INCLUDEDIR} ${UCX_INCLUDE_DIR})
link_directories(${UCX_ROOT}/lib/)

# END MAIN #
