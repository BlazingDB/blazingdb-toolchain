#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

cmake_minimum_required(VERSION 3.12 FATAL_ERROR)

project(blazingdb-dependencies C CXX)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/" ${CMAKE_MODULE_PATH})
message(STATUS "CMAKE_MODULE_PATH:" "${CMAKE_MODULE_PATH}")

# Parse the components version and download URLs
include(DefineVersions)

# Include CMake modules
include(FeatureSummary)
include(CheckIncludeFiles)
include(CheckLibraryExists)
include(CTest)

message(STATUS "BUILD_TARGET is ${BUILD_TARGET}")

if (BUILD_TARGET)
    if (BUILD_TARGET STREQUAL "gcp-cpp")
        include(ConfigureGoogleCloudCPP)
    elseif (BUILD_TARGET STREQUAL "aws-cpp")
        include(ConfigureAWSSDK)
    else()
        message(FATAL_ERROR "Error: Invalid value for BUILD_TARGET (${BUILD_TARGET}) You need to pass -DBUILD_TARGET=gcp-cpp or -DBUILD_TARGET=aws-cpp")
    endif()
else()
    message(FATAL_ERROR "Error: You need to pass -DBUILD_TARGET=gcp-cpp or -DBUILD_TARGET=aws-cpp")
endif()

# BEGIN MAIN #
# NOTE use USE_SOURCE_PERMISSIONS to preserve executable file permisions (e.g. flatc, etc)
install(DIRECTORY ${AWS_SDK_CPP_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)
install(DIRECTORY ${GOOGLE_CLOUD_CPP_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)

# Install the cmake modules to be used by the users/projects
install(DIRECTORY ${CMAKE_SOURCE_DIR}/cmake/ DESTINATION lib/cmake)

# Print the project summary
feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)

# END MAIN #
