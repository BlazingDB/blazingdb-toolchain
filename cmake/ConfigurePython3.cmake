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

macro(CONFIGURE_PYTHON3_EXTERNAL_PROJECT)
    if(CXX_OLD_ABI)
        # enable old ABI for C/C++
        message(FATAL_ERROR "We need to compile Python3 instead of just download and use the python3 libs and binaries! (TODO percy)")
    endif()

    # Download and unpack Python3 at configure time
    configure_file(${CMAKE_CURRENT_LIST_DIR}/Python3.CMakeLists.txt.cmake ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/python3-download/CMakeLists.txt)

    execute_process(
        COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/python3-download/
    )

    if(result)
        message(FATAL_ERROR "CMake step for Python3 failed: ${result}")
    endif()

    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -- -j8
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/python3-download/
    )

    if(result)
        message(FATAL_ERROR "Build step for Python3 failed: ${result}")
    endif()
endmacro()

# END macros

# BEGIN MAIN #

if (PYTHON3_INSTALL_DIR)
    message(STATUS "PYTHON3_INSTALL_DIR defined, it will use vendor version from ${PYTHON3_INSTALL_DIR}")
    set(PYTHON3_ROOT "${PYTHON3_INSTALL_DIR}")
else()
    message(STATUS "PYTHON3_INSTALL_DIR not defined, it will be built from sources")
    CONFIGURE_PYTHON3_EXTERNAL_PROJECT()
    set(PYTHON3_ROOT "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/python3-install/")
endif()


set(Python3_ROOT_DIR ${PYTHON3_ROOT}/)
#set(Python3_USE_STATIC_LIBS ON) # TODO percy use this option when upgrade to FindPython3

message(STATUS "Python3_ROOT_DIR: ${Python3_ROOT_DIR}")

# TODO percy version as arg
set(Python_ADDITIONAL_VERSIONS "3.6")
set(PYTHON_LIBRARY ${Python3_ROOT_DIR}/lib/libpython3.6m.a)
set(PYTHON_INCLUDE_DIR ${Python3_ROOT_DIR}/include/python3.6m)

find_package(PythonLibs REQUIRED)

message(STATUS "PYTHONLIBS_VERSION_STRING: ${PYTHONLIBS_VERSION_STRING}")

set_package_properties(Python3 PROPERTIES TYPE REQUIRED
    PURPOSE " Python3."
    URL "https://Python. org")

set(PYTHON3_INCLUDEDIR ${PYTHON3_ROOT}/include/)

include_directories(${PYTHON3_INCLUDEDIR} ${PYTHON3_INCLUDE_DIR})
link_directories(${PYTHON3_ROOT}/lib/)

# END MAIN #
