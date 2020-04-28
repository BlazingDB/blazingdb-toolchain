#=============================================================================
# Copyright 2020 BlazingDB, Inc.
#     Copyright 2020 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# BEGIN macros

macro(CONFIGURE_SPDLOG_EXTERNAL_PROJECT)
    execute_process(
        COMMAND bash ${CMAKE_SOURCE_DIR}/scripts/build-spdlog.sh "${CMAKE_SOURCE_DIR}"
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )

    if(result)
        message(FATAL_ERROR "CMake step for build spdlog failed: ${result}")
    endif()
endmacro()

# END macros

# BEGIN MAIN #

if (SPDLOG_INSTALL_DIR)
    message(STATUS "SPDLOG_INSTALL_DIR defined, it will use vendor version from ${SPDLOG_INSTALL_DIR}")
    set(SPDLOG_ROOT "${SPDLOG_BUILD_DIR}")
else()
    message(STATUS "SPDLOG_INSTALL_DIR not defined, it will be built from sources")
    configure_spdlog_external_project()
    set(SPDLOG_ROOT "${CMAKE_SOURCE_DIR}/build/spdlog/install/")
endif()

list(APPEND CMAKE_PREFIX_PATH "${SPDLOG_ROOT}")

find_package(spdlog REQUIRED)

set_package_properties(spdlog PROPERTIES TYPE REQUIRED
    PURPOSE "Very fast, header-only/compiled, C++ logging library."
    URL "https://github.com/gabime/spdlog")

message(STATUS "spdlog ${SPDLOG_ROOT}")

# END MAIN #
