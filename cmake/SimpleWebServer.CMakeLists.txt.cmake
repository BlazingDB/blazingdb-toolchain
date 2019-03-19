#=============================================================================
# Copyright 2018 BlazingDB, Inc.
#     Copyright 2018 Percy Camilo Triveño Aucahuasi <percy@blazingdb.com>
#=============================================================================

cmake_minimum_required(VERSION 2.8.12)

cmake_policy(SET CMP0048 NEW)

project(simplewebserver-download NONE)

include(ExternalProject)

# NOTE the commit 3f8fcc0c311e8d7d2a13aa34253778bc8021ac14 is the stable release v2.1.1
ExternalProject_Add(simplewebserver
    GIT_REPOSITORY  https://gitlab.com/eidheim/Simple-Web-Server.git
    GIT_TAG         3f8fcc0c311e8d7d2a13aa34253778bc8021ac14
    SOURCE_DIR      "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/simplewebserver-src"
    BINARY_DIR      "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/simplewebserver-build"
    INSTALL_DIR     "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/simplewebserver-install"
    UPDATE_COMMAND  ""
    CMAKE_ARGS      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/thirdparty/simplewebserver-install
                    ${SIMPLEWEBSERVER_CMAKE_ARGS}
)
