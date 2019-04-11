#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# - Find BlazingDB protocol C++ library libblazingdb-io (libblazingdb-io.a)
# JITIFY_ROOT hints the location
#
# This module defines
# JITIFY_FOUND
# JITIFY_INCLUDEDIR Preferred include directory e.g. <prefix>/include
# JITIFY_INCLUDE_DIR, directory containing blazingdb-io headers
# JITIFY_LIBS, blazingdb-io libraries
# JITIFY_LIBDIR, directory containing blazingdb-io libraries
# JITIFY_STATIC_LIB, path to blazingdb-io.a
# blazingdb-io - static library

# If JITIFY_ROOT is not defined try to search in the default system path
if ("${JITIFY_ROOT}" STREQUAL "")
    set(JITIFY_ROOT "/usr")
endif()

set(JITIFY_SEARCH_LIB_PATH
  ${JITIFY_ROOT}/lib
  ${JITIFY_ROOT}/lib/x86_64-linux-gnu
  ${JITIFY_ROOT}/lib64
  ${JITIFY_ROOT}/build
)

set(JITIFY_SEARCH_INCLUDE_DIR
  ${JITIFY_ROOT}
)

find_path(JITIFY_INCLUDE_DIR jitify.hpp
    PATHS ${JITIFY_SEARCH_INCLUDE_DIR}
    NO_DEFAULT_PATH
    DOC "Path to jitify headers"
)

if (NOT JITIFY_INCLUDE_DIR)
    message(FATAL_ERROR "jitify includes NOT found. "
      "Looked for headers in ${JITIFY_SEARCH_INCLUDE_DIR}")
    set(JITIFY_FOUND FALSE)
else()
    set(JITIFY_INCLUDE_DIR ${JITIFY_ROOT}/)
    set(JITIFY_INCLUDEDIR ${JITIFY_ROOT}/)
    set(JITIFY_LIBDIR ${JITIFY_ROOT}/build) # TODO percy make this part cross platform
    set(JITIFY_FOUND TRUE)
    #add_library(blazingdb-io STATIC IMPORTED)
    #set_target_properties(blazingdb-io PROPERTIES IMPORTED_LOCATION "${JITIFY_STATIC_LIB}")
endif ()

mark_as_advanced(
  JITIFY_FOUND
  JITIFY_INCLUDEDIR
  JITIFY_INCLUDE_DIR
  #JITIFY_LIBS
  JITIFY_STATIC_LIB
  #blazingdb-io
)
