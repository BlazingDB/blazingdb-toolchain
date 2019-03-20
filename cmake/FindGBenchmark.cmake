#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# - Find GPU Open Analytics Initiative (GoAi) libgdf (libgdf.a)
# GBENCHMARK_ROOT hints the location
#
# This module defines
# GBENCHMARK_FOUND
# GBENCHMARK_INCLUDEDIR Preferred include directory e.g. <prefix>/include
# GBENCHMARK_INCLUDE_DIR, directory containing libgdf headers
# GBENCHMARK_LIBS, libgdf libraries
# GBENCHMARK_LIBDIR, directory containing libgdf libraries
# GBENCHMARK_STATIC_LIB, path to libgdf.a
# gdf - static library
#TODO percy find librmm.so/.a ...

# If GBENCHMARK_ROOT is not defined try to search in the default system path
if ("${GBENCHMARK_ROOT}" STREQUAL "")
    set(GBENCHMARK_ROOT "/usr")
endif()

set(GBENCHMARK_SEARCH_LIB_PATH
  ${GBENCHMARK_ROOT}/lib
  ${GBENCHMARK_ROOT}/lib/x86_64-linux-gnu
  ${GBENCHMARK_ROOT}/lib64
  ${GBENCHMARK_ROOT}/build
)

set(GBENCHMARK_SEARCH_INCLUDE_DIR
  ${GBENCHMARK_ROOT}/include/
)

find_path(GBENCHMARK_INCLUDE_DIR benchmark.h
    PATHS ${GBENCHMARK_SEARCH_INCLUDE_DIR}/benchmark
    NO_DEFAULT_PATH
    DOC "Path to GBENCHMARK headers"
)

find_library(GBENCHMARK_STATIC_LIB NAMES libbenchmark.a
    PATHS ${GBENCHMARK_SEARCH_LIB_PATH}
    NO_DEFAULT_PATH
    DOC "Path to libgdf static library"
)

if (NOT GBENCHMARK_STATIC_LIB)
    message(FATAL_ERROR "libgdf includes and libraries NOT found. "
      "Looked for headers in ${GBENCHMARK_SEARCH_INCLUDE_DIR}, "
      "and for libs in ${GBENCHMARK_SEARCH_LIB_PATH}")
    set(GBENCHMARK_FOUND FALSE)
else()
    set(GBENCHMARK_INCLUDEDIR ${GBENCHMARK_ROOT}/include/)
    set(GBENCHMARK_LIBDIR ${GBENCHMARK_ROOT}/lib) # TODO percy make this part cross platform
    set(GBENCHMARK_FOUND TRUE)
endif ()

mark_as_advanced(
  GBENCHMARK_FOUND
  GBENCHMARK_INCLUDEDIR
  GBENCHMARK_INCLUDE_DIR
  GBENCHMARK_LIBS
  GBENCHMARK_STATIC_LIB
)
