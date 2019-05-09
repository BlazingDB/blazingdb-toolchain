#=============================================================================
# Copyright 2018 BlazingDB, Inc.
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

# BEGIN macros

macro(CONFIGURE_GDR_EXTERNAL_PROJECT)
    if(CXX_OLD_ABI)
        # NOTE percy c.gonzales if you want to pass other RAL CMAKE_CXX_FLAGS into this dependency add it by harcoding
        set(ENV{CFLAGS} "-D_GLIBCXX_USE_CXX11_ABI=0 -fPIC -O2")
        set(ENV{CXXFLAGS} "-D_GLIBCXX_USE_CXX11_ABI=0 -fPIC -O2")
    else()
        # NOTE percy c.gonzales if you want to pass other RAL CMAKE_CXX_FLAGS into this dependency add it by harcoding
        set(ENV{CFLAGS} "-fPIC -O2")
        set(ENV{CXXFLAGS} "-fPIC -O2")
    endif()

    # Download and unpack GDR at configure time
    configure_file(${CMAKE_CURRENT_LIST_DIR}/GDR.CMakeLists.txt.cmake ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/gdr-download/CMakeLists.txt)

    execute_process(
        COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/gdr-download/
    )

    if(result)
        message(FATAL_ERROR "CMake step for GDR failed: ${result}")
    endif()

    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -- -j8
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/gdr-download/
    )

    if(result)
        message(FATAL_ERROR "Build step for GDR failed: ${result}")
    endif()
endmacro()

# END macros

# BEGIN MAIN #

if (GDR_INSTALL_DIR)
    message(STATUS "GDR_INSTALL_DIR defined, it will use vendor version from ${GDR_INSTALL_DIR}")
    set(GDR_ROOT "${GDR_INSTALL_DIR}")
else()
    message(STATUS "GDR_INSTALL_DIR not defined, it will be built from sources")
    CONFIGURE_GDR_EXTERNAL_PROJECT()
    set(GDR_ROOT "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/gdr-install/")
endif()

set(GDR_HOME ${GDR_ROOT})
find_package(GDR REQUIRED)
set_package_properties(GDR PROPERTIES TYPE REQUIRED
    PURPOSE " GDR."
    URL "http://www.openGDR.org/")

set(GDR_INCLUDEDIR ${GDR_ROOT}/include/)

include_directories(${GDR_INCLUDEDIR} ${GDR_INCLUDE_DIR})
link_directories(${GDR_ROOT}/lib/)

# END MAIN #
