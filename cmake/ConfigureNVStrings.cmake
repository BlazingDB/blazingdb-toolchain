#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# BEGIN macros

macro(CONFIGURE_GPU_NVSTRINGS_EXTERNAL_PROJECT)
    set(ENV{CUDACXX} $ENV{CUDACXX})

    set(NVSTRINGS_CMAKE_ARGS
        " -DPYTHON_LIBRARY=${PYTHON_LIBRARY}"
        " -DPYTHON_INCLUDE_DIR=${PYTHON_INCLUDE_DIR}"
    )

    if(CXX_OLD_ABI)
        # enable old ABI for C/C++
        list(APPEND NVSTRINGS_CMAKE_ARGS " -DCMAKE_CXX11_ABI=OFF")
    else()
        list(APPEND NVSTRINGS_CMAKE_ARGS " -DCMAKE_CXX11_ABI=ON")
    endif()

    # Download and unpack nvstrings at configure time
    configure_file(${CMAKE_CURRENT_LIST_DIR}/NVStrings.CMakeLists.txt.cmake ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/nvstrings-download/CMakeLists.txt)

    execute_process(
        COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/nvstrings-download/
    )

    if(result)
        message(FATAL_ERROR "CMake step for nvstrings failed: ${result}")
    endif()

    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -- -j8
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/nvstrings-download/
    )

    if(result)
        message(FATAL_ERROR "Build step for nvstrings failed: ${result}")
    endif()

    execute_process(
        COMMAND bash ${CMAKE_SOURCE_DIR}/scripts/patch_nvstrings.sh ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/nvstrings-install/
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/nvstrings-download/
    )

    if(result)
        message(FATAL_ERROR "Patch step for nvstrings failed: ${result}")
    endif()
endmacro()

# END macros

# BEGIN MAIN #

if (NVSTRINGS_INSTALL_DIR)
    if (NOT NVSTRINGS_INSTALL_DIR)
        message(FATAL_ERROR "If you use the NVSTRINGS_INSTALL_DIR argument then you need pass the NVSTRINGS_INSTALL_DIR argument too (the home installation of nvstrings)")
    endif()

    message(STATUS "NVSTRINGS_INSTALL_DIR defined, it will use vendor version from ${NVSTRINGS_INSTALL_DIR}")
    set(NVSTRINGS_ROOT "${NVSTRINGS_INSTALL_DIR}")
else()
    message(STATUS "NVSTRINGS_INSTALL_DIR not defined, it will be built from sources")
    configure_gpu_nvstrings_external_project()
    set(NVSTRINGS_ROOT "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/nvstrings-install/")
endif()

find_package(NVStrings REQUIRED)
set_package_properties(NVStrings PROPERTIES TYPE REQUIRED
    PURPOSE "nvstrings is a C library for implementing common functionality for a GPU Data Frame."
    URL "https://github.com/gpuopenanalytics/nvstrings")

if(NOT NVSTRINGS_FOUND)
    message(FATAL_ERROR "nvstrings not found, please check your settings.")
endif()

message(STATUS "nvstrings found in ${NVSTRINGS_ROOT}")

set(NVSTRINGS_LIBDIR ${NVSTRINGS_ROOT}/lib/)
link_directories(${NVSTRINGS_LIBDIR})

include_directories(${NVSTRINGS_INCLUDEDIR} ${NVSTRINGS_INCLUDE_DIR})
# TODO percy seems cmake bug: we cannot define target dirs per cuda target
# ... see if works in future cmake versions
link_directories(${NVSTRINGS_LIBDIR})

# END MAIN #
