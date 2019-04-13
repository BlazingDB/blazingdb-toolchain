#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# BEGIN macros

macro(CONFIGURE_BLAZINGDB_COMMUNICATION_EXTERNAL_PROJECT)
    set(ENV{BOOST_ROOT} ${BOOST_ROOT})
    set(BOOST_INSTALL_DIR ${BOOST_ROOT})

    if (NOT BLAZINGDB_COMMUNICATION_BRANCH)
        set(BLAZINGDB_COMMUNICATION_BRANCH "develop")
    endif()

    message(STATUS "Using BLAZINGDB_COMMUNICATION_BRANCH: ${BLAZINGDB_COMMUNICATION_BRANCH}")

    # NOTE percy c.gonzales if you want to pass other RAL CMAKE_CXX_FLAGS into this dependency add it by harcoding
    set(BLAZINGDB_COMMUNICATION_CMAKE_ARGS
        " -DGOOGLETEST_INSTALL_DIR=${GOOGLETEST_INSTALL_DIR}"
        " -DARROW_INSTALL_DIR=${ARROW_INSTALL_DIR}"
        " -DAWS_SDK_CPP_BUILD_DIR=${AWS_SDK_CPP_BUILD_DIR}"
        " -DCMAKE_C_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0"
        " -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0"
    )

    # Download and unpack blazingdb-communication at configure time
    configure_file(${CMAKE_CURRENT_LIST_DIR}/BlazingDBCommunication.CMakeLists.txt.cmake ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/blazingdb-communication-download/CMakeLists.txt)

    execute_process(
        COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/blazingdb-communication-download/
    )

    if(result)
        message(FATAL_ERROR "CMake step for blazingdb-communication failed: ${result}")
    endif()

    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -- -j8
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/blazingdb-communication-download/
    )

    if(result)
        message(FATAL_ERROR "Build step for blazingdb-communication failed: ${result}")
    endif()
endmacro()

# END macros

# BEGIN MAIN #

if (BLAZINGDB_COMMUNICATION_INSTALL_DIR)
    message(STATUS "BLAZINGDB_COMMUNICATION_INSTALL_DIR defined, it will use vendor version from ${BLAZINGDB_COMMUNICATION_INSTALL_DIR}")
    set(BLAZINGDB_COMMUNICATION_ROOT "${BLAZINGDB_COMMUNICATION_INSTALL_DIR}")
else()
    message(STATUS "BLAZINGDB_COMMUNICATION_INSTALL_DIR not defined, it will be built from sources")
    configure_blazingdb_communication_external_project()
    set(BLAZINGDB_COMMUNICATION_ROOT "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/blazingdb-communication-install/")
endif()

find_package(BlazingDBCommunication REQUIRED)
set_package_properties(BlazingDBCommunication PROPERTIES TYPE REQUIRED
    PURPOSE "BlazingDBCommunication has the C++ communication definitions for the BlazingSQL."
    URL "https://github.com/BlazingDB/blazingdb-communication")

if(NOT BLAZINGDB_COMMUNICATION_FOUND)
    message(FATAL_ERROR "blazingdb-communication not found, please check your settings.")
endif()

message(STATUS "blazingdb-communication found in ${BLAZINGDB_COMMUNICATION_ROOT}")
include_directories(${BLAZINGDB_COMMUNICATION_INCLUDEDIR})

link_directories(${BLAZINGDB_COMMUNICATION_LIBDIR})

# END MAIN #
