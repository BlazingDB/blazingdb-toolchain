#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

cmake_minimum_required(VERSION 3.12 FATAL_ERROR)

project(blazingdb-dependencies C CXX CUDA)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/" ${CMAKE_MODULE_PATH})
message(STATUS "CMAKE_MODULE_PATH:" "${CMAKE_MODULE_PATH}")

# NOTE First step
include(ConfigureBlazingDBHostCompiler)

# Include CMake modules
include(FeatureSummary)
include(CheckIncludeFiles)
include(CheckLibraryExists)
include(CTest)

# Configure CUDA
include(ConfigureCUDA)

# NOTE Do not change the inclusion order
# Configure dependencies
include(ConfigureGoogleTest) # NOTE for unit tests
include(ConfigureGoogleBenchmark) # NOTE for performance tests
include(ConfigureBoost)
include(ConfigureRapidJSON) # TODO remove when we use binary protocol with ucx
include(ConfigureSimpleWebServer) # TODO remove when we use binary protocol with ucx
include(ConfigureAWSSDK)
include(ConfigureFlatBuffers)
include(ConfigureLz4)
include(ConfigureZSTD)
include(ConfigureBrotli)
include(ConfigureSnappy)
include(ConfigureThrift)
include(ConfigureArrow)
include(ConfigureParquet)
include(ConfigureNVStrings) # NOTE cudf related
include(ConfigureJitify) # NOTE cudf related

#find_package(Threads)

# BEGIN MAIN #

# NOTE use USE_SOURCE_PERMISSIONS to preserve executable file permisions (e.g. flatc, etc)
install(DIRECTORY ${GTEST_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)
install(DIRECTORY ${GBENCHMARK_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)
install(DIRECTORY ${BOOST_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)
install(DIRECTORY ${RAPIDJSON_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS) # TODO remove when we use binary protocol with ucx
install(DIRECTORY ${SIMPLEWEBSERVER_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS) # TODO remove when we use binary protocol with ucx
install(DIRECTORY ${AWS_SDK_CPP_ROOT} DESTINATION build/aws-sdk-cpp USE_SOURCE_PERMISSIONS)
install(DIRECTORY ${FLATBUFFERS_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)
install(DIRECTORY ${LZ4_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)
install(DIRECTORY ${ZSTD_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)
install(DIRECTORY ${BROTLI_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)
install(DIRECTORY ${SNAPPY_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)
install(DIRECTORY ${THRIFT_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)
install(DIRECTORY ${ARROW_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS)
install(DIRECTORY ${NVSTRINGS_ROOT} DESTINATION . USE_SOURCE_PERMISSIONS) # NOTE cudf related
install(FILES ${JITIFY_ROOT}/jitify.hpp DESTINATION include) # NOTE cudf related

# Install the cmake modules to be used by the users/projects
install(DIRECTORY ${CMAKE_SOURCE_DIR}/cmake/ DESTINATION lib/cmake)

#unnecessary becouse arrow installation step was already performed
#install(DIRECTORY ${PARQUET_ROOT} DESTINATION .)

# Print the project summary
feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)

#END MAIN #
