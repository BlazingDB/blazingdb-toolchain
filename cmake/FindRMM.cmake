#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# - Find GPU Open Analytics Initiative (GoAi) librmm (librmm.a)
# RMM_ROOT hints the location
#
# This module defines
# RMM_FOUND
# RMM_INCLUDEDIR Preferred include directory e.g. <prefix>/include
# RMM_INCLUDE_DIR, directory containing librmm headers
# RMM_LIBS, librmm libraries
# RMM_LIBDIR, directory containing librmm libraries
# RMM_STATIC_LIB, path to librmm.a
# rmm - static library
#TODO percy find librmm.so/.a ...

# If RMM_ROOT is not defined try to search in the default system path
if ("${RMM_ROOT}" STREQUAL "")
    set(RMM_ROOT "/usr")
endif()

set(RMM_SEARCH_LIB_PATH
  ${RMM_ROOT}/lib
  ${RMM_ROOT}/lib/x86_64-linux-gnu
  ${RMM_ROOT}/lib64
  ${RMM_ROOT}/build
)

set(RMM_SEARCH_INCLUDE_DIR
  ${RMM_ROOT}/include/
)

find_path(RMM_INCLUDE_DIR rmm.h
    PATHS ${RMM_SEARCH_INCLUDE_DIR}/rmm
    NO_DEFAULT_PATH
    DOC "Path to librmm headers"
)

#find_library(RMM_LIBS NAMES rmm
#    PATHS ${RMM_SEARCH_LIB_PATH}
#    NO_DEFAULT_PATH
#    DOC "Path to librmm library"
#)

#TODO percy change to librmm.a once rmm supports static build
find_library(RMM_STATIC_LIB NAMES librmm.so
    PATHS ${RMM_SEARCH_LIB_PATH}
    NO_DEFAULT_PATH
    DOC "Path to librmm static library"
)

if (NOT RMM_STATIC_LIB)
    message(FATAL_ERROR "librmm includes and libraries NOT found. "
      "Looked for headers in ${RMM_SEARCH_INCLUDE_DIR}, "
      "and for libs in ${RMM_SEARCH_LIB_PATH}")
    set(RMM_FOUND FALSE)
else()
    set(RMM_INCLUDEDIR ${RMM_ROOT}/include/)
    set(RMM_LIBDIR ${RMM_ROOT}/lib) # TODO percy make this part cross platform
    set(RMM_FOUND TRUE)
    #TODO percy change to STATIC once rmm supports static build
    add_library(rmm SHARED IMPORTED)
    set_target_properties(rmm PROPERTIES IMPORTED_LOCATION "${RMM_STATIC_LIB}")
endif ()

mark_as_advanced(
  RMM_FOUND
  RMM_INCLUDEDIR
  RMM_INCLUDE_DIR
  RMM_LIBS
  RMM_STATIC_LIB
  rmm
)
