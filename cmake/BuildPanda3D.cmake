include(ExternalProject)

# Build Panda3D from source
ExternalProject_Add(
  panda3d

  GIT_REPOSITORY https://github.com/panda3d/panda3d
  GIT_TAG 712300c9f1095a50e8719e8866c6f161aeba974b

  INSTALL_DIR ${PROJECT_BINARY_DIR}/panda3d

  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    -DCMAKE_OSX_ARCHITECTURES=x86_64
    -DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}

    -DBUILD_INTERROGATE=OFF
    -DBUILD_DIRECT=OFF
    -DBUILD_CONTRIB=OFF
    -DBUILD_MODELS=OFF
    -DBUILD_SHARED_LIBS=OFF
    -DBUILD_TOOLS=OFF
    -DINTERROGATE_PYTHON_INTERFACE=OFF
    -DINTERROGATE_C_INTERFACE=OFF
    -DINTERROGATE_EXECUTABLE=nonexistent
    -DINTERROGATE_MODULE_EXECUTABLE=nonexistent
    -DLINMATH_ALIGN=ON
    -DDO_PIPELINING=OFF
    -DDO_PSTATS=OFF

    -DHAVE_ARTOOLKIT=OFF
    -DHAVE_ASSIMP=OFF
    -DHAVE_AUDIO=OFF
    -DHAVE_BULLET=OFF
    -DHAVE_CG=OFF
    -DHAVE_COCOA=OFF
    -DHAVE_DX9=OFF
    -DHAVE_EGG=ON
    -DHAVE_EGL=OFF
    -DHAVE_FCOLLADA=OFF
    -DHAVE_FFMPEG=OFF
    -DHAVE_FMODEX=OFF
    -DHAVE_FREETYPE=OFF
    -DHAVE_GL=OFF
    -DHAVE_GLES1=OFF
    -DHAVE_GLES2=OFF
    -DHAVE_GLX=OFF
    -DHAVE_GTK3=OFF
    -DHAVE_HARFBUZZ=OFF
    -DHAVE_JPEG=OFF
    -DHAVE_NET=ON
    -DHAVE_ODE=OFF
    -DHAVE_OPENAL=OFF
    -DHAVE_OPENCV=OFF
    -DHAVE_OPENEXR=OFF
    -DHAVE_OPENSSL=OFF
    -DHAVE_OPUS=OFF
    -DHAVE_PNG=OFF
    -DHAVE_PYTHON=OFF
    -DHAVE_SDL=OFF
    -DHAVE_SPEEDTREE=OFF
    -DHAVE_SWRESAMPLE=OFF
    -DHAVE_THREADS=OFF
    -DHAVE_TIFF=OFF
    -DHAVE_TINYDISPLAY=OFF
    -DHAVE_VORBIS=OFF
    -DHAVE_VRPN=OFF
    -DHAVE_WGL=OFF
    -DHAVE_X11=OFF
    -DHAVE_ZLIB=${ZLIB_FOUND}

  BUILD_BYPRODUCTS
    ${PROJECT_BINARY_DIR}/panda3d/lib/libp3eggbase${CMAKE_STATIC_LIBRARY_SUFFIX}
    ${PROJECT_BINARY_DIR}/panda3d/lib/libp3progbase${CMAKE_STATIC_LIBRARY_SUFFIX}
    ${PROJECT_BINARY_DIR}/panda3d/lib/libp3converter${CMAKE_STATIC_LIBRARY_SUFFIX}
    ${PROJECT_BINARY_DIR}/panda3d/lib/libp3pandatoolbase${CMAKE_STATIC_LIBRARY_SUFFIX}
    ${PROJECT_BINARY_DIR}/panda3d/lib/libpandaegg${CMAKE_STATIC_LIBRARY_SUFFIX}
    ${PROJECT_BINARY_DIR}/panda3d/lib/libpanda${CMAKE_STATIC_LIBRARY_SUFFIX}
    ${PROJECT_BINARY_DIR}/panda3d/lib/libpandaexpress${CMAKE_STATIC_LIBRARY_SUFFIX}
    ${PROJECT_BINARY_DIR}/panda3d/lib/libp3dtool${CMAKE_STATIC_LIBRARY_SUFFIX}
    ${PROJECT_BINARY_DIR}/panda3d/lib/libp3prc${CMAKE_STATIC_LIBRARY_SUFFIX}
    ${PROJECT_BINARY_DIR}/panda3d/lib/libp3framework${CMAKE_STATIC_LIBRARY_SUFFIX}
)

file(MAKE_DIRECTORY "${PROJECT_BINARY_DIR}/panda3d/include/panda3d")

foreach(lib p3eggbase p3progbase p3converter p3pandatoolbase pandaegg panda pandaexpress p3dtool p3prc p3framework)
  add_library(${lib} STATIC IMPORTED GLOBAL)
  if(CMAKE_CXX_COMPILER_ID MATCHES "^(GNU|Clang)$")
    target_link_options(${lib} INTERFACE "LINKER:--exclude-libs,lib${lib}${CMAKE_STATIC_LIBRARY_SUFFIX}")
  endif()
  set_target_properties(${lib} PROPERTIES IMPORTED_LOCATION "${PROJECT_BINARY_DIR}/panda3d/lib/lib${lib}${CMAKE_STATIC_LIBRARY_SUFFIX}")
  if(WIN32)
    set_target_properties(${lib} PROPERTIES IMPORTED_LOCATION_DEBUG "${PROJECT_BINARY_DIR}/panda3d/lib/lib${lib}_d${CMAKE_STATIC_LIBRARY_SUFFIX}")
  endif()
  add_dependencies(${lib} panda3d)
endforeach()

set(pandaexpress_libs "p3dtool;p3prc")
if(ZLIB_FOUND)
  set(pandaexpress_libs "${pandaexpress_libs};${ZLIB_LIBRARY}")
endif()
if(WIN32)
  set(pandaexpress_libs "${pandaexpress_libs};ws2_32.lib")
endif()

set_target_properties(panda PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${PROJECT_BINARY_DIR}/panda3d/include/panda3d")
set_target_properties(panda PROPERTIES INTERFACE_LINK_LIBRARIES "pandaexpress")
set_target_properties(pandaexpress PROPERTIES INTERFACE_LINK_LIBRARIES "${pandaexpress_libs}")
set_target_properties(p3pandatoolbase PROPERTIES INTERFACE_LINK_LIBRARIES "panda")
set_target_properties(p3progbase PROPERTIES INTERFACE_LINK_LIBRARIES "p3pandatoolbase")
set_target_properties(p3framework PROPERTIES INTERFACE_LINK_LIBRARIES "panda")
set_target_properties(pandaegg PROPERTIES INTERFACE_LINK_LIBRARIES "panda")

if(APPLE)
  set_target_properties(p3dtool PROPERTIES INTERFACE_LINK_LIBRARIES "-framework Foundation;-framework AppKit")
  set_target_properties(panda PROPERTIES INTERFACE_LINK_LIBRARIES "pandaexpress;-framework IOKit")
endif()
