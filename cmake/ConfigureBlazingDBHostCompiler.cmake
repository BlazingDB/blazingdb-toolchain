#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# BEGIN macros

# example:
# configure_blazingdb_host_compiler(14, ON) for C++14 and force the standard is required
macro(CONFIGURE_BLAZINGDB_HOST_COMPILER HOST_CXX_STANDARD HOST_CXX_STANDARD_REQUIRED)
    set(CMAKE_CXX_STANDARD ${HOST_CXX_STANDARD})
    set(CMAKE_CXX_STANDARD_REQUIRED ${HOST_CXX_STANDARD_REQUIRED})
    option(CXX_OLD_ABI "Use the old GLIBCXX11 ABI" ON)

    message(STATUS "Using C++ standard: c++${CMAKE_CXX_STANDARD}")
    message(STATUS "C++ standard required: ${CMAKE_CXX_STANDARD_REQUIRED}")
    message(STATUS "Using C++ old ABI: ${CXX_OLD_ABI}")

    if(CMAKE_COMPILER_IS_GNUCXX)
        if(CXX_OLD_ABI)
            message(AUTHOR_WARNING "Using old C++ GLIBCXX11 ABI -D_GLIBCXX_USE_CXX11_ABI=0")
            set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D_GLIBCXX_USE_CXX11_ABI=0")
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_GLIBCXX_USE_CXX11_ABI=0")
        else()
            message(STATUS "Using modern/current C++ GLIBCXX11 ABI")
        endif()
    endif()
endmacro()

# END macros

# BEGIN MAIN #

configure_blazingdb_host_compiler(14 ON)

# END MAIN #
