#=============================================================================
# Copyright 2018 BlazingDB, Inc.
#     Copyright 2018-2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# BEGIN macros

macro(CONFIGURE_SPDLOG_EXTERNAL_PROJECT)
    message("configuring external project")
    # NOTE percy c.gonzales if you want to pass other RAL CMAKE_CXX_FLAGS into this dependency add it by harcoding
    set(SPDLOG_CMAKE_ARGS " -DSPDLOG_BUILD_SHARED=ON -DSPDLOG_BUILD_TESTS=OFF -DSPDLOG_BUILD_TESTS_HO=OFF")

    if(CXX_OLD_ABI)
        # enable old ABI for C/C++
        list(APPEND SPDLOG_CMAKE_ARGS " -DCMAKE_C_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0")
        list(APPEND SPDLOG_CMAKE_ARGS " -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0")
    endif()

    # Download and unpack spdlog at configure time
    configure_file(${CMAKE_CURRENT_LIST_DIR}/spdlog.CMakeLists.txt.cmake ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/spdlog-download/CMakeLists.txt)

    execute_process(
        COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/spdlog-download/
    )

    if(result)
        message(FATAL_ERROR "CMake step for spdlog failed: ${result}")
    endif()

    # Patch main aws cmake
    file(
        COPY ${CMAKE_SOURCE_DIR}/patches/spdlog-patch/include_splog_fmt_bundled/core.h
        DESTINATION ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/spdlog-src/include/splog/fmt/bundled/
    )

    message(STATUS "==== Patch for spdlog applied! ====")

    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -- -j8
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/spdlog-download/
    )

    if(result)
        message(FATAL_ERROR "Build step for spdlog failed: ${result}")
    endif()
endmacro()

macro(ADD_AWS_SDK_INCLUDE_DIR aws_target)
    get_target_property(aws_target_include_dir ${aws_target} INTERFACE_INCLUDE_DIRECTORIES)
    include_directories(${aws_target_include_dir})
endmacro()

# END macros

# BEGIN MAIN #

if (SPDLOG_INSTALL_DIR)
    message(STATUS "SPDLOG_INSTALL_DIR defined, it will use vendor version from ${SPDLOG_INSTALL_DIR}")
    set(SPDLOG_ROOT "${SPDLOG_INSTALL_DIR}")
else()
    message(STATUS "SPDLOG_INSTALL_DIR not defined, it will be built from sources")
    configure_spdlog_external_project()
    set(SPDLOG_ROOT "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/spdlog-install/")
endif()

# NOTE for the find packages
list(APPEND CMAKE_PREFIX_PATH ${SPDLOG_ROOT})

set(spdlog_DIR ${SPDLOG_ROOT})

# Locate the AWS SDK for C++ package.
# Requires that you build with:
#   -DSPDLOG_BUILD_DIR=/path/to/sdk_build
# or export/set:
#   CMAKE_PREFIX_PATH=/path/to/sdk_build
message(STATUS "spdlog_DIR: " ${spdlog_DIR})

find_package(spdlog REQUIRED)

set_package_properties(spdlog PROPERTIES TYPE REQUIRED
    PURPOSE "AWS SDK for C++ allows to integrate any C++ application with AWS services. Module: aws-cpp-sdk-core"
    URL "https://aws.amazon.com/sdk-for-cpp/")

message(STATUS "spdlog ${SPDLOG_ROOT}")

# END MAIN #
