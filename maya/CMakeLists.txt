set(MAYA_SOURCES
  config_maya.cxx
  maya_funcs.cxx
  mayaApi.cxx
  mayaShader.cxx
  mayaShaderColorDef.cxx
  mayaShaders.cxx
)

set(MAYA_HEADERS
  config_maya.h
  maya_funcs.h maya_funcs.I maya_funcs.T
  mayaApi.h
  mayaShader.h
  mayaShaderColorDef.h
  mayaShaders.h
  post_maya_include.h
  pre_maya_include.h
)

add_library(maya${MAYA_VERSION} ${MAYA_HEADERS} ${MAYA_SOURCES})
target_include_directories(maya${MAYA_VERSION} INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(maya${MAYA_VERSION} PUBLIC p3pandatoolbase panda ${MAYA_LIBRARIES})
