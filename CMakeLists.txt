cmake_minimum_required(VERSION 3.14)

project(maya-egg)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")

if(APPLE)
  set(CMAKE_OSX_ARCHITECTURES "x86_64")
  set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9")
endif()

# Locate ZLib before we build Panda3D
find_package(ZLIB)

include(cmake/BuildPanda3D.cmake)

# Locate Maya
set(MAYA_VERSION 2022 CACHE STRING "Maya version")

find_package(Maya ${MAYA_VERSION} REQUIRED)

# Set global flags
include_directories(${MAYA_INCLUDE_DIRS})
if(MSVC)
  add_compile_options("/GR-")
else()
  add_compile_options("-fno-rtti")
endif()

add_subdirectory(maya)
add_subdirectory(mayaegg)
add_subdirectory(mayaprogs)
