#=============================================================================
# Copyright 2018 BlazingDB, Inc.
#     Copyright 2018 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# BEGIN macros

#input: AWS_MODULES output: AWS_MODULES_STR
macro(NORMALIZE_AWS_MODULES_FOR_EXTERNALPROJECT_ADD)
    list(LENGTH AWS_MODULES AWS_MODULES_LEN)
    math(EXPR AWS_MODULES_LEN_LESS_1 "${AWS_MODULES_LEN} - 1")

    set(AWS_MODULE_INDEX 0)
    set(AWS_MODULES_STR "")

    while(${AWS_MODULE_INDEX} LESS ${AWS_MODULES_LEN})
        list(GET AWS_MODULES ${AWS_MODULE_INDEX} AWS_MODULE)
        string(APPEND AWS_MODULES_STR ${AWS_MODULE})

        if(NOT ${AWS_MODULE_INDEX} EQUAL ${AWS_MODULES_LEN_LESS_1})
            # NOTE this is necessary since ExternalProject_Add() needs the list expansion
            string(APPEND AWS_MODULES_STR "$<SEMICOLON>")
        endif()

        math(EXPR AWS_MODULE_INDEX "${AWS_MODULE_INDEX} + 1")
    endwhile()
endmacro()

macro(CONFIGURE_AWS_SDK_CPP_EXTERNAL_PROJECT)
    # NOTE percy c.gonzales if you want to pass other RAL CMAKE_CXX_FLAGS into this dependency add it by harcoding
    set(AWS_SDK_CPP_CMAKE_ARGS " -DBUILD_OPENSSL=ON"
                               " -DBUILD_CURL=ON"
                               " -DBUILD_SHARED_LIBS=OFF"
                               " -DENABLE_TESTING=OFF"
                               " -DENABLE_UNITY_BUILD=ON"
                               " -DCUSTOM_MEMORY_MANAGEMENT=0"
                               " -DCPP_STANDARD=${CMAKE_CXX_STANDARD}")

    if(CXX_OLD_ABI)
        # enable old ABI for C/C++
        list(APPEND AWS_SDK_CPP_CMAKE_ARGS " -DCMAKE_C_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0")
        list(APPEND AWS_SDK_CPP_CMAKE_ARGS " -DCMAKE_CXX_FLAGS=-D_GLIBCXX_USE_CXX11_ABI=0")
    endif()

    set(AWS_MODULES
        core
        s3
        s3-encryption
    )

    normalize_aws_modules_for_externalproject_add()

    # Download and unpack aws-sdk-cpp at configure time
    configure_file(${CMAKE_CURRENT_LIST_DIR}/AWSSDKCPP.CMakeLists.txt.cmake ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/aws-sdk-cpp-download/CMakeLists.txt)

    execute_process(
        COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/aws-sdk-cpp-download/
    )

    if(result)
        message(FATAL_ERROR "CMake step for aws-sdk-cpp failed: ${result}")
    endif()

    # Patch OpenSSL build dependency
    file(
        COPY ${CMAKE_SOURCE_DIR}/scripts/aws-sdk-cpp-patch/build_external.cmake
        DESTINATION ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/aws-sdk-cpp-src/cmake/
    )
    message(STATUS "Patch for AWS SDK CPP applied!")

    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -- -j8
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/aws-sdk-cpp-download/
    )

    if(result)
        message(FATAL_ERROR "Build step for aws-sdk-cpp failed: ${result}")
    endif()
endmacro()

macro(ADD_AWS_SDK_INCLUDE_DIR aws_target)
    get_target_property(aws_target_include_dir ${aws_target} INTERFACE_INCLUDE_DIRECTORIES)
    include_directories(${aws_target_include_dir})
endmacro()

macro(CONFIGURE_AWS_SDK)
    # Add the AWS SDK C++ includes: it seems AWS CMake files forgot to add the include_dir for each AWS lib.
    add_aws_sdk_include_dir(aws-cpp-sdk-core)
    add_aws_sdk_include_dir(aws-cpp-sdk-s3)
    add_aws_sdk_include_dir(aws-cpp-sdk-s3-encryption)
    add_aws_sdk_include_dir(aws-cpp-sdk-kms)

    message(STATUS "Using AWS SDK C++ module: AWS Core")
    message(STATUS "Using AWS SDK C++ module: AWS S3")
    message(STATUS "Using AWS SDK C++ module: AWS S3 Encryption")
endmacro()

# END macros

# BEGIN MAIN #

if (AWS_SDK_CPP_BUILD_DIR)
    message(STATUS "AWS_SDK_CPP_BUILD_DIR defined, it will use vendor version from ${AWS_SDK_CPP_BUILD_DIR}")
    set(AWS_SDK_CPP_ROOT "${AWS_SDK_CPP_BUILD_DIR}")
else()
    message(STATUS "AWS_SDK_CPP_BUILD_DIR not defined, it will be built from sources")
    configure_aws_sdk_cpp_external_project()
    set(AWS_SDK_CPP_ROOT "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/aws-sdk-cpp-build/")
endif()

set(aws-sdk-cpp_DIR ${AWS_SDK_CPP_ROOT})

# Locate the AWS SDK for C++ package.
# Requires that you build with:
#   -DAWS_SDK_CPP_BUILD_DIR=/path/to/sdk_build
# or export/set:
#   CMAKE_PREFIX_PATH=/path/to/sdk_build
message(STATUS "aws-sdk-cpp_DIR: " ${aws-sdk-cpp_DIR})
find_package(aws-sdk-cpp REQUIRED COMPONENTS aws-cpp-sdk-core aws-cpp-sdk-s3 aws-cpp-sdk-s3-encryption aws-cpp-sdk-kms)
set_package_properties(aws-sdk-cpp PROPERTIES TYPE REQUIRED
    PURPOSE "AWS SDK for C++ allows to integrate any C++ application with AWS services."
    URL "https://aws.amazon.com/sdk-for-cpp/")

message(STATUS "AWS SDK for C++ found in ${aws-sdk-cpp_DIR}")

configure_aws_sdk()

# END MAIN #
