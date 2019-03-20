#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# - Find GPU Open Analytics Initiative (GoAi) libnvstrings (libnvstrings.a)
# NVSTRINGS_ROOT hints the location
#
# This module defines
# NVSTRINGS_FOUND
# NVSTRINGS_INCLUDEDIR Preferred include directory e.g. <prefix>/include
# NVSTRINGS_INCLUDE_DIR, directory containing libnvstrings headers
# NVSTRINGS_LIBS, libnvstrings libraries
# NVSTRINGS_LIBDIR, directory containing libnvstrings libraries
# NVSTRINGS_STATIC_LIB, path to libnvstrings.a
# nvstrings - static library
#TODO percy find librmm.so/.a ...

# If NVSTRINGS_ROOT is not defined try to search in the default system path
if ("${NVSTRINGS_ROOT}" STREQUAL "")
    set(NVSTRINGS_ROOT "/usr")
endif()

set(NVSTRINGS_SEARCH_LIB_PATH
  ${NVSTRINGS_ROOT}/lib
  ${NVSTRINGS_ROOT}/lib/x86_64-linux-gnu
  ${NVSTRINGS_ROOT}/lib64
  ${NVSTRINGS_ROOT}/build
)

set(NVSTRINGS_SEARCH_INCLUDE_DIR
  ${NVSTRINGS_ROOT}/include/
)

find_path(NVSTRINGS_INCLUDE_DIR NVStrings.h
    PATHS ${NVSTRINGS_SEARCH_INCLUDE_DIR}/nvstrings
    NO_DEFAULT_PATH
    DOC "Path to libnvstrings headers"
)

#find_library(NVSTRINGS_LIBS NAMES nvstrings
#    PATHS ${NVSTRINGS_SEARCH_LIB_PATH}
#    NO_DEFAULT_PATH
#    DOC "Path to libnvstrings library"
#)

#TODO percy change to libnvstrings.a once nvstrings supports static build
find_library(NVSTRINGS_STATIC_LIB NAMES libNVStrings.so
    PATHS ${NVSTRINGS_SEARCH_LIB_PATH}
    NO_DEFAULT_PATH
    DOC "Path to libnvstrings static library"
)

if (NOT NVSTRINGS_STATIC_LIB)
    message(FATAL_ERROR "libnvstrings includes and libraries NOT found. "
      "Looked for headers in ${NVSTRINGS_SEARCH_INCLUDE_DIR}, "
      "and for libs in ${NVSTRINGS_SEARCH_LIB_PATH}")
    set(NVSTRINGS_FOUND FALSE)
else()
    set(NVSTRINGS_INCLUDEDIR ${NVSTRINGS_ROOT}/include/)
    set(NVSTRINGS_LIBDIR ${NVSTRINGS_ROOT}/lib) # TODO percy make this part cross platform
    set(NVSTRINGS_FOUND TRUE)
    #TODO percy change to STATIC once nvstrings supports static build
    add_library(nvstrings SHARED IMPORTED)
    set_target_properties(nvstrings PROPERTIES IMPORTED_LOCATION "${NVSTRINGS_STATIC_LIB}")
endif ()

mark_as_advanced(
  NVSTRINGS_FOUND
  NVSTRINGS_INCLUDEDIR
  NVSTRINGS_INCLUDE_DIR
  NVSTRINGS_LIBS
  NVSTRINGS_STATIC_LIB
  nvstrings
)
