cmake_minimum_required (VERSION 3.0)
set (CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)

set (PROJECT_NAME IOPROBING)
project (${PROJECT_NAME})

set (VERSION_MAJOR 0)
set (VERSION_MINOR 1)

set(DEV_DIR "${CMAKE_SOURCE_DIR}/dev")
set(DOC_DIR "${CMAKE_SOURCE_DIR}/doc")
set(DEPS_DIR "${CMAKE_SOURCE_DIR}/deps")
set(PLUGIN_DIR "${CMAKE_SOURCE_DIR}/plugins")

include(CTest)
include(FeatureSummary)
include(CheckCSourceCompiles)
include(FindPackageHandleStandardArgs)

SET(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
SET(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)

#### Search for dependencies
# set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} /usr/lib64 /usr/local/lib64 /usr/local/lib)

find_package(PkgConfig REQUIRED)
find_package(MPI REQUIRED)

set(CONFIGURE_MINIMAL "FALSE" CACHE BOOL "disable automatic checks for plugin dependencies")

# message(WARNING ${CONFIGURE_MINIMAL})



set (MDWB_C_SOURCE_DIR "${MDWB_DIR}/src")
include_directories("${CMAKE_SOURCE_DIR}/src" "${CMAKE_SOURCE_DIR}" "${MDWB_C_SOURCE_DIR}" "${MDWB_DIR}")


# compile flags
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu99 -pedantic -Wall -Wextra -pedantic-errors -Wno-unused-parameter -Werror")
set (CMAKE_C_FLAGS_DEBUG   "-O0 -g3")
set (CMAKE_C_FLAGS_RELEASE "-O3")


# identify which plugins are compilable
set (PLUGIN_DIR "${MDWB_DIR}/plugins")
set(PLUGINS "${PLUGIN_DIR}/md-dummy.c" "${PLUGIN_DIR}/md-posix.c" "${PLUGIN_DIR}/md-mpi.c")
add_definitions("-DMD_PLUGIN_MPIIO")

## GIT VERSIONs:
#execute_process(COMMAND git rev-parse --abbrev-ref HEAD
  #WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} OUTPUT_VARIABLE GIT_BRANCH OUTPUT_STRIP_TRAILING_WHITESPACE)

#execute_process(COMMAND git log -1 --format=%h
  #WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}  OUTPUT_VARIABLE GIT_COMMIT_HASH  OUTPUT_STRIP_TRAILING_WHITESPACE )

#set(PLUGINS ${PLUGINS} CACHE FILEPATH "enabled plugins")

SUBDIRS (src)

#feature_summary(WHAT ALL)
