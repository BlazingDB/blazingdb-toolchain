#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# BEGIN macros

macro(CONFIGURE_GOOGLE_CLOUD_CPP_EXTERNAL_PROJECT)
    execute_process(
        COMMAND bash ${CMAKE_SOURCE_DIR}/scripts/build-google-cloud-cpp.sh "${CMAKE_SOURCE_DIR}"
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )

    if(result)
        message(FATAL_ERROR "CMake step for build google-cloud-cpp failed: ${result}")
    endif()
endmacro()

# END macros

# BEGIN MAIN #

if (GOOGLE_CLOUD_CPP_INSTALL_DIR)
    message(STATUS "GOOGLE_CLOUD_CPP_INSTALL_DIR defined, it will use vendor version from ${GOOGLE_CLOUD_CPP_INSTALL_DIR}")
    set(GOOGLE_CLOUD_CPP_ROOT "${GOOGLE_CLOUD_CPP_BUILD_DIR}")
else()
    message(STATUS "GOOGLE_CLOUD_CPP_INSTALL_DIR not defined, it will be built from sources")
    configure_google_cloud_cpp_external_project()
    set(GOOGLE_CLOUD_CPP_ROOT "${CMAKE_SOURCE_DIR}/build/gcs/install/")
endif()

list(APPEND CMAKE_PREFIX_PATH "${GOOGLE_CLOUD_CPP_ROOT}")

find_package(storage_client REQUIRED)

set_package_properties(storage_client PROPERTIES TYPE REQUIRED
    PURPOSE "Google Cloud Client Library for C++ "
    URL "https://github.com/googleapis/google-cloud-cpp")

# END MAIN #
