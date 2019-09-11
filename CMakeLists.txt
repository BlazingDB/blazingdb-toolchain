#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

cmake_minimum_required(VERSION 3.12 FATAL_ERROR)

project(blazingdb-dependencies C CXX)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/" ${CMAKE_MODULE_PATH})
message(STATUS "CMAKE_MODULE_PATH:" "${CMAKE_MODULE_PATH}")

# Parse the COMPONENT_VERSION and the component download URLs
include(DefineVersions)

# NOTE First step
include(ConfigureBlazingDBHostCompiler)

# Include CMake modules
include(FeatureSummary)
include(CheckIncludeFiles)
include(CheckLibraryExists)
include(CTest)

# NOTE Do not change the inclusion order
# Configure dependencies
include(ConfigureAWSSDK)

# BEGIN MAIN #
# NOTE use USE_SOURCE_PERMISSIONS to preserve executable file permisions (e.g. flatc, etc)
install(DIRECTORY ${AWS_SDK_CPP_ROOT} DESTINATION build/aws-sdk-cpp USE_SOURCE_PERMISSIONS)
#install(DIRECTORY ${ARROW_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)

# Install the cmake modules to be used by the users/projects
install(DIRECTORY ${CMAKE_SOURCE_DIR}/cmake/ DESTINATION lib/cmake)

# Print the project summary
feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)

# END MAIN #
