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

# BEGIN macros

macro(CONFIGURE_JITIFY_EXTERNAL_PROJECT)
    if(CXX_OLD_ABI)
        # NOTE percy c.gonzales if you want to pass other RAL CMAKE_CXX_FLAGS into this dependency add it by harcoding
        set(ENV{CFLAGS} "-D_GLIBCXX_USE_CXX11_ABI=0 -O3 -fPIC")
        set(ENV{CXXFLAGS} "-D_GLIBCXX_USE_CXX11_ABI=0 -O3 -fPIC")
        set(ENV{PREFIX} "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/jitify-install")
    endif()

    # Download and unpack Jitify at configure time
    configure_file(${CMAKE_CURRENT_LIST_DIR}/Jitify.CMakeLists.txt.cmake ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/jitify-download/CMakeLists.txt)

    execute_process(
        COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/jitify-download/
    )

    if(result)
        message(FATAL_ERROR "CMake step for Jitify failed: ${result}")
    endif()

    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -- -j8
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/jitify-download/
    )

    if(result)
        message(FATAL_ERROR "Build step for Jitify failed: ${result}")
    endif()
endmacro()

# END macros

# BEGIN MAIN #

if (JITIFY_INSTALL_DIR)
    message(STATUS "JITIFY_INSTALL_DIR defined, it will use vendor version from ${JITIFY_INSTALL_DIR}")
    set(JITIFY_ROOT "${JITIFY_INSTALL_DIR}")
else()
    message(STATUS "JITIFY_INSTALL_DIR not defined, it will be built from sources")
    CONFIGURE_JITIFY_EXTERNAL_PROJECT()
    set(JITIFY_ROOT "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/jitify-src/")
endif()

set(JITIFY_HOME ${JITIFY_ROOT})
find_package(Jitify REQUIRED)
set_package_properties(Jitify PROPERTIES TYPE REQUIRED
    PURPOSE "Apache Jitify."
    URL "https://Jitify.apache.org")

set(JITIFY_INCLUDEDIR ${JITIFY_ROOT}/include/)

include_directories(${JITIFY_INCLUDEDIR} ${JITIFY_INCLUDE_DIR})
link_directories(${JITIFY_ROOT}/lib/)

# END MAIN #
