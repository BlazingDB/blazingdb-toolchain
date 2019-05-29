#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# BEGIN macros

macro(CONFIGURE_GPU_RMM_EXTERNAL_PROJECT)
    set(ENV{CUDACXX} $ENV{CUDACXX})

    set(RMM_CMAKE_ARGS
    )

    if(CXX_OLD_ABI)
        # enable old ABI for C/C++
        list(APPEND RMM_CMAKE_ARGS " -DCMAKE_CXX11_ABI=OFF")
    else()
        list(APPEND RMM_CMAKE_ARGS " -DCMAKE_CXX11_ABI=ON")
    endif()

    # Download and unpack rmm at configure time
    configure_file(${CMAKE_CURRENT_LIST_DIR}/RMM.CMakeLists.txt.cmake ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rmm-download/CMakeLists.txt)

    execute_process(
        COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rmm-download/
    )

    if(result)
        message(FATAL_ERROR "CMake step for rmm failed: ${result}")
    endif()

    execute_process(
        COMMAND ${CMAKE_COMMAND} --build . -- -j8
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rmm-download/
    )

    if(result)
        message(FATAL_ERROR "Build step for rmm failed: ${result}")
    endif()

    execute_process(
        COMMAND bash ${CMAKE_SOURCE_DIR}/scripts/patch_rmm.sh ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rmm-install/
        RESULT_VARIABLE result
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rmm-download/
    )

    if(result)
        message(FATAL_ERROR "Patch step for rmm failed: ${result}")
    endif()
endmacro()

# END macros

# BEGIN MAIN #

if (RMM_INSTALL_DIR)
    if (NOT RMM_INSTALL_DIR)
        message(FATAL_ERROR "If you use the RMM_INSTALL_DIR argument then you need pass the RMM_INSTALL_DIR argument too (the home installation of rmm)")
    endif()

    message(STATUS "RMM_INSTALL_DIR defined, it will use vendor version from ${RMM_INSTALL_DIR}")
    set(RMM_ROOT "${RMM_INSTALL_DIR}")
else()
    message(STATUS "RMM_INSTALL_DIR not defined, it will be built from sources")
    configure_gpu_rmm_external_project()
    set(RMM_ROOT "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/rmm-install/")
endif()

find_package(RMM REQUIRED)
set_package_properties(RMM PROPERTIES TYPE REQUIRED
    PURPOSE "rmm is a C library for implementing common functionality for a GPU Data Frame."
    URL "https://github.com/gpuopenanalytics/rmm")

if(NOT RMM_FOUND)
    message(FATAL_ERROR "rmm not found, please check your settings.")
endif()

message(STATUS "rmm found in ${RMM_ROOT}")

set(RMM_LIBDIR ${RMM_ROOT}/lib/)
link_directories(${RMM_LIBDIR})

include_directories(${RMM_INCLUDEDIR} ${RMM_INCLUDE_DIR})
# TODO percy seems cmake bug: we cannot define target dirs per cuda target
# ... see if works in future cmake versions
link_directories(${RMM_LIBDIR})

# END MAIN #
