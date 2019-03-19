#=============================================================================
# Copyright 2019 BlazingDB, Inc.
#     Copyright 2019 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

# - Find BlazingDB communication C++ library libblazingdb-communication (libblazingdb-communication.a)
# BLAZINGDB_COMMUNICATION_ROOT hints the location
#
# This module defines
# BLAZINGDB_COMMUNICATION_FOUND
# BLAZINGDB_COMMUNICATION_INCLUDEDIR Preferred include directory e.g. <prefix>/include
# BLAZINGDB_COMMUNICATION_INCLUDE_DIR, directory containing blazingdb-communication headers
# BLAZINGDB_COMMUNICATION_LIBS, blazingdb-communication libraries
# BLAZINGDB_COMMUNICATION_LIBDIR, directory containing blazingdb-communication libraries
# BLAZINGDB_COMMUNICATION_STATIC_LIB, path to blazingdb-communication.a
# blazingdb-communication - static library

# If BLAZINGDB_COMMUNICATION_ROOT is not defined try to search in the default system path
if ("${BLAZINGDB_COMMUNICATION_ROOT}" STREQUAL "")
    set(BLAZINGDB_COMMUNICATION_ROOT "/usr")
endif()

set(BLAZINGDB_COMMUNICATION_SEARCH_LIB_PATH
  ${BLAZINGDB_COMMUNICATION_ROOT}/lib
  ${BLAZINGDB_COMMUNICATION_ROOT}/lib/x86_64-linux-gnu
  ${BLAZINGDB_COMMUNICATION_ROOT}/lib64
  ${BLAZINGDB_COMMUNICATION_ROOT}/build
)

set(BLAZINGDB_COMMUNICATION_SEARCH_INCLUDE_DIR
  ${BLAZINGDB_COMMUNICATION_ROOT}/include/blazingdb/communication/
)

find_path(BLAZINGDB_COMMUNICATION_INCLUDE_DIR api.h
    PATHS ${BLAZINGDB_COMMUNICATION_SEARCH_INCLUDE_DIR}
    NO_DEFAULT_PATH
    DOC "Path to blazingdb-communication headers"
)

#find_library(BLAZINGDB_COMMUNICATION_LIBS NAMES blazingdb-communication
#    PATHS ${BLAZINGDB_COMMUNICATION_SEARCH_LIB_PATH}
#    NO_DEFAULT_PATH
#    DOC "Path to blazingdb-communication library"
#)

find_library(BLAZINGDB_COMMUNICATION_STATIC_LIB NAMES libblazingdb-communication.a
    PATHS ${BLAZINGDB_COMMUNICATION_SEARCH_LIB_PATH}
    NO_DEFAULT_PATH
    DOC "Path to blazingdb-communication static library"
)

if (NOT BLAZINGDB_COMMUNICATION_STATIC_LIB)
    message(FATAL_ERROR "blazingdb-communication includes and libraries NOT found. "
      "Looked for headers in ${BLAZINGDB_COMMUNICATION_SEARCH_INCLUDE_DIR}, "
      "and for libs in ${BLAZINGDB_COMMUNICATION_SEARCH_LIB_PATH}")
    set(BLAZINGDB_COMMUNICATION_FOUND FALSE)
else()
    set(BLAZINGDB_COMMUNICATION_INCLUDEDIR ${BLAZINGDB_COMMUNICATION_ROOT}/include/)
    set(BLAZINGDB_COMMUNICATION_LIBDIR ${BLAZINGDB_COMMUNICATION_ROOT}/build) # TODO percy make this part cross platform
    set(BLAZINGDB_COMMUNICATION_FOUND TRUE)
    add_library(blazingdb-communication STATIC IMPORTED)
    set_target_properties(blazingdb-communication PROPERTIES IMPORTED_LOCATION "${BLAZINGDB_COMMUNICATION_STATIC_LIB}")
endif ()

mark_as_advanced(
  BLAZINGDB_COMMUNICATION_FOUND
  BLAZINGDB_COMMUNICATION_INCLUDEDIR
  BLAZINGDB_COMMUNICATION_INCLUDE_DIR
  #BLAZINGDB_COMMUNICATION_LIBS
  BLAZINGDB_COMMUNICATION_STATIC_LIB
  blazingdb-communication
)
