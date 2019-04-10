#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# - Find BlazingDB protocol C++ library libblazingdb-io (libblazingdb-io.a)
# RAPIDJSON_ROOT hints the location
#
# This module defines
# RAPIDJSON_FOUND
# RAPIDJSON_INCLUDEDIR Preferred include directory e.g. <prefix>/include
# RAPIDJSON_INCLUDE_DIR, directory containing blazingdb-io headers
# RAPIDJSON_LIBS, blazingdb-io libraries
# RAPIDJSON_LIBDIR, directory containing blazingdb-io libraries
# RAPIDJSON_STATIC_LIB, path to blazingdb-io.a
# blazingdb-io - static library

# If RAPIDJSON_ROOT is not defined try to search in the default system path
if ("${RAPIDJSON_ROOT}" STREQUAL "")
    set(RAPIDJSON_ROOT "/usr")
endif()

set(RAPIDJSON_SEARCH_LIB_PATH
  ${RAPIDJSON_ROOT}/lib
  ${RAPIDJSON_ROOT}/lib/x86_64-linux-gnu
  ${RAPIDJSON_ROOT}/lib64
  ${RAPIDJSON_ROOT}/build
)

set(RAPIDJSON_SEARCH_INCLUDE_DIR
  ${RAPIDJSON_ROOT}/include/rapidjson/
)

find_path(RAPIDJSON_INCLUDE_DIR rapidjson.h
    PATHS ${RAPIDJSON_SEARCH_INCLUDE_DIR}
    NO_DEFAULT_PATH
    DOC "Path to rapidjson headers"
)

if (NOT RAPIDJSON_INCLUDE_DIR)
    message(FATAL_ERROR "blazingdb-io includes and libraries NOT found. "
      "Looked for headers in ${RAPIDJSON_SEARCH_INCLUDE_DIR}")
    set(RAPIDJSON_FOUND FALSE)
else()
    set(RAPIDJSON_INCLUDE_DIR ${RAPIDJSON_ROOT}/include/)
    set(RAPIDJSON_INCLUDEDIR ${RAPIDJSON_ROOT}/include/)
    set(RAPIDJSON_LIBDIR ${RAPIDJSON_ROOT}/build) # TODO percy make this part cross platform
    set(RAPIDJSON_FOUND TRUE)
    #add_library(blazingdb-io STATIC IMPORTED)
    #set_target_properties(blazingdb-io PROPERTIES IMPORTED_LOCATION "${RAPIDJSON_STATIC_LIB}")
endif ()

mark_as_advanced(
  RAPIDJSON_FOUND
  RAPIDJSON_INCLUDEDIR
  RAPIDJSON_INCLUDE_DIR
  #RAPIDJSON_LIBS
  RAPIDJSON_STATIC_LIB
  #blazingdb-io
)
